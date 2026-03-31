Return-Path: <stable+bounces-231453-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF5mOETvy2m5MgYAu9opvQ
	(envelope-from <stable+bounces-231453-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:59:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4269836C3D0
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07931312402C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DBA413258;
	Tue, 31 Mar 2026 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMS3f86P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6323D41B36B
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971584; cv=none; b=rJBPBMc0wkmpEsBIwidQW2iBOfN7CzlPkW1k2pdy1HQpGWGm6zJBylC/MKYVIHFFLxWghzAEOzHVW6pwM7LlTHGBlcVzr/FMtShO1EYtDfOBiKAt6Q9nJJCKVjz4w6xWFNOFSLuf5eQ9fUUIfU5UCPf9/exTZQ9Cr5D6CG+3KSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971584; c=relaxed/simple;
	bh=osElbW/uT3dhIbCgERqN13ChlHueSZNPb9IiJjEccK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o07vpHCQTSSHE1yEi3yUah+BFC4KTKQehhMDa3zl24UCO94290w3Nakntxpw9dOUKo7nW0kenBgTORAsaQk+9GoC6AuJFHm3/UBsyLPQtA4dIjfyIN/hSdQGpzgMdzAoGAvvQw77vkRNs8/O/p3em6wjp03Ev9efohS2+i/hQEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMS3f86P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658A5C19423;
	Tue, 31 Mar 2026 15:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774971584;
	bh=osElbW/uT3dhIbCgERqN13ChlHueSZNPb9IiJjEccK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LMS3f86PITCqrxHI9vMNZHUUYoDS3qxXa3yp385Ktbp5mkd6YVHt9FNnG/FAlVOrx
	 Vb8PmkLpzcZLNjYf+xSzYKnXfp43zdAvBVcl455Eu8QqZ7crhD7nt1QCrsFhoC9LXm
	 9jiJ3C5LTPotXYZKsZMC93G50zVL3LDgBqCnDF1cGhVL/LDFHwpQjMelxLdeVq1BuM
	 XA39I1ckI+EuS6eiWFuu4RPiBa8Mx+H0XIMEKq1sqq+pWHdqPOc2r98s13chna7pw6
	 qo4Dqej4ID9LSjmIUsmRZKkEPOUEUS6I8j0v9vxx11cWIPw0kxN/pMZLFlodIVqAQY
	 KivvfamZ61jKA==
From: Thomas Gleixner <tglx@kernel.org>
To: gregkh@linuxfoundation.org, dave@stgolabs.net
Cc: stable@vger.kernel.org
Subject: [PATCH 5.10.y] futex: Clear stale exiting pointer in
 futex_lock_pi() retry
In-Reply-To: <2026033035-underrate-yogurt-49bf@gregkh>
References: <2026033035-underrate-yogurt-49bf@gregkh>
Date: Tue, 31 Mar 2026 17:39:40 +0200
Message-ID: <87wlys80ub.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231453-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.968];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,stgolabs.net:email]
X-Rspamd-Queue-Id: 4269836C3D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


From: Davidlohr Bueso <dave@stgolabs.net>

Commit 210d36d892de5195e6766c45519dfb1e65f3eb83 upstream.

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
---
 kernel/futex/core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
---
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -2785,9 +2785,9 @@ static int futex_lock_pi(u32 __user *uad
 			 ktime_t *time, int trylock)
 {
 	struct hrtimer_sleeper timeout, *to;
-	struct task_struct *exiting = NULL;
 	struct rt_mutex_waiter rt_waiter;
 	struct futex_hash_bucket *hb;
+	struct task_struct *exiting;
 	struct futex_q q = futex_q_init;
 	int res, ret;
 
@@ -2800,6 +2800,7 @@ static int futex_lock_pi(u32 __user *uad
 	to = futex_setup_timer(time, &timeout, FLAGS_CLOCKRT, 0);
 
 retry:
+	exiting = NULL;
 	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &q.key, FUTEX_WRITE);
 	if (unlikely(ret != 0))
 		goto out;

