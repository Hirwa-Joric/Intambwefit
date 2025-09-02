rmdir /s /q wger\core\static\yarn\ > NUL 2>&1
mkdir wger\core\static\yarn\
xcopy /E /I /Y node_modules\* wger\core\static\yarn\