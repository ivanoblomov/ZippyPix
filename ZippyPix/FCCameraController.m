//
//  FCViewController.m
//  ZippyPix
//
//  Created by Roderick Monje on 11/1/12.
//  Copyright (c) 2012 Roderick Monje. All rights reserved.
//

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#import "FCCameraController.h"

@interface FCCameraController ()

@end

@implementation FCCameraController

#pragma mark - Camera

- (BOOL)startCameraControllerFromViewController:(UIViewController*)controller
                                   usingDelegate:(id <UIImagePickerControllerDelegate, UINavigationControllerDelegate>) delegate {
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.allowsEditing = NO;
    cameraUI.delegate = delegate;
    cameraUI.sourceType = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary;
    cameraUI.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:cameraUI.sourceType];
    [controller presentModalViewController:cameraUI animated:NO];
    isShowingCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    return YES;
}

#pragma mark - Image picker

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if (isShowingCamera)
        UIImageWriteToSavedPhotosAlbum([info objectForKey:UIImagePickerControllerOriginalImage], nil, nil , nil);
    FCPhotoController *pvc = (FCPhotoController *) [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle: nil] instantiateViewControllerWithIdentifier: @"photoController"];
    pvc.mediaInfo = info;
    [picker pushViewController:pvc animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if (! [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        return;

    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];

    if (isShowingCamera) {
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    } else {
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }

    isShowingCamera = ! isShowingCamera;
}

#pragma mark - View lifecycle

- (void)viewDidAppear:(BOOL)animated {
<<<<<<< HEAD
=======
    [super viewDidAppear:animated];
>>>>>>> launch-image transition is seamless: no flash, no status bar
    [self startCameraControllerFromViewController:self usingDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (! IS_WIDESCREEN)
        [self backgroundImage].image = [UIImage imageNamed:@"Default.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setBackgroundImage:nil];
    [super viewDidUnload];
}
@end
