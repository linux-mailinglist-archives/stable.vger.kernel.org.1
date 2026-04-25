Return-Path: <stable+bounces-241116-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAs4IcuL7GndZgAAu9opvQ
	(envelope-from <stable+bounces-241116-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 11:39:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE18F465BA0
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 11:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69C693010DB6
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 09:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39B7390CA9;
	Sat, 25 Apr 2026 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPGIoVrG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4F738B12C
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777109927; cv=none; b=Etaoc1XkcaV70y1tNMFkC2qKKkR6kum3wryvBxQUu35M4PK+As4VVyVR19pkwFwt9hgGPhuM84un51jd+4qd7vMBC0lvL/daJWIw8uP1W3G9bOkwwLJgBcafYuqWkZvo9si0wub9pTsH0ZQ1e2S4YrLwvdLpWJxXCqG0o5oKA7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777109927; c=relaxed/simple;
	bh=REzEfWkN6tjWJaQ0H+RiUYIwoU83Xx0WygSxTrhFKbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oeu9ScPdXEjlnrrLx+w9Ml7ux9ocHBvOkVo4pNB58JystEtuufO14yk0xUPYdmYuFdV92tuVGiwV/EmZV//3MpXMeWZ8BARmwcnHLh1SHdptBIADlMxTmRhFhH02pOxUMtLw1+Nt1kxlUfMTHnmOLSiwpfSF1SWFS78ZIXwIl48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPGIoVrG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ab1c8fdc40so5610525ad.1
        for <stable@vger.kernel.org>; Sat, 25 Apr 2026 02:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777109925; x=1777714725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YB7okcDXB2f9QxPT6JpL0fC68gABv+vXaX5leb6ndF8=;
        b=lPGIoVrGN7TI1crvVpUmhZ40Qr/CNtZl+2iSetodNgtvJxnDfePjs5n/tqDLq0c9Bc
         KbRKOOhPUW+mfC/+LhfE1XjYFT1LQK0RVepG6ensH5hMZ+0jSYzKyr1OEpMAEx90lasi
         L5esQPmMYVDoczahnk5cxX1VEYdDRiqqm3smjPpWxBxQpWb/4RNv6dZzNu8MXF9+q2TZ
         ++bpqzN44WWwtmLD/VhXrDbmw3uAL2t9I0vYBLL4VDuAf+PAw76RQsmMDUtCXC4SUuEm
         TK8giTMLD+Cv9Q+NzJkRh/sWz9BeaPAAw8A2mpnTQSdigaksheUq7SgUisaW0IYydyAV
         PzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777109925; x=1777714725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YB7okcDXB2f9QxPT6JpL0fC68gABv+vXaX5leb6ndF8=;
        b=PzGZ0WFS8mooiUYQckTnRWwZKXsNcsk5GrJWNMS1DPBpGMnSCmSc1/VKi8W0p/xN1r
         ZJoU+tiuw4yJkRiy2hHgkCnrqf8zUTtKuQ31tyP0zeKas69M0CZDhIRTzsrnOfmaW2AQ
         HueI1B9/7PcvDvUmSUCsju2UEnwRhOqKOXDVQnxkgnZZr1Uv9oySacsjVvvNMvjEGbln
         8Fx/xJnBzled51PD2qmtcEEsxHxliCeMhxlMLJAmhnz8gLj4kmI80iFIdmmIyL6Xeefb
         uSUlqrg7ufFxGi9SwiH1qtvlbtJhlxFrux+NUJaQKoI1deEPQY8VmLHDvVjlTzqmuQBs
         HkFg==
X-Forwarded-Encrypted: i=1; AFNElJ+ZJo746vjcJWry+WxmhF/SMgOEJ4nIHLoj48JoisB62GRBbTPfNWra4j0tpeVXqWem0OoWDjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YztTza7xZzZ8gLpXHEHegMbPL+nLkzp8OZH8g1VXbuAIZBgPSCv
	qCO2If7wCH0avjxoVq9CXWklJfvDphaeG+6T1i+t8ELYySmTCAhCx3/M
X-Gm-Gg: AeBDietO0+c9wpnUNhXqNrH0+rDPV5dgFZFkEalk4GPFZJLqOxkdJsQe3mmmHZZ3DdQ
	Ckv5Hy8rl6x6Bq2/spgoWg+SV+22EAuwA7PxmLPpqYuvby2wPG8/ZZAfsXUV1T1fL2m/h8hYSMf
	Rr4zuruqlateAIXH3vLSx7AH74bvwkTiOpYa5em5F1R/K2Aa+T9DJm+bMXu6bKGpZFT4iz7OTQr
	ghiF9Tl7OjT7v429rOU/BcDzMORARIrzNlRjFq3mdbGcKty6RiWn7OhfSRPiOM4JeZpxoMwEy84
	xExxW8r2YPr63U53elt9GugF40F2pGEVR80Orez2P0tmre542Qqq4S8NXC93Z/3FuZlkVkN8RsN
	8McNE/w25+gjU8vJaVvER+NEn71eML7ySqVFw4yTQKwgCm2EbqWBeR0M/7Pdwg7xfozeZGGkJJt
	0/zpvxzG12M2zoPHqPB8JmEm3TkFo=
X-Received: by 2002:a17:903:3b88:b0:2b2:ac6f:104b with SMTP id d9443c01a7336-2b5f9e79f5bmr187610395ad.1.1777109925297;
        Sat, 25 Apr 2026 02:38:45 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b606ce9891sm206791725ad.83.2026.04.25.02.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 02:38:44 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 1/2] ksmbd: rewrite stop_sessions() with restartable iteration
Date: Sat, 25 Apr 2026 18:38:28 +0900
Message-ID: <20260425093829.4004785-2-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425093829.4004785-1-charsyam@gmail.com>
References: <20260425093829.4004785-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DE18F465BA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FREEMAIL_CC(0.00)[chromium.org,talpey.com,gmail.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241116-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[charsyam@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
---
 fs/smb/server/connection.c | 46 +++++++++++++++++++++++++++++++-------
 fs/smb/server/connection.h |  1 +
 2 files changed, 39 insertions(+), 8 deletions(-)

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
 
-	if (!hash_empty(conn_list)) {
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
-- 
2.43.0


