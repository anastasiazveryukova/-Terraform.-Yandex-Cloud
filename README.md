# Домашнее задание к занятию «Основы Terraform. Yandex Cloud» Зверюкова Анастасия

### Цели задания

1. Создать свои ресурсы в облаке Yandex Cloud с помощью Terraform.
2. Освоить работу с переменными Terraform.


### Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Исходный код для выполнения задания расположен в директории [**02/src**](https://github.com/netology-code/ter-homeworks/tree/main/02/src).


### Задание 0

1. Ознакомьтесь с [документацией к security-groups в Yandex Cloud](https://cloud.yandex.ru/docs/vpc/concepts/security-groups?from=int-console-help-center-or-nav). 
Этот функционал понадобится к следующей лекции.

------
### Внимание!! Обязательно предоставляем на проверку получившийся код в виде ссылки на ваш github-репозиторий!
------

### Задание 1
В качестве ответа всегда полностью прикладывайте ваш terraform-код в git.
Убедитесь что ваша версия **Terraform** ~>1.12.0

1. Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.
2. Создайте сервисный аккаунт и ключ. [service_account_key_file](https://terraform-provider.yandexcloud.net).
4. Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную **vms_ssh_public_root_key**.
5. Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
6. Подключитесь к консоли ВМ через ssh и выполните команду ``` curl ifconfig.me```.
Примечание: К OS ubuntu "out of a box, те из коробки" необходимо подключаться под пользователем ubuntu: ```"ssh ubuntu@vm_ip_address"```. Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: ```eval $(ssh-agent) && ssh-add``` Вы познакомитесь с тем как при создании ВМ создать своего пользователя в блоке metadata в следующей лекции.;
8. Ответьте, как в процессе обучения могут пригодиться параметры ```preemptible = true``` и ```core_fraction=5``` в параметрах ВМ.

В качестве решения приложите:


- скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес;
- скриншот консоли, curl должен отобразить тот же внешний ip-адрес;
- ответы на вопросы.

<img width="1920" height="396" alt="Снимок экрана 2026-07-13 140039" src="https://github.com/user-attachments/assets/ec4595c3-2157-4142-b901-4a03f494ced2" />

<img width="1651" height="1010" alt="Снимок экрана 2026-07-13 144330" src="https://github.com/user-attachments/assets/d9304f4e-598e-441d-9eaa-9b9ad1e9869a" />

Ошибки были следующие:

В строке platform_id = "standart-v4" должно быть слово standard
Версия v4 неправильная. Согласно документации Yandex.Cloud (https://cloud.yandex.ru/docs/compute/concepts/vm-platforms) платформы могут быть только v1, v2 и v3.
Были попытки изменить версии на 1,2,3 ,ошибка не исчезла, поэтому platform_id я убрала с кода
В строке cores = 1 указано неправильное количество ядер процессора. Согласно документации Yandex.Cloud (https://cloud.yandex.ru/docs/compute/concepts/performance-levels) минимальное количество виртуальных ядер процессора для всех платформ равно двум.

preemptible = true. Этот параметр делает виртуальную машину прерываемой. Смысл в том, что облачный провайдер может принудительно остановить такую ВМ в любой момент — например, если освободятся более приоритетные ресурсы или если с момента запуска прошло 24 часа. Ключевой момент: такая ВМ не гарантирует отказоустойчивость, но работа с такой машиной обходиться дешевле.

core_fraction = 5. Этот параметр задаёт долю ресурсов виртуального процессора (vCPU). Значение 5 означает, что ВМ получит 5% от гарантированного ресурса (например, от квоты на vCPU в облаке). Это напрямую связано с экономией.

### Задание 2

1. Замените все хардкод-**значения** для ресурсов **yandex_compute_image** и **yandex_compute_instance** на **отдельные** переменные. К названиям переменных ВМ добавьте в начало префикс **vm_web_** .  Пример: **vm_web_name**.
2. Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их **default** прежними значениями из main.tf. 
3. Проверьте terraform plan. Изменений быть не должно. 

Вносим изменения в файл main.tf и variables.t

<img width="583" height="234" alt="Снимок экрана 2026-07-14 125556" src="https://github.com/user-attachments/assets/5d54806d-d4c6-4465-897d-8e16dd89866e" />

<img width="600" height="482" alt="Снимок экрана 2026-07-14 125910" src="https://github.com/user-attachments/assets/695f8156-678e-44b0-8e34-4ad916485185" />

<img width="1664" height="249" alt="Снимок экрана 2026-07-13 163432" src="https://github.com/user-attachments/assets/616bffc9-036a-4f41-8e51-9df60117dbc0" />


### Задание 3

1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: **"netology-develop-platform-db"** ,  ```cores  = 2, memory = 2, core_fraction = 20```. Объявите её переменные с префиксом **vm_db_** в том же файле ('vms_platform.tf').  ВМ должна работать в зоне "ru-central1-b"
3. Примените изменения.

Вносим изменения в файл main.tf и vms_platform.tf

<img width="976" height="755" alt="Снимок экрана 2026-07-14 130416" src="https://github.com/user-attachments/assets/399cb435-484d-4005-98f7-27effe557de4" />

<img width="1003" height="775" alt="Снимок экрана 2026-07-14 130521" src="https://github.com/user-attachments/assets/13728c2e-7710-4c03-8de9-f06d33303b14" />

Изменения применены, создана еще одна виртуальная машина

<img width="1920" height="447" alt="Снимок экрана 2026-07-14 110258" src="https://github.com/user-attachments/assets/c35b1ab9-b310-4332-a67a-e7d1c51b10d6" />


### Задание 4

1. Объявите в файле outputs.tf **один** output , содержащий: instance_name, external_ip, fqdn для каждой из ВМ в удобном лично для вас формате.(без хардкода!!!)
2. Примените изменения.

В качестве решения приложите вывод значений ip-адресов команды ```terraform output```.

Файл outputs.tf     https://github.com/anastasiazveryukova/-Terraform.-Yandex-Cloud/blob/main/02/src/outputs.tf

```
output "vm_external_ip_address_develop" {
value = yandex_compute_instance.develop.network_interface[0].nat_ip_address
description = "vm external ip"
}

output "vm_external_ip_address_develop2" {
value = yandex_compute_instance.develop2.network_interface[0].nat_ip_address
description = "vm external ip"
}

```


<img width="1673" height="661" alt="Снимок экрана 2026-07-14 113149" src="https://github.com/user-attachments/assets/03610da3-b6a6-4833-ae74-5060981ace1f" />

### Задание 5

1. В файле locals.tf опишите в **одном** local-блоке имя каждой ВМ, используйте интерполяцию ${..} с НЕСКОЛЬКИМИ переменными по примеру из лекции.
2. Замените переменные внутри ресурса ВМ на созданные вами local-переменные.
3. Примените изменения.

Файл  locals.tf    https://github.com/anastasiazveryukova/-Terraform.-Yandex-Cloud/blob/main/02/src/locals.tf

```
locals {
  lplatform = "netology-develop-platform"
  ldevelop = "develop"
  ldevelop2 = "develop2"
  
  vm_develop_lname = "${ local.lplatform }-${ local.ldevelop }"
  vm_develop2_lname = "${ local.lplatform }-${ local.ldevelop2 }"
}

```
<img width="903" height="247" alt="Снимок экрана 2026-07-14 131055" src="https://github.com/user-attachments/assets/9d818981-d5f1-4d64-b3a0-6323780ef654" />


### Задание 6

1. Вместо использования трёх переменных  ".._cores",".._memory",".._core_fraction" в блоке  resources {...}, объедините их в единую map-переменную **vms_resources** и  внутри неё конфиги обеих ВМ в виде вложенного map(object).  
   ```
   пример из terraform.tfvars:
   vms_resources = {
     web={
       cores=2
       memory=2
       core_fraction=5
       hdd_size=10
       hdd_type="network-hdd"
       ...
     },
     db= {
       cores=2
       memory=4
       core_fraction=20
       hdd_size=10
       hdd_type="network-ssd"
       ...
     }
   }
   ```
3. Создайте и используйте отдельную map(object) переменную для блока metadata, она должна быть общая для всех ваших ВМ.
   ```
   пример из terraform.tfvars:
   metadata = {
     serial-port-enable = 1
     ssh-keys           = "ubuntu:ssh-ed25519 AAAAC..."
   }
   ```  
  
5. Найдите и закоментируйте все, более не используемые переменные проекта.
6. Проверьте terraform plan. Изменений быть не должно.

Описываю переменные ".._cores",".._memory",".._core_fraction" в vms_platform.tf:      https://github.com/anastasiazveryukova/-Terraform.-Yandex-Cloud/blob/main/02/src/vms_platform.tf

<img width="949" height="319" alt="Снимок экрана 2026-07-14 131350" src="https://github.com/user-attachments/assets/17b31194-dfd1-49dc-bb9d-1ee692285277" />

Для блока metadata описываю переменные:

<img width="653" height="214" alt="Снимок экрана 2026-07-14 131635" src="https://github.com/user-attachments/assets/57b64c24-6f56-4fc3-a939-9bf37b405cb0" />

Вношу изменения в файл main.tf и комментируемые не используемые переменные        https://github.com/anastasiazveryukova/-Terraform.-Yandex-Cloud/blob/main/02/src/main.tf

<img width="720" height="658" alt="Снимок экрана 2026-07-14 131713" src="https://github.com/user-attachments/assets/2601c93b-72a8-4f3e-8a73-3fa72c43b9f6" />

<img width="1217" height="308" alt="Снимок экрана 2026-07-14 132032" src="https://github.com/user-attachments/assets/8859a2c4-fb89-400a-9daa-9b0e3478dc09" />

Коды проекта

https://github.com/anastasiazveryukova/-Terraform.-Yandex-Cloud/tree/main/02/src

## Дополнительное задание (со звёздочкой*)

**Настоятельно рекомендуем выполнять все задания со звёздочкой.**   
Они помогут глубже разобраться в материале. Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию. 


------
### Задание 7*

Изучите содержимое файла console.tf. Откройте terraform console, выполните следующие задания: 

1. Напишите, какой командой можно отобразить **второй** элемент списка test_list.
2. Найдите длину списка test_list с помощью функции length(<имя переменной>).
3. Напишите, какой командой можно отобразить значение ключа admin из map test_map.
4. Напишите interpolation-выражение, результатом которого будет: "John is admin for production server based on OS ubuntu-20-04 with X vcpu, Y ram and Z virtual disks", используйте данные из переменных test_list, test_map, servers и функцию length() для подстановки значений.

**Примечание**: если не догадаетесь как вычленить слово "admin", погуглите: "terraform get keys of map"

В качестве решения предоставьте необходимые команды и их вывод.

------

### Задание 8*
1. Напишите и проверьте переменную test и полное описание ее type в соответствии со значением из terraform.tfvars:
```
test = [
  {
    "dev1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117",
      "10.0.1.7",
    ]
  },
  {
    "dev2" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88",
      "10.0.2.29",
    ]
  },
  {
    "prod1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101",
      "10.0.1.30",
    ]
  },
]
```
2. Напишите выражение в terraform console, которое позволит вычленить строку "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117" из этой переменной.
------

------

### Задание 9*

Используя инструкцию https://cloud.yandex.ru/ru/docs/vpc/operations/create-nat-gateway#tf_1, настройте для ваших ВМ nat_gateway. Для проверки уберите внешний IP адрес (nat=false) у ваших ВМ и проверьте доступ в интернет с ВМ, подключившись к ней через serial console. Для подключения предварительно через ssh измените пароль пользователя: ```sudo passwd ubuntu```

### Правила приёма работыДля подключения предварительно через ssh измените пароль пользователя: sudo passwd ubuntu
В качестве результата прикрепите ссылку на MD файл с описанием выполненой работы в вашем репозитории. Так же в репозитории должен присутсвовать ваш финальный код проекта.

**Важно. Удалите все созданные ресурсы**.


### Критерии оценки

Зачёт ставится, если:

* выполнены все задания,
* ответы даны в развёрнутой форме,
* приложены соответствующие скриншоты и файлы проекта,
* в выполненных заданиях нет противоречий и нарушения логики.

На доработку работу отправят, если:

* задание выполнено частично или не выполнено вообще,
* в логике выполнения заданий есть противоречия и существенные недостатки. 
