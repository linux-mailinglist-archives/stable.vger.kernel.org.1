Return-Path: <stable+bounces-136592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCA8A9AF9B
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 15:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329DD9A4456
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 13:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E26B18E34A;
	Thu, 24 Apr 2025 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQqSZRys"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0870158858;
	Thu, 24 Apr 2025 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502467; cv=none; b=OwPRw6bINabIPSTLRfqrHB1GHltPSOUFARdnBbhbBELDFXmrYZUujmNMWr3I6YZdboezEXrBA+Dqw21Ts8VHxe6fV9eLufDJ3n4raDfE3P03I4G7suiYfjqkrLW4CfD1kfcgaaNQWGYnarjmK5WWRh1eV5sAkIVSd0bG5mUBjDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502467; c=relaxed/simple;
	bh=ZPdaq82mG+JRpwl8l1yKHK/Uc2NMfolvwuRLY9459r8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DXHndqCd1wRVkKwJ3AM3qjfthnj2otNPdIBh8p3u0q9zMwSz+jC8S+/YQ5CiSkyXyY92CCnh+qR2pmGQoaXEsz63tzha65dYBbzjDjsK0lLzCQlYi3tWji+m+f5L1Y/DoubJqYdi+ENt0ZlTMxxJ5WZTqnXegjAxX3NMwypTiOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQqSZRys; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745502466; x=1777038466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZPdaq82mG+JRpwl8l1yKHK/Uc2NMfolvwuRLY9459r8=;
  b=cQqSZRysIUliate2XS55Ea0zlQy4OM33WoiwFLHMpflUEweUawcrMDSZ
   TAOv6KqTzLmIK7G5zrUt5wbhc5VdEStWMPTJUQ0m9EMjCapqfzk8DlbFf
   zN59+q9N+nGu8AWGtc0LQQjas9TJjeRVvaE6tdr2n0Qt0MmCK9tHzUCY9
   Zte8x+SOSmbl+xmM/r78fJrjTL2c2L0vOel/fNdIBUWXDK7hZbf0cu/xx
   R7nGFuSRsCLvR4MNegiLCmck3z3xUbNeGnd76i5ZvTg8I3c+wx1ZyRI1j
   M/wP10ZAIvFlm3huZBy2gH43hTJOtBX62d38rb/dvpJPtLTi74JrY5cvY
   A==;
X-CSE-ConnectionGUID: pulsRbC4QQyZLPACZcqicw==
X-CSE-MsgGUID: vChKJFoFR+u0GYOL9q3oAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="58508196"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="58508196"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 06:47:44 -0700
X-CSE-ConnectionGUID: B3bl+cM3SfCd8QF0CBMMlQ==
X-CSE-MsgGUID: +/T9vHjtQbKiDTGombv6NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="137718958"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa004.fm.intel.com with ESMTP; 24 Apr 2025 06:47:44 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Luo Gengkun <luogengkun@huaweicloud.com>,
	stable@vger.kernel.org
Subject: [PATCH V2 1/5] perf/x86/intel: Only check the group flag for X86 leader
Date: Thu, 24 Apr 2025 06:47:14 -0700
Message-Id: <20250424134718.311934-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250424134718.311934-1-kan.liang@linux.intel.com>
References: <20250424134718.311934-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

A warning in intel_pmu_lbr_counters_reorder() may be triggered by below
perf command.

perf record -e "{cpu-clock,cycles/call-graph="lbr"/}" -- sleep 1

It's because the group is mistakenly treated as a branch counter group.

The hw.flags of the leader are used to determine whether a group is a
branch counters group. However, the hw.flags is only available for a
hardware event. The field to store the flags is a union type. For a
software event, it's a hrtimer. The corresponding bit may be set if the
leader is a software event.

For a branch counter group and other groups that have a group flag
(e.g., topdown, PEBS counters snapshotting, and ACR), the leader must
be a X86 event. Check the X86 event before checking the flag.
The patch only fixes the issue for the branch counter group.
The following patch will fix the other groups.

There may be an alternative way to fix the issue by moving the hw.flags
out of the union type. It should work for now. But it's still possible
that the flags will be used by other types of events later. As long as
that type of event is used as a leader, a similar issue will be
triggered. So the alternative way is dropped.

Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
Reported-by: Luo Gengkun <luogengkun@huaweicloud.com>
Closes: https://lore.kernel.org/lkml/20250412091423.1839809-1-luogengkun@huaweicloud.com/
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/perf_event.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 902bc42a6cfe..4fc61a09c30e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -110,9 +110,16 @@ static inline bool is_topdown_event(struct perf_event *event)
 	return is_metric_event(event) || is_slots_event(event);
 }
 
+int is_x86_event(struct perf_event *event);
+
+static inline bool check_leader_group(struct perf_event *leader, int flags)
+{
+	return is_x86_event(leader) ? !!(leader->hw.flags & flags) : false;
+}
+
 static inline bool is_branch_counters_group(struct perf_event *event)
 {
-	return event->group_leader->hw.flags & PERF_X86_EVENT_BRANCH_COUNTERS;
+	return check_leader_group(event->group_leader, PERF_X86_EVENT_PEBS_CNTR);
 }
 
 static inline bool is_pebs_counter_event_group(struct perf_event *event)
@@ -1129,7 +1136,6 @@ static struct perf_pmu_format_hybrid_attr format_attr_hybrid_##_name = {\
 	.pmu_type	= _pmu,						\
 }
 
-int is_x86_event(struct perf_event *event);
 struct pmu *x86_get_pmu(unsigned int cpu);
 extern struct x86_pmu x86_pmu __read_mostly;
 
-- 
2.38.1


