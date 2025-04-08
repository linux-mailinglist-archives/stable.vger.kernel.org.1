Return-Path: <stable+bounces-128937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA3BA7FD94
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546BC424FE8
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852F6267B6F;
	Tue,  8 Apr 2025 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1PFgyUXt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40324267393;
	Tue,  8 Apr 2025 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109677; cv=none; b=JciJVleoJ6alIEMcq3EScxHPXQMUshhPLQOak37eSX7BPN4QEQ+frPrxaYhDenFIof4kQWgq54DWSherbI3jcn6hdxrnslOjYGj4LKHPUAHI7NBS1bNyIxzrUHMyKcZZhELOooB0mWo4yZSuiLr4IKy/lVugUGTTHtjkhNe09vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109677; c=relaxed/simple;
	bh=Y2gXBrc2Ifw5mAmzL0eO7NlDQfIkKhxxyoA4J56/cRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCZUcXjC36LuXEPSMXrOt3nAvNqqwLUO/aQVhcrW7NVeyFCyvOoMOULF+438Hwoe0/VJ22Z9bpNJlVbqt+q0+ABBTM2or2ZksBg3SkrjSg5hU3SGuoVJ1QATfKCTAnEODdYRWdbgGNk7g244x2iOYDgHoRA8JX5WnB0J8pex1lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1PFgyUXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FA6C4CEE5;
	Tue,  8 Apr 2025 10:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744109677;
	bh=Y2gXBrc2Ifw5mAmzL0eO7NlDQfIkKhxxyoA4J56/cRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1PFgyUXtcrOwx4TkLrhpef7gMdAJuVUb/r8fQYY9+LPxZs7XutkOzbOZptMTJA3dZ
	 ZWTN7T/lKpNY0YeQtz02sVKK1F2TC1fl6GnqnpUKdMYeGQ+/aKVc2nYLnGD1BKgkwS
	 Qx2jPGEbV66dpXDWfGsOteLXFuHMPqq4qFDyZQWU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 013/227] netpoll: hold rcu read lock in __netpoll_send_skb()
Date: Tue,  8 Apr 2025 12:46:31 +0200
Message-ID: <20250408104820.792564996@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.353768086@linuxfoundation.org>
References: <20250408104820.353768086@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 505ead7ab77f289f12d8a68ac83da068e4d4408b ]

The function __netpoll_send_skb() is being invoked without holding the
RCU read lock. This oversight triggers a warning message when
CONFIG_PROVE_RCU_LIST is enabled:

	net/core/netpoll.c:330 suspicious rcu_dereference_check() usage!

	 netpoll_send_skb
	 netpoll_send_udp
	 write_ext_msg
	 console_flush_all
	 console_unlock
	 vprintk_emit

To prevent npinfo from disappearing unexpectedly, ensure that
__netpoll_send_skb() is protected with the RCU read lock.

Fixes: 2899656b494dcd1 ("netpoll: take rcu_read_lock_bh() in netpoll_send_skb_on_dev()")
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250306-netpoll_rcu_v2-v2-1-bc4f5c51742a@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/netpoll.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 4475b2174bcc4..66a6f62412393 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -326,6 +326,7 @@ static int netpoll_owner_active(struct net_device *dev)
 static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
 	netdev_tx_t status = NETDEV_TX_BUSY;
+	netdev_tx_t ret = NET_XMIT_DROP;
 	struct net_device *dev;
 	unsigned long tries;
 	/* It is up to the caller to keep npinfo alive. */
@@ -334,11 +335,12 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 	lockdep_assert_irqs_disabled();
 
 	dev = np->dev;
+	rcu_read_lock();
 	npinfo = rcu_dereference_bh(dev->npinfo);
 
 	if (!npinfo || !netif_running(dev) || !netif_device_present(dev)) {
 		dev_kfree_skb_irq(skb);
-		return NET_XMIT_DROP;
+		goto out;
 	}
 
 	/* don't get messages out of order, and no recursion */
@@ -377,7 +379,10 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 		skb_queue_tail(&npinfo->txq, skb);
 		schedule_delayed_work(&npinfo->tx_work,0);
 	}
-	return NETDEV_TX_OK;
+	ret = NETDEV_TX_OK;
+out:
+	rcu_read_unlock();
+	return ret;
 }
 
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
-- 
2.39.5




