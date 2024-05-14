Return-Path: <stable+bounces-44324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE628C5244
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CB3282B28
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B985103D;
	Tue, 14 May 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p5pNBBOP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57992943F;
	Tue, 14 May 2024 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685704; cv=none; b=smCdRsod83FtuyIwjKE/0U3vdd4IVXho0NBbklXH6Zk/GK5PDt2n8lKCoapOqz3CHTrZkMTttTKlD2aUu2UbT+5pN8bTIrvFcb1zdmCuE6IhhOkxk2GeyDfglDQbNquyCHeppqUGPS4/ONk+P52fcYMKVFp8NbhzdSnstVkz6lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685704; c=relaxed/simple;
	bh=n1LBDbvtNjsPtvu0OTW4b58RfhH0MSaCGHokNSYTVkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cR0wO6cYD2/e13A4jGDyfe5blitKYgumCCdjRxVuPg1awheK1vgN/Rnb7hu4Cl4W9KRROU3W4Mzospgfgj9Q/bR7DS2B/eWG1SoqaQuNCECUG11LLIZITxnwvdNN0gM2BoKNwnq2GT0MV4lvRQESmEHQd1t4VxJn48WF8x3R4RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p5pNBBOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA129C2BD10;
	Tue, 14 May 2024 11:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715685704;
	bh=n1LBDbvtNjsPtvu0OTW4b58RfhH0MSaCGHokNSYTVkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p5pNBBOPj1IFlqEY7xLZT6SNIjqcxFxoEHLmBaqA86yGXviCYitMF0oQzHNVeZDrE
	 AnffvUzB0MqwLMeO2sU9tXj+t+eoKFiT6HuG0fRLp2t8ZwVpPcfFOtkXzEVQ2y9iP/
	 CgYz/BBpQKBc7zzWrkTUTp4Y7pOmjxrakRf+t9PM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 199/301] net-sysfs: convert dev->operstate reads to lockless ones
Date: Tue, 14 May 2024 12:17:50 +0200
Message-ID: <20240514101039.773765872@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 004d138364fd10dd5ff8ceb54cfdc2d792a7b338 ]

operstate_show() can omit dev_base_lock acquisition only
to read dev->operstate.

Annotate accesses to dev->operstate.

Writers still acquire dev_base_lock for mutual exclusion.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 4893b8b3ef8d ("hsr: Simplify code for announcing HSR nodes timer setup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_netlink.c |  3 ++-
 net/core/link_watch.c   |  4 ++--
 net/core/net-sysfs.c    |  4 +---
 net/core/rtnetlink.c    |  4 ++--
 net/hsr/hsr_device.c    | 10 +++++-----
 net/ipv6/addrconf.c     |  2 +-
 6 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 65e9ed3851425..4488faf059a36 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -455,7 +455,8 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 			  u32 filter_mask, const struct net_device *dev,
 			  bool getlink)
 {
-	u8 operstate = netif_running(dev) ? dev->operstate : IF_OPER_DOWN;
+	u8 operstate = netif_running(dev) ? READ_ONCE(dev->operstate) :
+					    IF_OPER_DOWN;
 	struct nlattr *af = NULL;
 	struct net_bridge *br;
 	struct ifinfomsg *hdr;
diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index c469d1c4db5d7..cb43f5aebfbcc 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -67,7 +67,7 @@ static void rfc2863_policy(struct net_device *dev)
 {
 	unsigned char operstate = default_operstate(dev);
 
-	if (operstate == dev->operstate)
+	if (operstate == READ_ONCE(dev->operstate))
 		return;
 
 	write_lock(&dev_base_lock);
@@ -87,7 +87,7 @@ static void rfc2863_policy(struct net_device *dev)
 		break;
 	}
 
-	dev->operstate = operstate;
+	WRITE_ONCE(dev->operstate, operstate);
 
 	write_unlock(&dev_base_lock);
 }
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index fccaa5bac0ed0..5a9487af44e00 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -307,11 +307,9 @@ static ssize_t operstate_show(struct device *dev,
 	const struct net_device *netdev = to_net_dev(dev);
 	unsigned char operstate;
 
-	read_lock(&dev_base_lock);
-	operstate = netdev->operstate;
+	operstate = READ_ONCE(netdev->operstate);
 	if (!netif_running(netdev))
 		operstate = IF_OPER_DOWN;
-	read_unlock(&dev_base_lock);
 
 	if (operstate >= ARRAY_SIZE(operstates))
 		return -EINVAL; /* should not happen */
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 89964270cf27f..7ea66de1442cc 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -880,9 +880,9 @@ static void set_operstate(struct net_device *dev, unsigned char transition)
 		break;
 	}
 
-	if (dev->operstate != operstate) {
+	if (READ_ONCE(dev->operstate) != operstate) {
 		write_lock(&dev_base_lock);
-		dev->operstate = operstate;
+		WRITE_ONCE(dev->operstate, operstate);
 		write_unlock(&dev_base_lock);
 		netdev_state_change(dev);
 	}
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index dd4b5f0aa1318..cd337385e8592 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -31,8 +31,8 @@ static bool is_slave_up(struct net_device *dev)
 static void __hsr_set_operstate(struct net_device *dev, int transition)
 {
 	write_lock(&dev_base_lock);
-	if (dev->operstate != transition) {
-		dev->operstate = transition;
+	if (READ_ONCE(dev->operstate) != transition) {
+		WRITE_ONCE(dev->operstate, transition);
 		write_unlock(&dev_base_lock);
 		netdev_state_change(dev);
 	} else {
@@ -78,14 +78,14 @@ static void hsr_check_announce(struct net_device *hsr_dev,
 
 	hsr = netdev_priv(hsr_dev);
 
-	if (hsr_dev->operstate == IF_OPER_UP && old_operstate != IF_OPER_UP) {
+	if (READ_ONCE(hsr_dev->operstate) == IF_OPER_UP && old_operstate != IF_OPER_UP) {
 		/* Went up */
 		hsr->announce_count = 0;
 		mod_timer(&hsr->announce_timer,
 			  jiffies + msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL));
 	}
 
-	if (hsr_dev->operstate != IF_OPER_UP && old_operstate == IF_OPER_UP)
+	if (READ_ONCE(hsr_dev->operstate) != IF_OPER_UP && old_operstate == IF_OPER_UP)
 		/* Went down */
 		del_timer(&hsr->announce_timer);
 }
@@ -100,7 +100,7 @@ void hsr_check_carrier_and_operstate(struct hsr_priv *hsr)
 	/* netif_stacked_transfer_operstate() cannot be used here since
 	 * it doesn't set IF_OPER_LOWERLAYERDOWN (?)
 	 */
-	old_operstate = master->dev->operstate;
+	old_operstate = READ_ONCE(master->dev->operstate);
 	has_carrier = hsr_check_carrier(master);
 	hsr_set_operstate(master, has_carrier);
 	hsr_check_announce(master->dev, old_operstate);
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d1806eee1687d..01f4502916a12 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6011,7 +6011,7 @@ static int inet6_fill_ifinfo(struct sk_buff *skb, struct inet6_dev *idev,
 	    (dev->ifindex != dev_get_iflink(dev) &&
 	     nla_put_u32(skb, IFLA_LINK, dev_get_iflink(dev))) ||
 	    nla_put_u8(skb, IFLA_OPERSTATE,
-		       netif_running(dev) ? dev->operstate : IF_OPER_DOWN))
+		       netif_running(dev) ? READ_ONCE(dev->operstate) : IF_OPER_DOWN))
 		goto nla_put_failure;
 	protoinfo = nla_nest_start_noflag(skb, IFLA_PROTINFO);
 	if (!protoinfo)
-- 
2.43.0




