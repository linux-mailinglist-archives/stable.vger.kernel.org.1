Return-Path: <stable+bounces-195415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2974CC76222
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9FBDF359C39
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1941C3043A9;
	Thu, 20 Nov 2025 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgq5yGIV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABAE285073
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763668619; cv=none; b=ergHMWlIxjd/PVjaB2n6egJ9fF1Jw5Pg9QqrIIV3LgB8YxAaPs6HGtNoe3RDs4Ig0rFfZfkpaH0qyYuaOGk+G3EeeVVgiFjHVFek7CVMOM6YlTqIw04gYxZcqBx3j/GJjs7ge0Rbv5zsdjYDLb62IeaOcBij/5AErlvN4+W8+gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763668619; c=relaxed/simple;
	bh=9p/Rn9DhiLBRAOiMG6ON/K0+siBoWnGtF4PSPR/3Ijk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wq39oF1nif2of18TaGMFVeWvvvGX1XSnvRosf+6VEcLet5AZWlLYLMg0OolTA13cGnLXvOxRgmDynQ5Df73+CRs+fH9/p6Wq7L+bss099fu5P3qt0K5xvxEUUNkzyGASqrn4feyXOLec7BIR9coMFigADoNetkrg1otSA/+51iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgq5yGIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E992AC16AAE;
	Thu, 20 Nov 2025 19:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763668619;
	bh=9p/Rn9DhiLBRAOiMG6ON/K0+siBoWnGtF4PSPR/3Ijk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cgq5yGIVp9TWqujO1OExx/MGdepPpIQ7gLgH8/vS9zU3NUgeqCnfI+6Jj201XzcqR
	 qcFF0Rb1DXIH/iZLbxGEOZd5rpr5r3T+/kefcyFBOK2//M2G4KEnohch8EWc+4sGB5
	 qNyQHW4Vsie14VvbhnQrzUHkL4jGsRLTmWVsvYGOrEqmwdGnOwyJshdoHpNbedCfmM
	 i0JYYLVBpOQ9eCcy/UZiUIpCvjUbwJKI2PnzUH5A6yVNtY9ezl76YVNMvSEylGIzaz
	 Ytz4CtXDvWthN09/v0siFSxku5i3cr56vJJnFbM84v6Ipd/X5Xmug0en2fSPGM5n+c
	 LKBbHl2qfi5UA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] net: netpoll: Individualize the skb pool
Date: Thu, 20 Nov 2025 14:56:54 -0500
Message-ID: <20251120195656.2297634-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120195656.2297634-1-sashal@kernel.org>
References: <2025112006-author-harmony-d5f7@gregkh>
 <20251120195656.2297634-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 221a9c1df790fa711d65daf5ba05d0addc279153 ]

The current implementation of the netpoll system uses a global skb
pool, which can lead to inefficient memory usage and
waste when targets are disabled or no longer in use.

This can result in a significant amount of memory being unnecessarily
allocated and retained, potentially causing performance issues and
limiting the availability of resources for other system components.

Modify the netpoll system to assign a skb pool to each target instead of
using a global one.

This approach allows for more fine-grained control over memory
allocation and deallocation, ensuring that resources are only allocated
and retained as needed.

Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/20241114-skb_buffers_v2-v3-1-9be9f52a8b69@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 49c8d2c1f94c ("net: netpoll: fix incorrect refcount handling causing incorrect cleanup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netpoll.h |  1 +
 net/core/netpoll.c      | 31 +++++++++++++------------------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 3ddf205b7e2c3..f0dddb8852805 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -32,6 +32,7 @@ struct netpoll {
 	bool ipv6;
 	u16 local_port, remote_port;
 	u8 remote_mac[ETH_ALEN];
+	struct sk_buff_head skb_pool;
 };
 
 struct netpoll_info {
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 8c3379c1ecf07..ee7af71b7b102 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -45,9 +45,6 @@
 
 #define MAX_UDP_CHUNK 1460
 #define MAX_SKBS 32
-
-static struct sk_buff_head skb_pool;
-
 #define USEC_PER_POLL	50
 
 #define MAX_SKB_SIZE							\
@@ -236,20 +233,23 @@ void netpoll_poll_enable(struct net_device *dev)
 }
 EXPORT_SYMBOL(netpoll_poll_enable);
 
-static void refill_skbs(void)
+static void refill_skbs(struct netpoll *np)
 {
+	struct sk_buff_head *skb_pool;
 	struct sk_buff *skb;
 	unsigned long flags;
 
-	spin_lock_irqsave(&skb_pool.lock, flags);
-	while (skb_pool.qlen < MAX_SKBS) {
+	skb_pool = &np->skb_pool;
+
+	spin_lock_irqsave(&skb_pool->lock, flags);
+	while (skb_pool->qlen < MAX_SKBS) {
 		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
 		if (!skb)
 			break;
 
-		__skb_queue_tail(&skb_pool, skb);
+		__skb_queue_tail(skb_pool, skb);
 	}
-	spin_unlock_irqrestore(&skb_pool.lock, flags);
+	spin_unlock_irqrestore(&skb_pool->lock, flags);
 }
 
 static void zap_completion_queue(void)
@@ -286,12 +286,12 @@ static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 	struct sk_buff *skb;
 
 	zap_completion_queue();
-	refill_skbs();
+	refill_skbs(np);
 repeat:
 
 	skb = alloc_skb(len, GFP_ATOMIC);
 	if (!skb)
-		skb = skb_dequeue(&skb_pool);
+		skb = skb_dequeue(&np->skb_pool);
 
 	if (!skb) {
 		if (++count < 10) {
@@ -680,6 +680,8 @@ int netpoll_setup(struct netpoll *np)
 	struct in_device *in_dev;
 	int err;
 
+	skb_queue_head_init(&np->skb_pool);
+
 	rtnl_lock();
 	if (np->dev_name[0]) {
 		struct net *net = current->nsproxy->net_ns;
@@ -780,7 +782,7 @@ int netpoll_setup(struct netpoll *np)
 	}
 
 	/* fill up the skb queue */
-	refill_skbs();
+	refill_skbs(np);
 
 	err = __netpoll_setup(np, ndev);
 	if (err)
@@ -806,13 +808,6 @@ int netpoll_setup(struct netpoll *np)
 }
 EXPORT_SYMBOL(netpoll_setup);
 
-static int __init netpoll_init(void)
-{
-	skb_queue_head_init(&skb_pool);
-	return 0;
-}
-core_initcall(netpoll_init);
-
 static void rcu_cleanup_netpoll_info(struct rcu_head *rcu_head)
 {
 	struct netpoll_info *npinfo =
-- 
2.51.0


