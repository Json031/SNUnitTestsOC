//
//  SNUITestsTool.m
//
//  Created by MorganChen on 2025/4/16.
//  Copyright © 2025 MorganChen. All rights reserved.
//https://github.com/Json031/SNUnitTestsOC
//

#import "SNUITestsTool.h"

@implementation SNUITestsTool

+ (UITableView *)queryTableViewFromVC:(UIViewController *)viewController {
    for (UIView *subview in viewController.view.subviews) {
        if ([subview isKindOfClass:[UITableView class]]) {
            return (UITableView *)subview;
        }
    }
    XCTFail(@"viewController's tableView is nil");
    return nil;
}

+ (UIView *)queryViewFromTag:(UIViewController *)viewController tag:(NSInteger)tag {
    return [self findViewWithTag:viewController.view tag:tag];
}

+ (UIButton *)queryBtnFromTag:(UIViewController *)viewController tag:(NSInteger)tag {
    return (UIButton *)[self queryViewFromTag:viewController tag:tag];
}

+ (UILabel *)queryLabFromTag:(UIViewController *)viewController tag:(NSInteger)tag {
    return (UILabel *)[self queryViewFromTag:viewController tag:tag];
}

+ (UIView *)findViewWithTag:(UIView *)view tag:(NSInteger)tag {
    if (view.tag == tag) return view;
    for (UIView *subview in view.subviews) {
        UIView *found = [self findViewWithTag:subview tag:tag];
        if (found) return found;
    }
    return nil;
}

+ (BOOL)tableViewClickIndexPath:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    NSInteger numberOfSections = [tableView numberOfSections];
    XCTAssertTrue(numberOfSections > indexPath.section, @"TableView requires at least %ld sections", (long)indexPath.section);
    if (numberOfSections <= indexPath.section) return NO;
    
    NSInteger numberOfRows = [tableView numberOfRowsInSection:indexPath.section];
    XCTAssertTrue(numberOfRows > indexPath.row, @"TableView requires at least %ld rows", (long)indexPath.row);
    if (numberOfRows <= indexPath.row) return NO;

    if ([tableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [tableView.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    return YES;
}

+ (BOOL)clickBtnAtTag:(UIViewController *)viewController tag:(NSInteger)tag {
    UIButton *btn = [self queryBtnFromTag:viewController tag:tag];
    XCTAssertNotNil(btn, @"viewController's btn is nil");
    [btn sendActionsForControlEvents:UIControlEventTouchUpInside];
    return btn != nil;
}

+ (BOOL)detectViewIsInViewControllerHierarchy:(UIViewController *)viewController viewClass:(Class)viewClass {
    for (UIView *sub in viewController.view.subviews) {
        if ([sub isKindOfClass:viewClass]) {
            return YES;
        }
    }
    XCTFail(@"The view should be present in the view hierarchy");
    return NO;
}

+ (BOOL)hasPushPage:(UIViewController *)viewController nextPageClass:(Class)nextPageClass {
    UINavigationController *nav = viewController.navigationController;
    if (nav) {
        UIViewController *topVC = nav.topViewController;
        if (topVC == viewController) {
            XCTFail(@"Should redirect to a new page");
            return NO;
        }
        BOOL isCorrect = [topVC isKindOfClass:nextPageClass];
        XCTAssertTrue(isCorrect, @"Redirected VC should be %@, but got %@", NSStringFromClass(nextPageClass), NSStringFromClass([topVC class]));
        return isCorrect;
    }
    return NO;
}

+ (void)detectPop:(UIViewController *)viewController initialVCCount:(NSInteger)initialVCCount {
    UINavigationController *nav = viewController.navigationController;
    if (!nav) {
        XCTFail(@"viewController is not in UINavigationController");
        return;
    }
    XCTAssertEqual(nav.viewControllers.count, initialVCCount - 1, @"Navigation pop failed");
}

+ (BOOL)pollingLabelTextWithTestCase:(XCTestCase *)testCase viewController:(UIViewController *)viewController tag:(NSInteger)tag expectedText:(NSString *)expectedText timeOut:(NSUInteger)timeOut {
    UILabel *label = [self queryLabFromTag:viewController tag:tag];
    XCTAssertNotNil(label, @"UILabel not found");

    NSDate *start = [NSDate date];
    while ([[NSDate date] timeIntervalSinceDate:start] < timeOut) {
        if ([label.text isEqualToString:expectedText]) {
            return YES;
        }
        [NSThread sleepForTimeInterval:0.5];
    }
    BOOL isEqual = [label.text isEqualToString:expectedText];
    XCTAssertTrue(isEqual, @"Label text should become %@ within %lu seconds", expectedText, (unsigned long)timeOut);
    return isEqual;
}

@end
