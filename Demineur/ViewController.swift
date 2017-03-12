//
//  ViewController.swift
//  Demineur
//
//  Created by alexandre pouget on 09/03/2017.
//  Copyright © 2017 alexandre pouget. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func startPlay(_ sender: UIButton) {
        performSegue(withIdentifier: "homeToGame", sender: sender)
    }
    
    enum Difficulty:Int {
        case Easy
        case Medium
        case Hard
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToGame"{
            if let gameViewController = segue.destination as? GameViewController {
                //let know if 36 or 64 case
                if let button = sender as? UIButton {
                    if (button.currentTitle?.contains("Easy"))! {
                        gameViewController.nbCells = 36
                    }else if (button.currentTitle?.contains("Medium"))! {
                        gameViewController.nbCells = 64
                    }else{
                        gameViewController.nbCells = 144
                    }
                    
                }
            }
        }
    }


}

