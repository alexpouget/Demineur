//
//  PlayTable.swift
//  Demineur
//
//  Created by alexandre pouget on 09/03/2017.
//  Copyright © 2017 alexandre pouget. All rights reserved.
//

import Foundation

class PlayTable {
    
    var cells = [[Cell]]()
    var numberOfCell:Int
    var numberOfBomb:Int = 0
    var result:Result
    
    init(nbCells: Int) {
        self.numberOfCell = nbCells
        result = .notEnded
        
        let numberOfRow = Int(sqrt(Double(numberOfCell)))
        for row in 0..<numberOfRow {
            var rowArray = [Cell]()
            for col in 0..<numberOfRow {
                let cell = Cell(_row: row, _col: col)
                rowArray.append(cell)
            }
            cells.append(rowArray)
        }
        affectNumberOfBomb()
        generateBombs(nb: numberOfBomb, max: numberOfRow)
    }
    
    //generate bomb and indice near
    private func generateBombs(nb: Int,max:Int){
        for _ in 0..<nb{
            var row = 0
            var col = 0
            repeat{
                row = Int(arc4random_uniform(UInt32(max)))
                col = Int(arc4random_uniform(UInt32(max)))
            }while(cells[row][col].bombIsPresent)
            cells[row][col].bombIsPresent = true
            //incremente neighbour cell
            if row-1>=0 {
                if col-1>=0 {
                    self.cells[row-1][col-1].incrementeIndex()
                }
                cells[row-1][col].incrementeIndex()
                if col+1<max {
                    self.cells[row-1][col+1].incrementeIndex()
                }
            }
            if row+1<max {
                if col-1>=0 {
                    cells[row+1][col-1].incrementeIndex()
                }
                cells[row+1][col].incrementeIndex()
                if col+1<max {
                    cells[row+1][col+1].incrementeIndex()
                }
            }
            if col+1<max {
                cells[row][col+1].incrementeIndex()
            }
            if col-1>=0 {
                cells[row][col-1].incrementeIndex()
            }
        }
    }
    
    enum Result:Int {
        case Win
        case Loose
        case notEnded
    }
    
   
    private func affectNumberOfBomb(){
        switch numberOfCell {
        case 36:
            numberOfBomb = 6
        case 64:
            numberOfBomb = 14
        case 144:
            numberOfBomb = 32
        default:
            numberOfBomb = 8
        }
    }
}
