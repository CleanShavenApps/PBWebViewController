//
//  PBSafariActivity.m
//  Pinbrowser
//
//  Created by Mikael Konutgan on 12/02/2013.
//  Copyright (c) 2013 Mikael Konutgan. All rights reserved.
//

#import "PBSafariActivity.h"
#import "CSATargetContext.h"

@interface PBSafariActivity ()

@property (strong, nonatomic) NSURL *URL;

@end

@implementation PBSafariActivity

- (NSString *)activityType
{
    return NSStringFromClass([self class]);
}

- (NSString *)activityTitle
{
    return @"Open in Safari";
}

- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"782-compass"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[NSURL class]] && [CSATargetContext.sharedContext.delegate targetCanOpenURL:activityItem]) {
            return YES;
        }
    }
    
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[NSURL class]]) {
            self.URL = activityItem;
            return;
        }
    }
}

- (void)performActivity
{
    [CSATargetContext.sharedContext.delegate targetOpenURL:self.URL];
    [self activityDidFinish:YES];
}

@end
