//
//  BugModel.swift
//  FeedBackQA
//
//  Created by User on 3/27/20.
//

import UIKit

struct BugModel:Codable {
    var id:String
    var modelo: String
    var version: String
    var versionSO: String
    var fecha: String
    var mensaje: String
    var foto: String
}
