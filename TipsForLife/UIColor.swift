//
//  UIColor.swift
//  HyuKit
//
//  Created by NguyenVuHuy on 7/10/17.
//  Copyright © 2017 Hyubyn. All rights reserved.
//

import UIKit

extension UIColor {
    
    /*
     Function: getInverseColor
     Get opposite color of current color in color wheel
     */
    
    func getInverseColor() -> UIColor? {
        var alpha: CGFloat = 0.0
        var white: CGFloat = 0.0
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        
        if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor.init(red: 1.0 - red, green: 1.0 - green, blue: 1.0 - blue, alpha: alpha)
        }
        
        if getWhite(&white, alpha: &alpha) {
            return UIColor.init(white: 1.0 - white, alpha: alpha)
        }
        
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor.init(hue: 1.0 - hue, saturation: 1.0 - saturation, brightness: 1.0 - brightness, alpha: alpha)
        }
        
        return nil
        
    }
    
    /*
     Bảng phân loại độ tương phản:
     1. Mực đen trên giấy vàng.
     2. Mực xanh lá cây trên giấy trắng.
     3. Mực xanh dương trên giấy trắng.
     4. Mực trắng trên giấy xanh dương.
     5. Mực đen trên giấy trắng.
     6. Mực vàng trên giấy đen.
     7. Mực trắng trên giấy đỏ.
     8. Mực trắng trên giấy xanh lá cây.
     9. Mực trắng trên giấy đen.
     10. Mực đỏ trên giấy vàng.
     11. Mực xanh lá cây trên giấy đỏ.
     12. Mực đỏ trên giấy xanh lá cây.
    */
    class func getTextColor(from background: UIColor) -> [UIColor] {
        switch background {
        case UIColor.yellow:
            return [UIColor.black, UIColor.red]
        case UIColor.white:
            return [UIColor.green, UIColor.blue, UIColor.black]
        case UIColor.blue:
            return [UIColor.white]
        case UIColor.black:
            return [UIColor.yellow, UIColor.white]
        case UIColor.red:
            return [UIColor.white, UIColor.green]
        case UIColor.green:
            return [UIColor.white, UIColor.red]
        default:
            return [UIColor.white]
        }
    }
    
    
    /*
     Function: getNearByColor
     return left and right color with alpha = 1/2 current color in color wheel
     */
    func getNearByColor(option: SimilarColorOption = .green) -> [UIColor]? {
        var alpha: CGFloat = 0.0
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var color1, color2: UIColor?
        
        if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            switch option {
            case .green:
                color1 = UIColor.init(red: red, green: green / 2 > 0 ? green / 2 : 0.1, blue: blue, alpha: alpha / 2)
                color2 = UIColor.init(red: red, green: green * 2 < 1.0 ? green * 2 : 0.9, blue: blue, alpha: alpha / 2)
            case .red:
                color1 = UIColor.init(red: red / 2 > 0 ? red / 2 : 0.1, green: green, blue: blue, alpha: alpha / 2)
                color2 = UIColor.init(red: red * 2 < 1.0 ? red * 2 : 0.9, green: green , blue: blue, alpha: alpha / 2)
            default:
                color1 = UIColor.init(red: red , green: green, blue: blue / 2 > 0 ? blue / 2 : 0.1, alpha: alpha / 2)
                color2 = UIColor.init(red: red , green: green , blue: blue * 2 < 1.0 ? blue * 2 : 0.9, alpha: alpha / 2)
            }
            return [color2!, color1!]
        }
        return nil
    }
}

enum SimilarColorOption: Int {
    case red = 0
    case green = 1
    case blue = 2
}
