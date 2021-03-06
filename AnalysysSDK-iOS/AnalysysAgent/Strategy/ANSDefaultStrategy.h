//
//  ANSDefaultStrategy.h
//  AnalysysAgent
//
//  Created by SoDo on 2019/1/17.
//  Copyright © 2019 analysys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANSStrategyProtocol.h"

/**
 * @class
 * ANSDefaultStrategy
 *
 * @abstract
 * 默认策略信息
 *
 * @discussion
 * SDK默认策略
 */

NS_ASSUME_NONNULL_BEGIN

@interface ANSDefaultStrategy : NSObject<ANSStrategyProtocol>

/**
 默认debug模式
 */
@property (nonatomic, assign) NSInteger debugMode;

/**
 默认上传间隔
 */
@property (nonatomic, assign) NSInteger flushInterval;

/**
 默认累积上传条数
 */
@property (nonatomic, assign) NSInteger flushBulkSize;

/**
 默认上传允许失败最多次数
 */
@property (nonatomic, assign) NSInteger maxAllowFailedCount;

/**
 默认达到上传最多次数后延迟后，下次上传间隔
 */
@property (nonatomic, assign) NSInteger maxFailedDelay;


@end

NS_ASSUME_NONNULL_END
