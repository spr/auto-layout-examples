//
//  SPRConfigurationManager.m
//  AutoLayoutAlignment
//
//  Created by Scott Robertson on 4/21/13.
//  Copyright (c) 2013 Scott Robertson. All rights reserved.
//

#import "SPRConfigurationManager.h"

@implementation SPRConfigurationManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _verticalAlignment = NSLayoutFormatAlignAllLeft;
        _horizontalAlignment = NSLayoutFormatAlignAllTop;
        _direction = NSLayoutFormatDirectionLeadingToTrailing;
        _alignWithSuperview = YES;
    }
    return self;
}


+ (SPRConfigurationManager *)defaultManager {
    static SPRConfigurationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SPRConfigurationManager alloc] init];
    });
    return manager;
}

@end
