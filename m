Return-Path: <stable+bounces-264442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pi37N0F3MWofkAUAu9opvQ
	(envelope-from <stable+bounces-264442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:18:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8E8691E86
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:18:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=u72H14Bl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264442-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264442-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 931F83264CF3
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526294611C1;
	Tue, 16 Jun 2026 16:05:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AE13A8746;
	Tue, 16 Jun 2026 16:05:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625905; cv=none; b=INfqk11AYfmkdxquRkqWXP5bgpq4AX0Ebu0LTYJbAnULbCleLOh86pP9q7WDz9IiD6CQUUACe4OwR6yKYVztatm8xUoS3D+ewMtyJZEZQEWXG1/okDNybt1MCuk0PNBtkSl2DCoAUGLF4jZnYbJD6RbR2HLyx0knZ/G5QzyH2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625905; c=relaxed/simple;
	bh=XWozZlTtTBKXFvkBfd7LjvkGWytVfnbZ2pfoFSXj4jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAzVZC9nSEFQds9u3p6LwmENUOVUiGshT/R16/w/u2OzZU2BVmyvV4CjCguJtitGRqA+350c4GAXUu/y0+/e2+5maXp6Igr+XUexYTnlVe7JO52PI6qIzf1SI1bdwAcsuvf/OEScly1evCOURVtLwtippFqqbOd+/s521aajHAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u72H14Bl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C981F000E9;
	Tue, 16 Jun 2026 16:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625904;
	bh=ZrxVQ8v29yx10hxq8/Xc+7H1SQU7P4f2jpYxLLpVRRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=u72H14BlDgw/3Lp76E9gSvk83eBsJSlHLeebwyh5RYC6rP1YRH6GyT2CwsCgqEt4i
	 WIuQmm1HpfEKvwq61DbMuIaMCkdFwkVAEE/LcKCs581ezE0b55Y+4Jk2/dFbfWrceZ
	 QI9zxnADwRTs+ko+ntyRm/rQQnVMdK0EJ1i4w8jA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+78147abe6c524f183ee9@syzkaller.appspotmail.com,
	Davidlohr Bueso <dave@stgolabs.net>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH 6.18 229/325] locking/rtmutex: Skip remove_waiter() when waiter is not enqueued
Date: Tue, 16 Jun 2026 20:30:25 +0530
Message-ID: <20260616145109.805242622@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-264442-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:syzbot+78147abe6c524f183ee9@syzkaller.appspotmail.com,m:dave@stgolabs.net,m:tglx@kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,78147abe6c524f183ee9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,stgolabs.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F8E8691E86

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davidlohr Bueso <dave@stgolabs.net>

commit 40a25d59e85b3c8709ac2424d44f65610467871e upstream.

syzbot triggered the following splat in remove_waiter() via
FUTEX_CMP_REQUEUE_PI:

  KASAN: null-ptr-deref in range [0x0000000000000a88-0x0000000000000a8f]
   class_raw_spinlock_constructor
   remove_waiter+0x159/0x1200 kernel/locking/rtmutex.c:1561
   rt_mutex_start_proxy_lock+0x103/0x120
   futex_requeue+0x10e4/0x20d0
   __x64_sys_futex+0x34f/0x4d0

task_blocks_on_rt_mutex() does not arm the waiter upon deadlock detection,
leaving waiter->task nil, where 3bfdc63936dd ("rtmutex: Use waiter::task instead
of current in remove_waiter()") made this fatal.

Furthermore, rt_mutex_start_proxy_lock() should not be calling into remove_waiter()
upon a successfully grabbing the rtmutex. 1a1fb985f2e2 ("futex: Handle early deadlock
return correctly"), moved the remove_waiter() out of __rt_mutex_start_proxy_lock()
(where 'ret' was only ever 0 or < 0) into the wrapper. Tighten this check to
account for try_to_take_rt_mutex().

Fixes: 3bfdc63936dd ("rtmutex: Use waiter::task instead of current in remove_waiter()")
Reported-by: syzbot+78147abe6c524f183ee9@syzkaller.appspotmail.com
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/69f114ac.050a0220.ac8b.0003.GAE@google.com/
Link: https://patch.msgid.link/20260507112913.1019537-1-dave@stgolabs.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/locking/rtmutex.c     |    3 +++
 kernel/locking/rtmutex_api.c |    2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1548,6 +1548,9 @@ static void __sched remove_waiter(struct
 
 	lockdep_assert_held(&lock->wait_lock);
 
+	if (!waiter_task) /* never enqueued */
+		return;
+
 	scoped_guard(raw_spinlock, &waiter_task->pi_lock) {
 		rt_mutex_dequeue(lock, waiter);
 		waiter_task->pi_blocked_on = NULL;
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -365,7 +365,7 @@ int __sched rt_mutex_start_proxy_lock(st
 
 	raw_spin_lock_irq(&lock->wait_lock);
 	ret = __rt_mutex_start_proxy_lock(lock, waiter, task, &wake_q);
-	if (unlikely(ret))
+	if (unlikely(ret < 0))
 		remove_waiter(lock, waiter);
 	preempt_disable();
 	raw_spin_unlock_irq(&lock->wait_lock);



