Return-Path: <stable+bounces-211732-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBAxLBRxeGnEpwEAu9opvQ
	(envelope-from <stable+bounces-211732-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 09:02:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CAD90E21
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 09:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 108F4300B466
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 08:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5E5217723;
	Tue, 27 Jan 2026 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftjCPuRA"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9273EBF1B
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769500943; cv=none; b=lQPzFWJ1ubUiiy8KwPkgR9tq/LNWrMAys/bWe1IETZVG+GTHOzei5OzG3vuy/2RZ/YAkk3Sg6iKXLuJC2SdjI2uFnqsUBFcWkGbYprRIeAANj9ws50Ynozq3/YZw5pHKkbfTBxTdP6TsU5dpB/KmyoHcIsfolwRHY4aARwGeBm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769500943; c=relaxed/simple;
	bh=HsScYRN8C7XxHBUEFBrWlntzO0aUNoi24rZlNL0zzJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gYnYEptthZ6etjaGk41jSW0C/u3MgJUWSDNE/Rg8MAlQyt9QON7ETPMdz+Z8zz6/bas3FpreTj/mWgSq1WioDsBAou/94GN2UVTMSNK+mRrtoh0c1NuIKbRKuGhztUoUwnYKotv+X2hssMClUScBwhzrbBKRrFMImPDbNiZ7AAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftjCPuRA; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88a35a00506so100065826d6.2
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 00:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769500941; x=1770105741; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gYyhxoUylHHW2V1XitCAxiaLRC0fKk6AB8sFPEBn1tg=;
        b=ftjCPuRASxqKhEO7UMP2+uPIt8YnIGUwgt1pOhe7PzDckVoDQh83qK3EmZEnPbUiWR
         pBhqU2hVJQzxC/ER7DVvuhYahNdMtj/PUsg+8yj9WAeOAutbmKyJsvyXZJmEvNOZsMk2
         633oNNlfpBkyYGQc9vPbfHREYRqciRjDRXzun8hBs/GWDn8t4ToFJEkJvog/4pPm+537
         NDPmolSJfAh0QquKiT3SAYcaPMJFhbmGJLO4YCdcni9YHFrIMViILs8Z8Dv9pVZRsQvS
         CP4vdpQ1KdrxZB8oYVDHgOA+5nLV/Y0tW+MGvWoN/mlJyAOCx8z8FdCpq1vYNaXGHLlt
         EJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769500941; x=1770105741;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYyhxoUylHHW2V1XitCAxiaLRC0fKk6AB8sFPEBn1tg=;
        b=rSS6RmcQyuHCIpNwqv8WBuGn4AWi7vTZGzus4SBUsS6Wrjjpj0pMGZPLOi2exSJz2J
         zhc5rBWW0jQU3K5sgoDHUmdycioFla/W2oxASvpzHAXjTN44h7Hw5/tlSH2kqQwJynqj
         9ANMPAAsiGDPLWuPOqK+ksaliFKTXhzBKyUdaCCsGXf9VllSid/KKnNnd9eRe5ek6O+C
         0lC+fT9rqLRD9PtY1qXzve3nG0W8S7UfmYWOmaLgxJhiUCVDegA91WEIUosMTwpmcVfp
         4QHpYbbQf7Kn+4sx5lSUXz0UWo5N6i2LXseUOv/6J2WU4oOVNAeAN+3l3q6AA1/qOldS
         nQhw==
X-Forwarded-Encrypted: i=1; AJvYcCVV0d6Uxe+h08uuhPdzDGHI/5xxUA0ZR0HaQ5WJBCZzKQYuOC4SatBikwJomEsW368ShOyRExc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJx9GrBCBzWxIg0yHctrgTQZAiXxyOkLGJeKUSO4IXNO3VoLCF
	Xx00/xcCMmCFmJRS61p+ZyaPXGwnrX+TrNjZ5eeyXWhLg8lhIqrvATFvsPcI9g==
X-Gm-Gg: AZuq6aKaZEG5O/zPFXF2930sg2bPprNiA2JfefQD0M0cRgM9Z5GPDpxWhxBfDVEEjZv
	FtCbivSKVCFnwtGGh0L91Bmo4kPWRFxysnsvPLkXdbrs+865+b3vGtn8KOrF6IO+tDMW8JJQMfm
	rQDoMJ7bDZbnFOb9k8ChnbUDPJgwzglCTLeTDVyk685BXzdOLioCE5JS7Zd9CGvtpNItWdy7Dgj
	TtRtviN529PDiJv+cUyn5VVuWWh0EN3H8QLsa0SW0Bu/AIgXQKMIaCchSAKD8dBEXIeqGRj4Cu8
	JHGwVCv+RhsSjnAx6yt4ujgQkVmWBWcDae+wMmnRJMhS+LUp+J5+aON0l4npj2Bf33x5aXLIHh3
	oiodRFbW8hAZtPyPk4SiasXap8CLyySASnq1B3DS3yVhr5ERkzEXUfLEhIuqh9KTFqhRHqzQg6g
	TviqmXj7/4v5V596yX40O3
X-Received: by 2002:a05:622a:1453:b0:4ff:c144:a45 with SMTP id d75a77b69052e-5032f76dc5fmr8401861cf.1.1769500940541;
        Tue, 27 Jan 2026 00:02:20 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894aeb0ce21sm68244016d6.52.2026.01.27.00.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 00:02:20 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Tue, 27 Jan 2026 16:02:07 +0800
Subject: [PATCH net v3] net: cpsw_new: Execute ndo_set_rx_mode callback in
 a work queue
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-bbb-v3-1-5e71f340c1e9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAP5weGkC/1WMyw6CMBBFf4XM2po+oFVX/odxQV8wiVDTkkZD+
 Hdr3WDu6t6Zc1ZILqJLcGlWiC5jwjCXIg4NmLGfB0fQlg6cckkZF0RrTawRUnVeKmYplM9ndB5
 f1XKD2S1wL+OIaQnxXc2Z1dOfJDNSoqSmWrGTaO11mHp8HE2YKp/5nul+DP8yXau877U5W7Fnt
 m37ALL94w3PAAAA
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211732-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,nxp.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,linux.dev:url,ti.com:email]
X-Rspamd-Queue-Id: 47CAD90E21
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
Changes in v3:
- Resolve the deadlock issue identified in the AI review [2]
  by moving the netif_running() check under the RTNL lock and removing the
  cancel_work_sync() call in cpsw_ndo_stop().

- Link to v2: https://lore.kernel.org/r/20260125-bbb-v2-1-1547ffabc9d3@gmail.com

Changes in v2:
- Addresses the issue identified in the AI review [1]:
  - Adds a netif_running() check in cpsw_ndo_set_rx_mode_work()
  - Cancels the rx_mode_work in cpsw_ndo_stop()

- Link to v1: https://lore.kernel.org/r/20260123-bbb-v1-1-176b0b71834d@gmail.com

[1] https://netdev-ai.bots.linux.dev/ai-review.html?id=bd885e1e-1aed-4755-ad60-7150737ad0f5
[2] https://netdev-ai.bots.linux.dev/ai-review.html?id=c9fc3cf8-a06c-4cb8-b26b-910e775951a0
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
index ab88d4c02cbde76207f89cf433e2b383dcde6a83..838615c9a5ec3c9226c2aff6325ecda13ba9729f 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -248,15 +248,25 @@ static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
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
+	if (!netif_running(ndev)) {
+		rtnl_unlock();
+		return;
+	}
+
+	netif_addr_lock_bh(ndev);
 	if (ndev->flags & IFF_PROMISC) {
 		/* Enable promiscuous mode */
 		cpsw_set_promiscious(ndev, true);
 		cpsw_ale_set_allmulti(cpsw->ale, IFF_ALLMULTI, priv->emac_port);
+		netif_addr_unlock_bh(ndev);
+		rtnl_unlock();
 		return;
 	}
 
@@ -270,6 +280,16 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
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
base-commit: 615aad0f61e0c7a898184a394dc895c610100d4f
change-id: 20260123-bbb-dc3675f671d0

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


