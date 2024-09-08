Return-Path: <stable+bounces-73849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57691970692
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5B71F21B83
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 10:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6134F14C5A4;
	Sun,  8 Sep 2024 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VSjIbc9u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2290E2E634
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725791210; cv=none; b=WT56EM1l7gsKuWyqa9r59IF2ae7Kt0Nm1CaoXEt6RfXLLLpLuZgMl8rDMv1kLbh4KArDKI2ZSJ/8lLHvBYp5EgWV+oE6wNVXFLE2eL+1Xe15Eqx4sj73OnFrV+uqsXXgYjxaYtGzLLx3WmNXMbAiBZoImYsyDvIdDHl6YNGERWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725791210; c=relaxed/simple;
	bh=51+3QxoGDBvHxGyggiMKck6vBI4GFR9e0Zj5rj7A260=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CTc2BUeK529ur4fQ/hvAjdJDlBOubsgSOb4piOMEDjap+mPXMxdAZ6JfBjWdDtmFIUrUXa7Y1F6v2odeWg/y04m+Qb+HxalffqM3soYBZ0kUa3xW0wwBT8tYpWUStOjWTAz2HWXvqIxonVNijh6L4mFFTYowMf92zUlwpvhlOlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VSjIbc9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9433EC4CEC3;
	Sun,  8 Sep 2024 10:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725791210;
	bh=51+3QxoGDBvHxGyggiMKck6vBI4GFR9e0Zj5rj7A260=;
	h=Subject:To:Cc:From:Date:From;
	b=VSjIbc9uTKhQfrcR3JRSkvxXdBVhD4MKho9qSZiKwW/3CtdXfwu/mzKLfN69eU46U
	 8ovYX5upvZEr2BNWD3wqhUkXg9WobqhWb9m1mXw49iSjT+h7dZcnfPocQdkq5IsrbB
	 8pQZVQaMgJEf4pr8+64FSJYMbbLvj2HXOqv5mHyc=
Subject: FAILED: patch "[PATCH] perf/x86/intel: Limit the period on Haswell" failed to apply to 4.19-stable tree
To: kan.liang@linux.intel.com,lihuafei1@huawei.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 12:26:41 +0200
Message-ID: <2024090841-erasure-dice-630c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 25dfc9e357af8aed1ca79b318a73f2c59c1f0b2b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090841-erasure-dice-630c@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

25dfc9e357af ("perf/x86/intel: Limit the period on Haswell")
28f0f3c44b5c ("perf/x86: Change x86_pmu::limit_period signature")
706460a96fc6 ("perf/x86/amd/core: Add generic branch record interfaces")
b40d0156f560 ("perf/x86/amd/brs: Move feature-specific functions")
3c27b0c6ea48 ("perf/x86/amd: Fix AMD BRS period adjustment")
9622e67e3980 ("perf/x86/amd/core: Add PerfMonV2 counter control")
21d59e3e2c40 ("perf/x86/amd/core: Detect PerfMonV2 support")
cc37e520a236 ("perf/x86/amd: Make Zen3 branch sampling opt-in")
ba2fe7500845 ("perf/x86/amd: Add AMD branch sampling period adjustment")
ada543459cab ("perf/x86/amd: Add AMD Fam19h Branch Sampling support")
369461ce8fb6 ("x86: perf: Move RDPMC event flag to a common definition")
05485745ad48 ("perf/amd/uncore: Allow the driver to be built as a module")
5471eea5d3bf ("perf/x86: Reset the dirty counter to prevent the leak for an RDPMC task")
f83d2f91d259 ("perf/x86/intel: Add Alder Lake Hybrid support")
58ae30c29a37 ("perf/x86/intel: Add attr_update for Hybrid PMUs")
d9977c43bff8 ("perf/x86: Register hybrid PMUs")
e11c1a7eb302 ("perf/x86: Factor out x86_pmu_show_pmu_cap")
b98567298bad ("perf/x86: Remove temporary pmu assignment in event_init")
34d5b61f29ee ("perf/x86/intel: Factor out intel_pmu_check_extra_regs")
bc14fe1beeec ("perf/x86/intel: Factor out intel_pmu_check_event_constraints")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 25dfc9e357af8aed1ca79b318a73f2c59c1f0b2b Mon Sep 17 00:00:00 2001
From: Kan Liang <kan.liang@linux.intel.com>
Date: Mon, 19 Aug 2024 11:30:04 -0700
Subject: [PATCH] perf/x86/intel: Limit the period on Haswell

Running the ltp test cve-2015-3290 concurrently reports the following
warnings.

perfevents: irq loop stuck!
  WARNING: CPU: 31 PID: 32438 at arch/x86/events/intel/core.c:3174
  intel_pmu_handle_irq+0x285/0x370
  Call Trace:
   <NMI>
   ? __warn+0xa4/0x220
   ? intel_pmu_handle_irq+0x285/0x370
   ? __report_bug+0x123/0x130
   ? intel_pmu_handle_irq+0x285/0x370
   ? __report_bug+0x123/0x130
   ? intel_pmu_handle_irq+0x285/0x370
   ? report_bug+0x3e/0xa0
   ? handle_bug+0x3c/0x70
   ? exc_invalid_op+0x18/0x50
   ? asm_exc_invalid_op+0x1a/0x20
   ? irq_work_claim+0x1e/0x40
   ? intel_pmu_handle_irq+0x285/0x370
   perf_event_nmi_handler+0x3d/0x60
   nmi_handle+0x104/0x330

Thanks to Thomas Gleixner's analysis, the issue is caused by the low
initial period (1) of the frequency estimation algorithm, which triggers
the defects of the HW, specifically erratum HSW11 and HSW143. (For the
details, please refer https://lore.kernel.org/lkml/87plq9l5d2.ffs@tglx/)

The HSW11 requires a period larger than 100 for the INST_RETIRED.ALL
event, but the initial period in the freq mode is 1. The erratum is the
same as the BDM11, which has been supported in the kernel. A minimum
period of 128 is enforced as well on HSW.

HSW143 is regarding that the fixed counter 1 may overcount 32 with the
Hyper-Threading is enabled. However, based on the test, the hardware
has more issues than it tells. Besides the fixed counter 1, the message
'interrupt took too long' can be observed on any counter which was armed
with a period < 32 and two events expired in the same NMI. A minimum
period of 32 is enforced for the rest of the events.
The recommended workaround code of the HSW143 is not implemented.
Because it only addresses the issue for the fixed counter. It brings
extra overhead through extra MSR writing. No related overcounting issue
has been reported so far.

Fixes: 3a632cb229bf ("perf/x86/intel: Add simple Haswell PMU support")
Reported-by: Li Huafei <lihuafei1@huawei.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240819183004.3132920-1-kan.liang@linux.intel.com
Closes: https://lore.kernel.org/lkml/20240729223328.327835-1-lihuafei1@huawei.com/

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0c9c2706d4ec..9e519d8a810a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4589,6 +4589,25 @@ static enum hybrid_cpu_type adl_get_hybrid_cpu_type(void)
 	return HYBRID_INTEL_CORE;
 }
 
+static inline bool erratum_hsw11(struct perf_event *event)
+{
+	return (event->hw.config & INTEL_ARCH_EVENT_MASK) ==
+		X86_CONFIG(.event=0xc0, .umask=0x01);
+}
+
+/*
+ * The HSW11 requires a period larger than 100 which is the same as the BDM11.
+ * A minimum period of 128 is enforced as well for the INST_RETIRED.ALL.
+ *
+ * The message 'interrupt took too long' can be observed on any counter which
+ * was armed with a period < 32 and two events expired in the same NMI.
+ * A minimum period of 32 is enforced for the rest of the events.
+ */
+static void hsw_limit_period(struct perf_event *event, s64 *left)
+{
+	*left = max(*left, erratum_hsw11(event) ? 128 : 32);
+}
+
 /*
  * Broadwell:
  *
@@ -4606,8 +4625,7 @@ static enum hybrid_cpu_type adl_get_hybrid_cpu_type(void)
  */
 static void bdw_limit_period(struct perf_event *event, s64 *left)
 {
-	if ((event->hw.config & INTEL_ARCH_EVENT_MASK) ==
-			X86_CONFIG(.event=0xc0, .umask=0x01)) {
+	if (erratum_hsw11(event)) {
 		if (*left < 128)
 			*left = 128;
 		*left &= ~0x3fULL;
@@ -6766,6 +6784,7 @@ __init int intel_pmu_init(void)
 
 		x86_pmu.hw_config = hsw_hw_config;
 		x86_pmu.get_event_constraints = hsw_get_event_constraints;
+		x86_pmu.limit_period = hsw_limit_period;
 		x86_pmu.lbr_double_abort = true;
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;


