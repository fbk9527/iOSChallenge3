//
//  iOSCWebViewController.h
//  iOSChallenge3
//
//  Created by Freddy on 8/23/14.
//  Copyright (c) 2014 freddy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iOSCSearchHistoryTableViewController.h"

#ifdef DEBUG
#define PRINTFUNCTION NSLog(@"%s",__PRETTY_FUNCTION__);
#define PRINTSCROLLING(P) NSLog(@"X: %f Y:%f",P.x, P.y);
#else
#define PRINTFUNCTION
#define PRINTSCROLLING(x)
#endif
@interface iOSCWebViewController : UIViewController <iOSSearchHistoryDelegate, UIScrollViewDelegate>
@end
