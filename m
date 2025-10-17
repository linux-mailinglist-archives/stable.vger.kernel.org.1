Return-Path: <stable+bounces-187686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEEABEB14E
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 19:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EECEB4E796F
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28222306D47;
	Fri, 17 Oct 2025 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWbsHMG2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58F12E4254;
	Fri, 17 Oct 2025 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760722441; cv=none; b=uH1FNyzt/yqlXOTB9SMsejrSucnRb6yHKXHrI+P8vV63Z8yXFVYTZVSZGRxp1znOww7s9nYaJDxDM4noPivgvCVcgfok+MtyTlbV1pD5Ea0ibdy6EcmLcn8s89M2oE3eZwOzeq2DyGwfykONBa6JJQIi4txfx/sVN7nQGUp+ViU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760722441; c=relaxed/simple;
	bh=Q0QoUkpt2xUYIfX09AQuImr55777CNwie12QlXnh3ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FyHj5bXD2EN4AlNP8Nk9LBg4BJe660H9Mt17exei24c9ghWYTYd75Z8tnbE4tojwMujwFuqA7aGMG9AFczXeHppCdK0xm2ddnXU8yYdL4rzrb2DzghYVI2yQHxQDyavYGbElu5zHjZghdPO22aaaYoelOP0kg9KeZBbtABSfyiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWbsHMG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F7DC4CEE7;
	Fri, 17 Oct 2025 17:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760722441;
	bh=Q0QoUkpt2xUYIfX09AQuImr55777CNwie12QlXnh3ak=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZWbsHMG2rL7Uob9SpbYui0ijtJ9eOsLfe+z0ap6YaqT8Qm5CsaU/bebVqrpaSpXyb
	 Yc42GV4zFwYzJuF5EAJN8x7CkiymcUzNi0zqrdZqNy8zdZBtlr6qY7/s0r0OTMFP/g
	 RclpvQiXIyRxzrTfa/NWMgxbBRgwqfx2bQuWr0tXX4YGzpcWTqG4G9OfLD0dCc/CE2
	 zIYa8ImRPm4zcPRXDzLLQfxebl+7Ey8FqXXvshks7stpvtS6uX2KPYTsIGpHj2TWkU
	 rq7fYebhk2os8g118aX2jtFlhkpnb/JczTJFT9Gtru7MWC0GA45XdDHv5lA1UtP9d1
	 wBjB4edMq5ZwA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Oct 2025 19:33:41 +0200
Subject: [PATCH 5.4.y 4/5] arch: back to -std=gnu89 in < v5.18
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-v5-4-gcc-15-v1-4-6d6367ee50a1@kernel.org>
References: <20251017-v5-4-gcc-15-v1-0-6d6367ee50a1@kernel.org>
In-Reply-To: <20251017-v5-4-gcc-15-v1-0-6d6367ee50a1@kernel.org>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
 Alexey Dobriyan <adobriyan@gmail.com>, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5445; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Q0QoUkpt2xUYIfX09AQuImr55777CNwie12QlXnh3ak=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI+1f55rxp/vDRgTX+B45Kp/3497Dzuybv8zyX7A96Mt
 d2F3/XjOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbC2c/IsFj/MEvWbY+0mcc0
 LAxv6k2ep7XEKrt3QngPn16T3S4DLkaG1/EWog2XmJRXnpN9VikmtSlkWsPmWt+iR6ILtvnyLjn
 EAgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recent fixes have been backported to < v5.18 to fix build issues with
GCC 5.15. They all force -std=gnu11 in the CFLAGS, "because [the kernel]
requests the gnu11 standard via '-std=' in the main Makefile".

This is true for >= 5.18 versions, but not before. This switch to
-std=gnu11 has been done in commit e8c07082a810 ("Kbuild: move to
-std=gnu11").

For a question of uniformity, force -std=gnu89, similar to what is done
in the main Makefile.

Note: the fixes tags below refers to upstream commits, but this fix is
only for kernels not having commit e8c07082a810 ("Kbuild: move to
-std=gnu11").

Fixes: 7cbb015e2d3d ("parisc: fix building with gcc-15")
Fixes: 3b8b80e99376 ("s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS")
Fixes: b3bee1e7c3f2 ("x86/boot: Compile boot code with -std=gnu11 too")
Fixes: ee2ab467bddf ("x86/boot: Use '-std=gnu11' to fix build with GCC 15")
Fixes: 8ba14d9f490a ("efi: libstub: Use '-std=gnu11' to fix build with GCC 15")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Note:
  An alternative is to backport commit e8c07082a810 ("Kbuild: move to
  -std=gnu11"), but I guess we might not want to do that for stable, as
  it might introduce new warnings.

Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/parisc/boot/compressed/Makefile  | 2 +-
 arch/s390/Makefile                    | 2 +-
 arch/s390/purgatory/Makefile          | 2 +-
 arch/x86/Makefile                     | 2 +-
 arch/x86/boot/compressed/Makefile     | 2 +-
 drivers/firmware/efi/libstub/Makefile | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compressed/Makefile
index 98d69488e5c2..92cab904f1ba 100644
--- a/arch/parisc/boot/compressed/Makefile
+++ b/arch/parisc/boot/compressed/Makefile
@@ -21,7 +21,7 @@ KBUILD_CFLAGS += -fno-PIE -mno-space-regs -mdisable-fpregs -Os
 ifndef CONFIG_64BIT
 KBUILD_CFLAGS += -mfast-indirect-calls
 endif
-KBUILD_CFLAGS += -std=gnu11
+KBUILD_CFLAGS += -std=gnu89
 
 OBJECTS += $(obj)/head.o $(obj)/real2.o $(obj)/firmware.o $(obj)/misc.o $(obj)/piggy.o
 
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 22dc393b5a83..287b853a7f09 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -23,7 +23,7 @@ endif
 aflags_dwarf	:= -Wa,-gdwarf-2
 KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
 KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
-KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -std=gnu11
+KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -std=gnu89
 KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index 2f4d8422bdfb..facd0b3db637 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -20,7 +20,7 @@ GCOV_PROFILE := n
 UBSAN_SANITIZE := n
 KASAN_SANITIZE := n
 
-KBUILD_CFLAGS := -std=gnu11 -fno-strict-aliasing -Wall -Wstrict-prototypes
+KBUILD_CFLAGS := -std=gnu89 -fno-strict-aliasing -Wall -Wstrict-prototypes
 KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 69930ed5574b..424ee0e1f23d 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -31,7 +31,7 @@ endif
 CODE16GCC_CFLAGS := -m32 -Wa,$(srctree)/arch/x86/boot/code16gcc.h
 M16_CFLAGS	 := $(call cc-option, -m16, $(CODE16GCC_CFLAGS))
 
-REALMODE_CFLAGS	:= -std=gnu11 $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING \
+REALMODE_CFLAGS	:= -std=gnu89 $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
 		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=none)
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index e436819859d9..5771d5b43bb8 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -27,7 +27,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 	vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4
 
 KBUILD_CFLAGS := -m$(BITS) -O2
-KBUILD_CFLAGS += -std=gnu11
+KBUILD_CFLAGS += -std=gnu89
 KBUILD_CFLAGS += -fno-strict-aliasing $(call cc-option, -fPIE, -fPIC)
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 cflags-$(CONFIG_X86_32) := -march=i386
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 0dc80564bbd2..00622027a49f 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -7,7 +7,7 @@
 #
 cflags-$(CONFIG_X86_32)		:= -march=i386
 cflags-$(CONFIG_X86_64)		:= -mcmodel=small
-cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -O2 -std=gnu11 \
+cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -O2 -std=gnu89 \
 				   -fPIC -fno-strict-aliasing -mno-red-zone \
 				   -mno-mmx -mno-sse -fshort-wchar \
 				   -Wno-pointer-sign \

-- 
2.51.0


