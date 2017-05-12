//
//  ViewController.m
//  CCMenuItemProject
//
//  Created by 冯明庆 on 12/05/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

#import "ViewController.h"
#import "RCTMenuView.h"

@interface ViewController ()

- (void) ccTapGRAction : (UITapGestureRecognizer *) sender ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(ccTapGRAction:)];
    [self.view addGestureRecognizer:tapGR];
}

- (void) ccTapGRAction : (UITapGestureRecognizer *) sender {
    __block RCTMenuView *menuView = [[RCTMenuView alloc] init];
    [self.view addSubview:menuView];
    
    [menuView ccClickAction:^(NSMutableDictionary *dictionaryValue, NSString *stringKey, NSString *stringValue) {
        NSLog(@"\n%@ - %@ - %@" , stringKey , stringValue , dictionaryValue);
    } withCloseAction:^{
        menuView = nil; // Destory
    }];
    
    CGRect rect = self.view.frame;
    [menuView ccShowMenu:CGRectMake(rect.size.width * .5f,
                                    rect.size.height * .5f,
                                    rect.size.width * .5f,
                                    rect.size.height * .5f)];
}

@end
