//
//  ZLazyListTests.m
//  ZLazyListTests
//
//  Created by 臧成威 on 07/02/2016.
//  Copyright (c) 2016 臧成威. All rights reserved.
//

// https://github.com/Specta/Specta
@import ZLazyList;




SpecBegin(ZLazyListTest)

ZMapFunction map2x = ^id(NSNumber *value) {
    return @(value.integerValue * 2);
};

ZConditionFunction filterOdd = ^BOOL(NSNumber *value) {
    return value.integerValue % 2 == 1;
};

describe(@"list can be used", ^{

    it(@"can create", ^{
        ZLazyList *list = [[ZLazyList alloc] initWithArray:@[@1, @2, @3]];
        expect(list[0]).to.equal(@1);
        expect(list[1]).to.equal(@2);
        expect(list[2]).to.equal(@3);
    });

    it(@"count is correct", ^{
        ZLazyList *list = [[ZLazyList alloc] initWithArray:@[@1, @2, @3]];
        expect([list count]).to.equal(3);
    });
    
    it(@"append list correct", ^{
        ZLazyList *list1 = [[ZLazyList alloc] initWithArray:@[@1, @2, @3]];
        ZLazyList *list2 = [[ZLazyList alloc] initWithArray:@[@4, @5, @6]];
        ZLazyList *list3 = [list1 appendList:list2];
        
        expect(list3[0]).to.equal(@1);
        expect(list3[1]).to.equal(@2);
        expect(list3[2]).to.equal(@3);
        expect(list3[3]).to.equal(@4);
        expect(list3[4]).to.equal(@5);
        expect(list3[5]).to.equal(@6);
    });
    
    it(@"map correct", ^{
        ZLazyList *list1 = [[ZLazyList alloc] initWithArray:@[@1, @2, @3]];
        ZLazyList *list2 = [list1 map:map2x];
        expect(list2[0]).to.equal(@2);
        expect(list2[1]).to.equal(@4);
        expect(list2[2]).to.equal(@6);
    });
    
    it(@"filter correct", ^{
        ZLazyList *list1 = [[ZLazyList alloc] initWithArray:@[@1, @2, @3]];
        ZLazyList *list2 = [list1 filter:filterOdd];
        expect(list2[0]).to.equal(@1);
        expect(list2[1]).to.equal(@3);
    });
    
    it(@"take correct", ^{
        ZLazyList *list1 = [[ZLazyList alloc] initWithArray:@[@1, @2, @3]];
        ZLazyList *list2 = [list1 take:2];
        expect(list2[0]).to.equal(@1);
        expect(list2[1]).to.equal(@2);
        expect([list2 count]).to.equal(2);
    });
    
    it(@"skip correct", ^{
        ZLazyList *list1 = [[ZLazyList alloc] initWithArray:@[@1, @2, @3]];
        ZLazyList *list2 = [list1 skip:2];
        expect(list2[0]).to.equal(@3);
        expect([list2 count]).to.equal(1);
    });
    
    it(@"take last correct", ^{
        ZLazyList *list1 = [[ZLazyList alloc] initWithArray:@[@1, @2, @3]];
        ZLazyList *list2 = [list1 takeLast:2];
        expect(list2[0]).to.equal(@2);
        expect(list2[1]).to.equal(@3);
        expect([list2 count]).to.equal(2);
    });
    
    it(@"for each correct", ^{
        ZLazyList *list1 = [[ZLazyList alloc] initWithArray:@[@1, @2, @3]];
        __block int times = 0;
        [list1 forEach:^(NSNumber *value) {
            
            switch (times) {
                case 0:
                {
                    expect(value).to.equal(@1);
                    break;
                }
                case 1:
                {
                    expect(value).to.equal(@2);
                    break;
                }
                case 2:
                {
                    expect(value).to.equal(@3);
                    break;
                }
                default:
                    break;
            }
            ++times;
        }];
        expect(times).to.equal(3);
    });
});

describe(@"list execute as lazy", ^{
    
    it(@"map is lazy", ^{
        ZLazyList *list1 = [[ZLazyList alloc] initWithArray:@[@1, @2, @3]];
        
        __block NSUInteger callTimes = 0;
        
        ZLazyList *list2 = [list1 map:^id(NSNumber *value) {
            ++callTimes;
            return map2x(value);
        }];
        
        expect(list2[2]).to.equal(@6);
        expect(callTimes).to.equal(1);
    });
    
    it(@"filter is lazy", ^{
        ZLazyList *list1 = [[ZLazyList alloc] initWithArray:@[@1, @2, @3, @4, @5]];
        __block NSUInteger calltimes = 0;
        ZLazyList *list2 = [list1 filter:^BOOL(NSNumber *value) {
            ++calltimes;
            return filterOdd(value);
        }];
        ZLazyList *list3 = [list2 take: 2];
        
        expect([list3 count]).to.equal(2);
    });
    
});

SpecEnd

