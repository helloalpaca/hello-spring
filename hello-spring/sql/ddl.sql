drop table if exists member CASCADE;
create table member
(
    id bigint AUTO_INCREMENT,
    name varchar(255),
    primary key (id)
);

insert into member(name) values("spring");
insert into member(name) values("spring2");
select * from member;
