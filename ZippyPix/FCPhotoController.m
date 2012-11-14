//
//  FCPhotoViewController.m
//  PassportPix
//
//  Created by Roderick Monje on 8/22/12.
//  Copyright (c) 2012 Fovea Central. All rights reserved.
//

#import "FCPhotoController.h"

@implementation FCPhotoController

#pragma mark - Main

- (void)showError:(NSString *)title withMessage:(NSString *)message {
    [[self activityIndicatorView] stopAnimating];
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:self
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (IBAction)showCamera:(id)sender {
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (IBAction)toggleControls:(id)sender {
    BOOL isShowingControls = ! [self toolbar].hidden;
    [[UIApplication sharedApplication] setStatusBarHidden:isShowingControls withAnimation:UIStatusBarAnimationFade];
    [[self navigationController] setNavigationBarHidden:isShowingControls animated:YES];
    [[self toolbar] setHidden:isShowingControls];
}

#pragma mark - View lifecycle

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self photoImageView] setImage:[[self mediaInfo] objectForKey:UIImagePickerControllerOriginalImage]];
    [self setSelectedImageURL:[[self mediaInfo] objectForKey:UIImagePickerControllerReferenceURL]];
    [self walgreensCheckout];
    [[self photoImageView] addGestureRecognizer:[self tapRecognizer]];
    [[self tapRecognizer] setDelegate:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setActivityIndicatorView:nil];
    [self setAWebView:nil];
    [self setCameraItem:nil];
    [self setMediaInfo:nil];
    [self setPhotoImageView:nil];
    [self setProgressView:nil];
    [self setSelectedImageURL:nil];
    [self setTapRecognizer:nil];
    [self setToolbar:nil];
    [self setWalgreensCheckout:nil];
    [self setWalgreensItem:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
}

#pragma mark - Walgreens

- (void)cartPosterErrorResponse:(NSString*)response{
    NSLog(@"Cart responded with error %@!", response);
}

- (void)cartPosterSuccessResponse:(NSString*)response{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [self loadWebView:response];
}

- (void)didCartPostFailWithError:(NSError *)error {
    [self showError:@"Walgreens Error" withMessage:error.localizedDescription];
}

- (void)didFinishBatch {
    [[self progressView] setHidden:YES];
    @try {
        [[self walgreensCheckout] postCart];
    } @catch (NSException *exception) {
        [self showError:@"Walgreens Error" withMessage:@"Can't submit your print order. Please check your network connection and try again."];
        [self setWalgreensCheckout:nil];
        NSLog(@"Error posting cart: %@", exception.debugDescription);
    }
}

- (void)didInitFailWithError:(NSError *)error {
    NSLog(@"Failed to connect to Walgreens with error: %@", error.localizedDescription);
}

- (void)getUploadProgress:(float)progress {
    [[self progressView] setHidden:NO];
    [[self progressView] setProgress:progress];
}

- (void)imageuploadErrorWithImageData:(WAG_ImageData *)imageData  Error:(NSError *)error {
    NSLog(@"Error uploading image with error: %@", error.localizedDescription);
}

- (void)imageuploadSuccessWithImageData:(WAG_ImageData *)imageData {
}

- (void)initErrorResponse:(NSString *)response {
    NSLog(@"Failed to connect to Walgreens with response %@!", response);
}

- (void)initSuccessResponse:(NSString*)response {
}

- (IBAction)printToWalgreens:(id)sender {
    [[self cameraItem] setEnabled:NO];
    [[self walgreensItem] setEnabled:NO];
    [[self walgreensCheckout] upload:UIImageJPEGRepresentation([[self photoImageView] image], 1.0)];
}

- (WAG_CheckoutContext *)walgreensCheckout {
    if (! _walgreensCheckout) {
        _walgreensCheckout = [[WAG_CheckoutContext alloc] initWithAffliateId:FCWalgreensAffiliateID
                                                                     apiKey:FCWalgreensAPIKey
                                                                environment:FCWalgreensEnvironment
                                                                 appVersion:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
                                                             ProductGroupID:FCWalgreensProductGroupID
                                                                PublisherID:FCWalgreensPublisherID];
        [_walgreensCheckout setDelegate:self];
        [[self walgreensItem] setEnabled:YES];
    }
    return _walgreensCheckout;
}

#pragma mark - Web View

- (void)hideWebView{
    [[self aWebView] stopLoading];
    [[self aWebView] setHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)loadWebView:(NSString *)aURL {
    [[self activityIndicatorView] startAnimating];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [[self aWebView] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:aURL]]];
    [[self aWebView] setDelegate:self];
}

- (BOOL)url:(NSURL *)url containsString:(NSString *)string {
    return [[url absoluteString] rangeOfString:string].location != NSNotFound;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"Failed to load web view with error: %@", error.localizedDescription);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    if ([self url:[request URL] containsString:@"QP_BACK:"] ||
        [self url:[request URL] containsString:@"QP_ERROR:"] ||
        [self url:[request URL] containsString:@"QP_DONE:DONE"] ||
        [self url:[request URL] containsString:@"QP_CANCEL:"]) {
        if ([self url:[request URL] containsString:@"QP_CANCEL:"] || [self url:[request URL] containsString:@"QP_DONE:DONE"])
            [[self walgreensCheckout] clearImageQueue];
        [self hideWebView];
        [[self cameraItem] setEnabled:YES];
        [[self walgreensItem] setEnabled:YES];
		return NO;
	}

	return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[self activityIndicatorView] stopAnimating];
    [[self aWebView] setHidden:NO];
}

@end
