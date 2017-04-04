//
//  UCAccount.m
//  iOSExtension
//
//  Created by HungNV on 4/4/17.
//  Copyright © 2017 HungNV. All rights reserved.
//

#import "UCAccount.h"

@implementation UCAccount

+ (instancetype)sharedAccount {
    UCAccount *shared = [[UCAccount alloc] init];
    [shared setHasValidAuthentication:YES];
    return shared;
}

- (BOOL)sendMessage:(NSString *)message toRecipients:(NSArray *)recipients {
    // Sending a message here...
    
    return YES;
}

@end
