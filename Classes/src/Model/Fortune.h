//
//  Fortune.h
//  DeviceTest
//
//  Created by 荻野 雅 on 11/08/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Fortune : NSObject {
@private
	NSDictionary* blessDictionary_;
}

@property (nonatomic, retain) NSDictionary* blessDictionary;

- (id)initWithFilePath:(NSString*)filePath;
- (NSDictionary*)createBlessing;

@end
