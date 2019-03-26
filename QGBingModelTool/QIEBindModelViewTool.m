//
//  QIEBindModelViewTool.m
//  QGBingModelTool
//
//  Created by 李超群 on 2019/3/25.
//  Copyright © 2019 李超群. All rights reserved.
//

#import "QIEBindModelViewTool.h"
@implementation DYRoomModel
@end
@implementation QIEUserModel
@end
@interface QIEBindModelViewTool ()

/** 绑定直播间 model 的 view 数组 */
@property (nonatomic, strong) NSHashTable <id <QIERefreshUIProtocol>> *bindRoomModelViewsArray;

/** 绑定用户信息 model 的 view 数组 */
@property (nonatomic, strong) NSHashTable <id <QIERefreshUIProtocol>> *bindUserModelViewsArray;

@end

@implementation QIEBindModelViewTool

// - MARK: <-- 初始化 -->
static QIEBindModelViewTool *bindModelViewTool_ = nil;
+(instancetype)bindModelViewTool{
    if (!bindModelViewTool_) {
        bindModelViewTool_ = [[QIEBindModelViewTool alloc]init];
    }
    return bindModelViewTool_;
}

/** 当 aClass 的对象发生变化时候 就调用 anObj 的 refreshUI: 方法*/
-(void)bindModelClass:(QIEBindViewType)bindViewType object:(id <QIERefreshUIProtocol> )anObj{
    
    // - 做非空的判断
    if (!anObj || (![anObj respondsToSelector:@selector(refreshUI:)])) return;
    
    // - 根据类型刷新 UI
    if (bindViewType == QIEBindViewTypeUserModel) {
        [self.bindUserModelViewsArray addObject:anObj];
        [anObj refreshUI:self.userModel];
    }else if (bindViewType == QIEBindViewTypeRoomModel){
        [self.bindRoomModelViewsArray addObject:anObj];
        [anObj refreshUI:self.roomModel];
    }
}

/** 更新 roomModel 的数据 */
-(void)setRoomModel:(DYRoomModel *)roomModel{
    _roomModel = roomModel;
    for (id <QIERefreshUIProtocol> obj in self.bindRoomModelViewsArray) {
        [obj refreshUI:roomModel];
    }
}

/** 更新 userModel 的数据 */
-(void)setUserModel:(QIEUserModel *)userModel{
    _userModel = userModel;
    for (id <QIERefreshUIProtocol> obj in self.bindRoomModelViewsArray) {
        [obj refreshUI:userModel];
    }
}

// - MARK: <-- 懒加载 -->
/** 绑定直播间 model 的 view 数组 */
-(NSHashTable <id <QIERefreshUIProtocol>> *)bindRoomModelViewsArray{
    if(!_bindRoomModelViewsArray){
        _bindRoomModelViewsArray = [NSHashTable weakObjectsHashTable];
    }
    return _bindRoomModelViewsArray;
}

/** 绑定用户信息 model 的 view 数组 */
-(NSHashTable <id <QIERefreshUIProtocol>> *)bindUserModelViewsArray{
    if(!_bindUserModelViewsArray){
        _bindUserModelViewsArray = [NSHashTable weakObjectsHashTable];
    }
    return _bindUserModelViewsArray;
}

// - MARK: <-- 释放内存 -->
/** 销毁工具类 */
+(void)destoryTool{
    if (bindModelViewTool_) {
        [bindModelViewTool_.bindRoomModelViewsArray removeAllObjects];
        [bindModelViewTool_.bindUserModelViewsArray removeAllObjects];
        bindModelViewTool_ = nil;
    }
}

-(void)dealloc{
    NSLog(@"==========dealloc=========");
}
@end
