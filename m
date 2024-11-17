Return-Path: <stable+bounces-93709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 350729D05C4
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE561F2173E
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 20:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261C71DB551;
	Sun, 17 Nov 2024 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PynYuEZ5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD532E419
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731875040; cv=none; b=IqzCNmm/YiwXSAxpy4sm+GboFyVXjfy5E8jsnu5amAd0taT2qJ2NJV7o4zXmGPm4RAqGv5vLuNU+QmeiOEZZudemIlTD5z2FMjvqfNQrq2D126A4jPulFP1J93AjwxLPSxAH7xjTRrLDMDDDS5hPkIvfsdcRYipWq9fjq8IUC20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731875040; c=relaxed/simple;
	bh=fhu6ugFQ3wPsWDCwku6ljDqdIsZ3UyRpa2EudRqWuwY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YZgxhDCZaISl6grzGAkbjKtMNZPnxSefP0NnPsnZ7RGSXnx/rEEHGKqkh/xX4tf+qxieuqmw60M1uxsscg5ip/SEuYlsri5GyVVYiR3ULRNMN0kOst+D990ta+kQDijhatkf/KCwxSJ+gY+CyWNwXsA+27Tz8xrIA/sYKfYPeY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PynYuEZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEC6C4CECD;
	Sun, 17 Nov 2024 20:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731875040;
	bh=fhu6ugFQ3wPsWDCwku6ljDqdIsZ3UyRpa2EudRqWuwY=;
	h=Subject:To:Cc:From:Date:From;
	b=PynYuEZ5gBH6pE/0fGdrT40sj7hJncAwgWl4p0+GtGFVF7H3XvpvRs3ZkSh+x/QPP
	 XBw98pdteIpkepUWijU99mh3zQXs5+0/FBaeQjyuHHMqA30VszEIqvH/VlCd1yHVLT
	 Dox4KVNK8aJj2xMO7m52ldtNENEOdNRMBFaXWODE=
Subject: FAILED: patch "[PATCH] x86/stackprotector: Work around strict Clang TLS symbol" failed to apply to 6.6-stable tree
To: ardb@kernel.org,bp@alien8.de,brgerst@gmail.com,nathan@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Nov 2024 21:23:35 +0100
Message-ID: <2024111735-paging-quintet-7ce1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 577c134d311b9b94598d7a0c86be1f431f823003
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111735-paging-quintet-7ce1@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 577c134d311b9b94598d7a0c86be1f431f823003 Mon Sep 17 00:00:00 2001
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 5 Nov 2024 10:57:46 -0500
Subject: [PATCH] x86/stackprotector: Work around strict Clang TLS symbol
 requirements

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
index 324686bca368..b7ea3e8e9ecc 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -51,3 +51,19 @@ EXPORT_SYMBOL_GPL(mds_verw_sel);
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
index a5f221ea5688..f43bb974fc66 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2089,8 +2089,10 @@ void syscall_init(void)
 
 #ifdef CONFIG_STACKPROTECTOR
 DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
+#ifndef CONFIG_SMP
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif
+#endif
 
 #endif	/* CONFIG_X86_64 */
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index b8c5741d2fb4..feb8102a9ca7 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -491,6 +491,9 @@ SECTIONS
 . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
 
+/* needed for Clang - see arch/x86/entry/entry.S */
+PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
+
 #ifdef CONFIG_X86_64
 /*
  * Per-cpu symbols which need to be offset from __per_cpu_load


