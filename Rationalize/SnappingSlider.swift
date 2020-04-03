//
//  SnappingSlider.swift
//  Rationalize
//
//  Created by Yajnavalkya on 2020. 04. 03..
//  Copyright © 2020. Yajnavalkya. All rights reserved.
//

import UIKit

public protocol SnappingSliderDelegate : AnyObject {
    func snappingSlider(_ snappingSlider: SnappingSlider, didChangeValueTo newValue: Float)
}

public extension SnappingSliderDelegate {
    func snappingSlider(_ snappingSlider: SnappingSlider, didChangeValueTo newValue: Float){}
}

public class SnappingSlider: UISlider {
    public weak var delegate: SnappingSliderDelegate?
    
    @IBInspectable public var step: Float = 1
    
    @IBInspectable public lazy var threshold: Float = step / 2
    
    public var snappedValue: Float = 0 {
        didSet {
            value = snappedValue
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    private func initView() {
        addTarget(self, action: #selector(handleValueChange(sender:)), for: .valueChanged)
        
        addTarget(self, action: #selector(handleTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    
    @objc func handleTouchUp() {
        delegate?.snappingSlider(self, didChangeValueTo: snappedValue)
    }
    
    @objc func handleValueChange(sender: UISlider) {
        let displacementValue = value - snappedValue
        
        switch abs(displacementValue) {
        case let x where x > threshold:
            let sign = Sign(float: displacementValue)
            let newValue = sign.normalizedValue * step
            snappedValue += newValue
            delegate?.snappingSlider(self, didChangeValueTo: snappedValue)
            
        default:
            value = snappedValue
        }
    }
}

extension SnappingSlider {
    enum Sign {
        case negative
        case positive
        case zero
        
        init(float: Float) {
            switch float {
            case let x where x > 0:
                self = .positive
            case let x where x < 0:
                self = .negative
            default:
                self = .zero
            }
        }
        
        var normalizedValue: Float {
            switch self {
            case .positive:
                return 1
            case .negative:
                return -1
            case .zero:
                return 0
            }
        }
    }
}
