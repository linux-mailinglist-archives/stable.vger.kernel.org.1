Return-Path: <stable+bounces-231100-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BDHABlFymm/7AUAu9opvQ
	(envelope-from <stable+bounces-231100-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:40:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EB935857B
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D61683003D19
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8112B3815C0;
	Mon, 30 Mar 2026 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x0LbQ9Sq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4436A35B125
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863636; cv=none; b=ZvDadFOpfkpD+3u4HW1IuPGXFxN+IWLQnKa6q2m/IxjATfqtYmwzlXntKeO97eBHX5/U2c3fUC6t8OwjrXmQmgp+M0wOQlWvcfYse7/Ca84oGG4D6UChh8TGWH/xmMilE4NQveBnjfCygmfDisSB1mUF9alL2GmrQgWB1DpRHbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863636; c=relaxed/simple;
	bh=8YEzImST967gmbnGdp26KkoTKPO1qWKy0g3se6QTWo0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lIntYVRx4ULKZBb7P2ObIgeR0ckSEJqVzmI/c7Nu38fPgtiYJRsgh2zeMrZqLl4ou9j+vwsJMzREDIZeMYIzNJ8ARn0tRvdMW+Arf5DHHPEuSXT+zs6PwdHlrAbl1eyIU7KDC9yjpwMEx3APAmne72rDJ7IJgCyjpIG2WgF/HPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x0LbQ9Sq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6850C2BCB2;
	Mon, 30 Mar 2026 09:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774863636;
	bh=8YEzImST967gmbnGdp26KkoTKPO1qWKy0g3se6QTWo0=;
	h=Subject:To:Cc:From:Date:From;
	b=x0LbQ9SqG+NlNLa+9VQCRpnmKa02sN2OZhRClrKlgrYlYra/t+0k0uMxiejTMXkXd
	 llw6ti7e/0+4aeJVmM8g7qjDqaPCT8RpPPT9WpAr5wLS+jcly0r6w7uJexlS4mG69V
	 reGc3p87R8IstGUV2nk2HLk/70n8Nmoiixi/Gw60=
Subject: FAILED: patch "[PATCH] futex: Clear stale exiting pointer in futex_lock_pi() retry" failed to apply to 6.6-stable tree
To: dave@stgolabs.net,tglx@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 11:40:33 +0200
Message-ID: <2026033033-common-quartet-fb0d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231100-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: A8EB935857B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 210d36d892de5195e6766c45519dfb1e65f3eb83
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033033-common-quartet-fb0d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 210d36d892de5195e6766c45519dfb1e65f3eb83 Mon Sep 17 00:00:00 2001
From: Davidlohr Bueso <dave@stgolabs.net>
Date: Wed, 25 Mar 2026 17:17:59 -0700
Subject: [PATCH] futex: Clear stale exiting pointer in futex_lock_pi() retry
 path

Fuzzying/stressing futexes triggered:

    WARNING: kernel/futex/core.c:825 at wait_for_owner_exiting+0x7a/0x80, CPU#11: futex_lock_pi_s/524

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
      futex_state = EXITING;
			     futex_lock_pi(uaddr)
			       futex_lock_pi_atomic()
				 attach_to_pi_owner()
				   // observes EXITING
				   *exiting = owner;  // takes ref
				   return -EBUSY
			       wait_for_owner_exiting(-EBUSY, owner)
				 put_task_struct();   // drops ref
			       // exiting still points to owner
			       goto retry;
			       futex_lock_pi_atomic()
				 lock_pi_update_atomic()
				   cmpxchg(uaddr)
					*uaddr ^= WAITERS // whatever
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

diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index bc1f7e83a37e..7808068fa59e 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -918,7 +918,7 @@ int fixup_pi_owner(u32 __user *uaddr, struct futex_q *q, int locked)
 int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int trylock)
 {
 	struct hrtimer_sleeper timeout, *to;
-	struct task_struct *exiting = NULL;
+	struct task_struct *exiting;
 	struct rt_mutex_waiter rt_waiter;
 	struct futex_q q = futex_q_init;
 	DEFINE_WAKE_Q(wake_q);
@@ -933,6 +933,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 	to = futex_setup_timer(time, &timeout, flags, 0);
 
 retry:
+	exiting = NULL;
 	ret = get_futex_key(uaddr, flags, &q.key, FUTEX_WRITE);
 	if (unlikely(ret != 0))
 		goto out;


