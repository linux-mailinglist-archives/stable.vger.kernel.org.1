Return-Path: <stable+bounces-24987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670E9869730
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B89B1C23B42
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4FC1419B3;
	Tue, 27 Feb 2024 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K33rpJTR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50C51419A0;
	Tue, 27 Feb 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043541; cv=none; b=tQr1rIlpWrNwWWY5/ObLBkRK7fsZg+j5kL/ivxYLOuh6U/W4n6PemhYDhawU6i02o+oad23xg4ZYVTl/TwpZYGKePbPVWSVYwFmWFeVCEhGWbG50r7FC5dBC9PdXzA4bazsSGlLQA3lQObmPNT9BO4pHVm7Np2Nx4Tk45mGf6Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043541; c=relaxed/simple;
	bh=+dVqH3kOGSe60lZXWp9saEnkMULwH/Vt57z32fQ1j2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuH2SLoq/X/EQqJXquJINqa/wtnxL//9jD/pqzaWo2iP4rovxE8rzljNxTf34mr8+uVUwBMLoEUjohQyNSUXdYu20GXL94+wzkkVNjzUCgltHMKXGuT9YKrjdtaE+e/p2bFn3grPo60kvSDLrg3Tptzmp0MsIJ4dz76lLhdEIfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K33rpJTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F59C433C7;
	Tue, 27 Feb 2024 14:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043541;
	bh=+dVqH3kOGSe60lZXWp9saEnkMULwH/Vt57z32fQ1j2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K33rpJTRWqlJFyvlCSBLL69g2iOjxObzFbauvEJJqzo+gpgE+flUKTiqBxVd2kFNF
	 LOaWJX3Snm4Sds4EmREUiQjyjxIw1GZJ/XCzoyykiZooyp39Ew5INv3A9hZJX2a1IT
	 R6yr3dquDwfTVd4BKCOqXGRrYOsv97FwrIqWayMc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 146/195] net: bridge: switchdev: Skip MDB replays of deferred events on offload
Date: Tue, 27 Feb 2024 14:26:47 +0100
Message-ID: <20240227131615.242376272@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
References: <20240227131610.391465389@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tobias Waldekranz <tobias@waldekranz.com>

[ Upstream commit dc489f86257cab5056e747344f17a164f63bff4b ]

Before this change, generation of the list of MDB events to replay
would race against the creation of new group memberships, either from
the IGMP/MLD snooping logic or from user configuration.

While new memberships are immediately visible to walkers of
br->mdb_list, the notification of their existence to switchdev event
subscribers is deferred until a later point in time. So if a replay
list was generated during a time that overlapped with such a window,
it would also contain a replay of the not-yet-delivered event.

The driver would thus receive two copies of what the bridge internally
considered to be one single event. On destruction of the bridge, only
a single membership deletion event was therefore sent. As a
consequence of this, drivers which reference count memberships (at
least DSA), would be left with orphan groups in their hardware
database when the bridge was destroyed.

This is only an issue when replaying additions. While deletion events
may still be pending on the deferred queue, they will already have
been removed from br->mdb_list, so no duplicates can be generated in
that scenario.

To a user this meant that old group memberships, from a bridge in
which a port was previously attached, could be reanimated (in
hardware) when the port joined a new bridge, without the new bridge's
knowledge.

For example, on an mv88e6xxx system, create a snooping bridge and
immediately add a port to it:

    root@infix-06-0b-00:~$ ip link add dev br0 up type bridge mcast_snooping 1 && \
    > ip link set dev x3 up master br0

And then destroy the bridge:

    root@infix-06-0b-00:~$ ip link del dev br0
    root@infix-06-0b-00:~$ mvls atu
    ADDRESS             FID  STATE      Q  F  0  1  2  3  4  5  6  7  8  9  a
    DEV:0 Marvell 88E6393X
    33:33:00:00:00:6a     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
    33:33:ff:87:e4:3f     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
    ff:ff:ff:ff:ff:ff     1  static     -  -  0  1  2  3  4  5  6  7  8  9  a
    root@infix-06-0b-00:~$

The two IPv6 groups remain in the hardware database because the
port (x3) is notified of the host's membership twice: once via the
original event and once via a replay. Since only a single delete
notification is sent, the count remains at 1 when the bridge is
destroyed.

Then add the same port (or another port belonging to the same hardware
domain) to a new bridge, this time with snooping disabled:

    root@infix-06-0b-00:~$ ip link add dev br1 up type bridge mcast_snooping 0 && \
    > ip link set dev x3 up master br1

All multicast, including the two IPv6 groups from br0, should now be
flooded, according to the policy of br1. But instead the old
memberships are still active in the hardware database, causing the
switch to only forward traffic to those groups towards the CPU (port
0).

Eliminate the race in two steps:

1. Grab the write-side lock of the MDB while generating the replay
   list.

This prevents new memberships from showing up while we are generating
the replay list. But it leaves the scenario in which a deferred event
was already generated, but not delivered, before we grabbed the
lock. Therefore:

2. Make sure that no deferred version of a replay event is already
   enqueued to the switchdev deferred queue, before adding it to the
   replay list, when replaying additions.

Fixes: 4f2673b3a2b6 ("net: bridge: add helper to replay port and host-joined mdb entries")
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/switchdev.h   |  3 ++
 net/bridge/br_switchdev.c | 74 ++++++++++++++++++++++++---------------
 net/switchdev/switchdev.c | 73 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+), 28 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 7dcdc97c0bc33..a3d8f013adcd5 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -303,6 +303,9 @@ void switchdev_deferred_process(void);
 int switchdev_port_attr_set(struct net_device *dev,
 			    const struct switchdev_attr *attr,
 			    struct netlink_ext_ack *extack);
+bool switchdev_port_obj_act_is_deferred(struct net_device *dev,
+					enum switchdev_notifier_type nt,
+					const struct switchdev_obj *obj);
 int switchdev_port_obj_add(struct net_device *dev,
 			   const struct switchdev_obj *obj,
 			   struct netlink_ext_ack *extack);
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 4b3982c368b35..65567d1c8b853 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -593,21 +593,40 @@ br_switchdev_mdb_replay_one(struct notifier_block *nb, struct net_device *dev,
 }
 
 static int br_switchdev_mdb_queue_one(struct list_head *mdb_list,
+				      struct net_device *dev,
+				      unsigned long action,
 				      enum switchdev_obj_id id,
 				      const struct net_bridge_mdb_entry *mp,
 				      struct net_device *orig_dev)
 {
-	struct switchdev_obj_port_mdb *mdb;
+	struct switchdev_obj_port_mdb mdb = {
+		.obj = {
+			.id = id,
+			.orig_dev = orig_dev,
+		},
+	};
+	struct switchdev_obj_port_mdb *pmdb;
 
-	mdb = kzalloc(sizeof(*mdb), GFP_ATOMIC);
-	if (!mdb)
-		return -ENOMEM;
+	br_switchdev_mdb_populate(&mdb, mp);
 
-	mdb->obj.id = id;
-	mdb->obj.orig_dev = orig_dev;
-	br_switchdev_mdb_populate(mdb, mp);
-	list_add_tail(&mdb->obj.list, mdb_list);
+	if (action == SWITCHDEV_PORT_OBJ_ADD &&
+	    switchdev_port_obj_act_is_deferred(dev, action, &mdb.obj)) {
+		/* This event is already in the deferred queue of
+		 * events, so this replay must be elided, lest the
+		 * driver receives duplicate events for it. This can
+		 * only happen when replaying additions, since
+		 * modifications are always immediately visible in
+		 * br->mdb_list, whereas actual event delivery may be
+		 * delayed.
+		 */
+		return 0;
+	}
+
+	pmdb = kmemdup(&mdb, sizeof(mdb), GFP_ATOMIC);
+	if (!pmdb)
+		return -ENOMEM;
 
+	list_add_tail(&pmdb->obj.list, mdb_list);
 	return 0;
 }
 
@@ -675,51 +694,50 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
 	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
 		return 0;
 
-	/* We cannot walk over br->mdb_list protected just by the rtnl_mutex,
-	 * because the write-side protection is br->multicast_lock. But we
-	 * need to emulate the [ blocking ] calling context of a regular
-	 * switchdev event, so since both br->multicast_lock and RCU read side
-	 * critical sections are atomic, we have no choice but to pick the RCU
-	 * read side lock, queue up all our events, leave the critical section
-	 * and notify switchdev from blocking context.
+	if (adding)
+		action = SWITCHDEV_PORT_OBJ_ADD;
+	else
+		action = SWITCHDEV_PORT_OBJ_DEL;
+
+	/* br_switchdev_mdb_queue_one() will take care to not queue a
+	 * replay of an event that is already pending in the switchdev
+	 * deferred queue. In order to safely determine that, there
+	 * must be no new deferred MDB notifications enqueued for the
+	 * duration of the MDB scan. Therefore, grab the write-side
+	 * lock to avoid racing with any concurrent IGMP/MLD snooping.
 	 */
-	rcu_read_lock();
+	spin_lock_bh(&br->multicast_lock);
 
-	hlist_for_each_entry_rcu(mp, &br->mdb_list, mdb_node) {
+	hlist_for_each_entry(mp, &br->mdb_list, mdb_node) {
 		struct net_bridge_port_group __rcu * const *pp;
 		const struct net_bridge_port_group *p;
 
 		if (mp->host_joined) {
-			err = br_switchdev_mdb_queue_one(&mdb_list,
+			err = br_switchdev_mdb_queue_one(&mdb_list, dev, action,
 							 SWITCHDEV_OBJ_ID_HOST_MDB,
 							 mp, br_dev);
 			if (err) {
-				rcu_read_unlock();
+				spin_unlock_bh(&br->multicast_lock);
 				goto out_free_mdb;
 			}
 		}
 
-		for (pp = &mp->ports; (p = rcu_dereference(*pp)) != NULL;
+		for (pp = &mp->ports; (p = mlock_dereference(*pp, br)) != NULL;
 		     pp = &p->next) {
 			if (p->key.port->dev != dev)
 				continue;
 
-			err = br_switchdev_mdb_queue_one(&mdb_list,
+			err = br_switchdev_mdb_queue_one(&mdb_list, dev, action,
 							 SWITCHDEV_OBJ_ID_PORT_MDB,
 							 mp, dev);
 			if (err) {
-				rcu_read_unlock();
+				spin_unlock_bh(&br->multicast_lock);
 				goto out_free_mdb;
 			}
 		}
 	}
 
-	rcu_read_unlock();
-
-	if (adding)
-		action = SWITCHDEV_PORT_OBJ_ADD;
-	else
-		action = SWITCHDEV_PORT_OBJ_DEL;
+	spin_unlock_bh(&br->multicast_lock);
 
 	list_for_each_entry(obj, &mdb_list, list) {
 		err = br_switchdev_mdb_replay_one(nb, dev,
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 8cc42aea19c7e..2e14d4c37e2dc 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -19,6 +19,35 @@
 #include <linux/rtnetlink.h>
 #include <net/switchdev.h>
 
+static bool switchdev_obj_eq(const struct switchdev_obj *a,
+			     const struct switchdev_obj *b)
+{
+	const struct switchdev_obj_port_vlan *va, *vb;
+	const struct switchdev_obj_port_mdb *ma, *mb;
+
+	if (a->id != b->id || a->orig_dev != b->orig_dev)
+		return false;
+
+	switch (a->id) {
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		va = SWITCHDEV_OBJ_PORT_VLAN(a);
+		vb = SWITCHDEV_OBJ_PORT_VLAN(b);
+		return va->flags == vb->flags &&
+			va->vid == vb->vid &&
+			va->changed == vb->changed;
+	case SWITCHDEV_OBJ_ID_PORT_MDB:
+	case SWITCHDEV_OBJ_ID_HOST_MDB:
+		ma = SWITCHDEV_OBJ_PORT_MDB(a);
+		mb = SWITCHDEV_OBJ_PORT_MDB(b);
+		return ma->vid == mb->vid &&
+			ether_addr_equal(ma->addr, mb->addr);
+	default:
+		break;
+	}
+
+	BUG();
+}
+
 static LIST_HEAD(deferred);
 static DEFINE_SPINLOCK(deferred_lock);
 
@@ -307,6 +336,50 @@ int switchdev_port_obj_del(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
 
+/**
+ *	switchdev_port_obj_act_is_deferred - Is object action pending?
+ *
+ *	@dev: port device
+ *	@nt: type of action; add or delete
+ *	@obj: object to test
+ *
+ *	Returns true if a deferred item is pending, which is
+ *	equivalent to the action @nt on an object @obj.
+ *
+ *	rtnl_lock must be held.
+ */
+bool switchdev_port_obj_act_is_deferred(struct net_device *dev,
+					enum switchdev_notifier_type nt,
+					const struct switchdev_obj *obj)
+{
+	struct switchdev_deferred_item *dfitem;
+	bool found = false;
+
+	ASSERT_RTNL();
+
+	spin_lock_bh(&deferred_lock);
+
+	list_for_each_entry(dfitem, &deferred, list) {
+		if (dfitem->dev != dev)
+			continue;
+
+		if ((dfitem->func == switchdev_port_obj_add_deferred &&
+		     nt == SWITCHDEV_PORT_OBJ_ADD) ||
+		    (dfitem->func == switchdev_port_obj_del_deferred &&
+		     nt == SWITCHDEV_PORT_OBJ_DEL)) {
+			if (switchdev_obj_eq((const void *)dfitem->data, obj)) {
+				found = true;
+				break;
+			}
+		}
+	}
+
+	spin_unlock_bh(&deferred_lock);
+
+	return found;
+}
+EXPORT_SYMBOL_GPL(switchdev_port_obj_act_is_deferred);
+
 static ATOMIC_NOTIFIER_HEAD(switchdev_notif_chain);
 static BLOCKING_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
 
-- 
2.43.0




