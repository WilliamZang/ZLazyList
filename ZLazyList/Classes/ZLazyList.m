//
//  ZLazyList.m
//  Pods
//
//  Created by ZangChengwei on 16/7/2.
//
//

#import "ZLazyList.h"

typedef id(^HeadBlock)();
typedef ZLazyList *(^TailBlock)();
@interface ZLazyList ()

@property (nonatomic, strong) HeadBlock headBlock;
@property (nonatomic, strong) TailBlock tailBlock;

@end

@implementation ZLazyList

- (id)head
{
    return self.headBlock();
}

- (ZLazyList *)tail
{
    Z_GUARD(self.tailBlock == nil, nil)
    return self.tailBlock();
}

- (instancetype)initWithArray:(NSArray *)array
{
    NSAssert(array.count > 0, @"array must have items!");
    return [self initWithArray:array offset:0];
}

- (instancetype)initWithArray:(NSArray *)array offset:(NSUInteger)offset
{
    if (self = [super init]) {
        
        id firstObj = array[offset];
        _headBlock = ^id { return firstObj; };
        if (array.count > offset + 1) {
            ZLazyList *tail = [[ZLazyList alloc] initWithArray:array offset:offset + 1];
            _tailBlock = ^ZLazyList *{ return tail; };
        }
    }
    return self;
}

- (instancetype)initWithHeadBlock:(HeadBlock)headBlock tailBlock:(TailBlock)tailBlock
{
    if (self = [super init]) {
        _headBlock = headBlock;
        _tailBlock = tailBlock;
    }
    return self;
}

- (instancetype)initWithHead:(id)head tail:(ZLazyList *)tail
{
    return [self initWithHeadBlock:^id{
        return head;
    } tailBlock:^ZLazyList *{
        return tail;
    }];
}


- (ZLazyList *)appendList:(ZLazyList *)next
{
    if (self.tailBlock == nil) {
        return [[ZLazyList alloc] initWithHeadBlock:self.headBlock tailBlock:^ZLazyList *{
            return next;
        }];
    }
    return [[ZLazyList alloc] initWithHeadBlock:self.headBlock tailBlock:^ZLazyList *{
        return [self.tail appendList:next];
    }];
}

- (ZLazyList *)map:(ZMapFunction)mapFunction
{
    return [[ZLazyList alloc] initWithHeadBlock:^id{
        return mapFunction(self.head);
    } tailBlock:^ZLazyList *{
        return [self.tail map:mapFunction];
    }];
}

- (ZLazyList *)filter:(ZConditionFunction)conditionFunction
{
    TailBlock tailBlock = ^ZLazyList * {
        return [self.tail filter:conditionFunction];
    };
    if (conditionFunction(self.head)) {
        return [[ZLazyList alloc] initWithHeadBlock:^id{
            return self.head;
        } tailBlock:tailBlock];
    } else {
        return [self.tail filter:conditionFunction];
    }
}

- (ZLazyList *)take:(NSUInteger)count
{
    Z_GUARD(count <= 0, nil)
    return [[ZLazyList alloc] initWithHeadBlock:self.headBlock tailBlock:^ZLazyList *{
        return [self.tail take:count - 1];
    }];
}

- (ZLazyList *)skip:(NSUInteger)count
{
    Z_GUARD(count <= 0, self)
    
    return [self.tail skip:count - 1];
}

- (ZLazyList *)takeLast:(NSUInteger)count
{
    if ([self count] <= count) {
        return self;
    }
    return [self.tail takeLast:count];
}

- (NSUInteger)count
{
    return 1 + self.tail.count;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx
{
    return [self skip:idx].head;
}

- (void)forEach:(ZIteratorFunction)eachFunction
{
    eachFunction(self.head);
    [self.tail forEach:eachFunction];
}

@end
