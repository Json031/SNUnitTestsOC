//
//  SNUITestsTool.h
//
//  Created by MorganChen on 2025/4/16.
//  Copyright © 2025 MorganChen. All rights reserved.
//https://github.com/Json031/SNUnitTestsOC
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface SNUITestsTool : NSObject

+ (UITableView *)queryTableViewFromVC:(UIViewController *)viewController;
+ (UIView *)queryViewFromTag:(UIViewController *)viewController tag:(NSInteger)tag;
+ (UIButton *)queryBtnFromTag:(UIViewController *)viewController tag:(NSInteger)tag;
+ (UILabel *)queryLabFromTag:(UIViewController *)viewController tag:(NSInteger)tag;

+ (BOOL)tableViewClickIndexPath:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
+ (BOOL)clickBtnAtTag:(UIViewController *)viewController tag:(NSInteger)tag;
+ (BOOL)detectViewIsInViewControllerHierarchy:(UIViewController *)viewController viewClass:(Class)viewClass;
+ (BOOL)hasPushPage:(UIViewController *)viewController nextPageClass:(Class)nextPageClass;
+ (void)detectPop:(UIViewController *)viewController initialVCCount:(NSInteger)initialVCCount;
+ (BOOL)pollingLabelTextWithTestCase:(XCTestCase *)testCase viewController:(UIViewController *)viewController tag:(NSInteger)tag expectedText:(NSString *)expectedText timeOut:(NSUInteger)timeOut;

@end
