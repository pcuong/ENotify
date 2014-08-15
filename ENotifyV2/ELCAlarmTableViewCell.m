//
//  ELCAlarmTableViewCell.m
//  ENotifyV2
//
//  Created by Cuong Pham Ngoc on 8/15/14.
//  Copyright (c) 2014 PCuong. All rights reserved.
//

#import "ELCAlarmTableViewCell.h"

@interface ELCAlarmTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UILabel *rtuNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addedDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusTextLabel;


@end

@implementation ELCAlarmTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
