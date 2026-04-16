Return-Path: <stable+bounces-238357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kM+9I+w34WlFqgAAu9opvQ
	(envelope-from <stable+bounces-238357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 21:26:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DD5414145
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 21:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3459A3061D43
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 19:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC779361DC3;
	Thu, 16 Apr 2026 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QMy+wlff";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="56ktT4Mc"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A2B33555B;
	Thu, 16 Apr 2026 19:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367591; cv=none; b=tVQtIXPv39PCPIEHJaFi3MbQZW52rKw79CdSATTZe6aoEwZ5peL+9Eu2PkHSVnS1J3TLYqf9pixddx2CKBzGBu4xFnHNZXq1we0oVWc2Z+w9JiG65IeV9TKkl6TFn0B1xqsOLPTRiLfxw8t9lqtG2wv02MmmBB1NjXvm6vv8s54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367591; c=relaxed/simple;
	bh=MuQ51iGuZRvKAG0wnLwTSgekS0afYosmFXrtKRFkiac=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JxA+Q9BxGmuhBimMImz6Y7gptGOayvzZapsd/hcE9OW84VSR27Ix+LpxXH7GSt7PXca7jYwJnFCc+jf9A5omZ3AYFAOI+TapzTK7i0kdMLanxkEjlVPMq+AgkJN4aId5KQxwsLcZpk7J0UyUHZD+s92sqcgjND/RlEm05nd+GDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QMy+wlff; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=56ktT4Mc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Apr 2026 19:26:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776367584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XrxID4KIjy8dV3KsNfI0vInPh+pqQ/GI874DnBu6QKc=;
	b=QMy+wlff+KG5QOwf0p+NEcV4sIujBxZJRJFS5m2sJODI+m2szy3IvrzxQjL26gZiF02SzK
	5btGOiUKKJ3u4EID1HD9busVTeF+1Ktn1Vks+3P4Jy7t4i72L0qBMQxqHJnbi39ve1xzy3
	SN2ygbQTHETwzsEB61e2NzU7VWkpMWldTB4R3Qehdo4gIreVniZ2/xJvNhyWzP/3KGmQ/L
	RjUOnTfWg8xtCH1JnIRIc6SH86E6xIxCA5m2poOe4eBiok2/Myr8d4pqwCVlJuKcgh8q7i
	8gEQP1TDb3Z4ClwfyCleq+svMvBboy8VxDslO74jT5a6ZduJ+agF3pR4nCHlPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776367584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XrxID4KIjy8dV3KsNfI0vInPh+pqQ/GI874DnBu6QKc=;
	b=56ktT4McBpID8NzX86ZEaDUhHny/CYad3CfM2hxJ5KpPomwd6XzNNDmP2WOPdv6zJkyt5h
	G2xQIUQFPAj8SMDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clockevents: Add missing resets of the
 next_event_forced flag
Cc: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>,
 Eric Naim <dnaim@cachyos.org>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87340xfeje.ffs@tglx>
References: <87340xfeje.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177636758252.1323100.5283878386670888513.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238357-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,cachyos.org,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable,kernelorg];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: C9DD5414145
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     4096fd0e8eaea13ebe5206700b33f49635ae18e5
Gitweb:        https://git.kernel.org/tip/4096fd0e8eaea13ebe5206700b33f49635a=
e18e5
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 14 Apr 2026 22:55:01 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Thu, 16 Apr 2026 21:22:04 +02:00

clockevents: Add missing resets of the next_event_forced flag

The prevention mechanism against timer interrupt starvation missed to reset
the next_event_forced flag in a couple of places:

    - When the clock event state changes. That can cause the flag to be
      stale over a shutdown/startup sequence

    - When a non-forced event is armed, which then prevents rearming before
      that event. If that event is far out in the future this will cause
      missed timer interrupts.

    - In the suspend wakeup handler.

That led to stalls which have been reported by several people.

Add the missing resets, which fixes the problems for the reporters.

Fixes: d6e152d905bd ("clockevents: Prevent timer interrupt starvation")
Reported-by: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
Reported-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
Tested-by: Eric Naim <dnaim@cachyos.org>
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/68d1e9ac-2780-4be3-8ee3-0788062dd3a4@gmail.com
Link: https://patch.msgid.link/87340xfeje.ffs@tglx
---
 kernel/time/clockevents.c    | 7 ++++++-
 kernel/time/tick-broadcast.c | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index b4d7306..5e22697 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -94,6 +94,9 @@ static int __clockevents_switch_state(struct clock_event_de=
vice *dev,
 	if (dev->features & CLOCK_EVT_FEAT_DUMMY)
 		return 0;
=20
+	/* On state transitions clear the forced flag unconditionally */
+	dev->next_event_forced =3D 0;
+
 	/* Transition with new state-specific callbacks */
 	switch (state) {
 	case CLOCK_EVT_STATE_DETACHED:
@@ -366,8 +369,10 @@ int clockevents_program_event(struct clock_event_device =
*dev, ktime_t expires, b
 	if (delta > (int64_t)dev->min_delta_ns) {
 		delta =3D min(delta, (int64_t) dev->max_delta_ns);
 		cycles =3D ((u64)delta * dev->mult) >> dev->shift;
-		if (!dev->set_next_event((unsigned long) cycles, dev))
+		if (!dev->set_next_event((unsigned long) cycles, dev)) {
+			dev->next_event_forced =3D 0;
 			return 0;
+		}
 	}
=20
 	if (dev->next_event_forced)
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 7e57fa3..115e0bf 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -108,6 +108,7 @@ static struct clock_event_device *tick_get_oneshot_wakeup=
_device(int cpu)
=20
 static void tick_oneshot_wakeup_handler(struct clock_event_device *wd)
 {
+	wd->next_event_forced =3D 0;
 	/*
 	 * If we woke up early and the tick was reprogrammed in the
 	 * meantime then this may be spurious but harmless.

