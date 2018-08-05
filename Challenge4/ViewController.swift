import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var gameWord: UILabel!
    @IBOutlet var lives: UILabel!
    @IBOutlet var usedLetters: UILabel!
    
    @IBOutlet var chosenLetter: UITextField!
    @IBAction func submitButton(_ sender: Any) {
        
    }
    
    var allWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let wordsPath = Bundle.main.path(forResource: "words", ofType: "txt") {
            if let words = try? String(contentsOfFile: wordsPath) {
                allWords = words.components(separatedBy: "\n")
            } else {
                allWords = ["banker"]
            }
        }
        
        print(allWords)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

