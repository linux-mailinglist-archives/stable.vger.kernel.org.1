Return-Path: <stable+bounces-39927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAC68A5562
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A622813AD
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF8D1E52A;
	Mon, 15 Apr 2024 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iqCn1als"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C12E2119;
	Mon, 15 Apr 2024 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192235; cv=none; b=J5C/eFSJ7gDJRx0FyF+thP/ZzqjLalmUHRiaCJU+TGbP9TFxECnfBAs+f5Hm/UWta/CEGnoU7vFwtkw2CgcMVaAwx+Lv6016k0HGKHgbmJU9dRAxGnXS9Pyz1R9o9pzWY0I1uysdlwhTnBKZvurKWtIwysT5sQQioCGt+HzGGfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192235; c=relaxed/simple;
	bh=L+EJzNZEn7wV3fQBiEKpSqv44JfUzUy6IB4vrX3G2YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqs+hpkej9ou6EG1FuptDcUEccfUeC+1z5HGFbh1hlTI+YvMFpt8AZSpX27ARdJexNvKUGcuWnC4aVcWkYI+rXm2fyu1ier1LadGZjfR8AHZAscp/o0esoN/ldwgEyPROPNDEiCVj2Q8Tdt4jx52QoV8f+5zQoe5Z8yxKZjISEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iqCn1als; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1B0C113CC;
	Mon, 15 Apr 2024 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713192235;
	bh=L+EJzNZEn7wV3fQBiEKpSqv44JfUzUy6IB4vrX3G2YY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iqCn1alsQj0Nb+Kl4qbpcL0M0hcp0fpSEujAOsytGUYSTQckF6FZLrQhb+ZRJyMtD
	 klLcjwPwHop6bT/7Pe8+92c0r1Dps8EQ5t/nKNKWDmjnuwmfI60M4ztj8rdBUgPmsd
	 k57JxRZbspRplqOE/egfFKP8FK2Vf7ujiAgfFDyE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ingo Molnar <mingo@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.15 40/45] x86/bugs: Rename various ia32_cap variables to x86_arch_cap_msr
Date: Mon, 15 Apr 2024 16:21:47 +0200
Message-ID: <20240415141943.446735027@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141942.235939111@linuxfoundation.org>
References: <20240415141942.235939111@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ingo Molnar <mingo@kernel.org>

commit d0485730d2189ffe5d986d4e9e191f1e4d5ffd24 upstream.

So we are using the 'ia32_cap' value in a number of places,
which got its name from MSR_IA32_ARCH_CAPABILITIES MSR register.

But there's very little 'IA32' about it - this isn't 32-bit only
code, nor does it originate from there, it's just a historic
quirk that many Intel MSR names are prefixed with IA32_.

This is already clear from the helper method around the MSR:
x86_read_arch_cap_msr(), which doesn't have the IA32 prefix.

So rename 'ia32_cap' to 'x86_arch_cap_msr' to be consistent with
its role and with the naming of the helper function.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/9592a18a814368e75f8f4b9d74d3883aa4fd1eaf.1712813475.git.jpoimboe@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c   |   30 +++++++++++++-------------
 arch/x86/kernel/cpu/common.c |   48 +++++++++++++++++++++----------------------
 2 files changed, 39 insertions(+), 39 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -60,7 +60,7 @@ EXPORT_SYMBOL_GPL(x86_spec_ctrl_current)
 u64 x86_pred_cmd __ro_after_init = PRED_CMD_IBPB;
 EXPORT_SYMBOL_GPL(x86_pred_cmd);
 
-static u64 __ro_after_init ia32_cap;
+static u64 __ro_after_init x86_arch_cap_msr;
 
 static DEFINE_MUTEX(spec_ctrl_mutex);
 
@@ -145,7 +145,7 @@ void __init cpu_select_mitigations(void)
 		x86_spec_ctrl_base &= ~SPEC_CTRL_MITIGATIONS_MASK;
 	}
 
-	ia32_cap = x86_read_arch_cap_msr();
+	x86_arch_cap_msr = x86_read_arch_cap_msr();
 
 	/* Select the proper CPU mitigations before patching alternatives: */
 	spectre_v1_select_mitigation();
@@ -349,8 +349,8 @@ static void __init taa_select_mitigation
 	 * On MDS_NO=1 CPUs if ARCH_CAP_TSX_CTRL_MSR is not set, microcode
 	 * update is required.
 	 */
-	if ( (ia32_cap & ARCH_CAP_MDS_NO) &&
-	    !(ia32_cap & ARCH_CAP_TSX_CTRL_MSR))
+	if ( (x86_arch_cap_msr & ARCH_CAP_MDS_NO) &&
+	    !(x86_arch_cap_msr & ARCH_CAP_TSX_CTRL_MSR))
 		taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
 
 	/*
@@ -440,7 +440,7 @@ static void __init mmio_select_mitigatio
 	 * be propagated to uncore buffers, clearing the Fill buffers on idle
 	 * is required irrespective of SMT state.
 	 */
-	if (!(ia32_cap & ARCH_CAP_FBSDP_NO))
+	if (!(x86_arch_cap_msr & ARCH_CAP_FBSDP_NO))
 		static_branch_enable(&mds_idle_clear);
 
 	/*
@@ -450,10 +450,10 @@ static void __init mmio_select_mitigatio
 	 * FB_CLEAR or by the presence of both MD_CLEAR and L1D_FLUSH on MDS
 	 * affected systems.
 	 */
-	if ((ia32_cap & ARCH_CAP_FB_CLEAR) ||
+	if ((x86_arch_cap_msr & ARCH_CAP_FB_CLEAR) ||
 	    (boot_cpu_has(X86_FEATURE_MD_CLEAR) &&
 	     boot_cpu_has(X86_FEATURE_FLUSH_L1D) &&
-	     !(ia32_cap & ARCH_CAP_MDS_NO)))
+	     !(x86_arch_cap_msr & ARCH_CAP_MDS_NO)))
 		mmio_mitigation = MMIO_MITIGATION_VERW;
 	else
 		mmio_mitigation = MMIO_MITIGATION_UCODE_NEEDED;
@@ -511,7 +511,7 @@ static void __init rfds_select_mitigatio
 	if (rfds_mitigation == RFDS_MITIGATION_OFF)
 		return;
 
-	if (ia32_cap & ARCH_CAP_RFDS_CLEAR)
+	if (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR)
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 	else
 		rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
@@ -663,7 +663,7 @@ static void __init srbds_select_mitigati
 	 * are only exposed to SRBDS when TSX is enabled or when CPU is affected
 	 * by Processor MMIO Stale Data vulnerability.
 	 */
-	if ((ia32_cap & ARCH_CAP_MDS_NO) && !boot_cpu_has(X86_FEATURE_RTM) &&
+	if ((x86_arch_cap_msr & ARCH_CAP_MDS_NO) && !boot_cpu_has(X86_FEATURE_RTM) &&
 	    !boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
 		srbds_mitigation = SRBDS_MITIGATION_TSX_OFF;
 	else if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
@@ -806,7 +806,7 @@ static void __init gds_select_mitigation
 	/* Will verify below that mitigation _can_ be disabled */
 
 	/* No microcode */
-	if (!(ia32_cap & ARCH_CAP_GDS_CTRL)) {
+	if (!(x86_arch_cap_msr & ARCH_CAP_GDS_CTRL)) {
 		if (gds_mitigation == GDS_MITIGATION_FORCE) {
 			/*
 			 * This only needs to be done on the boot CPU so do it
@@ -1518,14 +1518,14 @@ static enum spectre_v2_mitigation __init
 /* Disable in-kernel use of non-RSB RET predictors */
 static void __init spec_ctrl_disable_kernel_rrsba(void)
 {
-	u64 ia32_cap;
+	u64 x86_arch_cap_msr;
 
 	if (!boot_cpu_has(X86_FEATURE_RRSBA_CTRL))
 		return;
 
-	ia32_cap = x86_read_arch_cap_msr();
+	x86_arch_cap_msr = x86_read_arch_cap_msr();
 
-	if (ia32_cap & ARCH_CAP_RRSBA) {
+	if (x86_arch_cap_msr & ARCH_CAP_RRSBA) {
 		x86_spec_ctrl_base |= SPEC_CTRL_RRSBA_DIS_S;
 		update_spec_ctrl(x86_spec_ctrl_base);
 	}
@@ -1892,7 +1892,7 @@ static void update_mds_branch_idle(void)
 	if (sched_smt_active()) {
 		static_branch_enable(&mds_idle_clear);
 	} else if (mmio_mitigation == MMIO_MITIGATION_OFF ||
-		   (ia32_cap & ARCH_CAP_FBSDP_NO)) {
+		   (x86_arch_cap_msr & ARCH_CAP_FBSDP_NO)) {
 		static_branch_disable(&mds_idle_clear);
 	}
 }
@@ -2789,7 +2789,7 @@ static const char *spectre_bhi_state(voi
 	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP))
 		return "; BHI: SW loop, KVM: SW loop";
 	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
-		 !(ia32_cap & ARCH_CAP_RRSBA))
+		 !(x86_arch_cap_msr & ARCH_CAP_RRSBA))
 		return "; BHI: Retpoline";
 	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
 		return "; BHI: Syscall hardening, KVM: SW loop";
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1198,25 +1198,25 @@ static bool __init cpu_matches(const str
 
 u64 x86_read_arch_cap_msr(void)
 {
-	u64 ia32_cap = 0;
+	u64 x86_arch_cap_msr = 0;
 
 	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
-		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, x86_arch_cap_msr);
 
-	return ia32_cap;
+	return x86_arch_cap_msr;
 }
 
-static bool arch_cap_mmio_immune(u64 ia32_cap)
+static bool arch_cap_mmio_immune(u64 x86_arch_cap_msr)
 {
-	return (ia32_cap & ARCH_CAP_FBSDP_NO &&
-		ia32_cap & ARCH_CAP_PSDP_NO &&
-		ia32_cap & ARCH_CAP_SBDR_SSDP_NO);
+	return (x86_arch_cap_msr & ARCH_CAP_FBSDP_NO &&
+		x86_arch_cap_msr & ARCH_CAP_PSDP_NO &&
+		x86_arch_cap_msr & ARCH_CAP_SBDR_SSDP_NO);
 }
 
-static bool __init vulnerable_to_rfds(u64 ia32_cap)
+static bool __init vulnerable_to_rfds(u64 x86_arch_cap_msr)
 {
 	/* The "immunity" bit trumps everything else: */
-	if (ia32_cap & ARCH_CAP_RFDS_NO)
+	if (x86_arch_cap_msr & ARCH_CAP_RFDS_NO)
 		return false;
 
 	/*
@@ -1224,7 +1224,7 @@ static bool __init vulnerable_to_rfds(u6
 	 * indicate that mitigation is needed because guest is running on a
 	 * vulnerable hardware or may migrate to such hardware:
 	 */
-	if (ia32_cap & ARCH_CAP_RFDS_CLEAR)
+	if (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR)
 		return true;
 
 	/* Only consult the blacklist when there is no enumeration: */
@@ -1233,11 +1233,11 @@ static bool __init vulnerable_to_rfds(u6
 
 static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
-	u64 ia32_cap = x86_read_arch_cap_msr();
+	u64 x86_arch_cap_msr = x86_read_arch_cap_msr();
 
 	/* Set ITLB_MULTIHIT bug if cpu is not in the whitelist and not mitigated */
 	if (!cpu_matches(cpu_vuln_whitelist, NO_ITLB_MULTIHIT) &&
-	    !(ia32_cap & ARCH_CAP_PSCHANGE_MC_NO))
+	    !(x86_arch_cap_msr & ARCH_CAP_PSCHANGE_MC_NO))
 		setup_force_cpu_bug(X86_BUG_ITLB_MULTIHIT);
 
 	if (cpu_matches(cpu_vuln_whitelist, NO_SPECULATION))
@@ -1249,7 +1249,7 @@ static void __init cpu_set_bug_bits(stru
 		setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
 
 	if (!cpu_matches(cpu_vuln_whitelist, NO_SSB) &&
-	    !(ia32_cap & ARCH_CAP_SSB_NO) &&
+	    !(x86_arch_cap_msr & ARCH_CAP_SSB_NO) &&
 	   !cpu_has(c, X86_FEATURE_AMD_SSB_NO))
 		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
 
@@ -1257,15 +1257,15 @@ static void __init cpu_set_bug_bits(stru
 	 * AMD's AutoIBRS is equivalent to Intel's eIBRS - use the Intel feature
 	 * flag and protect from vendor-specific bugs via the whitelist.
 	 */
-	if ((ia32_cap & ARCH_CAP_IBRS_ALL) || cpu_has(c, X86_FEATURE_AUTOIBRS)) {
+	if ((x86_arch_cap_msr & ARCH_CAP_IBRS_ALL) || cpu_has(c, X86_FEATURE_AUTOIBRS)) {
 		setup_force_cpu_cap(X86_FEATURE_IBRS_ENHANCED);
 		if (!cpu_matches(cpu_vuln_whitelist, NO_EIBRS_PBRSB) &&
-		    !(ia32_cap & ARCH_CAP_PBRSB_NO))
+		    !(x86_arch_cap_msr & ARCH_CAP_PBRSB_NO))
 			setup_force_cpu_bug(X86_BUG_EIBRS_PBRSB);
 	}
 
 	if (!cpu_matches(cpu_vuln_whitelist, NO_MDS) &&
-	    !(ia32_cap & ARCH_CAP_MDS_NO)) {
+	    !(x86_arch_cap_msr & ARCH_CAP_MDS_NO)) {
 		setup_force_cpu_bug(X86_BUG_MDS);
 		if (cpu_matches(cpu_vuln_whitelist, MSBDS_ONLY))
 			setup_force_cpu_bug(X86_BUG_MSBDS_ONLY);
@@ -1284,9 +1284,9 @@ static void __init cpu_set_bug_bits(stru
 	 * TSX_CTRL check alone is not sufficient for cases when the microcode
 	 * update is not present or running as guest that don't get TSX_CTRL.
 	 */
-	if (!(ia32_cap & ARCH_CAP_TAA_NO) &&
+	if (!(x86_arch_cap_msr & ARCH_CAP_TAA_NO) &&
 	    (cpu_has(c, X86_FEATURE_RTM) ||
-	     (ia32_cap & ARCH_CAP_TSX_CTRL_MSR)))
+	     (x86_arch_cap_msr & ARCH_CAP_TSX_CTRL_MSR)))
 		setup_force_cpu_bug(X86_BUG_TAA);
 
 	/*
@@ -1312,7 +1312,7 @@ static void __init cpu_set_bug_bits(stru
 	 * Set X86_BUG_MMIO_UNKNOWN for CPUs that are neither in the blacklist,
 	 * nor in the whitelist and also don't enumerate MSR ARCH_CAP MMIO bits.
 	 */
-	if (!arch_cap_mmio_immune(ia32_cap)) {
+	if (!arch_cap_mmio_immune(x86_arch_cap_msr)) {
 		if (cpu_matches(cpu_vuln_blacklist, MMIO))
 			setup_force_cpu_bug(X86_BUG_MMIO_STALE_DATA);
 		else if (!cpu_matches(cpu_vuln_whitelist, NO_MMIO))
@@ -1320,7 +1320,7 @@ static void __init cpu_set_bug_bits(stru
 	}
 
 	if (!cpu_has(c, X86_FEATURE_BTC_NO)) {
-		if (cpu_matches(cpu_vuln_blacklist, RETBLEED) || (ia32_cap & ARCH_CAP_RSBA))
+		if (cpu_matches(cpu_vuln_blacklist, RETBLEED) || (x86_arch_cap_msr & ARCH_CAP_RSBA))
 			setup_force_cpu_bug(X86_BUG_RETBLEED);
 	}
 
@@ -1333,7 +1333,7 @@ static void __init cpu_set_bug_bits(stru
 	 * disabling AVX2. The only way to do this in HW is to clear XCR0[2],
 	 * which means that AVX will be disabled.
 	 */
-	if (cpu_matches(cpu_vuln_blacklist, GDS) && !(ia32_cap & ARCH_CAP_GDS_NO) &&
+	if (cpu_matches(cpu_vuln_blacklist, GDS) && !(x86_arch_cap_msr & ARCH_CAP_GDS_NO) &&
 	    boot_cpu_has(X86_FEATURE_AVX))
 		setup_force_cpu_bug(X86_BUG_GDS);
 
@@ -1342,11 +1342,11 @@ static void __init cpu_set_bug_bits(stru
 			setup_force_cpu_bug(X86_BUG_SRSO);
 	}
 
-	if (vulnerable_to_rfds(ia32_cap))
+	if (vulnerable_to_rfds(x86_arch_cap_msr))
 		setup_force_cpu_bug(X86_BUG_RFDS);
 
 	/* When virtualized, eIBRS could be hidden, assume vulnerable */
-	if (!(ia32_cap & ARCH_CAP_BHI_NO) &&
+	if (!(x86_arch_cap_msr & ARCH_CAP_BHI_NO) &&
 	    !cpu_matches(cpu_vuln_whitelist, NO_BHI) &&
 	    (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED) ||
 	     boot_cpu_has(X86_FEATURE_HYPERVISOR)))
@@ -1356,7 +1356,7 @@ static void __init cpu_set_bug_bits(stru
 		return;
 
 	/* Rogue Data Cache Load? No! */
-	if (ia32_cap & ARCH_CAP_RDCL_NO)
+	if (x86_arch_cap_msr & ARCH_CAP_RDCL_NO)
 		return;
 
 	setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);



