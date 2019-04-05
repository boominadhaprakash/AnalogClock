//
//  ViewController.swift
//  AnalogClock
//
//  Created by Boominadha Prakash on 18/08/17.
//  Copyright © 2017 Boominadha Prakash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var clockView: AnalogClockView {
        let view = AnalogClockView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        view.center = self.view.center
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addAnalogClock()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addAnalogClock() {
        self.view.addSubview(clockView)
    }

}

