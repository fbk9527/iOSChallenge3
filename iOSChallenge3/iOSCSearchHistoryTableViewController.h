//
//  iOSCSearchHistoryTableViewController.h
//  iOSChallenge3
//
//  Created by Freddy on 8/23/14.
//  Copyright (c) 2014 freddy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class iOSCSearchHistoryTableViewController;
@protocol iOSSearchHistoryDelegate <NSObject>
- (void)iOSCSearchHistoryTableViewController:(iOSCSearchHistoryTableViewController*)controller
                             didSelectString:(NSString*)string;
@end

@interface iOSCSearchHistoryTableViewController : UITableViewController
@property (nonatomic, weak) id<iOSSearchHistoryDelegate> delegate;
@end
