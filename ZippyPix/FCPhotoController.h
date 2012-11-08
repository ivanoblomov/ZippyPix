//
//  FCPhotoViewController.h
//  PassportPix
//
//  Created by Roderick Monje on 8/22/12.
//  Copyright (c) 2012 Fovea Central. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WAG_CheckoutContext.h"

#define FCWalgreensAffiliateID @"extest1"
#define FCWalgreensAPIKey @"c71dcd5d741fed1ac3f5bb300eff48c2"
#define FCWalgreensEnvironment 0
#define FCWalgreensProductGroupID @""
#define FCWalgreensPublisherID @"5981781"

@class FCPhotoController;

@interface FCPhotoController : UIViewController <CheckoutDelegate, UIActionSheetDelegate, UIGestureRecognizerDelegate, UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cameraItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *walgreensItem;
@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapRecognizer;
@property (strong, nonatomic) IBOutlet UITextView *printWarningTextView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UIWebView *aWebView;
@property (strong, nonatomic) WAG_CheckoutContext *walgreensCheckout;
@property (weak, nonatomic) NSDictionary *mediaInfo;
@property (weak, nonatomic) NSURL *selectedImageURL;

- (IBAction)printToWalgreens:(id)sender;
- (IBAction)showCamera:(id)sender;
- (IBAction)toggleControls:(id)sender;

@end
