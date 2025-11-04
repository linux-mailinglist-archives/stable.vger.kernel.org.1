Return-Path: <stable+bounces-192441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFC7C32968
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 19:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D5D18880D6
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 18:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB96A343D92;
	Tue,  4 Nov 2025 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fm8fyfgG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897D2343D93
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280094; cv=none; b=UqLF6HJw/Uiz0JAWSl8eeJne7XNGOJrlLDwc3LTpwwAH/CgxkTxZ7stAcGzrh9nWfggTzrcS+a2qxoRcHC/67WQM3V84K/JUzO/7zdK7Q721G0vU2NoS1MCeC5WXqKZQXtzJBz6kpfuhIK9tLmf6LcePqrhC9u1fgAfV+u2qafY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280094; c=relaxed/simple;
	bh=3LiZFhYyEnAzvX/nKdccmlI8PJ9C5v78vZFnz6fU+qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tLzBzGmkgfj0Eeo0ICFmVGg+vdS7R+leQGBDv2ANx7JfvSuHIdTJ/Aj8rEBOOieo83btF5StH2kWll85SUMawwptlpvYXIYvuU4/YfN4UOPEEVs7/fdGssbiNgH6+kMorOehi0j8ufztVzg8Te6XC47YrsJYylqhD9Wm3JGsD24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fm8fyfgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6112C4CEF8;
	Tue,  4 Nov 2025 18:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762280094;
	bh=3LiZFhYyEnAzvX/nKdccmlI8PJ9C5v78vZFnz6fU+qw=;
	h=From:To:Cc:Subject:Date:From;
	b=Fm8fyfgGC37VBkf6Som7C/sxnjZpBrYz668S6IfMoSh8XYR3vdoxUT2uQTjQW3q96
	 WzZ/x7HZxUX/uUi6JXmTs8+3vfkz9wr9Gw59IUAEpjegExsgqT2cMqbq0erEHFTrcv
	 awzFjzbwG1Pvo4kjGhhDkvDnDIgKiXVz9XRP0AsFb/5Eg7N7yhC495hwMDxhdowqHE
	 b6PQtZXtFvq7zTaTDUiQ+yUi32S+mPsVZr2lFYfzEdWNYbZ0oFPMB5ew3JzPhiBtfz
	 p+etU/qSJxneNMY4bgzDjUaqCt0Vekgy3X2zQa8biXNH8IOsMyc9HpEvhqpfS8FvbT
	 vOgHlSTCzHerw==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 5.15] Makefile.compiler: replace cc-ifversion with compiler-specific macros
Date: Tue,  4 Nov 2025 11:14:46 -0700
Message-ID: <20251104181446.3262126-1-nathan@kernel.org>
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
[nathan: Backport to 5.15 and eliminate instances of cc-ifversion that
         did not exist upstream when this change was original created]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Documentation/kbuild/makefiles.rst            | 29 +++++++++++--------
 Makefile                                      |  6 ++--
 arch/mips/loongson64/Platform                 |  2 +-
 arch/s390/Makefile                            |  4 +--
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |  2 +-
 .../gpu/drm/amd/display/dc/dcn301/Makefile    |  2 +-
 .../gpu/drm/amd/display/dc/dcn302/Makefile    |  2 +-
 .../gpu/drm/amd/display/dc/dcn303/Makefile    |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |  2 +-
 scripts/Makefile.compiler                     | 10 +++++--
 13 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index db3af0b45baf..19a1fcc7894a 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -682,22 +682,27 @@ more details, with real examples.
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
index 09bb1b22cd26..3589269e63a2 100644
--- a/Makefile
+++ b/Makefile
@@ -804,7 +804,6 @@ stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
 KBUILD_CFLAGS += $(stackp-flags-y)
 
 KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
-KBUILD_CFLAGS += $(KBUILD_CFLAGS-y)
 
 ifdef CONFIG_CC_IS_CLANG
 KBUILD_CPPFLAGS += -Qunused-arguments
@@ -1043,7 +1042,6 @@ ifdef CONFIG_CC_IS_GCC
 KBUILD_CFLAGS += -Wno-maybe-uninitialized
 endif
 
-ifdef CONFIG_CC_IS_GCC
 # The allocators already balk at large sizes, so silence the compiler
 # warnings for bounds checks involving those possible values. While
 # -Wno-alloc-size-larger-than would normally be used here, earlier versions
@@ -1055,8 +1053,8 @@ ifdef CONFIG_CC_IS_GCC
 # ignored, continuing to default to PTRDIFF_MAX. So, left with no other
 # choice, we must perform a versioned check to disable this warning.
 # https://lore.kernel.org/lkml/20210824115859.187f272f@canb.auug.org.au
-KBUILD_CFLAGS += $(call cc-ifversion, -ge, 0901, -Wno-alloc-size-larger-than)
-endif
+KBUILD_CFLAGS-$(call gcc-min-version, 90100) += -Wno-alloc-size-larger-than
+KBUILD_CFLAGS += $(KBUILD_CFLAGS-y)
 
 # disable invalid "can't wrap" optimizations for signed / pointers
 KBUILD_CFLAGS	+= -fno-strict-overflow
diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
index 3e660d6d3c2b..2335b697beeb 100644
--- a/arch/mips/loongson64/Platform
+++ b/arch/mips/loongson64/Platform
@@ -12,7 +12,7 @@ cflags-$(CONFIG_CPU_LOONGSON64)	+= -Wa,--trap
 # by GAS.  The cc-option can't probe for this behaviour so -march=loongson3a
 # can't easily be used safely within the kbuild framework.
 #
-ifeq ($(call cc-ifversion, -ge, 0409, y), y)
+ifeq ($(call gcc-min-version, 40900), y)
   ifeq ($(call ld-ifversion, -ge, 22500, y), y)
     cflags-$(CONFIG_CPU_LOONGSON64)  += \
       $(call cc-option,-march=loongson3a -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index c8071eb82e2e..19c618979ce7 100644
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
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index 54db9af8437d..57c9a0c6e8ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -18,7 +18,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o := -mhard-float -maltivec
 endif
 
 ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+ifneq ($(call gcc-min-version, 70100), y)
 IS_OLD_GCC = 1
 endif
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
index 347d86848bac..178c4d6f61b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
@@ -14,7 +14,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -maltivec
 endif
 
 ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+ifneq ($(call gcc-min-version, 70100), y)
 IS_OLD_GCC = 1
 endif
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index dfd77b3cc84d..e0fe5bbda7de 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -42,7 +42,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -maltivec
 endif
 
 ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+ifneq ($(call gcc-min-version, 70100), y)
 IS_OLD_GCC = 1
 endif
 CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -mhard-float
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
index 09264716d1dc..fb6bcf77bd8f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
@@ -22,7 +22,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn301/dcn301_resource.o := -mhard-float -maltivec
 endif
 
 ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+ifneq ($(call gcc-min-version, 70100), y)
 IS_OLD_GCC = 1
 endif
 CFLAGS_$(AMDDALPATH)/dc/dcn301/dcn301_resource.o += -mhard-float
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
index 101620a8867a..d157aad86cf9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
@@ -21,7 +21,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -maltivec
 endif
 
 ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+ifneq ($(call gcc-min-version, 70100), y)
 IS_OLD_GCC = 1
 endif
 CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o += -mhard-float
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/Makefile b/drivers/gpu/drm/amd/display/dc/dcn303/Makefile
index 6f7a1f2b49f0..129e6308c712 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/Makefile
@@ -17,7 +17,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn303/dcn303_resource.o := -mhard-float -maltivec
 endif
 
 ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+ifneq ($(call gcc-min-version, 70100), y)
 IS_OLD_GCC = 1
 endif
 CFLAGS_$(AMDDALPATH)/dc/dcn303/dcn303_resource.o += -mhard-float
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
index 4bab97acb155..e3a63f82a69d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
@@ -22,7 +22,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o := -mhard-float -maltivec
 endif
 
 ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+ifneq ($(call gcc-min-version, 70100), y)
 IS_OLD_GCC = 1
 endif
 CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o += -mhard-float
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 36cac3839b50..d5c55926cc5b 100644
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
diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index 3eddd0ab2532..c36b201fddb1 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -61,9 +61,13 @@ cc-option-yn = $(call try-run,\
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


