Return-Path: <stable+bounces-244090-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NbQHmDO+WlHEQMAu9opvQ
	(envelope-from <stable+bounces-244090-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:02:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E792F4CC196
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B7C130E8999
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 10:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D12F40FD93;
	Tue,  5 May 2026 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kXdnXspz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="06Q3+NLD"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F983E6397;
	Tue,  5 May 2026 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978206; cv=none; b=PR8A7ecjeWjyPz6VQcyLefOvdvTuqr3X8Yz0k1nrbVK08W7l+XICNnZZsxanES5X7biiuW4wUQk/DOpexoV23UNMuqu/9aGlue6VizfqjZEBhWJSdnHFOHUngco/HMMyWf+QYUCeRXMWU1ydOkU8rZbd6h5HhyvTfgr4mD9r3n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978206; c=relaxed/simple;
	bh=mKv3TWFQLbl/kYlBK08fj3usfid6jF3fmoybZ47Re2c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oOgbN8jGFvBJHV5ZvkWdoC1RzEUNlcESr8cDwrGWjSv2NXKrLmiVI5j8zLOE/RzDjhe0QQ3mmETSPz+dxCV1bIocJnT2atz8jaqC5mVDZz9E30Ax3/sqwp+d4nUE1v433lpEAwVEiHNGuMxIjZaqPq2J0C3VS79TW3wMGFlsvUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kXdnXspz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=06Q3+NLD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 05 May 2026 10:50:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777978202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ewhGIahKK4xtdT/4fDDoT2JDYy1CUjHKz9NCsJsqiZ4=;
	b=kXdnXspziBhF6UWB/uQ4eNxkAMUY+lBCbRslnuT3CCFMo3JigjqBuV+ehCda/jcBovBd6S
	FRxuJbHwVUNH1RoBON1eezrGn4drtvwbMu6Ku/exlBhQUsvW9eRF8BhzS2/QU/zNLQUCzG
	xoH1knuDNFCpQnC8RAYFRvnO1QvF1xBKo3ri6WkYHqO51ziH4BQIBjXVbfvvisJiZoDJqz
	XFKKPnnH2AKvTK9QI0l0hvd1oO0CXaEJXn3DUWDlpueYjVX63H3IsWm1zWzQ1w6xJPS/2T
	wCNoeEsgJ5V1qwKuSYzbU9Z1fMJdTHMOHVCNMKAoL+544oXFuB6QIFFSoV7ILA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777978202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ewhGIahKK4xtdT/4fDDoT2JDYy1CUjHKz9NCsJsqiZ4=;
	b=06Q3+NLDFZpTMYbv7QNMkfiJkyKE/BQRqRKOahnb+w8d6+HkjO7BSCkq0L3SIcrsFiULPb
	SNc2cr1x2+wqBECA==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Always reprogram ACR events to
 prevent stale masks
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260430002558.712334-3-dapeng1.mi@linux.intel.com>
References: <20260430002558.712334-3-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177797820071.424702.6693023256397751621.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E792F4CC196
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244090-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,vger.kernel.org:replyto,linutronix.de:dkim,infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8ba0b706a485b1e607594cf4210786d517ad1611
Gitweb:        https://git.kernel.org/tip/8ba0b706a485b1e607594cf4210786d517a=
d1611
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Thu, 30 Apr 2026 08:25:55 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 May 2026 12:47:21 +02:00

perf/x86/intel: Always reprogram ACR events to prevent stale masks

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
Link: https://patch.msgid.link/20260430002558.712334-3-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 810ab21..4b9e105 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1294,13 +1294,16 @@ int x86_perf_rdpmc_index(struct perf_event *event)
 	return event->hw.event_base_rdpmc;
 }
=20
-static inline int match_prev_assignment(struct hw_perf_event *hwc,
+static inline int match_prev_assignment(struct perf_event *event,
 					struct cpu_hw_events *cpuc,
 					int i)
 {
+	struct hw_perf_event *hwc =3D &event->hw;
+
 	return hwc->idx =3D=3D cpuc->assign[i] &&
-		hwc->last_cpu =3D=3D smp_processor_id() &&
-		hwc->last_tag =3D=3D cpuc->tags[i];
+	       hwc->last_cpu =3D=3D smp_processor_id() &&
+	       hwc->last_tag =3D=3D cpuc->tags[i] &&
+	       !is_acr_event_group(event);
 }
=20
 static void x86_pmu_start(struct perf_event *event, int flags);
@@ -1346,7 +1349,7 @@ static void x86_pmu_enable(struct pmu *pmu)
 			 * - no other event has used the counter since
 			 */
 			if (hwc->idx =3D=3D -1 ||
-			    match_prev_assignment(hwc, cpuc, i))
+			    match_prev_assignment(event, cpuc, i))
 				continue;
=20
 			/*
@@ -1367,7 +1370,7 @@ static void x86_pmu_enable(struct pmu *pmu)
 			event =3D cpuc->event_list[i];
 			hwc =3D &event->hw;
=20
-			if (!match_prev_assignment(hwc, cpuc, i))
+			if (!match_prev_assignment(event, cpuc, i))
 				x86_assign_hw_event(event, cpuc, i);
 			else if (i < n_running)
 				continue;

