Return-Path: <stable+bounces-213148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wICtOTNbgWlnFwMAu9opvQ
	(envelope-from <stable+bounces-213148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 03:19:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 610B2D3B14
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 03:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E9CC303EEBD
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 02:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99502F363E;
	Tue,  3 Feb 2026 02:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwEskGGZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAF61509AB
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 02:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085151; cv=none; b=izPau6shTgS9FiC6F5Z4Fhw3fhu4lKziEc6xkA81egFx3iIrvkwJB7b8FH6vHX1cFCZSSdC/NZZd/cV9ZeI+CVjl/bwMrBi5vLKXstEFsxqTyfLm383ZmVLiWbLOe/qGC8k3ScQha2bDta9HDbHJDI/3aOYuHiFAUfxh46tykCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085151; c=relaxed/simple;
	bh=PwlO+5tJ1Z658R3+kpEyrC8Bi6r9M0IwKU98dcsWaCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kxbszf1Qvocnc+099tK2KGgyC02v1iB2E8NqKQr60aeXGQ7JgBNQ/7y0p/NH1T88IKsdtbBItJbnUsUrXX9NguZqEHbAZk6/9gFp2Ulb2qrcGYNTPtSDV3K4ATZPSzzHsD00N1mqSpGLtm69jyL/kEfzLX//ZjTx3bUiZUTupm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwEskGGZ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-502a98c66f7so41838641cf.1
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 18:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770085148; x=1770689948; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylf/wxb0zUUywRHu+X/57l5JJ2yWVJWbffw9Iqhdass=;
        b=QwEskGGZMS8r2/Bi6yuZR5NZKU/T6YmWTXXwA+1HBbSqOA/3Ebm24Th8M2hyy0naAh
         f3ZpRJtUcklhKkTe9Yf4ygI48u4is6Uf+oowsTqWq5C0jQErkGlImqjG6du3CDUTv6Vq
         qtXbpYdBkGn80prDPF4LUtY1i2Q27peRGMa18Hwqr4zUUAoTZ343yu2Ti0wWje5BaQds
         TrE+E/TJFVUNJm5bLfTtzEOKm5cy19eLtcaa9B+uSNNfWFs+B3h1rBRoqdPvAwZqPFtp
         0KJb0G4WUYN+ViM2Kk+G4ImNYBNlM+xcoQaoYyL+XGdGZLP9jj30Llc5oSkZ/g5JuF6O
         2mLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770085148; x=1770689948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ylf/wxb0zUUywRHu+X/57l5JJ2yWVJWbffw9Iqhdass=;
        b=TtkcxnaKkqNJ9RBUp6lVop68Iv8DUh6PDMAfBOGtzBlYtdBXi7Gr6dKjcSEF/nngGT
         VtdgDga50Vxvdu5WajwMbaxWSLWdHU3ZsnfP1CJQ7rgDiqdMqSrRR90HUOOm7DggziZT
         FLeL3Jkj7MdyjeFmYOlKPdC+vbnjmhWVkIsJSOXdjgptPjD0OOXw92wEwbudgzbC7EWz
         8oMNUQtmQH1q3q+LU2i31JYWNuzQJ8cxpmCZzAEUJd6WVWb1ehDb2QEzNoKsnoT5OuaU
         PF4oBsVAuHw57uhD5/+hZea1VjpMuObnV+sCvShU+1P0oRX+4RrnKplKPsB1RKK6YEkg
         RxcA==
X-Forwarded-Encrypted: i=1; AJvYcCWZw4ycy63U9eg0OERiPiUaI6E5yAhnpmtbIFF59j+VCGLZ9FbE7C08oLJjOot1+S5aTzvLRIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl/CZcdmR6oxgVxfKOh7qTSX0zf3HDiiyvO681tpg9irXzE7PR
	Z/2aIKnwviKXzozXsc/iF+MNJEe9Pfv3GrDlGyRPn0qiwS41Vq6uVRbC
X-Gm-Gg: AZuq6aJJsYTghBhznjejdIsHeWqijb/nVckBvA0CPh/0fD3vxHLWYuPuJw2hrZmagkj
	A1xiNp9675w0VaB2iZIrG+sW1Y6eB5g1YqOMOkFInBiWiv8/TYyBAreen4LkRghLcadO9vVzkju
	WBFcNKjM3kKgH8t1kWE4oXZ6P9TrI+29G8LCNzz3+1F4u874pPfotcFMVcG3DIAzHAXuMrPq4mE
	FOU+xEHv+uYhxxDnWH57d8Gb4aILHLsseofksxNpNYrJW7S58sq01XLaKMnHUfpzElR+Vv7Nnau
	1D9YkudjIsI2o0up4DsBKC5l8azyeZd0p1Ujh3WURmGseIs4DLAKcUsuJWMjD3SDPvJj4SyA6CN
	S2DmwvBzvcNP+GmqArd7HNiFh/7AYmp7cnKVAfOxvIjLHztcNicRyBPaRpiAjhy7nvOnEV6qq5E
	fEq7Y1tyNTEcZltCI2rtca
X-Received: by 2002:ac8:5d89:0:b0:501:4701:e9f9 with SMTP id d75a77b69052e-505d2184a51mr174064431cf.26.1770085147611;
        Mon, 02 Feb 2026 18:19:07 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d5c34asm1337199885a.50.2026.02.02.18.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 18:19:07 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Tue, 03 Feb 2026 10:18:30 +0800
Subject: [PATCH net v5 1/2] net: cpsw_new: Execute ndo_set_rx_mode callback
 in a work queue
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-bbb-v5-1-ea0ea217a85c@gmail.com>
References: <20260203-bbb-v5-0-ea0ea217a85c@gmail.com>
In-Reply-To: <20260203-bbb-v5-0-ea0ea217a85c@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213148-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,nxp.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 610B2D3B14
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
 drivers/net/ethernet/ti/cpsw_new.c  | 34 +++++++++++++++++++++++++++++-----
 drivers/net/ethernet/ti/cpsw_priv.h |  1 +
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index ab88d4c02cbde76207f89cf433e2b383dcde6a83..21af0a10626aaf0ce6ecb04837899801743f3894 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -248,16 +248,22 @@ static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
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
+	if (!netif_running(ndev))
+		goto unlock_rtnl;
+
+	netif_addr_lock_bh(ndev);
 	if (ndev->flags & IFF_PROMISC) {
 		/* Enable promiscuous mode */
 		cpsw_set_promiscious(ndev, true);
 		cpsw_ale_set_allmulti(cpsw->ale, IFF_ALLMULTI, priv->emac_port);
-		return;
+		goto unlock_addr;
 	}
 
 	/* Disable promiscuous mode */
@@ -270,6 +276,18 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 	/* add/remove mcast address either for real netdev or for vlan */
 	__hw_addr_ref_sync_dev(&ndev->mc, ndev, cpsw_add_mc_addr,
 			       cpsw_del_mc_addr);
+
+unlock_addr:
+	netif_addr_unlock_bh(ndev);
+unlock_rtnl:
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
@@ -1398,6 +1416,7 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 		priv->msg_enable = netif_msg_init(debug_level, CPSW_DEBUG);
 		priv->emac_port = i + 1;
 		priv->tx_packet_min = CPSW_MIN_PACKET_SIZE;
+		INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
 
 		if (is_valid_ether_addr(slave_data->mac_addr)) {
 			ether_addr_copy(priv->mac_addr, slave_data->mac_addr);
@@ -1447,13 +1466,18 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 
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
+		unregister_netdev(ndev);
+		disable_work_sync(&priv->rx_mode_work);
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

-- 
2.52.0


