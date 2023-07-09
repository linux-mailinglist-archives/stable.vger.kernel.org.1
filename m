Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD2B74C2CE
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjGILY6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjGILY5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:24:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117281A5
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:24:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89D1560BC9
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A00EC433C8;
        Sun,  9 Jul 2023 11:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901895;
        bh=1c9KlyVyZon1eaO2PmUGJfgl4tRhAYa+Qlsl/10fatM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OL6PzyE/7x+WZ9s6p8NiuCJjTBHNBqiCm64/dHehNngps8G9KqPHezLblEJmp/pPb
         C6/I3FC1zpwwr40oZyOKt+y/961hzcDDYO4HZHFPZ3j2E9yrqJkNm7iXlUGPcjNi/h
         khtHbBh7yanLyTmJ5P9AliC/IiBUxz1hikspQXas=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 155/431] net: dsa: avoid suspicious RCU usage for synced VLAN-aware MAC addresses
Date:   Sun,  9 Jul 2023 13:11:43 +0200
Message-ID: <20230709111454.799197435@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit d06f925f13976ab82167c93467c70a337a0a3cda ]

When using the felix driver (the only one which supports UC filtering
and MC filtering) as a DSA master for a random other DSA switch, one can
see the following stack trace when the downstream switch ports join a
VLAN-aware bridge:

=============================
WARNING: suspicious RCU usage
-----------------------------
net/8021q/vlan_core.c:238 suspicious rcu_dereference_protected() usage!

stack backtrace:
Workqueue: dsa_ordered dsa_slave_switchdev_event_work
Call trace:
 lockdep_rcu_suspicious+0x170/0x210
 vlan_for_each+0x8c/0x188
 dsa_slave_sync_uc+0x128/0x178
 __hw_addr_sync_dev+0x138/0x158
 dsa_slave_set_rx_mode+0x58/0x70
 __dev_set_rx_mode+0x88/0xa8
 dev_uc_add+0x74/0xa0
 dsa_port_bridge_host_fdb_add+0xec/0x180
 dsa_slave_switchdev_event_work+0x7c/0x1c8
 process_one_work+0x290/0x568

What it's saying is that vlan_for_each() expects rtnl_lock() context and
it's not getting it, when it's called from the DSA master's ndo_set_rx_mode().

The caller of that - dsa_slave_set_rx_mode() - is the slave DSA
interface's dsa_port_bridge_host_fdb_add() which comes from the deferred
dsa_slave_switchdev_event_work().

We went to great lengths to avoid the rtnl_lock() context in that call
path in commit 0faf890fc519 ("net: dsa: drop rtnl_lock from
dsa_slave_switchdev_event_work"), and calling rtnl_lock() is simply not
an option due to the possibility of deadlocking when calling
dsa_flush_workqueue() from the call paths that do hold rtnl_lock() -
basically all of them.

So, when the DSA master calls vlan_for_each() from its ndo_set_rx_mode(),
the state of the 8021q driver on this device is really not protected
from concurrent access by anything.

Looking at net/8021q/, I don't think that vlan_info->vid_list was
particularly designed with RCU traversal in mind, so introducing an RCU
read-side form of vlan_for_each() - vlan_for_each_rcu() - won't be so
easy, and it also wouldn't be exactly what we need anyway.

In general I believe that the solution isn't in net/8021q/ anyway;
vlan_for_each() is not cut out for this task. DSA doesn't need rtnl_lock()
to be held per se - since it's not a netdev state change that we're
blocking, but rather, just concurrent additions/removals to a VLAN list.
We don't even need sleepable context - the callback of vlan_for_each()
just schedules deferred work.

The proposed escape is to remove the dependency on vlan_for_each() and
to open-code a non-sleepable, rtnl-free alternative to that, based on
copies of the VLAN list modified from .ndo_vlan_rx_add_vid() and
.ndo_vlan_rx_kill_vid().

Fixes: 64fdc5f341db ("net: dsa: sync unicast and multicast addresses for VLAN filters too")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://lore.kernel.org/r/20230626154402.3154454-1-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/dsa.h | 12 +++++--
 net/dsa/dsa.c     |  2 +-
 net/dsa/slave.c   | 84 ++++++++++++++++++++++++++++++++---------------
 net/dsa/switch.c  |  4 +--
 net/dsa/switch.h  |  3 ++
 5 files changed, 74 insertions(+), 31 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index def06ef676dd8..56e297e7848d6 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -329,9 +329,17 @@ struct dsa_port {
 	struct list_head	fdbs;
 	struct list_head	mdbs;
 
-	/* List of VLANs that CPU and DSA ports are members of. */
 	struct mutex		vlans_lock;
-	struct list_head	vlans;
+	union {
+		/* List of VLANs that CPU and DSA ports are members of.
+		 * Access to this is serialized by the sleepable @vlans_lock.
+		 */
+		struct list_head	vlans;
+		/* List of VLANs that user ports are members of.
+		 * Access to this is serialized by netif_addr_lock_bh().
+		 */
+		struct list_head	user_vlans;
+	};
 };
 
 /* TODO: ideally DSA ports would have a single dp->link_dp member,
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 6cd8607a3928f..390d790c0b056 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1105,7 +1105,7 @@ static struct dsa_port *dsa_port_touch(struct dsa_switch *ds, int index)
 	mutex_init(&dp->vlans_lock);
 	INIT_LIST_HEAD(&dp->fdbs);
 	INIT_LIST_HEAD(&dp->mdbs);
-	INIT_LIST_HEAD(&dp->vlans);
+	INIT_LIST_HEAD(&dp->vlans); /* also initializes &dp->user_vlans */
 	INIT_LIST_HEAD(&dp->list);
 	list_add_tail(&dp->list, &dst->ports);
 
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 165bb2cb84316..527b1d576460f 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -27,6 +27,7 @@
 #include "master.h"
 #include "netlink.h"
 #include "slave.h"
+#include "switch.h"
 #include "tag.h"
 
 struct dsa_switchdev_event_work {
@@ -161,8 +162,7 @@ static int dsa_slave_schedule_standalone_work(struct net_device *dev,
 	return 0;
 }
 
-static int dsa_slave_host_vlan_rx_filtering(struct net_device *vdev, int vid,
-					    void *arg)
+static int dsa_slave_host_vlan_rx_filtering(void *arg, int vid)
 {
 	struct dsa_host_vlan_rx_filtering_ctx *ctx = arg;
 
@@ -170,6 +170,28 @@ static int dsa_slave_host_vlan_rx_filtering(struct net_device *vdev, int vid,
 						  ctx->addr, vid);
 }
 
+static int dsa_slave_vlan_for_each(struct net_device *dev,
+				   int (*cb)(void *arg, int vid), void *arg)
+{
+	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_vlan *v;
+	int err;
+
+	lockdep_assert_held(&dev->addr_list_lock);
+
+	err = cb(arg, 0);
+	if (err)
+		return err;
+
+	list_for_each_entry(v, &dp->user_vlans, list) {
+		err = cb(arg, v->vid);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int dsa_slave_sync_uc(struct net_device *dev,
 			     const unsigned char *addr)
 {
@@ -180,18 +202,14 @@ static int dsa_slave_sync_uc(struct net_device *dev,
 		.addr = addr,
 		.event = DSA_UC_ADD,
 	};
-	int err;
 
 	dev_uc_add(master, addr);
 
 	if (!dsa_switch_supports_uc_filtering(dp->ds))
 		return 0;
 
-	err = dsa_slave_schedule_standalone_work(dev, DSA_UC_ADD, addr, 0);
-	if (err)
-		return err;
-
-	return vlan_for_each(dev, dsa_slave_host_vlan_rx_filtering, &ctx);
+	return dsa_slave_vlan_for_each(dev, dsa_slave_host_vlan_rx_filtering,
+				       &ctx);
 }
 
 static int dsa_slave_unsync_uc(struct net_device *dev,
@@ -204,18 +222,14 @@ static int dsa_slave_unsync_uc(struct net_device *dev,
 		.addr = addr,
 		.event = DSA_UC_DEL,
 	};
-	int err;
 
 	dev_uc_del(master, addr);
 
 	if (!dsa_switch_supports_uc_filtering(dp->ds))
 		return 0;
 
-	err = dsa_slave_schedule_standalone_work(dev, DSA_UC_DEL, addr, 0);
-	if (err)
-		return err;
-
-	return vlan_for_each(dev, dsa_slave_host_vlan_rx_filtering, &ctx);
+	return dsa_slave_vlan_for_each(dev, dsa_slave_host_vlan_rx_filtering,
+				       &ctx);
 }
 
 static int dsa_slave_sync_mc(struct net_device *dev,
@@ -228,18 +242,14 @@ static int dsa_slave_sync_mc(struct net_device *dev,
 		.addr = addr,
 		.event = DSA_MC_ADD,
 	};
-	int err;
 
 	dev_mc_add(master, addr);
 
 	if (!dsa_switch_supports_mc_filtering(dp->ds))
 		return 0;
 
-	err = dsa_slave_schedule_standalone_work(dev, DSA_MC_ADD, addr, 0);
-	if (err)
-		return err;
-
-	return vlan_for_each(dev, dsa_slave_host_vlan_rx_filtering, &ctx);
+	return dsa_slave_vlan_for_each(dev, dsa_slave_host_vlan_rx_filtering,
+				       &ctx);
 }
 
 static int dsa_slave_unsync_mc(struct net_device *dev,
@@ -252,18 +262,14 @@ static int dsa_slave_unsync_mc(struct net_device *dev,
 		.addr = addr,
 		.event = DSA_MC_DEL,
 	};
-	int err;
 
 	dev_mc_del(master, addr);
 
 	if (!dsa_switch_supports_mc_filtering(dp->ds))
 		return 0;
 
-	err = dsa_slave_schedule_standalone_work(dev, DSA_MC_DEL, addr, 0);
-	if (err)
-		return err;
-
-	return vlan_for_each(dev, dsa_slave_host_vlan_rx_filtering, &ctx);
+	return dsa_slave_vlan_for_each(dev, dsa_slave_host_vlan_rx_filtering,
+				       &ctx);
 }
 
 void dsa_slave_sync_ha(struct net_device *dev)
@@ -1759,6 +1765,7 @@ static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
 	struct netlink_ext_ack extack = {0};
 	struct dsa_switch *ds = dp->ds;
 	struct netdev_hw_addr *ha;
+	struct dsa_vlan *v;
 	int ret;
 
 	/* User port... */
@@ -1782,8 +1789,17 @@ static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
 	    !dsa_switch_supports_mc_filtering(ds))
 		return 0;
 
+	v = kzalloc(sizeof(*v), GFP_KERNEL);
+	if (!v) {
+		ret = -ENOMEM;
+		goto rollback;
+	}
+
 	netif_addr_lock_bh(dev);
 
+	v->vid = vid;
+	list_add_tail(&v->list, &dp->user_vlans);
+
 	if (dsa_switch_supports_mc_filtering(ds)) {
 		netdev_for_each_synced_mc_addr(ha, dev) {
 			dsa_slave_schedule_standalone_work(dev, DSA_MC_ADD,
@@ -1803,6 +1819,12 @@ static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
 	dsa_flush_workqueue();
 
 	return 0;
+
+rollback:
+	dsa_port_host_vlan_del(dp, &vlan);
+	dsa_port_vlan_del(dp, &vlan);
+
+	return ret;
 }
 
 static int dsa_slave_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
@@ -1816,6 +1838,7 @@ static int dsa_slave_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
 	};
 	struct dsa_switch *ds = dp->ds;
 	struct netdev_hw_addr *ha;
+	struct dsa_vlan *v;
 	int err;
 
 	err = dsa_port_vlan_del(dp, &vlan);
@@ -1832,6 +1855,15 @@ static int dsa_slave_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
 
 	netif_addr_lock_bh(dev);
 
+	v = dsa_vlan_find(&dp->user_vlans, &vlan);
+	if (!v) {
+		netif_addr_unlock_bh(dev);
+		return -ENOENT;
+	}
+
+	list_del(&v->list);
+	kfree(v);
+
 	if (dsa_switch_supports_mc_filtering(ds)) {
 		netdev_for_each_synced_mc_addr(ha, dev) {
 			dsa_slave_schedule_standalone_work(dev, DSA_MC_DEL,
diff --git a/net/dsa/switch.c b/net/dsa/switch.c
index d5bc4bb7310dc..36f8ffea2d168 100644
--- a/net/dsa/switch.c
+++ b/net/dsa/switch.c
@@ -634,8 +634,8 @@ static bool dsa_port_host_vlan_match(struct dsa_port *dp,
 	return false;
 }
 
-static struct dsa_vlan *dsa_vlan_find(struct list_head *vlan_list,
-				      const struct switchdev_obj_port_vlan *vlan)
+struct dsa_vlan *dsa_vlan_find(struct list_head *vlan_list,
+			       const struct switchdev_obj_port_vlan *vlan)
 {
 	struct dsa_vlan *v;
 
diff --git a/net/dsa/switch.h b/net/dsa/switch.h
index 15e67b95eb6e1..ea034677da153 100644
--- a/net/dsa/switch.h
+++ b/net/dsa/switch.h
@@ -111,6 +111,9 @@ struct dsa_notifier_master_state_info {
 	bool operational;
 };
 
+struct dsa_vlan *dsa_vlan_find(struct list_head *vlan_list,
+			       const struct switchdev_obj_port_vlan *vlan);
+
 int dsa_tree_notify(struct dsa_switch_tree *dst, unsigned long e, void *v);
 int dsa_broadcast(unsigned long e, void *v);
 
-- 
2.39.2



