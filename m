Return-Path: <stable+bounces-116722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6636FA39ACD
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61BA03A4999
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549AF234973;
	Tue, 18 Feb 2025 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ozy/sZyU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146A82343BE
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878101; cv=none; b=Uwv3ravfAR+rRrZox9z8TNl4nWRGNDALMF9iIru1c4K/h6dD/yNh+dAjKF1VbT99gwabGwmjTOM++e8x10MB1BOTDZH+7WJpGn6JCj97NONaGaES+Eu++KngGgLFfJrlKhksuN7uH/4gA+IQnbDxgTWO95BJedR8ymZzUg9VzqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878101; c=relaxed/simple;
	bh=ym+TeM0qQyMjMhQ2LDoSd09SYzvp7ZMlz8s48riT6Fw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a7loIjNb6cGOikHpuLbQ/3NpuKdjJfbGntcXgAL0ZsFIp0e6deO9heNkPUT2BM9winVuGQmf1wSJJIGw+2YLZ/iqk9YbOVDu1dASWmu/Rur8VdEgVvkbV+afeS2l5FBae+Tor3N+u2pw05L5kenNBgq/iXgfEBiBARQIu2F/ni0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ozy/sZyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390AFC4CEE7;
	Tue, 18 Feb 2025 11:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739878100;
	bh=ym+TeM0qQyMjMhQ2LDoSd09SYzvp7ZMlz8s48riT6Fw=;
	h=Subject:To:Cc:From:Date:From;
	b=Ozy/sZyUy3NyrY3MnyZQVqq+o29RT0LIjbCGO8JSJyQ4NVSP7sTyc1bWCRqe6rEoK
	 qiilXcvoECiP3M+020YWVNPKz6aLKJmcdISEeJwSajVmfF84jH6FYsdxxt4aiod3S2
	 R3iAWSwcw2BxSCd6iPUJgqnmmm3qiMytv79bAad4=
Subject: FAILED: patch "[PATCH] perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF" failed to apply to 6.6-stable tree
To: kan.liang@linux.intel.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Feb 2025 12:28:17 +0100
Message-ID: <2025021817-pull-grievance-de31@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 47a973fd75639fe80d59f9e1860113bb2a0b112b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021817-pull-grievance-de31@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 47a973fd75639fe80d59f9e1860113bb2a0b112b Mon Sep 17 00:00:00 2001
From: Kan Liang <kan.liang@linux.intel.com>
Date: Wed, 29 Jan 2025 07:48:19 -0800
Subject: [PATCH] perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF

The EAX of the CPUID Leaf 023H enumerates the mask of valid sub-leaves.
To tell the availability of the sub-leaf 1 (enumerate the counter mask),
perf should check the bit 1 (0x2) of EAS, rather than bit 0 (0x1).

The error is not user-visible on bare metal. Because the sub-leaf 0 and
the sub-leaf 1 are always available. However, it may bring issues in a
virtualization environment when a VMM only enumerates the sub-leaf 0.

Introduce the cpuid35_e?x to replace the macros, which makes the
implementation style consistent.

Fixes: eb467aaac21e ("perf/x86/intel: Support Architectural PerfMon Extension leaf")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20250129154820.3755948-3-kan.liang@linux.intel.com

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 966f7832497d..f3d5b718f93f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4905,20 +4905,22 @@ static inline bool intel_pmu_broken_perf_cap(void)
 
 static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 {
-	unsigned int sub_bitmaps, eax, ebx, ecx, edx;
+	unsigned int cntr, fixed_cntr, ecx, edx;
+	union cpuid35_eax eax;
+	union cpuid35_ebx ebx;
 
-	cpuid(ARCH_PERFMON_EXT_LEAF, &sub_bitmaps, &ebx, &ecx, &edx);
+	cpuid(ARCH_PERFMON_EXT_LEAF, &eax.full, &ebx.full, &ecx, &edx);
 
-	if (ebx & ARCH_PERFMON_EXT_UMASK2)
+	if (ebx.split.umask2)
 		pmu->config_mask |= ARCH_PERFMON_EVENTSEL_UMASK2;
-	if (ebx & ARCH_PERFMON_EXT_EQ)
+	if (ebx.split.eq)
 		pmu->config_mask |= ARCH_PERFMON_EVENTSEL_EQ;
 
-	if (sub_bitmaps & ARCH_PERFMON_NUM_COUNTER_LEAF_BIT) {
+	if (eax.split.cntr_subleaf) {
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
-			    &eax, &ebx, &ecx, &edx);
-		pmu->cntr_mask64 = eax;
-		pmu->fixed_cntr_mask64 = ebx;
+			    &cntr, &fixed_cntr, &ecx, &edx);
+		pmu->cntr_mask64 = cntr;
+		pmu->fixed_cntr_mask64 = fixed_cntr;
 	}
 
 	if (!intel_pmu_broken_perf_cap()) {
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 1ac79f361645..0ba8d20f2d1d 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -188,11 +188,33 @@ union cpuid10_edx {
  * detection/enumeration details:
  */
 #define ARCH_PERFMON_EXT_LEAF			0x00000023
-#define ARCH_PERFMON_EXT_UMASK2			0x1
-#define ARCH_PERFMON_EXT_EQ			0x2
-#define ARCH_PERFMON_NUM_COUNTER_LEAF_BIT	0x1
 #define ARCH_PERFMON_NUM_COUNTER_LEAF		0x1
 
+union cpuid35_eax {
+	struct {
+		unsigned int	leaf0:1;
+		/* Counters Sub-Leaf */
+		unsigned int    cntr_subleaf:1;
+		/* Auto Counter Reload Sub-Leaf */
+		unsigned int    acr_subleaf:1;
+		/* Events Sub-Leaf */
+		unsigned int    events_subleaf:1;
+		unsigned int	reserved:28;
+	} split;
+	unsigned int            full;
+};
+
+union cpuid35_ebx {
+	struct {
+		/* UnitMask2 Supported */
+		unsigned int    umask2:1;
+		/* EQ-bit Supported */
+		unsigned int    eq:1;
+		unsigned int	reserved:30;
+	} split;
+	unsigned int            full;
+};
+
 /*
  * Intel Architectural LBR CPUID detection/enumeration details:
  */


