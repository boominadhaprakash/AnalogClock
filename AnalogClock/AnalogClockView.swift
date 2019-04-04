//
//  AnalogClockView.swift
//  AnalogClock
//
//  Created by Sonata on 04/04/19.
//  Copyright © 2019 Boominadha Prakash. All rights reserved.
//

import Foundation
import UIKit

class AnalogClockView: UIView {
    
    //MARK: - Properties
    var hourLayer:CALayer!
    var minuteLayer:CALayer!
    var secondsLayer:CALayer!
    var imageLayer:CALayer!
    
    var hourAngle: CGFloat = 0
    var minuteAngle: CGFloat = 0
    var secondsAngle: CGFloat = 0
    
    //MARK: Init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAnalogClock()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpAnalogClock()
    }
    
    //MARK: Internal methods
    func setUpAnalogClock() {
        let layer = CALayer()
        layer.frame = self.frame
        self.layer.addSublayer(layer)
        
        addImageLayer()
        addHourLayer()
        addMinuteLayer()
        addSecondsLayer()
        
        let date = NSDate()
        
        //Place the hands at correct location
        let calendar = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian);
        let dateComponenets = calendar?.components([NSCalendar.Unit.year,NSCalendar.Unit.month,NSCalendar.Unit.day, NSCalendar.Unit.second, NSCalendar.Unit.minute, NSCalendar.Unit.hour], from: date as Date)
        let seconds:NSInteger = (dateComponenets?.second!)!
        let minutes:NSInteger = (dateComponenets?.minute!)!
        let hours:NSInteger = (dateComponenets?.hour!)!
        
        hourAngle = (CGFloat(hours * (360/12)) + (CGFloat(minutes) * (1.0/60) * (360/12)))
        minuteAngle = CGFloat(minutes * (360/60))
        secondsAngle = CGFloat(seconds * (360/60))
        
        hourLayer.transform = CATransform3DMakeRotation(hourAngle/CGFloat(180*Double.pi), 0, 0, 1)
        minuteLayer.transform = CATransform3DMakeRotation(minuteAngle/CGFloat(180*Double.pi), 0, 0, 1)
        secondsLayer.transform = CATransform3DMakeRotation(secondsAngle/CGFloat(180*Double.pi), 0, 0, 1)
        
        secondLayerAnimation()
        minuteLayerAnimation()
        hourLayerAnimation()
    }
    func addImageLayer() {
        imageLayer = CALayer()
        imageLayer.backgroundColor = UIColor.clear.cgColor
        imageLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        imageLayer.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        imageLayer.bounds = CGRect(x: 0, y: 0, width: ((self.frame.width/2)-20)*2, height: ((self.frame.width/2)-20)*2)
        imageLayer.contents = UIImage(named: "ClockFace.jpg")?.cgImage
        layer.addSublayer(imageLayer)
    }
    func addHourLayer() {
        hourLayer = CALayer()
        hourLayer.backgroundColor = UIColor.black.cgColor
        hourLayer.anchorPoint = CGPoint(x: 0.5, y: 0)
        hourLayer.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        hourLayer.bounds = CGRect(x: 0, y: 0, width: 8, height: (self.frame.width/2)-(self.frame.width * 0.7))
        layer.addSublayer(hourLayer)
    }
    func addMinuteLayer() {
        minuteLayer = CALayer()
        minuteLayer.backgroundColor = UIColor.black.cgColor
        minuteLayer.anchorPoint = CGPoint(x: 0.5, y: 0)
        minuteLayer.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        minuteLayer.bounds = CGRect(x: 0, y: 0, width: 5, height: (self.frame.width/2)-(self.frame.width * 0.8))
        layer.addSublayer(minuteLayer)
    }
    func addSecondsLayer() {
        secondsLayer = CALayer()
        secondsLayer.backgroundColor = UIColor.red.cgColor
        secondsLayer.anchorPoint = CGPoint(x: 0.5, y: 0)
        secondsLayer.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        secondsLayer.bounds = CGRect(x: 0, y: 0, width: 3, height: (self.frame.width/2)-(self.frame.width * 0.1))
        layer.addSublayer(secondsLayer)
    }
    func secondLayerAnimation() {
        let secondsAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        secondsAnimation.repeatCount = Float.infinity
        secondsAnimation.duration = 60
        secondsAnimation.isRemovedOnCompletion = false
        secondsAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        secondsAnimation.fromValue = (secondsAngle+180) * CGFloat(Double.pi / 180)
        secondsAnimation.byValue = (2 * Double.pi)
        secondsLayer.add(secondsAnimation, forKey: "SecondAnimationKey")
    }
    func minuteLayerAnimation() {
        let minutesAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        minutesAnimation.repeatCount = Float.infinity
        minutesAnimation.duration = 60 * 60
        minutesAnimation.isRemovedOnCompletion = false
        minutesAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        let fromValue = ((minuteAngle+180) * .pi / 180)
        let toValue = 2 * Double.pi
        minutesAnimation.fromValue = fromValue ;
        minutesAnimation.byValue = toValue
        minuteLayer.add(minutesAnimation, forKey: "MinutesAnimationKey")
    }
    func hourLayerAnimation() {
        let hoursAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        hoursAnimation.repeatCount = Float.infinity
        hoursAnimation.duration = CFTimeInterval(60 * 60 * 12);
        hoursAnimation.isRemovedOnCompletion = false
        hoursAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        hoursAnimation.fromValue = ((hourAngle+180)  * .pi / 180)
        hoursAnimation.byValue = 2 * Double.pi
        hourLayer.add(hoursAnimation, forKey: "HoursAnimationKey")
    }
}
