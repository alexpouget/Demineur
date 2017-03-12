//
//  GameViewController.swift
//  Demineur
//
//  Created by alexandre pouget on 09/03/2017.
//  Copyright © 2017 alexandre pouget. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var nbCells: Int?
    private var timer = Timer()
    private var timeInSecond = 0
    
    @IBOutlet var gameView: GameView!{
        didSet{
            if nbCells != nil {
                gameView.playTable = PlayTable(nbCells: nbCells!)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
    }
    private func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeInSecond), userInfo: nil, repeats: true)
    }
    
    func updateTimeInSecond(){
        timeInSecond += 1
    }
    
    func endGame(){
        timer.invalidate()
        switch gameView.playTable!.result {
        case .Loose:
            performSegue(withIdentifier: "popUpSegue", sender: nil)
        case .Win:
            performSegue(withIdentifier: "popUpSegue", sender: nil)
        case .notEnded:
            timeInSecond = 0
            startTimer()
        }
        
    }
    
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "popUpSegue" ){
            if let gvController = segue.destination as? GameViewController{
                gvController.gameView = gameView
                gvController.timeInSecond = timeInSecond
            }
        }
    }

    // MARK: - popUpController
    
    @IBAction func restart() {
        gameView.reset()
        gameView.setNeedsDisplay()
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var resultatLabel: UILabel!{
        didSet{
            //calcul time
            let hours = timeInSecond / 3600
            let minutes = timeInSecond / 60 % 60
            let seconds = timeInSecond % 60
            //PopUp Value
            switch gameView.playTable!.result {
            case .Loose:
                self.resultatLabel.text = "Game over in \(hours):\(minutes):\(seconds) "
            case .Win:
                self.resultatLabel.text = "Win in \(hours):\(minutes):\(seconds)"
            default:
                print("error")
            }
        }
    }

    @IBOutlet weak var popUp: UIView!{
        didSet{
            // PopUp Style
            popUp.layer.cornerRadius = 5.0
            popUp.layer.borderWidth = 2
            popUp.layer.borderColor = UIColor.black.cgColor
        }
    }
    
}
