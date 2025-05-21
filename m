Return-Path: <stable+bounces-145852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A5DABF83C
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE72F9E26B6
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C0C1E9B0F;
	Wed, 21 May 2025 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNYPAGbc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A9C1537C6;
	Wed, 21 May 2025 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839004; cv=none; b=ovuY+y4U73ICaEcKVkedmWorBGqqfLA65vgH3obViGtti/gGnPLxWOzwLZEst53BFyXVDX6vI5rZlKAoP3NY8XvR04iIXfclQ+ZpgTGkle+kWDzt8YXNuDmbRIPCBxiqNqsFxUcXMnuOKt1ZzbMImPkUvG1ap8TPSVTcXhXtJBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839004; c=relaxed/simple;
	bh=B1YJC4noCJYqbdluweLPdw+nQEa22mlM+03uMJzYTds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzVdUYmGhr06AypD2brzdOFYcNjCFCYc619rjsx7Bzc2Of6cy1NzgrlWSdBfEkPOSNNJ3sGkgv2g5sDNZHN4+G0WllaIEPfN6ov0nFVuHGw6ulTFgeJPQe49IErUpowCTGwg4Imx17uMAvPX+KeuxnDM0NgIucnLaEGt0jVuGU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNYPAGbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8FFC4CEE7;
	Wed, 21 May 2025 14:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747839003;
	bh=B1YJC4noCJYqbdluweLPdw+nQEa22mlM+03uMJzYTds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hNYPAGbcvyjW/w+X/fTLuLiCDvKe6XIz/72ic2ZmMq6ElgLLLHimqLq2YOusc0Onu
	 HYVpDVEg2gjbHFiV8rek2tg1jRA2mH5yEeHkfcI61qDqL8Stv8BFciWGliECEMjEVS
	 Y3GzYzyTDTUp7A38+zk8ZAVIJPaOnjfql0UeRBXns/T1ivg3tLOiqu1IhLHef70TfF
	 qsyrVa3gDs41g8/gA7cKELCKgZOrdYkTaWnv1bUdMPvY7DyQuSO9jbgAFSqHyeaMA2
	 bp6ouutlNi8BgzTPfYQRVxpXJI/e3LKaMEBeTl4XlLaRdQS9hPjAuhvBf/klgrJWu+
	 7BX0eC5388Cww==
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
Subject: [PATCH v6.6 05/26] af_unix: Remove io_uring code for GC.
Date: Wed, 21 May 2025 14:45:13 +0000
Message-ID: <20250521144803.2050504-6-lee@kernel.org>
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

[ Upstream commit 11498715f266a3fb4caabba9dd575636cbcaa8f1 ]

Since commit 705318a99a13 ("io_uring/af_unix: disable sending
io_uring over sockets"), io_uring's unix socket cannot be passed
via SCM_RIGHTS, so it does not contribute to cyclic reference and
no longer be candidate for garbage collection.

Also, commit 6e5e6d274956 ("io_uring: drop any code related to
SCM_RIGHTS") cleaned up SCM_RIGHTS code in io_uring.

Let's do it in AF_UNIX as well by reverting commit 0091bfc81741
("io_uring/af_unix: defer registered files gc to io_uring release")
and commit 10369080454d ("net: reclaim skb->scm_io_uring bit").

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Jens Axboe <axboe@kernel.dk>
Link: https://lore.kernel.org/r/20240129190435.57228-3-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 11498715f266a3fb4caabba9dd575636cbcaa8f1)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/net/af_unix.h |  1 -
 net/unix/garbage.c    | 25 ++-----------------------
 net/unix/scm.c        |  6 ------
 3 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 865e2f7bd67cf..4d35204c08570 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -20,7 +20,6 @@ static inline struct unix_sock *unix_get_socket(struct file *filp)
 void unix_inflight(struct user_struct *user, struct file *fp);
 void unix_notinflight(struct user_struct *user, struct file *fp);
 void unix_destruct_scm(struct sk_buff *skb);
-void io_uring_destruct_scm(struct sk_buff *skb);
 void unix_gc(void);
 void wait_for_unix_gc(struct scm_fp_list *fpl);
 struct sock *unix_peer_get(struct sock *sk);
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index b4bf7f7538826..c04f82489abb9 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -184,12 +184,10 @@ static bool gc_in_progress;
 
 static void __unix_gc(struct work_struct *work)
 {
-	struct sk_buff *next_skb, *skb;
-	struct unix_sock *u;
-	struct unix_sock *next;
 	struct sk_buff_head hitlist;
-	struct list_head cursor;
+	struct unix_sock *u, *next;
 	LIST_HEAD(not_cycle_list);
+	struct list_head cursor;
 
 	spin_lock(&unix_gc_lock);
 
@@ -293,30 +291,11 @@ static void __unix_gc(struct work_struct *work)
 
 	spin_unlock(&unix_gc_lock);
 
-	/* We need io_uring to clean its registered files, ignore all io_uring
-	 * originated skbs. It's fine as io_uring doesn't keep references to
-	 * other io_uring instances and so killing all other files in the cycle
-	 * will put all io_uring references forcing it to go through normal
-	 * release.path eventually putting registered files.
-	 */
-	skb_queue_walk_safe(&hitlist, skb, next_skb) {
-		if (skb->destructor == io_uring_destruct_scm) {
-			__skb_unlink(skb, &hitlist);
-			skb_queue_tail(&skb->sk->sk_receive_queue, skb);
-		}
-	}
-
 	/* Here we are. Hitlist is filled. Die. */
 	__skb_queue_purge(&hitlist);
 
 	spin_lock(&unix_gc_lock);
 
-	/* There could be io_uring registered files, just push them back to
-	 * the inflight list
-	 */
-	list_for_each_entry_safe(u, next, &gc_candidates, link)
-		list_move_tail(&u->link, &gc_inflight_list);
-
 	/* All candidates should have been detached by now. */
 	WARN_ON_ONCE(!list_empty(&gc_candidates));
 
diff --git a/net/unix/scm.c b/net/unix/scm.c
index 505e56cf02a21..db65b0ab59479 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -148,9 +148,3 @@ void unix_destruct_scm(struct sk_buff *skb)
 	sock_wfree(skb);
 }
 EXPORT_SYMBOL(unix_destruct_scm);
-
-void io_uring_destruct_scm(struct sk_buff *skb)
-{
-	unix_destruct_scm(skb);
-}
-EXPORT_SYMBOL(io_uring_destruct_scm);
-- 
2.49.0.1112.g889b7c5bd8-goog


