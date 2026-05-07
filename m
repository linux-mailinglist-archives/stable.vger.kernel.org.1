Return-Path: <stable+bounces-244547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA65D6lo/Gn0PgAAu9opvQ
	(envelope-from <stable+bounces-244547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 12:25:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 982674E6C2B
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 12:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D9F23012C6E
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BCF3E9286;
	Thu,  7 May 2026 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GyEfxfZd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6113C0600
	for <stable@vger.kernel.org>; Thu,  7 May 2026 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778149530; cv=none; b=RvFyxbgcNC+Y3IhIl7dg+KEwfon5OBKr+6MnjpVFKRHDsH4RPNVhiuuzbv4HHUmMGdQl99WVYHHP7fKiqCcgToBGq+KAnoZTtUS5p82ryrY8n+WNiXopxPeEwCyUKx2ACbf1xWa4Eq8ImZUhtzKvvWHdpryNmRybMO6LtVaAVHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778149530; c=relaxed/simple;
	bh=CGNEfqG3oQIByaFDaavAgFGAywFYEzTkTu61Q4tgqrI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LZ3NbELRlLDV6XlHX8xHCkEHmOr+uNwENw01tyacKHEWM49pXkdEfY+lJZyQDHAcxljMoa37ou43f4Mu6a2d4CeyI/0o8nYTBwpFCI75Bq22Q+Mq3jrYnfxBGt0J9MKsdYynShFS+T2rOi0f5aoZSNMGoxjHij1GVSt+T0A38no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GyEfxfZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D488C2BCB2;
	Thu,  7 May 2026 10:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778149529;
	bh=CGNEfqG3oQIByaFDaavAgFGAywFYEzTkTu61Q4tgqrI=;
	h=Subject:To:Cc:From:Date:From;
	b=GyEfxfZd2sVGm78EN7Uj2/j5aYI9ebYL2Vkynbq+W4Bl6F24x2TqxHyhW0YEUMOMH
	 0V1b77+enUYnPt0Nd2Witd65izR7e0fWfVuOMNxi1RPPDWRr2QlxCA/74XZEqUS9ur
	 Wao5lcCU43YS5V38qvXy1efl0Q3P9DeBMNCikor0=
Subject: FAILED: patch "[PATCH] ksmbd: rewrite stop_sessions() with restartable iteration" failed to apply to 5.15-stable tree
To: charsyam@gmail.com,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 07 May 2026 12:25:24 +0200
Message-ID: <2026050724-tricolor-shiftless-e1fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 982674E6C2B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244547-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,microsoft.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c444139cb747bf6de1922b39900fdf02281490f4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050724-tricolor-shiftless-e1fa@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c444139cb747bf6de1922b39900fdf02281490f4 Mon Sep 17 00:00:00 2001
From: DaeMyung Kang <charsyam@gmail.com>
Date: Sat, 25 Apr 2026 18:38:28 +0900
Subject: [PATCH] ksmbd: rewrite stop_sessions() with restartable iteration

stop_sessions() walks conn_list with hash_for_each() and, for every
entry, drops conn_list_lock across the transport ->shutdown() call
before re-acquiring the read lock to continue the loop.  The hash
walk relies on cross-iteration state (the current bucket and the
hlist position), which is not preserved across unlock/relock: if
another thread performs a list mutation during the unlocked window,
the ongoing iteration becomes unreliable and can re-visit
connections that have already been handled or skip connections that
have not.  The outer `if (!hash_empty(conn_list)) goto again;` retry
masks the symptom in the common case but does not address the
unsafe iteration itself.

Reframe the loop so it never relies on iterator state across
unlock/relock.  Under conn_list_lock held for read, pick the first
connection whose ->shutdown() has not yet been issued by this path,
pin it by taking an extra reference, record that fact on the
connection and mark it EXITING while still inside the locked walk,
then drop the lock.  Then call ->shutdown() outside the lock, drop
the pin (freeing the connection if the handler already released its
reference), and restart from the top.

Use a new per-connection flag, conn->stop_called, as the "shutdown
issued from stop_sessions()" marker rather than reusing the status
state.  ksmbd_conn_set_exiting() is also invoked by
ksmbd_sessions_deregister() on sibling channels of a multichannel
session without issuing a transport shutdown, so treating
KSMBD_SESS_EXITING as "already handled here" would skip connections
that still need shutdown() to wake their handler out of recv(),
leaving the outer retry waiting indefinitely for the hash to drain.
stop_sessions() is serialised by init_lock in
ksmbd_conn_transport_destroy(), so writing stop_called under the
read lock has no other writer.

Set EXITING inside the locked walk so the selection, the stop_called
marker, and the status transition all happen together, and guard
against regressing a connection that has already advanced to
KSMBD_SESS_RELEASING on its own (for example, if the handler exited
its receive loop for an unrelated reason between teardown steps).

When the pin drop is the last put, release the transport and pair
ida_destroy(&target->async_ida) with the ida_init() done in
ksmbd_conn_alloc(), so stop_sessions() retiring a connection on its
own does not leak the xarray backing of the embedded async_ida.

The outer retry with msleep() is kept to wait for handler threads to
reach ksmbd_conn_free() and drain the hash.

Observed with an instrumented build that logs one line per visit and
widens the unlocked window before ->shutdown() by 200 ms, under
five concurrent cifs mounts (nosharesock, one connection each):

  * Current code: the same connection address is revisited many
    times during a single stop_sessions() call and ->shutdown() is
    invoked well beyond the number of live connections before the
    hash finally drains.

  * Rewritten code: each live connection produces exactly one
    ->shutdown() call; the function returns as soon as the hash is
    empty.

Functional teardown via `ksmbd.control --shutdown` with the same
five mounts completes cleanly on the rewritten path.

Performance is observably unchanged.  Tearing down N concurrent
nosharesock cifs connections with `ksmbd.control --shutdown` +
`rmmod ksmbd` takes essentially the same wall time before and after
the rewrite:

    N        before        after
    10       4.93s         5.34s
    30       7.34s         7.03s
    50       7.31s         7.01s     (3-run avg: 7.04s vs 7.25s)
   100       6.98s         6.78s
   200       6.77s         6.89s

and the number of ->shutdown() calls equals the number of live
connections on both paths when the race is not widened.  The
teardown is dominated by the msleep(100)-based outer retry waiting
for handler threads to run ksmbd_conn_free(), not by the iteration
itself; the restartable loop's worst-case O(N^2) visit cost is in
the microseconds even at N=200 and sits far below the msleep(100)
granularity.

Applied alone on top of ksmbd-for-next-next, this patch does not
introduce a new leak site.  Under the same reproducer (10x
concurrent-holders + ss -K + ksmbd.control --shutdown + rmmod), the
tree still shows the pre-existing per-connection transport leak
count that arises when the last refcount drop lands in one of
ksmbd_conn_r_count_dec(), __free_opinfo() or session_fd_check() -
all of which end with a bare kfree() today.  kmemleak backtraces
for the unreferenced objects point into the TCP accept path
(sk_clone -> inet_csk_clone_lock, sock_alloc_inode) and none
involve stop_sessions().  Plugging those bare-kfree sites is the
responsibility of the follow-up patch.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index fbbc0529743f..c5aac4946cbe 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -540,24 +540,54 @@ int ksmbd_conn_transport_init(void)
 
 static void stop_sessions(void)
 {
-	struct ksmbd_conn *conn;
+	struct ksmbd_conn *conn, *target;
 	struct ksmbd_transport *t;
+	bool any;
 	int bkt;
 
+	/*
+	 * Serialised via init_lock; no concurrent stop_sessions() can
+	 * touch conn->stop_called, so writing it under the read lock is
+	 * safe.
+	 */
 again:
+	target = NULL;
+	any = false;
 	down_read(&conn_list_lock);
 	hash_for_each(conn_list, bkt, conn, hlist) {
-		t = conn->transport;
-		ksmbd_conn_set_exiting(conn);
-		if (t->ops->shutdown) {
-			up_read(&conn_list_lock);
-			t->ops->shutdown(t);
-			down_read(&conn_list_lock);
-		}
+		any = true;
+		if (conn->stop_called)
+			continue;
+		atomic_inc(&conn->refcnt);
+		conn->stop_called = true;
+		/*
+		 * Mark the connection EXITING while still holding the
+		 * read lock so the selection and the status transition
+		 * happen together.  Do not regress a connection that has
+		 * already advanced to RELEASING on its own (e.g. the
+		 * handler exited its receive loop for an unrelated
+		 * reason).
+		 */
+		if (READ_ONCE(conn->status) != KSMBD_SESS_RELEASING)
+			ksmbd_conn_set_exiting(conn);
+		target = conn;
+		break;
 	}
 	up_read(&conn_list_lock);
 
-	if (!hash_empty(conn_list)) {
+	if (target) {
+		t = target->transport;
+		if (t->ops->shutdown)
+			t->ops->shutdown(t);
+		if (atomic_dec_and_test(&target->refcnt)) {
+			ida_destroy(&target->async_ida);
+			t->ops->free_transport(t);
+			kfree(target);
+		}
+		goto again;
+	}
+
+	if (any) {
 		msleep(100);
 		goto again;
 	}
diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
index ae21a1bd4c70..de2d46941c93 100644
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -49,6 +49,7 @@ struct ksmbd_conn {
 	struct mutex			srv_mutex;
 	int				status;
 	unsigned int			cli_cap;
+	bool				stop_called;
 	union {
 		__be32			inet_addr;
 #if IS_ENABLED(CONFIG_IPV6)


