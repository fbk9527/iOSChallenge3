//
//  iOSCWebHistoricalEntry.h
//  iOSChallenge3
//
//  Created by Freddy on 8/23/14.
//  Copyright (c) 2014 freddy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ENUM(NSUInteger, _IOSCWebEntryType){
    IOSWebEntryTypeSearch = 0,
    IOSWebEntryTypeWebAddress
};
typedef enum _IOSCWebEntryType IOSCWebEntryType;

@interface iOSCWebHistoricalEntry : NSObject
@property(nonatomic,strong) NSString* searchBarEntry;
@property(nonatomic,strong) NSDate* searchedDate;
@property(nonatomic,assign,readonly) IOSCWebEntryType entry;

- (instancetype)initWithSearchEntry:(NSString*)searchBarText;
- (instancetype)initWithSearchEntry:(NSString *)searchBarText forDate:(NSDate*)date;
@end
