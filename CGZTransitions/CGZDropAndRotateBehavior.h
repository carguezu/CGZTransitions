//
//  CGZDropAndRotateBehavior.h
//
//  Created by Carlos on 13/03/14.
//  Copyright (c) 2014 CarlosGz. All rights reserved.
//

@import UIKit;

@interface CGZDropAndRotateBehavior : UIDynamicBehavior

/** Initializes the behavior.
 * @param item Adds a dynamic item to the behavior item array.
 */
- (instancetype)initWithItem:(id<UIDynamicItem>)item;

/** Removes a specific dynamic item from the dynamic item behavior. */
-(void)removeItem:(id <UIDynamicItem>)item;

@end
