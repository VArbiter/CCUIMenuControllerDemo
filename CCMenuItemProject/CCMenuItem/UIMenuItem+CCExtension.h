//
//  UIMenuItem+CCExtension.h
//  CCMenuItemProject
//
//  Created by CC on 12/05/2017.
//  Copyright © 2017 CC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIMenuItem (CCExtension)

@property (nonatomic , strong) NSMutableDictionary *dictionary ;

@property (nonatomic , assign) NSInteger integerCurrentIndex ;

@property (nonatomic , strong , readonly) NSString *stringKey ;

@end

#pragma mark - -----------------------------------------------------------------

@interface UIMenuController (CCExtension)

@property (nonatomic , assign , readonly) UIMenuItem *(^blockMenuItem)(NSInteger integerIndex) ;

@property (nonatomic , assign , readonly) NSInteger (^blockClickIndex)(NSString *stringTitle);

@end
