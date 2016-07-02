# ZLazyList

[![CI Status](http://img.shields.io/travis/WilliamZang/ZLazyList.svg?style=flat)](https://travis-ci.org/WilliamZang/ZLazyList)
[![Version](https://img.shields.io/cocoapods/v/ZLazyList.svg?style=flat)](http://cocoapods.org/pods/ZLazyList)
[![License](https://img.shields.io/cocoapods/l/ZLazyList.svg?style=flat)](http://cocoapods.org/pods/ZLazyList)
[![Platform](https://img.shields.io/cocoapods/p/ZLazyList.svg?style=flat)](http://cocoapods.org/pods/ZLazyList)

ZLazyList is just a functional programming test.
To show what is lazily calculate.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

You can create a list like this: 
``` objective-c
ZLazyList *list1 = [[ZLazyList alloc] initWithArray:@[@1, @2, @3]];
```

Then use `filter:` or `map:` add to this list
``` objective-c
ZLazyList *list2 = [list1 map:^id(NSNumber *value) {
            return @(value.integerValue * 2);
        }];
NSLog(@"%@", list2[2]);
```
You will found the map block is only be call once.


## Installation

ZLazyList is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ZLazyList"
```

## Author

臧成威, zangchengwei@meituan.com

## License

ZLazyList is available under the MIT license. See the LICENSE file for more info.
