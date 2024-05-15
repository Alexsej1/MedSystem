Разработайте графовую базу данных MeDSystem для управления информацией о пациентах, врачах, отделениях, лекарствах.


Структура базы данных:

Узлы:
Пациенты (Patients),
Врачи (Doctors),
Отделения (Departments),
Лекарства (Medications),


Рёбра:
Пациенты знакомы друг с другом по палате (Knows),
Врачи лечат пациентов (TreatedBy),
Пациенты принадлежат к отделениям (BelongsToDepartment),
Врачи работают в отделениях (WorksInDepartment),
Пациенты принимают лекарства (TakesMedication),
Врачи назначают лекарства (PrescribesMedication)