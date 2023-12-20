all:
	mkdir -p release
	cc main.c glad_gl.c -I inc -Ofast -lglfw -lm -o release/shooter
	strip --strip-unneeded release/shooter
	upx --lzma --best release/shooter

test:
	cc main.c glad_gl.c -I inc -Ofast -lglfw -lm -o /tmp/shooter_test
	/tmp/shooter_test
	rm /tmp/shooter_test

web:
	emcc main.c glad_gl.c -DWEB -O3 --closure 1 -s FILESYSTEM=0 -s USE_GLFW=3 -s ENVIRONMENT=web -s TOTAL_MEMORY=128MB -I inc -o bin/index.html --shell-file t.html

run:
	emrun bin/index.html

win:
	i686-w64-mingw32-gcc main.c glad_gl.c -Ofast -I inc -L. -lglfw3dll -lm -o SeriousShooter.exe
	strip --strip-unneeded SeriousShooter.exe
	upx --lzma --best SeriousShooter.exe

clean:
	rm -f -r release
	rm -f SeriousShooter.exe
	rm -f bin/index.html
	rm -f bin/index.js
	rm -f bin/index.wasm
