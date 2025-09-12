FILE_SIZE=6144
DATA_OFFS=6088
TARGET=flash.bin-with_conf

all:
	@echo "make extra, $(TARGET), rm_$(TARGET), rm_extra"

$(TARGET): .config flash_evk.log print_fit_hab.log
	@dd if=/dev/zero of=$@ bs=512 count=$(FILE_SIZE) 2>/dev/null
	@dd if=flash.bin of=$@ bs=512 seek=0 conv=notrunc 2>/dev/null
	@tar -czhf - $^ | dd of=$@ bs=512 seek=$(DATA_OFFS) conv=notrunc 2>/dev/null
	
extra:
	@dd if=$(TARGET) bs=512 skip=$(DATA_OFFS) 2>/dev/null | tar -xzf -

rm_extra:
	rm -rf .config flash_evk.log print_fit_hab.log

rm_$(TARGET):
	rm -rf $(TARGET)
