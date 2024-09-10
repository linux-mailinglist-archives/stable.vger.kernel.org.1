Return-Path: <stable+bounces-74263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F31972E5B
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA1D1C20F51
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD6918C024;
	Tue, 10 Sep 2024 09:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dWfXEm/R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD07318B498;
	Tue, 10 Sep 2024 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961294; cv=none; b=JOm2pKTrFN1xfWuoGYu2vintMX1mD+uJSOEN34t7vtQFZgbIdKubQiKKQ+SWfUIsdbU5hmgLETDyWDzY/88i6mK/j8SpEhXGieZmdltS3zzaW/41BPBSPZE2+QyCZknkqZN9lNjUBpwMPTEue96C4o8n+Z8EhAnSXQVz23GmmKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961294; c=relaxed/simple;
	bh=eDCRDDqIRSzCif9HNmmFiOWrxfsVzqI2SAeSkso6KWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVtTnAo0knD/by0dQBVurYkW21Sco57OEyPGx9ZoXvShSypizMDb18m8D608qzuq03SN+ned3m6ErcHmftFdl7qki1+g8Ok9E6VETquh4nt6sQ2QQ+PiADx+w2+NXQT36UL9Op4yg8sLDs08ZhvxK+FyJ4XEqAhLh++cgxNj5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dWfXEm/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8A1C4CECC;
	Tue, 10 Sep 2024 09:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961294;
	bh=eDCRDDqIRSzCif9HNmmFiOWrxfsVzqI2SAeSkso6KWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWfXEm/RmdQLxajWgykV8U6KEq/5g1igafOhg8tYfQnng74lOhwoLil9myyF5ntau
	 lvXE8l2+zhO9euLLZDgbuV2YsRuUKnKK6xQZyMAYcBA9iRfokud7R893Itp7B8wqkk
	 UupcUhozI9q4shLeOak6RVhst6LGyzUAS9fx4rMw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 6.10 022/375] perf/x86/intel: Limit the period on Haswell
Date: Tue, 10 Sep 2024 11:26:59 +0200
Message-ID: <20240910092623.019775521@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <kan.liang@linux.intel.com>

commit 25dfc9e357af8aed1ca79b318a73f2c59c1f0b2b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/core.c |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4529,6 +4529,25 @@ static enum hybrid_cpu_type adl_get_hybr
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
@@ -4546,8 +4565,7 @@ static enum hybrid_cpu_type adl_get_hybr
  */
 static void bdw_limit_period(struct perf_event *event, s64 *left)
 {
-	if ((event->hw.config & INTEL_ARCH_EVENT_MASK) ==
-			X86_CONFIG(.event=0xc0, .umask=0x01)) {
+	if (erratum_hsw11(event)) {
 		if (*left < 128)
 			*left = 128;
 		*left &= ~0x3fULL;
@@ -6573,6 +6591,7 @@ __init int intel_pmu_init(void)
 
 		x86_pmu.hw_config = hsw_hw_config;
 		x86_pmu.get_event_constraints = hsw_get_event_constraints;
+		x86_pmu.limit_period = hsw_limit_period;
 		x86_pmu.lbr_double_abort = true;
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;



