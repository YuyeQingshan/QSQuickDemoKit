//
//  QSButtonGroup.h
//  Pods
//
//  Created by qingshan on 2017/4/6.
//
//

#import <Foundation/Foundation.h>

@interface QSButtonGroup : NSObject

- (void)setupButtonGroupInContentView:(UIView *)contentView;

- (void)addButtonWithTitle:(NSString *)title actionBlock:(dispatch_block_t)block;
@end
