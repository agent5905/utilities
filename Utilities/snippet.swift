//
//  snippet.swift
//  Utilities
//
//  Created by Daniel Garcia on 8/16/16.
//  Copyright © 2016 Daniel Garcia. All rights reserved.
//

import Foundation
/*
 
 comboBoxListView.frame = CGRectMake(0.0, self.frame.height - (self.cornerRadius * 1.5), self.frame.width - self.frame.height, 100.0)
 comboBoxListView.backgroundColor = UIColor.whiteColor()
 comboBoxListView.clipsToBounds = true
 comboBoxListView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
 let viewMaskLayer = CAShapeLayer()
 viewMaskLayer.frame = comboBoxListView.bounds
 viewMaskLayer.path = UIBezierPath(roundedRect: comboBoxListView.bounds, byRoundingCorners: [.BottomRight, .BottomLeft], cornerRadii: CGSize(width: self.cornerRadius, height: self.cornerRadius)).CGPath
 comboBoxListView.layer.mask = viewMaskLayer
 
 
 let borderLayer = CAShapeLayer()
 borderLayer.frame = comboBoxListView.bounds
 borderLayer.path = viewMaskLayer.path
 borderLayer.lineWidth = self.borderWith
 borderLayer.strokeColor = self.borderColor
 borderLayer.fillColor = UIColor.clearColor().CGColor
 
 comboBoxListView.layer.addSublayer(borderLayer)

*/

/*override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
 let translatedPoint = comboBoxListView.tableView.convertPoint(point, toView: self)
 
 if CGRectContainsPoint(comboBoxListView.tableView.bounds, translatedPoint) {
 print("table view pressed")
 //return comboBoxListView.tableView.hitTest(translatedPoint, withEvent: event)
 return comboBoxListView.tableView
 }
 
 return super.hitTest(point, withEvent: event)
 }*/

/*
 override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
 print("touch")
 
 let touch = event!.allTouches()!.first! as UITouch
 
 if listVisible && (touch.view != self || touch.view != self.arrowView || touch.view != self.comboBoxListView.tableView) {
 print("outside")
 hideList()
 }
 
 super.touchesBegan(touches, withEvent: event)
 }
*/