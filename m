Return-Path: <stable+bounces-241964-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLk3F+6i8mm3tAEAu9opvQ
	(envelope-from <stable+bounces-241964-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 02:31:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0164B49BC03
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 02:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF2FC3048756
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 00:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2410D1A682F;
	Thu, 30 Apr 2026 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kq7ITEHo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B7119DF62;
	Thu, 30 Apr 2026 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509054; cv=none; b=kniuxv6KWqE/Kro51jaLln5jORPrvexMqZNk/czxHkGaJwcYwSR4LeX6oR/2pEBPK0GGJhFAOhDIVDF5uC56FQsWMu8XSSy6oOpxJFSex21yGpaM1YfDoYh+KEvlj7P7UYeoH+DvVjAeEuo67/P1kM959KJJPBMmYoa3zD+TLxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509054; c=relaxed/simple;
	bh=BB4qWrczuxBdpRMQvOH7NHT8ySrVHIlxNOcUm8gwJN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kesbsRgrme94jYGsh1V2ndWnAhyzP5Bwgq2tITrqHDkz05hA3DU+R8baYfrEdYAYJ8QOJ1HAmkdPA8kn2jly1wWpOW/w24pehTHNPe8c6Dda4dVuJJmpQgv2WvdlNU6gpY3sg7vYFoB8z35LDfvZoNNKgWxIybURS0hRNo7AIrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kq7ITEHo; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777509053; x=1809045053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BB4qWrczuxBdpRMQvOH7NHT8ySrVHIlxNOcUm8gwJN8=;
  b=kq7ITEHoI6u8sHC6fMRPl0hqcdPTEI+D46PlLMuY/ywjJkHHT7K/NQ6o
   UGcmXgMkP6DBP2KZlSfCF2BXBbit20BMjw3oBt4ymLFFJhlnrwAdVsenU
   urew1TEtvLGejIUKjLnHeQoqo4ZjDKOHfHHm3q9Hz1WwA0diu3maKWL5O
   NsvPVYkn/Uv0tNxIW5HdE6erqwKipowKFQC6s9q5kyT81rtFCGV46FiiP
   rwO6mk8IchYURXjfufFBKWOU6r9RppQ46i3Cy3lf78tKx4cSzuxhyDCRz
   RUr3SUd5XEeECr09c0393yhEHeg2EkqxvsfyVjTxLS/s4IWdZywKD6ncn
   g==;
X-CSE-ConnectionGUID: M7meXerLT0eaMcibHrhQXQ==
X-CSE-MsgGUID: COWp+PRgTY6+xumqi6CMTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="95873641"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="95873641"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 17:30:53 -0700
X-CSE-ConnectionGUID: qbM9CZcNQzy0726/hU4Gtg==
X-CSE-MsgGUID: 1pS2YygjRoC0UK/v6P4kcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="234455199"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 29 Apr 2026 17:30:50 -0700
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
Subject: [Patch v4 1/5] perf/x86/intel: Improve validation and configuration of ACR masks
Date: Thu, 30 Apr 2026 08:25:54 +0800
Message-Id: <20260430002558.712334-2-dapeng1.mi@linux.intel.com>
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
X-Rspamd-Queue-Id: 0164B49BC03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241964-lists,stable=lfdr.de];
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
- Figure out the event index group of an ACR group. Any bits in the
  user-space mask not present in the index group are now dropped.
- Instead of an early return on invalid bits, drop only the invalid
  portions and continue iterating through all ACR events to ensure full
  configuration.
- Explicitly clear the stale hardware ACR mask for each event prior to
  writing the new configuration.

Besides, a non-leader event member of ACR group could be disabled in
theory. This could cause bit-shifting errors in the acr_mask of remaining
group members. But since ACR sampling requires all events to be active,
this should not be a big concern in real use case. Add a "FIXME" comment
to notice this risk.

Cc: stable@vger.kernel.org
Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

V4: 1) Simplify ACR group indices validation. 2) Add FIXME to notify the
bit-shifting risk of ACR mask if event numbers of ACR group are diabled.

 arch/x86/events/intel/core.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4768236c054b..ca910e6bfc77 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3332,23 +3332,41 @@ static void intel_pmu_enable_event(struct perf_event *event)
 static void intel_pmu_acr_late_setup(struct cpu_hw_events *cpuc)
 {
 	struct perf_event *event, *leader;
-	int i, j, idx;
+	int i, j, k, bit, idx;
 
+	/*
+	 * FIXME: ACR mask parsing relies on cpuc->event_list[] (active events only).
+	 * Disabling an ACR event causes bit-shifting errors in the acr_mask of
+	 * remaining group members. As ACR sampling requires all events to be active,
+	 * this limitation is acceptable for now. Revisit if independent event toggling
+	 * is required.
+	 */
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
+				/* Event index of ACR group must locate in [i, j). */
+				if (idx >= j || !is_acr_event_group(cpuc->event_list[idx]))
+					continue;
+				__set_bit(cpuc->assign[idx], (unsigned long *)&event->hw.config1);
 			}
 		}
 		i = j - 1;
-- 
2.34.1


