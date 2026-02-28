Return-Path: <stable+bounces-220574-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APYqBxc/o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220574-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:16:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B0D1C6C78
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D1FE31BDE66
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F80D3DCED9;
	Sat, 28 Feb 2026 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imgnZFXz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7293DCEDB;
	Sat, 28 Feb 2026 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300456; cv=none; b=OTQnD7j+INR1CMtZ21bn/wTFtQ/Kq3Y6380SeWJvNwjdZD887R0Ol3ncjIVWXnB5XQZrfXIgh9ecF6I92kkJjjtfrrae7jSX3Twf6eqo3HE49pzdtbhPL0mas4++uzYIoMwMeLVMkQq2xk/ivSlxiEe+37TUpHlDhnBBdslGspM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300456; c=relaxed/simple;
	bh=/X2qo0fxVpWKGEpHPfNQHbX/j4hmYZWEuxoIb69Wglk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3/5+JrY3dQYAG2Z6z6HZXQWRrM/pQGNOh3MWZOV14Jaadk1nHBLHtrB51xjASwINAnQI/KeSV/DkoyLy+ZdEaV26MMGjW3hI31LNZyfVlmZDmn99n11N2SSXlMxR7kg0H+cTAte0Kl9SiBDtDOGAFsA6PbkP9sSrVfWxpuFajM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imgnZFXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7277C116D0;
	Sat, 28 Feb 2026 17:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300455;
	bh=/X2qo0fxVpWKGEpHPfNQHbX/j4hmYZWEuxoIb69Wglk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=imgnZFXz4w9TJhhUIi6qDtvGKfsbUiWejbZIdu42JSxifFZVjcPRdpNxxkOUT8JPp
	 TfoDlzcrWt5UJEDiO+P1qGuJc0eM/IFGbBIo7H1vfF8bvzwOrbm6QUk6jVkdGoQZyN
	 ZBAo+fehqZw10hQSFtHpEgkAFS4fhIa6V8ZwwXq5iMHBCAw3lCWLWrd8ww4iY1f4zj
	 le9yMvSskHwxaai+nzeRKbanzBHScXYe+ysf5NiNqu1pt9YQoEyAd3evDwX5+wqWLc
	 gVShJc5e2sB05k5e6tp96a4UB3EoXeNb+NMyAhoLZ4OHwLxr0UslX11FFHg56HG3D+
	 EOBmDE1o1HeHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com,
	Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 495/844] team: avoid NETDEV_CHANGEMTU event when unregistering slave
Date: Sat, 28 Feb 2026 12:26:48 -0500
Message-ID: <20260228173244.1509663-496-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220574-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[stable,881d65229ca4f9ae8c84];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,msgid.link:url,appspotmail.com:email,nvidia.com:email,ffff88807dcf8618:email,i-love.sakura.ne.jp:email,fomichev.me:email]
X-Rspamd-Queue-Id: 94B0D1C6C78
X-Rspamd-Action: no action

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit bb4c698633c0e19717586a6524a33196cff01a32 ]

syzbot is reporting

  unregister_netdevice: waiting for netdevsim0 to become free. Usage count = 3
  ref_tracker: netdev@ffff88807dcf8618 has 1/2 users at
       __netdev_tracker_alloc include/linux/netdevice.h:4400 [inline]
       netdev_hold include/linux/netdevice.h:4429 [inline]
       inetdev_init+0x201/0x4e0 net/ipv4/devinet.c:286
       inetdev_event+0x251/0x1610 net/ipv4/devinet.c:1600
       notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
       call_netdevice_notifiers_mtu net/core/dev.c:2318 [inline]
       netif_set_mtu_ext+0x5aa/0x800 net/core/dev.c:9886
       netif_set_mtu+0xd7/0x1b0 net/core/dev.c:9907
       dev_set_mtu+0x126/0x260 net/core/dev_api.c:248
       team_port_del+0xb07/0xcb0 drivers/net/team/team_core.c:1333
       team_del_slave drivers/net/team/team_core.c:1936 [inline]
       team_device_event+0x207/0x5b0 drivers/net/team/team_core.c:2929
       notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2281 [inline]
       call_netdevice_notifiers net/core/dev.c:2295 [inline]
       __dev_change_net_namespace+0xcb7/0x2050 net/core/dev.c:12592
       do_setlink+0x2ce/0x4590 net/core/rtnetlink.c:3060
       rtnl_changelink net/core/rtnetlink.c:3776 [inline]
       __rtnl_newlink net/core/rtnetlink.c:3935 [inline]
       rtnl_newlink+0x15a9/0x1be0 net/core/rtnetlink.c:4072
       rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6958
       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894

problem. Ido Schimmel found steps to reproduce

  ip link add name team1 type team
  ip link add name dummy1 mtu 1499 master team1 type dummy
  ip netns add ns1
  ip link set dev dummy1 netns ns1
  ip -n ns1 link del dev dummy1

and also found that the same issue was fixed in the bond driver in
commit f51048c3e07b ("bonding: avoid NETDEV_CHANGEMTU event when
unregistering slave").

Let's do similar thing for the team driver, with commit ad7c7b2172c3 ("net:
hold netdev instance lock during sysfs operations") and commit 303a8487a657
("net: s/__dev_set_mtu/__netif_set_mtu/") also applied.

Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Link: https://patch.msgid.link/20260224125709.317574-2-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/team/team_core.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index c08a5c1bd6e4d..a0fe998cc055d 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1292,7 +1292,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 
 static void __team_port_change_port_removed(struct team_port *port);
 
-static int team_port_del(struct team *team, struct net_device *port_dev)
+static int team_port_del(struct team *team, struct net_device *port_dev, bool unregister)
 {
 	struct net_device *dev = team->dev;
 	struct team_port *port;
@@ -1330,7 +1330,13 @@ static int team_port_del(struct team *team, struct net_device *port_dev)
 	__team_port_change_port_removed(port);
 
 	team_port_set_orig_dev_addr(port);
-	dev_set_mtu(port_dev, port->orig.mtu);
+	if (unregister) {
+		netdev_lock_ops(port_dev);
+		__netif_set_mtu(port_dev, port->orig.mtu);
+		netdev_unlock_ops(port_dev);
+	} else {
+		dev_set_mtu(port_dev, port->orig.mtu);
+	}
 	kfree_rcu(port, rcu);
 	netdev_info(dev, "Port device %s removed\n", portname);
 	netdev_compute_master_upper_features(team->dev, true);
@@ -1634,7 +1640,7 @@ static void team_uninit(struct net_device *dev)
 	ASSERT_RTNL();
 
 	list_for_each_entry_safe(port, tmp, &team->port_list, list)
-		team_port_del(team, port->dev);
+		team_port_del(team, port->dev, false);
 
 	__team_change_mode(team, NULL); /* cleanup */
 	__team_options_unregister(team, team_options, ARRAY_SIZE(team_options));
@@ -1933,7 +1939,16 @@ static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
 
 	ASSERT_RTNL();
 
-	return team_port_del(team, port_dev);
+	return team_port_del(team, port_dev, false);
+}
+
+static int team_del_slave_on_unregister(struct net_device *dev, struct net_device *port_dev)
+{
+	struct team *team = netdev_priv(dev);
+
+	ASSERT_RTNL();
+
+	return team_port_del(team, port_dev, true);
 }
 
 static netdev_features_t team_fix_features(struct net_device *dev,
@@ -2926,7 +2941,7 @@ static int team_device_event(struct notifier_block *unused,
 					       !!netif_oper_up(port->dev));
 		break;
 	case NETDEV_UNREGISTER:
-		team_del_slave(port->team->dev, dev);
+		team_del_slave_on_unregister(port->team->dev, dev);
 		break;
 	case NETDEV_FEAT_CHANGE:
 		if (!port->team->notifier_ctx) {
@@ -2999,3 +3014,4 @@ MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Jiri Pirko <jpirko@redhat.com>");
 MODULE_DESCRIPTION("Ethernet team device driver");
 MODULE_ALIAS_RTNL_LINK(DRV_NAME);
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
-- 
2.51.0


