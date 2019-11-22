//
//  CustomControl.swift
//  StarRating
//
//  Created by Craig Swanson on 11/21/19.
//  Copyright © 2019 Craig Swanson. All rights reserved.
//

import Foundation
import UIKit

class CustomControl: UIControl {
    
    var value: Int = 1
    
    private let componentDimension: CGFloat = 40.0
    private let componentCount: Int = 5
    private let componentActiveColor: UIColor = .black
    private let componentInactiveColor: UIColor = .gray
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        
        setup()
    }
    
    func setup() {
        var starArray: [UILabel] = []
        for n in stride(from: CGFloat(1), through: CGFloat(5), by: 1) {
            let newLabel = UILabel(frame: CGRect(x: (n * 8) + (componentDimension * (n - 1)), y: 0, width: componentDimension, height: componentDimension))
            newLabel.tag = Int(n)
            newLabel.font = .systemFont(ofSize: 32.0, weight: .bold)
            newLabel.text = "✩"
            newLabel.textAlignment = .center
            if n == 1 {
                newLabel.textColor = componentActiveColor
            } else {
                newLabel.textColor = componentInactiveColor
            }
            addSubview(newLabel)
            starArray.append(newLabel)
        }
    }
    override var intrinsicContentSize: CGSize {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * 8.0
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        updateValue(at: touch)
        sendActions(for: .touchDown)
        
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        
        if self.bounds.contains(touchPoint) {
            updateValue(at: touch)
            sendActions(for: [.touchDragInside, .valueChanged])
        } else {
            sendActions(for: .touchDragOutside)
        }
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        defer {
            super.endTracking(touch, with: event)
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        defer {
            super.cancelTracking(with: event)
        }
        
        sendActions(for: .touchCancel)
    }
    
    private func updateValue(at touch: UITouch) {
        
    }
    
}
