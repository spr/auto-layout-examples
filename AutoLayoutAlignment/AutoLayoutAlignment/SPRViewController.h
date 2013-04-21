//
//  SPRViewController.h
//  AutoLayoutAlignment
//
//  Created by Scott Robertson on 4/21/13.
//  Copyright (c) 2013 Scott Robertson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPRViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *verticalView;
@property (weak, nonatomic) IBOutlet UIView *horizontalView;

@property (weak, nonatomic) IBOutlet UILabel *verticalConstraints;
@property (weak, nonatomic) IBOutlet UILabel *horizontalConstraints;

- (IBAction)logAutolayoutTrace:(id)sender;
@end
