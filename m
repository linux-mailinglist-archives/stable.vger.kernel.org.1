Return-Path: <stable+bounces-249160-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dPa+MQpqCmp+1AQAu9opvQ
	(envelope-from <stable+bounces-249160-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 03:23:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E419564BB0
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 03:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F958300BD9F
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 01:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E671A9B46;
	Mon, 18 May 2026 01:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPBRra7U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF90171CD
	for <stable@vger.kernel.org>; Mon, 18 May 2026 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779067397; cv=none; b=BLABvvuSnirS/DzwTJnjIHmG2XCSUUr91HsIMz99ho9QV/7CSQyIXFkkX6L6ajG9w6WsY6IaVAWR9Y22+Bvmwql05YgNL9XrXjF4/A86S7lFdGJUm56rZyNB/oJQBPD9QYgbb2PXve644hxrAN6wliZ7R3sAOkufLpgvqWRd5n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779067397; c=relaxed/simple;
	bh=HEr+MmcRGEH1OPNAMTIvomqWSZK+XH5/gTH+b0Ye+ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKNv+BkicfBrxZ+c7JZh3V3Rn2oQEioD2QGIu3rwZAewv3JSVTFLlXh4SR53SkNQ/4cbIzgHDs1dsp9cADeRuEuokgDW8kLRFo9tlXhQ8IywPpg6gnKK0RPmzQ524/9iC4DOJvJ371dMNCvcXxnaTqRrVOl0Vti4et2QSLF3iII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPBRra7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D136EC2BCB0;
	Mon, 18 May 2026 01:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779067397;
	bh=HEr+MmcRGEH1OPNAMTIvomqWSZK+XH5/gTH+b0Ye+ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BPBRra7U9ZlaGKaYNxbEHureBdjg8/8gtwqdS7V3/SDCWuwv0pzeTtncybyhV+wh4
	 SeQzZ78GQoh06UqLHtAbwBNmZtCPuDc5/rD0NbofFU0pJMX95v3m6foW27785y7s+W
	 dvHt+ZW0XIqt5esX8U+ArukNoSHFrxuTIkOMvKUH2YiNmwtImGdY/zRGR+VEQWXpzA
	 QglWtkSw8hW/33ZLroLGyPWLTw+0Ol9N80cCs8W34KJX9SgB0l4rq+waLvd3hOH6Rc
	 dABsgNJZKtWrxFgCSUfMBrM+QJ97VYepKNBFkfHcWrVBOFoRKyoqEwvpEk1UYmcz8c
	 vIR9GOYCtUjVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] perf/x86/intel: Disable PMI for self-reloaded ACR events
Date: Sun, 17 May 2026 21:23:15 -0400
Message-ID: <20260518012315.481330-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051250-afflicted-express-5419@gregkh>
References: <2026051250-afflicted-express-5419@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1E419564BB0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249160-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,infradead.org:email,msgid.link:url]
X-Rspamd-Action: no action

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

[ Upstream commit 1271aeccc307066315b2d3b0d5af2510e27018b5 ]

On platforms with Auto Counter Reload (ACR) support, such as NVL, a
"NMI received for unknown reason 30" warning is observed when running
multiple events in a group with ACR enabled:

  $ perf record -e '{instructions/period=20000,acr_mask=0x2/u,\
    cycles/period=40000,acr_mask=0x3/u}' ./test

The warning occurs because the Performance Monitoring Interrupt (PMI)
is enabled for the self-reloaded event (the cycles event in this case).
According to the Intel SDM, the overflow bit
(IA32_PERF_GLOBAL_STATUS.PMCn_OVF) is never set for self-reloaded events.
Since the bit is not set, the perf NMI handler cannot identify the source
of the interrupt, leading to the "unknown reason" message.

Furthermore, enabling PMI for self-reloaded events is unnecessary and
can lead to extraneous records that pollute the user's requested data.

Disable the interrupt bit for all events configured with ACR self-reload.

Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260430002558.712334-4-dapeng1.mi@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/core.c | 17 +++++++++++++----
 arch/x86/events/perf_event.h | 10 ++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7d8c7eb7838da..7d9f6a58f3f26 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2866,11 +2866,11 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 	intel_set_masks(event, idx);
 
 	/*
-	 * Enable IRQ generation (0x8), if not PEBS,
-	 * and enable ring-3 counting (0x2) and ring-0 counting (0x1)
-	 * if requested:
+	 * Enable IRQ generation (0x8), if not PEBS or self-reloaded
+	 * ACR event, and enable ring-3 counting (0x2) and ring-0
+	 * counting (0x1) if requested:
 	 */
-	if (!event->attr.precise_ip)
+	if (!event->attr.precise_ip && !is_acr_self_reload_event(event))
 		bits |= INTEL_FIXED_0_ENABLE_PMI;
 	if (hwc->config & ARCH_PERFMON_EVENTSEL_USR)
 		bits |= INTEL_FIXED_0_USER;
@@ -2955,6 +2955,15 @@ static void intel_pmu_enable_event(struct perf_event *event)
 			enable_mask |= ARCH_PERFMON_EVENTSEL_BR_CNTR;
 		intel_set_masks(event, idx);
 		static_call_cond(intel_pmu_enable_acr_event)(event);
+		/*
+		 * For self-reloaded ACR event, don't enable PMI since
+		 * HW won't set overflow bit in GLOBAL_STATUS. Otherwise,
+		 * the PMI would be recognized as a suspicious NMI.
+		 */
+		if (is_acr_self_reload_event(event))
+			hwc->config &= ~ARCH_PERFMON_EVENTSEL_INT;
+		else if (!event->attr.precise_ip)
+			hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
 		__x86_pmu_enable_event(hwc, enable_mask);
 		break;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 493e6ba51e06d..2bafb8f0f9077 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -133,6 +133,16 @@ static inline bool is_acr_event_group(struct perf_event *event)
 	return check_leader_group(event->group_leader, PERF_X86_EVENT_ACR);
 }
 
+static inline bool is_acr_self_reload_event(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (hwc->idx < 0)
+		return false;
+
+	return test_bit(hwc->idx, (unsigned long *)&hwc->config1);
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
-- 
2.53.0


