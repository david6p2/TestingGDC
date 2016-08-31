//
//  TestingGDCTests.m
//  TestingGDCTests
//
//  Created by David Céspedes on 31/08/16.
//  Copyright © 2016 LSR Marketing Service. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface TestingGDCTests : XCTestCase

@property (nonatomic) ViewController *vcToTest;

@end

@interface ViewController (Test)

-(NSInteger)fibonacci:(NSInteger)fibMe;

@end

@implementation TestingGDCTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.vcToTest = [[ViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testfibonacci {
    NSNumber * fibToTest = @11;
    NSInteger fib = [self.vcToTest fibonacci:fibToTest.integerValue];
    NSNumber * expectedFib = @89;
    XCTAssertEqual(fib, expectedFib.integerValue, @"fib %ld is not equal to %ld",(long)fib, (long)expectedFib.integerValue);
    
}



@end
