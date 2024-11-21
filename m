Return-Path: <stable+bounces-94535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFAC9D4F89
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 16:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F77D2854EA
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 15:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF801D932F;
	Thu, 21 Nov 2024 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faU4Ii19"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3251D959B
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732202129; cv=none; b=K65egqkj08MjSRGBCabc/cS1FpMAZ7KHBMF1YjdDOr/NjFjanniMCLgMSV72QZ+aNRVwbtwZ1mjqF4fZoq+wOsxPlrms4HuQb00C2jI76u3gYk9qDStf8QvgqRRJku2oJMAEPcEZ4ewtkDdK3ZpGberWW4U9uoEk8kYGTSSwqcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732202129; c=relaxed/simple;
	bh=jo34bX0yctYrbGmofurl0F4HH5XJ4NLuxdPQEGGJsDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eF6MjpnQ6ZHIktvX2AVbPHcAdgUUKI56MIARfhpbyT1px/48W4asPeitE00TDC9CfyEH0cd488q3c9yumiPZvOS+CeFf+5efRmczPGLtCvFiSlSeFsP1uSq3GKWHJL8ancCzj+roWZ4YQL/ZnlaAQelgbuTozKxikbqiRp7V32c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faU4Ii19; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d42b87aceaso19104486d6.0
        for <stable@vger.kernel.org>; Thu, 21 Nov 2024 07:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732202125; x=1732806925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQQ3XxUfjoMgcfA1s/E5d/tb9rI5+D6nLewMCKHRzYg=;
        b=faU4Ii19Azn6i8UsoR/7iF5+/Pxx+/iGpIajFg+yl/i7BOnD8VhmhPiPrT9P5sjVW8
         BUFGFdOOqmTP+O6PjCsu8HBfknq1TSEPRvzIfiilRtJ5kgOrtW26R2Ou05kxsP7ohsAS
         rl6j4x3i8iuFwJrDi455yHGmdfRJiU0U6Sm0S8FlvEtuT6ZwuFoDPTrJ526g+QFcgr09
         QQgAcnQDv6jdm8wuRzt4KND1TZaxtaGC9A+wM+rZSZ+iEmGz+2kQrpPkPhiwcdJ0w0xZ
         W1TKmCNWhvdyHUTePV6ExAHvZ4N+YeM5Zf5yoKS1M+3G/KRvvrXz/0kWojr1U4CcRWI3
         qBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732202125; x=1732806925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQQ3XxUfjoMgcfA1s/E5d/tb9rI5+D6nLewMCKHRzYg=;
        b=dSLD4pQaNXVeo56CoR1vWruoNAiavXgNqqb0B5JQ7EaBpsPlVz/aRj5uHRzH36m/Ni
         OVjb2JbsanFHdxhZfwRoI9mh6FUHZZvyGJ8zBhQibh0SZRTtfoRzJnLJd8TybFFSv3aI
         CbDTh5TzlRWlfxjqJ3YFHN2/12LcIt5ds4FAzLnzYRJf2LtvM8EhdhJAoA1QORWk7aRc
         vlgqe94bVziRyEkZuHM5KNRvpMenyp1/40dQCoGzuaZdc/6A4O7Bwb8wpfB8df7PgC75
         TQ+d/IX/0FQFgx0EZ13cOmmZSLBgjs4SxaJbx7KqbQlcE/IfW1VQLbn5vubhnTCcy22x
         k9CA==
X-Gm-Message-State: AOJu0YysEpnB/Zkio3BTtIbie+ZzHurPRgvWZFNSi6YiR/Poz9ZJSFx8
	qd0cBjzzq7DZdc9y1uYaoiDUHijzGYo+swImmU5pQNEP+WfRxpTeyv2D
X-Gm-Gg: ASbGncsEHoxqK/rjg9HwAAFidM4uF3CKHt/byhcoTQaayq2mI5I7EZEnPXlMaB3vq07
	l6xoiEMpZNtObdlOThFwy03fbh/mTQwkKWDjNLdO4pwh0xApZlh43kVTBmDnWpwj7krpQ36gffi
	4AXr8RNAWThUhjJWfwrSWF1mPcZFRpXacGw9cowxBkk0Sp4T5mD+WyeHethKDFe0CpjH+LpmmsX
	jbFboO80he8Di7g7lnWIsCMFGx8vJQ=
X-Google-Smtp-Source: AGHT+IFtpo09JPTX5+UzxXnMddO6yPZlNnnqoxaGaqtIBYkeW8RFYkPzNTFBTc7z/kOAHJqT4n/XZw==
X-Received: by 2002:a05:6214:4008:b0:6cb:ee9c:7045 with SMTP id 6a1803df08f44-6d442336b6emr46603166d6.2.1732202124966;
        Thu, 21 Nov 2024 07:15:24 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d4381369bcsm24545196d6.109.2024.11.21.07.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 07:15:24 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 6.6.y] x86/stackprotector: Work around strict Clang TLS symbol requirements
Date: Thu, 21 Nov 2024 10:15:19 -0500
Message-ID: <20241121151519.3692548-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111735-paging-quintet-7ce1@gregkh>
References: <2024111735-paging-quintet-7ce1@gregkh>
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
index 3ff53a2d4ff0..c83582b5a010 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -113,7 +113,8 @@ ifeq ($(CONFIG_X86_32),y)
 
 	ifeq ($(CONFIG_STACKPROTECTOR),y)
 		ifeq ($(CONFIG_SMP),y)
-			KBUILD_CFLAGS += -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard
+			KBUILD_CFLAGS += -mstack-protector-guard-reg=fs \
+					 -mstack-protector-guard-symbol=__ref_stack_chk_guard
 		else
 			KBUILD_CFLAGS += -mstack-protector-guard=global
 		endif
diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index 34eca8015b64..2143358d0c4c 100644
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
index 0e82074517f6..768076e68668 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -19,3 +19,6 @@
 extern void cmpxchg8b_emu(void);
 #endif
 
+#if defined(__GENKSYMS__) && defined(CONFIG_STACKPROTECTOR)
+extern unsigned long __ref_stack_chk_guard;
+#endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7a1e58fb43a0..852cc2ab4df9 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2159,8 +2159,10 @@ void syscall_init(void)
 
 #ifdef CONFIG_STACKPROTECTOR
 DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
+#ifndef CONFIG_SMP
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif
+#endif
 
 #endif	/* CONFIG_X86_64 */
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 54a5596adaa6..60eb8baa44d7 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -496,6 +496,9 @@ SECTIONS
 	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
 }
 
+/* needed for Clang - see arch/x86/entry/entry.S */
+PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
+
 /*
  * The ASSERT() sink to . is intentional, for binutils 2.14 compatibility:
  */

base-commit: c1036e4f14d03aba549cdd9b186148d331013056
-- 
2.47.0


