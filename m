Return-Path: <stable+bounces-242787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIuGLJRM92lieQIAu9opvQ
	(envelope-from <stable+bounces-242787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 15:24:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ACF4B5E35
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 15:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FFFA300AB12
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 13:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7433CB2D0;
	Sun,  3 May 2026 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vp9qxu1m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JMnckAOp"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAC03CAE7D;
	Sun,  3 May 2026 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777814666; cv=none; b=Tj69GvaeMFw8c9Adb/v7nL22PyBF1xa2HeOKgRpBNJHocFJ/aeckmrAR+tHki1OfE4ATV5rGk9tRxAzmwGo10C09iz8zrm4YLMuEISYqdfcRDnteljVNO3H/x2kqa2tuYPvmkAvxbfbg/7PMKkGwuBWc0YJbhlt7SvZCKH9PATY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777814666; c=relaxed/simple;
	bh=hXJkb9zeGBnqy8Bqmj5jsUWVyNOcIs9SNKVV5AIb5VM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BUm/N/20PRUCusxN37XAIkBeoLJgCfrpuW8GSjni/EuCsHhT5RwGYIBFJHYrr6DQHKqkWf9BQKP7S7fRxlvab2wxe27RK0CgcHxVHzmyFFkj1Un3AcLsS9BgJpRwViISCetRcpIwnGzsTOXcvXdaAhnGjmK7V15ldvr9wyycv8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vp9qxu1m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JMnckAOp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777814656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tz8my8xNlqK7bwfmWQRlThnku6PbexVIGoppmPblUuk=;
	b=Vp9qxu1mT/Oh2DbsI8QMvVXYSiRlU6u4bjDfoV/yTMq8J3WS2mAHx1tWP4tNmNmEK/N7mw
	l5AdP4IwCTdzgV9adKYAzO7ffWy0WcU3u3cCB5sZB8q2Xk9gohFFQN6995mMAL3C1RhNup
	Exm/qr0JNtawUgNmzpxI5Z4WBRUIHYiMxBDLF7Pp0v+AEgD08FZyYtxNTP4UMwIeyxn/l4
	lrW7i9hzaxFuuE9xs3uUiLacHD7s8/sFjNf05V6brOJiHtBTP5L9VaHHkb4Dy6uI/o4cA9
	4BU1brqlbx6g5/0oskH1IJrcemnruoDuO6SlG39uSGvePWnYdkPMDTE/Skoo9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777814656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tz8my8xNlqK7bwfmWQRlThnku6PbexVIGoppmPblUuk=;
	b=JMnckAOp+EHGs30bBWElkNK1KSD9wAP5DDGdbEycT/kSpN+bTLhVUPu8Lcj49TLIeCDL38
	R9uZw3v3eCTc9RAw==
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Soheil Hassas Yeganeh
 <soheil@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara
 <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Khazhismel Kumykov <khazhy@google.com>, Willem de
 Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, Jens
 Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
In-Reply-To: <xbotidrmois5ygxtqtwqzczkt76wcc7uw5cz5lptda53coaavj@pzvxcpe534cu>
References: <cover.1752824628.git.namcao@linutronix.de>
 <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <CACSApvZT5F4F36jLWEc5v_AbqZVQpmH1W7UK21tB9nPu=OtmBA@mail.gmail.com>
 <20250718085948.3xXGcxeQ@linutronix.de>
 <20260429-november-speisen-3084d769d316@brauner>
 <87340exm2o.fsf@yellow.woof>
 <xbotidrmois5ygxtqtwqzczkt76wcc7uw5cz5lptda53coaavj@pzvxcpe534cu>
Date: Sun, 03 May 2026 15:24:14 +0200
Message-ID: <87cxzc62yp.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 49ACF4B5E35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-242787-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namcao@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Mateusz Guzik <mjguzik@gmail.com> writes:
> Strictly speaking more error prone than the seq approach, but should be
> faster on weaker-ordered archs thanks to avoided fences.
>
> I'm definitely not going to protest the seqc route.

Linus probably wouldn't be thrilled if I break epoll again, so let's
stay with the simpler seqcount route.

Nam

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index a3090b446af1..22c3f0186476 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -38,6 +38,7 @@
 #include <linux/compat.h>
 #include <linux/rculist.h>
 #include <linux/capability.h>
+#include <linux/seqlock.h>
 #include <net/busy_poll.h>
 
 /*
@@ -190,6 +191,9 @@ struct eventpoll {
 	/* Lock which protects rdllist and ovflist */
 	spinlock_t lock;
 
+	/* Protect switching between rdllist and ovflist */
+	seqcount_spinlock_t seq;
+
 	/* RB tree root used to store monitored fd structs */
 	struct rb_root_cached rbr;
 
@@ -382,8 +386,17 @@ static inline struct epitem *ep_item_from_wait(wait_queue_entry_t *p)
  */
 static inline int ep_events_available(struct eventpoll *ep)
 {
-	return !list_empty_careful(&ep->rdllist) ||
-		READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR;
+	bool events_available;
+	unsigned int seq;
+
+	do {
+		seq = read_seqcount_begin(&ep->seq);
+
+		events_available = !list_empty_careful(&ep->rdllist) ||
+				   READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR;
+	} while (read_seqcount_retry(&ep->seq, seq));
+
+	return events_available;
 }
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
@@ -735,8 +748,12 @@ static void ep_start_scan(struct eventpoll *ep, struct list_head *txlist)
 	 */
 	lockdep_assert_irqs_enabled();
 	spin_lock_irq(&ep->lock);
+	write_seqcount_begin(&ep->seq);
+
 	list_splice_init(&ep->rdllist, txlist);
 	WRITE_ONCE(ep->ovflist, NULL);
+
+	write_seqcount_end(&ep->seq);
 	spin_unlock_irq(&ep->lock);
 }
 
@@ -768,6 +785,9 @@ static void ep_done_scan(struct eventpoll *ep,
 			ep_pm_stay_awake(epi);
 		}
 	}
+
+	write_seqcount_begin(&ep->seq);
+
 	/*
 	 * We need to set back ep->ovflist to EP_UNACTIVE_PTR, so that after
 	 * releasing the lock, events will be queued in the normal way inside
@@ -779,6 +799,9 @@ static void ep_done_scan(struct eventpoll *ep,
 	 * Quickly re-inject items left on "txlist".
 	 */
 	list_splice(txlist, &ep->rdllist);
+
+	write_seqcount_end(&ep->seq);
+
 	__pm_relax(ep->ws);
 
 	if (!list_empty(&ep->rdllist)) {
@@ -1155,6 +1178,7 @@ static int ep_alloc(struct eventpoll **pep)
 
 	mutex_init(&ep->mtx);
 	spin_lock_init(&ep->lock);
+	seqcount_spinlock_init(&ep->seq, &ep->lock);
 	init_waitqueue_head(&ep->wq);
 	init_waitqueue_head(&ep->poll_wait);
 	INIT_LIST_HEAD(&ep->rdllist);

