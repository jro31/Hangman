import UIKit
import GameplayKit

class ViewController: UIViewController {
    
    @IBOutlet var gameWordLabel: UILabel!
    @IBOutlet var livesLabel: UILabel!
    
    var chosenLetterString = ""
    var chosenLetterCharacter = Array<Character>()
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        chosenLetterString = sender.titleLabel!.text!
        chosenLetterCharacter = Array(chosenLetterString)
        print("Chosen letter character: \(chosenLetterCharacter)")
        
        playingGame()
    }
    
    var allWords = [String]()
    var questionMarks = ""
    var livesRemaining = 10
    var gameWord = ""
    var lettersArray = Array<Character>()
    var startingGameWordLabel = ""
    var questionMarksArray = Array<Character>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let wordsPath = Bundle.main.path(forResource: "words", ofType: "txt") {
            if let words = try? String(contentsOfFile: wordsPath) {
                allWords = words.components(separatedBy: "\n")
            } else {
                allWords = ["banker"]
            }
        }
        
        startGame()
        
    }
    
    func startGame() {
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
        livesLabel.text = "\(livesRemaining)"
    }
    
    func playingGame() {
        
        var updatedGameWord: [Character]
        var updatedGameWordText: String
        
        for letters in lettersArray {
            if letters == chosenLetterCharacter[0] {
                let correctLetterPosition = lettersArray.index(of: chosenLetterCharacter[0])!
                
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

