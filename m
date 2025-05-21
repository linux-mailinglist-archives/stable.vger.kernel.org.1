Return-Path: <stable+bounces-145849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1C4ABF831
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993391BA68DA
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DE11E0DE3;
	Wed, 21 May 2025 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECX7TZ99"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70701DFE00;
	Wed, 21 May 2025 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747838981; cv=none; b=AjE8SP0CYfcXP5E+eIIlUmkyLGmbDMDFgY7E5aUVqT3tO7EWIJITmpTT39f5cRDNJmhFKmU0nvqFxKbhBik5kLJU9+pEkMVUQl7P5NUE6FkRgT8uQuKyOGnJ1qdlrnuqVuVUTXth/+t3dK61gvwH7V+bfvZmAEdaBoHZ/ZOy/J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747838981; c=relaxed/simple;
	bh=8cUgHkvbHACk8fUQ4pXuXawjYvAU50wseEwUIO8WWiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWTiVNmk6ej/PViqH4ML56zCrpdCivVbdOTruvSQpKko/1rJz8j+55880GG0JQ0vcI2eeKYVc8QSLW7+KLQ3hB7F65pseDEScVQ0KH2TZIMZJWpQVUnoa+6ir7Z571CzSFqPgM6rj+q/KnVI7idafXhtRPE6fzXM6h7+Wf4inBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECX7TZ99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3752C4CEE7;
	Wed, 21 May 2025 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747838981;
	bh=8cUgHkvbHACk8fUQ4pXuXawjYvAU50wseEwUIO8WWiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ECX7TZ99lYeXrVdC/eZYbpAKd6IXJ1GYGe0ioZsWS70TqeDy2y5NE0tvC8/avdjPP
	 /+mknFhO2/CYvPhN3N8K4gM3y3SKRi48yWL8SNB5eEOGPYfhaqdsQ2s0PHYxT1Yzy/
	 oZ/+olspbDC39tCyy/8iOFcPUsJo/Afm/I0Rr5Bji2b28Bi5XlgZGcfVwaMVOWBDsK
	 xiL1QeXqkJCQTd8Xdnq0Ad8OOPMjomkEpD+CXobnlJQO1hKU1sRQTToADNP31uq0Bc
	 6Rurev9TLI4UkipSSWmCBzyGwNUkw7AS1gV/9Nry3Pl2xeqYnuWrnpgpXvJvT60JgG
	 PI0iOgBM+flbQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Rao Shoaib <Rao.Shoaib@oracle.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v6.6 02/26] af_unix: Run GC on only one CPU.
Date: Wed, 21 May 2025 14:45:10 +0000
Message-ID: <20250521144803.2050504-3-lee@kernel.org>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
In-Reply-To: <20250521144803.2050504-1-lee@kernel.org>
References: <20250521144803.2050504-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 8b90a9f819dc2a06baae4ec1a64d875e53b824ec ]

If more than 16000 inflight AF_UNIX sockets exist and the garbage
collector is not running, unix_(dgram|stream)_sendmsg() call unix_gc().
Also, they wait for unix_gc() to complete.

In unix_gc(), all inflight AF_UNIX sockets are traversed at least once,
and more if they are the GC candidate.  Thus, sendmsg() significantly
slows down with too many inflight AF_UNIX sockets.

There is a small window to invoke multiple unix_gc() instances, which
will then be blocked by the same spinlock except for one.

Let's convert unix_gc() to use struct work so that it will not consume
CPUs unnecessarily.

Note WRITE_ONCE(gc_in_progress, true) is moved before running GC.
If we leave the WRITE_ONCE() as is and use the following test to
call flush_work(), a process might not call it.

    CPU 0                                     CPU 1
    ---                                       ---
                                              start work and call __unix_gc()
    if (work_pending(&unix_gc_work) ||        <-- false
        READ_ONCE(gc_in_progress))            <-- false
            flush_work();                     <-- missed!
	                                      WRITE_ONCE(gc_in_progress, true)

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20240123170856.41348-5-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 8b90a9f819dc2a06baae4ec1a64d875e53b824ec)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/unix/garbage.c | 54 +++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 38639766b9e7c..a2a8543613a52 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -86,7 +86,6 @@
 /* Internal data structures and random procedures: */
 
 static LIST_HEAD(gc_candidates);
-static DECLARE_WAIT_QUEUE_HEAD(unix_gc_wait);
 
 static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
 			  struct sk_buff_head *hitlist)
@@ -182,23 +181,8 @@ static void inc_inflight_move_tail(struct unix_sock *u)
 }
 
 static bool gc_in_progress;
-#define UNIX_INFLIGHT_TRIGGER_GC 16000
-
-void wait_for_unix_gc(void)
-{
-	/* If number of inflight sockets is insane,
-	 * force a garbage collect right now.
-	 * Paired with the WRITE_ONCE() in unix_inflight(),
-	 * unix_notinflight() and gc_in_progress().
-	 */
-	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
-	    !READ_ONCE(gc_in_progress))
-		unix_gc();
-	wait_event(unix_gc_wait, !READ_ONCE(gc_in_progress));
-}
 
-/* The external entry point: unix_gc() */
-void unix_gc(void)
+static void __unix_gc(struct work_struct *work)
 {
 	struct sk_buff *next_skb, *skb;
 	struct unix_sock *u;
@@ -209,13 +193,6 @@ void unix_gc(void)
 
 	spin_lock(&unix_gc_lock);
 
-	/* Avoid a recursive GC. */
-	if (gc_in_progress)
-		goto out;
-
-	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
-	WRITE_ONCE(gc_in_progress, true);
-
 	/* First, select candidates for garbage collection.  Only
 	 * in-flight sockets are considered, and from those only ones
 	 * which don't have any external reference.
@@ -346,8 +323,31 @@ void unix_gc(void)
 	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
 	WRITE_ONCE(gc_in_progress, false);
 
-	wake_up(&unix_gc_wait);
-
- out:
 	spin_unlock(&unix_gc_lock);
 }
+
+static DECLARE_WORK(unix_gc_work, __unix_gc);
+
+void unix_gc(void)
+{
+	WRITE_ONCE(gc_in_progress, true);
+	queue_work(system_unbound_wq, &unix_gc_work);
+}
+
+#define UNIX_INFLIGHT_TRIGGER_GC 16000
+
+void wait_for_unix_gc(void)
+{
+	/* If number of inflight sockets is insane,
+	 * force a garbage collect right now.
+	 *
+	 * Paired with the WRITE_ONCE() in unix_inflight(),
+	 * unix_notinflight(), and __unix_gc().
+	 */
+	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
+	    !READ_ONCE(gc_in_progress))
+		unix_gc();
+
+	if (READ_ONCE(gc_in_progress))
+		flush_work(&unix_gc_work);
+}
-- 
2.49.0.1112.g889b7c5bd8-goog


