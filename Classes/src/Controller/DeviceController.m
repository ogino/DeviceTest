//
//  DeviceController.m
//  DeviceTest
//
//  Created by 荻野 雅 on 11/08/10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DeviceController.h"

@interface DeviceController (PrivateDelegateHandling)
- (void)prepareAccelerometer;
- (void)prepareOrientation;
- (void)createMotionManager;
- (void)didLotate:(NSNotification*)notification;
- (void)updateMotionManager:(CMDeviceMotion*)motion;
@end


@implementation DeviceController

@synthesize label = label_;
@synthesize xAcceler = xAcceler_;
@synthesize yAcceler = yAcceler_;
@synthesize zAcceler = zAcceler_;
@synthesize direction = direction_;
@synthesize xMotion = xMotion_;
@synthesize yMotion = yMotion_;
@synthesize zMotion = zMotion_;
@synthesize shakeMotion = shakeMotion_;
@synthesize motionManager = motionManager_;
@synthesize accelerometerX = accelerometerX_;
@synthesize accelerometerY = accelerometerY_;
@synthesize accelerometerZ = accelerometerZ_;

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
	self.label = nil;
	self.xAcceler = nil;
	self.yAcceler = nil;
	self.zAcceler = nil;
	self.direction = nil;
	self.xMotion = nil;
	self.yMotion = nil;
	self.zMotion = nil;
	self.shakeMotion = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.label.text = @"デバイスの方位チェック";
	self.accelerometerX = 0.0;
	self.accelerometerY = 0.0;
	self.accelerometerZ = 0.0;
	[self prepareAccelerometer];
	[self prepareOrientation];
	[self createMotionManager];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIAccelerometerDelegate

#define FILTER_RATIO 0.1
#define FILTER_PREV_RATIO (1.0 - FILTER_RATIO)

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration {
	self.accelerometerX = (acceleration.x * FILTER_RATIO) + (self.accelerometerX * FILTER_PREV_RATIO);
	self.accelerometerY = (acceleration.y * FILTER_RATIO) + (self.accelerometerY * FILTER_PREV_RATIO);
	self.accelerometerZ = (acceleration.z * FILTER_RATIO) + (self.accelerometerZ * FILTER_PREV_RATIO);
	self.xAcceler.text = [NSString stringWithFormat:@"%+.2f", self.accelerometerX];
	self.yAcceler.text = [NSString stringWithFormat:@"%+.2f", self.accelerometerY];
	self.zAcceler.text = [NSString stringWithFormat:@"%+.2f", self.accelerometerZ];
}

#pragma mark - UIResponderDelegate

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent*)event {
	switch (motion) {
		case UIEventSubtypeMotionShake:
			self.shakeMotion.text = @"シェイク開始";
			break;
		default:
			self.shakeMotion.text = @"モーション開始";
			break;
	}
	if ([super respondsToSelector:@selector(motionBegan:withEvent:)]) {
        [super motionBegan:motion withEvent:event];
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent*)event {
	switch (motion) {
		case UIEventSubtypeMotionShake:
			self.shakeMotion.text = @"シェイク完了";
			break;
		default:
			self.shakeMotion.text = @"モーション完了";
			break;
	}
	if ([super respondsToSelector:@selector(motionEnded:withEvent:)]) {
        [super motionEnded:motion withEvent:event];
    }
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent*)event {
	switch (motion) {
		case UIEventSubtypeMotionShake:
			self.shakeMotion.text = @"シェイクキャンセル";
			break;
		default:
			self.shakeMotion.text = @"モーションキャンセル";
			break;
	}
	if ([super respondsToSelector:@selector(motionCancelled:withEvent:)]) {
        [super motionCancelled:motion withEvent:event];
    }
}

- (BOOL)canBecomeFirstResponder {
	return YES;
}


#pragma mark - Private Methods

- (void)prepareAccelerometer {
	UIAccelerometer* accelerometer = [UIAccelerometer sharedAccelerometer];
	accelerometer.updateInterval = 0.1f;
	accelerometer.delegate = self;
}

- (void)prepareOrientation {
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)createMotionManager {
	self.motionManager = [[[CMMotionManager alloc] init] autorelease];
	if (self.motionManager.gyroAvailable) {
		self.motionManager.gyroUpdateInterval = 0.1f;
		[self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
			[self updateMotionManager:motion];
		}];
		self.xMotion.text = [NSString stringWithFormat:@"%+.0f Degree", 0.0f];
		self.yMotion.text = [NSString stringWithFormat:@"%+.0f Degree", 0.0f];
		self.zMotion.text = [NSString stringWithFormat:@"%+.0f Degree", 0.0f];
	} else {
		self.xMotion.text = @"ジャイロ非対応";
		self.yMotion.text = @"ジャイロ非対応";
		self.zMotion.text = @"ジャイロ非対応";
	}
}

- (void)didLotate:(NSNotification*)notification {
	UIDeviceOrientation orientation = [[notification object] orientation];
	switch (orientation) {
		case UIDeviceOrientationFaceDown:
			self.direction.text = @"画面が下向き";
			break;
		case UIDeviceOrientationFaceUp:
			self.direction.text = @"画面が上向き";
			break;
		case UIDeviceOrientationLandscapeLeft:
			self.direction.text = @"左90度回転";
			break;
		case UIDeviceOrientationLandscapeRight:
			self.direction.text = @"右90度回転";
			break;
		case UIDeviceOrientationPortrait:
			self.direction.text = @"回転なし";
			break;
		case UIDeviceOrientationPortraitUpsideDown:
			self.direction.text = @"180度回転";
			break;
		default:
			break;
	}
	self.shakeMotion.text = nil;
}

#define DEGREE_RATIO (180 / M_PI)


- (void)updateMotionManager:(CMDeviceMotion*)motion {
	CMAttitude* attitude = motion.attitude;
	double pitch = attitude.pitch * DEGREE_RATIO;
	double yaw = attitude.yaw * DEGREE_RATIO;
	double roll = attitude.roll * DEGREE_RATIO;
	self.xMotion.text = [NSString stringWithFormat:@"%+.0f Degree", pitch];
	self.yMotion.text = [NSString stringWithFormat:@"%+.0f Degree", yaw];
	self.zMotion.text = [NSString stringWithFormat:@"%+.0f Degree", roll]; 
}

@end
