Return-Path: <stable+bounces-25805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8082386F92B
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 05:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF511C20852
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 04:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2D46117;
	Mon,  4 Mar 2024 04:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFAGqFJC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1F539E
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 04:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709526261; cv=none; b=cYU2ieSZsuQiC8NdQcUm/H2dYylTHJFejSL4zpawYN03YYyUeBgmqDkXGEzux1keoGNqSqwxDq4rclwa5rQX9nHvagnBVlzncsM4RLcRGRLTsrCqwcli8G0HBVyJLvrxAO0DdNvExR+tuWkY8Ej2cPIzVq7YN562jpEQE1yoymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709526261; c=relaxed/simple;
	bh=JFdaDtcv5UaLCt2e7PYSHuv14pAnxQlaXOWyPGBQC7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jjam8Elwz0bZl1SPaqCjhmpFMfKxXUOwI/VYRtoxo7IbCAH+TydTdlA3XztXX1fGC23aa9cxjxxaVPwwGolY5UeSRi/2Ndx6tPJ1KH6BeJIprJpgkuKAX8y+AXTiU0IGK7kK/gUoReaKj4b5AdnfVQKmA7wFemvMMZdOg6VN1E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFAGqFJC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709526260; x=1741062260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JFdaDtcv5UaLCt2e7PYSHuv14pAnxQlaXOWyPGBQC7Q=;
  b=TFAGqFJC8AdBjMSU/kAozsJxtbTBLlQxmT3s9mzNZjBiu0UFKL+NMwSh
   A90Cy3XPnMTEC3IsKJtTMxZIxDNTII9TQKK4E4+vwOVeXWvHaLn/gbBKw
   Ov+rYm+tEbIf+c2ywnSdIpkz2xAkiTltoTrjHKEf3fMoPKTfLmkCw7Wh4
   RAbnoRfMmuuvJ9hpLHaY1m4bsOdoivgPncCQPn38vcdUI9bxV4zDk6VVC
   3pbx+u3Op2P78PDpNTFPKheZPec8rq8dLNYXHujrQW5Mvcw1Mb4Q29p+A
   hieCmkJLn8BeK133JHVixDblo4hKVX4BzCnDB1lK3NEFe1Cj9fUA/DxwW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4121817"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4121817"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 20:24:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13516375"
Received: from dhorstma-mobl.amr.corp.intel.com (HELO desk) ([10.209.64.132])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 20:24:19 -0800
Date: Sun, 3 Mar 2024 20:24:19 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.7.y v2 3/5] x86/bugs: Use ALTERNATIVE() instead of
 mds_user_clear static key
Message-ID: <20240303-delay-verw-backport-6-7-y-v2-3-439b1829d099@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240303-delay-verw-backport-6-7-y-v2-0-439b1829d099@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303-delay-verw-backport-6-7-y-v2-0-439b1829d099@linux.intel.com>

commit 6613d82e617dd7eb8b0c40b2fe3acea655b1d611 upstream.

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
---
 Documentation/arch/x86/mds.rst       | 38 +++++++++++++++++++++++++-----------
 arch/x86/include/asm/entry-common.h  |  1 -
 arch/x86/include/asm/nospec-branch.h | 12 ------------
 arch/x86/kernel/cpu/bugs.c           | 15 ++++++--------
 arch/x86/kernel/nmi.c                |  3 ---
 arch/x86/kvm/vmx/vmx.c               |  2 +-
 6 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/Documentation/arch/x86/mds.rst b/Documentation/arch/x86/mds.rst
index e73fdff62c0a..c58c72362911 100644
--- a/Documentation/arch/x86/mds.rst
+++ b/Documentation/arch/x86/mds.rst
@@ -95,6 +95,9 @@ The kernel provides a function to invoke the buffer clearing:
 
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
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index ce8f50192ae3..7e523bb3d2d3 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -91,7 +91,6 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 
 static __always_inline void arch_exit_to_user_mode(void)
 {
-	mds_user_clear_cpu_buffers();
 	amd_clear_divider();
 }
 #define arch_exit_to_user_mode arch_exit_to_user_mode
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 2519615936e9..d15b35815eba 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -540,7 +540,6 @@ DECLARE_STATIC_KEY_FALSE(switch_to_cond_stibp);
 DECLARE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
 DECLARE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
-DECLARE_STATIC_KEY_FALSE(mds_user_clear);
 DECLARE_STATIC_KEY_FALSE(mds_idle_clear);
 
 DECLARE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
@@ -574,17 +573,6 @@ static __always_inline void mds_clear_cpu_buffers(void)
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
index bb0ab8466b91..48d049cd74e7 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -111,9 +111,6 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
 /* Control unconditional IBPB in switch_mm() */
 DEFINE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
-/* Control MDS CPU buffer clear before returning to user space */
-DEFINE_STATIC_KEY_FALSE(mds_user_clear);
-EXPORT_SYMBOL_GPL(mds_user_clear);
 /* Control MDS CPU buffer clear before idling (halt, mwait) */
 DEFINE_STATIC_KEY_FALSE(mds_idle_clear);
 EXPORT_SYMBOL_GPL(mds_idle_clear);
@@ -252,7 +249,7 @@ static void __init mds_select_mitigation(void)
 		if (!boot_cpu_has(X86_FEATURE_MD_CLEAR))
 			mds_mitigation = MDS_MITIGATION_VMWERV;
 
-		static_branch_enable(&mds_user_clear);
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 
 		if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
 		    (mds_nosmt || cpu_mitigations_auto_nosmt()))
@@ -356,7 +353,7 @@ static void __init taa_select_mitigation(void)
 	 * For guests that can't determine whether the correct microcode is
 	 * present on host, enable the mitigation for UCODE_NEEDED as well.
 	 */
-	static_branch_enable(&mds_user_clear);
+	setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 
 	if (taa_nosmt || cpu_mitigations_auto_nosmt())
 		cpu_smt_disable(false);
@@ -424,7 +421,7 @@ static void __init mmio_select_mitigation(void)
 	 */
 	if (boot_cpu_has_bug(X86_BUG_MDS) || (boot_cpu_has_bug(X86_BUG_TAA) &&
 					      boot_cpu_has(X86_FEATURE_RTM)))
-		static_branch_enable(&mds_user_clear);
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 	else
 		static_branch_enable(&mmio_stale_data_clear);
 
@@ -484,12 +481,12 @@ static void __init md_clear_update_mitigation(void)
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
index 17e955ab69fe..3082cf24b69e 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -563,9 +563,6 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 	}
 	if (this_cpu_dec_return(nmi_state))
 		goto nmi_restart;
-
-	if (user_mode(regs))
-		mds_user_clear_cpu_buffers();
 }
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 94082169bbbc..b59ac1525b17 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7229,7 +7229,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
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



