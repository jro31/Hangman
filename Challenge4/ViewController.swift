import UIKit
import GameplayKit

class ViewController: UIViewController {
    
    @IBOutlet var gameWordLabel: UILabel!
    @IBOutlet var livesLabel: UILabel!
    
    @IBOutlet var allButtons: [UIButton]!
    
    var chosenLetterString = ""
    var chosenLetterCharacter = Array<Character>()
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        
        chosenLetterString = sender.titleLabel!.text!
        chosenLetterCharacter = Array(chosenLetterString)
        print("Chosen letter character: \(chosenLetterCharacter)")
        
        playingGame()
        
        if !gameWord.contains(chosenLetterString) {
            livesRemaining -= 1
            livesLabel.text = "\(livesRemaining)"
            
            if livesRemaining < 4 {
                livesLabel.textColor = UIColor.red
            }
        }
        
        sender.isEnabled = false // Disables the button once pressed
        sender.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3) // Fades the appearance of the button once pressed
        
        if !gameWordLabel.text!.contains("?") {
            let alert = UIAlertController(title: "Congratulations!", message: "You did it", preferredStyle: .alert)
            let playAgainButton = UIAlertAction(title: "Play again", style: .default) {
                (action:UIAlertAction!) in
                
                self.startGame()
            }
            alert.addAction(playAgainButton)
            present(alert, animated: true)
        }
        
        if livesRemaining == 0 {
            let alert = UIAlertController(title: gameWord, message: "Better luck next time!", preferredStyle: .alert)
            let playAgainButton = UIAlertAction(title: "Play again", style: .default) {
                (action:UIAlertAction!) in
                
                self.startGame()
            }
            alert.addAction(playAgainButton)
            present(alert, animated: true)
        }
    }
    
    var allWords = [String]()
    var livesRemaining = 10
    var gameWord = ""
    var lettersArray = Array<Character>()
    var startingGameWordLabel = ""
    var questionMarksArray = Array<Character>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startGame()
    }
    
    func startGame() {
        for buttons in allButtons {
            buttons.isEnabled = true
            buttons.backgroundColor = UIColor.lightGray.withAlphaComponent(1)
        }
        
        if let wordsPath = Bundle.main.path(forResource: "words", ofType: "txt") {
            if let words = try? String(contentsOfFile: wordsPath) {
                allWords = words.components(separatedBy: "\n")
            } else {
                allWords = ["banker"]
            }
        }
        
        var questionMarks = ""
        
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as! [String]
        gameWord = allWords[0].uppercased()
        print("Gameword: \(gameWord)")
        lettersArray = Array(gameWord) //This breaks-down 'gameWord' into an array of characters
        print("Letters array: \(lettersArray)")
        
        for _ in lettersArray {
            questionMarks += "?"
        }
        questionMarksArray = Array(questionMarks) //This breaks-down 'questionMarks' into an array of question marks
        startingGameWordLabel = String(questionMarksArray)
        
        gameWordLabel.text = startingGameWordLabel
        
        livesRemaining = 10
        livesLabel.text = "\(livesRemaining)"
        livesLabel.textColor = UIColor.black
    }
    
    func playingGame() {
        
        var updatedGameWord: [Character]
        var updatedGameWordText: String
        
        for letters in lettersArray {
            if letters == chosenLetterCharacter[0] {
                let correctLetterPosition = lettersArray.index(of: chosenLetterCharacter[0])!
                
                lettersArray[correctLetterPosition] = "0" // This changes any already-selected letters to be '0', so that for any subsequent loops, they will not get selected again. This is because some words contain the same letter multiple times.
                
                if gameWordLabel.text == startingGameWordLabel {
                    updatedGameWord = questionMarksArray
                    updatedGameWord[correctLetterPosition] = chosenLetterCharacter[0]
                    updatedGameWordText = String(updatedGameWord)
                    gameWordLabel.text = updatedGameWordText
                } else {
                    var veryUpdatedGameWord = Array(gameWordLabel.text!)
                    veryUpdatedGameWord[correctLetterPosition] = chosenLetterCharacter[0]
                    let veryUpdatedGameWordText = String(veryUpdatedGameWord)
                    gameWordLabel.text = veryUpdatedGameWordText
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

