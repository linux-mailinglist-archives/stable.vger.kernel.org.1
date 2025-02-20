Return-Path: <stable+bounces-118475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A09A3E0EC
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 17:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0720D3A8B75
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB331FDA94;
	Thu, 20 Feb 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvEJDIHq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5127EDF58
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069110; cv=none; b=Cs6ltTMbflfJxTpbd/0J0AnI5hetJlzXg4c9Q6A+h4i26KaKw7Fj8l1sGYaoBd9Y3ziGLEubW33X+z39+HyFc3/+uH1v9Oe9A+CDQT0uAUFszHMcs77EWYXn2GSuy23XCBv5OjFBabBQbxfEkH829eBe+NnAIUL6S8yBY2MxnNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069110; c=relaxed/simple;
	bh=E9xKkhlHj9hGw0SPbX/em9ZYiOnxyo7qbN+GUWXseys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rp+qY5mFY1ZsRa93xHHj45JyhfVNeJrE6Q+N0vmpWwtTkWVKp2y0pFZwQYaBUGkGwQKWnAOM1EH2BKugLH34tWOpXMPYYpm4RWw66snbGxjFhuR4ODHiOnzd6x3O/88UdhWDFB3WkfrL3lA5cB6kDtczzNtGoaOZRu5SaJI61Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvEJDIHq; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740069110; x=1771605110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E9xKkhlHj9hGw0SPbX/em9ZYiOnxyo7qbN+GUWXseys=;
  b=PvEJDIHq3wW7N22lhI7BSe74lPo+F+/0DF1tTPso8lR0Dg8fsI9wa2PX
   kG4hgCc9Jqb1iCk4Sz5hqT0ELaOY8rkWsj39iMap7r/Q6CFkO0uaiohvg
   7mk0OJmPizMi6BLKec4KkHnQBtjBdBfOmr3HxvcVriufKg90Fip5qSCNH
   PglaqfN4xc8QaZGFvHnRap8Yv9NQI+cqw7YO58eaci71d/shpQHhiIJau
   5/T72msWlCTfkFVGlRa2Q++I5IMUg1vEMU8g/EXlCXdqEN0bVcdFLUrKv
   eJCtEdApiyXOSF4yc+TwyWAxqSaSzxohI3PZLk/nId2AizlsDrEGUow87
   Q==;
X-CSE-ConnectionGUID: bao12s8xSYmMN+YnsFFsuA==
X-CSE-MsgGUID: eo/ChcFIRkGinyt9sFzo7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40044926"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40044926"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:31:49 -0800
X-CSE-ConnectionGUID: wudXInrIQPSamfrdbzRWFA==
X-CSE-MsgGUID: HNvEU4tuQ1ON6qkxxLcEZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="115068146"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 20 Feb 2025 08:31:48 -0800
From: Kan Liang <kan.liang@linux.intel.com>
To: stable@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 6.6.y] perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF
Date: Thu, 20 Feb 2025 08:31:46 -0800
Message-Id: <20250220163146.3030320-1-kan.liang@linux.intel.com>
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


