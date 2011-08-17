//
//  FortuneTest.m
//  DeviceTest
//
//  Created by 荻野 雅 on 11/08/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FortuneTest.h"


@implementation FortuneTest

- (void)setUp {
	[super setUp];
	_fortune = [[Fortune alloc] init];
}

- (void)tearDown {
	[_fortune release];
	[super tearDown];
}

- (void)testInit {
	assertThat(_fortune, notNilValue());
}

- (void)testBlessings {
	NSString* filePath =  [[NSBundle bundleForClass:[self class]] pathForResource:@"Fortune" ofType:@"plist"];
	NSDictionary* dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
	assertThat(dictionary, notNilValue());
	_fortune.blessDictionary = dictionary;
	NSDictionary* blessing = [_fortune createBlessing];
	assertThat(blessing, notNilValue());
	NSLog(@"blessing:\n%@", blessing);
}

@end
