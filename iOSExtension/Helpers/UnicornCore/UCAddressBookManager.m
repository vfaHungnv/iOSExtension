/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The class that manages UnicornChat's own address book.
*/

#import "UCAddressBookManager.h"
#import "UCContact.h"

@implementation UCAddressBookManager

- (NSArray<UCContact *> *)contactsMatchingName:(NSString *)name {
    NSMutableArray<UCContact *> *results = [[NSMutableArray alloc] init];
    for (UCContact *contact in [self allContacts]) {
        if ([[[contact name] lowercaseString] containsString:[name lowercaseString]]) {
            [results addObject:contact];
        }
    }
    return results;
}


- (NSArray<UCContact *> *)allContacts {
    UCContact *contact1 = [[UCContact alloc] init];
    [contact1 setName:@"Home"];
    [contact1 setUnicornName:@"My father"];
    
    UCContact *contact2 = [[UCContact alloc] init];
    [contact2 setName:@"Kendy"];
    [contact2 setUnicornName:@"Kendy"];

    UCContact *contact3 = [[UCContact alloc] init];
    [contact3 setName:@"Jion"];
    [contact3 setUnicornName:@"Jion"];
    
    UCContact *contact4 = [[UCContact alloc] init];
    [contact4 setName:@"Anne Johnson"];
    [contact4 setUnicornName:@"Pinky Nose"];
    
    NSArray<UCContact *> *allContacts = @[contact1,
                                          contact2,
                                          contact3,
                                          contact4,
                                          ];
    return allContacts;
}

@end
