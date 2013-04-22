//
//  SPRViewController.m
//  AutoLayoutAlignment
//
//  Created by Scott Robertson on 4/21/13.
//  Copyright (c) 2013 Scott Robertson. All rights reserved.
//

#import "SPRViewController.h"

#import "SPRConfigurationManager.h"

#import <QuartzCore/QuartzCore.h>

@interface SPRViewController ()

@property (nonatomic,strong) UILabel *vertTop;
@property (nonatomic,strong) UILabel *vertMid;
@property (nonatomic,strong) UILabel *vertBot;

@property (nonatomic,strong) NSArray *activeVerticalConstraints;
@property (nonatomic,strong) NSLayoutConstraint *superviewVerticalAlignmentConstraint;

@property (nonatomic,strong) UILabel *horizFront;
@property (nonatomic,strong) UILabel *horizMid;
@property (nonatomic,strong) UILabel *horizEnd;

@property (nonatomic,strong) NSArray *activeHorizontalConstraints;
@property (nonatomic,strong) NSLayoutConstraint *superviewHorizontalAlignmentConstraint;

@end

@implementation SPRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.verticalView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.verticalView.layer.borderWidth = 2.0f;
    
    self.horizontalView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.horizontalView.layer.borderWidth = 2.0f;
    
    // Prep the subviews
    self.vertTop = [[UILabel alloc] init];
    self.vertTop.translatesAutoresizingMaskIntoConstraints = NO;
    self.vertTop.backgroundColor = [UIColor orangeColor];
    self.vertTop.text = @"Top View";
    [self.verticalView addSubview:self.vertTop];
    
    self.vertMid = [[UILabel alloc] init];
    self.vertMid.translatesAutoresizingMaskIntoConstraints = NO;
    self.vertMid.backgroundColor = [UIColor purpleColor];
    self.vertMid.text = @"Middle View";
    self.vertMid.font = [UIFont systemFontOfSize:26.0f];
    [self.verticalView addSubview:self.vertMid];
    
    self.vertBot = [[UILabel alloc] init];
    self.vertBot.translatesAutoresizingMaskIntoConstraints = NO;
    self.vertBot.backgroundColor = [UIColor cyanColor];
    self.vertBot.text = @"Bottom View";
    [self.verticalView addSubview:self.vertBot];
    [self setupVerticalView];
    
    self.horizFront = [[UILabel alloc] init];
    self.horizFront.translatesAutoresizingMaskIntoConstraints = NO;
    self.horizFront.backgroundColor = [UIColor orangeColor];
    self.horizFront.text = @"Leading View";
    [self.horizontalView addSubview:self.horizFront];
    
    self.horizMid = [[UILabel alloc] init];
    self.horizMid.translatesAutoresizingMaskIntoConstraints = NO;
    self.horizMid.backgroundColor = [UIColor purpleColor];
    self.horizMid.text = @"Middle View";
    self.horizMid.font = [UIFont systemFontOfSize:26.0f];
    [self.horizontalView addSubview:self.horizMid];
    
    self.horizEnd = [[UILabel alloc] init];
    self.horizEnd.translatesAutoresizingMaskIntoConstraints = NO;
    self.horizEnd.backgroundColor = [UIColor cyanColor];
    self.horizEnd.text = @"Trailing View";
    [self.horizontalView addSubview:self.horizEnd];
    [self setupHorizontalView];
    
    // KVO
    SPRConfigurationManager *configuration = [SPRConfigurationManager defaultManager];
    [configuration addObserver:self forKeyPath:@"verticalAlignment" options:NSKeyValueObservingOptionNew context:nil];
    [configuration addObserver:self forKeyPath:@"horizontalAlignment" options:NSKeyValueObservingOptionNew context:nil];
    [configuration addObserver:self forKeyPath:@"direction" options:NSKeyValueObservingOptionNew context:nil];
    [configuration addObserver:self forKeyPath:@"alignWithSuperview" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logAutolayoutTrace:(id)sender {
    id trace = [[[UIApplication sharedApplication] keyWindow] performSelector:@selector(_autolayoutTrace)];
    NSLog(@"%@", trace);
}

- (NSLayoutAttribute)attributeForOption:(NSLayoutFormatOptions)option {
    NSLayoutAttribute attribute = 0;
    switch (option) {
        case NSLayoutFormatAlignAllBaseline:
            attribute = NSLayoutAttributeBaseline;
            break;
        case NSLayoutFormatAlignAllBottom:
            attribute = NSLayoutAttributeBottom;
            break;
        case NSLayoutFormatAlignAllCenterX:
            attribute = NSLayoutAttributeCenterX;
            break;
        case NSLayoutFormatAlignAllCenterY:
            attribute = NSLayoutAttributeCenterY;
            break;
        case NSLayoutFormatAlignAllLeading:
            attribute = NSLayoutAttributeLeading;
            break;
        case NSLayoutFormatAlignAllLeft:
            attribute = NSLayoutAttributeLeft;
            break;
        case NSLayoutFormatAlignAllRight:
            attribute = NSLayoutAttributeRight;
            break;
        case NSLayoutFormatAlignAllTop:
            attribute = NSLayoutAttributeTop;
            break;
        case NSLayoutFormatAlignAllTrailing:
            attribute = NSLayoutAttributeTrailing;
            break;
        default:
            attribute = 0;
            break;
    }
    return attribute;
}

- (void)setupVerticalView {
    SPRConfigurationManager *configuration = [SPRConfigurationManager defaultManager];
    
    if (self.activeVerticalConstraints) {
        [self.verticalView removeConstraints:self.activeVerticalConstraints];
    }
    if (self.superviewVerticalAlignmentConstraint) {
        [self.verticalView removeConstraint:self.superviewVerticalAlignmentConstraint];
        self.superviewVerticalAlignmentConstraint = nil;
    }
    
    NSLayoutFormatOptions options = configuration.verticalAlignment | configuration.direction;
    NSString *verticalConstraints = @"V:|[vertTop][vertMid][vertBot]-(>=0)-|";
    
    NSDictionary *views = @{@"vertTop": self.vertTop, @"vertMid": self.vertMid, @"vertBot": self.vertBot};
    
    self.activeVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraints options:options metrics:nil views:views];
    
    if (configuration.shouldAlignWithSuperview) {
        NSLayoutAttribute attribute = [self attributeForOption:options & NSLayoutFormatAlignmentMask];
        self.superviewVerticalAlignmentConstraint = [NSLayoutConstraint constraintWithItem:self.vertTop attribute:attribute relatedBy:NSLayoutRelationEqual toItem:self.verticalView attribute:attribute multiplier:1.0f constant:0.0f];
    }
    
    [self.verticalView addConstraints:self.activeVerticalConstraints];
    if (self.superviewVerticalAlignmentConstraint) {
        [self.verticalView addConstraint:self.superviewVerticalAlignmentConstraint];
    }
    
    self.verticalConstraints.text = verticalConstraints;
    [self.verticalView setNeedsLayout];
    [self.verticalConstraints setNeedsDisplay];
}

- (void)setupHorizontalView {
    SPRConfigurationManager *configuration = [SPRConfigurationManager defaultManager];
    
    if (self.activeHorizontalConstraints) {
        [self.horizontalView removeConstraints:self.activeHorizontalConstraints];
    }
    if (self.superviewHorizontalAlignmentConstraint) {
        [self.horizontalView removeConstraint:self.superviewHorizontalAlignmentConstraint];
        self.superviewHorizontalAlignmentConstraint = nil;
    }
    
    NSLayoutFormatOptions options = configuration.horizontalAlignment | configuration.direction;
    NSString *horizontalConstraints = @"H:|[horizFront][horizMid][horizEnd]-(>=0)-|";
    
    NSDictionary *views = @{@"horizFront": self.horizFront, @"horizMid": self.horizMid, @"horizEnd": self.horizEnd};
    
    self.activeHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraints options:options metrics:nil views:views];
    
    if (configuration.shouldAlignWithSuperview) {
        NSLayoutAttribute attribute = [self attributeForOption:options & NSLayoutFormatAlignmentMask];
        self.superviewHorizontalAlignmentConstraint = [NSLayoutConstraint constraintWithItem:self.horizFront attribute:attribute relatedBy:NSLayoutRelationEqual toItem:self.horizontalView attribute:attribute multiplier:1.0f constant:0.0f];
    }
    
    [self.horizontalView addConstraints:self.activeHorizontalConstraints];
    if (self.superviewHorizontalAlignmentConstraint) {
        [self.horizontalView addConstraint:self.superviewHorizontalAlignmentConstraint];
    }
    
    self.horizontalConstraints.text = horizontalConstraints;
    [self.horizontalView setNeedsLayout];
    [self.horizontalConstraints setNeedsDisplay];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"verticalAlignment"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setupVerticalView];
        });
    }
    if ([keyPath isEqualToString:@"horizontalAlignment"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setupHorizontalView];
        });
    }
    if ([keyPath isEqualToString:@"direction"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setupHorizontalView];
        });
    }
    if ([keyPath isEqualToString:@"alignWithSuperview"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setupVerticalView];
            [self setupHorizontalView];
        });
    }
}

@end
