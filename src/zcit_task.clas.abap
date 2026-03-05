CLASS zcit_task DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcit_task IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: lt_students TYPE TABLE OF zcit_db,
          ls_student  TYPE zcit_db.

* CREATE (UPSERT)

    ls_student-id = 1.
    ls_student-name = 'Alice'.
    ls_student-marks = 30.
    APPEND ls_student TO lt_students.

    CLEAR ls_student.

    ls_student-id = 2.
    ls_student-name = 'Bob'.
    ls_student-marks = 20.
    APPEND ls_student TO lt_students.

    MODIFY zcit_db FROM TABLE @lt_students.

    IF sy-subrc = 0.
      out->write( 'Records inserted successfully' ).
    ENDIF.


* READ

    SELECT SINGLE *
      FROM zcit_db
      WHERE id = 1
      INTO @ls_student.

    IF sy-subrc = 0.
      out->write( |Student Name: { ls_student-name } Marks: { ls_student-marks }| ).
    ENDIF.


* UPDATE

    UPDATE zcit_db
      SET marks = 85
      WHERE id = 1.

    IF sy-subrc = 0.
      out->write( 'Marks updated successfully' ).
    ENDIF.


* DELETE

    DELETE FROM zcit_db
      WHERE id = 2.

    IF sy-subrc = 0.
      out->write( 'Record deleted successfully' ).
    ENDIF.


* FINAL DISPLAY

    SELECT *
      FROM zcit_db
      INTO TABLE @lt_students.

    out->write( lt_students ).

  ENDMETHOD.

ENDCLASS.
