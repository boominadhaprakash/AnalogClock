# Analog Clock
This Project has been development in Xcode 10.1 and Swift v4.2. I have referred this code from this link http://www.knowstack.com/coreanimation-analog-clock/. 
But the code available in that link is in Objective-C and also for Mac Programming. So, I have converted it for Swift v4.2.

<img src="https://github.com/boominadhaprakash/AnalogClock/blob/master/AnalogClock/clock.png" width="320" height="568" title="Sample Screenshot">

# USAGE
# Drag and drop the Source folder into your project.

## Programmatic way
   #### Setting width and height to Full Screen
	 var clockView: AnalogClockView {
   		let view = AnalogClockView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
   		view.center = self.view.center
   		return view
   	}
   	self.view.addSubview(clockView)
		
   #### Custom width and height
   	var clockView: AnalogClockView {
        let view = AnalogClockView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view.center = self.view.center
        return view
      }
   	self.view.addSubview(clockView)
      
## Configure via Interface Builder
    Add an UIView to ViewController via Storyboard or XIB and set the class name as AnalogClockView in UIView's identity inspector
