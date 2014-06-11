include theos/makefiles/common.mk

TWEAK_NAME = BasicAnalyzer
${TWEAK_NAME}_FILES = $(shell find . -name '*.m' -print) 
${TWEAK_NAME}_FILES += $(shell find . -name '*.xmi' -print)

${TWEAK_NAME}_CFLAGS = -include Tweak-Prefix.pch
${TWEAK_NAME}_LDFLAGS = -Llib -lAAClientLib

ADDITIONAL_CCFLAGS  = -Qunused-arguments

include $(THEOS_MAKE_PATH)/tweak.mk

#after-install::
#	install.exec "killall -9 SpringBoard"
