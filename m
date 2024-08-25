Return-Path: <stable+bounces-70109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062DB95E407
	for <lists+stable@lfdr.de>; Sun, 25 Aug 2024 16:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83AD11F21626
	for <lists+stable@lfdr.de>; Sun, 25 Aug 2024 14:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C568613F43A;
	Sun, 25 Aug 2024 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="keLeolZT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kS0d1+S1"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35451DFCB;
	Sun, 25 Aug 2024 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724597692; cv=none; b=ULm+brVplpXrqPKFtCmoUZ0xv/rUz/uDBsD/ZD9sgdFsMxS4MuegDaoVbm91FY5MMFhRCBkg5rEBIaH4tMx7aykZLYY2XT3Ei5SNqolbRU360N6qEIJIcz6ocM+WPvYidZsq3u/Fmg/cCfiNJTBiKcXi3WPQraTZhbKjyqAG15A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724597692; c=relaxed/simple;
	bh=++LVRg4bp9nIRqe6eDRq9iQzNxspOTnDagj6ICY9YX8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZJXVj6Qjq/50tZoiadno03fLRiciLkyuesj30I42NkaJEoYxKqk0zaWM87jLZi4PTWDrVQ+tFDDZXdNkaHRjvS/v/KxPxM/PD8yQhBQ19fkh+TWPmwCgXdXA59L5jwE/8UU13pl5ZGabEAgbJyPzCRNKHfBwUnfp1bdZP8ilFvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=keLeolZT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kS0d1+S1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 25 Aug 2024 14:54:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724597689;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fWiOdt2XHcMTbBWWzZSL9waZ0W5oriL5BqzCMWpA2TA=;
	b=keLeolZTMXnpEoSsneuLbuurVzANWsOVVK7KwK+7wc6NPF6936PLMVIsRkbktiRyGSh3Um
	SL2pzfXeu8Au8dMeb0Uw/NF0iBmT04Wgsg7ywQpyavgFgjUHl47F97f0SITMefhFBrTvVK
	Q9L6gLzfy3U8Yyaj1mi65HhvG6eryIK7QlA8Y0AAEwFGZlKNhQl65JdASnxlk3KDXRQMIF
	2CMg4r//xcxBL0uUuklvLsXLKsRnpZXos/5WZ7Xz8Ey4f3gMFe6sY6+4bYwVwVCLTVrA/p
	PBchmVo4tduvIQClmCETcutlGsg0RkkcoG8ltQ215AoHdq+vnDIS25h7oxJqFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724597689;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fWiOdt2XHcMTbBWWzZSL9waZ0W5oriL5BqzCMWpA2TA=;
	b=kS0d1+S110RmlDx5UtariB24GNBJffsRt19lSD88REKRY216UxigmQAQLmZcJr1tId0rkc
	zuJAk1VH3MbhYVCg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Limit the period on Haswell
Cc: Li Huafei <lihuafei1@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 Kan Liang <kan.liang@linux.intel.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240819183004.3132920-1-kan.liang@linux.intel.com>
References: <20240819183004.3132920-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172459768833.2215.4831564360570699596.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     25dfc9e357af8aed1ca79b318a73f2c59c1f0b2b
Gitweb:        https://git.kernel.org/tip/25dfc9e357af8aed1ca79b318a73f2c59c1f0b2b
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 19 Aug 2024 11:30:04 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 25 Aug 2024 16:49:05 +02:00

perf/x86/intel: Limit the period on Haswell

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
---
 arch/x86/events/intel/core.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0c9c270..9e519d8 100644
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

