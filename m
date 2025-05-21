Return-Path: <stable+bounces-145868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6504ABF876
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE42502449
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E2621FF2C;
	Wed, 21 May 2025 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRLakpgY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD841FF1AD;
	Wed, 21 May 2025 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839127; cv=none; b=HRyU7HYjq8AzqwBE+njI/fACWFRox+4E0d6em/atUnXterALWHjPUgRk3TFmCduXxXAMTudfKhND1Qgt7FMqcP3f/xLVVcGvdIcyBEuHRhDzzkn2jUKqN8uc2Gm/d8AzCEaQcMjHOxkVpEb3n7SuI2I0u/MyT7kidYFvfuqxBOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839127; c=relaxed/simple;
	bh=4L+lwrX7Ae12v/jarUE4TloDXL3LKGUzaohCqpphWOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sm5hyyCxQTgpdEXgz85dhRFhE3EG/JI3+kibwcE6bpD0/lndt3cDIDMl7Tv/S5D8L+mFp0U+LK+MqRA+FZqyn4YjC9BYK+xPZdIoJoHKeINWVbA1cjH/PjQLwY2WmcQf1TbW/LTDGfUaNKM7XcpB1t/jwYWE2l0JJ8qCvbNtnks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRLakpgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE2EC4CEE4;
	Wed, 21 May 2025 14:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747839126;
	bh=4L+lwrX7Ae12v/jarUE4TloDXL3LKGUzaohCqpphWOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iRLakpgYlPRd+vrbXrsoGQ6O3WJBkVTG8QOywgEY5A9sSM1jTOsGWyus5Jn/XDYsF
	 JLcj21efniPjGKnoTurmn8TzHRqrSBDCr1uy8tAmBMZVyQBPl7ZsI/aBFdDi6dpqW1
	 gLevInVrC+vzqSkjBSpd0YIkT29rpWoB2OpQZtj3m6QtWKWJds+iwAB35DZKsPIxRn
	 4h63CXQEmTdBfrpprJBxa5Ql8EPkqeHkxubnDa1cv4R46kbgXbE4C+ypQKKqdiB0Xt
	 nSP1ujjQ8b20juYC5D1fkOzfIjAhKRpwN4NvzCj3KA2gLouM/7A2OmjY8QpJhgtPAd
	 oYVpI1jDkxjfw==
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
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v6.6 21/26] af_unix: Remove lock dance in unix_peek_fds().
Date: Wed, 21 May 2025 14:45:29 +0000
Message-ID: <20250521144803.2050504-22-lee@kernel.org>
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

[ Upstream commit 118f457da9ed58a79e24b73c2ef0aa1987241f0e ]

In the previous GC implementation, the shape of the inflight socket
graph was not expected to change while GC was in progress.

MSG_PEEK was tricky because it could install inflight fd silently
and transform the graph.

Let's say we peeked a fd, which was a listening socket, and accept()ed
some embryo sockets from it.  The garbage collection algorithm would
have been confused because the set of sockets visited in scan_inflight()
would change within the same GC invocation.

That's why we placed spin_lock(&unix_gc_lock) and spin_unlock() in
unix_peek_fds() with a fat comment.

In the new GC implementation, we no longer garbage-collect the socket
if it exists in another queue, that is, if it has a bridge to another
SCC.  Also, accept() will require the lock if it has edges.

Thus, we need not do the complicated lock dance.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20240401173125.92184-3-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 118f457da9ed58a79e24b73c2ef0aa1987241f0e)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/net/af_unix.h |  1 -
 net/unix/af_unix.c    | 42 ------------------------------------------
 net/unix/garbage.c    |  2 +-
 3 files changed, 1 insertion(+), 44 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index d88ca51a9081d..47042de4a2a9c 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -17,7 +17,6 @@ static inline struct unix_sock *unix_get_socket(struct file *filp)
 }
 #endif
 
-extern spinlock_t unix_gc_lock;
 extern unsigned int unix_tot_inflight;
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver);
 void unix_del_edges(struct scm_fp_list *fpl);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index eee0bccd7877b..df70d8a7ee837 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1796,48 +1796,6 @@ static void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
 {
 	scm->fp = scm_fp_dup(UNIXCB(skb).fp);
-
-	/*
-	 * Garbage collection of unix sockets starts by selecting a set of
-	 * candidate sockets which have reference only from being in flight
-	 * (total_refs == inflight_refs).  This condition is checked once during
-	 * the candidate collection phase, and candidates are marked as such, so
-	 * that non-candidates can later be ignored.  While inflight_refs is
-	 * protected by unix_gc_lock, total_refs (file count) is not, hence this
-	 * is an instantaneous decision.
-	 *
-	 * Once a candidate, however, the socket must not be reinstalled into a
-	 * file descriptor while the garbage collection is in progress.
-	 *
-	 * If the above conditions are met, then the directed graph of
-	 * candidates (*) does not change while unix_gc_lock is held.
-	 *
-	 * Any operations that changes the file count through file descriptors
-	 * (dup, close, sendmsg) does not change the graph since candidates are
-	 * not installed in fds.
-	 *
-	 * Dequeing a candidate via recvmsg would install it into an fd, but
-	 * that takes unix_gc_lock to decrement the inflight count, so it's
-	 * serialized with garbage collection.
-	 *
-	 * MSG_PEEK is special in that it does not change the inflight count,
-	 * yet does install the socket into an fd.  The following lock/unlock
-	 * pair is to ensure serialization with garbage collection.  It must be
-	 * done between incrementing the file count and installing the file into
-	 * an fd.
-	 *
-	 * If garbage collection starts after the barrier provided by the
-	 * lock/unlock, then it will see the elevated refcount and not mark this
-	 * as a candidate.  If a garbage collection is already in progress
-	 * before the file count was incremented, then the lock/unlock pair will
-	 * ensure that garbage collection is finished before progressing to
-	 * installing the fd.
-	 *
-	 * (*) A -> B where B is on the queue of A or B is on the queue of C
-	 * which is on the queue of listening socket A.
-	 */
-	spin_lock(&unix_gc_lock);
-	spin_unlock(&unix_gc_lock);
 }
 
 static void unix_destruct_scm(struct sk_buff *skb)
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 89ea71d9297ba..12a4ec27e0d4d 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -183,7 +183,7 @@ static void unix_free_vertices(struct scm_fp_list *fpl)
 	}
 }
 
-DEFINE_SPINLOCK(unix_gc_lock);
+static DEFINE_SPINLOCK(unix_gc_lock);
 unsigned int unix_tot_inflight;
 
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
-- 
2.49.0.1112.g889b7c5bd8-goog


