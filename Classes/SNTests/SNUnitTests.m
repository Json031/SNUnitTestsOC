//
//  SNUnitTests.m
//
//  Created by MorganChen on 2025/4/17.
//  Copyright © 2025 MorganChen. All rights reserved.
//https://github.com/Json031/SNUnitTestsOC
//

#import "SNUnitTests.h"
#import "SNUnitTestsTool.h"

@implementation SNUnitTests

- (id)getMethodResultWithClass:(Class)classType
                        method:(id (^)(id instance))method
                         param:(id)param {
    id instance = [[classType alloc] init];
    id (^methodWithParam)(id) = method(instance);
    return methodWithParam(param);
}

- (id)getClassMethodResult:(id (^)(id _Nullable))method
                    param:(id)param {
    return method(param);
}

- (void)testMethodCallWithClass:(Class)classType
                         method:(id (^)(id instance))method
                          param:(id)param
                       expected:(id)expected
                    failMessage:(NSString *)failMessage {
    id result = [self getMethodResultWithClass:classType method:method param:param];
    [SNUnitTestsTool xctAssertEqualWithResult:result expected:expected failMessage:failMessage];
}

- (void)testClassMethodCall:(id (^)(id _Nullable))method
                      param:(id)param
                   expected:(id)expected
                failMessage:(NSString *)failMessage {
    id result = [self getClassMethodResult:method param:param];
    [SNUnitTestsTool xctAssertEqualWithResult:result expected:expected failMessage:failMessage];
}

- (void)highConcurrencyUnitTestingForClassMethodWithIterations:(NSInteger)iterations
                                                timeoutSeconds:(NSTimeInterval)timeoutSeconds
                                                    classType:(Class)classType
                                                       method:(id (^)(id instance))method
                                                        param:(id)param
                                                     expected:(id)expected
                                                      verbose:(BOOL)verbose {
    XCTestExpectation *expectation = [SNUnitTestsTool createXCTestExpectationWithDescription:@"High concurrency unit testing for class method checks" iterations:iterations];

    NSLock *lock = [[NSLock alloc] init];
    NSMutableArray<NSNumber *> *failedIndices = [NSMutableArray array];

    dispatch_apply(iterations, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
        id result = [self getMethodResultWithClass:classType method:method param:param];
        if (![result isEqual:expected]) {
            [lock lock];
            [failedIndices addObject:@(index)];
            [lock unlock];
            if (verbose) {
                NSLog(@"❌ Mismatch at index %zu, expected: %@, but got: %@", index, expected, result);
            }
        } else {
            if (verbose) {
                NSLog(@"✅ Match at index %zu", index);
            }
        }
        [expectation fulfill];
    });

    [self waitForExpectations:@[expectation] timeout:timeoutSeconds];
    XCTAssertTrue(failedIndices.count == 0, @"Failures occurred at indices: %@", failedIndices);
}

@end
