//
//  Column.swift
//  TowerOfShanoi
//
//  Created by Kevin E Lopez on 1/10/15.
//  Copyright (c) 2015 Kevin E Lopez. All rights reserved.
//

import UIKit

class Column: UIImageView {

    weak var fallingObject: Block!
    weak var topObject: Block!
    var arrayOfObjects = [Block]()
    var capacity: Float!
    
    
}
