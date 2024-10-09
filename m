Return-Path: <stable+bounces-83201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B43996A9C
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 14:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69695289F0C
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 12:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022011E0B6B;
	Wed,  9 Oct 2024 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m5cWThOb"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FDE1E0E15
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477842; cv=none; b=VNCO9RA9kOyU9WEyWfG2DOF8IfRhI0IpUvd30IXcTFNY6SeQfr0ojEt3vlx/KFpHgwC6a2IVPCv9GVf2s+rDdriAYWd6Cqog9rg9W4Juu897JkiP2Gunld2mpiIRcAyOeXbZi3gjn3Ls1cHxYRUxaRQPEVrA6fsa9UbSj0R0u90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477842; c=relaxed/simple;
	bh=0bHcAwk1FtE7wnS8yZd3g7IH7HqaPqTuvx0X6BBDCTM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iUAAUSdwIfylUwBSOJ10R6a7rzUmuhZ++EsiyeQxlPVU50kjwRymvjZvTFc/7VwOboYuzNTsA8PlVRt1wprGuT6US3z8Fw0XWVoG5oCbUQ99zKQsTAg8SAEZTA7BJkTJuM/Tc3Z0V/eMlAHCb/oPHiQVoxNNgRiD3RPO7uHu3XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m5cWThOb; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1159fb161fso9514978276.1
        for <stable@vger.kernel.org>; Wed, 09 Oct 2024 05:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728477840; x=1729082640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EOQGqInYbwRKx9I5MqqmxixFjvxM615DnKf+PJhCNdk=;
        b=m5cWThObbcHX3nv+egNTpszU/CLy5R7cPLXQqvH6bZpVZGBEo2D8mes/DJsnUrdX5c
         Q7m9AII+uBXDjcD32KMdI8Q79T18+4M/rEkr9m+zDyf7e9/gAf4gk/LmLiD+f0VNQlkr
         7uVLUjJG/ep9uFIRfIQTJWsB9jIEwt2obCbvdZehEvNiOv3IB7aEOa8ItVBH5f6cp5Ji
         Mg2do4nd2rBkeKMp6XVbNsnW/X3DcsopplOFoY4N2l4+oKZ2J2W0TajZ+1GdhRX+Aj8i
         DLeY5IdnbKLUuT7g7QenIo+1aXk+xtT2gPzdSA3tHL6smxY5KXLzPLNSSg6ussUARu+v
         4BEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728477840; x=1729082640;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EOQGqInYbwRKx9I5MqqmxixFjvxM615DnKf+PJhCNdk=;
        b=eQpJ0/XjX6YR9TzfNIUsHoiiNsy90kJbcZ5oFOrUTkWCN8rfcqMTdvok89Hpkdu3Gm
         EPrXDh7TGQyp2sQ9gZTIzxfflHH886+plodtCEVeQDYNWCxknWgjSteABxoRuqiyDwzy
         q7NluabiO1u5yMQLhOOEMk2KlE8FPO9p4X6aF54M7B82ls5fY9j0PKUMrUH44EtdAKJv
         wR1hdCVrufER8EtFML8nzuWC56gdas9c89Eh8SMZSS/Jld+erKSMiI7hKSXzhzgKAMU7
         c+8GdfJO6jZy8U9jlaop2pCI7OZ8lXVxWFPuyCFeR0LAdirGJd2Vf190z5tXquQPfnoZ
         ZbpA==
X-Forwarded-Encrypted: i=1; AJvYcCWvydCIge6EL4GSd1wmrjhp77R2NWUiaO3PJPdJni5GkP/EvQDcia05thMU2XF7tCfEwT11H8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKS3HyXk29Ba1wEWalbz2lPPHOfMkFZSRjgikrIYkThENughDc
	XdNJMivWoEGeRtvcFwuxU/x2ZXP/eUCBz5rd553+x4LkmQQknodhK0aPXCW6O4plZi5sqg==
X-Google-Smtp-Source: AGHT+IEJxRS5v5JwaZ6SyyYklYdBADtytTHLbXNxpRbD72Gz4pQYyrhKTh2d3rdekoiaZZUxOons9M1K
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:abad:0:b0:e11:44fb:af26 with SMTP id
 3f1490d57ef6-e28fe31ff16mr1675276.2.1728477839944; Wed, 09 Oct 2024 05:43:59
 -0700 (PDT)
Date: Wed,  9 Oct 2024 14:43:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5424; i=ardb@kernel.org;
 h=from:subject; bh=UDyw98mBYs75N34uUwJo9zjn819mhGUVva9KMoRGrbQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ2tqlMu4VpoLWdM0oba8P/clYL7b97ojO67+r1VQeBZV
 L/k2XsdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCL34hgZNsceuz1DmeGr5xr1
 uasn5t/X7JlUsuJbgHvSRna7r1qPAhn+2YtMD18T/KW162H3HGnbs2bpi5yWRK/fLSFxTieHa+k xPgA=
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009124352.3105119-2-ardb+git@google.com>
Subject: [PATCH v2] x86/stackprotector: Work around strict Clang TLS symbol requirements
From: Ard Biesheuvel <ardb+git@google.com>
To: x86@kernel.org
Cc: llvm@lists.linux.dev, keescook@chromium.org, 
	linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org, 
	Fangrui Song <i@maskray.me>, Brian Gerst <brgerst@gmail.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

GCC and Clang both implement stack protector support based on Thread
Local Storage (TLS) variables, and this is used in the kernel to
implement per-task stack cookies, by copying a task's stack cookie into
a per-CPU variable every time it is scheduled in.

Both now also implement -mstack-protector-guard-symbol=, which permits
the TLS variable to be specified directly. This is useful because it
will allow us to move away from using a fixed offset of 40 bytes into
the per-CPU area on x86_64, which requires a lot of special handling in
the per-CPU code and the runtime relocation code.

However, while GCC is rather lax in its implementation of this command
line option, Clang actually requires that the provided symbol name
refers to a TLS variable (i.e., one declared with __thread), although it
also permits the variable to be undeclared entirely, in which case it
will use an implicit declaration of the right type.

The upshot of this is that Clang will emit the correct references to the
stack cookie variable in most cases, e.g.,

   10d:       64 a1 00 00 00 00       mov    %fs:0x0,%eax
                      10f: R_386_32   __stack_chk_guard

However, if a non-TLS definition of the symbol in question is visible in
the same compilation unit (which amounts to the whole of vmlinux if LTO
is enabled), it will drop the per-CPU prefix and emit a load from a
bogus address.

Work around this by using a symbol name that never occurs in C code, and
emit it as an alias in the linker script.

Fixes: 3fb0fdb3bbe7 ("x86/stackprotector/32: Make the canary into a regular percpu variable")
Cc: <stable@vger.kernel.org>
Cc: Fangrui Song <i@maskray.me>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://github.com/ClangBuiltLinux/linux/issues/1854
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
v2: add declaration of alias to asm-prototypes.h, but expose it only to
    genksyms

 arch/x86/Makefile                     |  5 +++--
 arch/x86/entry/entry.S                | 16 ++++++++++++++++
 arch/x86/include/asm/asm-prototypes.h |  3 +++
 arch/x86/kernel/cpu/common.c          |  2 ++
 arch/x86/kernel/vmlinux.lds.S         |  3 +++
 5 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index cd75e78a06c1..5b773b34768d 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -142,9 +142,10 @@ ifeq ($(CONFIG_X86_32),y)
 
     ifeq ($(CONFIG_STACKPROTECTOR),y)
         ifeq ($(CONFIG_SMP),y)
-			KBUILD_CFLAGS += -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard
+            KBUILD_CFLAGS += -mstack-protector-guard-reg=fs \
+                             -mstack-protector-guard-symbol=__ref_stack_chk_guard
         else
-			KBUILD_CFLAGS += -mstack-protector-guard=global
+            KBUILD_CFLAGS += -mstack-protector-guard=global
         endif
     endif
 else
diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index d9feadffa972..a503e6d535f8 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -46,3 +46,19 @@ EXPORT_SYMBOL_GPL(mds_verw_sel);
 .popsection
 
 THUNK warn_thunk_thunk, __warn_thunk
+
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
index 25466c4d2134..3674006e3974 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -20,3 +20,6 @@
 extern void cmpxchg8b_emu(void);
 #endif
 
+#if defined(__GENKSYMS__) && defined(CONFIG_STACKPROTECTOR)
+extern unsigned long __ref_stack_chk_guard;
+#endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 07a34d723505..ba83f54dfaa8 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2085,8 +2085,10 @@ void syscall_init(void)
 
 #ifdef CONFIG_STACKPROTECTOR
 DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
+#ifndef CONFIG_SMP
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif
+#endif
 
 #endif	/* CONFIG_X86_64 */
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 2b7c8c14c6fd..a80ad2bf8da4 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -490,6 +490,9 @@ SECTIONS
 . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
 
+/* needed for Clang - see arch/x86/entry/entry.S */
+PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
+
 #ifdef CONFIG_X86_64
 /*
  * Per-cpu symbols which need to be offset from __per_cpu_load
-- 
2.47.0.rc0.187.ge670bccf7e-goog


