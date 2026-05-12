Return-Path: <stable+bounces-246243-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG/yCNltA2pS5wEAu9opvQ
	(envelope-from <stable+bounces-246243-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:13:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B69E75270F3
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74B6030046B1
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7CA3EDE62;
	Tue, 12 May 2026 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KFJtrN7B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30383EDE41;
	Tue, 12 May 2026 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608726; cv=none; b=eMWy2SD9DjfJwAOIg9sFjPAArsklAI+9hgetxlxFtPDJMs0nz/waP3BFzfIfCvlm6Rtn3fm8FQ0GP3KeRrdayIMQI25K5ezj+xyE8gCXvoYJHam39VxXCKoM3VLlCuO18kjomQ1MFV0dQ57A+8AM5FeB4OtnOz/X9TtNZFbFl3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608726; c=relaxed/simple;
	bh=oIkj7PieIMqmHyTJ0S3itbH77NiCZ6cO4X/lKgv0PLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVfmd9CXAONtsftPjhEEdJ5sYnIBPOwf3UGOF6fYybR6WAl3lZ6tqYCkdv5gMfdFdpF99bOxVVbD1XdZx+m7hqE4Pw063jNQEsF/a4GFVHqpkH1azCgBf8ufgj4o8/SClVV2jUyf4rE9INK/AeMZx9BlZZ+dWL3+a1G7y6VStxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KFJtrN7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A806C2BCB0;
	Tue, 12 May 2026 17:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608726;
	bh=oIkj7PieIMqmHyTJ0S3itbH77NiCZ6cO4X/lKgv0PLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KFJtrN7BAaH5QYTWK8yha59jSFSgh626PVxjWoHIzS472Pah1IA1+SUyCldE+ZXwn
	 nyIy+kKEBoAVX22p94v0qPdNM24Oc1Reb0t3+hqnYZwcJUP3+s3rbcczZtneCRoFrs
	 SGDJ8TwYkwmKQusjHZL2VAZqKgNpN7s47fPaR0ko=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 6.18 191/270] perf/x86/intel: Always reprogram ACR events to prevent stale masks
Date: Tue, 12 May 2026 19:39:52 +0200
Message-ID: <20260512173942.470016199@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: B69E75270F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246243-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,infradead.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

commit 8ba0b706a485b1e607594cf4210786d517ad1611 upstream.

Members of an ACR group are logically linked via a bitmask of their
hardware counter indices. If some members of the group are assigned new
hardware counters during rescheduling, even events that keep their
original counter index must be updated with a new mask.

Without this, an event will continue to use a stale acr_mask that
references the old indices of its group peers. Ensure all ACR events are
reprogrammed during the scheduling path to maintain consistency across
the group.

Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260430002558.712334-3-dapeng1.mi@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/core.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1281,13 +1281,16 @@ int x86_perf_rdpmc_index(struct perf_eve
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
@@ -1333,7 +1336,7 @@ static void x86_pmu_enable(struct pmu *p
 			 * - no other event has used the counter since
 			 */
 			if (hwc->idx == -1 ||
-			    match_prev_assignment(hwc, cpuc, i))
+			    match_prev_assignment(event, cpuc, i))
 				continue;
 
 			/*
@@ -1354,7 +1357,7 @@ static void x86_pmu_enable(struct pmu *p
 			event = cpuc->event_list[i];
 			hwc = &event->hw;
 
-			if (!match_prev_assignment(hwc, cpuc, i))
+			if (!match_prev_assignment(event, cpuc, i))
 				x86_assign_hw_event(event, cpuc, i);
 			else if (i < n_running)
 				continue;



