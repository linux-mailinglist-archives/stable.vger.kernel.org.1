Return-Path: <stable+bounces-230785-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAj1OmHQx2kcdAUAu9opvQ
	(envelope-from <stable+bounces-230785-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 13:58:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B3134E74E
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 13:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC57D3011D76
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 12:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309C43890FD;
	Sat, 28 Mar 2026 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jyXCit5f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5tgmtqpj"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E372C159E;
	Sat, 28 Mar 2026 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774702681; cv=none; b=SVIuVMotxrTFFf3M9JASzUKavPpo1S+mTZvuwV6zB32rWIfaEf7ea2ByUhhU11rCJB66Ids995YMMeatwOk+F4OCa9kOLcB1GvRhpEpZqXBozd+sWuEpM09o6Kq2DFcL5v9y3yMrcT/031rluwfXNu2C/XEoRezpNueQ+zDCUuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774702681; c=relaxed/simple;
	bh=pVqao8RWkuAoYk4NSRkqSfxc1WHYeNTP2T0N0McFvjU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P5wcD8HKsesgbae7K6toi8Bt088MH7Vw/MG4nQJfJDBuVeqHWW6kVHpW0uEfrOUXQLUeja4a2EXXx9H0g07cBxRYRx+khIcm1Ntn6EbaoJEhne70FDC4V88okfRagkXn9RlRLbeXZPGE/jXXn2qyPboiUy8pt6bvt1rHxw37ryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jyXCit5f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5tgmtqpj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Mar 2026 12:57:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774702672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BhsYOWRaoYgABVK1deJjkpCXBTh6mYgJjfU6XsZf2Ac=;
	b=jyXCit5fMrhwmY0nrP9a/FPKKopTDtSEbm+w3rulMgdIhCcs7Im+ifm+ImUba7hzPZe7IK
	aqa3WUqWUun3UDiWQvi6gV9HEV8FZggmFHwlNuUCezRyaIq8FJd1o5LTKt3zZ5VMOzeRqI
	oq2yBKTXhBFMi+fogwKBXAlYxCpbzN/htZOyAaexpdy9R5ryfkliYyU0l2hhFe9i30SekB
	V6Gf4Gvrbkc4GtHjprKmpDWfUCeU4ejgYhExJdG9TBrl9DTPZqmn9b5nObn7v2fKyk/+X1
	0URUvOSRei1bKgSU05u+ORTIPDZSB6LhpIFgTYra8KV7kNSIbKdphom/hayQww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774702672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BhsYOWRaoYgABVK1deJjkpCXBTh6mYgJjfU6XsZf2Ac=;
	b=5tgmtqpjyBOXJrP9+K6G4r8lQfAfWJ0hkLQp1jCVvQJFU9UfjAGnv5ze5Ji4SGRoXumaLr
	vn1LE2N649hzy3Bw==
From: "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Clear stale exiting pointer in
 futex_lock_pi() retry path
Cc: Davidlohr Bueso <dave@stgolabs.net>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260326001759.4129680-1-dave@stgolabs.net>
References: <20260326001759.4129680-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177470266575.1647592.12296818501282696704.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-230785-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stgolabs.net:email,vger.kernel.org:replyto];
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
X-Rspamd-Queue-Id: E3B3134E74E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     210d36d892de5195e6766c45519dfb1e65f3eb83
Gitweb:        https://git.kernel.org/tip/210d36d892de5195e6766c45519dfb1e65f=
3eb83
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Wed, 25 Mar 2026 17:17:59 -07:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sat, 28 Mar 2026 13:54:02 +01:00

futex: Clear stale exiting pointer in futex_lock_pi() retry path

Fuzzying/stressing futexes triggered:

    WARNING: kernel/futex/core.c:825 at wait_for_owner_exiting+0x7a/0x80, CPU=
#11: futex_lock_pi_s/524

When futex_lock_pi_atomic() sees the owner is exiting, it returns -EBUSY
and stores a refcounted task pointer in 'exiting'.

After wait_for_owner_exiting() consumes that reference, the local pointer
is never reset to nil. Upon a retry, if futex_lock_pi_atomic() returns a
different error, the bogus pointer is passed to wait_for_owner_exiting().

  CPU0			     CPU1		       CPU2
  futex_lock_pi(uaddr)
  // acquires the PI futex
  exit()
    futex_cleanup_begin()
      futex_state =3D EXITING;
			     futex_lock_pi(uaddr)
			       futex_lock_pi_atomic()
				 attach_to_pi_owner()
				   // observes EXITING
				   *exiting =3D owner;  // takes ref
				   return -EBUSY
			       wait_for_owner_exiting(-EBUSY, owner)
				 put_task_struct();   // drops ref
			       // exiting still points to owner
			       goto retry;
			       futex_lock_pi_atomic()
				 lock_pi_update_atomic()
				   cmpxchg(uaddr)
					*uaddr ^=3D WAITERS // whatever
				   // value changed
				 return -EAGAIN;
			       wait_for_owner_exiting(-EAGAIN, exiting) // stale
				 WARN_ON_ONCE(exiting)

Fix this by resetting upon retry, essentially aligning it with requeue_pi.

Fixes: 3ef240eaff36 ("futex: Prevent exit livelock")
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260326001759.4129680-1-dave@stgolabs.net
---
 kernel/futex/pi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index bc1f7e8..7808068 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -918,7 +918,7 @@ int fixup_pi_owner(u32 __user *uaddr, struct futex_q *q, =
int locked)
 int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int =
trylock)
 {
 	struct hrtimer_sleeper timeout, *to;
-	struct task_struct *exiting =3D NULL;
+	struct task_struct *exiting;
 	struct rt_mutex_waiter rt_waiter;
 	struct futex_q q =3D futex_q_init;
 	DEFINE_WAKE_Q(wake_q);
@@ -933,6 +933,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, =
ktime_t *time, int tryl
 	to =3D futex_setup_timer(time, &timeout, flags, 0);
=20
 retry:
+	exiting =3D NULL;
 	ret =3D get_futex_key(uaddr, flags, &q.key, FUTEX_WRITE);
 	if (unlikely(ret !=3D 0))
 		goto out;

