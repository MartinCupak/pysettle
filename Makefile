# settle:  settle.o
# 	g++ -fPIC -c *.cc *.c
# 	g++ -shared -fPIC -Wl,-install_name,libsettle.so  -o libsettle.so *.o
# 	#objdump -T libsettle.so | grep main

mac: settle.o
#	g++ -Ofast -fPIC -c *.cc *.c
#	g++ -Ofast -shared -fPIC -Wl,-install_name,libsettle.so  -o libsettle.so *.o
	g++ -fPIC -c *.cc *.c
	g++ -shared -fPIC -Wl,-install_name,libsettle.so  -o libsettle.so *.o
	#objdump -T libsettle.so | grep main

linux: settle.o
	gcc -g -Wall -Wno-unused-but-set-variable -Wno-unused-parameter -Wno-unused-variable -Ofast -fPIC -c *.c
	g++ -g -Wall -Wno-unused-but-set-variable -Wno-unused-parameter -Wno-unused-variable -Ofast -fPIC -c *.cc
	g++ -Wall -Ofast -shared -fPIC -Wl,-soname,libsettle.so  -o libsettle.so *.o
	#objdump -T libsettle.so | grep main
	# -Ofast

clean:
	rm -fv *.o

cleaner: clean
	rm -fv *.so *.pyc

install: linux
	sudo cp -arv --preserve=mode,timestamps libsettle.so /usr/local/lib

test:	install
	time python try.py
