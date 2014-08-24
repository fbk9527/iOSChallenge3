//
//  iOSCWebViewController.m
//  iOSChallenge3
//
//  Created by Freddy on 8/23/14.
//  Copyright (c) 2014 freddy. All rights reserved.
//


#import "iOSCWebViewController.h"

#define kTOOLBAR_FADEAT 10.0f
#define kTOOLBAR_FADETM 0.25f
#define kOPAQUE 1.0f
#define kTRANSPARENT 0.0f
#define kEMPTYSTRING @""


@interface iOSCWebViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;
@property (weak, nonatomic) IBOutlet UIToolbar *navigationBar;
@property (weak, nonatomic) IBOutlet UIWebView *webivew;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;
@property (weak, nonatomic) IBOutlet UIView *backingView;
@property (strong, nonatomic) iOSCSearchHistoryTableViewController *searchTableViewController;
@property (assign, nonatomic) BOOL showingToolbar;
@end


static NSString * kSearchStorboardId = @"HistoryAndSearchViewController";

@implementation iOSCWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Handle no history
    self.backButton.enabled = self.webivew.canGoBack;
    self.forwardButton.enabled = self.webivew.canGoForward;
    
    // Scrollview delegate
    self.webivew.scrollView.delegate = self;
    
    // Initially show toolbar
    self.showingToolbar = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - SearchBar Delegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    PRINTFUNCTION
    if (!self.searchTableViewController) {
        
        // Instantiate
        iOSCSearchHistoryTableViewController* controller = [[self storyboard] instantiateViewControllerWithIdentifier:kSearchStorboardId];
        
        // Correct frame
        CGRect offsetFrame = self.backingView.frame;
        CGRect controllerFrame = controller.view.frame;
        CGRect newFrame = CGRectMake(0.0f, offsetFrame.size.height, controllerFrame.size.width, controllerFrame.size.height - offsetFrame.size.height);
        
        self.searchTableViewController = controller;
        self.searchTableViewController.view.frame = newFrame;
        self.searchTableViewController.delegate = self;
    }
    [self.searchTableViewController.view setHidden:NO];
    [self.view addSubview:self.searchTableViewController.view];
    [self.searchbar setShowsCancelButton:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    PRINTFUNCTION
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    PRINTFUNCTION
    [self DismissSearchViewControllerOptionallyClearText:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    PRINTFUNCTION
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:[searchBar text]]];
    [self.webivew loadRequest:request];
    [self DismissSearchViewControllerOptionallyClearText:NO];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    PRINTFUNCTION
}





#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    PRINTFUNCTION
    [self refreshNavigationButtons];
    
    // Update address bar while loading
    [self updateSearchAddressBarWithNewLocation:webView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    PRINTFUNCTION
    [self refreshNavigationButtons];
    
    // Update address bar to reflect new location
    [self updateSearchAddressBarWithNewLocation:webView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    PRINTFUNCTION
    
    if (error) {
        // Display Error
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        [alert show];
    }
    [self refreshNavigationButtons];
}





#pragma mark - UISearchViewTableDelegate
- (void)iOSCSearchHistoryTableViewController:(iOSCSearchHistoryTableViewController *)controller
                             didSelectString:(NSString *)string
{
    PRINTFUNCTION
    
}


#pragma mark - Navigation Actions
- (IBAction)backButtonSelected:(UIBarButtonItem *)sender {
    PRINTFUNCTION
    if (sender.enabled) {
        [self.webivew goBack];
    }
}

- (IBAction)forwardButtonSelected:(UIBarButtonItem *)sender {
    PRINTFUNCTION
    if(sender.enabled){
        [self.webivew goForward];
    }
}





#pragma mark - Scrollview Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    PRINTFUNCTION
    CGPoint location = scrollView.contentOffset;
    PRINTSCROLLING(location)
    
    // Fade out
    if (self.showingToolbar && location.y > kTOOLBAR_FADEAT) {
        __weak UIToolbar* weak_toolbar = self.navigationBar;
        _showingToolbar = NO;
        [UIView animateWithDuration:kTOOLBAR_FADETM animations:^{
            weak_toolbar.alpha = kTRANSPARENT;
        }];
    }
    
    // Fade back in
    else if(!self.showingToolbar && location.y <= kTOOLBAR_FADEAT){
        __weak UIToolbar* weak_toolbar = self.navigationBar;
        _showingToolbar = YES;
        [UIView animateWithDuration:kTOOLBAR_FADETM animations:^{
            weak_toolbar.alpha = kOPAQUE;
        }];
    }
    
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    PRINTFUNCTION
}

#pragma mark - Helper Functions
-(void)DismissSearchViewControllerOptionallyClearText:(BOOL)clearText {
    UIView* tblView = [self.view viewWithTag:22];
    [tblView setHidden:YES];
    [self.view bringSubviewToFront:tblView];
    [tblView removeFromSuperview];
    [self.searchbar setShowsCancelButton:NO];
    [self.searchbar resignFirstResponder];
    [self.searchDisplayController setActive:NO];
    
    if (clearText) {
        self.searchbar.text = kEMPTYSTRING;
    }
}

-(void)refreshNavigationButtons{
    self.backButton.enabled = self.webivew.canGoBack;
    self.forwardButton.enabled = self.webivew.canGoForward;
}

-(void)updateSearchAddressBarWithNewLocation:(UIWebView*)webview {
    self.searchbar.text = [[[webview request]URL]description];
}
@end
