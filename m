Return-Path: <stable+bounces-244091-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONeSAxTO+WlHEQMAu9opvQ
	(envelope-from <stable+bounces-244091-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:01:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 641C14CC123
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD05530EAC78
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 10:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA1C30F934;
	Tue,  5 May 2026 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O1OgpMRg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CyRwaoRB"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272A382396;
	Tue,  5 May 2026 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978207; cv=none; b=qUl/F0vFcCe9GkM1arfgrdtT/CgSquABmIvqmrNwBmJJuYVL7qgUvY5z1oRk2LmkGP6nPRS4cwmPqGGa1Av/mALlyeCy7KBWMxnPUhbDsXZFb+yxGJrYhjQeLPXtkOOYbz5PhkokT7u8x8xg2Ss8nN7eyGcbDo4djYAj814YhV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978207; c=relaxed/simple;
	bh=qmQWSz+C6O381UFkQUD0qh4pgE7zvnXE0lV/jliDKYw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nhij+Lp7zJ12Ha+ZIqhvjCBUjtK/2DKDB78UtLUXcBVm5IlvnELwvMHxiEoJdv9L5uxwY73lyhAtTe/h8TWkoR0KpQ96DiLjNNy34YChsrFVrjkk1PbOgTpyYq0wiFk0YpWz6bv28NKV507Rr3Du0nT4KIwtq9R4eNnICaava3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O1OgpMRg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CyRwaoRB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 05 May 2026 10:50:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777978203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9N4IVYeu/sFornV8YPJq8xRry6/MqBINjaOfAveXmvw=;
	b=O1OgpMRgACa9klFWl9MEPMvizbhi7GjN0oiZFIAgeHhbOGD02BA872BzhJozmVlODs32dQ
	a1C7+kbvfgPOZSwuiYrEqNqdbCrZeeUsC9gHPf4t+0MApLe8R6YIAAms63qSZXp6xx0akr
	BQ9spxfJxn01GWX8bDUxXI8+mxoQfrajhczEVGEOkKkUqs6J5BM//vBfWZ1+5xAsSeoHT1
	g4RIpHV15lhiQj9Km2jk0jf10FlqwwzMT8Ji0KjyI+zVOgSAGnNTw2KHs90KvjfpWo248t
	C02/n/A8vGt2Xh8nGyEZ31wU9eyKrauVD6N7GA8C8m9bNFJOys3PQ22qn2KUtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777978203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9N4IVYeu/sFornV8YPJq8xRry6/MqBINjaOfAveXmvw=;
	b=CyRwaoRBA9l8VSywgx20qyoNEbPdgA3JrwViXU4pkn91bfu1UkVpyEkAvoG8sHocEi9PJE
	IkDcWNz+BrfsRIAA==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Improve validation and configuration
 of ACR masks
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260430002558.712334-2-dapeng1.mi@linux.intel.com>
References: <20260430002558.712334-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177797820197.424702.12499957309052876582.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 641C14CC123
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244091-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:replyto,infradead.org:email,intel.com:email];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5ad732a56be46aabf158c16aa0c095291727aaef
Gitweb:        https://git.kernel.org/tip/5ad732a56be46aabf158c16aa0c09529172=
7aaef
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Thu, 30 Apr 2026 08:25:54 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 May 2026 12:47:21 +02:00

perf/x86/intel: Improve validation and configuration of ACR masks

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

Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260430002558.712334-2-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/core.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d9488ad..f8deb67 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3332,23 +3332,41 @@ static void intel_pmu_enable_event(struct perf_event =
*event)
 static void intel_pmu_acr_late_setup(struct cpu_hw_events *cpuc)
 {
 	struct perf_event *event, *leader;
-	int i, j, idx;
+	int i, j, k, bit, idx;
=20
+	/*
+	 * FIXME: ACR mask parsing relies on cpuc->event_list[] (active events only=
).
+	 * Disabling an ACR event causes bit-shifting errors in the acr_mask of
+	 * remaining group members. As ACR sampling requires all events to be activ=
e,
+	 * this limitation is acceptable for now. Revisit if independent event togg=
ling
+	 * is required.
+	 */
 	for (i =3D 0; i < cpuc->n_events; i++) {
 		leader =3D cpuc->event_list[i];
 		if (!is_acr_event_group(leader))
 			continue;
=20
-		/* The ACR events must be contiguous. */
+		/* Find the last event of the ACR group. */
 		for (j =3D i; j < cpuc->n_events; j++) {
 			event =3D cpuc->event_list[j];
 			if (event->group_leader !=3D leader->group_leader)
 				break;
-			for_each_set_bit(idx, (unsigned long *)&event->attr.config2, X86_PMC_IDX_=
MAX) {
-				if (i + idx >=3D cpuc->n_events ||
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
+		for (k =3D i; k < j; k++) {
+			event =3D cpuc->event_list[k];
+			event->hw.config1 =3D 0;
+			for_each_set_bit(bit, (unsigned long *)&event->attr.config2, X86_PMC_IDX_=
MAX) {
+				idx =3D i + bit;
+				/* Event index of ACR group must locate in [i, j). */
+				if (idx >=3D j || !is_acr_event_group(cpuc->event_list[idx]))
+					continue;
+				__set_bit(cpuc->assign[idx], (unsigned long *)&event->hw.config1);
 			}
 		}
 		i =3D j - 1;

