//
//  FortuneAppDelegate.h
//  Fortune
//
//  Created by 荻野 雅 on 11/08/10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FortuneViewController;

@interface FortuneAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet FortuneViewController *viewController;

@end
