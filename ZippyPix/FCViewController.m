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

- (BOOL)startCameraControllerFromViewController:(UIViewController*) controller
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
