LOCAL_PATH:= $(call my-dir)

# Build static binary
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	twrpTarMain.cpp \
	twrp-functions.cpp \
	twrpTar.cpp \
	tarWrite.c \
	twrpDU.cpp
LOCAL_CFLAGS:= -g -c -W -DBUILD_TWRPTAR_MAIN

LOCAL_C_INCLUDES += bionic external/stlport/stlport
LOCAL_STATIC_LIBRARIES := libc libtar_static libstlport_static libstdc++

ifeq ($(TWHAVE_SELINUX), true)
    LOCAL_C_INCLUDES += external/libselinux/include
    LOCAL_STATIC_LIBRARIES += libselinux
    LOCAL_CFLAGS += -DHAVE_SELINUX -g
endif
ifneq ($(RECOVERY_SDCARD_ON_DATA),)
	LOCAL_CFLAGS += -DRECOVERY_SDCARD_ON_DATA
endif
ifeq ($(TW_EXCLUDE_ENCRYPTED_BACKUPS), true)
    LOCAL_CFLAGS += -DTW_EXCLUDE_ENCRYPTED_BACKUPS
else
	LOCAL_STATIC_LIBRARIES += libopenaes_static
endif

LOCAL_MODULE:= twrpTar
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_MODULE_TAGS:= eng
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
include $(BUILD_EXECUTABLE)

