//
//  ViewController.swift
//  Passly
//
//  Created by Noah Evans on 02/07/2020.
//

import UIKit



class ViewController: UIViewController{

    @IBOutlet weak var genButtonOutlet: UIButton!

   
    @IBOutlet weak var slider: UISlider!
    
    var passwordLength: Int = 0
    
    
    
 
    
  
    func getPassword (length: Int) -> String {
        let allowedChars = #"""
        abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
        """#
        let allowedCharsCount = UInt32(allowedChars.count)
        var randomString = ""

        for _ in 0..<length {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }

        return randomString
    }
    

    var checkView = SuccessCheck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
     //   checkView = SuccessCheck(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
        
        // Add to the parent view
        self.view.addSubview(checkView)

        self.genButtonOutlet.applyGradient(colors: [UIColor(named: "purple1")!, UIColor(named: "purple2")!])
        self.genButtonOutlet.layer.cornerCurve = .continuous
        self.genButtonOutlet.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    @IBAction func generateButton(_ sender: Any) {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 1.0)
        let sliderLength: Int = Int(slider.value)
        let password = getPassword(length: sliderLength)
        let pasteboard = UIPasteboard.general
        pasteboard.string = password
        
        // Animate the tick process
      //  checkView.initWithTime(withDuration: 2, bgCcolor: .green, colorOfStroke: .white, widthOfTick: 10) {
            //do additional work after completion
        
    }
    
    @IBAction func sliderChanged(_ sender: Any) {
        if 1...50 ~= slider.value {
            UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 0.2)
        }
        if 51...100 ~= slider.value {
            UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 0.3)
        }
        if 101...150 ~= slider.value {
            UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 0.4)
        }
        if 151...200 ~= slider.value {
            UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 0.5)
        }
        if 201...256 ~= slider.value {
            UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 0.6)
        }
        
        
    }
    
    @IBAction func customLength(_ sender: Any) {
        
        let ac = UIAlertController(title: "Custom Length", message: "If you're generating a very large password, the app may freeze for a second.", preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Generate", style: .default) { [self, unowned ac] _ in
            
            let answer = ac.textFields![0]
            answer.keyboardType = .decimalPad

            passwordLength = (answer.text! as NSString).integerValue
            

            
            if passwordLength > 3000000 {
                let tooBigAlert = UIAlertController(title: "Woah there!", message: "You can't generate passwords with more than 3,000,000 characters using Passly.", preferredStyle: .alert)
                let tooBigOkay = UIAlertAction(title: "Okay!", style: .default, handler: nil)
                
                tooBigAlert.addAction(tooBigOkay)
                present(tooBigAlert, animated: true, completion: nil)
            }
            else {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 1.0)
                let password = getPassword(length: passwordLength)
                let pasteboard = UIPasteboard.general
                pasteboard.string = password

                
            }
            

        }

        ac.addAction(submitAction)

        present(ac, animated: true) {

            UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 0.7)
        }

    }
}



extension UIView {
    @discardableResult
    func applyGradient(colors: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colors: colors, locations: nil)
    }
    
    @discardableResult
    func applyGradient(colors: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}

