//
//  SNUnitTestsTool.h
//
//  Created by MorganChen on 2025/4/17.
//  Copyright © 2025 MorganChen. All rights reserved.
//https://github.com/Json031/SNUnitTestsOC
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNUnitTestsTool : NSObject

+ (void)xctAssertEqualWithResult:(id)result
                        expected:(id)expected
                    failMessage:(nullable NSString *)failMessage;

+ (XCTestExpectation *)createXCTestExpectationWithDescription:(NSString *)description
                                                   iterations:(NSInteger)iterations;

@end

NS_ASSUME_NONNULL_END
