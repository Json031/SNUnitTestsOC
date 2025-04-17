//
//  SNUnitTestsTool.m
//
//  Created by MorganChen on 2025/4/17.
//  Copyright © 2025 MorganChen. All rights reserved.
//https://github.com/Json031/SNUnitTestsOC
//

#import "SNUnitTestsTool.h"

@implementation SNUnitTestsTool

+ (void)xctAssertEqualWithResult:(id)result
                        expected:(id)expected
                    failMessage:(NSString *)failMessage {
    if (failMessage) {
        XCTAssertEqualObjects(result, expected, @"%@", failMessage);
    } else {
        XCTAssertEqualObjects(result, expected, @"返回值与预期不一致 The return value is inconsistent with the expected value");
    }
}

+ (XCTestExpectation *)createXCTestExpectationWithDescription:(NSString *)description
                                                   iterations:(NSInteger)iterations {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:description];
    expectation.expectedFulfillmentCount = iterations;
    return expectation;
}

@end
