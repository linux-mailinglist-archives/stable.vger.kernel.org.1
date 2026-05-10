Return-Path: <stable+bounces-245066-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMijAt/jAGqIOAEAu9opvQ
	(envelope-from <stable+bounces-245066-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 22:00:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41775506211
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 22:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D6B2300DE1F
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 20:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AEB2248A0;
	Sun, 10 May 2026 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkWZTouL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770D81607A4
	for <stable@vger.kernel.org>; Sun, 10 May 2026 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778443220; cv=none; b=bL/TV2uY8rg7Kn2J9WW1RczHoJaEZD1E+P2D9iXa+ndPLAOzI5NOZzKsPOnuSEg+Q6vdksU6AMt8ObYHWh24HJ/1BeHHJymt3TQba+9SUsYXxTDSym7qROs+hxhzpgorX8kacLMNxF5h9PVMUmNBrSAXk3nYKi7MnWuJmYkPfdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778443220; c=relaxed/simple;
	bh=sgzAEVuFl/NMWX55t3QZ/8r+ssy8LTP2amnu56WbgIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miDRjs3Na1fVpmu2UjMv4Ek8sjxDF7dYISlmOOny56AoeAHBWhnfMnQ7kLTc8SYRvMnJEJn/bpPoHV/0uMQmY5BbkIR/tohUCEzksgqAKG6U5OVUjHikgx/WzZ3rnBYUWUbBv5ghOwF/RqQLAR0kXrzMQcV7clof77oQgZzhwnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkWZTouL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBBEC2BCB8;
	Sun, 10 May 2026 20:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778443220;
	bh=sgzAEVuFl/NMWX55t3QZ/8r+ssy8LTP2amnu56WbgIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qkWZTouLEkguINp8hePf8jPNjtFlcUpdrlO2dTfzOQQWzPj+TzC88sHKbv3gBxBvT
	 rRqg1EUsNRuri393cly2xOx7F/xeKufogDUa9wIFSsiN5Vkp2kyPmojuWVLdeDCGbA
	 PXjnqTsyHellG7WldE1/52SeeuSnIcHLSdnxBMXQyF+8QNCCkZMHWM6us7RElKmjoC
	 F1WTQjIVfPOp1lCuBmyJsG/BDRvExbghCvDllLiBARLt6T0bvbj0JJZnNtge/6BGeE
	 fNi+mdd5m16EarCTDBQzcU2/dNKER61LP/5WthQBG+1/suSYg5TODkj/MqEwlyb35C
	 8QVfoQxOli6xw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: DaeMyung Kang <charsyam@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: rewrite stop_sessions() with restartable iteration
Date: Sun, 10 May 2026 16:00:16 -0400
Message-ID: <20260510200017.599429-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050720-idealist-crayon-e443@gregkh>
References: <2026050720-idealist-crayon-e443@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 41775506211
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245066-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: DaeMyung Kang <charsyam@gmail.com>

[ Upstream commit c444139cb747bf6de1922b39900fdf02281490f4 ]

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
[ kept list_for_each_entry iteration and schedule_timeout_interruptible(HZ/10) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/connection.c | 46 +++++++++++++++++++++++++++++++-------
 fs/smb/server/connection.h |  1 +
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 907ddfc2c2c1d..51e7e7042fb05 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -478,23 +478,53 @@ int ksmbd_conn_transport_init(void)
 
 static void stop_sessions(void)
 {
-	struct ksmbd_conn *conn;
+	struct ksmbd_conn *conn, *target;
 	struct ksmbd_transport *t;
+	bool any;
 
+	/*
+	 * Serialised via init_lock; no concurrent stop_sessions() can
+	 * touch conn->stop_called, so writing it under the read lock is
+	 * safe.
+	 */
 again:
+	target = NULL;
+	any = false;
 	down_read(&conn_list_lock);
 	list_for_each_entry(conn, &conn_list, conns_list) {
-		t = conn->transport;
-		ksmbd_conn_set_exiting(conn);
-		if (t->ops->shutdown) {
-			up_read(&conn_list_lock);
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
+	}
+	up_read(&conn_list_lock);
+
+	if (target) {
+		t = target->transport;
+		if (t->ops->shutdown)
 			t->ops->shutdown(t);
-			down_read(&conn_list_lock);
+		if (atomic_dec_and_test(&target->refcnt)) {
+			ida_destroy(&target->async_ida);
+			t->ops->free_transport(t);
+			kfree(target);
 		}
+		goto again;
 	}
-	up_read(&conn_list_lock);
 
-	if (!list_empty(&conn_list)) {
+	if (any) {
 		schedule_timeout_interruptible(HZ / 10); /* 100ms */
 		goto again;
 	}
diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
index 45421269ddd88..e196f723358ef 100644
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -46,6 +46,7 @@ struct ksmbd_conn {
 	struct mutex			srv_mutex;
 	int				status;
 	unsigned int			cli_cap;
+	bool				stop_called;
 	union {
 		__be32			inet_addr;
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.53.0


