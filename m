Return-Path: <stable+bounces-118662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B77A40992
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 16:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A022D7AC786
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F1C1C863C;
	Sat, 22 Feb 2025 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORV7LJgR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E2A69D2B
	for <stable@vger.kernel.org>; Sat, 22 Feb 2025 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239610; cv=none; b=W7p3gFSXffMO4lCcCemTWiN0QHbx1qoJVsB373iUa0KSmANi20SDWNTlDlzmH3GTs2aGAybCDsbOKI6eEh9fyz5oIB2ByzHdntk6UDdbUMmFpvk+2gz7jPMuMXya/kIetY8GH04ZczCdWLIHMa+g80ae3KHxJGfMXB+Ejmmazhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239610; c=relaxed/simple;
	bh=8q9F57A9Z3+BMQZbEK3k9OVkXzFjOj5yEjsTJPuwyGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqXZhVJRLPKYiAht0cKat8XVoUvzO4DJEscDXV+fEkiE+BdE1TmYyHO3wpsPAug0PkeUowhtrgZ86w8mM74JMKNcw62lQ6JeMz1YWztRzG1Y0PtxohvQe9Ci8W8FL60tg3tJP6iOs8dl1r3FsbnxTa+pElhCu2o+3x4rcjaQpIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORV7LJgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A50C4CED1;
	Sat, 22 Feb 2025 15:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740239610;
	bh=8q9F57A9Z3+BMQZbEK3k9OVkXzFjOj5yEjsTJPuwyGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ORV7LJgRFcdnqGOLohwM29C/crjkWWkLh1NN7S1YbHLiAOkDJkRDd9nFo1TyqYHy1
	 kot/FxShgvSLBsnpNKbshYlXwQAco3NAaCw4wJ40K1RtzGH9xHUgLtW+PSEZIqC8tp
	 K/YhT+0p1hPr//1oKiFQCTJL9m4PcU7G14RAPr5fAF222yoZXa3TvOU4ALgyjCrMf5
	 k7I1TJMZJtWgSdq4B19YffbF+bHZeSZ/AfC+5yW9RdrbMVuXo/aAxxXVUltRSEDUR7
	 lahCEeYLxaUTLU2IIA70HkIk7cWzqyHqPHSOGMP9cNMam5bkIbqOZ4qSgpfDPPMerJ
	 8BINuBaCLBG3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kan.liang@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF
Date: Sat, 22 Feb 2025 10:53:28 -0500
Message-Id: <20250221195603-304270ded225b186@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250220201711.3030856-1-kan.liang@linux.intel.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
❌ Build failures detected

The upstream commit SHA1 provided is correct: 47a973fd75639fe80d59f9e1860113bb2a0b112b


Status in newer kernel trees:
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Failed     |  N/A       |
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-6.13.y. Reject:

diff a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c	(rejected hunks)
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
 
diff a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h	(rejected hunks)
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
Patch failed to apply on stable/linux-6.12.y. Reject:

diff a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c	(rejected hunks)
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
 
diff a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h	(rejected hunks)
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
Patch failed to apply on stable/linux-6.1.y. Reject:

diff a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c	(rejected hunks)
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
 
diff a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h	(rejected hunks)
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
Patch failed to apply on stable/linux-5.15.y. Reject:

diff a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c	(rejected hunks)
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
 
diff a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h	(rejected hunks)
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
Patch failed to apply on stable/linux-5.10.y. Reject:

diff a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c	(rejected hunks)
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
 
diff a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h	(rejected hunks)
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
Patch failed to apply on stable/linux-5.4.y. Reject:

diff a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c	(rejected hunks)
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
 
diff a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h	(rejected hunks)
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

