Return-Path: <stable+bounces-59141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E3D92EC6E
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 18:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554471F233FF
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 16:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906ED16C68C;
	Thu, 11 Jul 2024 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DhMXRI0u"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C98155CB8;
	Thu, 11 Jul 2024 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714554; cv=none; b=NYNr9Hs6ws0DpWIbCMsd1bj3VTKqqKZ7A2pHOARGEWGA5aBU8/YSqXJFmMEXm+MU5wwWkAfDNHXbowt8eWj6OmQ5DYn/RhuUCtYM7+xru3m7rNLiLuYimkp7OQd/v1+609gYVH2Hs5l2aZgW1tC4hsGbWQeGX+RP32V+hRG+yKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714554; c=relaxed/simple;
	bh=nu4E+KG9xuPTzxWlnYTkEQF4+5J5OTZxHGatiEDscYA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FzbWmtJs3/+VQWOYjJ2+glZMTF1pp/lfm95odM2bN5DQnpY9uRLJvJpRyIqG+6T6WrpOvcVdNK1WNkXIkv1yPOGXghkQcnQjseFLoX9pv5GIZ7zWQXjeL5QcHJjHRUO6Rpa5AUEjrUEoXd+LLMUQBX+slO8ML+Nnj9euCDxFg9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DhMXRI0u; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720714552; x=1752250552;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nu4E+KG9xuPTzxWlnYTkEQF4+5J5OTZxHGatiEDscYA=;
  b=DhMXRI0u1LRtD6MsfSwQSBtRv2Ui830u1omWKtfNbqUcZQJY/lY3RUwt
   z0LeU22jg5unc8bhG3kaii2t7lJZ1fVnq5/Ni1BeZEvVMjFcRm1ZlgNDF
   OrFAASAnIKhdzDO4s1JLm6O00sahncFQs8shQ4AYH6MRRSxt+MN6LURZh
   VvxYGTPD2oLtc6aM/5RsR8XE1dmr/z0sYg7aNVazlsgz0JnSoxe3U4ShZ
   lxW5DMv/VS0cWSZZAstqvU2/MiKx9bSbkkn6lpSj2oiXnV4VKRzX5ifSh
   UpvB3/21yk/JxeyOpSEPva4O2x1nUQsPjb7NmbkQqDSeOs/DV//hzU0Fx
   g==;
X-CSE-ConnectionGUID: rps1EfeuTripT+iN6Kg5mg==
X-CSE-MsgGUID: 0+dMQ5nSQvOmgzTB6cie5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18256354"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="18256354"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 09:15:50 -0700
X-CSE-ConnectionGUID: jY/+j+1lTM+b/+U45mdZ6Q==
X-CSE-MsgGUID: SXO4woDFR5i9HztP026IJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="53559170"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa005.jf.intel.com with ESMTP; 11 Jul 2024 09:15:49 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF
Date: Thu, 11 Jul 2024 09:16:36 -0700
Message-Id: <20240711161636.1428705-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
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
index cd8f2db6cdf6..3fb81f7b618c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4842,8 +4842,8 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
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
index 91b73571412f..41ace8431e01 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -190,7 +190,7 @@ union cpuid10_edx {
 #define ARCH_PERFMON_EXT_UMASK2			0x1
 #define ARCH_PERFMON_EXT_EQ			0x2
 #define ARCH_PERFMON_NUM_COUNTER_LEAF_BIT	0x1
-#define ARCH_PERFMON_NUM_COUNTER_LEAF		0x1
+#define ARCH_PERFMON_NUM_COUNTER_LEAF		BIT(ARCH_PERFMON_NUM_COUNTER_LEAF_BIT)
 
 /*
  * Intel Architectural LBR CPUID detection/enumeration details:
-- 
2.38.1


