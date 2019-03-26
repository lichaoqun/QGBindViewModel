//
//  QIEBindModelViewTool.h
//  QGBingModelTool
//
//  Created by 李超群 on 2019/3/25.
//  Copyright © 2019 李超群. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DYRoomModel : NSObject

/** <#注释#> */
@property (nonatomic, copy) NSString *title;
@end
@interface QIEUserModel : NSObject
@end


typedef NS_ENUM(NSInteger, QIEBindViewType) {
    QIEBindViewTypeRoomModel,   /**< 绑定直播间 model */
    QIEBindViewTypeUserModel    /**< 绑定用户 model */
};

/** 更新 UI 时候需要调用的方法 */
@protocol QIERefreshUIProtocol <NSObject>

/** 更新 UI  viewModel: 变化的 model */
-(void)refreshUI:(id)viewModel;

@end

@interface QIEBindModelViewTool : NSObject

/** 绑定的直播间 model */
@property (nonatomic, strong) DYRoomModel *roomModel;

/** 绑定的用户 model */
@property (nonatomic, strong) QIEUserModel *userModel;

/** 单例初始化 */
+(instancetype)bindModelViewTool;

/** 当调用 bindViewType 对应的 model 的 set方法 就调用 anObj 的 refreshUI: 方法*/
-(void)bindModelClass:(QIEBindViewType)bindViewType object:(id <QIERefreshUIProtocol> )anObj;

@end
