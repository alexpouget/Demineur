//
//  GameView.swift
//  Demineur
//
//  Created by alexandre pouget on 09/03/2017.
//  Copyright © 2017 alexandre pouget. All rights reserved.
//

import UIKit

class GameView: UIView{
    
    private var sizeButton = CGFloat()
    private var buttons = [[CaseButton]]()
    private var ratiosSizeButtons = CGFloat(0.9)
    private var caseHidden = 0
    private var numberOfFlag = 0 {
        didSet{
            label.text = "flag = \(numberOfFlag)"
        }
    }
    private var label:UILabel! = UILabel()
    
    private var result:PlayTable.Result = .notEnded{
        didSet{
            playTable?.result = result
            if let con = self.next as? GameViewController{
                con.endGame()
            }
        }
    }
    
    var playTable:PlayTable?{
        didSet{
            drawButtons()
            drawInfo()
        }
    }
    
    func reset(){
        buttons.removeAll()
        playTable = PlayTable(nbCells: playTable!.numberOfCell)
        result = .notEnded
    }
    
    private func drawInfo(){
        label = UILabel(frame: CGRect(x: 0, y: 30, width: bounds.size.width, height: 30))
        label.text = "flag = \(numberOfFlag)"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.gray
        addSubview(label)
    }
    
    private func drawButtons(){
        caseHidden = playTable!.numberOfCell - playTable!.numberOfBomb
        sizeButton = bounds.size.width / CGFloat(Int(sqrt(Double(playTable!.numberOfCell)))) * ratiosSizeButtons
        numberOfFlag = playTable!.numberOfBomb
        //rows
        for rows in playTable!.cells{
           //columns
            var rowArray = [CaseButton]()
            for cell in rows{
                //init
                let button = CaseButton(frame: CGRect(x: 0+CGFloat(cell.col!)*sizeButton , y: 70+CGFloat(cell.row!)*sizeButton, width: sizeButton, height: sizeButton))
                button.cell = cell
                
                //design
                button.backgroundColor = UIColor.lightGray
                button.layer.borderColor = UIColor.black.cgColor
                button.layer.borderWidth = 1
                button.titleLabel?.adjustsFontSizeToFitWidth = true
                
                //action
                button.addTarget(self, action: #selector(reveal), for: .touchUpInside) // reveal
                button.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(flaged)))// flaged a faire
                
                rowArray.append(button)
                addSubview(button)
            }
            buttons.append(rowArray)
        }
    }

    func reveal(button : CaseButton){
        if(button.visibilityState == .hidden){
            let numberRow = Int(sqrt(Double(playTable!.numberOfCell)))
            //Bomb
            if(button.cell!.bombIsPresent){
                button.setTitle("B", for: .normal)
                button.backgroundColor = UIColor.red
                result = .Loose
            }
            else{
                button.backgroundColor = UIColor.blue
                button.setTitle(String(describing: button.cell!.indexNumber), for: .normal)
                button.visibilityState = .visible
                caseHidden -= 1
                if(caseHidden==0){
                    result = .Win
                }
                //If index == 0 reveal neighbour
                if button.cell!.indexNumber == 0 {
                    let row = (button.cell!.row)!
                    let col = (button.cell!.col)!

                    if row-1>=0 {
                        if col-1>=0 {
                            reveal(button: buttons[row-1][col-1])
                        }
                        reveal(button: buttons[row-1][col])
                        if col+1<numberRow {
                            reveal(button: buttons[row-1][col+1])
                        }
                    }
                    if row+1<numberRow {
                        if col-1>=0 {
                            reveal(button: buttons[row+1][col-1])
                        }
                        reveal(button: buttons[row+1][col])
                        
                        if col+1<numberRow {
                            reveal(button: buttons[row+1][col+1])
                        }
                    }
                    if col+1<numberRow {
                        reveal(button: buttons[row][col+1])
                    }
                    if col-1>=0 {
                        reveal(button: buttons[row][col-1])
                    }
                }
            }
        }
    }
 
    func flaged(recognizer : UILongPressGestureRecognizer){
        if recognizer.state == .ended {
            if let button = recognizer.view as? CaseButton{
                if(button.visibilityState == .hidden){
                    button.setTitle("F", for: .normal)
                    button.visibilityState = .flaged
                    numberOfFlag -= 1
                }else if button.visibilityState == .flaged {
                    button.setTitle("", for: .normal)
                    button.visibilityState = .hidden
                    numberOfFlag += 1
                }
            }
        }
    }
}
