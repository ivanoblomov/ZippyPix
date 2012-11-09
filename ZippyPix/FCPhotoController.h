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
#define FCWalgreensAPIKey @"9468e9a3078b1708e44343caec5231dc"
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
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UIWebView *aWebView;
@property (strong, nonatomic) NSDictionary *mediaInfo;
@property (strong, nonatomic) NSURL *selectedImageURL;
@property (strong, nonatomic) WAG_CheckoutContext *walgreensCheckout;

- (IBAction)printToWalgreens:(id)sender;
- (IBAction)showCamera:(id)sender;
- (IBAction)toggleControls:(id)sender;

@end
