//
//  MapStackCell.h
//  MapStack
//
//  Created by Mike Leveton on 9/11/15.
//  Copyright (c) 2015 Mike Leveton. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MapStackCellDelegate;

@interface MapStackCell : UITableViewCell

@property (nonatomic, weak) id <MapStackCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;

- (void)setUpRightSideView;

@end

@protocol MapStackCellDelegate <NSObject>

- (void)mapStackCell:(MapStackCell *)cell WasTappedWithIndex:(NSIndexPath *)indexPath;

@end
