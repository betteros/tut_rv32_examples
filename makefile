HOST ?= riscv64-unknown-elf
CFLAGS ?= -march=rv32imac -mabi=ilp32 -mcmodel=medany 
PROGRAM ?= breathe

build:
	$(HOST)-gcc -c -O2 $(CFLAGS) src/$(PROGRAM).S -o $(PROGRAM).o
	$(HOST)-gcc -O2 -fno-builtin-printf -g $(CFLAGS) $(PROGRAM).o -o $(PROGRAM) -T config/flash.lds -nostartfiles

upload:
	openocd -f config/openocd.cfg &
	$(HOST)-gdb $(PROGRAM) --batch -ex "set remotetimeout 240" -ex "target extended-remote localhost:3333" -ex "monitor reset halt" -ex "monitor flash protect 0 64 last off" -ex "load" -ex "monitor resume" -ex "monitor shutdown" -ex "quit"
	echo "Successfully uploaded "'"$(PROGRAM)"'" to freedom-e300-hifive1."

dont:
#	$(HOST)-gcc -O2 -fno-builtin-printf -DNO_INIT -g $(CFLAGS) -I/home/prushik/sand/freedom-e-sdk/bsp/include -I/home/prushik/sand/freedom-e-sdk/bsp/drivers/ -I/home/prushik/sand/freedom-e-sdk/bsp/env -I/home/prushik/sand/freedom-e-sdk/bsp/env/freedom-e300-hifive1 /home/prushik/sand/freedom-e-sdk/bsp/env/start.o /home/prushik/sand/freedom-e-sdk/bsp/env/entry.o $(PROGRAM).o /home/prushik/sand/freedom-e-sdk/bsp/env/freedom-e300-hifive1/init.o -o $(PROGRAM) -Wl,--wrap=malloc -Wl,--wrap=free -Wl,--wrap=open -Wl,--wrap=lseek -Wl,--wrap=read -Wl,--wrap=write -Wl,--wrap=fstat -Wl,--wrap=stat -Wl,--wrap=close -Wl,--wrap=link -Wl,--wrap=unlink -Wl,--wrap=execve -Wl,--wrap=fork -Wl,--wrap=getpid -Wl,--wrap=kill -Wl,--wrap=wait -Wl,--wrap=isatty -Wl,--wrap=times -Wl,--wrap=sbrk -Wl,--wrap=_exit -Wl,--wrap=puts -Wl,--wrap=_malloc -Wl,--wrap=_free -Wl,--wrap=_open -Wl,--wrap=_lseek -Wl,--wrap=_read -Wl,--wrap=_write -Wl,--wrap=_fstat -Wl,--wrap=_stat -Wl,--wrap=_close -Wl,--wrap=_link -Wl,--wrap=_unlink -Wl,--wrap=_execve -Wl,--wrap=_fork -Wl,--wrap=_getpid -Wl,--wrap=_kill -Wl,--wrap=_wait -Wl,--wrap=_isatty -Wl,--wrap=_times -Wl,--wrap=_sbrk -Wl,--wrap=__exit -Wl,--wrap=_puts -L. -Wl,--start-group -lwrap -lc -Wl,--end-group -T /home/prushik/sand/freedom-e-sdk/bsp/env/freedom-e300-hifive1/flash.lds -nostartfiles -L/home/prushik/sand/freedom-e-sdk/bsp/env
