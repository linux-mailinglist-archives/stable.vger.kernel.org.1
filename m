Return-Path: <stable+bounces-254748-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJuBCmv1F2q5WAgAu9opvQ
	(envelope-from <stable+bounces-254748-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:57:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A595EE1F8
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A8E7313B84D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 07:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773FB31F98B;
	Thu, 28 May 2026 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VCA7gCGq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EFD316905
	for <stable@vger.kernel.org>; Thu, 28 May 2026 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954732; cv=none; b=YmLKoFDP7NyTmHm5az5qNhknpxoJ52dvTR/6ofNoM9sAo6aLGmT2EfxGl13/to1yzSBTkNpNPzDy6a1W1SoRiRcWXaAnhgEbjVKMInLl3H1mBT0qUHCqJQ4RmDi8rjCafwPCA6WWf6D4y0iOUxZVRdFANlMI02jIbfz09VIeo08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954732; c=relaxed/simple;
	bh=o2cTQ7dVz0Cn4Tv3zjhGE3+4rUB/p/ChtRKWwsW3Fh0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=l0FoAxdEeh2mtH4UqFLgDPF1NTmpeRQ3SysdkI7JKSEk8lL03ojsCd5Fy1Z6rVWOic2Wi2X9COU2gxnTG15hf6v0tx3MW3CCUc/RzxAh7B0LFK8gFgwzFpFDkfA6QlFS18s35p+3S1UcP2MCxyuZE6Hh6ODYNlPvwUMLC/wUAS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VCA7gCGq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF46F1F000E9;
	Thu, 28 May 2026 07:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779954730;
	bh=2RD4zzJBUxjya73wEVpVrjLQIJQdCY68OvJbHGn95HY=;
	h=Subject:To:Cc:From:Date;
	b=VCA7gCGqjt0Ho9NxbtcMkE1u3/p2SYso1SitnuA6Do0sJ8IPL0IFFbr6Fr4Zr/O4R
	 sCJEdaBWq6xf304suqXrKHgOM3Z+QxfrEjattqOuab1TNgwUBZxaRGdO0c/oLg8REn
	 7VlDcnCi28pl1pLfTFaOJs1rwDRfgPgAKvpuZNX0=
Subject: FAILED: patch "[PATCH] Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs" failed to apply to 5.10-stable tree
To: safa.karakus@secunnix.com,luiz.von.dentz@intel.com,oss@fourdim.xyz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 09:51:09 +0200
Message-ID: <2026052809-colt-unlearned-fe00@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254748-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,secunnix.com:email,linuxfoundation.org:dkim,gregkh:email,intel.com:email]
X-Rspamd-Queue-Id: C1A595EE1F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ab1513597c6cf17cd1ad2a21e3b045421b48e022
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052809-colt-unlearned-fe00@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ab1513597c6cf17cd1ad2a21e3b045421b48e022 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Safa=20Karaku=C5=9F?= <safa.karakus@secunnix.com>
Date: Sat, 16 May 2026 21:15:04 +0300
Subject: [PATCH] Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs
 l2cap_conn_del()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

bt_accept_dequeue() unlinks a not-yet-accepted child from the parent
accept queue and release_sock()s it before returning, so the returned
sk has no caller reference and is unlocked.

l2cap_sock_cleanup_listen() walks these children on listening-socket
close.  A concurrent HCI disconnect drives hci_rx_work ->
l2cap_conn_del() which runs l2cap_chan_del() + l2cap_sock_kill() and
frees the child sk and its l2cap_chan; cleanup_listen() then uses both:

  BUG: KASAN: slab-use-after-free in l2cap_sock_kill
    l2cap_sock_kill / l2cap_sock_cleanup_listen / __x64_sys_close
  Freed by: l2cap_conn_del -> l2cap_sock_close_cb -> l2cap_sock_kill

This is distinct from the two fixes already in this area: commit
e83f5e24da741 ("Bluetooth: serialize accept_q access") serialises the
accept_q list/poll and takes temporary refs inside bt_accept_dequeue(),
and CVE-2025-39860 serialises the userspace close()/accept() race by
calling cleanup_listen() under lock_sock() in l2cap_sock_release().
Neither covers l2cap_conn_del() running from hci_rx_work, so this UAF
still reproduces on current bluetooth/master.

Take the reference at the source: bt_accept_dequeue() does sock_hold()
while sk is still locked, before release_sock(); callers sock_put().
cleanup_listen() pins the chan with l2cap_chan_hold_unless_zero() under
a brief child sk lock (serialising vs l2cap_sock_teardown_cb()), drops
it before l2cap_chan_lock(), and skips a duplicate l2cap_sock_kill() on
SOCK_DEAD.  conn->lock is not taken here: cleanup_listen() runs under
the parent sk lock and that would invert
conn->lock -> chan->lock -> sk_lock (lockdep).

KASAN/SMP: an unprivileged listen/close vs HCI-disconnect race produced
12 use-after-free reports per run before this change; 0, and no lockdep
report, over 1600+ raced iterations after it on bluetooth/master.

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Cc: stable@vger.kernel.org
Reported-by: Siwei Zhang <oss@fourdim.xyz>
Reviewed-by: Siwei Zhang <oss@fourdim.xyz>
Signed-off-by: Safa Karakuş <safa.karakus@secunnix.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 9d68dd86023c..1a6aa3f8d4d6 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -340,6 +340,16 @@ restart:
 			if (newsock)
 				sock_graft(sk, newsock);
 
+			/* Hand the caller a reference taken while sk is
+			 * still locked.  bt_accept_unlink() just dropped
+			 * the accept-queue reference; without this hold a
+			 * concurrent teardown (e.g. l2cap_conn_del() ->
+			 * l2cap_sock_kill()) could free sk between
+			 * release_sock() and the caller using it.  Every
+			 * caller drops this with sock_put() when done.
+			 */
+			sock_hold(sk);
+
 			release_sock(sk);
 			if (next)
 				sock_put(next);
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index b971281f0a2b..d7af617cda45 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -751,6 +751,8 @@ static void iso_sock_cleanup_listen(struct sock *parent)
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		iso_sock_close(sk);
 		iso_sock_kill(sk);
+		/* Drop the reference handed back by bt_accept_dequeue(). */
+		sock_put(sk);
 	}
 
 	/* If listening socket has a hcon, properly disconnect it */
@@ -1356,8 +1358,13 @@ static int iso_sock_accept(struct socket *sock, struct socket *newsock,
 		}
 
 		ch = bt_accept_dequeue(sk, newsock);
-		if (ch)
+		if (ch) {
+			/* Drop the bridging ref from bt_accept_dequeue();
+			 * the grafted socket keeps ch alive from here.
+			 */
+			sock_put(ch);
 			break;
+		}
 
 		if (!timeo) {
 			err = -EAGAIN;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index cf590a67d364..b34e7da8d906 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -349,8 +349,13 @@ static int l2cap_sock_accept(struct socket *sock, struct socket *newsock,
 		}
 
 		nsk = bt_accept_dequeue(sk, newsock);
-		if (nsk)
+		if (nsk) {
+			/* Drop the bridging ref from bt_accept_dequeue();
+			 * the grafted socket keeps nsk alive from here.
+			 */
+			sock_put(nsk);
 			break;
+		}
 
 		if (!timeo) {
 			err = -EAGAIN;
@@ -1475,22 +1480,54 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 	BT_DBG("parent %p state %s", parent,
 	       state_to_string(parent->sk_state));
 
-	/* Close not yet accepted channels */
+	/* Close not yet accepted channels.
+	 *
+	 * bt_accept_dequeue() now returns sk with an extra reference held
+	 * (taken while sk was still locked) so a concurrent l2cap_conn_del()
+	 * -> l2cap_sock_kill() cannot free sk under us.
+	 *
+	 * cleanup_listen() runs under the parent sk lock, so unlike
+	 * l2cap_sock_shutdown() we must NOT take conn->lock here: that would
+	 * establish sk_lock -> conn->lock and invert the established
+	 * conn->lock -> chan->lock -> sk_lock order (lockdep deadlock).
+	 *
+	 * Instead, briefly take the child sk lock to fetch and pin its chan.
+	 * l2cap_conn_del() reaches the chan free only via
+	 * l2cap_chan_del() -> l2cap_sock_teardown_cb(), which itself takes
+	 * the child sk lock; holding it across l2cap_chan_hold_unless_zero()
+	 * therefore guarantees the chan cannot be freed while we read and
+	 * pin it (hold_unless_zero() additionally skips a chan already past
+	 * its last reference).  We then drop the sk lock before taking
+	 * chan->lock, so sk and chan locks are never held together.
+	 */
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
-		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+		struct l2cap_chan *chan;
+
+		lock_sock_nested(sk, L2CAP_NESTING_NORMAL);
+		chan = l2cap_chan_hold_unless_zero(l2cap_pi(sk)->chan);
+		release_sock(sk);
+		if (!chan) {
+			/* l2cap_conn_del() already tearing this child down */
+			sock_put(sk);
+			continue;
+		}
 
 		BT_DBG("child chan %p state %s", chan,
 		       state_to_string(chan->state));
 
-		l2cap_chan_hold(chan);
 		l2cap_chan_lock(chan);
-
 		__clear_chan_timer(chan);
 		l2cap_chan_close(chan, ECONNRESET);
-		l2cap_sock_kill(sk);
-
+		/* l2cap_conn_del() may already have killed this socket
+		 * (it sets SOCK_DEAD); skip the duplicate to avoid a
+		 * double sock_put()/l2cap_chan_put().
+		 */
+		if (!sock_flag(sk, SOCK_DEAD))
+			l2cap_sock_kill(sk);
 		l2cap_chan_unlock(chan);
+
 		l2cap_chan_put(chan);
+		sock_put(sk);
 	}
 }
 
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index be6639cd6f59..bd7d959c6e9e 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -180,6 +180,8 @@ static void rfcomm_sock_cleanup_listen(struct sock *parent)
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		rfcomm_sock_close(sk);
 		rfcomm_sock_kill(sk);
+		/* Drop the reference handed back by bt_accept_dequeue(). */
+		sock_put(sk);
 	}
 
 	parent->sk_state  = BT_CLOSED;
@@ -497,8 +499,13 @@ static int rfcomm_sock_accept(struct socket *sock, struct socket *newsock,
 		}
 
 		nsk = bt_accept_dequeue(sk, newsock);
-		if (nsk)
+		if (nsk) {
+			/* Drop the bridging ref from bt_accept_dequeue();
+			 * the grafted socket keeps nsk alive from here.
+			 */
+			sock_put(nsk);
 			break;
+		}
 
 		if (!timeo) {
 			err = -EAGAIN;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index eba44525d41d..f1799c6a6f87 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -502,6 +502,8 @@ static void sco_sock_cleanup_listen(struct sock *parent)
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		sco_sock_close(sk);
 		sco_sock_kill(sk);
+		/* Drop the reference handed back by bt_accept_dequeue(). */
+		sock_put(sk);
 	}
 
 	parent->sk_state  = BT_CLOSED;
@@ -765,8 +767,13 @@ static int sco_sock_accept(struct socket *sock, struct socket *newsock,
 		}
 
 		ch = bt_accept_dequeue(sk, newsock);
-		if (ch)
+		if (ch) {
+			/* Drop the bridging ref from bt_accept_dequeue();
+			 * the grafted socket keeps ch alive from here.
+			 */
+			sock_put(ch);
 			break;
+		}
 
 		if (!timeo) {
 			err = -EAGAIN;


