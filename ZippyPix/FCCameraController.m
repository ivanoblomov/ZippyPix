//
//  FCViewController.m
//  ZippyPix
//
//  Created by Roderick Monje on 11/1/12.
//  Copyright (c) 2012 Roderick Monje. All rights reserved.
//

#import "FCCameraController.h"

@interface FCCameraController ()

@end

@implementation FCCameraController

#pragma mark - Camera

- (IBAction)showCameraUI {
    [self startCameraControllerFromViewController:self usingDelegate:self];
}

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
    FCPhotoController *pvc = (FCPhotoController *) [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle: nil] instantiateViewControllerWithIdentifier: @"photoController"];
    pvc.mediaInfo = info;
    [picker pushViewController:pvc animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if (! [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        return;

    if (isShowingCamera) {
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    } else {
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }

    isShowingCamera = ! isShowingCamera;
}

#pragma mark - Media browser

- (IBAction)showSavedMediaBrowser {
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}

- (BOOL)startMediaBrowserFromViewController:(UIViewController*) controller
               usingDelegate:(id <UIImagePickerControllerDelegate, UINavigationControllerDelegate>) delegate {

    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
            || (delegate == nil)
            || (controller == nil))
        return NO;

    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.allowsEditing = NO;
    mediaUI.delegate = delegate;
    mediaUI.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:mediaUI animated:YES completion:nil];
    return YES;
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
