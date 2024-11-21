Return-Path: <stable+bounces-94527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1D59D4EAE
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 15:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8EE1F21414
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 14:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E661DA10A;
	Thu, 21 Nov 2024 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZfZN1x8"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4451D9591
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732199406; cv=none; b=e7Haajk/DO1QwaevVqtovkU76xVi7IjqTA4AfEsX3VHQAQpt0rI11hAWR3h7WdDd6B4DTs7l/tpZao2MKf1zlvgwdivuj2jEiNHJ+JL4A8fE2ApRWEtuxVHCMfMq3aFY8di3tJRPXt4pVvkFgPKOZbjIHNlSlhL41wrXMt3y7Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732199406; c=relaxed/simple;
	bh=ojzah/ILNlj/OM4tm2bf0ao5YLCaUMs+KB4w0umUBwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PssOuQiKNIwJq2HzqGJz270Sp6EkyGc1nwHiaMVfk6iLqFJELipxS1HKRs/MTtP0yFJ03Jkztv1Pe40xX+R696evPlbXVJ5fVUaahzmPeBtEIfxXUIVkpmHO2W8HLQD31hFT5gV8BGAOO6KM26N9lS1qZcxJLuiGahnBUk2HS4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZfZN1x8; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d3e9e854b8so18471726d6.1
        for <stable@vger.kernel.org>; Thu, 21 Nov 2024 06:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732199403; x=1732804203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kx9TyW32ODc64DAloEjQFPeTyDgeKOv8ziD1S5YwPww=;
        b=BZfZN1x8YBuJnUi+MmQBQ2aPqCp2OkidY3yjlRwB/DdUBdkAm+tPmku7HJmDk+vAzP
         Mirsvulpgn0gu+Xf0FfkqkfHa8CPKuEPVTvluzW8mdbjMKLPCO2M0NTTehII4jupWnl5
         lKluazyVwwGVBAqTTHUd6jzQzSLuIXHOga+la9/2MXgJH+I0bhC/oZN/QC5YbKYX9fZZ
         ofxIk4Gm0Ard6v4iPA+0kBomc9xQApATm+flo4I4d8XA5qtb65uAr0Mo77qeQC2YzMSS
         KSW0YmmGXqAdz0g6H2qO8437WOghyLWLPrTB1AjbXEzmdYr2lYb+lcVuXLE90kuFyfo9
         JsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732199403; x=1732804203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kx9TyW32ODc64DAloEjQFPeTyDgeKOv8ziD1S5YwPww=;
        b=PltHb46YpjR2rfs8yfaRH+MfhiVvFIZWaVkBBfvuEJuNrA76EV1VjBxTBjHhOkyEdX
         UuXuDFQr9fLkv3S4HJWeD+aTchXlFISWYPAbBCrlTZwrJuBipyycHtt6kIu5VNwraR2g
         V1Qr/6bovhcs0TV+4Kja30gEvnlXsFkTPZzwQZdQPeADG/BuATNUcRQ5is7usRW8DMZw
         TKfeD5jy+wzzpxS0cAPVb3GiY+pSFn7V5gqz6jWY/JcvyBp4RKp+KzG8h6Zhu1LZYVNu
         b50WJqw5Xl8/zi3ck89W/oKUPqdKy1dKbgg97DnrTQpEIIE6aiBTFfgsZZGnRNNjjJyK
         ACCg==
X-Gm-Message-State: AOJu0Ywu+8wGCoH0vR3gj1Fm5+LCZIS5SpICqT/HYwKJBv9XKarCcbLw
	bmAIXXV5xnE2MkHHBNW6RqX1btI4apkAd0e7Rp9RwUKoTF9vuy/NXD5j
X-Gm-Gg: ASbGncuV5eUpxUNUfEpIphp2Rl2Xxsb7lXN2D3GhKaJH54E6o5/FHAY8OZZoQ6WkqdG
	w/tpSTOQ36aHzZKcvlwS5KhnurVXhXhYmekAh5N5a6BEovp2W1/5baQxY0/26bXrswiwOeCXi6r
	+dHNIJpl5OFbdNyKGGM5Tl4Jbe6IJf2jdjVVeI8E6+AgszFg1PbYQzaZQ94c0liNGFZQqKwBbbd
	/jiZfJnRdwQ5YtSE72c5OvlOCTR7R0=
X-Google-Smtp-Source: AGHT+IG8ezatTaJp/uGLl5DXX+CMtFF0+9Jrk+Y+qzwQhC49rcIAfXgCjIsnGMgaZD/qtUBAw2dNgg==
X-Received: by 2002:a05:6214:1c4a:b0:6d3:5be3:e711 with SMTP id 6a1803df08f44-6d44239bf6fmr56098206d6.9.1732199403148;
        Thu, 21 Nov 2024 06:30:03 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d43812acf9sm23963236d6.82.2024.11.21.06.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 06:30:02 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 5.10.y] x86/stackprotector: Work around strict Clang TLS symbol requirements
Date: Thu, 21 Nov 2024 09:29:54 -0500
Message-ID: <20241121142954.3564808-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111739-dimmed-aspirate-171d@gregkh>
References: <2024111739-dimmed-aspirate-171d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ard Biesheuvel <ardb@kernel.org>

GCC and Clang both implement stack protector support based on Thread Local
Storage (TLS) variables, and this is used in the kernel to implement per-task
stack cookies, by copying a task's stack cookie into a per-CPU variable every
time it is scheduled in.

Both now also implement -mstack-protector-guard-symbol=, which permits the TLS
variable to be specified directly. This is useful because it will allow to
move away from using a fixed offset of 40 bytes into the per-CPU area on
x86_64, which requires a lot of special handling in the per-CPU code and the
runtime relocation code.

However, while GCC is rather lax in its implementation of this command line
option, Clang actually requires that the provided symbol name refers to a TLS
variable (i.e., one declared with __thread), although it also permits the
variable to be undeclared entirely, in which case it will use an implicit
declaration of the right type.

The upshot of this is that Clang will emit the correct references to the stack
cookie variable in most cases, e.g.,

  10d:       64 a1 00 00 00 00       mov    %fs:0x0,%eax
                     10f: R_386_32   __stack_chk_guard

However, if a non-TLS definition of the symbol in question is visible in the
same compilation unit (which amounts to the whole of vmlinux if LTO is
enabled), it will drop the per-CPU prefix and emit a load from a bogus
address.

Work around this by using a symbol name that never occurs in C code, and emit
it as an alias in the linker script.

Fixes: 3fb0fdb3bbe7 ("x86/stackprotector/32: Make the canary into a regular percpu variable")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Cc: stable@vger.kernel.org
Link: https://github.com/ClangBuiltLinux/linux/issues/1854
Link: https://lore.kernel.org/r/20241105155801.1779119-2-brgerst@gmail.com
(cherry picked from commit 577c134d311b9b94598d7a0c86be1f431f823003)
---
 arch/x86/Makefile                     |  3 ++-
 arch/x86/entry/entry.S                | 15 +++++++++++++++
 arch/x86/include/asm/asm-prototypes.h |  3 +++
 arch/x86/kernel/cpu/common.c          |  2 ++
 arch/x86/kernel/vmlinux.lds.S         |  3 +++
 5 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 8b9fa777f513..dcd8c6f676ca 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -90,7 +90,8 @@ ifeq ($(CONFIG_X86_32),y)
 
 	ifeq ($(CONFIG_STACKPROTECTOR),y)
 		ifeq ($(CONFIG_SMP),y)
-			KBUILD_CFLAGS += -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard
+			KBUILD_CFLAGS += -mstack-protector-guard-reg=fs \
+					 -mstack-protector-guard-symbol=__ref_stack_chk_guard
 		else
 			KBUILD_CFLAGS += -mstack-protector-guard=global
 		endif
diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index f4419afc7147..23f9efbe9d70 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -48,3 +48,18 @@ EXPORT_SYMBOL_GPL(mds_verw_sel);
 
 .popsection
 
+#ifndef CONFIG_X86_64
+/*
+ * Clang's implementation of TLS stack cookies requires the variable in
+ * question to be a TLS variable. If the variable happens to be defined as an
+ * ordinary variable with external linkage in the same compilation unit (which
+ * amounts to the whole of vmlinux with LTO enabled), Clang will drop the
+ * segment register prefix from the references, resulting in broken code. Work
+ * around this by avoiding the symbol used in -mstack-protector-guard-symbol=
+ * entirely in the C code, and use an alias emitted by the linker script
+ * instead.
+ */
+#ifdef CONFIG_STACKPROTECTOR
+EXPORT_SYMBOL(__ref_stack_chk_guard);
+#endif
+#endif
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 5cdccea45554..390b13db24b8 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -18,3 +18,6 @@
 extern void cmpxchg8b_emu(void);
 #endif
 
+#if defined(__GENKSYMS__) && defined(CONFIG_STACKPROTECTOR)
+extern unsigned long __ref_stack_chk_guard;
+#endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index bdcf1e9375ee..f8e5598408bf 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1974,8 +1974,10 @@ EXPORT_PER_CPU_SYMBOL(cpu_current_top_of_stack);
 
 #ifdef CONFIG_STACKPROTECTOR
 DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
+#ifndef CONFIG_SMP
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif
+#endif
 
 #endif	/* CONFIG_X86_64 */
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 740f87d8aa48..60fb61dffe98 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -490,6 +490,9 @@ SECTIONS
 	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
 }
 
+/* needed for Clang - see arch/x86/entry/entry.S */
+PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
+
 #ifdef CONFIG_X86_32
 /*
  * The ASSERT() sink to . is intentional, for binutils 2.14 compatibility:

base-commit: 711d99f845cdb587b7d7cf5e56c289c3d96d27c5
-- 
2.47.0


