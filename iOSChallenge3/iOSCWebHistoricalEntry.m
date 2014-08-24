//
//  iOSCWebHistoricalEntry.m
//  iOSChallenge3
//
//  Created by Freddy on 8/23/14.
//  Copyright (c) 2014 freddy. All rights reserved.
//

#import "iOSCWebHistoricalEntry.h"

@implementation iOSCWebHistoricalEntry

#pragma mark - Initalization
- (instancetype)initWithSearchEntry:(NSString *)searchBarText{
    return [self initWithSearchEntry:searchBarText forDate:[NSDate date]];
}

- (instancetype)initWithSearchEntry:(NSString *)searchBarText forDate:(NSDate *)date {
    self = [super init];
    if (self) {
        _searchBarEntry = searchBarText;
        _searchedDate   = date;
    }
    return self;
}

- (void)setSearchBarEntry:(NSString *)searchBarEntry{
    
}
@end
