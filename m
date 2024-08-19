Return-Path: <stable+bounces-69623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E08695733F
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 20:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78C81F236F4
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 18:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E7618952F;
	Mon, 19 Aug 2024 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nu5zeQl3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37701189512;
	Mon, 19 Aug 2024 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092180; cv=none; b=L613gReoJJiMw8ureQFU6WnBKDkM0ZKiTe11HCHs20HYcadteRHmruot0LPgBxJpleDJ+OrT+f+bgR/IetNLj/drIuS+jwufsAeZvKahxh/wuVUQnrP2h+E99ATyZQ5Hh70+BD/6yBqkIEbnxFpXxJSdmzI3StYbRFPTBsDh1ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092180; c=relaxed/simple;
	bh=RQ7i3UfkVy05ASqG8daq5DVVmW9E2kAR2KVRBwhbH/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CTMbjEIMb5TdszyNP/MtAig/CBaltX5pJ889OcSfCgi7WPJMsuRVvAr4jtIXjPpXczAtayS0MXaaifErwMHEWlQwIKg9KAQiBdgEX3gHSOwuDHzkMM/CCJp1R/G4nxpziongkVpHgmztvC4nFjklEqU2WNkGILU3AMjshTT3eq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nu5zeQl3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724092178; x=1755628178;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RQ7i3UfkVy05ASqG8daq5DVVmW9E2kAR2KVRBwhbH/o=;
  b=Nu5zeQl3rWXYiM34z+Lkv82laO2yK0+rviPsMvZ2AAF+wunonZFOe1R/
   I1OYFEX1UZOOapvoihS4LuB689vx6+DnJd51MM5TaknyF7+s5Qty558Wn
   /be6nyq3+t+d8xkD7HHed2JEB/8zz7xwtGerKty/JQsANKopGS+f5WXnp
   EyZOMOQNm3k+h8SXAGy1PTCyS/ykx7Hk3O1oxmAgvYYOJ82gzMNIrhA5s
   iqa1D2PUiQlwSU1L6wFv95QA2YuJolFWT02pcqRfw066okT9HL8VWC+c1
   cuJxNf8vLUmPyhfmtobQPd8t0Tf+ltOy/ArGn2WEe1kPTDwO4DBsXTZHG
   w==;
X-CSE-ConnectionGUID: YI7IqZfWQJKQdoMN8S82JQ==
X-CSE-MsgGUID: 4eIOIfOrQ0SfqVlJrQzf7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="21979404"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="21979404"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 11:29:37 -0700
X-CSE-ConnectionGUID: 9ni8XZAPTdqTgfhRObze4Q==
X-CSE-MsgGUID: E2+hFNjZSOi13idnQnA3pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="64850618"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 19 Aug 2024 11:29:36 -0700
From: kan.liang@linux.intel.com
To: tglx@linutronix.de,
	peterz@infradead.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	ak@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Vince Weaver <vincent.weaver@maine.edu>,
	stable@vger.kernel.org
Subject: [PATCH] perf/x86/intel: Limit the period on Haswell
Date: Mon, 19 Aug 2024 11:30:04 -0700
Message-Id: <20240819183004.3132920-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

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
Closes: https://lore.kernel.org/lkml/20240729223328.327835-1-lihuafei1@huawei.com/
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/core.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e8bd45556c30..605ed19043ed 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4634,6 +4634,25 @@ static enum hybrid_cpu_type adl_get_hybrid_cpu_type(void)
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
@@ -4651,8 +4670,7 @@ static enum hybrid_cpu_type adl_get_hybrid_cpu_type(void)
  */
 static void bdw_limit_period(struct perf_event *event, s64 *left)
 {
-	if ((event->hw.config & INTEL_ARCH_EVENT_MASK) ==
-			X86_CONFIG(.event=0xc0, .umask=0x01)) {
+	if (erratum_hsw11(event)) {
 		if (*left < 128)
 			*left = 128;
 		*left &= ~0x3fULL;
@@ -6821,6 +6839,7 @@ __init int intel_pmu_init(void)
 
 		x86_pmu.hw_config = hsw_hw_config;
 		x86_pmu.get_event_constraints = hsw_get_event_constraints;
+		x86_pmu.limit_period = hsw_limit_period;
 		x86_pmu.lbr_double_abort = true;
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;
-- 
2.38.1


