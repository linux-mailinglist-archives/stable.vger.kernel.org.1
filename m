Return-Path: <stable+bounces-110248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DFCA19E5B
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 07:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63AD63AE192
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 06:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AA71C5F1F;
	Thu, 23 Jan 2025 06:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UhAqwGXV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F40170A0A;
	Thu, 23 Jan 2025 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737613217; cv=none; b=XPlO0DYjVtG5fg5PB8tSE5xjpNj26TGLyXQNguUkgqV0svCvMgGhvFEDHoqBd7xatdjEyce1Mc12JScDhRDRUF9Otr1qa+jT0DGvApncK/zyY9cQOuQRtHnu1gd3brk8g4ChNPs/ElOmVG9szUaiwFluYtmAppWMotoR9MOuSv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737613217; c=relaxed/simple;
	bh=Q7f0JQndshh2AJGcplxnFEAoV0+2mUf/eOiGuWfB/D4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RE7b8y+R3w+bNOIU0alCeiSjbLJif/cSq3ilUpSzQnVvqdpUVbKt2HUqWa0o+C5WYrB5roIS7x70s0Dd4GzCIdN1nZ5BRamETVrAPWCClCkH1FbiIHIwluPuWJKJiwINdYw3BH+RBgbq4ENQUfMMu9779CnthJelbEZENzb1Pgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UhAqwGXV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737613217; x=1769149217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q7f0JQndshh2AJGcplxnFEAoV0+2mUf/eOiGuWfB/D4=;
  b=UhAqwGXVAoYdIC6+uWHzXrfBjU4Emo8/vvFkLJm3fDedqIN7SQoWsf/v
   ZL3xd2GIzUi6qltV4MPx50gwtaKq9E29GvwDUS6uFa8HXtG1QeZQl05f7
   4H18PF6hvYqbz1/mptgtAN6311g7qbs8PIlgiUSBHURNXJaVqZUM2BmhF
   uCE5wWIdttAxei2eVigqi6vGZp/9vRoSbyKFv8F8/nsE/VYzJgHwP+G0b
   bRmbQk+ZyLp+dBWrvT5g+c82HMOkK1R+cEFfhsZ4tLMd6DYpGvOoV60yg
   nVjnXT75QLgO46nnQY8u+ww0Dmwq0MRGKV3t+K3npRS8+Gm947rUrAzCZ
   g==;
X-CSE-ConnectionGUID: cIo1ZoFsS4qTm7xVonexyw==
X-CSE-MsgGUID: 4iEMtzloQPOoaCUQhFFXUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="55513032"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="55513032"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 22:20:16 -0800
X-CSE-ConnectionGUID: 2YFA9debS46ba63sEM9DoQ==
X-CSE-MsgGUID: V31eWlYtQIaqQj5j+kf59w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112334423"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa003.jf.intel.com with ESMTP; 22 Jan 2025 22:20:12 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 02/20] perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF
Date: Thu, 23 Jan 2025 14:07:03 +0000
Message-Id: <20250123140721.2496639-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
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

Fixes: eb467aaac21e ("perf/x86/intel: Support Architectural PerfMon Extension leaf")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/core.c      | 4 ++--
 arch/x86/include/asm/perf_event.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5e8521a54474..12eb96219740 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4966,8 +4966,8 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 	if (ebx & ARCH_PERFMON_EXT_EQ)
 		pmu->config_mask |= ARCH_PERFMON_EVENTSEL_EQ;
 
-	if (sub_bitmaps & ARCH_PERFMON_NUM_COUNTER_LEAF_BIT) {
-		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
+	if (sub_bitmaps & ARCH_PERFMON_NUM_COUNTER_LEAF) {
+		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF_BIT,
 			    &eax, &ebx, &ecx, &edx);
 		pmu->cntr_mask64 = eax;
 		pmu->fixed_cntr_mask64 = ebx;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index adaeb8ca3a8a..71e2ae021374 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -197,7 +197,7 @@ union cpuid10_edx {
 #define ARCH_PERFMON_EXT_UMASK2			0x1
 #define ARCH_PERFMON_EXT_EQ			0x2
 #define ARCH_PERFMON_NUM_COUNTER_LEAF_BIT	0x1
-#define ARCH_PERFMON_NUM_COUNTER_LEAF		0x1
+#define ARCH_PERFMON_NUM_COUNTER_LEAF		BIT(ARCH_PERFMON_NUM_COUNTER_LEAF_BIT)
 
 /*
  * Intel Architectural LBR CPUID detection/enumeration details:
-- 
2.40.1


