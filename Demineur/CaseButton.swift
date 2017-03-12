//
//  CaseButton.swift
//  Demineur
//
//  Created by alexandre pouget on 09/03/2017.
//  Copyright © 2017 alexandre pouget. All rights reserved.
//

import UIKit

class CaseButton: UIButton {

    var cell: Cell?
    var visibilityState:VisibilityState = .hidden
    
    enum VisibilityState: Int {
        case hidden
        case visible
        case flaged
    }
    
}
