Return-Path: <stable+bounces-111183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D908A220DE
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 16:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98CE3A7F9C
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 15:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2E01DE8AD;
	Wed, 29 Jan 2025 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KEy/zouT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AEC1CB9EA;
	Wed, 29 Jan 2025 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738165691; cv=none; b=nCC2zXzpy/B5cW8kfyFpjOFv6SZdUIHPpaJTjSS7WyBLLGbbqilNVKLyh+bVu8zgEyHaJZ0dG6+zdVdC5qA5ZQAdXRxPmY8vVSqR1QiQRoGA+O1qqQUJAux+iHwJnB4yGweZsATFquzNnhK+68j/G55NfftmsWWDmzewD+ycvog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738165691; c=relaxed/simple;
	bh=a5xLFkIixG4demBHG/GQFB10Llx4qy/6C9pHVc2brF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bKEfiG8kdUPgCh5XpyI0gAqDaXkB7J1em84FXHCuGyxZVfSpIA5bAg9bPXSLy8Kp4ZyWH601vrj5gPHLUniU6XxcAcIOvJqGBcDi9drxEpI/o2iM17xj2Wt6ZLBqiaTWGXrYPvp7FFD/0HSgrAsQ99dwh7pWT65zVEDNY2eBgMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KEy/zouT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738165689; x=1769701689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a5xLFkIixG4demBHG/GQFB10Llx4qy/6C9pHVc2brF0=;
  b=KEy/zouTU+I49XaS71AI5oK9P7e+EebPYJh4SMX1dxpzQSksYnXKTCLN
   9b3o8IJPM9SZu4Bb6TqNlIs/9ufTxI69ZYXTARew/+fMK3QbxAPZyWL2c
   8qyYxvPcv9iNNJZDMDGuCAt+fs9OdBemLnN7xvrAbSYGbZV1yePmVwxz+
   xEpONL4o9L3NV5hoDk0/63A0T/zbFxk1zdEOVLc/lOdMQQ56X95LiMhHi
   EcRV+nGHg7D5XJ+2q9s10+EC1Nqyd7NCjwoLfYO8BQyCtBz49QkUIcMRk
   runy8V5WfFee+ob0vYsTVHt6nQQepUPKt+plrt5e2hmdXB8Lm/48HU0GB
   A==;
X-CSE-ConnectionGUID: DPgA8iR3R2ST7GfozVDZGQ==
X-CSE-MsgGUID: IQ71ftDaRmqFU9sEb/2dkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="37882923"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="37882923"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 07:48:06 -0800
X-CSE-ConnectionGUID: xvpe4UMyRRyE1aQfqyXsrg==
X-CSE-MsgGUID: XhrrMENjR8meaLROX8aOrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108927429"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 29 Jan 2025 07:48:06 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	ak@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: dapeng1.mi@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF
Date: Wed, 29 Jan 2025 07:48:19 -0800
Message-Id: <20250129154820.3755948-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250129154820.3755948-1-kan.liang@linux.intel.com>
References: <20250129154820.3755948-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

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
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/core.c      | 18 ++++++++++--------
 arch/x86/include/asm/perf_event.h | 28 +++++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0a1030eb6db8..120df9620951 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4945,20 +4945,22 @@ static inline bool intel_pmu_broken_perf_cap(void)
 
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
index adaeb8ca3a8a..9aef5d044706 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -194,11 +194,33 @@ union cpuid10_edx {
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
-- 
2.38.1


