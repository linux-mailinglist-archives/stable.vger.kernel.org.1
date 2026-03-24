Return-Path: <stable+bounces-230238-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAwWJZgOw2lKnwQAu9opvQ
	(envelope-from <stable+bounces-230238-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 23:22:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1AF31D4BA
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 23:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 620923014F7C
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 22:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE25B381AE3;
	Tue, 24 Mar 2026 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mtKaNo06";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bFT3FTJK"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCD82E5B21;
	Tue, 24 Mar 2026 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774390898; cv=none; b=Q3a9R7RixIeRP/HYoPkvWYWQv/iBPMsYx1oT+/a69XJjiCwVsz7lwKxlIh/ZXO3xGU1OqOD/Oi9rKlIutJ1oyhuQLAmve7+NhK8NbqWQv33fZfXP7IAXcR0hsoH3yQlH5bitejEl4eAEOxN54UJC41U9dJsVVDpflcwJJXk6qns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774390898; c=relaxed/simple;
	bh=1fAPhsMA1W9sKMRbuZrkukFuNOhGtZoWlS0RdzNMqmQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=K/pwQ5JXtmRwVhClE7ZE8G/skpvzkTyZYkxAf8Fl2vSwN5eyfBZZWbLrLPEgo3P5oIjWwQ0lSJ+yhtFS4X7ZYS5W2P2hhHbcO7Eg2jNkFx847182DdK0MUtoGm4bU0h49fGH2hoVTHot4Dk4zFlfybb2Eq+RLUiuPsYksDDA7JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mtKaNo06; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bFT3FTJK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Mar 2026 22:21:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774390895;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D1QnBu97ZMtfpLiuGGbIC1NMxPNAE+1LfRnnCKnN7CA=;
	b=mtKaNo06EnvhdkBKneCSJX95LrRjZo4gIwxSQmFm4pcNWvVx30h81nGOAVystw3r9S9OTT
	GoJSmqSOCm7hVajiVBkvTl341RkrSxyFtZQTsNjsN68EP7rg/AqdfZAO6QYa0M5s0D+2MM
	YP2soMPdvXbJbEkdVSQ0r4M78UzZYpFW32BZIGx4JUnVBg8Bqf1dadaVRsH+IbXcDF5pFz
	i9QUBYHZzzdkNdvTJGcSXGUfH65ZUFE2i9EJkkqoW69S67wZvKM/vQkra1gcj56ezwlp50
	xySqdsga9X+v5av4c3Y0c9qa8VF5gY19m28t6UVG6pUxHLPYRtcS6uOO/S8e0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774390895;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D1QnBu97ZMtfpLiuGGbIC1NMxPNAE+1LfRnnCKnN7CA=;
	b=bFT3FTJKySj83NqBt0mXOqZfZhz7vs/NVywXUrX9xZTNAQFusxpK5dRGjUUkb8nkB8lxLf
	+u+9UciTGwTeQuBQ==
From: "tip-bot2 for Zhan Xusheng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] alarmtimer: Fix argument order in alarm_timer_forward()
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260323061130.29991-1-zhanxusheng@xiaomi.com>
References: <20260323061130.29991-1-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177439089404.1647592.17218464106125587863.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230238-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linutronix.de:dkim,vger.kernel.org:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: DC1AF31D4BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     5d16467ae56343b9205caedf85e3a131e0914ad8
Gitweb:        https://git.kernel.org/tip/5d16467ae56343b9205caedf85e3a131e09=
14ad8
Author:        Zhan Xusheng <zhanxusheng1024@gmail.com>
AuthorDate:    Mon, 23 Mar 2026 14:11:30 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 24 Mar 2026 23:17:14 +01:00

alarmtimer: Fix argument order in alarm_timer_forward()

alarm_timer_forward() passes arguments to alarm_forward() in the wrong
order:

  alarm_forward(alarm, timr->it_interval, now);

However, alarm_forward() is defined as:

  u64 alarm_forward(struct alarm *alarm, ktime_t now, ktime_t interval);

and uses the second argument as the current time:

  delta =3D ktime_sub(now, alarm->node.expires);

Passing the interval as "now" results in incorrect delta computation,
which can lead to missed expirations or incorrect overrun accounting.

This issue has been present since the introduction of
alarm_timer_forward().

Fix this by swapping the arguments.

Fixes: e7561f1633ac ("alarmtimer: Implement forward callback")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260323061130.29991-1-zhanxusheng@xiaomi.com
---
 kernel/time/alarmtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 069d93b..b64db40 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -540,7 +540,7 @@ static s64 alarm_timer_forward(struct k_itimer *timr, kti=
me_t now)
 {
 	struct alarm *alarm =3D &timr->it.alarm.alarmtimer;
=20
-	return alarm_forward(alarm, timr->it_interval, now);
+	return alarm_forward(alarm, now, timr->it_interval);
 }
=20
 /**

