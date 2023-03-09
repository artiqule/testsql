3. PL/SQL – описать результат выполнения анонимного блока

declare
  vID number := 3;
  vFIO varchar2(200);
begin
  select FIO
  into vFIO
  from (select 1 as ID, 'Иванов Иван Иванович' as FIO from dual
        union all
        select 2 as ID, 'Сергеев Сергей Сергеевич' as FIO from dual)
  where ID=vID;
  dbms_output.put_line('ФИО: '||vFIO);
end;
