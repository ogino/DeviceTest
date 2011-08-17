//
//  DeviceController.h
//  DeviceTest
//
//  Created by 荻野 雅 on 11/08/10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>


@interface DeviceController : UIViewController<UIAccelerometerDelegate> {
@private
	UILabel* label_;
	UILabel* xAcceler_;
	UILabel* yAcceler_;
	UILabel* zAcceler_;
	UILabel* direction_;
	UILabel* xMotion_;
	UILabel* yMotion_;
	UILabel* zMotion_;
	UILabel* shakeMotion_;
	CMMotionManager* motionManager_;
	double accelerometerX_;
	double accelerometerY_;
	double accelerometerZ_;
}

@property (nonatomic, retain) IBOutlet UILabel* label;
@property (nonatomic, retain) IBOutlet UILabel* xAcceler;
@property (nonatomic, retain) IBOutlet UILabel* yAcceler;
@property (nonatomic, retain) IBOutlet UILabel* zAcceler;
@property (nonatomic, retain) IBOutlet UILabel* direction;
@property (nonatomic, retain) IBOutlet UILabel* xMotion;
@property (nonatomic, retain) IBOutlet UILabel* yMotion;
@property (nonatomic, retain) IBOutlet UILabel* zMotion;
@property (nonatomic, retain) IBOutlet UILabel* shakeMotion;
@property (nonatomic, retain) CMMotionManager* motionManager;
@property (nonatomic, assign) double accelerometerX;
@property (nonatomic, assign) double accelerometerY;
@property (nonatomic, assign) double accelerometerZ;

@end
