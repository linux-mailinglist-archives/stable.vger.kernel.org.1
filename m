Return-Path: <stable+bounces-244089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJF4C9vN+WlHEQMAu9opvQ
	(envelope-from <stable+bounces-244089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:00:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8389D4CC0D2
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 028883068923
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 10:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648593E3C76;
	Tue,  5 May 2026 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TQW63jPm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WZnRzAXp"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684062C030E;
	Tue,  5 May 2026 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978204; cv=none; b=UUuO934VVBh68OhOlWuiP/2OOiYa3slhP4qsCHM1wT6qCVwsMRss2PW3Lqox8rOlI2MiZq7GmgSHsCCSLPhfMhQPRavxee7OzwkI3qskzxqV/XvgYlaOZG3xFh/xU0vihu7qi11fK6ya2lqA5It62pbNO2IBCyPCdfrGppy/fIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978204; c=relaxed/simple;
	bh=jL4ZCsgiBkhKvyV1wAzzq7Pl+yyGDGNghj9zLJHVri0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lXP6Kg1Ru6zxOf9cLeHm/TWC6247M76V7N0rSlSZsJ8rqto3CvU9fC/2VwWDw89eh1f/+pR7HesOMFeEpXwJUJrENu2x2M38JtniYNmOTN1utoDxn+QQmJ5tKHmRvT4cVk/qBCsFsNTmKxaGgFD8p4CTUXYrXGpxXjITyaiit+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TQW63jPm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WZnRzAXp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 05 May 2026 10:49:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777978200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4wu/HyXR9qY3pJeMNR7yN8nZpyOYkKhUXndSbXwF4Y=;
	b=TQW63jPmDMesEeGV2XXcyLe5kh5NCCopkgQd5cAJfpOB5PplszjlMtoIwdvsXWPC/EcWxg
	ofG+63eioihV+BzDpJRmHg6m7MclezDSc0G7lxlPD33UmAeM7s2UHwGPUfDMRyjxj/lXvG
	NCIhPBBXxokXtpyITZAv7vj8VPWYK27Dj7WLruQ8RZ9XPUvXrqNZ0yOTplLvVLvTsHTjGr
	Tgt9P8Cv45whFXjeSDeJ31EKxsyNd0yd3ODS4lAbtuSWarMSEaWhJr8KjEVdUtsIer2fNo
	wXHhWUWSVVOdJI9XBa2CIW5kbVGb+5XYTDTFc7K5Ho5C9GCaALD0JEV6fpo97Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777978200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4wu/HyXR9qY3pJeMNR7yN8nZpyOYkKhUXndSbXwF4Y=;
	b=WZnRzAXpJMY9uOT9IFVCTgiP6NZAj4OrfazAziXmWz8KWLKP1QqUyAGeRvFnQ1j+WecDFb
	0ZsLnWLTM6iccmAw==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel: Disable PMI for self-reloaded ACR events
Cc: Andi Kleen <ak@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260430002558.712334-4-dapeng1.mi@linux.intel.com>
References: <20260430002558.712334-4-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177797819945.424702.9826996078893790451.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8389D4CC0D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244089-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linutronix.de:dkim,vger.kernel.org:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,intel.com:email]

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1271aeccc307066315b2d3b0d5af2510e27018b5
Gitweb:        https://git.kernel.org/tip/1271aeccc307066315b2d3b0d5af2510e27=
018b5
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Thu, 30 Apr 2026 08:25:56 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 May 2026 12:47:21 +02:00

perf/x86/intel: Disable PMI for self-reloaded ACR events

On platforms with Auto Counter Reload (ACR) support, such as NVL, a
"NMI received for unknown reason 30" warning is observed when running
multiple events in a group with ACR enabled:

  $ perf record -e '{instructions/period=3D20000,acr_mask=3D0x2/u,\
    cycles/period=3D40000,acr_mask=3D0x3/u}' ./test

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
Link: https://patch.msgid.link/20260430002558.712334-4-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/core.c | 17 +++++++++++++----
 arch/x86/events/perf_event.h | 10 ++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f8deb67..ead6d95 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3118,11 +3118,11 @@ static void intel_pmu_enable_fixed(struct perf_event =
*event)
 	intel_set_masks(event, idx);
=20
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
 		bits |=3D INTEL_FIXED_0_ENABLE_PMI;
 	if (hwc->config & ARCH_PERFMON_EVENTSEL_USR)
 		bits |=3D INTEL_FIXED_0_USER;
@@ -3306,6 +3306,15 @@ static void intel_pmu_enable_event(struct perf_event *=
event)
 		intel_set_masks(event, idx);
 		static_call_cond(intel_pmu_enable_acr_event)(event);
 		static_call_cond(intel_pmu_enable_event_ext)(event);
+		/*
+		 * For self-reloaded ACR event, don't enable PMI since
+		 * HW won't set overflow bit in GLOBAL_STATUS. Otherwise,
+		 * the PMI would be recognized as a suspicious NMI.
+		 */
+		if (is_acr_self_reload_event(event))
+			hwc->config &=3D ~ARCH_PERFMON_EVENTSEL_INT;
+		else if (!event->attr.precise_ip)
+			hwc->config |=3D ARCH_PERFMON_EVENTSEL_INT;
 		__x86_pmu_enable_event(hwc, enable_mask);
 		break;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fad87d3..524668d 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -137,6 +137,16 @@ static inline bool is_acr_event_group(struct perf_event =
*event)
 	return check_leader_group(event->group_leader, PERF_X86_EVENT_ACR);
 }
=20
+static inline bool is_acr_self_reload_event(struct perf_event *event)
+{
+	struct hw_perf_event *hwc =3D &event->hw;
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

