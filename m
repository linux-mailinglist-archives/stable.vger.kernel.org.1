Return-Path: <stable+bounces-136879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8537A9F025
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 14:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5682317F562
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 12:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E12267AF3;
	Mon, 28 Apr 2025 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hsQ9D+0D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5637267AF6
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841518; cv=none; b=IXV9zfPVOqWDxw7nxPD2GEzBxhqxnsYjBhiaqNVPv777HOnKxvBhfXSHGJ5fCUptZsC2cCCCtx1XYLslHTm20Ic19KeTZq3it1fy2dhk+vHz6kihG9LDZ+6XN1j39LTNWmmsV4VTQ8SM6YFV8Ud1NMpXJpzcZYDLbiMMiEd6/ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841518; c=relaxed/simple;
	bh=o/1ZgF7dCwd+q1/v1UAnkFVqrwf5ciqKJbWc/1L2hTQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CfYWcw93wlO59FgMoIy3Qenj39kyb/NecZovKeec0iFdSnPRc5x4u1xk3zx9qfWCkQMuUx8tlk8G5mQnKFo1Le3T5ZWY71cz4jU0s2UMqPTpmDUaKlR3uQaH4a84JO8JsoZEmDygo48EsjYD6B2G/ytixIA/+PMF9ucZbYPAlP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hsQ9D+0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087F3C4CEED;
	Mon, 28 Apr 2025 11:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745841518;
	bh=o/1ZgF7dCwd+q1/v1UAnkFVqrwf5ciqKJbWc/1L2hTQ=;
	h=Subject:To:Cc:From:Date:From;
	b=hsQ9D+0DJIEseSLo20qJd2j6a6cRh1w6db9GvhfokWvEx3zXs9uNHRH3yX1l4N7IG
	 b6Wu3T0drJhs+KUkShb3PCpmfSh5BBb0qmOk2TwybrMHGvbOZMoEkcgGluop1YnSnI
	 NgaIaUSBiPjXEAdFtTAIJoenvPuk+gahzDNjowI0=
Subject: FAILED: patch "[PATCH] LoongArch: Handle fp, lsx, lasx and lbt assembly symbols" failed to apply to 6.1-stable tree
To: yangtiezhu@loongson.cn,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 13:58:27 +0200
Message-ID: <2025042827-scanner-ripping-3482@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2ef174b13344b3b4554d3d28e6f9e2a2c1d3138f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042827-scanner-ripping-3482@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2ef174b13344b3b4554d3d28e6f9e2a2c1d3138f Mon Sep 17 00:00:00 2001
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Thu, 24 Apr 2025 20:15:41 +0800
Subject: [PATCH] LoongArch: Handle fp, lsx, lasx and lbt assembly symbols

Like the other relevant symbols, export some fp, lsx, lasx and lbt
assembly symbols and put the function declarations in header files
rather than source files.

While at it, use "asmlinkage" for the other existing C prototypes
of assembly functions and also do not use the "extern" keyword with
function declarations according to the document coding-style.rst.

Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/asm/fpu.h
index 3177674228f8..45514f314664 100644
--- a/arch/loongarch/include/asm/fpu.h
+++ b/arch/loongarch/include/asm/fpu.h
@@ -22,22 +22,29 @@
 struct sigcontext;
 
 #define kernel_fpu_available() cpu_has_fpu
-extern void kernel_fpu_begin(void);
-extern void kernel_fpu_end(void);
 
-extern void _init_fpu(unsigned int);
-extern void _save_fp(struct loongarch_fpu *);
-extern void _restore_fp(struct loongarch_fpu *);
+void kernel_fpu_begin(void);
+void kernel_fpu_end(void);
 
-extern void _save_lsx(struct loongarch_fpu *fpu);
-extern void _restore_lsx(struct loongarch_fpu *fpu);
-extern void _init_lsx_upper(void);
-extern void _restore_lsx_upper(struct loongarch_fpu *fpu);
+asmlinkage void _init_fpu(unsigned int);
+asmlinkage void _save_fp(struct loongarch_fpu *);
+asmlinkage void _restore_fp(struct loongarch_fpu *);
+asmlinkage int _save_fp_context(void __user *fpregs, void __user *fcc, void __user *csr);
+asmlinkage int _restore_fp_context(void __user *fpregs, void __user *fcc, void __user *csr);
 
-extern void _save_lasx(struct loongarch_fpu *fpu);
-extern void _restore_lasx(struct loongarch_fpu *fpu);
-extern void _init_lasx_upper(void);
-extern void _restore_lasx_upper(struct loongarch_fpu *fpu);
+asmlinkage void _save_lsx(struct loongarch_fpu *fpu);
+asmlinkage void _restore_lsx(struct loongarch_fpu *fpu);
+asmlinkage void _init_lsx_upper(void);
+asmlinkage void _restore_lsx_upper(struct loongarch_fpu *fpu);
+asmlinkage int _save_lsx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
+asmlinkage int _restore_lsx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
+
+asmlinkage void _save_lasx(struct loongarch_fpu *fpu);
+asmlinkage void _restore_lasx(struct loongarch_fpu *fpu);
+asmlinkage void _init_lasx_upper(void);
+asmlinkage void _restore_lasx_upper(struct loongarch_fpu *fpu);
+asmlinkage int _save_lasx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
+asmlinkage int _restore_lasx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
 
 static inline void enable_lsx(void);
 static inline void disable_lsx(void);
diff --git a/arch/loongarch/include/asm/lbt.h b/arch/loongarch/include/asm/lbt.h
index e671978bf552..38566574e562 100644
--- a/arch/loongarch/include/asm/lbt.h
+++ b/arch/loongarch/include/asm/lbt.h
@@ -12,9 +12,13 @@
 #include <asm/loongarch.h>
 #include <asm/processor.h>
 
-extern void _init_lbt(void);
-extern void _save_lbt(struct loongarch_lbt *);
-extern void _restore_lbt(struct loongarch_lbt *);
+asmlinkage void _init_lbt(void);
+asmlinkage void _save_lbt(struct loongarch_lbt *);
+asmlinkage void _restore_lbt(struct loongarch_lbt *);
+asmlinkage int _save_lbt_context(void __user *regs, void __user *eflags);
+asmlinkage int _restore_lbt_context(void __user *regs, void __user *eflags);
+asmlinkage int _save_ftop_context(void __user *ftop);
+asmlinkage int _restore_ftop_context(void __user *ftop);
 
 static inline int is_lbt_enabled(void)
 {
diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
index 6ab640101457..28caf416ae36 100644
--- a/arch/loongarch/kernel/fpu.S
+++ b/arch/loongarch/kernel/fpu.S
@@ -458,6 +458,7 @@ SYM_FUNC_START(_save_fp_context)
 	li.w		a0, 0				# success
 	jr		ra
 SYM_FUNC_END(_save_fp_context)
+EXPORT_SYMBOL_GPL(_save_fp_context)
 
 /*
  * a0: fpregs
@@ -471,6 +472,7 @@ SYM_FUNC_START(_restore_fp_context)
 	li.w		a0, 0				# success
 	jr		ra
 SYM_FUNC_END(_restore_fp_context)
+EXPORT_SYMBOL_GPL(_restore_fp_context)
 
 /*
  * a0: fpregs
@@ -484,6 +486,7 @@ SYM_FUNC_START(_save_lsx_context)
 	li.w	a0, 0					# success
 	jr	ra
 SYM_FUNC_END(_save_lsx_context)
+EXPORT_SYMBOL_GPL(_save_lsx_context)
 
 /*
  * a0: fpregs
@@ -497,6 +500,7 @@ SYM_FUNC_START(_restore_lsx_context)
 	li.w	a0, 0					# success
 	jr	ra
 SYM_FUNC_END(_restore_lsx_context)
+EXPORT_SYMBOL_GPL(_restore_lsx_context)
 
 /*
  * a0: fpregs
@@ -510,6 +514,7 @@ SYM_FUNC_START(_save_lasx_context)
 	li.w	a0, 0					# success
 	jr	ra
 SYM_FUNC_END(_save_lasx_context)
+EXPORT_SYMBOL_GPL(_save_lasx_context)
 
 /*
  * a0: fpregs
@@ -523,6 +528,7 @@ SYM_FUNC_START(_restore_lasx_context)
 	li.w	a0, 0					# success
 	jr	ra
 SYM_FUNC_END(_restore_lasx_context)
+EXPORT_SYMBOL_GPL(_restore_lasx_context)
 
 .L_fpu_fault:
 	li.w	a0, -EFAULT				# failure
diff --git a/arch/loongarch/kernel/lbt.S b/arch/loongarch/kernel/lbt.S
index 001f061d226a..71678912d24c 100644
--- a/arch/loongarch/kernel/lbt.S
+++ b/arch/loongarch/kernel/lbt.S
@@ -90,6 +90,7 @@ SYM_FUNC_START(_save_lbt_context)
 	li.w		a0, 0			# success
 	jr		ra
 SYM_FUNC_END(_save_lbt_context)
+EXPORT_SYMBOL_GPL(_save_lbt_context)
 
 /*
  * a0: scr
@@ -110,6 +111,7 @@ SYM_FUNC_START(_restore_lbt_context)
 	li.w		a0, 0			# success
 	jr		ra
 SYM_FUNC_END(_restore_lbt_context)
+EXPORT_SYMBOL_GPL(_restore_lbt_context)
 
 /*
  * a0: ftop
@@ -120,6 +122,7 @@ SYM_FUNC_START(_save_ftop_context)
 	li.w		a0, 0			# success
 	jr		ra
 SYM_FUNC_END(_save_ftop_context)
+EXPORT_SYMBOL_GPL(_save_ftop_context)
 
 /*
  * a0: ftop
@@ -150,6 +153,7 @@ SYM_FUNC_START(_restore_ftop_context)
 	li.w		a0, 0			# success
 	jr		ra
 SYM_FUNC_END(_restore_ftop_context)
+EXPORT_SYMBOL_GPL(_restore_ftop_context)
 
 .L_lbt_fault:
 	li.w		a0, -EFAULT		# failure
diff --git a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signal.c
index 7a555b600171..4740cb5b2388 100644
--- a/arch/loongarch/kernel/signal.c
+++ b/arch/loongarch/kernel/signal.c
@@ -51,27 +51,6 @@
 #define lock_lbt_owner()	({ preempt_disable(); pagefault_disable(); })
 #define unlock_lbt_owner()	({ pagefault_enable(); preempt_enable(); })
 
-/* Assembly functions to move context to/from the FPU */
-extern asmlinkage int
-_save_fp_context(void __user *fpregs, void __user *fcc, void __user *csr);
-extern asmlinkage int
-_restore_fp_context(void __user *fpregs, void __user *fcc, void __user *csr);
-extern asmlinkage int
-_save_lsx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
-extern asmlinkage int
-_restore_lsx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
-extern asmlinkage int
-_save_lasx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
-extern asmlinkage int
-_restore_lasx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
-
-#ifdef CONFIG_CPU_HAS_LBT
-extern asmlinkage int _save_lbt_context(void __user *regs, void __user *eflags);
-extern asmlinkage int _restore_lbt_context(void __user *regs, void __user *eflags);
-extern asmlinkage int _save_ftop_context(void __user *ftop);
-extern asmlinkage int _restore_ftop_context(void __user *ftop);
-#endif
-
 struct rt_sigframe {
 	struct siginfo rs_info;
 	struct ucontext rs_uctx;


