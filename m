Return-Path: <stable+bounces-192440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF750C3298C
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 19:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9E334F59CA
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 18:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B718D343D86;
	Tue,  4 Nov 2025 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7oSGJKU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7515133EB1D
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280079; cv=none; b=pV0R5Am6u8PzMc5rDaZxPkUyGeVI6VZcqkzRWFMt4wl4Gk5D0Ti9SeaTvnBbQQQzWxNGSyoYXXZiFlWePlZwGcpzP7PqIsHU1Iwud67NDtQHW/pL3SCfgIki2VPAoKEJzinpUC9Z1aJZd2OcWw5vrS6MGs1I+jVuV+AQTUdp6z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280079; c=relaxed/simple;
	bh=MJXU2Udo8va0PjQlGfOYyp5B9o7fcaBVXVFHG7lIfPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cl9MtXycYYnLfatkVyYo9pIV/JhBWhbmnjO2f5LMvasHIoDZyow+JkCnfhPM9bYucRFnTlTqaDqcqx2gQjsw8aVD7U6ZX/77BogYINaQod6IDrsg+WBPwBwjqbhuo1CEIn+vlLmD2n8z8fcFTe4iubwpgjtR2Cz35ZYenplOa5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7oSGJKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F65C4CEF8;
	Tue,  4 Nov 2025 18:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762280079;
	bh=MJXU2Udo8va0PjQlGfOYyp5B9o7fcaBVXVFHG7lIfPM=;
	h=From:To:Cc:Subject:Date:From;
	b=O7oSGJKUK/3KSIOoelWaV/I+xk3z/vPeHc+UR8giZtDRfyC5s6h44uiQpA2y8T4Sn
	 XhqLZ3zONTgQrIsFLmqZuC5OHLAZYMEFVuKqdkk4GKgGWypv7TZjO6nb1LCLlfOqw4
	 UlO4NEqM7xbtqMd7VklbAkQHbvycqSmydS5VyyFClCsSztoXk56CMvfYtid98D2Kyj
	 C/2IA6U2/A1kMTHmGsEoKMWSG/9Jbb7ZwnGHZQrg5Z0px5rfZHCiYpA8GcCebloH6E
	 mx7rUUGalWssvxE0ZIgJS9pqlsP/dADz3goPdhavs50DAUxcGs47GtlL4vascP4A+Q
	 +r/BA0IfUtE0A==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 5.10] Makefile.compiler: replace cc-ifversion with compiler-specific macros
Date: Tue,  4 Nov 2025 11:14:27 -0700
Message-ID: <20251104181427.3261962-1-nathan@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nick Desaulniers <ndesaulniers@google.com>

commit 88b61e3bff93f99712718db785b4aa0c1165f35c upstream.

cc-ifversion is GCC specific. Replace it with compiler specific
variants. Update the users of cc-ifversion to use these new macros.

Link: https://github.com/ClangBuiltLinux/linux/issues/350
Link: https://lore.kernel.org/llvm/CAGG=3QWSAUakO42kubrCap8fp-gm1ERJJAYXTnP1iHk_wrH=BQ@mail.gmail.com/
Suggested-by: Bill Wendling <morbo@google.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
[nathan: Backport to 5.10 and eliminate instances of cc-ifversion that
         did not exist upstream when this change was original created]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Documentation/kbuild/makefiles.rst            | 29 +++++++++++--------
 Makefile                                      |  4 ++-
 arch/mips/loongson64/Platform                 |  2 +-
 arch/powerpc/Makefile                         |  4 ++-
 arch/s390/Makefile                            |  4 +--
 drivers/gpu/drm/amd/display/dc/calcs/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |  2 +-
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   |  2 +-
 scripts/Kbuild.include                        | 10 +++++--
 12 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 0d5dd5413af0..6f7d0e33c1a7 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -552,22 +552,27 @@ more details, with real examples.
 	In the above example, -Wno-unused-but-set-variable will be added to
 	KBUILD_CFLAGS only if gcc really accepts it.
 
-    cc-ifversion
-	cc-ifversion tests the version of $(CC) and equals the fourth parameter
-	if version expression is true, or the fifth (if given) if the version
-	expression is false.
+    gcc-min-version
+	gcc-min-version tests if the value of $(CONFIG_GCC_VERSION) is greater than
+	or equal to the provided value and evaluates to y if so.
 
 	Example::
 
-		#fs/reiserfs/Makefile
-		ccflags-y := $(call cc-ifversion, -lt, 0402, -O1)
+		cflags-$(call gcc-min-version, 70100) := -foo
 
-	In this example, ccflags-y will be assigned the value -O1 if the
-	$(CC) version is less than 4.2.
-	cc-ifversion takes all the shell operators:
-	-eq, -ne, -lt, -le, -gt, and -ge
-	The third parameter may be a text as in this example, but it may also
-	be an expanded variable or a macro.
+	In this example, cflags-y will be assigned the value -foo if $(CC) is gcc and
+	$(CONFIG_GCC_VERSION) is >= 7.1.
+
+    clang-min-version
+	clang-min-version tests if the value of $(CONFIG_CLANG_VERSION) is greater
+	than or equal to the provided value and evaluates to y if so.
+
+	Example::
+
+		cflags-$(call clang-min-version, 110000) := -foo
+
+	In this example, cflags-y will be assigned the value -foo if $(CC) is clang
+	and $(CONFIG_CLANG_VERSION) is >= 11.0.0.
 
     cc-cross-prefix
 	cc-cross-prefix is used to check if there exists a $(CC) in path with
diff --git a/Makefile b/Makefile
index aa84aec9cbe8..5e5c4ca0db4e 100644
--- a/Makefile
+++ b/Makefile
@@ -855,7 +855,9 @@ DEBUG_CFLAGS	:=
 # Workaround for GCC versions < 5.0
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=61801
 ifdef CONFIG_CC_IS_GCC
-DEBUG_CFLAGS	+= $(call cc-ifversion, -lt, 0500, $(call cc-option, -fno-var-tracking-assignments))
+ifneq ($(call gcc-min-version, 50000),y)
+DEBUG_CFLAGS	+= $(call cc-option, -fno-var-tracking-assignments)
+endif
 endif
 
 ifdef CONFIG_DEBUG_INFO
diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
index e2354e128d9a..76f44ca09b9d 100644
--- a/arch/mips/loongson64/Platform
+++ b/arch/mips/loongson64/Platform
@@ -12,7 +12,7 @@ cflags-$(CONFIG_CPU_LOONGSON64)	+= -Wa,--trap
 # by GAS.  The cc-option can't probe for this behaviour so -march=loongson3a
 # can't easily be used safely within the kbuild framework.
 #
-ifeq ($(call cc-ifversion, -ge, 0409, y), y)
+ifeq ($(call gcc-min-version, 40900), y)
   ifeq ($(call ld-ifversion, -ge, 225000000, y), y)
     cflags-$(CONFIG_CPU_LOONGSON64)  += \
       $(call cc-option,-march=loongson3a -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 912e64ab5f24..d92141eb3215 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -168,7 +168,9 @@ endif
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44199
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52828
 ifndef CONFIG_CC_IS_CLANG
-CC_FLAGS_FTRACE	+= $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)
+ifneq ($(call gcc-min-version, 40900),y)
+CC_FLAGS_FTRACE	+= -mno-sched-epilog
+endif
 endif
 endif
 
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 92f2426d8797..98c019abd0ad 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -35,8 +35,8 @@ KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
 
 ifdef CONFIG_CC_IS_GCC
-	ifeq ($(call cc-ifversion, -ge, 1200, y), y)
-		ifeq ($(call cc-ifversion, -lt, 1300, y), y)
+	ifeq ($(call gcc-min-version, 120000), y)
+		ifneq ($(call gcc-min-version, 130000), y)
 			KBUILD_CFLAGS += $(call cc-disable-warning, array-bounds)
 			KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, array-bounds)
 		endif
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
index 4674aca8f206..cb7c37ef8735 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
@@ -34,7 +34,7 @@ calcs_ccflags := -mhard-float -maltivec
 endif
 
 ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+ifneq ($(call gcc-min-version, 70100),y)
 IS_OLD_GCC = 1
 endif
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index 54db9af8437d..ce9ab2214a43 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -18,7 +18,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o := -mhard-float -maltivec
 endif
 
 ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+ifneq ($(call gcc-min-version, 70100),y)
 IS_OLD_GCC = 1
 endif
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
index 90eefd2c3ecf..a85877767d3c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
@@ -14,7 +14,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -maltivec
 endif
 
 ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+ifneq ($(call gcc-min-version, 70100),y)
 IS_OLD_GCC = 1
 endif
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index bd2a068f9863..a71c0f298380 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -47,7 +47,7 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mgeneral-regs-only
 endif
 
 ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+ifneq ($(call gcc-min-version, 70100),y)
 IS_OLD_GCC = 1
 endif
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index ce8251151b45..1ee735af6ddd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -35,7 +35,7 @@ dml_ccflags := -mhard-float -maltivec
 endif
 
 ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+ifneq ($(call gcc-min-version, 70100),y)
 IS_OLD_GCC = 1
 endif
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
index ea29cf95d470..6207809f293b 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
@@ -11,7 +11,7 @@ dsc_ccflags := -mhard-float -maltivec
 endif
 
 ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+ifneq ($(call gcc-min-version, 70100),y)
 IS_OLD_GCC = 1
 endif
 endif
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 3e5c8d09d82c..ccd7b09a379d 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -133,9 +133,13 @@ cc-option-yn = $(call try-run,\
 cc-disable-warning = $(call try-run,\
 	$(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
 
-# cc-ifversion
-# Usage:  EXTRA_CFLAGS += $(call cc-ifversion, -lt, 0402, -O1)
-cc-ifversion = $(shell [ $(CONFIG_GCC_VERSION)0 $(1) $(2)000 ] && echo $(3) || echo $(4))
+# gcc-min-version
+# Usage: cflags-$(call gcc-min-version, 70100) += -foo
+gcc-min-version = $(shell [ $(CONFIG_GCC_VERSION)0 -ge $(1)0 ] && echo y)
+
+# clang-min-version
+# Usage: cflags-$(call clang-min-version, 110000) += -foo
+clang-min-version = $(shell [ $(CONFIG_CLANG_VERSION)0 -ge $(1)0 ] && echo y)
 
 # ld-option
 # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
-- 
2.51.2


