//
//  File.swift
//  Checklists
//
//  Created by Arain on 15/6/22.
//  Copyright (c) 2015年 Arain. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}
