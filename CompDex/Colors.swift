//
//  Colors.swift
//  CompDex
//
//  Created by Angel Avila on 4/19/16.
//  Copyright © 2016 Angel Avila. All rights reserved.
//

import Foundation
import UIKit

public class Colors {
    
    public init () {}
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func getLabelColorForType(type: String) -> UIColor {
        var typeColor: UIColor = UIColor()
        switch(type) {
        case "NORMAL" :
            typeColor = UIColorFromRGB(0xA8A77A)
            break
        case "FIGHTING" :
            typeColor = UIColorFromRGB(0xC22E28)
            break
        case "FLYING" :
            typeColor = UIColorFromRGB(0xA98FF3)
            break
        case "POISON" :
            typeColor = UIColorFromRGB(0xA33EA1)
            break
        case "GROUND" :
            typeColor = UIColorFromRGB(0xE2BF65)
            break
        case "ROCK" :
            typeColor = UIColorFromRGB(0xB6A136)
            break
        case "BUG" :
            typeColor = UIColorFromRGB(0xA6B91A)
            break
        case "GHOST" :
            typeColor = UIColorFromRGB(0x735797)
            break
        case "STEEL" :
            typeColor = UIColorFromRGB(0xB7B7CE)
            break
        case "FIRE" :
            typeColor = UIColorFromRGB(0xEE8130)
            break
        case "WATER" :
            typeColor = UIColorFromRGB(0x6390F0)
            break
        case "GRASS" :
            typeColor = UIColorFromRGB(0x7AC74C)
            break
        case "ELECTRIC" :
            typeColor = UIColorFromRGB(0xF7D02C)
            break
        case "PSYCHIC" :
            typeColor = UIColorFromRGB(0xF95587)
            break
        case "ICE" :
            typeColor = UIColorFromRGB(0x96D9D6)
            break
        case "DRAGON" :
            typeColor = UIColorFromRGB(0x6F35FC)
            break
        case "DARK" :
            typeColor = UIColorFromRGB(0x705746)
            break
        case "FAIRY" :
            typeColor = UIColorFromRGB(0xD685AD)
            break
        default:
            typeColor = UIColor.blackColor()
        }
        return typeColor
    }
}