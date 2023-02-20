create table board(	
    idx int not null auto_increment,
	memId varchar(100) not null, 
	title varchar(100) not null,
	content varchar(2000) not null,
	writer varchar(30) not null,
	indate datetime default now(),
	count int default 0,
	primary key(idx)
);

drop table board;

insert into board(title,content,writer)
values('게시판 연습','게시판 연습','관리자');

insert into board(title,content,writer)
values('게시판 연습','게시판 연습','박매일');

insert into board(title,content,writer)
values('게시판 연습','게시판 연습','장영우');

select * from board;

create table member(
  memId varchar(100) not null,
  memPwd varchar(50) not null,
  memName varchar(50) not null,
  primary key(memId)
);
insert into member values('smhrd01','smhrd01','관리자');
insert into member values('smhrd02','smhrd02','박매일');
insert into member values('smhrd03','smhrd03','장영우');

select * from member;


