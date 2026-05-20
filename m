Return-Path: <stable+bounces-252165-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKP9MST4DWry4wUAu9opvQ
	(envelope-from <stable+bounces-252165-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:06:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 660465954CF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7BDE3115EE2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932163F4DDB;
	Wed, 20 May 2026 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qSNxxH6N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DCD3FC5B0;
	Wed, 20 May 2026 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299963; cv=none; b=LWz87728bp0/uPemV5AhTIo5kxfKo6bfKTUFh6jjl3/o2wiu6UvjHDnqI1a/2OxUKtp/EO1mBkASNhV4lBVbtNp2LDU00ueZhmaU3LFPerFRa9S43751970zXGm6JJh6KD8Da/V7cPRlx+qopAdBfmReZFEHs42MEZeFKU7EkuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299963; c=relaxed/simple;
	bh=za0EmHhLR8bcr9PiijtAxR0tQg6mdpfCzle9gCJCxbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snuKUtL9f39JbqpthtAqlRYiZ+LHKjEAoTdbSAlHv9k+tpiqVksJfZ64OCsAO+af1D75sdjbvWnn6S99M9YbiZBK+j2vpqHJPPgcNijLmlnF4IrVJYZV2BUv55NqZPfBqsat59HSb1qJHQ+XEUdnnI/J/FvbYT0EyqO3rX5vTdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qSNxxH6N; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC06B1F00893;
	Wed, 20 May 2026 17:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299960;
	bh=t0xrUjCTLn5QA2NA7DL2lhIo3mOrVJIDYIm79fb1wsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qSNxxH6NWuEOAk0XVKZkIxpC8o2N02bF1Ix8Sg+W2DPjY2sG4q9S463zAyExRqTaS
	 jzMSfyFa6WbtroBKUYqAPxqsgultMVcvBuLahyho5q1yQN6Gk2EjWLRM18NN29cO4n
	 qktCpVrR23f6LDR+XwFPGVoDMivlpkia+yqfk0UI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andi Kleen <ak@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 952/957] perf/x86/intel: Disable PMI for self-reloaded ACR events
Date: Wed, 20 May 2026 18:23:55 +0200
Message-ID: <20260520162155.248091762@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252165-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,msgid.link:url,intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 660465954CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/core.c |   17 +++++++++++++----
 arch/x86/events/perf_event.h |   10 ++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2866,11 +2866,11 @@ static void intel_pmu_enable_fixed(struc
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
@@ -2955,6 +2955,15 @@ static void intel_pmu_enable_event(struc
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
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -133,6 +133,16 @@ static inline bool is_acr_event_group(st
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



