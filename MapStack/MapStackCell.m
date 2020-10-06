//
//  MapStackCell.m
//  MapStack
//
//  Created by Mike Leveton on 9/11/15.
//  Copyright (c) 2015 Mike Leveton. All rights reserved.
//

#import "MapStackCell.h"

@implementation MapStackCell

- (void)awakeFromNib {
    // Initialization code
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpRightSideView{
    UIView *squareView = [[UIView alloc]initWithFrame:CGRectMake(245, 25, 50, 50)];
    [squareView setBackgroundColor:[UIColor redColor]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapRightSide:)];
    [tap setNumberOfTapsRequired:1];
    [squareView addGestureRecognizer:tap];
    [self addSubview:squareView];
}

- (void)didTapRightSide:(UITapGestureRecognizer *)recognizer{
    
    if ([self.delegate respondsToSelector:@selector(mapStackCell:WasTappedWithIndex:)]){
        [self.delegate mapStackCell:self WasTappedWithIndex:self.indexPath];
    }
}

@end
