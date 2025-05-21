Return-Path: <stable+bounces-145883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73190ABF97A
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCDA1BA84FA
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3477E217679;
	Wed, 21 May 2025 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="np4WEJP1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB8D189513;
	Wed, 21 May 2025 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841580; cv=none; b=Xn9E5JnZjcPQF0WfZXA5Zc7Q9LcLSSfjuSAFvDf0CvqvCyEEyk6zbQhSa5X2fRfMtLTKZ/npA/XOi8mEnrJi6+ZdvvT9m61zlj+U7TBCXI+RDMPogQoqx36JONUTfS3a/e6zS/huYoyKWR8GcdLy63gaMcXFv2iZ8TjY9DNjkm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841580; c=relaxed/simple;
	bh=oef6HLrlbAgx8WrXcvkKFP3hlsXTMr+e/rWC4/VLf9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiyPfq9W3Y5F/lRDoTI9nIxx9iu+8v1eLpLGir7SUxZcXLs7V0NmlzyhmuYwzphZpvcXtspawVz6btAP4XsmFiCMIBd+ShMm0lQKne6tWIt/hQRNPIYvwbrXqWVObbQPrL76tcqYMvmJBSUPFYH5o4imDK4jmRo/97TnLLeQADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=np4WEJP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69784C4CEE7;
	Wed, 21 May 2025 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841579;
	bh=oef6HLrlbAgx8WrXcvkKFP3hlsXTMr+e/rWC4/VLf9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=np4WEJP1m83ZWB/BspU69JbUCa34WhxzwD73n9Aesyr6EA5MadeMtDALnmavuIlLg
	 s5r6u26/6/hNiGXra+FH6Yb4lXMhV9iOC7b3G7NX382NXGe7Ie/YOi0EdEiHhZtZQ/
	 3/zTxwbdig1wNu4ZB6AzhSMxM2ICkwYxcZfM2QUFp6YnYRWd/Vtyv0VblzLbeT8ztV
	 niM0j3bAj2mhmU8E7vBoFBqOe2BhBoLFVd+kcnZeyRuPcCz4TyMHwSw+Z6/gxaj+M/
	 pT102jKuc+FU5e6GliT/EpkbZ05EGMRG6IANdl0GRBPWw/q4MC41H/Y2kgA6ZY+hyF
	 Gc2qzefWD9HaQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Sasha Levin <sashal@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Rao Shoaib <Rao.Shoaib@oracle.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v6.1 06/27] af_unix: Remove io_uring code for GC.
Date: Wed, 21 May 2025 16:27:05 +0100
Message-ID: <20250521152920.1116756-7-lee@kernel.org>
X-Mailer: git-send-email 2.49.0.1143.g0be31eac6b-goog
In-Reply-To: <20250521152920.1116756-1-lee@kernel.org>
References: <20250521152920.1116756-1-lee@kernel.org>
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
 net/unix/garbage.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 7eeaac165e85..c04f82489abb 100644
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
-		if (skb->scm_io_uring) {
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
 
-- 
2.49.0.1143.g0be31eac6b-goog


