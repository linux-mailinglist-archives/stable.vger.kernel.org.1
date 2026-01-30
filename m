Return-Path: <stable+bounces-212840-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id amCmOP9CfGmBLgIAu9opvQ
	(envelope-from <stable+bounces-212840-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 06:34:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 447DFB7558
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 06:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 206363027941
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 05:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E26E374196;
	Fri, 30 Jan 2026 05:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmtKyMmh"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249436CDF9
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 05:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769751262; cv=none; b=MjmiP+b29Exp/9NU/FbLokD9SwChRK6CnUaqUGqINxvH2/ZUYPu+fahm+8jD3DluJyAnn4uRwM3Zm1+HIEviuBymAGIDbMfYIocjcue/vEenv/Dz/yVedlcTtAr8tdHTjIwP27xtoxXL5VTX7AFgoh2hnF3RzWlTJvlVRgxBuP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769751262; c=relaxed/simple;
	bh=0h7xP6A49Jgeo/0GDXqLFRTApRe+v4rNX4sEgCnoL5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eY3T9La3NGQhw4WRpfH7WfI9iFa7BMl2852hRanl+/BlzuYap0DDu+gCzO8mGh6ZOK4ps+XW+VvT6eXfGiSTCMafukNXH38MwlHem0j2vEAeMGDXHffW2nZOILyO1IZiZvH2uf+xuz8rXeF7qquhdOL8gJUQsWlh+XWlhaUaRto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmtKyMmh; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c6aaf3cd62so183054185a.3
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 21:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769751258; x=1770356058; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UKpVoG4fkiASguZlTDW91/9jV9J6kBfvakyqskZ0dmo=;
        b=DmtKyMmhD0F6RW5pebHUNE+KewYZhUOVILAlykZGiHaD/rB0LujTG6wr/87Rxn0riD
         Fcx/18UGC7b/ElxVBp8YC2hSO6PLgEEdUvw9u+OytAY86MuR5I2W/eQ8yH5OwvDyr2GM
         A1gUyb76DtxzwiFPq56fu51PqZvYxaUP/u80TTS4GHqpu4um4KoM4LfVDtYReKqdvv7f
         lfU3YHfZNyybf7tqgI6F1sV9pjrDeFP3YGUvBV567Kas6oG0M0HjBZmToAE7GaGlqD4V
         zy8N5eDoE4h82jML2uyI1tmMXw+HvuzBJFVpOc3crSvZcE69lcq6Zv+0u8/6US9S9eKJ
         bd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769751258; x=1770356058;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKpVoG4fkiASguZlTDW91/9jV9J6kBfvakyqskZ0dmo=;
        b=RM+7JnxUFZ5Rn7ZDHyVVrNtysbVyAe2w6wHoIFhnPMc6TAj4rU5Z2Mg9PYd4YKBrXL
         mYMBKWvmszW3RtFciGaqbnm0Kl+IufTQ63qa20MVMbL7sisP4MfdNBJamrjCOwmd93z0
         24Ds34vVcPz2Tt7qYDAvxK0gsUaZYI6Sfd+dbcFgoi5YYOfn/2pTeYiEBDgbJqGPKenm
         Ht+mP22UJfMaVIN5PJwQExSAcssfXhX8LBCfm+pdcDmGUCsoSzF/cZRA7XNiF9N5jNYQ
         ZfCQX8Ozzbpcj/5C2DukfhroT9dxNSyo7qDixnz1cwo/+FCWsaVw+Lnbe0+51/j7wxc2
         BHZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXDTsxbIrO8ASz+pPGAmKFdTHhiDG43WoQPQ6HyhYnIPBCkb/ExBEr8GqFxikRCsNI/ItIyPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCEG6hTjQFlpfurL2qnBGEM20dl4HOY34PTBvdKq7jTl2UaGYO
	bydyyHj12pSAeNmBliGbHwBuXaqVBe+Qd6PfrmqWBa/u/yF1W84LlAzNJFkJ7g==
X-Gm-Gg: AZuq6aJkbxhdHFYH1xxw3FFu7WrlWHBb7BhU51PSQB/bUodIYAFVWYGvv2tfl4i1VtS
	t0X+y6QG/4tTzIDPhYy7UnuOcfZYRL8NPDftaPimDqTXGE7MepPPXdj+TDZ79lcb/Qy09AaI9vM
	zZHupiRMqwZ5wxnIl0PbTLZtcKv2c3ZvjtSY3jrMm0xF/3oag57WbBrq4GCqWy0qoJCY15h1z90
	R7Bun67rK37B15M0SQ5EQvaMhtWrswey1Y7CT1lzs8+qq8hgauuX9cWs+klxLA2gzypf0XJ2kD0
	CVoxkVdJDuCtT1YS4/MdpGyXECZiD436oT4gFRWQXMInC/eJr879o49A3IAP4VyvSs0e+bEsQZM
	3K/Ct/5VqJKiXJ7THlHNbJ/Zy4hzjlNLac0NmxnppZBV4jDL3HVjIzU3aBnMQ1Z+b7ig3e7HTwV
	78Z1xZyX2t7nc3jK0mhua1
X-Received: by 2002:a05:620a:4542:b0:8c6:b14e:655d with SMTP id af79cd13be357-8c9eb30e4a9mr249559585a.74.1769751257701;
        Thu, 29 Jan 2026 21:34:17 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d2847asm551232885a.34.2026.01.29.21.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 21:34:17 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Fri, 30 Jan 2026 13:34:07 +0800
Subject: [PATCH net v4] net: cpsw_new: Execute ndo_set_rx_mode callback in
 a work queue
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-bbb-v4-1-2bd000a15c34@gmail.com>
X-B4-Tracking: v=1; b=H4sIAM5CfGkC/13MTQ7CIBAF4Ks0rMXwj7ryHsZFgaElsa2Bhmia3
 l2km2pm9WbmewtKEAMkdGkWFCGHFKaxBHFokO3bsQMcXMmIEaYIZRwbY7CzXGnplaaOoPL5jOD
 Dq7bc0AgzupdlH9I8xXdtzrSefkoyxWW0MsRoeuLCXbuhDY+jnYbqM9sbuRn2NVJo71tjz47/G
 743ejO8GAmaei6IpXDem3VdP/xw/1UDAQAA
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
	TAGGED_FROM(0.00)[bounces-212840-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,nxp.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:email,nxp.com:email,davemloft.net:email,lunn.ch:email]
X-Rspamd-Queue-Id: 447DFB7558
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
Changes in v4:
- Using schedule_work() instead of creating a dedicated workqueue.

- Link to v3: https://lore.kernel.org/r/20260127-bbb-v3-1-5e71f340c1e9@gmail.com

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
 drivers/net/ethernet/ti/cpsw_new.c  | 33 +++++++++++++++++++++++++++++----
 drivers/net/ethernet/ti/cpsw_priv.h |  1 +
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index ab88d4c02cbde76207f89cf433e2b383dcde6a83..744657cad0927da21232969d07c15e68f44811e3 100644
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
 
@@ -270,6 +280,15 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
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
+
+	schedule_work(&priv->rx_mode_work);
 }
 
 static unsigned int cpsw_rxbuf_total_len(unsigned int len)
@@ -1398,6 +1417,7 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 		priv->msg_enable = netif_msg_init(debug_level, CPSW_DEBUG);
 		priv->emac_port = i + 1;
 		priv->tx_packet_min = CPSW_MIN_PACKET_SIZE;
+		INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
 
 		if (is_valid_ether_addr(slave_data->mac_addr)) {
 			ether_addr_copy(priv->mac_addr, slave_data->mac_addr);
@@ -1447,13 +1467,18 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 
 static void cpsw_unregister_ports(struct cpsw_common *cpsw)
 {
+	struct net_device *ndev;
+	struct cpsw_priv *priv;
 	int i = 0;
 
 	for (i = 0; i < cpsw->data.slaves; i++) {
-		if (!cpsw->slaves[i].ndev)
+		ndev = cpsw->slaves[i].ndev;
+		if (!ndev)
 			continue;
 
-		unregister_netdev(cpsw->slaves[i].ndev);
+		priv = netdev_priv(ndev);
+		disable_work_sync(&priv->rx_mode_work);
+		unregister_netdev(ndev);
 	}
 }
 
diff --git a/drivers/net/ethernet/ti/cpsw_priv.h b/drivers/net/ethernet/ti/cpsw_priv.h
index 91add8925e235c6cf5542fde11f3383b9234c872..acb6181c5c9e1bf6ed46a7fd14ce422efc0b724e 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.h
+++ b/drivers/net/ethernet/ti/cpsw_priv.h
@@ -391,6 +391,7 @@ struct cpsw_priv {
 	u32 tx_packet_min;
 	struct cpsw_ale_ratelimit ale_bc_ratelimit;
 	struct cpsw_ale_ratelimit ale_mc_ratelimit;
+	struct work_struct rx_mode_work;
 };
 
 #define ndev_to_cpsw(ndev) (((struct cpsw_priv *)netdev_priv(ndev))->cpsw)

---
base-commit: 33a647c659ffa5bdb94abc345c8c86768ff96215
change-id: 20260123-bbb-dc3675f671d0

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


