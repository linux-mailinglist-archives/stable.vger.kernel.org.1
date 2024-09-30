Return-Path: <stable+bounces-78283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEA498A8DF
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 17:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279961F22C2F
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 15:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6605192D64;
	Mon, 30 Sep 2024 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bNXFCOBr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8B8192B66;
	Mon, 30 Sep 2024 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710877; cv=none; b=N3Xjq5GX9+WPnU3i86/rs4Hz4zTVXCNX3e77N16jBLz6IhhksFJGl/clSg8gw9i/q7rTMUYySJQakoU01ZsLpS6Qt3p0YOOn4lDprJsI5I325uj8yBNFOYZh9/0mcMfuoDjk4srT6qYaoZxvkBByff2yHiKCNexGeRiNqRULhFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710877; c=relaxed/simple;
	bh=59MOJI7sH5VZtSb/aVSGviiGNxKMeono+gO/jFoLHuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gqh5UZi2K4Eb3N1w7vDK4XCKpwON83waokCiHMtIkLnBgwk9FgNuKo2qVQ8bqvINDneKCSGAXVHP3f5eEWYPq/JdaXoqWMb/h+Ij8vLTzQmDpWY/CMiSM7dIhbyPtGhDj+yJq6nWIjNc8yDntBoJqo+bnG5by+ff+WYUzD6lwfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bNXFCOBr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727710876; x=1759246876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=59MOJI7sH5VZtSb/aVSGviiGNxKMeono+gO/jFoLHuQ=;
  b=bNXFCOBrn4WOvnTYnFFjpC2DBntQshuZJbEZTpPkBrG07J2BJQfMr7PD
   e/3F9eAmTjF6/ymCuviqoSrcawcKbPTk26UCOvANAoACNUbLfpy4T1zXE
   Tm5qCencJMxuj6RD9G/O6oxJMN02NGZodbRfVB0EFDvJBAeI5bKir+1fG
   CAGHY740l2lpHZceFeQ9QFRL98PopR2J8r6QyD72vXjdSnmkAEDlyADio
   uQmgdxn0komIFMP5yUwazO9cy6rlLVQgogXszF9mjlZ69WOuJEhlEz0JA
   5qi6eW8MFEqzofDjBAHaaWYtGIJU7nAwLgv9plgn+c7rsR/Rl3x3dO0Sb
   A==;
X-CSE-ConnectionGUID: OqvzPz0QRKex9ylKREdCMw==
X-CSE-MsgGUID: NPbvLimISEmJpI5xa24Czg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26272157"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26272157"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 08:41:13 -0700
X-CSE-ConnectionGUID: bg2RpUXxSDCYMyvoh/L7jw==
X-CSE-MsgGUID: RstOgzmORn2q2/lAn8UbhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="78172478"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 30 Sep 2024 08:41:13 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-kernel@vger.kernel.org
Cc: eranian@google.com,
	ak@linux.intel.com,
	thomas.falcon@intel.com,
	Kan Liang <kan.liang@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF
Date: Mon, 30 Sep 2024 08:41:20 -0700
Message-Id: <20240930154122.578924-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240930154122.578924-1-kan.liang@linux.intel.com>
References: <20240930154122.578924-1-kan.liang@linux.intel.com>
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
index 342f8b1a2f93..123ed1d60118 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4900,8 +4900,8 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
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
index e3b5e8e96fb3..1d4ce655aece 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -191,7 +191,7 @@ union cpuid10_edx {
 #define ARCH_PERFMON_EXT_UMASK2			0x1
 #define ARCH_PERFMON_EXT_EQ			0x2
 #define ARCH_PERFMON_NUM_COUNTER_LEAF_BIT	0x1
-#define ARCH_PERFMON_NUM_COUNTER_LEAF		0x1
+#define ARCH_PERFMON_NUM_COUNTER_LEAF		BIT(ARCH_PERFMON_NUM_COUNTER_LEAF_BIT)
 
 /*
  * Intel Architectural LBR CPUID detection/enumeration details:
-- 
2.38.1


