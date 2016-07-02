//
//  ZLazyList.h
//  Pods
//
//  Created by ZangChengwei on 16/7/2.
//
//

#import <Foundation/Foundation.h>
#import "ZMarcos.h"

@interface ZLazyList : NSObject

@property (nonatomic, readonly) id head;
@property (nonatomic, readonly) ZLazyList *tail;

- (instancetype)initWithArray:(NSArray *)array;

- (ZLazyList *)appendList:(ZLazyList *)next;

- (ZLazyList *)map:(ZMapFunction)mapFunction;

- (ZLazyList *)filter:(ZConditionFunction)conditionFunction;

- (ZLazyList *)take:(NSUInteger)count;

- (ZLazyList *)skip:(NSUInteger)count;

- (ZLazyList *)takeLast:(NSUInteger)count;

- (NSUInteger)count;

- (id)objectAtIndexedSubscript:(NSUInteger)idx;

- (void)forEach:(ZIteratorFunction)eachFunction;





@end
