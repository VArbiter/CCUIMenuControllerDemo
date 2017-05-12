//
//  UIView+CCDynamicGenerateMethod.h
//  CCMenuItemProject
//
//  Created by CC on 12/05/2017.
//  Copyright © 2017 CC. All rights reserved.
//

#import "RCTMenuView.h"
#import "UIMenuItem+CCExtension.h"

@interface RCTMenuView (CCDynamicGenerateMethod)

@property (nonatomic , copy) void(^blockStringTitle)(NSString *stringTitle) ;
@property (nonatomic , class) NSArray *arrayKeys ;

#pragma mark - NOT FOR PRIMARY
- (void) _CC_DYNAMIC_METHOD_GENERATOR_IMPLEMENTATION_ : (id) sender  ;

@end
