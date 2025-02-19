Return-Path: <stable+bounces-117092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD2BA3B4A3
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77A83A86F0
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 08:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A323C1E0DD0;
	Wed, 19 Feb 2025 08:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t4DgN7Li"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB391E0DCE;
	Wed, 19 Feb 2025 08:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954181; cv=none; b=GWd3BrRALxSY9f67BMaSVlVDysuBhfFXc504ZJ9JOdwoZBYoU0nAzHtzjipoJgjeLSmlQ0AbXtFDrCMkVnAIQ9tYOyuQK2ANIHW1M5CnyIIO12xmXzuyUhtpcUZMvzMjFx7ZSVOYXjT6TX8ziy298tKL1hMf9umUf06oL0G56wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954181; c=relaxed/simple;
	bh=CL7UzKAgZgnScadDRPXrggynStLg7v+xbqa0Qwpi5hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHw/krGoK7N7ErasTCqd6cjfUH66fUSuxkr/wc9E19gE8YEYj3QFk22uTMGSSTDILmdXT/F4mRj3rvMz84iPghatZWNmDxZ+8KG5tWcgJmIFKI2DIUUGM3l6gt2LnZ6WbHR6JuafpoBzo3dpe2BUejtmn6owPNvPWAmdAkznNTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t4DgN7Li; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A7AC4CED1;
	Wed, 19 Feb 2025 08:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739954181;
	bh=CL7UzKAgZgnScadDRPXrggynStLg7v+xbqa0Qwpi5hA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4DgN7Li3cpRavZ2zmbiXGdllMipMbnFixdC02QbDZgUDJfdjPWEfugAdYdONJ5Uo
	 eJaOXrr1aRPt5yZvdz7atHwQPkMQEo7s/vBCJrdOO2U3Ni4IYBMwIE3s63nMjgFCPD
	 f0xUfvH7qg436HkKsyqdb/q8aM5v7uSKXneuTIJQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kan Liang <kan.liang@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 6.13 122/274] perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF
Date: Wed, 19 Feb 2025 09:26:16 +0100
Message-ID: <20250219082614.392926575@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082609.533585153@linuxfoundation.org>
References: <20250219082609.533585153@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <kan.liang@linux.intel.com>

commit 47a973fd75639fe80d59f9e1860113bb2a0b112b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/core.c      |   18 ++++++++++--------
 arch/x86/include/asm/perf_event.h |   28 +++++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 11 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4887,20 +4887,22 @@ static inline bool intel_pmu_broken_perf
 
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
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -187,11 +187,33 @@ union cpuid10_edx {
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



