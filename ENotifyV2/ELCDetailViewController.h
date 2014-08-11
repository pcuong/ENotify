//
//  ELCDetailViewController.h
//  ENotifyV2
//
//  Created by Cuong Pham Ngoc on 8/11/14.
//  Copyright (c) 2014 PCuong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELCDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
