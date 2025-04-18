//
//  SNUnitTests.h
//
//  Created by MorganChen on 2025/4/17.
//  Copyright © 2025 MorganChen. All rights reserved.
//https://github.com/Json031/SNUnitTestsOC
//

#import <XCTest/XCTest.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNUnitTests : XCTestCase

- (id)getMethodResultWithClass:(Class)classType
                        method:(id (^)(id instance))method
                         param:(nullable id)param;

- (id)getClassMethodResult:(id (^)(id _Nullable))method
                    param:(nullable id)param;

- (void)testMethodCallWithClass:(Class)classType
                         method:(id (^)(id instance))method
                          param:(nullable id)param
                       expected:(id)expected
                    failMessage:(nullable NSString *)failMessage;

- (void)testClassMethodCall:(id (^)(id _Nullable))method
                      param:(nullable id)param
                   expected:(id)expected
                failMessage:(nullable NSString *)failMessage;

- (void)highConcurrencyUnitTestingForClassMethodWithIterations:(NSInteger)iterations
                                                timeoutSeconds:(NSTimeInterval)timeoutSeconds
                                                       method:(id (^)(id _Nullable))method
                                                        param:(id)param
                                                     expected:(id)expected
                                                       verbose:(BOOL)verbose;

- (void)highConcurrencyUnitTestingForMethodWithIterations:(NSInteger)iterations
                                                timeoutSeconds:(NSTimeInterval)timeoutSeconds
                                                    classType:(Class)classType
                                                       method:(id (^)(id instance))method
                                                        param:(id)param
                                                     expected:(id)expected
                                                  verbose:(BOOL)verbose;

- (void)efficiencyPerformanceTesting:(NSInteger)iterations
                           threshold:(NSTimeInterval)threshold
                               block:(void (^)(void))block
                         failMessage:(nullable NSString *)failMessage;
@end

NS_ASSUME_NONNULL_END
