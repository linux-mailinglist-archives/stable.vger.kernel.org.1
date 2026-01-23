Return-Path: <stable+bounces-211373-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EfKFCxYc2nruwAAu9opvQ
	(envelope-from <stable+bounces-211373-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 12:14:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7371074E2A
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 12:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BFF4322DEE4
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 11:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF79318EF9;
	Fri, 23 Jan 2026 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHKKuGrR"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D901231829
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166575; cv=none; b=GPmUMtTjwVi/4yta1HlaiVYoFwack38+cV4FbPXIq/qT284okP3hKmCUKIGCFvw2B1FNP3eNaQSwKgn491gP339FRVWesbM04Qet+ehr3Dsq6rWTeux/J6yhf5SzXlUO1UoMWW1Xju9CeOzuD25R4A0hjuwORgL9rdz3ei57nI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166575; c=relaxed/simple;
	bh=4iDgbCPDX6zetLw0sIoTMixX1OU29nvoRAcbnlpMyp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dQR44NOVIo8WJHLyyY3L1fGoI5MU+pZl0u5DfYN2sYIURme/iZgqMmpbi86Z5Agc3KhjHHrszRSRRBwtqClAex0loNbbfNWS0Yzh8vwZQlntqH5AUFu9Gca+lKt/fXD1qXHx1JkEjOlw/9dThyXgEKFTidDOILGKM4n/h6WdeEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHKKuGrR; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88ffcb14e11so37524396d6.0
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 03:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769166571; x=1769771371; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0/pAK6MrrOiwwDQc0GBrsxIdwLQE0979ZY3mHhzgGcY=;
        b=UHKKuGrRBDJYfX0sG/9bxETcd5SZb8WQwP+7HWlx1nIw2UoE23VKeMOvwdQBhRBINE
         q3YKvVduVJeoHK7pjMmHofRUmMxheAwfCnvyhDkW8qixjat0eO+2EF9EvawjQhoHwpQA
         uMJeLJismzXFR5MdJLaLGUAi/POQzt1rMNvV9UeJe94BWQDUF5JFeltvobw4DRRMVA8q
         BvNqu2HZe9CqzmIukR61UfP90vAo0sRHnEh62nBUPhtSAn8n4yey2WpbwbcjIYe3buRx
         SaHG2BX6vn3n1Ifw26p2gMly7GBRlk6UTn1vL2bfj3Dy2atpYFB9nLb/6RraBHRT3znP
         mLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769166571; x=1769771371;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/pAK6MrrOiwwDQc0GBrsxIdwLQE0979ZY3mHhzgGcY=;
        b=ru/XIVFDJ+Ad5CXZ/RW+aIfBxk7mL+8mmbZecT7/6sjGtCnHX/0N5Yi2xZ71udeDMh
         1zX0Gt16MyuxamZ5ZrzOUCCEF4leZFUdfxSTwXhckwr6yAGDmfZLlLY0SDDEQv76dSiz
         Ke81jbVxK+CnMW9tlsazonWcLpHTqBjq5bKlqhR0O27NoF9aVAIT7ObRJew9Oa7xN1Uy
         E9BgXlORpnv7ur+XOAKt/kPRbpIgdcYs/gGc8C6M/kMOsoM6N+MpN0YotqeIrX/95u0R
         m54Qr/wjmuXQkbE2DpGlj/3MKQ0OO6dcqAXNj/5tORICTGPuOd+KqCHCYZ21nLPjE35s
         1jPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzXdY7CiKu9OlKrtOVzYlh+FlHLo1hWvbtXyVyryMv7YPZD36u9nkXDZixGCBRQHYTJ/X2pcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsBRGSAhYGxC2PaIZ0PbVbxxYCZ5Bt8tsL6l9L7YC3xLSY8kvA
	cE3YjkNJ1X1qHOx6WsIygr8ele7+kD2+mIUo1pUrYDKMiZ02NxO+sg4b
X-Gm-Gg: AZuq6aIbXhM42N+ZhPy6/p8k4Op5B13yqwfxcKDJdQI6LK+BvqC0dMlnylN4S0wW6tE
	aV7AFG7zGklUfXQHxLqqyTS80pbcjvVg7/Y2PA9YyOhlWtwrREF8PNrgGonwohuLsxtNHA/vysg
	aQ8Q4R2CttQPzMQhZ3H18HxUZqYfZeUCxcSkfQ1McGTFQYqiLXd1t7GEQM3wlPDLnk/tz8ph6X4
	dYplpNB333OoR67U4RDXuQIEwCWlYVSXfniUPbozzejCQdXB3KW8+FsSZyCCqZndv31OmDoBhaQ
	3BT77liJ0QgogQAGqWPbhB6/+3RkzfptRAFl1Spy2tt17JBZr6uDyPzV2gtqC2k/4sLDf5N9mLc
	AOawbU6+boU2Jt/vjYly48REf9wsO9qVE4ZV2aHNLsl6lj+YqXHjIr7c+GUwUY8T0JCSkP79JPi
	Ld6kdgWc9Tl7oyFdVIUN+A
X-Received: by 2002:a05:6214:2628:b0:894:610c:3a22 with SMTP id 6a1803df08f44-89490177e74mr36606866d6.20.1769166571210;
        Fri, 23 Jan 2026 03:09:31 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502f7f72d8bsm14348801cf.22.2026.01.23.03.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 03:09:30 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Fri, 23 Jan 2026 19:09:07 +0800
Subject: [PATCH net] net: cpsw_new: Execute ndo_set_rx_mode callback in a
 work queue
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-bbb-v1-1-176b0b71834d@gmail.com>
X-B4-Tracking: v=1; b=H4sIANJWc2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyNj3aSkJN2UZGMzc9M0M3PDFAMloMqCotS0zAqwKdFKeaklSrG1tQB
 t+L7sWgAAAA==
X-Change-ID: 20260123-bbb-dc3675f671d0
To: netdev@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>, stable@vger.kernel.org, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, linux-omap@vger.kernel.org
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211373-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email]
X-Rspamd-Queue-Id: 7371074E2A
X-Rspamd-Action: no action

Commit 1767bb2d47b7 ("ipv6: mcast: Don't hold RTNL for
IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP") removed the RTNL lock for
IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP operations. However, this
change triggered the following call trace on my BeagleBone Black board:
  WARNING: net/8021q/vlan_core.c:236 at vlan_for_each+0x120/0x124, CPU#0: rpcbind/496
  RTNL: assertion failed at net/8021q/vlan_core.c (236)
  Modules linked in:
  CPU: 0 UID: 997 PID: 496 Comm: rpcbind Not tainted 6.19.0-rc6-next-20260122-yocto-standard+ #8 PREEMPT
  Hardware name: Generic AM33XX (Flattened Device Tree)
  Call trace:
   unwind_backtrace from show_stack+0x28/0x2c
   show_stack from dump_stack_lvl+0x30/0x38
   dump_stack_lvl from __warn+0xb8/0x11c
   __warn from warn_slowpath_fmt+0x130/0x194
   warn_slowpath_fmt from vlan_for_each+0x120/0x124
   vlan_for_each from cpsw_add_mc_addr+0x54/0xd8
   cpsw_add_mc_addr from __hw_addr_ref_sync_dev+0xc4/0xec
   __hw_addr_ref_sync_dev from __dev_mc_add+0x78/0x88
   __dev_mc_add from igmp6_group_added+0x84/0xec
   igmp6_group_added from __ipv6_dev_mc_inc+0x1fc/0x2f0
   __ipv6_dev_mc_inc from __ipv6_sock_mc_join+0x124/0x1b4
   __ipv6_sock_mc_join from do_ipv6_setsockopt+0x84c/0x1168
   do_ipv6_setsockopt from ipv6_setsockopt+0x88/0xc8
   ipv6_setsockopt from do_sock_setsockopt+0xe8/0x19c
   do_sock_setsockopt from __sys_setsockopt+0x84/0xac
   __sys_setsockopt from ret_fast_syscall+0x0/0x5

This trace occurs because vlan_for_each() is called within
cpsw_ndo_set_rx_mode(), which expects the RTNL lock to be held.
Since modifying vlan_for_each() to operate without the RTNL lock is not
straightforward, and because ndo_set_rx_mode() is invoked both with and
without the RTNL lock across different code paths, simply adding
rtnl_lock() in cpsw_ndo_set_rx_mode() is not a viable solution.

To resolve this issue, we opt to execute the actual processing within
a work queue, following the approach used by the icssg-prueth driver.

Fixes: 1767bb2d47b7 ("ipv6: mcast: Don't hold RTNL for IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
---
Please note that the cpsw driver also has the same issue. If this resolution
is acceptable, I will create another patch to fix the issue in cpsw.

Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: linux-omap@vger.kernel.org
---
 drivers/net/ethernet/ti/cpsw_new.c  | 29 +++++++++++++++++++++++++++--
 drivers/net/ethernet/ti/cpsw_priv.h |  2 ++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index ab88d4c02cbde76207f89cf433e2b383dcde6a83..786d64a952643927ad80d2effbb171dd87f91160 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -248,15 +248,20 @@ static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
 	return 0;
 }
 
-static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
+static void cpsw_ndo_set_rx_mode_work(struct work_struct *work)
 {
-	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_priv *priv = container_of(work, struct cpsw_priv, rx_mode_work);
 	struct cpsw_common *cpsw = priv->cpsw;
+	struct net_device *ndev = priv->ndev;
 
+	rtnl_lock();
+	netif_addr_lock_bh(ndev);
 	if (ndev->flags & IFF_PROMISC) {
 		/* Enable promiscuous mode */
 		cpsw_set_promiscious(ndev, true);
 		cpsw_ale_set_allmulti(cpsw->ale, IFF_ALLMULTI, priv->emac_port);
+		netif_addr_unlock_bh(ndev);
+		rtnl_unlock();
 		return;
 	}
 
@@ -270,6 +275,16 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 	/* add/remove mcast address either for real netdev or for vlan */
 	__hw_addr_ref_sync_dev(&ndev->mc, ndev, cpsw_add_mc_addr,
 			       cpsw_del_mc_addr);
+	netif_addr_unlock_bh(ndev);
+	rtnl_unlock();
+}
+
+static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+
+	queue_work(cpsw->cmd_wq, &priv->rx_mode_work);
 }
 
 static unsigned int cpsw_rxbuf_total_len(unsigned int len)
@@ -1398,6 +1413,7 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 		priv->msg_enable = netif_msg_init(debug_level, CPSW_DEBUG);
 		priv->emac_port = i + 1;
 		priv->tx_packet_min = CPSW_MIN_PACKET_SIZE;
+		INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
 
 		if (is_valid_ether_addr(slave_data->mac_addr)) {
 			ether_addr_copy(priv->mac_addr, slave_data->mac_addr);
@@ -1976,6 +1992,13 @@ static int cpsw_probe(struct platform_device *pdev)
 	}
 	cpsw_split_res(cpsw);
 
+	cpsw->cmd_wq = create_singlethread_workqueue("cpsw_cmd_wq");
+	if (!cpsw->cmd_wq) {
+		dev_err(dev, "error initializing workqueue\n");
+		ret = -ENOMEM;
+		goto clean_cpts;
+	}
+
 	/* setup netdevs */
 	ret = cpsw_create_ports(cpsw);
 	if (ret)
@@ -2042,6 +2065,7 @@ static int cpsw_probe(struct platform_device *pdev)
 clean_unregister_notifiers:
 	cpsw_unregister_notifiers(cpsw);
 clean_unregister_netdev:
+	destroy_workqueue(cpsw->cmd_wq);
 	cpsw_unregister_ports(cpsw);
 clean_cpts:
 	cpts_release(cpsw->cpts);
@@ -2068,6 +2092,7 @@ static void cpsw_remove(struct platform_device *pdev)
 		return;
 	}
 
+	destroy_workqueue(cpsw->cmd_wq);
 	cpsw_unregister_notifiers(cpsw);
 	cpsw_unregister_devlink(cpsw);
 	cpsw_unregister_ports(cpsw);
diff --git a/drivers/net/ethernet/ti/cpsw_priv.h b/drivers/net/ethernet/ti/cpsw_priv.h
index 91add8925e235c6cf5542fde11f3383b9234c872..8cdf4bff198fcc05436ff381a7e4326b3e3c27b1 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.h
+++ b/drivers/net/ethernet/ti/cpsw_priv.h
@@ -362,6 +362,7 @@ struct cpsw_common {
 	struct net_device *hw_bridge_dev;
 	bool ale_bypass;
 	u8 base_mac[ETH_ALEN];
+	struct workqueue_struct *cmd_wq;
 };
 
 struct cpsw_ale_ratelimit {
@@ -391,6 +392,7 @@ struct cpsw_priv {
 	u32 tx_packet_min;
 	struct cpsw_ale_ratelimit ale_bc_ratelimit;
 	struct cpsw_ale_ratelimit ale_mc_ratelimit;
+	struct work_struct rx_mode_work;
 };
 
 #define ndev_to_cpsw(ndev) (((struct cpsw_priv *)netdev_priv(ndev))->cpsw)

---
base-commit: a0c666c25aeefd16f4b088c6549a6fb6b65a8a1d
change-id: 20260123-bbb-dc3675f671d0

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


