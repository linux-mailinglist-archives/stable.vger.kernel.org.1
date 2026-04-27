Return-Path: <stable+bounces-241268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKGPITYn72lE8AAAu9opvQ
	(envelope-from <stable+bounces-241268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:07:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 016FB46F8DF
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77417304BDAA
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4F83845DA;
	Mon, 27 Apr 2026 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEb7rmvO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85359370D4F;
	Mon, 27 Apr 2026 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280418; cv=none; b=Z/iwIho2ayUAm6ETJ4yLoHHWuC8Vn7LGPVAfLYgR85Tt1HaQIOD/Lww00nKbS6FXfqUMQOkgME/MIrFhgtjAHQrxTTxRfTvkGEEjeomyT/7DBthE7iCAkiCJDLNlx2lakTJPSXjUq/KBWsCKKIMNe/UgQiya0qFMPok0y4nr4VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280418; c=relaxed/simple;
	bh=nK1rDZVAfufYW3vFHcgbHqcBeP8uEYPME2B5Cm9dQss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cxv/vhPg6rOpfMzxW/ckBUhERAIFeC67TxmCDzZMLBMl6CwWwrjGvRkoosHCE6TdtBffVF5Z2uidTo40rm2FtMu/Nb/ie5RcVI6yLbdrsTrrqa5nd5VV8GgRZyxUqD1c6kmcO22hYgxU1qOW8nbdaXx7dauTFuej0vavZ4aAS1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEb7rmvO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777280417; x=1808816417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nK1rDZVAfufYW3vFHcgbHqcBeP8uEYPME2B5Cm9dQss=;
  b=TEb7rmvO1a4MlyoIh6HH9W7nMSLCqDHchfs7YhRddQ5IyBQKS/Ya4llj
   MuH7erlnoDwM4oO5jU1M/iCfD6KJdBISBWoNFVpQBvw30B/i5oOuUc1G9
   otUBnnXdeDUpmWKccZu9zQXWDi7vMeyqauesrdZn9mMDEN/ER3XIN/+Wv
   X0CYC68B62IMoLqw/DiiO4OAB3Phe5pV51ISviFlqw0KGYCL6CsI2YjAU
   kOWep7NM0db0geUZR+K3BeqeTKVR3WU+ZZBnEX0ITTBjFDwwXsQLvxY67
   9ioZW6auwXZASzeOnxLpPHE7oytbLWiPW1K9MxfdNdX9K7attA5HkR2zi
   g==;
X-CSE-ConnectionGUID: V1sx/m5xSGen1JuKHHgbOw==
X-CSE-MsgGUID: qNP1ZngNR4iRu4iSqZ8LCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="88476330"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="88476330"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:00:17 -0700
X-CSE-ConnectionGUID: 4lKUi6WyT4qjSv7btlrTZg==
X-CSE-MsgGUID: /LP5uMb3S+qTzyzU+eJTDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="233850599"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 27 Apr 2026 02:00:13 -0700
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
Subject: [Patch v3 1/4] perf/x86/intel: Improve validation and configuration of ACR masks
Date: Mon, 27 Apr 2026 16:55:10 +0800
Message-Id: <20260427085513.3728672-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427085513.3728672-1-dapeng1.mi@linux.intel.com>
References: <20260427085513.3728672-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 016FB46F8DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241268-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]

Currently there are several issues on the user space ACR mask validation
and configuration.
- The validation for user space ACR mask (attr.config2) is incomplete,
  e.g., the ACR mask could include the index which belongs to another
  ACR events group, but it's not validated.
- An early return on an invalid ACR mask caused all subsequent ACR groups
  to be skipped.
- The stale hardware ACR mask (hw.config1) is not cleared before setting
  new hardware ACR mask.

The following changes address all of the above issues.
- Calculate the indices bitmap for each ACR events group. Any bits in
  the user-space mask not present in the group's bitmap are now dropped.
- Instead of an early return on invalid bits, drop only the invalid
  portions and continue iterating through all ACR events to ensure full
  configuration.
- Explicitly clear the stale hardware ACR mask for each event prior to
  writing the new configuration.

Cc: stable@vger.kernel.org
Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

v3: new patch.

 arch/x86/events/intel/core.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4768236c054b..1a2c268018a2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3332,23 +3332,41 @@ static void intel_pmu_enable_event(struct perf_event *event)
 static void intel_pmu_acr_late_setup(struct cpu_hw_events *cpuc)
 {
 	struct perf_event *event, *leader;
-	int i, j, idx;
+	int i, j, k, bit, idx;
+	u64 group_mask;
 
 	for (i = 0; i < cpuc->n_events; i++) {
 		leader = cpuc->event_list[i];
 		if (!is_acr_event_group(leader))
 			continue;
 
-		/* The ACR events must be contiguous. */
+		/* Find the last event of the ACR group. */
 		for (j = i; j < cpuc->n_events; j++) {
 			event = cpuc->event_list[j];
 			if (event->group_leader != leader->group_leader)
 				break;
-			for_each_set_bit(idx, (unsigned long *)&event->attr.config2, X86_PMC_IDX_MAX) {
-				if (i + idx >= cpuc->n_events ||
-				    !is_acr_event_group(cpuc->event_list[i + idx]))
-					return;
-				__set_bit(cpuc->assign[i + idx], (unsigned long *)&event->hw.config1);
+		}
+
+		/* Figure out the group indices bitmap. */
+		group_mask = 0;
+		for (k = i; k < j; k++)
+			group_mask |= BIT_ULL(cpuc->assign[k]);
+
+		/*
+		 * Translate the user-space ACR mask (attr.config2) into the physical
+		 * counter bitmask (hw.config1) for each ACR event in the group.
+		 * NOTE: ACR event contiguity is guaranteed by intel_pmu_hw_config().
+		 */
+		for (k = i; k < j; k++) {
+			event = cpuc->event_list[k];
+			event->hw.config1 = 0;
+			for_each_set_bit(bit, (unsigned long *)&event->attr.config2, X86_PMC_IDX_MAX) {
+				idx = i + bit;
+				if (idx >= cpuc->n_events ||
+				    !(BIT_ULL(cpuc->assign[idx]) & group_mask) ||
+				    !is_acr_event_group(cpuc->event_list[idx]))
+					continue;
+				__set_bit(cpuc->assign[idx], (unsigned long *)&event->hw.config1);
 			}
 		}
 		i = j - 1;
-- 
2.34.1


