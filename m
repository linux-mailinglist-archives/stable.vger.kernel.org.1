Return-Path: <stable+bounces-211477-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LzwAD94dWnDFQEAu9opvQ
	(envelope-from <stable+bounces-211477-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 02:56:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0827F7A5
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 02:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59961300D173
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 01:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8006C1C8626;
	Sun, 25 Jan 2026 01:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cl3EsP2s"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD69719C556
	for <stable@vger.kernel.org>; Sun, 25 Jan 2026 01:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769306162; cv=none; b=bfh9R1T4twl2apIAt54Z2FBK0DRBcTSRZLWkR7Mb1YtV4vHI0wQXzp1iv2lXxCgB5TJzu5C6MHAIVwD1Vli1qiBfWNiIPZkKZ/0satgztHveojwWPQKPJqkIkWklqxJ0H7zwq+17o+d4BE2EXBkziPPazKJz1khH8Q1s1zkBujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769306162; c=relaxed/simple;
	bh=czHtok8kdM+NFjQous0qO1iQS3e10Dwr/nFSfUrsxbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uNjz24mbtBINIq8f+l0Bh2DUiZeo14tHx0+SQ1AGfOLOc8XtBeu1vgJyYjSeLgXPQdotFhXRQDgkzpB0lytRXf9FRQqyJBd0Ts5iD4tinU0iWEj0A9aDyGUJYn2o+viuYa7rKc1lcC4mRWyFyn3AR/i+u9SV2UpVpWdvldVjcFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cl3EsP2s; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5029fb0b977so33752191cf.0
        for <stable@vger.kernel.org>; Sat, 24 Jan 2026 17:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769306159; x=1769910959; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B8JTWJ4sRGrlm2gY6MCzSC7MNQIM/QuydTD6Wv2h6Os=;
        b=Cl3EsP2s1wXyPSSP/G+QUsKMs2NoPzM8R1hqDzGDqX+LcP6feXEdPrN4W76UZWRAP0
         sxeHhIZx+hHd192F8jAj1Jky4S7OjYX4kNLtxZhuazulHzUv1qtBXqwvxB3yIut63FkV
         lswMAi5nBPq0fDpxA6Tq7cte1I2g3Yjj/1GVexcaD4bDswrXWES4uWgWZ1/vwdWMJFut
         bkO6gUlsaihRSHG1vR0A70OyJMuwdpkk1sgcclKHNW1Jt4SgT8CFiQ4e1VNjTwDjx+vB
         Z46oL+ASi2EEa9sYexg8QrLocc638worFkPTwtlt0n6BaiSLy8nMT6i/7yNm3Qg18eNP
         rsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769306159; x=1769910959;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8JTWJ4sRGrlm2gY6MCzSC7MNQIM/QuydTD6Wv2h6Os=;
        b=maQJDNfNHWgRIrnM4yw+nXVk5/ny8WpxKYFsxovXfMoyU4F5+KFxCqJHgOzEgto7Eh
         JdGwq1q4kUkmhz6VDXlFlBPTL2d3PkhRptgRzybP72lDH3qxYVUAITmQfB4mxy3fDW9M
         gdh0BEpfOngqiJb+Rn+EpI44VOFbGGwsUxt024DEH3ElWeaFuB/iLifrBAY6eRbp/VxE
         IyT0y6au/6uzMV6bpBwm7PM6VBfuaqdCmhoSk6oiAdUoFJsvQS68OIQBK+gPkcSumSpO
         5+0N+t/D+B+8trE/tBjszzSj3e1CUBa3Ua1p1dAqfH322howpVYuVtWUs9nes4DNmTbJ
         3GIg==
X-Forwarded-Encrypted: i=1; AJvYcCXN0rkUxdOn9VdSUaNyGNnXbtolgKn/XuhaT/rQQ5op8QWbPzMJYxbWOyR5KoGbLVnlfI8KTRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH/OpTR7mUPQlR8oG/u477jdqbgv4oduSq1yerwpxTC0/lgRPK
	3MZq2Rh9SYu22PIis4AZxfY1fRhfLSP53S6GqKCzW5250TrDy1IWs9iI
X-Gm-Gg: AZuq6aKZ2o4GId2B07svelaEYizyHMfIMhfH8qvZtQcDtRy0ZwaVjQWQ/OuZvEBWBgo
	LvoI2iAiKx55yBRtifvgmZYtZL+NDnPyZK+jRtZPD0JEUPYRaV1CUlpRgl431KLX/1dJKqJZK26
	iGwBM/Ijj8FWk3xecv/Ef0zO0MYfFySTSAu8rPGnkRGW8jqq+q2CWpX7YLfUVhyelCkwFYaAGzm
	cczA2nnJdVE5ryqC4hJKg7KX5YDtTiOIwv1o8Lky7FUCjxUemtMt7D/MUdOcbFWRv90saYJLiWY
	6oSW0Ts9hhlrv4yxVhmcvtuqltiL+E+jLe48dsqGGBKqAlgGz9KGDH7MFdWtZ6kd1frXu07zJbZ
	H8RPpCa46i09YMBq7yx7LwnmVtN+afAcnQbZwUTyoiMl71N1DtfTvF1MN6NvOYvQKDgRVr/XTbX
	FkKBguVAcqHoh37OrXDJtB
X-Received: by 2002:a05:622a:315:b0:501:3d11:18cb with SMTP id d75a77b69052e-50314ceaa37mr5122341cf.73.1769306159399;
        Sat, 24 Jan 2026 17:55:59 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8949193cdc1sm49035636d6.47.2026.01.24.17.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 17:55:59 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Sun, 25 Jan 2026 09:55:33 +0800
Subject: [PATCH net v2] net: cpsw_new: Execute ndo_set_rx_mode callback in
 a work queue
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260125-bbb-v2-1-1547ffabc9d3@gmail.com>
X-B4-Tracking: v=1; b=H4sIABR4dWkC/1WMyw7CIBREf6W5azE8FIwr/8N0UeC2vYkFAw3RN
 Py7hJ2Z1ZmZnAMyJsIM9+GAhIUyxdBAngZw6xQWZOQbg+RScyEVs9Yy75Q211kb4Tm05zvhTJ9
 ueULAHcZWrpT3mL7dXESf/iRFsBajLbdG3NTFP5ZtotfZxQ3GWusPN60RDJsAAAA=
X-Change-ID: 20260123-bbb-dc3675f671d0
To: netdev@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>, stable@vger.kernel.org, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
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
	TAGGED_FROM(0.00)[bounces-211477-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,nxp.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url,davemloft.net:email,nxp.com:email]
X-Rspamd-Queue-Id: 7A0827F7A5
X-Rspamd-Action: no action

Commit 1767bb2d47b7 ("ipv6: mcast: Don't hold RTNL for
IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.") removed the RTNL lock for
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
Changes in v2:
- Addresses the issue identified in the AI review [1]:
  - Adds a netif_running() check in cpsw_ndo_set_rx_mode_work()
  - Cancels the rx_mode_work in cpsw_ndo_stop()

- Link to v1: https://lore.kernel.org/r/20260123-bbb-v1-1-176b0b71834d@gmail.com

[1] https://netdev-ai.bots.linux.dev/ai-review.html?id=bd885e1e-1aed-4755-ad60-7150737ad0f5
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
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: linux-omap@vger.kernel.org
---
 drivers/net/ethernet/ti/cpsw_new.c  | 34 ++++++++++++++++++++++++++++++++--
 drivers/net/ethernet/ti/cpsw_priv.h |  2 ++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index ab88d4c02cbde76207f89cf433e2b383dcde6a83..a631df9691e06fef563da6276f8ee9358c4cf911 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -248,15 +248,23 @@ static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
 	return 0;
 }
 
-static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
+static void cpsw_ndo_set_rx_mode_work(struct work_struct *work)
 {
-	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_priv *priv = container_of(work, struct cpsw_priv, rx_mode_work);
 	struct cpsw_common *cpsw = priv->cpsw;
+	struct net_device *ndev = priv->ndev;
 
+	if (!netif_running(ndev))
+		return;
+
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
 
@@ -270,6 +278,16 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
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
@@ -813,6 +831,8 @@ static int cpsw_ndo_stop(struct net_device *ndev)
 
 	__hw_addr_ref_unsync_dev(&ndev->mc, ndev, cpsw_purge_all_mc);
 
+	cancel_work_sync(&priv->rx_mode_work);
+
 	if (cpsw->usage_count <= 1) {
 		napi_disable(&cpsw->napi_rx);
 		napi_disable(&cpsw->napi_tx);
@@ -1398,6 +1418,7 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 		priv->msg_enable = netif_msg_init(debug_level, CPSW_DEBUG);
 		priv->emac_port = i + 1;
 		priv->tx_packet_min = CPSW_MIN_PACKET_SIZE;
+		INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
 
 		if (is_valid_ether_addr(slave_data->mac_addr)) {
 			ether_addr_copy(priv->mac_addr, slave_data->mac_addr);
@@ -1976,6 +1997,13 @@ static int cpsw_probe(struct platform_device *pdev)
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
@@ -2042,6 +2070,7 @@ static int cpsw_probe(struct platform_device *pdev)
 clean_unregister_notifiers:
 	cpsw_unregister_notifiers(cpsw);
 clean_unregister_netdev:
+	destroy_workqueue(cpsw->cmd_wq);
 	cpsw_unregister_ports(cpsw);
 clean_cpts:
 	cpts_release(cpsw->cpts);
@@ -2068,6 +2097,7 @@ static void cpsw_remove(struct platform_device *pdev)
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
base-commit: ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea
change-id: 20260123-bbb-dc3675f671d0

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


