Return-Path: <stable+bounces-83389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6D599924A
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 21:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB071C24AB6
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 19:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F171E1CF2A6;
	Thu, 10 Oct 2024 19:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BPwlFp3x"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A081C9ECA;
	Thu, 10 Oct 2024 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728588455; cv=none; b=mYhgTGUqfDqH40wiL7sizSE8WeGT9DGr+ti3ekROCP3/dpIQ9+/UXH7vUtLKiJFN91Hs8fV351yFPTxoUCo1gzRQsUtXnee5GFkNBu9i9ZGerxJid+4xfYix384Cp6FCnBsyvsay4dl1FYNgoWBtVZQ+NmPA/0QITN/JDDzGIcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728588455; c=relaxed/simple;
	bh=4s1F1amb2HpeSQnXE9kDw0v+CMKI1EweulQR8X5Vto0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lLGARUU/dE3BdvOT0lL4t96NgQXPst/gVVzXt4WjOfNm6ge28TLvNJQPpL9ouUy+ThpmyHaF7SGJviXxPzG0Ri1gFVoVTDD+9e851GIGtcSzY8pxAre/quyZmyIxlQ+wDDKDgCE/uJRsGl+HtMI8yc50e/JQ+HBs8En8PRLvMgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BPwlFp3x; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728588454; x=1760124454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4s1F1amb2HpeSQnXE9kDw0v+CMKI1EweulQR8X5Vto0=;
  b=BPwlFp3xSnN+cyI/QXLW5BBG/Up9te6+D/AEJS9tkcjJGSDLnhwmDCSz
   9ER2Xs5ODfX9UiIYsGpioz1hfGrhX/UrwX9iabCio8gPz1QOxT/bMC4z8
   zoWkNNcXtQlyIW5uz2g5QrGYUm7oGZ0oRWWT8aB0nJEgAvZIF+f7zze9+
   YU2H/AAQ+Px75nMID8K/7LzyCV3vmGzeTSXINfJCr2tqlED8KODBK+xFf
   DCstAk1baeyCti3wesl6Av1UHngNM09lkLs3poUe7MW+QlqfFfDiQKSxy
   iuzigE2Q5eqFAKwpis/QAs3Ee5K59KybzPKV/h39Bl9lMpG2TjdRlBufd
   Q==;
X-CSE-ConnectionGUID: JQ9ci/QlTtq259W/Mcvimg==
X-CSE-MsgGUID: /iO1dgKZSzWTNpoSUS3Org==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="31870235"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="31870235"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 12:27:31 -0700
X-CSE-ConnectionGUID: 5tqLculqRhWIYOkGD0AAfg==
X-CSE-MsgGUID: e5MYBkxkTFmsBXVLeIUGNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="76614755"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 10 Oct 2024 12:27:31 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	ak@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: eranian@google.com,
	thomas.falcon@intel.com,
	Kan Liang <kan.liang@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH V2 1/3] perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF
Date: Thu, 10 Oct 2024 12:28:42 -0700
Message-Id: <20241010192844.1006990-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241010192844.1006990-1-kan.liang@linux.intel.com>
References: <20241010192844.1006990-1-kan.liang@linux.intel.com>
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
index 7ca40002a19b..2f3bf3bbbd77 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4886,8 +4886,8 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
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


