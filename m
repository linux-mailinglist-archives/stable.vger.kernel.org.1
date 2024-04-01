Return-Path: <stable+bounces-33938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3B5893B8D
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 15:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7FB1C213A6
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 13:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08AE17580;
	Mon,  1 Apr 2024 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U1lpcqK+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C87F9DF
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711978669; cv=none; b=CEq7ZutCUEVuvrw/mnqbsPOj/JT2qNEdHCA9YAjZdoPhXdmcZzLLhE69Twkamp2L9ilnLPw1Ddxkl+6pfU1IEcpgpUSVWM3waob2NQaLKtUyhY0h/fKso1+5hWB42Z/W9vgry3hAlvPYl/oa4F0LW24PbuhR+u/KcFiKd558K9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711978669; c=relaxed/simple;
	bh=Ss1Fg/ivoGHg2hwWdkIP6USj/lUcLN+ackAtt7tXvKs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Yko52p/v5C0d1se2VMEVa96HbPV46ra+IDfN83EoVoODAQ92MlOh3yTwY6t+NkBQfaIR/Px4SYU+kIaTXuM5NU4rw10bu548EeUuVd668gcHWxW9958j4AzQzXgONOk42QUTSRtyzVaPfLuysS6tjpFGomuhVQpIXjo75SvDfVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U1lpcqK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6110CC433C7;
	Mon,  1 Apr 2024 13:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711978668;
	bh=Ss1Fg/ivoGHg2hwWdkIP6USj/lUcLN+ackAtt7tXvKs=;
	h=Subject:To:Cc:From:Date:From;
	b=U1lpcqK+UxQLQvmKUoEbLJpkxUdyBRT6AAn4A8ERpa4erMT4Iw2b7TSxLml4qjSpr
	 3Ka95WpvWWJcY45V78OY/7bClCQKSSthuTaHEn1xWdUeq5CT9HW4CRZdtVjD4v9OWZ
	 NUMMKMZNv+O28rUGy67qLDdybDL+6Q2ihX5D++Yo=
Subject: FAILED: patch "[PATCH] perf/x86/amd/lbr: Use freeze based on availability" failed to apply to 6.8-stable tree
To: sandipan.das@amd.com,mingo@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Apr 2024 15:37:37 +0200
Message-ID: <2024040137-tragedy-chapter-f8c0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x 598c2fafc06fe5c56a1a415fb7b544b31453d637
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040137-tragedy-chapter-f8c0@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Possible dependencies:

598c2fafc06f ("perf/x86/amd/lbr: Use freeze based on availability")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 598c2fafc06fe5c56a1a415fb7b544b31453d637 Mon Sep 17 00:00:00 2001
From: Sandipan Das <sandipan.das@amd.com>
Date: Mon, 25 Mar 2024 13:01:45 +0530
Subject: [PATCH] perf/x86/amd/lbr: Use freeze based on availability

Currently, the LBR code assumes that LBR Freeze is supported on all processors
when X86_FEATURE_AMD_LBR_V2 is available i.e. CPUID leaf 0x80000022[EAX]
bit 1 is set. This is incorrect as the availability of the feature is
additionally dependent on CPUID leaf 0x80000022[EAX] bit 2 being set,
which may not be set for all Zen 4 processors.

Define a new feature bit for LBR and PMC freeze and set the freeze enable bit
(FLBRI) in DebugCtl (MSR 0x1d9) conditionally.

It should still be possible to use LBR without freeze for profile-guided
optimization of user programs by using an user-only branch filter during
profiling. When the user-only filter is enabled, branches are no longer
recorded after the transition to CPL 0 upon PMI arrival. When branch
entries are read in the PMI handler, the branch stack does not change.

E.g.

  $ perf record -j any,u -e ex_ret_brn_tkn ./workload

Since the feature bit is visible under flags in /proc/cpuinfo, it can be
used to determine the feasibility of use-cases which require LBR Freeze
to be supported by the hardware such as profile-guided optimization of
kernels.

Fixes: ca5b7c0d9621 ("perf/x86/amd/lbr: Add LbrExtV2 branch record support")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/69a453c97cfd11c6f2584b19f937fe6df741510f.1711091584.git.sandipan.das@amd.com

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index aec16e581f5b..5692e827afef 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -904,8 +904,8 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	if (!status)
 		goto done;
 
-	/* Read branch records before unfreezing */
-	if (status & GLOBAL_STATUS_LBRS_FROZEN) {
+	/* Read branch records */
+	if (x86_pmu.lbr_nr) {
 		amd_pmu_lbr_read();
 		status &= ~GLOBAL_STATUS_LBRS_FROZEN;
 	}
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 4a1e600314d5..5149830c7c4f 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -402,10 +402,12 @@ void amd_pmu_lbr_enable_all(void)
 		wrmsrl(MSR_AMD64_LBR_SELECT, lbr_select);
 	}
 
-	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
-	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
+	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	}
 
-	wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
 	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg | DBG_EXTN_CFG_LBRV2EN);
 }
 
@@ -418,10 +420,12 @@ void amd_pmu_lbr_disable_all(void)
 		return;
 
 	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
-	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
-
 	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
-	wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+
+	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	}
 }
 
 __init int amd_pmu_lbr_init(void)
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 4d850a780f7e..a38f8f9ba657 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -459,6 +459,14 @@
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] flushes all branch type predictions */
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
 
+/*
+ * Extended auxiliary flags: Linux defined - for features scattered in various
+ * CPUID levels like 0x80000022, etc.
+ *
+ * Reuse free bits when adding new feature flags!
+ */
+#define X86_FEATURE_AMD_LBR_PMC_FREEZE	(21*32+ 0) /* AMD LBR and PMC Freeze */
+
 /*
  * BUG word(s)
  */
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 0dad49a09b7a..a515328d9d7d 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -49,6 +49,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
+	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 


