//
//  ViewController.swift
//  AnalogClock
//
//  Created by Boominadha Prakash on 18/08/17.
//  Copyright © 2017 Boominadha Prakash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var hourLayer:CALayer!
    var minuteLayer:CALayer!
    var secondsLayer:CALayer!
    var imageLayer:CALayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let layer:CALayer = CALayer()
        layer.frame = self.view.frame
        self.view.layer.addSublayer(layer)
        //layer.contentsRect = CGRect(x: (self.view.frame.size.width/2)-100, y: (self.view.frame.size.height/2)-100, width: (self.view.frame.size.width/2)+100, height: (self.view.frame.size.height/2)+100)
        //layer.contents = UIImage(named: "ClockFace.jpg")?.cgImage;
        
        //Draw the image layer
        imageLayer = CALayer()
        imageLayer.backgroundColor = UIColor.clear.cgColor
        imageLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        imageLayer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        imageLayer.bounds = CGRect(x: 0, y: 0, width: ((self.view.frame.size.width/2)-20)*2, height: ((self.view.frame.size.width/2)-20)*2)
        imageLayer.contents = UIImage(named: "ClockFace.jpg")?.cgImage
        layer.addSublayer(imageLayer)
        
        
        //Draw the hours hand layer
        hourLayer = CALayer()
        hourLayer.backgroundColor = UIColor.black.cgColor
        hourLayer.anchorPoint = CGPoint(x: 0.5, y: 0)
        hourLayer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        hourLayer.bounds = CGRect(x: 0, y: 0, width: 10, height: (self.view.frame.size.width/2)-100)
        layer.addSublayer(hourLayer)
        
        //Draw the minutes hand layer
        minuteLayer = CALayer()
        minuteLayer.backgroundColor = UIColor.black.cgColor
        minuteLayer.anchorPoint = CGPoint(x: 0.5, y: 0)
        minuteLayer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        minuteLayer.bounds = CGRect(x: 0, y: 0, width: 6, height: (self.view.frame.size.width/2)-50)
        layer.addSublayer(minuteLayer)
        
        //Draw the seconds hand layer
        secondsLayer = CALayer()
        secondsLayer.backgroundColor = UIColor.red.cgColor
        secondsLayer.anchorPoint = CGPoint(x: 0.5, y: 0)
        secondsLayer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        secondsLayer.bounds = CGRect(x: 0, y: 0, width: 3, height: (self.view.frame.size.width/2)-20)
        layer.addSublayer(secondsLayer)
        
        let date = NSDate()
        //Place the hands at correct location
        let calendar = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian);
        let dateComponenets = calendar?.components([NSCalendar.Unit.year,NSCalendar.Unit.month,NSCalendar.Unit.day, NSCalendar.Unit.second, NSCalendar.Unit.minute, NSCalendar.Unit.hour], from: date as Date)
        let seconds:NSInteger = (dateComponenets?.second!)!
        let minutes:NSInteger = (dateComponenets?.minute!)!
        let hours:NSInteger = (dateComponenets?.hour!)!
        print("Hour: \(hours), Minute: \(minutes), Seconds:\(seconds)")
        
        //Calculate the angles for each hand of the analog clock

        let hourAngle:CGFloat = (CGFloat(hours * (360/12)) + (CGFloat(minutes) * (1.0/60) * (360/12)))
        let minuteAngle:CGFloat = CGFloat(minutes * (360/60))
        let secondsAngle = CGFloat(seconds * (360/60))
        
        hourLayer.transform = CATransform3DMakeRotation(hourAngle/CGFloat(180*M_PI), 0, 0, 1)
        minuteLayer.transform = CATransform3DMakeRotation(minuteAngle/CGFloat(180*M_PI), 0, 0, 1)
        secondsLayer.transform = CATransform3DMakeRotation(secondsAngle/CGFloat(180*M_PI), 0, 0, 1)
    
    
        //Add 3 animations for each layer
        let secondsAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        secondsAnimation.repeatCount = Float.infinity
        secondsAnimation.duration = 60
        secondsAnimation.isRemovedOnCompletion = false
        secondsAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        secondsAnimation.fromValue = (secondsAngle+180) * CGFloat(M_PI / 180)
        secondsAnimation.byValue = (2 * M_PI)
        secondsLayer.add(secondsAnimation, forKey: "SecondAnimationKey")
        
        let minutesAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        minutesAnimation.repeatCount = Float.infinity
        minutesAnimation.duration = 60 * 60
        minutesAnimation.isRemovedOnCompletion = false
        minutesAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        let fromValue = ((minuteAngle+180) * .pi / 180)
        let toValue = 2 * M_PI
        minutesAnimation.fromValue = fromValue ;
        minutesAnimation.byValue = toValue
        minuteLayer.add(minutesAnimation, forKey: "MinutesAnimationKey")
        
        let hoursAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        hoursAnimation.repeatCount = Float.infinity
        hoursAnimation.duration = CFTimeInterval(60 * 60 * 12);
        hoursAnimation.isRemovedOnCompletion = false
        hoursAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        hoursAnimation.fromValue = ((hourAngle+180)  * .pi / 180)
        hoursAnimation.byValue = 2 * M_PI
        hourLayer.add(hoursAnimation, forKey: "HoursAnimationKey")
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

