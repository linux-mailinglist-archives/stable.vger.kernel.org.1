Return-Path: <stable+bounces-23627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F5F8670DC
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6451C28693
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E69F5B5CF;
	Mon, 26 Feb 2024 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="agRCqas7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="agRCqas7"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329DD5B043
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942373; cv=none; b=Kf15jT9FG9x82KEoimjje4lX0E5JvdgcEG1EwJE3TQwRany/GJcevOIa36/1kORnRtTm6fw0HHeN6tONwn61hwAwRfbVGrits4ozH8Dn8xs5RqxUuCBJm/JpT7uFFo0e7ZiW4QsWWGb7Ys7E0hCnCk2oVzb/5wjWuk1GO/sDsso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942373; c=relaxed/simple;
	bh=Lxq9oDXwsQgMDa4/K4dwfoYwaHx9ixdNTqlMCfK4yDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f9CTbcydRz7/BjLZB0aLKvjc35cvf4L71wMPX871QVHYjdu/r5IFvFeJ3B1iJ6zbQP+x4o7dfYHs8fFGVmng5Orfo29Ibpvy7D0l5HXNS9L65qZMGZZgDHP7SPceAx2E5Uwjnh3GovJ+2uqtgppJ3ifQoy1Fk3Xjcn9q/KHpcyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=agRCqas7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=agRCqas7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 42E3E1FB45;
	Mon, 26 Feb 2024 10:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708942368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSYrisymazx8dEGehQj9HXXs0iSz1SFyuVsbjET7j0I=;
	b=agRCqas7djODrx0yqOK2G2sSYSW2S8LSdkDfJGTLtg1bQ2dx/7sIqeW2bTZHHFAzXsTgCs
	e2BTQ7u0vbTM/AbiPe7MnAc6TUTRrGXFB4kiqFcFOk3TvIKxUXUbHHWF3ei+TCpLluWX0Y
	fkFsnrednAAdKcnCCaOo3Z/DzPiK/VI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708942368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSYrisymazx8dEGehQj9HXXs0iSz1SFyuVsbjET7j0I=;
	b=agRCqas7djODrx0yqOK2G2sSYSW2S8LSdkDfJGTLtg1bQ2dx/7sIqeW2bTZHHFAzXsTgCs
	e2BTQ7u0vbTM/AbiPe7MnAc6TUTRrGXFB4kiqFcFOk3TvIKxUXUbHHWF3ei+TCpLluWX0Y
	fkFsnrednAAdKcnCCaOo3Z/DzPiK/VI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0015C13A80;
	Mon, 26 Feb 2024 10:12:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MJIxOR9k3GX/LAAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Mon, 26 Feb 2024 10:12:47 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 5/7] x86/bugs: Use ALTERNATIVE() instead of mds_user_clear static key
Date: Mon, 26 Feb 2024 12:12:37 +0200
Message-Id: <20240226101239.17633-6-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226101239.17633-1-nik.borisov@suse.com>
References: <20240226101239.17633-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

The VERW mitigation at exit-to-user is enabled via a static branch
mds_user_clear. This static branch is never toggled after boot, and can
be safely replaced with an ALTERNATIVE() which is convenient to use in
asm.

Switch to ALTERNATIVE() to use the VERW mitigation late in exit-to-user
path. Also remove the now redundant VERW in exc_nmi() and
arch_exit_to_user_mode().

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240213-delay-verw-v8-4-a6216d83edb7%40linux.intel.com
Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 Documentation/x86/mds.rst            | 38 ++++++++++++++++++++--------
 arch/x86/entry/common.c              |  2 --
 arch/x86/include/asm/nospec-branch.h | 12 ---------
 arch/x86/kernel/cpu/bugs.c           | 15 +++++------
 arch/x86/kernel/nmi.c                |  3 ---
 arch/x86/kvm/vmx/vmx.c               |  2 +-
 6 files changed, 34 insertions(+), 38 deletions(-)

diff --git a/Documentation/x86/mds.rst b/Documentation/x86/mds.rst
index 5d4330be200f..e801df0bb3a8 100644
--- a/Documentation/x86/mds.rst
+++ b/Documentation/x86/mds.rst
@@ -95,6 +95,9 @@ enters a C-state.
 
     mds_clear_cpu_buffers()
 
+Also macro CLEAR_CPU_BUFFERS can be used in ASM late in exit-to-user path.
+Other than CFLAGS.ZF, this macro doesn't clobber any registers.
+
 The mitigation is invoked on kernel/userspace, hypervisor/guest and C-state
 (idle) transitions.
 
@@ -138,17 +141,30 @@ Mitigation points
 
    When transitioning from kernel to user space the CPU buffers are flushed
    on affected CPUs when the mitigation is not disabled on the kernel
-   command line. The migitation is enabled through the static key
-   mds_user_clear.
-
-   The mitigation is invoked in prepare_exit_to_usermode() which covers
-   all but one of the kernel to user space transitions.  The exception
-   is when we return from a Non Maskable Interrupt (NMI), which is
-   handled directly in do_nmi().
-
-   (The reason that NMI is special is that prepare_exit_to_usermode() can
-    enable IRQs.  In NMI context, NMIs are blocked, and we don't want to
-    enable IRQs with NMIs blocked.)
+   command line. The mitigation is enabled through the feature flag
+   X86_FEATURE_CLEAR_CPU_BUF.
+
+   The mitigation is invoked just before transitioning to userspace after
+   user registers are restored. This is done to minimize the window in
+   which kernel data could be accessed after VERW e.g. via an NMI after
+   VERW.
+
+   **Corner case not handled**
+   Interrupts returning to kernel don't clear CPUs buffers since the
+   exit-to-user path is expected to do that anyways. But, there could be
+   a case when an NMI is generated in kernel after the exit-to-user path
+   has cleared the buffers. This case is not handled and NMI returning to
+   kernel don't clear CPU buffers because:
+
+   1. It is rare to get an NMI after VERW, but before returning to userspace.
+   2. For an unprivileged user, there is no known way to make that NMI
+      less rare or target it.
+   3. It would take a large number of these precisely-timed NMIs to mount
+      an actual attack.  There's presumably not enough bandwidth.
+   4. The NMI in question occurs after a VERW, i.e. when user state is
+      restored and most interesting data is already scrubbed. Whats left
+      is only the data that NMI touches, and that may or may not be of
+      any interest.
 
 
 2. C-State transition
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 3f8e22615812..c93c9f3a6a25 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -216,8 +216,6 @@ __visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
 #endif
 
 	user_enter_irqoff();
-
-	mds_user_clear_cpu_buffers();
 }
 
 #define SYSCALL_EXIT_WORK_FLAGS				\
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index ba069ed16f94..649d734d90bd 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -353,7 +353,6 @@ DECLARE_STATIC_KEY_FALSE(switch_to_cond_stibp);
 DECLARE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
 DECLARE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
-DECLARE_STATIC_KEY_FALSE(mds_user_clear);
 DECLARE_STATIC_KEY_FALSE(mds_idle_clear);
 
 DECLARE_STATIC_KEY_FALSE(mmio_stale_data_clear);
@@ -385,17 +384,6 @@ static __always_inline void mds_clear_cpu_buffers(void)
 	asm volatile("verw %[ds]" : : [ds] "m" (ds) : "cc");
 }
 
-/**
- * mds_user_clear_cpu_buffers - Mitigation for MDS and TAA vulnerability
- *
- * Clear CPU buffers if the corresponding static key is enabled
- */
-static __always_inline void mds_user_clear_cpu_buffers(void)
-{
-	if (static_branch_likely(&mds_user_clear))
-		mds_clear_cpu_buffers();
-}
-
 /**
  * mds_idle_clear_cpu_buffers - Mitigation for MDS vulnerability
  *
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 48ae44cf7795..dfac90db22a0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -102,9 +102,6 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
 /* Control unconditional IBPB in switch_mm() */
 DEFINE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
-/* Control MDS CPU buffer clear before returning to user space */
-DEFINE_STATIC_KEY_FALSE(mds_user_clear);
-EXPORT_SYMBOL_GPL(mds_user_clear);
 /* Control MDS CPU buffer clear before idling (halt, mwait) */
 DEFINE_STATIC_KEY_FALSE(mds_idle_clear);
 EXPORT_SYMBOL_GPL(mds_idle_clear);
@@ -236,7 +233,7 @@ static void __init mds_select_mitigation(void)
 		if (!boot_cpu_has(X86_FEATURE_MD_CLEAR))
 			mds_mitigation = MDS_MITIGATION_VMWERV;
 
-		static_branch_enable(&mds_user_clear);
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 
 		if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
 		    (mds_nosmt || cpu_mitigations_auto_nosmt()))
@@ -333,7 +330,7 @@ static void __init taa_select_mitigation(void)
 	 * For guests that can't determine whether the correct microcode is
 	 * present on host, enable the mitigation for UCODE_NEEDED as well.
 	 */
-	static_branch_enable(&mds_user_clear);
+	setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 
 	if (taa_nosmt || cpu_mitigations_auto_nosmt())
 		cpu_smt_disable(false);
@@ -401,7 +398,7 @@ static void __init mmio_select_mitigation(void)
 	 */
 	if (boot_cpu_has_bug(X86_BUG_MDS) || (boot_cpu_has_bug(X86_BUG_TAA) &&
 					      boot_cpu_has(X86_FEATURE_RTM)))
-		static_branch_enable(&mds_user_clear);
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 	else
 		static_branch_enable(&mmio_stale_data_clear);
 
@@ -461,12 +458,12 @@ static void __init md_clear_update_mitigation(void)
 	if (cpu_mitigations_off())
 		return;
 
-	if (!static_key_enabled(&mds_user_clear))
+	if (!boot_cpu_has(X86_FEATURE_CLEAR_CPU_BUF))
 		goto out;
 
 	/*
-	 * mds_user_clear is now enabled. Update MDS, TAA and MMIO Stale Data
-	 * mitigation, if necessary.
+	 * X86_FEATURE_CLEAR_CPU_BUF is now enabled. Update MDS, TAA and MMIO
+	 * Stale Data mitigation, if necessary.
 	 */
 	if (mds_mitigation == MDS_MITIGATION_OFF &&
 	    boot_cpu_has_bug(X86_BUG_MDS)) {
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 5bb001c0c771..b0caa7185922 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -553,9 +553,6 @@ do_nmi(struct pt_regs *regs, long error_code)
 		write_cr2(this_cpu_read(nmi_cr2));
 	if (this_cpu_dec_return(nmi_state))
 		goto nmi_restart;
-
-	if (user_mode(regs))
-		mds_user_clear_cpu_buffers();
 }
 NOKPROBE_SYMBOL(do_nmi);
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c93070829790..4bf0c6221ec8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6662,7 +6662,7 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	/* L1D Flush includes CPU buffer clear to mitigate MDS */
 	if (static_branch_unlikely(&vmx_l1d_should_flush))
 		vmx_l1d_flush(vcpu);
-	else if (static_branch_unlikely(&mds_user_clear))
+	else if (cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF))
 		mds_clear_cpu_buffers();
 	else if (static_branch_unlikely(&mmio_stale_data_clear) &&
 		 kvm_arch_has_assigned_device(vcpu->kvm))
-- 
2.34.1


