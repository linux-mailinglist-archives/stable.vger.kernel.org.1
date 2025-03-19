Return-Path: <stable+bounces-125209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59994A690A7
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3911B66C93
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AF0213E78;
	Wed, 19 Mar 2025 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RLbFtc52"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9EC213E79;
	Wed, 19 Mar 2025 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395030; cv=none; b=e/J93uVnLSzhV2pOeyj9Xl2IACexxwdWB8/fV9BsBLiEGteqlyWci6UidWwF6491vPQsDEu2iyWnR+rg0qoACGEgj0RiIyVTzoM3l66y3SqkXwSlUmHa1H3H07lDNhWtkaVS6JTUakG4UNIPZL7vNwCm7WmFpUPFUOJizQq921c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395030; c=relaxed/simple;
	bh=/f1QS6wf3joohSTwC/VTPTkHeazGtbFRX33SJpljYQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkJJA8YC8a9mgeZ1COnLoigxPeT2ylNRBw79CgDJl8/N+Pp6VTtYfqb3a3VhyoGz/HgkmHbKbYX0OpHLedl8nwyB44DPPBidHZ7gGjWe12o9JRk+GJQdE551nuam6/9h2vyRkhFw/TEqUnBnkBI//AvlA885YC2Hz0D6p7JjERQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RLbFtc52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D44C4CEE4;
	Wed, 19 Mar 2025 14:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395029;
	bh=/f1QS6wf3joohSTwC/VTPTkHeazGtbFRX33SJpljYQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RLbFtc52wunKDWzEiwLVk1paRT9SfvfuO5C0tG1tjhOa4EKjkzN4MJzDlhEUmFTy6
	 TuyzN3KsvwbBQaROvPnkVzn+72zxFKySrm7m2FN86yLfN1yKDycWwcYBc/E8hwVJCq
	 3fe0Dcqav8gcyo4GY8pucnmXaxZQGQBi428KgHFk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jay Vosburgh <jv@jvosburgh.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 041/231] bonding: fix incorrect MAC address setting to receive NS messages
Date: Wed, 19 Mar 2025 07:28:54 -0700
Message-ID: <20250319143027.830163359@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
References: <20250319143026.865956961@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 0c5e145a350de3b38cd5ae77a401b12c46fb7c1d ]

When validation on the backup slave is enabled, we need to validate the
Neighbor Solicitation (NS) messages received on the backup slave. To
receive these messages, the correct destination MAC address must be added
to the slave. However, the target in bonding is a unicast address, which
we cannot use directly. Instead, we should first convert it to a
Solicited-Node Multicast Address and then derive the corresponding MAC
address.

Fix the incorrect MAC address setting on both slave_set_ns_maddr() and
slave_set_ns_maddrs(). Since the two function names are similar. Add
some description for the functions. Also only use one mac_addr variable
in slave_set_ns_maddr() to save some code and logic.

Fixes: 8eb36164d1a6 ("bonding: add ns target multicast address to slave device")
Acked-by: Jay Vosburgh <jv@jvosburgh.net>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250306023923.38777-2-liuhangbin@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_options.c | 55 +++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 327b6ecdc77e0..d1b095af253bd 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1242,10 +1242,28 @@ static bool slave_can_set_ns_maddr(const struct bonding *bond, struct slave *sla
 	       slave->dev->flags & IFF_MULTICAST;
 }
 
+/**
+ * slave_set_ns_maddrs - add/del all NS mac addresses for slave
+ * @bond: bond device
+ * @slave: slave device
+ * @add: add or remove all the NS mac addresses
+ *
+ * This function tries to add or delete all the NS mac addresses on the slave
+ *
+ * Note, the IPv6 NS target address is the unicast address in Neighbor
+ * Solicitation (NS) message. The dest address of NS message should be
+ * solicited-node multicast address of the target. The dest mac of NS message
+ * is converted from the solicited-node multicast address.
+ *
+ * This function is called when
+ *   * arp_validate changes
+ *   * enslaving, releasing new slaves
+ */
 static void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool add)
 {
 	struct in6_addr *targets = bond->params.ns_targets;
 	char slot_maddr[MAX_ADDR_LEN];
+	struct in6_addr mcaddr;
 	int i;
 
 	if (!slave_can_set_ns_maddr(bond, slave))
@@ -1255,7 +1273,8 @@ static void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool
 		if (ipv6_addr_any(&targets[i]))
 			break;
 
-		if (!ndisc_mc_map(&targets[i], slot_maddr, slave->dev, 0)) {
+		addrconf_addr_solict_mult(&targets[i], &mcaddr);
+		if (!ndisc_mc_map(&mcaddr, slot_maddr, slave->dev, 0)) {
 			if (add)
 				dev_mc_add(slave->dev, slot_maddr);
 			else
@@ -1278,23 +1297,43 @@ void bond_slave_ns_maddrs_del(struct bonding *bond, struct slave *slave)
 	slave_set_ns_maddrs(bond, slave, false);
 }
 
+/**
+ * slave_set_ns_maddr - set new NS mac address for slave
+ * @bond: bond device
+ * @slave: slave device
+ * @target: the new IPv6 target
+ * @slot: the old IPv6 target in the slot
+ *
+ * This function tries to replace the old mac address to new one on the slave.
+ *
+ * Note, the target/slot IPv6 address is the unicast address in Neighbor
+ * Solicitation (NS) message. The dest address of NS message should be
+ * solicited-node multicast address of the target. The dest mac of NS message
+ * is converted from the solicited-node multicast address.
+ *
+ * This function is called when
+ *   * An IPv6 NS target is added or removed.
+ */
 static void slave_set_ns_maddr(struct bonding *bond, struct slave *slave,
 			       struct in6_addr *target, struct in6_addr *slot)
 {
-	char target_maddr[MAX_ADDR_LEN], slot_maddr[MAX_ADDR_LEN];
+	char mac_addr[MAX_ADDR_LEN];
+	struct in6_addr mcast_addr;
 
 	if (!bond->params.arp_validate || !slave_can_set_ns_maddr(bond, slave))
 		return;
 
-	/* remove the previous maddr from slave */
+	/* remove the previous mac addr from slave */
+	addrconf_addr_solict_mult(slot, &mcast_addr);
 	if (!ipv6_addr_any(slot) &&
-	    !ndisc_mc_map(slot, slot_maddr, slave->dev, 0))
-		dev_mc_del(slave->dev, slot_maddr);
+	    !ndisc_mc_map(&mcast_addr, mac_addr, slave->dev, 0))
+		dev_mc_del(slave->dev, mac_addr);
 
-	/* add new maddr on slave if target is set */
+	/* add new mac addr on slave if target is set */
+	addrconf_addr_solict_mult(target, &mcast_addr);
 	if (!ipv6_addr_any(target) &&
-	    !ndisc_mc_map(target, target_maddr, slave->dev, 0))
-		dev_mc_add(slave->dev, target_maddr);
+	    !ndisc_mc_map(&mcast_addr, mac_addr, slave->dev, 0))
+		dev_mc_add(slave->dev, mac_addr);
 }
 
 static void _bond_options_ns_ip6_target_set(struct bonding *bond, int slot,
-- 
2.39.5




