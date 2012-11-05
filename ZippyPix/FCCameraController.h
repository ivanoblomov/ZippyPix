//
//  FCViewController.h
//  ZippyPix
//
//  Created by Roderick Monje on 11/1/12.
//  Copyright (c) 2012 Roderick Monje. All rights reserved.
//

#import <MobileCoreServices/UTCoreTypes.h>
#import <UIKit/UIKit.h>
#import "WAG_CheckoutContext.h"

@interface FCCameraController : UIViewController <CheckoutDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    BOOL isShowingCamera;
}

@end
