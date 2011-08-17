//
//  DeviceController.h
//  DeviceTest
//
//  Created by 荻野 雅 on 11/08/10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "Fortune.h"


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
	UILabel* countText_;
	UILabel* blessText_;
	CMMotionManager* motionManager_;
	NSTimer* timer_;
	Fortune* fortune_;
	double accelerometerX_;
	double accelerometerY_;
	double accelerometerZ_;
	NSUInteger count_;
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
@property (nonatomic, retain) IBOutlet UILabel* countText;
@property (nonatomic, retain) IBOutlet UILabel* blessText;
@property (nonatomic, retain) CMMotionManager* motionManager;
@property (nonatomic, retain) NSTimer* timer;
@property (nonatomic, retain) Fortune* fortune;
@property (nonatomic, assign) double accelerometerX;
@property (nonatomic, assign) double accelerometerY;
@property (nonatomic, assign) double accelerometerZ;
@property (nonatomic, assign) NSUInteger count;

@end
