Return-Path: <stable+bounces-128828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1870AA7F569
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 09:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8741F3B280D
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 07:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AF825F999;
	Tue,  8 Apr 2025 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hwP6koyN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1884A217F5D
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744095721; cv=none; b=GbVU7kmw2BoUNsI24D3CjfFPVdYvqo77JwqvgMq9ja6B3Uei7U9JFSSJpCy6loU3ds/abAUQIZJADtLtCCwGTsA7d80IJvXVY3cJWeoriOV/nbEK+Q3ODSj24nf+ZyDVf4ErMthLPcfGy1UTFxcrvB/UtrwQpYL7uTqwskwGTLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744095721; c=relaxed/simple;
	bh=Sx9aeaTVB43SaUlmGiEwMWgWTOfU17xqcNVUS7MuGrM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rXy/VM+qYf0yHIQPoOTOIwN6mVw37F0sibmRASUcJ916TSWFDS9AWeEs+D8OTzh7PZ3gNan792uqc6Cmm+zDZMyuA2rGT2f89dbYOQKNGjrx3r2is4lVjhMQVcdvf6Htau0ZPp+99isKi3GMWR5LE71moFjNp/0j9l3KcMZ+9ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hwP6koyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B04CC4CEE5;
	Tue,  8 Apr 2025 07:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744095719;
	bh=Sx9aeaTVB43SaUlmGiEwMWgWTOfU17xqcNVUS7MuGrM=;
	h=Subject:To:Cc:From:Date:From;
	b=hwP6koyN6kH3ZgUw+zGP2gRUxunNqBQttvISXXc8zZWHRKtZIAzCt4mAvyp0+BwiS
	 zSR+BDwT2GtK+tDGYNMMsevVG4oDZIB1e0FtkC1+3azkjhpfD+XYz7UfQi82MF2+op
	 /d949ff2FZino7MvpCvsoea10MH8Qg+89Zhcw1Pw=
Subject: FAILED: patch "[PATCH] x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT" failed to apply to 6.13-stable tree
To: kirill.shutemov@linux.intel.com,afranji@google.com,ak@linux.intel.com,brgerst@gmail.com,hpa@zytor.com,jgross@suse.com,jpoimboe@redhat.com,luto@kernel.org,mingo@kernel.org,sathyanarayanan.kuppuswamy@linux.intel.com,tony.luck@intel.com,torvalds@linux-foundation.org,vannapurve@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 09:00:26 +0200
Message-ID: <2025040826-tracing-shanty-607f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.13-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
git checkout FETCH_HEAD
git cherry-pick -x 22cc5ca5de52bbfc36a7d4a55323f91fb4492264
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040826-tracing-shanty-607f@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 22cc5ca5de52bbfc36a7d4a55323f91fb4492264 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Fri, 28 Feb 2025 01:44:14 +0000
Subject: [PATCH] x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT

CONFIG_PARAVIRT_XXL is mainly defined/used by XEN PV guests. For
other VM guest types, features supported under CONFIG_PARAVIRT
are self sufficient. CONFIG_PARAVIRT mainly provides support for
TLB flush operations and time related operations.

For TDX guest as well, paravirt calls under CONFIG_PARVIRT meets
most of its requirement except the need of HLT and SAFE_HLT
paravirt calls, which is currently defined under
CONFIG_PARAVIRT_XXL.

Since enabling CONFIG_PARAVIRT_XXL is too bloated for TDX guest
like platforms, move HLT and SAFE_HLT paravirt calls under
CONFIG_PARAVIRT.

Moving HLT and SAFE_HLT paravirt calls are not fatal and should not
break any functionality for current users of CONFIG_PARAVIRT.

Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Tested-by: Ryan Afranji <afranji@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20250228014416.3925664-2-vannapurve@google.com

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index abb8374c9ff7..9a9b21b78905 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -76,6 +76,28 @@ static __always_inline void native_local_irq_restore(unsigned long flags)
 
 #endif
 
+#ifndef CONFIG_PARAVIRT
+#ifndef __ASSEMBLY__
+/*
+ * Used in the idle loop; sti takes one instruction cycle
+ * to complete:
+ */
+static __always_inline void arch_safe_halt(void)
+{
+	native_safe_halt();
+}
+
+/*
+ * Used when interrupts are already enabled or to
+ * shutdown the processor:
+ */
+static __always_inline void halt(void)
+{
+	native_halt();
+}
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_PARAVIRT */
+
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
@@ -97,24 +119,6 @@ static __always_inline void arch_local_irq_enable(void)
 	native_irq_enable();
 }
 
-/*
- * Used in the idle loop; sti takes one instruction cycle
- * to complete:
- */
-static __always_inline void arch_safe_halt(void)
-{
-	native_safe_halt();
-}
-
-/*
- * Used when interrupts are already enabled or to
- * shutdown the processor:
- */
-static __always_inline void halt(void)
-{
-	native_halt();
-}
-
 /*
  * For spinlocks, etc:
  */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index bed346bfac89..c4c23190925c 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -102,6 +102,16 @@ static inline void notify_page_enc_status_changed(unsigned long pfn,
 	PVOP_VCALL3(mmu.notify_page_enc_status_changed, pfn, npages, enc);
 }
 
+static __always_inline void arch_safe_halt(void)
+{
+	PVOP_VCALL0(irq.safe_halt);
+}
+
+static inline void halt(void)
+{
+	PVOP_VCALL0(irq.halt);
+}
+
 #ifdef CONFIG_PARAVIRT_XXL
 static inline void load_sp0(unsigned long sp0)
 {
@@ -165,16 +175,6 @@ static inline void __write_cr4(unsigned long x)
 	PVOP_VCALL1(cpu.write_cr4, x);
 }
 
-static __always_inline void arch_safe_halt(void)
-{
-	PVOP_VCALL0(irq.safe_halt);
-}
-
-static inline void halt(void)
-{
-	PVOP_VCALL0(irq.halt);
-}
-
 static inline u64 paravirt_read_msr(unsigned msr)
 {
 	return PVOP_CALL1(u64, cpu.read_msr, msr);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 62912023b46f..631c306ce1ff 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -120,10 +120,9 @@ struct pv_irq_ops {
 	struct paravirt_callee_save save_fl;
 	struct paravirt_callee_save irq_disable;
 	struct paravirt_callee_save irq_enable;
-
+#endif
 	void (*safe_halt)(void);
 	void (*halt)(void);
-#endif
 } __no_randomize_layout;
 
 struct pv_mmu_ops {
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 97925632c28e..1ccd05d8999f 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -75,6 +75,11 @@ void paravirt_set_sched_clock(u64 (*func)(void))
 	static_call_update(pv_sched_clock, func);
 }
 
+static noinstr void pv_native_safe_halt(void)
+{
+	native_safe_halt();
+}
+
 #ifdef CONFIG_PARAVIRT_XXL
 static noinstr void pv_native_write_cr2(unsigned long val)
 {
@@ -100,11 +105,6 @@ static noinstr void pv_native_set_debugreg(int regno, unsigned long val)
 {
 	native_set_debugreg(regno, val);
 }
-
-static noinstr void pv_native_safe_halt(void)
-{
-	native_safe_halt();
-}
 #endif
 
 struct pv_info pv_info = {
@@ -161,9 +161,11 @@ struct paravirt_patch_template pv_ops = {
 	.irq.save_fl		= __PV_IS_CALLEE_SAVE(pv_native_save_fl),
 	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(pv_native_irq_disable),
 	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(pv_native_irq_enable),
+#endif /* CONFIG_PARAVIRT_XXL */
+
+	/* Irq HLT ops. */
 	.irq.safe_halt		= pv_native_safe_halt,
 	.irq.halt		= native_halt,
-#endif /* CONFIG_PARAVIRT_XXL */
 
 	/* Mmu ops. */
 	.mmu.flush_tlb_user	= native_flush_tlb_local,


