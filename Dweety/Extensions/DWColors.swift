//
//  DWColors.swift
//  Dweety
//
//  Created by Mohamed EL Meseery on 9/3/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import UIKit

extension UIColor {
    class var mainColor : UIColor {
        return UIColor(hexString: "009ADA")
    }
    class var mainColorDarker : UIColor {
        return UIColor(hexString: "0080B7")
    }
    class var grayColor : UIColor {
        return UIColor(hexString: "888888")
    }
    class var redColor : UIColor {
        return UIColor(hexString: "DC582A")
    }
    class var greenColor : UIColor {
        return UIColor(hexString: "BED62F")
    }
    class var whiteColor : UIColor {
        return .white
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
