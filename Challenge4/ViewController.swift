import UIKit
import GameplayKit

class ViewController: UIViewController {
    
    @IBOutlet var gameWordLabel: UILabel!
    @IBOutlet var livesLabel: UILabel!
    
    var allWords = [String]()
    var questionMarks = ""
    var livesRemaining = 7
    
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
        let gameWord = allWords[0]
        print("Gameword: \(gameWord)")
        let lettersArray = Array(gameWord) //This breaks-down 'gameWord' into an array of characters
        
        for _ in lettersArray {
            questionMarks += "?"
        }
        let questionMarksArray = Array(questionMarks) //This breaks-down 'questionMarks' into an array of question marks
        let startingGameWordLabel = String(questionMarksArray)
        
        gameWordLabel.text = startingGameWordLabel
        livesLabel.text = "\(livesRemaining)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

