Return-Path: <stable+bounces-213310-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMlEF9VegmnTTAMAu9opvQ
	(envelope-from <stable+bounces-213310-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 21:47:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6E5DEA03
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 21:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DED73030EC5
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 20:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D30226AA91;
	Tue,  3 Feb 2026 20:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CHS4pvDC"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EDA23EA8B;
	Tue,  3 Feb 2026 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770151633; cv=none; b=GFrJ0HN9dlWzunin8bgTyLAayACARSPcwCIrkt728ZCSW0JJx/ODnwx+8ULUyGQSlVaoLFikq/uokwaKdW9Haa02zG+21BPtNWp2Ul0BFobMrfdlER1l2yC0aUhH+7DQi6axOxhRA3QgzO24ib4ARua65bVoFhez70wG5+Pe62s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770151633; c=relaxed/simple;
	bh=n8Gu1b6SVDUvp7nMHZ45WgmNneWHYh6TPZPyxkK2XdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wq9C9Cb/2urvaddhHMEnf5uwzRt4DUpjuM8cBqgmf/uAAGp9yhYXj8nNpnZk8v40JiG82QKZ5W4b1903qQcZb9/J7+Xr0ueq7rjLBTVeMUIZaLeSQyf+GMTlEt7AEclt3IGo7GGXuBhZXWd4uKl/Kq4WpnJU4SCYrucZ91V2OXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CHS4pvDC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id A965220B7167; Tue,  3 Feb 2026 12:47:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A965220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770151631;
	bh=2TqzsAPsciPuY7IjVQVwvxX799dWOrqhumxNF/w71wk=;
	h=From:To:Cc:Subject:Date:From;
	b=CHS4pvDC/BYZ8Nr6yb6NfSqM8tzn3+Vf7mNVXuIaBMO6GRw7dZirnWkTM1e6FtoGd
	 xa8a0Ra78Wz+AdoMwfc5tgUJEsqtfGDrkGwjIH/Fi/JqBQLw7fTBiiyiycCU7fk63H
	 sA/k80+EymyTLuY8pOGFtWpv6XsrYFKuC451ddD8=
From: longli@linux.microsoft.com
To: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	stable@kernel.org
Subject: [Patch 6.12.y 1/2] net: mana: Change the function signature of mana_get_primary_netdev_rcu
Date: Tue,  3 Feb 2026 12:45:23 -0800
Message-ID: <20260203204524.827567-1-longli@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213310-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@linux.microsoft.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 1E6E5DEA03
X-Rspamd-Action: no action

From: Long Li <longli@microsoft.com>

commit a8445cfec101c42e9d64cdb2dac13973b22c205c upstream.

Change mana_get_primary_netdev_rcu() to mana_get_primary_netdev(), and
return the ndev with refcount held. The caller is responsible for dropping
the refcount.

Also drop the check for IFF_SLAVE as it is not necessary if the upper
device is present.

Signed-off-by: Long Li <longli@microsoft.com>
Link: https://patch.msgid.link/1741821332-9392-1-git-send-email-longli@linuxonhyperv.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Fixes: 1df03a4b4414 ("RDMA/mana_ib: Set correct device into ib")
Cc: stable@kernel.org
---
 drivers/infiniband/hw/mana/device.c           |  7 +++---
 drivers/infiniband/hw/mana/mana_ib.h          |  1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c | 22 ++++++++++++-------
 include/net/mana/mana.h                       |  4 +++-
 4 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 7ac01918ef7c..7a1d5c250965 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -84,10 +84,8 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	dev->ib_dev.num_comp_vectors = mdev->gdma_context->max_num_queues;
 	dev->ib_dev.dev.parent = mdev->gdma_context->dev;
 
-	rcu_read_lock(); /* required to get primary netdev */
-	ndev = mana_get_primary_netdev_rcu(mc, 0);
+	ndev = mana_get_primary_netdev(mc, 0, &dev->dev_tracker);
 	if (!ndev) {
-		rcu_read_unlock();
 		ret = -ENODEV;
 		ibdev_err(&dev->ib_dev, "Failed to get netdev for IB port 1");
 		goto free_ib_device;
@@ -95,7 +93,8 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	ether_addr_copy(mac_addr, ndev->dev_addr);
 	addrconf_addr_eui48((u8 *)&dev->ib_dev.node_guid, ndev->dev_addr);
 	ret = ib_device_set_netdev(&dev->ib_dev, ndev, 1);
-	rcu_read_unlock();
+	/* mana_get_primary_netdev() returns ndev with refcount held */
+	netdev_put(ndev, &dev->dev_tracker);
 	if (ret) {
 		ibdev_err(&dev->ib_dev, "Failed to set ib netdev, ret %d", ret);
 		goto free_ib_device;
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index b53a5b4de908..2638688f2505 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -64,6 +64,7 @@ struct mana_ib_dev {
 	struct gdma_queue **eqs;
 	struct xarray qp_table_wq;
 	struct mana_ib_adapter_caps adapter_caps;
+	netdevice_tracker dev_tracker;
 };
 
 struct mana_ib_wq {
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 12c22261dd3a..37d4966d16db 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3000,21 +3000,27 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 	kfree(ac);
 }
 
-struct net_device *mana_get_primary_netdev_rcu(struct mana_context *ac, u32 port_index)
+struct net_device *mana_get_primary_netdev(struct mana_context *ac,
+					   u32 port_index,
+					   netdevice_tracker *tracker)
 {
 	struct net_device *ndev;
 
-	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
-			 "Taking primary netdev without holding the RCU read lock");
 	if (port_index >= ac->num_ports)
 		return NULL;
 
-	/* When mana is used in netvsc, the upper netdevice should be returned. */
-	if (ac->ports[port_index]->flags & IFF_SLAVE)
-		ndev = netdev_master_upper_dev_get_rcu(ac->ports[port_index]);
-	else
+	rcu_read_lock();
+
+	/* If mana is used in netvsc, the upper netdevice should be returned. */
+	ndev = netdev_master_upper_dev_get_rcu(ac->ports[port_index]);
+
+	/* If there is no upper device, use the parent Ethernet device */
+	if (!ndev)
 		ndev = ac->ports[port_index];
 
+	netdev_hold(ndev, tracker, GFP_ATOMIC);
+	rcu_read_unlock();
+
 	return ndev;
 }
-EXPORT_SYMBOL_NS(mana_get_primary_netdev_rcu, NET_MANA);
+EXPORT_SYMBOL_NS(mana_get_primary_netdev, NET_MANA);
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index f2a5200d8a0f..ac9a4b0bd49b 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -819,5 +819,7 @@ int mana_cfg_vport(struct mana_port_context *apc, u32 protection_dom_id,
 		   u32 doorbell_pg_id);
 void mana_uncfg_vport(struct mana_port_context *apc);
 
-struct net_device *mana_get_primary_netdev_rcu(struct mana_context *ac, u32 port_index);
+struct net_device *mana_get_primary_netdev(struct mana_context *ac,
+					   u32 port_index,
+					   netdevice_tracker *tracker);
 #endif /* _MANA_H */
-- 
2.34.1


