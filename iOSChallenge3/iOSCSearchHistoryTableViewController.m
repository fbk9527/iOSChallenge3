//
//  iOSCSearchHistoryTableViewController.m
//  iOSChallenge3
//
//  Created by Freddy on 8/23/14.
//  Copyright (c) 2014 freddy. All rights reserved.
//

#import "iOSCSearchHistoryTableViewController.h"

@interface iOSCSearchHistoryTableViewController ()
@end

@implementation iOSCSearchHistoryTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.history count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"history" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.history objectAtIndex:[indexPath row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Unselect row
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Inform webview of selection
    [self.delegate iOSCSearchHistoryTableViewController:self didSelectString:self.history[indexPath.row]];
}


#pragma mark - Lazy Loading
-(NSMutableArray*)history{
    if (!_history) {
        _history = [[NSMutableArray alloc]init];
    }
    return _history;
}


#pragma mark - Update Search Results
- (void)addSearchStringToHistory:(NSString *)searched
{
    if (![self.history containsObject:searched]) {
        [self.history addObject:searched];
    }
    [self.tableView reloadData];
}

-(void)filterSearchResultsBy:(NSString *)typedString
{
    
}
@end
