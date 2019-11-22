use O
go

if object_id('em_email_recipients') is not null drop table em_email_recipients
if object_id('em_email_files') is not null drop table em_email_files
if object_id('em_email') is not null drop table em_email
if object_id('em_email_status') is not null drop table em_email_status
if object_id('em_recipient_type') is not null drop table em_recipient_type
if object_id('em_email_address') is not null drop table em_email_address
go

create table em_email_status(
status_id int not null,
status_name varchar(255) not null,
constraint pk_em_email_status primary key clustered ( status_id ))
go
create unique index idx_em_email_status_name on dbo.em_email_status ( status_name ASC)
go


create table em_recipient_type(
type_id int not null,
type_name varchar(255) not null,
type_description varchar(255) null,
constraint pk_em_recipient_type primary key clustered ( type_id ))
go
create unique index idx_em_recipient_type_name on dbo.em_recipient_type ( type_name ASC)
go

create table em_email_address(
address_id int not null,
address_string varchar(255) not null,
constraint pk_em_email_address primary key clustered ( address_id ))
go
create unique index idx_em_email_address_string on dbo.em_email_address ( address_string ASC)
go

create table em_email(
email_id int not null,
email_sender_id int not null,
email_subject varchar(255) not null,
email_body varchar(255) null,
email_sign_name varchar(255) null,
email_status_id int not null,
constraint pk_em_email primary key clustered ( email_id ))
go
alter table em_email
    add constraint fk_em_email_sender foreign key ( email_sender_id )
    references dbo.em_email_address ( address_id )
go
alter table em_email
    add constraint fk_em_email_status foreign key ( email_status_id )
    references dbo.em_email_status ( status_id )
go
create index idx_em_email_sender on dbo.em_email ( email_sender_id ASC)
create index idx_em_email_subject on dbo.em_email ( email_subject ASC)
create index idx_em_email_sign_name on dbo.em_email ( email_sign_name ASC)
create index idx_em_email_status on dbo.em_email ( email_status_id ASC)
go

create table em_email_recipients(
email_id int not null,
recipient_id int not null,
constraint pk_em_email_recipients primary key clustered ( email_id, recipient_id ))
go
alter table em_email_recipients
    add constraint fk_em_er_email foreign key ( email_id )
    references dbo.em_email ( email_id )
go
alter table em_email_recipients
    add constraint fk_em_er_recipient foreign key ( recipient_id )
    references dbo.em_email_address ( address_id )
go
create index idx_em_er_email on dbo.em_email_recipients ( email_id ASC)
create index idx_em_er_recipient on dbo.em_email_recipients ( recipient_id ASC)
go

create table em_email_files(
email_id int not null,
file_name varchar(255) not null,
constraint pk_em_email_files primary key clustered ( email_id, file_name ))
go
alter table em_email_files
    add constraint fk_em_ef_email foreign key ( email_id )
    references dbo.em_email ( email_id )
go
create index idx_em_ef_email on dbo.em_email_recipients ( email_id ASC)
go


