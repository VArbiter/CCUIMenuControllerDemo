//
//  RCTMenuView.h
//  RCTExtension
//
//  Created by CC on 2017/4/19.
//  Copyright © 2017年 CC. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface RCTMenuView : UIView

@property (nonatomic , strong) NSArray <NSDictionary *> *arrayTitleItems ;

#pragma mark - EDIT BY CC
- (void) ccShowMenu : (CGRect) rectFrame;
- (void) ccClickAction : (void(^)(NSMutableDictionary *dictionaryValue ,
                                  NSString *stringKey ,
                                  NSString *stringValue ,
                                  NSInteger integerIndex)) blockClick
       withCloseAction : (dispatch_block_t) blockClose ;
@end
