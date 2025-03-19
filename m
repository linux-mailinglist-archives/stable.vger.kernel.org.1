Return-Path: <stable+bounces-125184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EEFA69003
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3EB46331B
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35F620E31B;
	Wed, 19 Mar 2025 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E+4FNJBt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44851C5D6A;
	Wed, 19 Mar 2025 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395012; cv=none; b=IozWs/PFDVQKJcHctDo/nN3cxNPxMCoOAPNzjZVsScAHyk8+bWa6Of6Nz1fGR1+e9TWYtrIcyuK1Jg4AljbPAMXmDciJmPMfrhhWLT/A04RdNxnP5VYpCJcsGZGk41sDzRh1GM+9oVA9mTccYI2gjCC/THXNc3slLcv+L6xvr04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395012; c=relaxed/simple;
	bh=xpRuJt/GGGIxdW2g1o7OWqjGRif/2Y5XVRniMFofkNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JEisR3FaJn8S6HAzVL1icVdbBQUrFvnQkE1pWNhq3IguHUFwLl5GChm59mO2VeMF/XLoSl/6DntopYC9bKnLpOxgRbASLopm6drkOCXWjEEaYDBNxjRyTabLz/PPaoNTQSHGEyJeh8XMu50UdZdmbIYx3MtNh2EWad/8S+Ph3PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E+4FNJBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F22C4CEE9;
	Wed, 19 Mar 2025 14:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395012;
	bh=xpRuJt/GGGIxdW2g1o7OWqjGRif/2Y5XVRniMFofkNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E+4FNJBtQk5B4yA0VKuD05m8pEW59klfcLCtkKJ9AMezd37FBWcyNno3VkdIYbASt
	 lrktniRPHjwEnvrW9UTPLH6Pj4TTaZiX56BZ1pg0O5w+nDoVp7Ngvd0Wo2M3gzoYpa
	 XA2I7BZTGy3lnbOGjxFzTT2COD/oaCpuMq7lA5Yk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 023/231] netpoll: hold rcu read lock in __netpoll_send_skb()
Date: Wed, 19 Mar 2025 07:28:36 -0700
Message-ID: <20250319143027.401151586@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
References: <20250319143026.865956961@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 45fb60bc48039..e95c2933756df 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -319,6 +319,7 @@ static int netpoll_owner_active(struct net_device *dev)
 static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
 	netdev_tx_t status = NETDEV_TX_BUSY;
+	netdev_tx_t ret = NET_XMIT_DROP;
 	struct net_device *dev;
 	unsigned long tries;
 	/* It is up to the caller to keep npinfo alive. */
@@ -327,11 +328,12 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
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
@@ -370,7 +372,10 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
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




