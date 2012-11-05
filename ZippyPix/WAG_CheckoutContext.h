//
//  CheckoutContext.h
//  QuickPrintsSDK
//
//  Created by Photon on 22/12/11.
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
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "WAG_ImageData.h"

@protocol CheckoutDelegate 

// INIT 
/**
 * ... This will be called when the authentication is success ...
 */
-(void) initSuccessResponse:(NSString*)response;

/**
 * ... This will be called when the authentication is failure ...
 */
-(void) didInitFailWithError:(NSError *)error;

@optional

-(void) initErrorResponse:(NSString*)response  NS_DEPRECATED(10_0, 10_4, 2_0, 2_0);


//IMAGE UPLOAD 


/**
 * ...  New delegate methods support both single and multiple image upload ...
 */
-(void) imageuploadSuccessWithImageData:(WAG_ImageData *)imageData;
-(void) imageuploadErrorWithImageData:(WAG_ImageData *)imageData  Error:(NSError *)error;

/**
 * ... This will give the upload pregress status ...
 */
-(void) getUploadProgress:(float)progress;

/**
 * ... This will be called when the cartPoster returns url ...
 */
-(void) cartPosterSuccessResponse:(NSString*)response;

/**
 * ... This will be called when the cartPoster process is failure ...
 */
-(void) didCartPostFailWithError:(NSError *)error;

-(void) cartPosterErrorResponse:(NSString*)response;

-(void) didFinishBatch;



// EXCEPTION
/**
 * ... This will be called when there is any generic exception ...
 */
-(void) didFailWithServiceException:(NSString*)response NS_DEPRECATED(10_0, 10_4, 2_0, 2_0);
-(void) didServiceFailWithError:(NSError*)error;



@end

@interface WAG_CheckoutContext : NSObject <CLLocationManagerDelegate> {
	id <CheckoutDelegate>   delegate;
	CLLocationManager       *locationManager; 
	NSString                *cartPosterUrl;
    BOOL                    authenticationStatus;
	
}

@property(nonatomic, assign) id <CheckoutDelegate>  delegate;
@property(nonatomic, retain) NSString               *cartPosterUrl;
@property(nonatomic, assign) BOOL                   authenticationStatus;

/**
 * ... initilize the CheckoutContext class with affliated id , api key and walgreens webservice environment ...
 * ... Environment = 0 is for staging ...
 * ... Environment = 1 is for production ...
 */
-(id) initWithAffliateId:(NSString*)affIdStr apiKey:(NSString*)apiKey environment:(NSInteger)envtype appVersion:(NSString*)version;
/**
 * ... initilize the CheckoutContext class with affliated id , api key and walgreens webservice url ...
 * ... Environment = 0 is for staging ...
 * ... Environment = 1 is for production ...
 */
-(id) initWithAffliateId:( NSString*)affIdStr apiKey:(NSString*)apiKey serviceUrl:(NSString*)urlStr environment:(NSInteger)envtype appVersion:(NSString*)version;


/**
 * ... initilize the CheckoutContext class with affliated id , api key and walgreens webservice environment ...
 * ... Environment = 0 is for staging ...
 * ... Environment = 1 is for production ...
 */
-(id) initWithAffliateId:(NSString*)affIdStr apiKey:(NSString*)apiKey environment:(NSInteger)envtype appVersion:(NSString*)version ProductGroupID:(NSString *)productGroupID PublisherID:(NSString *)publisherID;


/**
 * ... This will set the user info into the sdk ...
 */
-(void)setUserInfoWith:(NSString *)firstName LastName:(NSString *)lastName Email:(NSString *)email PhoneNo:(NSString *)phoneNo;

/**
 * ... This will upload the image into Aws server and generate the image url ...
   ... The input parameter is generic type , the input data can be assert data or NSData  ...
 */
-(void) upload:(id)arg;

/* This method can cancel the image upload process */
-(void) cancelImageUpload;

/* This will clear the images from the queue  */
-(void) removeImageFromQueueWithAsset:(ALAsset *)asset;

/**
 * ... This api will return the imaximum upload image count...
 */
-(NSInteger) getMaximumImageUploadCount;

/**
 * ... This api will return the imaximum upload image count...
 */
-(NSInteger) uploadedImageCount;

/**
 * ... This will be clear the uploaded image queue ...
 */
-(void) clearImageQueue;

/**
 * ... This will be return the image upload status ...
 */
+(BOOL) inProgress;

/**
 * ... This will call the cartPoster to get the checkout url...
 */
-(void) postCart;


@end
