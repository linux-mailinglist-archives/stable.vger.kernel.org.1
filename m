Return-Path: <stable+bounces-128834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE9EA7F596
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 09:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754753B3BBE
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 07:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655AB261368;
	Tue,  8 Apr 2025 07:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y6UrpGSj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2109626159B
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744095750; cv=none; b=bRjXY0BernWq21ZncsUEtRtvAjZjOf8ncS65JAtCKF4Gu1ZW8E1wpgEP3Wu0QtRR+NQR40w4GaJ2/OsFObvkS9Gkl3te1OKoL5tv13ukfJVXg54RTt81Zpmc7QIYVJZiZOsa/LBfQ9vMl8aafMnO02KpdPGdlTHqndeFFXxGHDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744095750; c=relaxed/simple;
	bh=D7KFqevg4WycKsR0zN55MOTHF4/1cUtErRvvp6nH/Ac=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LrSLPuMCdh24El4qtdu1egsHT1recB7dYBZBOB3wmxWDJInlPBbVGLsIwJMwLfGn/L69RYFZkXlJK8mJUvLw1f1QN2gXAULYWue3j+JwsuklcisCH8wGAnOb7XpBSsb75NkfYYr4UKt/wj6e6U7AAIZHEGIHGd0e/g2tzYoYgwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y6UrpGSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F086C4CEEE;
	Tue,  8 Apr 2025 07:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744095749;
	bh=D7KFqevg4WycKsR0zN55MOTHF4/1cUtErRvvp6nH/Ac=;
	h=Subject:To:Cc:From:Date:From;
	b=Y6UrpGSjMICvY49U25jEYjsjZbBlGvw5FQK/2mTjuWcOiAY5tpHeCqsD0i420EyCV
	 OpAr7wtLEJq/NpLz2jwWRjv3M6u3J1hGJBBCqEEomxZpR5H+hJKU69fjQsL8ZiYkdY
	 ulUiL3lg8dVxaHqhIrtNEWiMNM0DvEfrLV63AtJk=
Subject: FAILED: patch "[PATCH] x86/tdx: Fix arch_safe_halt() execution for TDX VMs" failed to apply to 5.15-stable tree
To: vannapurve@google.com,afranji@google.com,brgerst@gmail.com,hpa@zytor.com,jgross@suse.com,jpoimboe@redhat.com,kirill.shutemov@linux.intel.com,luto@kernel.org,mingo@kernel.org,torvalds@linux-foundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 09:00:46 +0200
Message-ID: <2025040846-deafening-unmanaged-f966@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9f98a4f4e7216dbe366010b4cdcab6b220f229c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040846-deafening-unmanaged-f966@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9f98a4f4e7216dbe366010b4cdcab6b220f229c4 Mon Sep 17 00:00:00 2001
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 28 Feb 2025 01:44:15 +0000
Subject: [PATCH] x86/tdx: Fix arch_safe_halt() execution for TDX VMs

Direct HLT instruction execution causes #VEs for TDX VMs which is routed
to hypervisor via TDCALL. If HLT is executed in STI-shadow, resulting #VE
handler will enable interrupts before TDCALL is routed to hypervisor
leading to missed wakeup events, as current TDX spec doesn't expose
interruptibility state information to allow #VE handler to selectively
enable interrupts.

Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
prevented the idle routines from executing HLT instruction in STI-shadow.
But it missed the paravirt routine which can be reached via this path
as an example:

	kvm_wait()       =>
        safe_halt()      =>
        raw_safe_halt()  =>
        arch_safe_halt() =>
        irq.safe_halt()  =>
        pv_native_safe_halt()

To reliably handle arch_safe_halt() for TDX VMs, introduce explicit
dependency on CONFIG_PARAVIRT and override paravirt halt()/safe_halt()
routines with TDX-safe versions that execute direct TDCALL and needed
interrupt flag updates. Executing direct TDCALL brings in additional
benefit of avoiding HLT related #VEs altogether.

As tested by Ryan Afranji:

  "Tested with the specjbb2015 benchmark. It has heavy lock contention which leads
   to many halt calls. TDX VMs suffered a poor score before this patchset.

   Verified the major performance improvement with this patchset applied."

Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Tested-by: Ryan Afranji <afranji@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250228014416.3925664-3-vannapurve@google.com

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 05b4eca156cf..f614c0522a0b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -878,6 +878,7 @@ config INTEL_TDX_GUEST
 	depends on X86_64 && CPU_SUP_INTEL
 	depends on X86_X2APIC
 	depends on EFI_STUB
+	depends on PARAVIRT
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
 	select X86_MCE
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 7772b01ab738..aa0eb4057226 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -14,6 +14,7 @@
 #include <asm/ia32.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
+#include <asm/paravirt_types.h>
 #include <asm/pgtable.h>
 #include <asm/set_memory.h>
 #include <asm/traps.h>
@@ -398,7 +399,7 @@ static int handle_halt(struct ve_info *ve)
 	return ve_instr_len(ve);
 }
 
-void __cpuidle tdx_safe_halt(void)
+void __cpuidle tdx_halt(void)
 {
 	const bool irq_disabled = false;
 
@@ -409,6 +410,16 @@ void __cpuidle tdx_safe_halt(void)
 		WARN_ONCE(1, "HLT instruction emulation failed\n");
 }
 
+static void __cpuidle tdx_safe_halt(void)
+{
+	tdx_halt();
+	/*
+	 * "__cpuidle" section doesn't support instrumentation, so stick
+	 * with raw_* variant that avoids tracing hooks.
+	 */
+	raw_local_irq_enable();
+}
+
 static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 {
 	struct tdx_module_args args = {
@@ -1109,6 +1120,19 @@ void __init tdx_early_init(void)
 	x86_platform.guest.enc_kexec_begin	     = tdx_kexec_begin;
 	x86_platform.guest.enc_kexec_finish	     = tdx_kexec_finish;
 
+	/*
+	 * Avoid "sti;hlt" execution in TDX guests as HLT induces a #VE that
+	 * will enable interrupts before HLT TDCALL invocation if executed
+	 * in STI-shadow, possibly resulting in missed wakeup events.
+	 *
+	 * Modify all possible HLT execution paths to use TDX specific routines
+	 * that directly execute TDCALL and toggle the interrupt state as
+	 * needed after TDCALL completion. This also reduces HLT related #VEs
+	 * in addition to having a reliable halt logic execution.
+	 */
+	pv_ops.irq.safe_halt = tdx_safe_halt;
+	pv_ops.irq.halt = tdx_halt;
+
 	/*
 	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
 	 * bringup low level code. That raises #VE which cannot be handled
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 65394aa9b49f..4a1922ec80cf 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -58,7 +58,7 @@ void tdx_get_ve_info(struct ve_info *ve);
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
 
-void tdx_safe_halt(void);
+void tdx_halt(void);
 
 bool tdx_early_handle_ve(struct pt_regs *regs);
 
@@ -72,7 +72,7 @@ void __init tdx_dump_td_ctls(u64 td_ctls);
 #else
 
 static inline void tdx_early_init(void) { };
-static inline void tdx_safe_halt(void) { };
+static inline void tdx_halt(void) { };
 
 static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 91f6ff618852..962c3ce39323 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -939,7 +939,7 @@ void __init select_idle_routine(void)
 		static_call_update(x86_idle, mwait_idle);
 	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
 		pr_info("using TDX aware idle routine\n");
-		static_call_update(x86_idle, tdx_safe_halt);
+		static_call_update(x86_idle, tdx_halt);
 	} else {
 		static_call_update(x86_idle, default_idle);
 	}


