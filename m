Return-Path: <stable+bounces-240043-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGorDRwa52nT3wEAu9opvQ
	(envelope-from <stable+bounces-240043-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:33:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7553436FDF
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0515430094FF
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 06:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BD02C0323;
	Tue, 21 Apr 2026 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZhCe8JAg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xg2m3epx"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2D5273F9;
	Tue, 21 Apr 2026 06:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776753171; cv=none; b=R8OXYK6Qr/LqA67e0BWh7R+9WMEazuncfnUkwzvzUYJiirPBcMk+fp+O/54l60n7eVrpl66pvV9B2wmbF1sWFKw9s7OjjCv7biqEEsgDzOPF0/NA1WeeDL/ZXuCtr/M8B6Xk4VmyZbAUaVRJLzDphpKHJgVf2CZFU6byCQONrvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776753171; c=relaxed/simple;
	bh=kgOa+dQkvwxEDLTNWL3Llbs2CssuzqEaiOL4lLTkDIA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=uaw6xcv3gcniPI9Nd7EViHYth2HZiXu3BITmOzk3luI9HHqlNsfmk4/lDdWgdgHdOOyFaErZhJXc/mhmDeupQEI5JLJ2iPQ/POyhqxcT3Kmc0jEhw1RGM8zyiajaI9pL9rDC/JoKMHqGebg82riyeWyVuq7d+sJCM37P9/GmoYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZhCe8JAg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xg2m3epx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 Apr 2026 06:32:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776753167;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RCNYo50DblwWm2f7ZOkA1WIQi1M8OESQnJ049FZsiUY=;
	b=ZhCe8JAgzm3rbHxhfXS2+YFuVSSCXarNELX5Ip9OntAWFguJHSOtYec9g+Ysq7yq3xe7HW
	2uNOIfSYOrmk3erlJLHA6zixFlI5wPRrAExssqyY0YSbunaQK82/qPvSQvSZpNglFSa5tL
	Nhj3Y+kJ+l5gcdKSf5hcaDz1vY277xX5pXMDI5+PT/wlLDqeWd7I5I25GgUwNl0DWtITEf
	XQOwKDndQGR00urz0p3SpC0SvaEIkvUVuciZm5NpfCNcXmyIM6aq5AGSgITFPlV8ZEYM0N
	wqoSxOV3WaTFo94TRUBK7DB5oGrdNExT3ee9m3bdAcMx0vRz7QIfROwvjfd61g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776753167;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RCNYo50DblwWm2f7ZOkA1WIQi1M8OESQnJ049FZsiUY=;
	b=xg2m3epxUSqDspuOmrV7uwTBYQxbAiFm/0vlKIURUl6JwARK2d0mau//G2+puZBMlLo+g3
	wuKw0jWG2oeRHMCg==
From: "tip-bot2 for Keenan Dong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] rtmutex: Use waiter::task instead of current in
 remove_waiter()
Cc: Yuan Tan <yuantan098@gmail.com>, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Keenan Dong <keenanat2000@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177675316594.2419917.10349064268539358592.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240043-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lzu.edu.cn,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7553436FDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     3bfdc63936dd4773109b7b8c280c0f3b5ae7d349
Gitweb:        https://git.kernel.org/tip/3bfdc63936dd4773109b7b8c280c0f3b5ae=
7d349
Author:        Keenan Dong <keenanat2000@gmail.com>
AuthorDate:    Wed, 08 Apr 2026 16:46:00 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 21 Apr 2026 00:22:31 +02:00

rtmutex: Use waiter::task instead of current in remove_waiter()

remove_waiter() is used by the slowlock paths, but it is also used for
proxy-lock rollback in rt_mutex_start_proxy_lock() when invoked from
futex_requeue().

In the latter case waiter::task is not current, but remove_waiter()
operates on current for the dequeue operation. That results in several
problems:

  1) the rbtree dequeue happens without waiter::task::pi_lock being held

  2) the waiter task's pi_blocked_on state is not cleared, which leaves a
     dangling pointer primed for UAF around.

  3) rt_mutex_adjust_prio_chain() operates on the wrong top priority waiter
     task

Use waiter::task instead of current in all related operations in
remove_waiter() to cure those problems.

[ tglx: Fixup rt_mutex_adjust_prio_chain(), add a comment and amend the
  	changelog ]

Fixes: 8161239a8bcc ("rtmutex: Simplify PI algorithm and make highest prio ta=
sk get lock")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/locking/rtmutex.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index ccaba61..4f386ea 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1544,6 +1544,8 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base =
*lock,
  *
  * Must be called with lock->wait_lock held and interrupts disabled. It must
  * have just failed to try_to_take_rt_mutex().
+ *
+ * When invoked from rt_mutex_start_proxy_lock() waiter::task !=3D current !
  */
 static void __sched remove_waiter(struct rt_mutex_base *lock,
 				  struct rt_mutex_waiter *waiter)
@@ -1551,14 +1553,15 @@ static void __sched remove_waiter(struct rt_mutex_bas=
e *lock,
 {
 	bool is_top_waiter =3D (waiter =3D=3D rt_mutex_top_waiter(lock));
 	struct task_struct *owner =3D rt_mutex_owner(lock);
+	struct task_struct *waiter_task =3D waiter->task;
 	struct rt_mutex_base *next_lock;
=20
 	lockdep_assert_held(&lock->wait_lock);
=20
-	raw_spin_lock(&current->pi_lock);
-	rt_mutex_dequeue(lock, waiter);
-	current->pi_blocked_on =3D NULL;
-	raw_spin_unlock(&current->pi_lock);
+	scoped_guard(raw_spinlock, &waiter_task->pi_lock) {
+		rt_mutex_dequeue(lock, waiter);
+		waiter_task->pi_blocked_on =3D NULL;
+	}
=20
 	/*
 	 * Only update priority if the waiter was the highest priority
@@ -1594,7 +1597,7 @@ static void __sched remove_waiter(struct rt_mutex_base =
*lock,
 	raw_spin_unlock_irq(&lock->wait_lock);
=20
 	rt_mutex_adjust_prio_chain(owner, RT_MUTEX_MIN_CHAINWALK, lock,
-				   next_lock, NULL, current);
+				   next_lock, NULL, waiter_task);
=20
 	raw_spin_lock_irq(&lock->wait_lock);
 }

