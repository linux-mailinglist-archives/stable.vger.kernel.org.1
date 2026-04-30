Return-Path: <stable+bounces-241965-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDQPFRCj8mm3tAEAu9opvQ
	(envelope-from <stable+bounces-241965-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 02:32:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A510349BC11
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 02:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82E34305A250
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 00:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BB31C860A;
	Thu, 30 Apr 2026 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fsgOtMxF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1368E15B0EC;
	Thu, 30 Apr 2026 00:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509058; cv=none; b=rzTKTVgIBWPhyYUm07F/JqsEMha46EvYsMXCziZo8Otd8fDGHajE9U8rzm7ivWIkGjij+CXlAVcytUJ2o+R7zvEYDRooPx1elDNG08Il5Nl/VopzOS1rSb7+hIYGTODtUEy+TzvzA1nk/dwHcx691CIXyUa8/+1nOOp6hVlQljw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509058; c=relaxed/simple;
	bh=PtMBhBKt++ceNCnar5o1TitSiDffAtnjds9cTNPiE/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZI+1Ef5FKb7GxPkc8Gx+al1mNm2d4cyCsjQSL9r+zffdkzsOLzcpl8J03NmONOPBR5ks2eK+QRKIWhqXTItevcKi3UQXzcj7hxZDTsykn6ueUtpp3SpHkhe6vy8vYgMFQN5xR7+jCNtW6NLXjJLtICNOgCy5xYlcGzi+qEADA+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fsgOtMxF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777509057; x=1809045057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PtMBhBKt++ceNCnar5o1TitSiDffAtnjds9cTNPiE/o=;
  b=fsgOtMxF1xI68Gigvua5I9oBwC5FN6CQNId4W98fwqOjnjr5DEXOww5x
   wInT+TbtboZWyhn1hF85OQLGsT2HIC1BV5gGjvpNTQXZzSyGa0TnvhX7w
   lisZ546ua+PpvL1gqLeHHeFtfGvEA94fsRBQCUAQlfCP2HWxstMEGg4O1
   0zlQEEoh73UJf+vvAty/6hhamEY+62QgG1i3wZcRi5keFhtFQUZNc7xqU
   SUnbf+sY5Ft61wvOBP6GbodPplIeykloAdZduok/aGXXt83k4iHtx9asc
   YY/9Ulj3GDifSs6jkALcMLxDwq6w7Uuf62liHXagEV3BmS/tY+P2RZT9X
   w==;
X-CSE-ConnectionGUID: pMI88eDeTZaYazxjzhzW6w==
X-CSE-MsgGUID: B9ltQ2tXQ0GYInXmaUvCYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="95873652"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="95873652"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 17:30:57 -0700
X-CSE-ConnectionGUID: WQvW9QkoQ3OxKQT9ryemvA==
X-CSE-MsgGUID: hGqHobNFQbqfm5RceBoMHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="234455202"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 29 Apr 2026 17:30:54 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	stable@vger.kernel.org
Subject: [Patch v4 2/5] perf/x86/intel: Always reprogram ACR events to prevent stale masks
Date: Thu, 30 Apr 2026 08:25:55 +0800
Message-Id: <20260430002558.712334-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430002558.712334-1-dapeng1.mi@linux.intel.com>
References: <20260430002558.712334-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A510349BC11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241965-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,linux.intel.com:mid]

Members of an ACR group are logically linked via a bitmask of their
hardware counter indices. If some members of the group are assigned new
hardware counters during rescheduling, even events that keep their
original counter index must be updated with a new mask.

Without this, an event will continue to use a stale acr_mask that
references the old indices of its group peers. Ensure all ACR events are
reprogrammed during the scheduling path to maintain consistency across
the group.

Cc: stable@vger.kernel.org
Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

V4: new patch.

 arch/x86/events/core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 03ce1bc7ef2e..e766621f9449 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1294,13 +1294,16 @@ int x86_perf_rdpmc_index(struct perf_event *event)
 	return event->hw.event_base_rdpmc;
 }
 
-static inline int match_prev_assignment(struct hw_perf_event *hwc,
+static inline int match_prev_assignment(struct perf_event *event,
 					struct cpu_hw_events *cpuc,
 					int i)
 {
+	struct hw_perf_event *hwc = &event->hw;
+
 	return hwc->idx == cpuc->assign[i] &&
-		hwc->last_cpu == smp_processor_id() &&
-		hwc->last_tag == cpuc->tags[i];
+	       hwc->last_cpu == smp_processor_id() &&
+	       hwc->last_tag == cpuc->tags[i] &&
+	       !is_acr_event_group(event);
 }
 
 static void x86_pmu_start(struct perf_event *event, int flags);
@@ -1346,7 +1349,7 @@ static void x86_pmu_enable(struct pmu *pmu)
 			 * - no other event has used the counter since
 			 */
 			if (hwc->idx == -1 ||
-			    match_prev_assignment(hwc, cpuc, i))
+			    match_prev_assignment(event, cpuc, i))
 				continue;
 
 			/*
@@ -1367,7 +1370,7 @@ static void x86_pmu_enable(struct pmu *pmu)
 			event = cpuc->event_list[i];
 			hwc = &event->hw;
 
-			if (!match_prev_assignment(hwc, cpuc, i))
+			if (!match_prev_assignment(event, cpuc, i))
 				x86_assign_hw_event(event, cpuc, i);
 			else if (i < n_running)
 				continue;
-- 
2.34.1


