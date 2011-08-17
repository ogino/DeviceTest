//
//  AppDelegate.h
//  DeviceTest
//
//  Created by 荻野 雅 on 11/08/10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DeviceController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
}

@property (nonatomic, retain) IBOutlet UIWindow* window;
@property (nonatomic, retain) IBOutlet DeviceController* viewController;

@end
