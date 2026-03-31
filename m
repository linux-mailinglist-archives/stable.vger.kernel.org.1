Return-Path: <stable+bounces-231893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEkxHLsBzGk8NQYAu9opvQ
	(envelope-from <stable+bounces-231893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:17:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E8236E6EC
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE60631E33F9
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CDD42668F;
	Tue, 31 Mar 2026 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eqwUv1tH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789A1425CE0;
	Tue, 31 Mar 2026 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975339; cv=none; b=rkqKjq1GYyW2lRo9IElCE3qrdBqOHkBtg+nu+IjrofGDKNGP1fo2h50TA6Gfc1rGEhDMTt9j4esstrZC2S+/FJuzIMIkcdgdT83xwmakEeBcSGyZhf/f2nqSA7jcAjxTygXhER8Do9GVmy9BmPf0W90MwA9iUozqIwSwx7tIxp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975339; c=relaxed/simple;
	bh=PrOTm3UxiCBM8W0rKLWqIVcJbQzuSvrJSJMsREGwFt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xu9IkfmUmVwqwM+QCxaQ8lhYhdRa7HLwzq1w/Vkc5z5wcHC2f2QVGQN/QMDJg/gmCnhOtKyZpQxKP3rz1XbR2ftCwxmf3yOcB6hssDJato0/tRkVA1ohVBTCymoI9KcDYqkAR/E83pt1BQpf1hkiHkJ6zTGgo167SsjUJ8ZAvQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eqwUv1tH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B8BC19423;
	Tue, 31 Mar 2026 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975339;
	bh=PrOTm3UxiCBM8W0rKLWqIVcJbQzuSvrJSJMsREGwFt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eqwUv1tHuIrv8ePAbOxinhAK+uIg8xjdjKnKssuIpscFzUYNWXlQl1RR75vihSknP
	 jGjIGfQpJHIb0gFkF7/9RiNRf581UzLGf+IN1ILW4UobLcatlb7xA1OEihdaQWp/i6
	 6AlPBrT1w0m4VUxXGm2tL0TErTF0fAZVKyENNzPg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Davidlohr Bueso <dave@stgolabs.net>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH 6.19 256/342] futex: Clear stale exiting pointer in futex_lock_pi() retry path
Date: Tue, 31 Mar 2026 18:21:29 +0200
Message-ID: <20260331161808.374911530@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231893-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,stgolabs.net:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: E2E8236E6EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davidlohr Bueso <dave@stgolabs.net>

commit 210d36d892de5195e6766c45519dfb1e65f3eb83 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/futex/pi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -918,7 +918,7 @@ int fixup_pi_owner(u32 __user *uaddr, st
 int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int trylock)
 {
 	struct hrtimer_sleeper timeout, *to;
-	struct task_struct *exiting = NULL;
+	struct task_struct *exiting;
 	struct rt_mutex_waiter rt_waiter;
 	struct futex_q q = futex_q_init;
 	DEFINE_WAKE_Q(wake_q);
@@ -933,6 +933,7 @@ int futex_lock_pi(u32 __user *uaddr, uns
 	to = futex_setup_timer(time, &timeout, flags, 0);
 
 retry:
+	exiting = NULL;
 	ret = get_futex_key(uaddr, flags, &q.key, FUTEX_WRITE);
 	if (unlikely(ret != 0))
 		goto out;



