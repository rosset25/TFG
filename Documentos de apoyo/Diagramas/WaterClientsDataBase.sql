create table Tenant (
    id bigint unsigned not null auto_increment,
    name varchar(225) not null,

    primary key (id),
    unique key uniqueName (name)
);


create table User (
    id bigint unsigned not null auto_increment,
    tenantId bigint unsigned not null,
    email varchar(225) not null,
    enabled boolean not null,
    password varchar(255) not null,

    primary key (id),
    unique key uniqueEmail (email),

    constraint fk_User_Tenant_id foreign key (tenantId) references Tenant(id)
);


create table Watermeter (
    id bigint unsigned not null auto_increment,
    tenantId bigint unsigned not null,
    meter varchar(225) not null,
    policy varchar(225) not null,
    address varchar(255) not null,

    primary key (id),
    unique key uniqueMeter (tenantId, meter),

    constraint fk_Watermeter_Tenant_id foreign key (tenantId) references Tenant(id)
);

create table UserWatermeter (
    meterId bigint unsigned not null,
    userId bigint unsigned not null,

    primary key (meterId, userId),

    -- No se crea un índice para esta clave ajena ya que lo cubre la clave primaria.
    constraint fk_UserWatermeter_Watermeter_id foreign key (meterId) references Watermeter(id),
    constraint fk_UserWatermeter_User_id foreign key (userId) references User(id)
);

create table persistent_logins (
    username varchar(64) not null,
    series varchar(64) primary key,
    token varchar(64) not null,
    last_used timestamp not null
);

create table AdditionalWatermeterData (

    meterId bigint unsigned not null,
    washingmachine boolean not null,
    dishwasher boolean not null,
    bottleWater boolean not null,
    numBath int unsigned not null,
    numPerson int unsigned not null,
    numChild int unsigned not null,

    primary key (meterId),

    constraint fk_AdditionalData_Watermeter_id foreign key (meterId) references Watermeter(id)
);
