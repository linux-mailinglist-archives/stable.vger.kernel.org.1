Return-Path: <stable+bounces-118511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033FBA3E5AE
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 21:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A513A798A
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 20:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630D91DDC14;
	Thu, 20 Feb 2025 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIvWi5Pd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4881D5160
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 20:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082617; cv=none; b=dHAIYOUsVNwyGNxmnsw7bE8myAqAVPCBA5/9CqCkb5ue6TMquGLLAWu3LTsG+l4ltiWnra/CmQD4B0IDEgGC2fN2QX+z6N5P5rOIUfn0eOFhm3jEcA+hBDwgo1bdx1Ue8PGYpmtl6C+7YhVoH35x0+3WXb/Dp608BF+s2OBYNpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082617; c=relaxed/simple;
	bh=JopwU1tRzm/OLHD7ECLfVZYglL1z+L9dpaJpCGJU0E4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kBKiYoW0IAzxd9cfPEszxJnM+5z0FllFn/3Pa6aM8PoiH1EWc4FUbj9neAT1QVmm3j7mkG3/sxlBuW3RedDTQMmLz3AvjmIO9tfDs9fKVZ3mBtkYRKrnLmeHw18xZaDEO3dPRHlmMzYNprJo8JerRHl4FQFAFgDCGTVcZ+0F1x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIvWi5Pd; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740082615; x=1771618615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JopwU1tRzm/OLHD7ECLfVZYglL1z+L9dpaJpCGJU0E4=;
  b=kIvWi5PdZqcC5U5hcWEzn6BmuKFPhgzamV9wPzeDhZTmfC6nSxd3SqjT
   u8FNnoJaGrhg+ub+YWB0t5zCSClasVaClPP1zWx7YXH+dwJouo22y2G6Z
   KtwTn748Mb6R6CmnszuCFUfYzIg3OzXT7dLQJv4yKLfSgtxkA8jsYg2SU
   8qcYWDJhsSbFopD40iArI3w7yRS7xVoJqCVVqc2lOBif6+ik5f7Y36xyu
   2pwmMkzCmt1t1Ljf4VRy4dX3vzhDHM+uvySnfqq+ckcOpdX9Rl4xgM/rX
   hzIENEvirDbT26tNNHL+/2P8Jry0AYebthAweiDsuTJYeiEpI8AcoHXUU
   A==;
X-CSE-ConnectionGUID: zqUP3iloSECCN1L4B+cniw==
X-CSE-MsgGUID: CzA/AtaBR+yhhnjH9YoYjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="58430560"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="58430560"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 12:16:54 -0800
X-CSE-ConnectionGUID: U9oXL2eeSJaYSkAKqoenEg==
X-CSE-MsgGUID: f9hbXyH2S5WYCQpvqDjZ8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115009262"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 20 Feb 2025 12:16:53 -0800
From: Kan Liang <kan.liang@linux.intel.com>
To: stable@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 6.6.y] perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF
Date: Thu, 20 Feb 2025 12:17:11 -0800
Message-Id: <20250220201711.3030856-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <2025021817-pull-grievance-de31@gregkh>
References: <2025021817-pull-grievance-de31@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 47a973fd75639fe80d59f9e1860113bb2a0b112b ]

(The patch is not exactly the same as the upstream patch. Because in the
6.6 stable kernel, the umask2/eq enumeration is not supported. The
number of counters is used rather than the counter mask. But the change
is straightforward, which utilizes the structured union to replace the
macros when parsing the CPUID enumeration. It also fixed a wrong
macros.)

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
---
 arch/x86/events/intel/core.c      | 17 ++++++++++-------
 arch/x86/include/asm/perf_event.h | 26 +++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 37c8badd2701..52f2ca214617 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4643,16 +4643,19 @@ static void intel_pmu_check_num_counters(int *num_counters,
 
 static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 {
-	unsigned int sub_bitmaps = cpuid_eax(ARCH_PERFMON_EXT_LEAF);
-	unsigned int eax, ebx, ecx, edx;
+	unsigned int cntr, fixed_cntr, ecx, edx;
+	union cpuid35_eax eax;
+	union cpuid35_ebx ebx;
 
-	if (sub_bitmaps & ARCH_PERFMON_NUM_COUNTER_LEAF_BIT) {
+	cpuid(ARCH_PERFMON_EXT_LEAF, &eax.full, &ebx.full, &ecx, &edx);
+
+	if (eax.split.cntr_subleaf) {
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
-			    &eax, &ebx, &ecx, &edx);
-		pmu->num_counters = fls(eax);
-		pmu->num_counters_fixed = fls(ebx);
+			    &cntr, &fixed_cntr, &ecx, &edx);
+		pmu->num_counters = fls(cntr);
+		pmu->num_counters_fixed = fls(fixed_cntr);
 		intel_pmu_check_num_counters(&pmu->num_counters, &pmu->num_counters_fixed,
-					     &pmu->intel_ctrl, ebx);
+					     &pmu->intel_ctrl, fixed_cntr);
 	}
 }
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 85a9fd5a3ec3..384e8a7db482 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -177,9 +177,33 @@ union cpuid10_edx {
  * detection/enumeration details:
  */
 #define ARCH_PERFMON_EXT_LEAF			0x00000023
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
-- 
2.38.1


