//
//  ViewController.m
//  TableSample
//
//  Created by Shinya Hirai on 1/29/14.
//  Copyright (c) 2014 Shinya Hirai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSArray *sampleArray;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
    sampleArray = @[@"text01おいおgfhcgvjhbkj",@"text02",@"text03",@"text04",@"text05",@"text06",@"text07"];
}

/* Driving The Table View */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [sampleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // バルーンとテキストの部分を宣言
	UIImageView *balloonView;
	UILabel *label;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		balloonView = [[UIImageView alloc] initWithFrame:CGRectZero];
		balloonView.tag = 1;
		
		label = [[UILabel alloc] initWithFrame:CGRectZero];
		label.backgroundColor = [UIColor clearColor];
		label.tag = 2;
		label.numberOfLines = 0;
		label.lineBreakMode = NSLineBreakByWordWrapping;
		label.font = [UIFont systemFontOfSize:14.0];
		
		UIView *message = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, cell.frame.size.width, cell.frame.size.height)];
        message.tag = 3;
		[message addSubview:balloonView];
		[message addSubview:label];
        message.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		[cell.contentView addSubview:message];
		
	} else {
		balloonView = (UIImageView *)[[cell.contentView viewWithTag:3] viewWithTag:1];
		label = (UILabel *)[[cell.contentView viewWithTag:3] viewWithTag:2];
	}
    
	NSString *text = sampleArray[indexPath.row];
    
    // iOS7だとこのコードが使えないのでその下のコード
    // 後にiOS6以下でも走るよう条件分岐する必要があるかも
	// CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(240.0f, 480.0f) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize size = [text boundingRectWithSize:CGSizeMake(240.0f, 480.0f)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0]}
                                     context:nil].size;
    
	UIImage *balloon;
    
    // ここでセルに表示する左右の分岐
    if(indexPath.row % 2 == 0)
	{
		balloonView.frame = CGRectMake(320.0f - (size.width + 28.0f), 2.0f, size.width + 28.0f, size.height + 15.0f);
		balloon = [[UIImage imageNamed:@"aqua.png"] stretchableImageWithLeftCapWidth:24 topCapHeight:15];
		label.frame = CGRectMake(307.0f - (size.width + 5.0f), 8.0f, size.width + 5.0f, size.height);
	}
	else
	{
		balloonView.frame = CGRectMake(0.0, 2.0, size.width + 28, size.height + 15);
		balloon = [[UIImage imageNamed:@"grey_2.png"] stretchableImageWithLeftCapWidth:24 topCapHeight:15];
		label.frame = CGRectMake(16, 8, size.width + 5, size.height);
	}
    
    balloonView.image = balloon;
    label.text = text;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *body = sampleArray[indexPath.row];
    
    // iOS7だとこのコードが使えないのでその下のコード
    // 後にiOS6以下でも走るよう条件分岐する必要があるかも
    // CGSize size = [body sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(240.0, 480.0) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize size = [body boundingRectWithSize:CGSizeMake(240.0f, 480.0f)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0]}
                                     context:nil].size;
	return size.height + 15;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
