drop table if EXISTS  user_info;
create table user_info(
    ui_id bigint  unsigned not null auto_increment,
    ui_name varchar(31) not null comment '用户名',
    ui_nick_name varchar(31) not null comment '用户昵称',
    ui_sex enum('男','女') not null comment '用户性别',
    ui_age tinyint unsigned not null comment '用户年龄',
    ui_type varchar(31) not null  comment '用户类型',
    ui_birth datetime not null default current_timestamp comment '用户出生日期',
    ui_address varchar(31) not null default '' comment '用户居住地点',
    ui_id_type varchar(32) not null default '' comment '用户唯一标识类型',
    ui_id_card varchar(18) not null default '' comment '用户唯一标识',
    ui_phone varchar(18) not null default '' comment '用户手机',
    ui_email varchar(63) not null default '' comment '邮箱',
    ui_password varchar(15) not null default '' comment '用户密码',
    ui_salt varchar(31) not null default '' comment '盐',
    ui_salt_password varchar(31) not null default '' comment '盐密',
    ui_token varchar(32) not null default '' comment '盐密',
    ui_register_time datetime not null default current_timestamp comment '用户注册时间',
    ui_status enum('正常','注销','禁用') not null default '正常' comment '用户状态',
    ui_login_time datetime not null default current_timestamp comment '登录时间',
    ui_forbid_time  datetime not null default current_timestamp comment '退出时间',
    create_time datetime not null default current_timestamp comment '创建时间',
    create_founder bigint unsigned not null default 0 comment '', 
    update_time datetime not null default current_timestamp on update current_timestamp comment '更新时间', 
    update_founder bigint unsigned not null default 0 comment '', 
    is_delete int unsigned not null default 0  comment '数据状态',
    primary key(`ui_id`),
    unique key unique_name(`ui_name`),
    unique key unique_email(`ui_email`),
    unique key unique_phone(`ui_phone`),
    unique key unique_id_card_type(`ui_id_card`,`ui_id_type`)
);

-- 超级用户SQL语句


create table ability_info(
    ai_id  bigint unsigned not null auto_increment,
    ai_parent_id  bigint unsigned not null default 0 comment '主id',
    organization_id bigint unsigned not null comment '组织id',
    organization_name  varchar(31) not null comment '组织名',
    organization_type_enum varchar(31) not null comment '组织名',
    ai_name varchar(31) not null default '' comment '策略名',
    ai_lable json not null default(json_array()) comment '策略标签',
    ai_ability_type varchar(31) not null comment '策略类型',
    ai_data varchar(511)  not null comment '策略数据',
    ai_description varchar(511)  not null default '' comment '策略说明',
    ai_relation_status enum('正常','作废') not null default '正常' comment '',
    ai_bind_times bigint not null default 0 comment '绑定次数',
    ai_range_power varchar(15) not null default 'default' comment '授权范围',
    create_time datetime not null default current_timestamp comment '创建时间',
    create_founder bigint unsigned not null default 0 comment '', 
    update_time datetime not null default current_timestamp on update current_timestamp comment '更新时间', 
    update_founder bigint unsigned not null default 0 comment '', 
    primary key(ai_id),
    key index_org_id(organization_id),
    key index_parent_id(ai_parent_id)
);

drop table if EXISTS  ability_relation;

create table ability_relation(
    ar_id bigint unsigned not null auto_increment,
    ai_id bigint unsigned not null comment '动作id',
    ai_name varchar(31) not null comment '动作名',
    organization_id bigint unsigned not null comment '组织id',
    organization_name  varchar(31) not null comment '组织名',
    organization_type_enum varchar(31) not null comment '组织名',
    ability_type_enum varchar(31) not null comment '动作类型',
    protocel_config_enum varchar(31) not null comment '协议配置类型',
    ar_relation_status int not null default 1 comment '绑定关系[绑定，解绑，记录]',
    ar_explain varchar(255) not null default '' comment '说明',
    create_time datetime not null default current_timestamp comment '创建时间',
    create_founder bigint unsigned not null default 0 comment '', 
    update_time datetime not null default current_timestamp on update current_timestamp comment '更新时间', 
    update_founder bigint unsigned not null default 0 comment '', 
    is_delete int unsigned not null default 0  comment '数据状态',
    primary key (`ar_id`),
    key  index_ai_id(`ai_id`)
);

create table  organization_info(
    oi_id bigint unsigned not null auto_increment,
    oi_superior_id bigint unsigned not null default 0 comment '附id',
    oi_name varchar(31) not null comment'组织名',
    oi_english_name varchar(31) not null comment '组织英语名',
    oi_type varchar(31) not null comment '组织类型[ 团队，业务线，项目，环境 四个]',
    oi_tag json not null default (JSON_ARRAY()) comment "标签",
    oi_explain varchar(127) not null comment '说明',
    oi_subordinate_num int unsigned not null default 0 comment '下级数量',
    oi_interface_num int unsigned not null default 0 comment 'api',
    oi_creater_id bigint unsigned not null comment'创建人',
    oi_creater_name varchar(31) not null comment'创建人名',
    oi_owner_id bigint unsigned not null comment'所有权人',
    oi_owner_name varchar(31) not null comment'所有权名',
    create_time datetime not null default current_timestamp comment '创建时间',
    create_founder bigint unsigned not null default 0 comment '', 
    update_time datetime not null default current_timestamp on update current_timestamp comment '更新时间', 
    update_founder bigint unsigned not null default 0 comment '', 
    is_delete int unsigned not null default 0  comment '数据状态',
    primary key (`oi_id`),
    key index_superior(`oi_superior_id`),
    key index_creater_id(`oi_creater_id`),
    key index_owner_id(`oi_owner_id`),
    key index_create(`create_time`)
);

create table organization_power(
    op_id  bigint unsigned not null auto_increment,
    ui_id bigint unsigned not null comment '用户id',
    ui_name varchar(36) not null comment '用户名',
    organization_id bigint unsigned not null comment '组织id',
    organization_name  varchar(31) not null comment '组织名',
    organization_type_enum varchar(31) not null comment '组织名',
    op_power varchar(36) not null comment '角色',
    op_status int not null default 0 comment '数据状态',
    create_time datetime not null default current_timestamp comment '创建时间',
    create_founder bigint unsigned not null default 0 comment '', 
    update_time datetime not null default current_timestamp on update current_timestamp comment '更新时间', 
    update_founder bigint unsigned not null default 0 comment '', 
    is_delete int unsigned not null default 0  comment '数据状态',
    primary key (`op_id`),
    key index_ui_id(`ui_id`),
    key index_organization_id(`organization_id`)
);

create table instance_info(
    id bigint unsigned not null auto_increment,
    application_id bigint unsigned not null comment '项目id',
    application_english_name varchar(31) not null comment '项目英文',
    organization_type_enum varchar(31) not null comment '组织类型[ API,实例 两个]',
    network_address int unsigned not null  default 0 comment '网络地址' ,
    port  int unsigned not null  default 0 comment '端口',
    protocol varchar(15) not null default '' comment '协议[http1.0，http2.0, dubbo, grpc......]',
    `language` varchar(15) not null default 'Java' comment '语言',
    example_type varchar(15) not null default '' comment '实例类型',
    rpc_type varchar(15) not null default '' comment 'rpc框架类型',
    `version` varchar(15) not null default '' comment '版本号',
    tag varchar(127) not null default '' comment '标签',
    client_version varchar(15) not null default '' comment 'client版本',
    create_time datetime not null default current_timestamp comment '创建时间，上线时间',
    update_time datetime not null default current_timestamp on update current_timestamp comment '更新时间，下线时间', 
    is_delete int unsigned not null default 1  comment '数据状态',
    primary key (`id`),
     unique key unique_path_version(`network_address`,`protocol`,`create_time`)
);

create table interface_info(
    id bigint unsigned not null auto_increment,
    application_id bigint unsigned not null comment '项目id',
    application_english_name varchar(31) not null comment '项目英文',
    organization_type_enum varchar(31) not null comment '组织类型[ API,实例 两个]',
    networkAddress int unsigned not null  default 0 comment '网络地址' ,
    port  int unsigned not null  default 0 comment '端口',
    protocol varchar(15) not null default '' comment '协议[http1.0，http2.0, dubbo, grpc......]',
    `language` varchar(15) not null default 'Java' comment '语言',
    example_type varchar(15) not null default '' comment '实例类型',
    rpc_type varchar(15) not null default '' comment 'rpc框架类型',
    `version` varchar(15) not null default '' comment '版本号',
    client_version varchar(15) not null default '' comment '电子client版本',
    `path` varchar(255) not null default '' comment 'api路径',
    http_method_type varchar(127) not null default '' comment 'http协议请求方法',
    module_name varchar(127) not null default '' comment '模块名',
    interace_name varchar(127) not null default '' comment '接口名',
    method_name varchar(127) not null default '' comment '方法名',
    class_name varchar(127) not null default '' comment 'dubbo或者其他协议需要，也方便查找',
    `explain` varchar(127) not null default '' comment '说明',
    create_time datetime not null default current_timestamp comment '创建时间，上线时间',
    update_time datetime not null default current_timestamp on update current_timestamp comment '更新时间，下线时间', 
    is_delete int unsigned not null default 1  comment '数据状态',
    primary key (`id`),
    unique key unique_path_version(`path`,`version`,`rpc_type`)
);
-- 量好计算，请求时间怎么计算
-- TP如何处理，配置
-- 
create  table statistic_info(
    id bigint unsigned not null auto_increment,
    organization_type_enum  varchar(15) not null comment '统计维度',
    application_id bigint unsigned not null comment '项目id',
    application_english_name varchar(31) not null comment '项目英文', 
    organization_id bigint unsigned not null comment '组织id[ 项目，实例，]',
    organization_name varchar(31) not null comment '名', 
    time_dimension varchar(15) not null comment '时间维度',
    time_spot datetime not null comment '统计的时间点',
    request_num int unsigned not null default 0 comment '请求总量',
    ablility_refuse_num int unsigned not null default 0 comment '动作拒绝总量',
    resources_request_num int unsigned not null default 0 comment '资源请求总量，只有项目维度才会有',
    cache_request_num  int unsigned not null default 0 comment '缓存处理量',
    downstream_request_num  int unsigned not null default 0 comment '下游请求量，有项目或则动作',
    downstream_service_error int unsigned not null default 0 comment '下游请求量，异常数',
    downstream_service_out_time int unsigned not null default 0 comment '下游超时数',
    downstream_request_average_time int unsigned not null default 0 comment '平均时间，这个平均时间', 
    primary key(`id`)
);

create table type_metabigint (
    tm_id bigint unsigned not null auto_increment,
    api_id  bigint unsigned not null comment 'apiId',
    tm_class_id bigint unsigned not null default 0 comment '等于tm_id',
    tm_name varchar(31) not null comment '参数名',
    tm_china_name varchar(31) not null comment '参数中文名',
    tm_index int unsigned not null comment'参数索引',
    tm_spot varchar(15) not null default '' comment '参数获取点',
    tm_use_type   varchar(31) not null comment '参数使用类型',
    tm_spot_type varchar(31) not null comment '是入参还是返回',
    tm_class_type varchar(31) not null comment '参数类型',
    tm_type_full_name varchar(127) not null default '' comment '完全类型',
    tm_paradigm int unsigned not null default 0 comment '是否是模板',
    tm_paradimg varchar(255) not null default '' comment '参数值说明',
    tm_explain varchar(511) not null default ''comment '参数值说明',
    tm_version varchar(15) not null default '' comment '版本号',
    tm_check_expression varchar(63) not null default '' comment '校验表达式',
    create_time datetime not null default current_timestamp comment '创建时间',
    update_time datetime not null default current_timestamp on update current_timestamp comment '更新时间', 
    is_delete int unsigned not null default 1  comment '数据状态',
    primary key (`tm_id`)
);
