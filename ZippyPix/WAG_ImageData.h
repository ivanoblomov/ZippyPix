//
//  WAG_ImageData.h
//  QuickPrintsSDK
//
//  Created by Photon on 13/03/12.
/*
 * Copyright 2012 Walgreen Co. All rights reserved *
 * Licensed under the Walgreens Developer Program and Portal Terms of Use and API License Agreement, Version 1.0 (the “Terms of Use”)
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at https://developer.walgreens.com/page/terms-use
 *
 * This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing  permissions and limitations under the License.
 */

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

#define UploadStateInQueue @"UploadStateInQueue"  // In queue, waiting for uploading
#define UploadStateUploading @"UploadStateUploading"  // Uploading starts
#define UploadStateSuccess @"UploadStateSuccess"    // Successfully uploaded
#define UploadStateFailed @"UploadStateFailed"      // Upload failed (No Network or other)
#define UploadStateCancelled @"UploadStateCancelled"  // Cancelled the uploading process



@interface WAG_ImageData : NSObject{
    
    NSString    *uploadState;  // State of the uploading image  
    UIImage     *imgSource;    // If the image is of NSData , the value will be set to nil once it is uploaded to server because of memory issue. further modifiaction can be done using the image key

    ALAsset     *imgAsset;  // Local image reference
    NSString    *imageKey;  // Image key is to map with Image data object. 
        
}
@property (nonatomic, retain) NSString  *uploadState;
@property (nonatomic, retain) UIImage   *imgSource;
@property (nonatomic, retain) ALAsset   *imgAsset;
@property (nonatomic, retain) NSString  *imageKey;

@end
