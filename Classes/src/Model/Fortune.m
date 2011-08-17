//
//  Fortune.m
//  DeviceTest
//
//  Created by 荻野 雅 on 11/08/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Fortune.h"


@implementation Fortune

@synthesize blessDictionary = blessDictionary_;

#pragma mark - Inherit Methods

- (id)init {
	if ((self = [super init])) {
		NSString* filePath = [[NSBundle mainBundle] pathForResource:@"Fortune" ofType:@"plist"];
		self.blessDictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
	}
	return self;
}

- (void)dealloc {
	self.blessDictionary = nil;
	[super dealloc];
}

#pragma mark - Public Mathods

- (id)initWithFilePath:(NSString*)filePath {
	if ((self = [super init])) {
		self.blessDictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
	}
	return self;
}

#define POWER_NUMBER 31

- (NSDictionary*)createBlessing {
	NSUInteger max = -1;
	if (self.blessDictionary) max = self.blessDictionary.count;
	NSUInteger index = ((random() * (NSUInteger)[[NSDate date] timeIntervalSinceReferenceDate]) ^ POWER_NUMBER) % max;
	NSString* key = (NSString*)[(NSArray*)[self.blessDictionary allKeys] objectAtIndex:index];
	return (NSDictionary*)[self.blessDictionary objectForKey:key];
}

@end
