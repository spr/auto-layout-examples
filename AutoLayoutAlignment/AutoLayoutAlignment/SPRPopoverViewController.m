//
//  SPRPopoverViewController.m
//  AutoLayoutAlignment
//
//  Created by Scott Robertson on 4/21/13.
//  Copyright (c) 2013 Scott Robertson. All rights reserved.
//

#import "SPRPopoverViewController.h"

#import "SPRConfigurationManager.h"

@interface SPRPopoverViewController ()

@property (nonatomic,strong) NSArray *horizontalChoices;
@property (nonatomic,strong) NSArray *verticalChoices;
@property (nonatomic,strong) NSArray *directionChoices;

@end

typedef NS_ENUM(NSInteger, kPopoverSections) {
    kPopoverSectionsVertical,
    kPopoverSectionsHorizontal,
    kPopoverSectionsDirection,
    kPopoverSectionsSuperview
};

@implementation SPRPopoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.verticalChoices = @[@(NSLayoutFormatAlignAllLeft), @(NSLayoutFormatAlignAllRight), @(NSLayoutFormatAlignAllLeading), @(NSLayoutFormatAlignAllTrailing), @(NSLayoutFormatAlignAllCenterX)];
    self.horizontalChoices = @[@(NSLayoutFormatAlignAllTop), @(NSLayoutFormatAlignAllBottom), @(NSLayoutFormatAlignAllCenterY), @(NSLayoutFormatAlignAllBaseline)];
    self.directionChoices = @[@(NSLayoutFormatDirectionLeadingToTrailing), @(NSLayoutFormatDirectionLeftToRight), @(NSLayoutFormatDirectionRightToLeft)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    SPRConfigurationManager *configuration = [SPRConfigurationManager defaultManager];
    switch (indexPath.section) {
        case kPopoverSectionsVertical:
        {
            NSLayoutFormatOptions currentVertical = configuration.verticalAlignment;
            if (indexPath.row == [self.verticalChoices indexOfObject:@(currentVertical)]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            break;
        }
        case kPopoverSectionsHorizontal:
        {
            NSLayoutFormatOptions currentHorizontal = configuration.horizontalAlignment;
            if (indexPath.row == [self.horizontalChoices indexOfObject:@(currentHorizontal)]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            break;
        }
        case kPopoverSectionsSuperview:
        {
            if (configuration.shouldAlignWithSuperview && indexPath.row == 0) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else if (!configuration.shouldAlignWithSuperview && indexPath.row == 1) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            break;
        }
        case kPopoverSectionsDirection:
        {
            NSLayoutFormatOptions currentDirection = configuration.direction;
            if (indexPath.row == [self.directionChoices indexOfObject:@(currentDirection)]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            break;
        }
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPRConfigurationManager *configuration = [SPRConfigurationManager defaultManager];
    switch (indexPath.section) {
        case kPopoverSectionsVertical:
            configuration.verticalAlignment = [(NSNumber *)self.verticalChoices[indexPath.row] integerValue];
            break;
        case kPopoverSectionsHorizontal:
            configuration.horizontalAlignment = [(NSNumber *)self.horizontalChoices[indexPath.row] integerValue];
            break;
        case kPopoverSectionsDirection:
            configuration.direction = [(NSNumber *)self.directionChoices[indexPath.row] integerValue];
            break;
        case kPopoverSectionsSuperview:
            configuration.alignWithSuperview = (indexPath.row == 0);
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadData];
}

@end
