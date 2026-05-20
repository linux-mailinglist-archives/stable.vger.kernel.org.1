Return-Path: <stable+bounces-252714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAFPJswCDmqs5QUAu9opvQ
	(envelope-from <stable+bounces-252714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:51:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D43059753D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25C0A399B674
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BAF3F9280;
	Wed, 20 May 2026 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kvw+SLzY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A56036A033;
	Wed, 20 May 2026 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301397; cv=none; b=EDiTyQ5NYz6EaABsHxaBbmlODA9FYhwaQy1AYKel3y1BGQKruN5vORf5vyuTZE2ARoepBI/915KGB/YrB0fSIf63+pZFMswDC79Dbaws1u15h4BZoc2l2cA9HR/E16aKrXLSE+Z07j3rPwkl3kiRz7uPv7Lj+hhMFT1n3X8I9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301397; c=relaxed/simple;
	bh=+5eiioj8k2llRebhV5v19P2Ep0bSnGtV2p5pPQ6x/kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHuRHsb/2zYdDyRb370WWlWwiTpGwm3u9XUTNSAScG7zkWkbKmA3g6QLPXLFGHz9C3eUB0P/YqxzFX93XJqv0r7aZv+z14eS7Q4Lcr21W9NiVeL5PKm0dU4i+NFNGKmWwqQS2AvChFOALPklNGm6eSMzF5fGYYuvmIEdW4+5Kfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kvw+SLzY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123D41F000E9;
	Wed, 20 May 2026 18:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301396;
	bh=KLFa3aMKdAYGm5xmNDLvBA6Kz18sXaLDiILtdS2Qjkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kvw+SLzYuwT8MxrtApBOEfLkPIo6i/eWPwr8hhwwpscnqNW0EDboWan9XgaR0WSXl
	 m/QQulGAb/oSRTL3/0pcUutxUqXm73pO9PBAIFyzAM/tMB5+CCAX/5ZUwK+SQ5A2Tb
	 HAUSkyXv6MzmheN0R4KPIN3fRz2aCJR5pw8q6uPY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haoze Xie <royenheart@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 539/666] vrf: Fix a potential NPD when removing a port from a VRF
Date: Wed, 20 May 2026 18:22:30 +0200
Message-ID: <20260520162122.953465544@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252714-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,nvidia.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1D43059753D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 2674d603a9e6970463b2b9ebcf8e31e90beae169 ]

RCU readers that identified a net device as a VRF port using
netif_is_l3_slave() assume that a subsequent call to
netdev_master_upper_dev_get_rcu() will return a VRF device. They then
continue to dereference its l3mdev operations.

This assumption is not always correct and can result in a NPD [1]. There
is no RCU synchronization when removing a port from a VRF, so it is
possible for an RCU reader to see a new master device (e.g., a bridge)
that does not have l3mdev operations.

Fix by adding RCU synchronization after clearing the IFF_L3MDEV_SLAVE
flag. Skip this synchronization when a net device is removed from a VRF
as part of its deletion and when the VRF device itself is deleted. In
the latter case an RCU grace period will pass by the time RTNL is
released.

[1]
BUG: kernel NULL pointer dereference, address: 0000000000000000
[...]
RIP: 0010:l3mdev_fib_table_rcu (net/l3mdev/l3mdev.c:181)
[...]
Call Trace:
<TASK>
l3mdev_fib_table_by_index (net/l3mdev/l3mdev.c:201 net/l3mdev/l3mdev.c:189)
__inet_bind (net/ipv4/af_inet.c:499 (discriminator 3))
inet_bind_sk (net/ipv4/af_inet.c:469)
__sys_bind (./include/linux/file.h:62 (discriminator 1) ./include/linux/file.h:83 (discriminator 1) net/socket.c:1951 (discriminator 1))
__x64_sys_bind (net/socket.c:1969 (discriminator 1) net/socket.c:1967 (discriminator 1) net/socket.c:1967 (discriminator 1))
do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Fixes: fdeea7be88b1 ("net: vrf: Set slave's private flag before linking")
Reported-by: Haoze Xie <royenheart@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Yuan Tan <yuantan098@gmail.com>
Closes: https://lore.kernel.org/netdev/20260419145332.3988923-1-n05ec@lzu.edu.cn/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20260423063607.1208202-1-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vrf.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index b62462d8eff26..93ecd9577f4d3 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1104,6 +1104,7 @@ static int do_vrf_add_slave(struct net_device *dev, struct net_device *port_dev,
 
 err:
 	port_dev->priv_flags &= ~IFF_L3MDEV_SLAVE;
+	synchronize_net();
 	return ret;
 }
 
@@ -1123,10 +1124,16 @@ static int vrf_add_slave(struct net_device *dev, struct net_device *port_dev,
 }
 
 /* inverse of do_vrf_add_slave */
-static int do_vrf_del_slave(struct net_device *dev, struct net_device *port_dev)
+static int do_vrf_del_slave(struct net_device *dev, struct net_device *port_dev,
+			    bool needs_sync)
 {
 	netdev_upper_dev_unlink(port_dev, dev);
 	port_dev->priv_flags &= ~IFF_L3MDEV_SLAVE;
+	/* Make sure that concurrent RCU readers that identified the device
+	 * as a VRF port see a VRF master or no master at all.
+	 */
+	if (needs_sync)
+		synchronize_net();
 
 	cycle_netdev(port_dev, NULL);
 
@@ -1135,7 +1142,7 @@ static int do_vrf_del_slave(struct net_device *dev, struct net_device *port_dev)
 
 static int vrf_del_slave(struct net_device *dev, struct net_device *port_dev)
 {
-	return do_vrf_del_slave(dev, port_dev);
+	return do_vrf_del_slave(dev, port_dev, true);
 }
 
 static void vrf_dev_uninit(struct net_device *dev)
@@ -1691,7 +1698,7 @@ static void vrf_dellink(struct net_device *dev, struct list_head *head)
 	struct list_head *iter;
 
 	netdev_for_each_lower_dev(dev, port_dev, iter)
-		vrf_del_slave(dev, port_dev);
+		do_vrf_del_slave(dev, port_dev, false);
 
 	vrf_map_unregister_dev(dev);
 
@@ -1822,7 +1829,7 @@ static int vrf_device_event(struct notifier_block *unused,
 			goto out;
 
 		vrf_dev = netdev_master_upper_dev_get(dev);
-		vrf_del_slave(vrf_dev, dev);
+		do_vrf_del_slave(vrf_dev, dev, false);
 	}
 out:
 	return NOTIFY_DONE;
-- 
2.53.0




