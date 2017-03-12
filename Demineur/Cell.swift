//
//  Case.swift
//  Demineur
//
//  Created by alexandre pouget on 09/03/2017.
//  Copyright © 2017 alexandre pouget. All rights reserved.
//

import Foundation

class Cell {
    
    private var bomb : Bool = false
    private var index : Int = 0
    
    let row:Int?
    let col:Int?
    
    init(_row: Int,_col: Int) {
        self.row = _row
        self.col = _col
    }
    
    init(_row: Int,_col: Int,_index : Int) {
        self.row = _row
        self.col = _col
        self.index = _index
    }
    
    init(_row: Int,_col: Int,_bomb : Bool) {
        self.row = _row
        self.col = _col
        self.bomb = _bomb
    }
    
    var bombIsPresent:Bool{
        get{
            return bomb
        }
        set{
            self.bomb = newValue
        }
    }
    
    var indexNumber:Int{
        get{
            return index
        }
    }
    
    func incrementeIndex(){
        self.index += 1
    }
    
}
