Return-Path: <stable+bounces-231450-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBwmOdXsy2mlMgYAu9opvQ
	(envelope-from <stable+bounces-231450-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:48:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E423C36C0D6
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 897E230ABB1F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E9E3E9598;
	Tue, 31 Mar 2026 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsVyblDw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46838413234
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971437; cv=none; b=fnd8Yl7HgiaMbxkaESLYiJUOczq2TTHY0gWToxGinIL9YOrKWdu6qKgjLm9YVmGj689BQiG27mXPfYDoii16ELp4v/WuD6GoWUky8RwbdfzF8gNZhERWSPJ7DElwKfMBaTjtGdhnWXicKQ4tEV0nC/+S84PMZ7aVRQrf6Zvi1Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971437; c=relaxed/simple;
	bh=Yb+PbtUMeEDqyWvZOoBcT6U6EFeoBjI81t+7Sf93/CM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZddpSpsypwZZslcNLWfBupujUir/w9RQ5dQ5nGwpDoUOP40FR4/POgMglrJ0eLFJ9lG4IjpA2YJYso3UD03LuBadf3lOIrzldJerXFN0Q8n3cEwPkFscA1srbs00uF/dC689eaRBP1CH1Il+TcOzwsTuTfCtHVHlGd9G90pALtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsVyblDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FC3C19423;
	Tue, 31 Mar 2026 15:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774971436;
	bh=Yb+PbtUMeEDqyWvZOoBcT6U6EFeoBjI81t+7Sf93/CM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TsVyblDwJksvRcrBR6egtgDuLQS2GxDKn7X9bx9SsXCr7ZHFPMz8ni1/202neD3EV
	 1v8bIGpeFSKreBmADpZVpO5Ew87VXL9EytyudUaC2yhRIiadPwQUVnLamllTKMqpSt
	 Wqf++J2tQicRwzFBU2Ahz826ZI+kKQMGuYRcX5jImJ9A3YOFGIAgvKSn4fGOigaVbg
	 d4nQjeh0CyndgeE1O6Z5PsT7LMIlLa9WdtjYPutEl2+qWmRbbCUvbU3sG2/Mjw+jRV
	 sdkD4oIYNwjOQNPp9vFTLccHhJY21ClPdrG5ov5SVmaV/bzYcMA1smYm6tPFNfpql5
	 UuDeU3Lv4eeFA==
From: Thomas Gleixner <tglx@kernel.org>
To: gregkh@linuxfoundation.org, dave@stgolabs.net
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6.y, 6.1.y] futex: Clear stale exiting pointer in
 futex_lock_pi() retry
In-Reply-To: <2026033033-common-quartet-fb0d@gregkh>
References: <2026033033-common-quartet-fb0d@gregkh>
Date: Tue, 31 Mar 2026 17:37:13 +0200
Message-ID: <875x6c9fiu.ffs@tglx>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231450-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: E423C36C0D6
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
 kernel/futex/pi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
---
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -930,9 +930,9 @@ int fixup_pi_owner(u32 __user *uaddr, st
 int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int trylock)
 {
 	struct hrtimer_sleeper timeout, *to;
-	struct task_struct *exiting = NULL;
 	struct rt_mutex_waiter rt_waiter;
 	struct futex_hash_bucket *hb;
+	struct task_struct *exiting;
 	struct futex_q q = futex_q_init;
 	int res, ret;
 
@@ -945,6 +945,7 @@ int futex_lock_pi(u32 __user *uaddr, uns
 	to = futex_setup_timer(time, &timeout, flags, 0);
 
 retry:
+	exiting = NULL;
 	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &q.key, FUTEX_WRITE);
 	if (unlikely(ret != 0))
 		goto out;

