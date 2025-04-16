//
//  SNUITests.h
//
//  Created by MorganChen on 2025/4/16.
//  Copyright © 2025 MorganChen. All rights reserved.
//https://github.com/Json031/SNUnitTestsOC
//

#import <XCTest/XCTest.h>

@interface SNUITests : XCTestCase

+ (instancetype)createWithViewController:(UIViewController *)viewController;

- (void)setUpWithError;
- (BOOL)clickCellAtIndex:(NSIndexPath *)indexPath nextPageClass:(Class)nextPageClass newViewClass:(Class)newViewClass;
- (BOOL)clickBtnAtTag:(NSInteger)tag nextPageClass:(Class)nextPageClass newViewClass:(Class)newViewClass;
- (void)tapTabBarItemAtIndex:(NSInteger)index;
- (BOOL)pollingLabelTextWithTag:(NSInteger)tag expectedText:(NSString *)expectedText timeOut:(NSUInteger)timeOut;

@end
