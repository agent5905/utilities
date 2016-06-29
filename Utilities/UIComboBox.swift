//
//  UIComboBox.swift
//  Utilities
//
//  Created by Daniel Garcia on 6/29/16.
//  Copyright © 2016 Daniel Garcia. All rights reserved.
//

import UIKit

@IBDesignable class UIComboBox: UITextField {
    
    enum UIComboBoxStyle: Int {
        case DropDownComboBox = 0
        case SimpleComboBox = 1
        case DropDownList = 2
    }

    @IBInspectable var dropDownHeight:CGFloat = 100.0
    @IBInspectable var displayArrow:Bool = true {
        didSet{
            
        }
    }
    
    let arrowView = UIView()
    let comboBoxHeight:CGFloat = 30.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
    
    
    func setup(){
        super.clipsToBounds = false
        drawArrow()
        
    }
    
    func drawArrow(){
        
        arrowView.frame = CGRectMake(self.bounds.width - comboBoxHeight, 0.0 , comboBoxHeight, comboBoxHeight)
        arrowView.backgroundColor = UIColor.lightGrayColor()
        //arrowView.layer.cornerRadius = 5.0
    
        
        let buttonMaskLayer = CAShapeLayer()
        buttonMaskLayer.frame = arrowView.bounds
        buttonMaskLayer.path = UIBezierPath(roundedRect: arrowView.bounds, byRoundingCorners: [.TopRight, .BottomRight], cornerRadii: CGSize(width: 5.0, height: 5.0)).CGPath
        arrowView.layer.mask = buttonMaskLayer
        
        
        let xPos:CGFloat = 15.0
        let yPos:CGFloat = 20.0
        let size:CGFloat = 7.5
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, xPos, yPos)
        
        CGPathAddLineToPoint(path, nil, xPos + size, yPos - size)
        CGPathAddLineToPoint(path, nil, xPos - size, yPos - size)
        CGPathAddLineToPoint(path, nil, xPos, yPos)
        
        let triangle = CAShapeLayer()
        triangle.frame = arrowView.bounds
        triangle.path = path
        triangle.lineWidth = 0.5
        triangle.strokeColor = UIColor.darkGrayColor().CGColor
        triangle.fillColor = UIColor.darkGrayColor().CGColor
        
        arrowView.layer.insertSublayer(triangle, atIndex: 0)
        
        
        self.addSubview(arrowView)
    }
    
    
    //Methods
    var TextChanged: ((sender: UIComboBox) -> ())?
    var SelectedIndexChanged: ((sender: UIComboBox) -> ())?
    var GotFocus: ((sender:UIComboBox) -> ())?
    var LostFocus: ((sender:UIComboBox) -> ())?
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
