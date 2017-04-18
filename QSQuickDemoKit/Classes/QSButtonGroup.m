//
//  QSButtonGroup.m
//  Pods
//
//  Created by qingshan on 2017/4/6.
//
//

#import "QSButtonGroup.h"

#import <UIKit/UIKit.h>
#import <ChameleonFramework/Chameleon.h>

@interface QSButtonCellItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) dispatch_block_t action;
@end

@implementation QSButtonCellItem
@end

@interface QSButtonCell : UICollectionViewCell

@property (nonatomic, readonly, strong) UILabel *titleLabel;
@end

@implementation QSButtonCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        
        [self.contentView addSubview:_titleLabel];
        
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        NSDictionary *views = NSDictionaryOfVariableBindings(_titleLabel);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_titleLabel]-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:views]];
    }
    
    return self;
}
@end

@interface QSButtonGroup () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<QSButtonCellItem *> *collectionViewDataSource;
@end

@implementation QSButtonGroup

#pragma mark - LifeCircle

- (instancetype)init {
    self = [super init];
    if (self) {
        _collectionViewDataSource = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark - Pubic

- (void)setupButtonGroupInContentView:(UIView *)contentView {
    if (!contentView) {
        return;
    }
    
    [self.collectionView registerClass:[QSButtonCell class]
            forCellWithReuseIdentifier:NSStringFromClass([QSButtonCell class])];
    
    [contentView addSubview:self.collectionView];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = NSDictionaryOfVariableBindings(contentView, _collectionView);
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:views]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_collectionView]|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:views]];
}

- (void)addButtonWithTitle:(NSString *)title actionBlock:(dispatch_block_t)block {
    if (title.length == 0 || !block) {
        return;
    }
    
    QSButtonCellItem *item = [QSButtonCellItem new];
    item.title = title;
    item.action = block;
    
    [self.collectionViewDataSource addObject:item];
}

#pragma mark - Custom Accessor

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(150, 150*0.618);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor flatWhiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    
    return _collectionView;
}

#pragma mark - CollectionDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _collectionViewDataSource.count;
}

- (QSButtonCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QSButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([QSButtonCell class])
                                                                   forIndexPath:indexPath];
    
    QSButtonCellItem *item = [self.collectionViewDataSource objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = item.title;
    cell.contentView.backgroundColor = [UIColor colorWithRandomFlatColorOfShadeStyle:UIShadeStyleDark];
    cell.titleLabel.textColor = [UIColor colorWithContrastingBlackOrWhiteColorOn:cell.contentView.backgroundColor
                                                                          isFlat:YES];
    return cell;
}

#pragma mark - CollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    QSButtonCellItem *item = [self.collectionViewDataSource objectAtIndex:indexPath.row];
    if (item.action) {
        item.action();
    }
}

@end
