//
//  ZMarcos.h
//  Pods
//
//  Created by ZangChengwei on 16/7/2.
//
//

#ifndef ZMarcos_h
#define ZMarcos_h

#define Z_GUARD(_CONDITION_, _RETURN_VAL_)  \
if (_CONDITION_) {                          \
  return (_RETURN_VAL_);                    \
}

typedef id(^ZMapFunction)(id);
typedef BOOL(^ZConditionFunction)(id);
typedef void(^ZIteratorFunction)(id);
typedef id(^ZFoldFunction)(id, id);

#endif /* ZMarcos_h */
