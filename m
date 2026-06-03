Return-Path: <stable+bounces-260190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Va6vFmSMIGrS4wAAu9opvQ
	(envelope-from <stable+bounces-260190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 22:19:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC05D63B146
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 22:19:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=WMWwsoze;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=I+PuS+yi;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260190-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260190-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82AC2303CC00
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 20:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494303D9DA0;
	Wed,  3 Jun 2026 20:16:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC333A3816;
	Wed,  3 Jun 2026 20:16:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780517775; cv=none; b=fw6k2boULuFJGY29+8TbkNuankE70FCBpSeEns01P4Su+ubHjJY5IOrNxiQTQ4lExkAVFnJBFpcUtb41GKU/nNsPhh3Pk5vdyNDQtd+dd52pMO5Ru667MrrtMdQ3oM1tk/Xps9AhWpj5w58cdyhdCwj80p/wknNRW2uNQTNOqf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780517775; c=relaxed/simple;
	bh=ljWLbcWqPQqUQqC+Y9aEHfuzUNNwSOwpXPzUrs/XVno=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sgFPzN31wjUPBSlpgzhcGX5oZMsJISrme0xLuykN+zCw7hyRR9hv/a4uxXm+fYV0/p0efVVtlPJ/jZ3HeEn/tOH+YVwPemqgs4JCzcd0tAoCl70WsljCR8I5qtVl3rEDdSYSrYu6jJtIilh3apwK74kGUoSjqM3GS2j/aKPiOKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WMWwsoze; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I+PuS+yi; arc=none smtp.client-ip=193.142.43.55
Date: Wed, 03 Jun 2026 20:16:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780517772;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HaAcml/hsg87+10WXExvmobFW3lWSh2IJIWZcKaC2PQ=;
	b=WMWwsozel6zE39ywRYVesQBSYcrqYp1wUyF04v0SUthnmgMXjWlpTf0K3PckrdJZwYOJjE
	p44vcYZ0l4go1n3ku7Cjg8Fr0CwxMCL6nA5VNVhhRSJxRyT968E6Oa9NglEfPBbgcrCq6j
	U8hxrmTUrAV5xB2lpOSU5Gk6UvZWT9j4OKAycpdYhft5SC32MeaCEg4FinKxT+yGPSqBje
	eeE5M29GNwT9M9wYUezUx1wkfC5Iklc9pcyE/Viw1+CeqM76QiqPiwkuVPltKHvXW6tZcg
	cileJwmaQ8qg02i42wdlD+rtXKRakaFB1B0YE8U3P/VmwtrAX+eHQk0WYeOUag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780517772;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HaAcml/hsg87+10WXExvmobFW3lWSh2IJIWZcKaC2PQ=;
	b=I+PuS+yiYv8/fHgSwAmj3Jov+A27CiRDLiiv5lGSoOgpPo5Nds+XxQdL4jQj90DMKPDukR
	XMlzNOVciHl770BA==
From: "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/rtmutex: Skip remove_waiter() when
 waiter is not enqueued
Cc: syzbot+78147abe6c524f183ee9@syzkaller.appspotmail.com,
 Davidlohr Bueso <dave@stgolabs.net>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260507112913.1019537-1-dave@stgolabs.net>
References: <20260507112913.1019537-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178051776811.710.17500090454720140903.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-tip-commits@vger.kernel.org,m:syzbot+78147abe6c524f183ee9@syzkaller.appspotmail.com,m:dave@stgolabs.net,m:tglx@kernel.org,m:stable@vger.kernel.org,m:x86@kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-260190-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable,78147abe6c524f183ee9];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,vger.kernel.org:replyto,linutronix.de:from_mime,linutronix.de:dkim,tip-bot2:mid,msgid.link:url,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC05D63B146

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     40a25d59e85b3c8709ac2424d44f65610467871e
Gitweb:        https://git.kernel.org/tip/40a25d59e85b3c8709ac2424d44f6561046=
7871e
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Thu, 07 May 2026 04:29:13 -07:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Wed, 03 Jun 2026 22:11:53 +02:00

locking/rtmutex: Skip remove_waiter() when waiter is not enqueued

syzbot triggered the following splat in remove_waiter() via
FUTEX_CMP_REQUEUE_PI:

  KASAN: null-ptr-deref in range [0x0000000000000a88-0x0000000000000a8f]
   class_raw_spinlock_constructor
   remove_waiter+0x159/0x1200 kernel/locking/rtmutex.c:1561
   rt_mutex_start_proxy_lock+0x103/0x120
   futex_requeue+0x10e4/0x20d0
   __x64_sys_futex+0x34f/0x4d0

task_blocks_on_rt_mutex() does not arm the waiter upon deadlock detection,
leaving waiter->task nil, where 3bfdc63936dd ("rtmutex: Use waiter::task inst=
ead
of current in remove_waiter()") made this fatal.

Furthermore, rt_mutex_start_proxy_lock() should not be calling into remove_wa=
iter()
upon a successfully grabbing the rtmutex. 1a1fb985f2e2 ("futex: Handle early =
deadlock
return correctly"), moved the remove_waiter() out of __rt_mutex_start_proxy_l=
ock()
(where 'ret' was only ever 0 or < 0) into the wrapper. Tighten this check to
account for try_to_take_rt_mutex().

Fixes: 3bfdc63936dd ("rtmutex: Use waiter::task instead of current in remove_=
waiter()")
Reported-by: syzbot+78147abe6c524f183ee9@syzkaller.appspotmail.com
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/69f114ac.050a0220.ac8b.0003.GAE@google.co=
m/
Link: https://patch.msgid.link/20260507112913.1019537-1-dave@stgolabs.net
---
 kernel/locking/rtmutex.c     | 3 +++
 kernel/locking/rtmutex_api.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4f386ea..daeeeef 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1558,6 +1558,9 @@ static void __sched remove_waiter(struct rt_mutex_base =
*lock,
=20
 	lockdep_assert_held(&lock->wait_lock);
=20
+	if (!waiter_task) /* never enqueued */
+		return;
+
 	scoped_guard(raw_spinlock, &waiter_task->pi_lock) {
 		rt_mutex_dequeue(lock, waiter);
 		waiter_task->pi_blocked_on =3D NULL;
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 124219a..514fce7 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -365,7 +365,7 @@ int __sched rt_mutex_start_proxy_lock(struct rt_mutex_bas=
e *lock,
=20
 	raw_spin_lock_irq(&lock->wait_lock);
 	ret =3D __rt_mutex_start_proxy_lock(lock, waiter, task, &wake_q);
-	if (unlikely(ret))
+	if (unlikely(ret < 0))
 		remove_waiter(lock, waiter);
 	preempt_disable();
 	raw_spin_unlock_irq(&lock->wait_lock);

