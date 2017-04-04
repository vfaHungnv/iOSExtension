//
//  UCAccount.h
//  iOSExtension
//
//  Created by HungNV on 4/4/17.
//  Copyright © 2017 HungNV. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UCAccount : NSObject
@property (nonatomic) BOOL hasValidAuthentication;

+ (instancetype)sharedAccount;

- (BOOL)sendMessage:(nullable NSString *)message toRecipients:(nullable NSArray *)recipients;
@end

NS_ASSUME_NONNULL_END
