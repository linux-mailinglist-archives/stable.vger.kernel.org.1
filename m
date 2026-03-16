Return-Path: <stable+bounces-225517-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLX7E0rXt2kwWAEAu9opvQ
	(envelope-from <stable+bounces-225517-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 11:11:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4C6297B6D
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 11:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C382305DBA1
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 09:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8763F38F929;
	Mon, 16 Mar 2026 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YwNRWgE/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dMp/EiHn"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57C038F243;
	Mon, 16 Mar 2026 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654636; cv=none; b=qUW8LkkhkhBA7pUifKr8M2cAxzlpO1GThY1CUKIMU2TYShwjmpEvdo/mcLVmmLhdlSOorgy9Xpgb7DTogvEdvDqIqQ866wVaJn4oTq/OJ811x2iqIJXr3rKuGb3ChIsAD+YviT3HPfgLVSh+/u1P3yeQeKrtmpx0Ok77y7fTky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654636; c=relaxed/simple;
	bh=p7nVWPFp4Z48QNFqM9rbPvtzhjEwdzD/1sVpTOz33rU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aU0G6/Ne3u7rfgG7TSNydUN4xSTdt6wiGdw6Mhw8HdjKsGQ1tv4B9tZSzUmqHWHcJPkklHTXxQJNbr7S3Un+5b2Y6RrPMyIhF2yG15ogTJpctORMzPF7Mz8W9cFQyl6cbpNRcEk2BZFCCAGrUxlp7Lunthan9dtwv+ECCx2nCbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YwNRWgE/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dMp/EiHn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 16 Mar 2026 09:50:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773654633;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnRXhtFPSWWERwIqnukzBbn5E9sRMdx2jBq9UjforRI=;
	b=YwNRWgE/1hwmTuUUJ1DunBb1UZyXKNNvvkGoM+CKC7shrRE8tv2e4FsiqU8ENbaYvlXlCR
	6FDs7Bv6eYuzmaDIvcLzwpOBFsLm3GZvW9zRpLrEXD4OzkQiO6SiDVmcMVH8b/M+PvuYIM
	a4F7XFnW2iUKQK4BEaXxVqnH5MbvJ2El3KFrRlnHwMlee4Ro6xDlxGmx4nP9sxpJayjzLk
	tU9WFC60wFxjZl3F10POu6PUuxZhYSPZUoaP05vTEILyvj7kX2qzFiKDHys+XX9uhSeADb
	gBq8l1S0uRPdBqjPAbf/BV+X/0Gp87gRj93lrNbCJmvOCMSj7z4jEh88n8BfEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773654633;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnRXhtFPSWWERwIqnukzBbn5E9sRMdx2jBq9UjforRI=;
	b=dMp/EiHnCHBbJvgZ+cw5VZdWy3bkvDSAdufSoadhlpkv5hzpQ3etdzkdx+l7Dyke1aifOg
	tpCynrsuZx30gfAg==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86: Move event pointer setup earlier in
 x86_pmu_enable()
Cc: Breno Leitao <leitao@debian.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260310-perf-v2-1-4a3156fce43c@debian.org>
References: <20260310-perf-v2-1-4a3156fce43c@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177365463204.1647592.7251376530763980341.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225517-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:replyto,infradead.org:email,msgid.link:url];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 4D4C6297B6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     8d5fae6011260de209aaf231120e8146b14bc8e0
Gitweb:        https://git.kernel.org/tip/8d5fae6011260de209aaf231120e8146b14=
bc8e0
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Tue, 10 Mar 2026 03:13:16 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 12 Mar 2026 11:29:15 +01:00

perf/x86: Move event pointer setup earlier in x86_pmu_enable()

A production AMD EPYC system crashed with a NULL pointer dereference
in the PMU NMI handler:

  BUG: kernel NULL pointer dereference, address: 0000000000000198
  RIP: x86_perf_event_update+0xc/0xa0
  Call Trace:
   <NMI>
   amd_pmu_v2_handle_irq+0x1a6/0x390
   perf_event_nmi_handler+0x24/0x40

The faulting instruction is `cmpq $0x0, 0x198(%rdi)` with RDI=3D0,
corresponding to the `if (unlikely(!hwc->event_base))` check in
x86_perf_event_update() where hwc =3D &event->hw and event is NULL.

drgn inspection of the vmcore on CPU 106 showed a mismatch between
cpuc->active_mask and cpuc->events[]:

  active_mask: 0x1e (bits 1, 2, 3, 4)
  events[1]:   0xff1100136cbd4f38  (valid)
  events[2]:   0x0                 (NULL, but active_mask bit 2 set)
  events[3]:   0xff1100076fd2cf38  (valid)
  events[4]:   0xff1100079e990a90  (valid)

The event that should occupy events[2] was found in event_list[2]
with hw.idx=3D2 and hw.state=3D0x0, confirming x86_pmu_start() had run
(which clears hw.state and sets active_mask) but events[2] was
never populated.

Another event (event_list[0]) had hw.state=3D0x7 (STOPPED|UPTODATE|ARCH),
showing it was stopped when the PMU rescheduled events, confirming the
throttle-then-reschedule sequence occurred.

The root cause is commit 7e772a93eb61 ("perf/x86: Fix NULL event access
and potential PEBS record loss") which moved the cpuc->events[idx]
assignment out of x86_pmu_start() and into step 2 of x86_pmu_enable(),
after the PERF_HES_ARCH check. This broke any path that calls
pmu->start() without going through x86_pmu_enable() -- specifically
the unthrottle path:

  perf_adjust_freq_unthr_events()
    -> perf_event_unthrottle_group()
      -> perf_event_unthrottle()
        -> event->pmu->start(event, 0)
          -> x86_pmu_start()     // sets active_mask but not events[]

The race sequence is:

  1. A group of perf events overflows, triggering group throttle via
     perf_event_throttle_group(). All events are stopped: active_mask
     bits cleared, events[] preserved (x86_pmu_stop no longer clears
     events[] after commit 7e772a93eb61).

  2. While still throttled (PERF_HES_STOPPED), x86_pmu_enable() runs
     due to other scheduling activity. Stopped events that need to
     move counters get PERF_HES_ARCH set and events[old_idx] cleared.
     In step 2 of x86_pmu_enable(), PERF_HES_ARCH causes these events
     to be skipped -- events[new_idx] is never set.

  3. The timer tick unthrottles the group via pmu->start(). Since
     commit 7e772a93eb61 removed the events[] assignment from
     x86_pmu_start(), active_mask[new_idx] is set but events[new_idx]
     remains NULL.

  4. A PMC overflow NMI fires. The handler iterates active counters,
     finds active_mask[2] set, reads events[2] which is NULL, and
     crashes dereferencing it.

Move the cpuc->events[hwc->idx] assignment in x86_pmu_enable() to
before the PERF_HES_ARCH check, so that events[] is populated even
for events that are not immediately started. This ensures the
unthrottle path via pmu->start() always finds a valid event pointer.

Fixes: 7e772a93eb61 ("perf/x86: Fix NULL event access and potential PEBS reco=
rd loss")
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260310-perf-v2-1-4a3156fce43c@debian.org
---
 arch/x86/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 03ce1bc..54b4c31 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1372,6 +1372,8 @@ static void x86_pmu_enable(struct pmu *pmu)
 			else if (i < n_running)
 				continue;
=20
+			cpuc->events[hwc->idx] =3D event;
+
 			if (hwc->state & PERF_HES_ARCH)
 				continue;
=20
@@ -1379,7 +1381,6 @@ static void x86_pmu_enable(struct pmu *pmu)
 			 * if cpuc->enabled =3D 0, then no wrmsr as
 			 * per x86_pmu_enable_event()
 			 */
-			cpuc->events[hwc->idx] =3D event;
 			x86_pmu_start(event, PERF_EF_RELOAD);
 		}
 		cpuc->n_added =3D 0;

