Return-Path: <stable+bounces-272960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6sMQAiK+T2qtngIAu9opvQ
	(envelope-from <stable+bounces-272960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 17:28:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1316732E3E
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 17:28:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fJtkzJNI;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272960-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272960-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F12E8307ED0C
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 14:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E6E319859;
	Thu,  9 Jul 2026 14:59:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9D7314A83
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 14:59:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609198; cv=none; b=UBLIyTnrINS7/T7BQp4ynIbj2FmFJ1qEyBFOwP6sZmyiq8vJx1yxHzIEEz2s7ZSaLv97GjDle9AkVG9U5kP/FQ9Q1H16hffUninMxElzGse8V7ltwHBb9o0YjC75R2wcIpLJAbqTmdbRmVkF/XELKp4NZ0xH3MrPESWOTdiS4mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609198; c=relaxed/simple;
	bh=v0OjFO2hslvzaeyn4F64MBVG0kEMSXJugDzefPSyV6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDe10ZXWmkOnLXQauIQWRqoqZB4mRzO1tfGnbAA1sEfihpF6hrifgGCOiXktyN3u/iM414GunCBQO/OS4oOHV2QweVYIoko17Xr1lJTZA3YbvuTHVdt52Df4EwS5M1KSNdg1VxGLGb2QjPxkDUU+4NZw2A8bYSHQ77WKneffwPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJtkzJNI; arc=none smtp.client-ip=209.85.160.171
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c21495722so8756741cf.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 07:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783609195; x=1784213995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uOKbSEhS51WNqBs8EzLbyYXHulgqBQq5gKSOvZPTDiU=;
        b=fJtkzJNIU2lASVgvwUcdlcRo7EBle3tDXPB1uDFXmwbDgDMFdLc+qgfapcyoXLvu2J
         2sro5Anxc+fOhLZT5bF5D4eQoyf08DwHJvA6YJJ5f01yGV2TuUdP7Wy74kevWD7hkyXU
         XdUXwthd3YgfMrVnWRlKnWmAR+1pZe4j23Ec47tCrWz3XIoShjgJ/lwYdqibYdqHt5SS
         JBAXT9BajtOsLyF0gKbBzfSEGbn90gCVuHu5irvEbxp4qZPrvshkjfHqIL+mRk9JiN1u
         M7wIzCLcPtL1Db7nlOXBYQqGZwiWaADW48EwKjvYHydwzn1QWH9S9GJTug7prfBgS7C4
         MVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783609195; x=1784213995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uOKbSEhS51WNqBs8EzLbyYXHulgqBQq5gKSOvZPTDiU=;
        b=U6k5C0N2km8euvRhV7Z1Z+ZkXy/xoNLIZvrig1FQV9gUJFhGoeNPnEVg6QuMXY0osy
         7cfd37E89HTZukY7rcQxEMrqlce1AY92Ij2Ai6dscYwdWJ4of80EwI97Gs8z0b7fA66N
         Gnp8GIu0wT/zUiJYsLN08+vCu+A3bcUASo7o7CqibOrOwL3BwF0boJBfNE0oDBgXwGrl
         k1Vjm+5kEJGKAnfF6b9IiTPCwD8UhL02mIHk+pIpcHbAmm65kDBSyfgwpSUAxopPrQ1a
         Hhe9EnkP1jgaqJGs+Jp6S0pD0WdhFlZPSAi+aGvpiVNJLihcsL1M2TzLn90oFUrRsXVg
         UPhA==
X-Gm-Message-State: AOJu0Ywkas/2rVzX8yu7erUc6gcByWAeIEDJnHPSwEIKfELWtvNhEBFM
	NQFHO4yKBHcOUbQg9kFGgEKAlAT3TrGvga36L9a7WnhxVKRLRt9Nt26dYzhp9OhP
X-Gm-Gg: AfdE7cnCmH76yoN4q6o9xqBYAHmIsizGS1NU0lMq5epk+nhYyrBzHwQncA3JXDiJa8n
	y3tVAgUDzsbQCL612I4AYqu9PVqWpH0FqQaEjkaWMwKnpgdYaxfV6HNvsVrzZ2/A3UiRuYR3gXo
	OwjkFlbjaOecp5QNjRzLOI0DqNKbxSOoyiRmgw8B0vEcK3YHCkwWUQAQ6QFXT49Tv5kaA96y5Gt
	WRAt7kT4bbZ4WU2Tcbl4rCKfS2eKKgtZg82wggzUzk2F+LU0SMtsd7ew8jGA/0U0nQW9NNo6BpW
	zfOF+pivfJSBs5gkbhZ+M9anyD8TyvmsJf2Hno1bdqFSZeWTYGMck9MAK9YCAge/cjJwm+IpRo5
	P4wR/2/L7w1r4KfInOL/5mCc4ZG6JgcBV2xdiBgbqIVELuDkK7Xbc2U8BwNHH8Loxby6PG2Wmqx
	MTCxXk07fZD+qyZnVwfzbYqc6cvS49e3XOEdSHXCqMpDKlhZmi1s6EVqd2R5L/E2z+30MXFU3O2
	+Gd1gTLMp/UCnxfwCOIxTNBlNnWi5CC5MLKPo7iuMZ7EJzKmWnD6+8=
X-Received: by 2002:ac8:5ac2:0:b0:51b:fadc:ed7d with SMTP id d75a77b69052e-51c8b3c6862mr82111791cf.44.1783609194678;
        Thu, 09 Jul 2026 07:59:54 -0700 (PDT)
Received: from sm-sl16-1.lab-skae.tower-research.com (static-71-183-126-99.nycmny.fios.verizon.net. [71.183.126.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd80fd492sm20374506d6.34.2026.07.09.07.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:59:54 -0700 (PDT)
From: Sid Kumar <sidkumar1@gmail.com>
To: stable@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Keenan Dong <keenanat2000@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Thomas Gleixner <tglx@kernel.org>,
	Sid Kumar <sidkumar1@gmail.com>,
	syzbot+78147abe6c524f183ee9@syzkaller.appspotmail.com
Subject: [PATCH 5.15.y v2 2/2] locking/rtmutex: Skip remove_waiter() when waiter is not enqueued
Date: Thu,  9 Jul 2026 10:59:49 -0400
Message-ID: <20260709145949.3640783-2-sidkumar1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260709145949.3640783-1-sidkumar1@gmail.com>
References: <20260709145949.3640783-1-sidkumar1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[stgolabs.net,gmail.com,lzu.edu.cn,kernel.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272960-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:dave@stgolabs.net,m:keenanat2000@gmail.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:tglx@kernel.org,m:sidkumar1@gmail.com,m:syzbot+78147abe6c524f183ee9@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sidkumar1@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sidkumar1@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,78147abe6c524f183ee9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,stgolabs.net:email,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1316732E3E

From: Davidlohr Bueso <dave@stgolabs.net>

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
(cherry picked from commit 40a25d59e85b3c8709ac2424d44f65610467871e)
Signed-off-by: Sid Kumar <sidkumar1@gmail.com>
---
 kernel/locking/rtmutex.c     | 3 +++
 kernel/locking/rtmutex_api.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index f79c9286c7c0..2118f8928eb7 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1513,6 +1513,9 @@ static void __sched remove_waiter(struct rt_mutex_base *lock,
 
 	lockdep_assert_held(&lock->wait_lock);
 
+	if (!waiter_task) /* never enqueued */
+		return;
+
 	raw_spin_lock(&waiter_task->pi_lock);
 	rt_mutex_dequeue(lock, waiter);
 	waiter_task->pi_blocked_on = NULL;
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 56d1938cb52a..c4e191340c59 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -322,7 +322,7 @@ int __sched rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 
 	raw_spin_lock_irq(&lock->wait_lock);
 	ret = __rt_mutex_start_proxy_lock(lock, waiter, task);
-	if (unlikely(ret))
+	if (unlikely(ret < 0))
 		remove_waiter(lock, waiter);
 	raw_spin_unlock_irq(&lock->wait_lock);
 
-- 
2.39.2


