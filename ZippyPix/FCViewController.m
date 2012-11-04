//
//  FCViewController.m
//  ZippyPix
//
//  Created by Roderick Monje on 11/1/12.
//  Copyright (c) 2012 Roderick Monje. All rights reserved.
//

#import "FCViewController.h"

@interface FCViewController ()

@end

@implementation FCViewController

#pragma mark - Camera

- (IBAction)showCameraUI {
    [self startCameraControllerFromViewController:self usingDelegate:self];
}

- (BOOL)startCameraControllerFromViewController:(UIViewController*)controller
                                   usingDelegate:(id <UIImagePickerControllerDelegate, UINavigationControllerDelegate>) delegate {
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.allowsEditing = NO;
    cameraUI.delegate = delegate;
    cameraUI.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    [controller presentModalViewController:cameraUI animated:NO];
    return YES;
}

#pragma mark - Image picker

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage;

    // Handle still image
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
        editedImage = (UIImage *) [info objectForKey:UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImageWriteToSavedPhotosAlbum ((editedImage) ? editedImage : originalImage, nil, nil , nil);
    }

    // Handle movie
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        NSString *moviePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath))
            UISaveVideoAtPathToSavedPhotosAlbum(moviePath, nil, nil, nil);
    }

    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidAppear:(BOOL)animated {
    [self showCameraUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
