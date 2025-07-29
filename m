Return-Path: <stable+bounces-165027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE029B14743
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 06:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E5F1AA0515
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 04:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2436C22D4C3;
	Tue, 29 Jul 2025 04:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACqcHq7m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D575B227599
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 04:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753763338; cv=none; b=p3mBcyOade8Mzy4HpQIN6hqS7TIKPqVbEr+qzCcykzQVUoAaC6ofQ3pYrFaLnQz3DCXg2jM8PqQn4Cp90BWEmfKU/pl3Rr+J5nTYT36xFpaPlNi8BpzCSA3BgBYcM/C0/N7DYeUhC9pXSOyr6+fKHcq2qKU1/lWPkkTclFupHqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753763338; c=relaxed/simple;
	bh=067Ud5Na+FE58MvOVwqVkwiS1rU4DnrfzhYpPJdWCjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQct4FdiZm+fAnpaiplT1UzCLAmB16RYKlYyytDNnLXlw+mUB2vC6TN/eDOCybUuZHVvzIsh+g3oKMz7Q6QFfsihBf295XRgQssyP35Iu1MoMBlTa5ULmH19d/gN7J37+TU2jf9zdPvdqCq+AgB+rI/RALscoGmwDlLbZGjaLsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACqcHq7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983E4C4CEF5;
	Tue, 29 Jul 2025 04:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753763338;
	bh=067Ud5Na+FE58MvOVwqVkwiS1rU4DnrfzhYpPJdWCjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ACqcHq7mQa9HkTvA5dOuBkA6Xv/odWLxQOdAC9cq//R+utGx3nxYb0aVGaKnKq+sw
	 Q+GuoTqdMYJVL81fzxL7i5JTXEvfWH1/4H2Ama9MUR9oSpmLtx9sDw1hZhSPV8MeSL
	 IDtqtobNaf6Zu/upFrDX5mKMhrN5QtF4vpvSJ95l3VGMmrprSAkLo0nlFqV6qEawoD
	 lLBp/ma28KRJY5tABxBPyisMdLobLp/WhuFPte2s1/q1yt2yOZoCnzW0fqKfmFEVjo
	 1wOpbFSqIjLIpW84tfPBL/Tq9ykcYGR+VgvDX8e9QFzGe9SkymDXOcTtwNjVsAYkV8
	 tIoUKrMnANFjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] dpaa2-mac: export MAC counters even when in TYPE_FIXED
Date: Tue, 29 Jul 2025 00:28:51 -0400
Message-Id: <20250729042853.2357022-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250729042853.2357022-1-sashal@kernel.org>
References: <2025072840-quickstep-spiny-0e80@gregkh>
 <20250729042853.2357022-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ioana Ciornei <ioana.ciornei@nxp.com>

[ Upstream commit d87e606373f641c58d5e8e4c48b3216fd9d1c78a ]

If the network interface object is connected to a MAC of TYPE_FIXED, the
link status management is handled exclusively by the firmware. This does
not mean that the driver cannot access the MAC counters and export them
in ethtool.

For this to happen, we open the attached dpmac device and keep a pointer
to it in priv->mac. Because of this, all the checks in the driver of the
following form 'if (priv->mac)' have to be updated to actually check
the dpmac attribute and not rely on the presence of a non-NULL value.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: ee9f3a81ab08 ("dpaa2-eth: Fix device reference count leak in MAC endpoint handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  | 37 +++++++++----------
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.h  | 13 +++++++
 .../ethernet/freescale/dpaa2/dpaa2-ethtool.c  | 16 ++++----
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  | 26 -------------
 4 files changed, 39 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index b0f96a835fec..217e3004c0cc 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -1765,7 +1765,7 @@ static int dpaa2_eth_link_state_update(struct dpaa2_eth_priv *priv)
 	/* When we manage the MAC/PHY using phylink there is no need
 	 * to manually update the netif_carrier.
 	 */
-	if (priv->mac)
+	if (dpaa2_eth_is_type_phy(priv))
 		goto out;
 
 	/* Chech link state; speed / duplex changes are not treated yet */
@@ -1804,7 +1804,7 @@ static int dpaa2_eth_open(struct net_device *net_dev)
 			   priv->dpbp_dev->obj_desc.id, priv->bpid);
 	}
 
-	if (!priv->mac) {
+	if (!dpaa2_eth_is_type_phy(priv)) {
 		/* We'll only start the txqs when the link is actually ready;
 		 * make sure we don't race against the link up notification,
 		 * which may come immediately after dpni_enable();
@@ -1826,7 +1826,7 @@ static int dpaa2_eth_open(struct net_device *net_dev)
 		goto enable_err;
 	}
 
-	if (priv->mac)
+	if (dpaa2_eth_is_type_phy(priv))
 		phylink_start(priv->mac->phylink);
 
 	return 0;
@@ -1900,11 +1900,11 @@ static int dpaa2_eth_stop(struct net_device *net_dev)
 	int dpni_enabled = 0;
 	int retries = 10;
 
-	if (!priv->mac) {
+	if (dpaa2_eth_is_type_phy(priv)) {
+		phylink_stop(priv->mac->phylink);
+	} else {
 		netif_tx_stop_all_queues(net_dev);
 		netif_carrier_off(net_dev);
-	} else {
-		phylink_stop(priv->mac->phylink);
 	}
 
 	/* On dpni_disable(), the MC firmware will:
@@ -2192,7 +2192,7 @@ static int dpaa2_eth_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 	if (cmd == SIOCSHWTSTAMP)
 		return dpaa2_eth_ts_ioctl(dev, rq, cmd);
 
-	if (priv->mac)
+	if (dpaa2_eth_is_type_phy(priv))
 		return phylink_mii_ioctl(priv->mac->phylink, rq, cmd);
 
 	return -EOPNOTSUPP;
@@ -4137,9 +4137,6 @@ static int dpaa2_eth_connect_mac(struct dpaa2_eth_priv *priv)
 	if (IS_ERR_OR_NULL(dpmac_dev) || dpmac_dev->dev.type != &fsl_mc_bus_dpmac_type)
 		return 0;
 
-	if (dpaa2_mac_is_type_fixed(dpmac_dev, priv->mc_io))
-		return 0;
-
 	mac = kzalloc(sizeof(struct dpaa2_mac), GFP_KERNEL);
 	if (!mac)
 		return -ENOMEM;
@@ -4151,18 +4148,21 @@ static int dpaa2_eth_connect_mac(struct dpaa2_eth_priv *priv)
 	err = dpaa2_mac_open(mac);
 	if (err)
 		goto err_free_mac;
+	priv->mac = mac;
 
-	err = dpaa2_mac_connect(mac);
-	if (err) {
-		netdev_err(priv->net_dev, "Error connecting to the MAC endpoint\n");
-		goto err_close_mac;
+	if (dpaa2_eth_is_type_phy(priv)) {
+		err = dpaa2_mac_connect(mac);
+		if (err) {
+			netdev_err(priv->net_dev, "Error connecting to the MAC endpoint\n");
+			goto err_close_mac;
+		}
 	}
-	priv->mac = mac;
 
 	return 0;
 
 err_close_mac:
 	dpaa2_mac_close(mac);
+	priv->mac = NULL;
 err_free_mac:
 	kfree(mac);
 	return err;
@@ -4170,10 +4170,9 @@ static int dpaa2_eth_connect_mac(struct dpaa2_eth_priv *priv)
 
 static void dpaa2_eth_disconnect_mac(struct dpaa2_eth_priv *priv)
 {
-	if (!priv->mac)
-		return;
+	if (dpaa2_eth_is_type_phy(priv))
+		dpaa2_mac_disconnect(priv->mac);
 
-	dpaa2_mac_disconnect(priv->mac);
 	dpaa2_mac_close(priv->mac);
 	kfree(priv->mac);
 	priv->mac = NULL;
@@ -4203,7 +4202,7 @@ static irqreturn_t dpni_irq0_handler_thread(int irq_num, void *arg)
 		dpaa2_eth_update_tx_fqids(priv);
 
 		rtnl_lock();
-		if (priv->mac)
+		if (dpaa2_eth_has_mac(priv))
 			dpaa2_eth_disconnect_mac(priv);
 		else
 			dpaa2_eth_connect_mac(priv);
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
index 5934b1b4ee97..77b1d39dd5c5 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
@@ -705,6 +705,19 @@ static inline unsigned int dpaa2_eth_rx_head_room(struct dpaa2_eth_priv *priv)
 	return priv->tx_data_offset - DPAA2_ETH_RX_HWA_SIZE;
 }
 
+static inline bool dpaa2_eth_is_type_phy(struct dpaa2_eth_priv *priv)
+{
+	if (priv->mac && priv->mac->attr.link_type == DPMAC_LINK_TYPE_PHY)
+		return true;
+
+	return false;
+}
+
+static inline bool dpaa2_eth_has_mac(struct dpaa2_eth_priv *priv)
+{
+	return priv->mac ? true : false;
+}
+
 int dpaa2_eth_set_hash(struct net_device *net_dev, u64 flags);
 int dpaa2_eth_set_cls(struct net_device *net_dev, u64 key);
 int dpaa2_eth_cls_key_size(u64 key);
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
index d7de60049700..f65179ed4f33 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
@@ -85,7 +85,7 @@ static int dpaa2_eth_nway_reset(struct net_device *net_dev)
 {
 	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
 
-	if (priv->mac)
+	if (dpaa2_eth_is_type_phy(priv))
 		return phylink_ethtool_nway_reset(priv->mac->phylink);
 
 	return -EOPNOTSUPP;
@@ -97,7 +97,7 @@ dpaa2_eth_get_link_ksettings(struct net_device *net_dev,
 {
 	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
 
-	if (priv->mac)
+	if (dpaa2_eth_is_type_phy(priv))
 		return phylink_ethtool_ksettings_get(priv->mac->phylink,
 						     link_settings);
 
@@ -115,7 +115,7 @@ dpaa2_eth_set_link_ksettings(struct net_device *net_dev,
 {
 	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
 
-	if (!priv->mac)
+	if (!dpaa2_eth_is_type_phy(priv))
 		return -ENOTSUPP;
 
 	return phylink_ethtool_ksettings_set(priv->mac->phylink, link_settings);
@@ -127,7 +127,7 @@ static void dpaa2_eth_get_pauseparam(struct net_device *net_dev,
 	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
 	u64 link_options = priv->link_state.options;
 
-	if (priv->mac) {
+	if (dpaa2_eth_is_type_phy(priv)) {
 		phylink_ethtool_get_pauseparam(priv->mac->phylink, pause);
 		return;
 	}
@@ -150,7 +150,7 @@ static int dpaa2_eth_set_pauseparam(struct net_device *net_dev,
 		return -EOPNOTSUPP;
 	}
 
-	if (priv->mac)
+	if (dpaa2_eth_is_type_phy(priv))
 		return phylink_ethtool_set_pauseparam(priv->mac->phylink,
 						      pause);
 	if (pause->autoneg)
@@ -198,7 +198,7 @@ static void dpaa2_eth_get_strings(struct net_device *netdev, u32 stringset,
 			strlcpy(p, dpaa2_ethtool_extras[i], ETH_GSTRING_LEN);
 			p += ETH_GSTRING_LEN;
 		}
-		if (priv->mac)
+		if (dpaa2_eth_has_mac(priv))
 			dpaa2_mac_get_strings(p);
 		break;
 	}
@@ -211,7 +211,7 @@ static int dpaa2_eth_get_sset_count(struct net_device *net_dev, int sset)
 
 	switch (sset) {
 	case ETH_SS_STATS: /* ethtool_get_stats(), ethtool_get_drvinfo() */
-		if (priv->mac)
+		if (dpaa2_eth_has_mac(priv))
 			num_ss_stats += dpaa2_mac_get_sset_count();
 		return num_ss_stats;
 	default:
@@ -311,7 +311,7 @@ static void dpaa2_eth_get_ethtool_stats(struct net_device *net_dev,
 	}
 	*(data + i++) = buf_cnt;
 
-	if (priv->mac)
+	if (dpaa2_eth_has_mac(priv))
 		dpaa2_mac_get_ethtool_stats(priv->mac, data + i);
 }
 
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
index 50dd302abcf4..81b2822a7dc9 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
@@ -228,32 +228,6 @@ static const struct phylink_mac_ops dpaa2_mac_phylink_ops = {
 	.mac_link_down = dpaa2_mac_link_down,
 };
 
-bool dpaa2_mac_is_type_fixed(struct fsl_mc_device *dpmac_dev,
-			     struct fsl_mc_io *mc_io)
-{
-	struct dpmac_attr attr;
-	bool fixed = false;
-	u16 mc_handle = 0;
-	int err;
-
-	err = dpmac_open(mc_io, 0, dpmac_dev->obj_desc.id,
-			 &mc_handle);
-	if (err || !mc_handle)
-		return false;
-
-	err = dpmac_get_attributes(mc_io, 0, mc_handle, &attr);
-	if (err)
-		goto out;
-
-	if (attr.link_type == DPMAC_LINK_TYPE_FIXED)
-		fixed = true;
-
-out:
-	dpmac_close(mc_io, 0, mc_handle);
-
-	return fixed;
-}
-
 static int dpaa2_pcs_create(struct dpaa2_mac *mac,
 			    struct device_node *dpmac_node, int id)
 {
-- 
2.39.5


