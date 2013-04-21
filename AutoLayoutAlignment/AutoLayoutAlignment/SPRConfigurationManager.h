//
//  SPRConfigurationManager.h
//  AutoLayoutAlignment
//
//  Created by Scott Robertson on 4/21/13.
//  Copyright (c) 2013 Scott Robertson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPRConfigurationManager : NSObject

+ (SPRConfigurationManager *)defaultManager;

@property (nonatomic,readwrite) NSLayoutFormatOptions verticalAlignment;
@property (nonatomic,readwrite) NSLayoutFormatOptions horizontalAlignment;
@property (nonatomic,readwrite) NSLayoutFormatOptions direction;
@property (nonatomic,readwrite,getter = shouldAlignWithSuperview) BOOL alignWithSuperview;

@end
