//
//  ViewController.swift
//  Passly
//
//  Created by Noah Evans on 02/07/2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var genButtonOutlet: UIButton!
    @IBOutlet weak var labelOutlet: UILabel!
    @IBOutlet weak var animateView: UIView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelOutlet.isHidden = true
        self.genButtonOutlet.applyGradient(colors: [UIColor(named: "purple1")!, UIColor(named: "purple2")!])
        self.genButtonOutlet.layer.cornerCurve = .continuous
        self.genButtonOutlet.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    @IBAction func generateButton(_ sender: Any) {
        let password = getPassword(length: 150)
        let pasteboard = UIPasteboard.general
        pasteboard.string = password
        labelOutlet.isHidden = false
        
        
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

