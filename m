Return-Path: <stable+bounces-165026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE6AB14742
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 06:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48BA617CF67
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 04:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAF022B594;
	Tue, 29 Jul 2025 04:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFmisDUe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A060C227B83
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 04:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753763337; cv=none; b=NWPASrrMgdwyZPOaZcZsgMrypVzCFzeDJ2dnVe2fCFbkecB6hrfQRxcH+DlMvpeKjMWL5rwePdcKEecvqhKFYDhPX3YRevfx2vf+N07V8zMmdGMVzI3zI78Igwb+NH0W91EwA110myvJaeS//NDjNtKHd4hHQrKC7JtfCTfIlv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753763337; c=relaxed/simple;
	bh=gn2DB44mrKAsvWLAu6C1BqUpJKB619GELhLuDL3dVCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EwHXHIwzDbyk/mCDHKQuRZKHgPw74zNf4jzE9qiAZjSnefeaeaAsL6nnGHshNf30yEGYCwUyFNfI/E4xVqjuJ3gagzH+wWOtUAEKKmJ73DzF8qyA4LaVXygJYYZMOx1YC6rc6+mqBXDq5FOO15hXherFSe/ZaoHqpc17T3fI7ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFmisDUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9C3C4CEEF;
	Tue, 29 Jul 2025 04:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753763337;
	bh=gn2DB44mrKAsvWLAu6C1BqUpJKB619GELhLuDL3dVCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFmisDUeP428C+TUbr6tI+1gyBQdnMDkr4E/uidLyUrczxXi+Fj7inSmxyZHxqau9
	 YeOYtTVhcn+nkuwOA9fIzFjA7DrFQbNVR46ym2lNyKHZFqPf9WuSUhgKV5tsgHmCC6
	 X6dw+8emA5DfykI1TfQSt3xQKTrOOR8u0FdNspBYWFx1+fXWfnFeud7A1+s5Yet2HG
	 HNMDVWcF4+p+biPY/t4GD8aKX31vf2osV5owhoet8XCjK0lNsGqoOpw4ksq/ZZK8GE
	 fVzfevu94Gi8GFBQ+9Akg1I1DGp1rQVAeKjhqe/THpqllCGL9GmOlo1BEXxFDodb2G
	 TGkxT2X+7+BuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] dpaa2-mac: split up initializing the MAC object from connecting to it
Date: Tue, 29 Jul 2025 00:28:50 -0400
Message-Id: <20250729042853.2357022-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072840-quickstep-spiny-0e80@gregkh>
References: <2025072840-quickstep-spiny-0e80@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ioana Ciornei <ioana.ciornei@nxp.com>

[ Upstream commit 095dca16d92f32150314ef47ea150ed83c5aacd9 ]

Split up the initialization phase of the dpmac object from actually
configuring the phylink instance, connecting to it and configuring the
MAC. This is done so that even though the dpni object is connected to a
dpmac which has link management handled by the firmware we are still
able to export the MAC counters.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: ee9f3a81ab08 ("dpaa2-eth: Fix device reference count leak in MAC endpoint handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  | 14 +++-
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  | 69 +++++++++++--------
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.h  |  5 ++
 3 files changed, 59 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 776f624e3b8e..b0f96a835fec 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4148,15 +4148,24 @@ static int dpaa2_eth_connect_mac(struct dpaa2_eth_priv *priv)
 	mac->mc_io = priv->mc_io;
 	mac->net_dev = priv->net_dev;
 
+	err = dpaa2_mac_open(mac);
+	if (err)
+		goto err_free_mac;
+
 	err = dpaa2_mac_connect(mac);
 	if (err) {
 		netdev_err(priv->net_dev, "Error connecting to the MAC endpoint\n");
-		kfree(mac);
-		return err;
+		goto err_close_mac;
 	}
 	priv->mac = mac;
 
 	return 0;
+
+err_close_mac:
+	dpaa2_mac_close(mac);
+err_free_mac:
+	kfree(mac);
+	return err;
 }
 
 static void dpaa2_eth_disconnect_mac(struct dpaa2_eth_priv *priv)
@@ -4165,6 +4174,7 @@ static void dpaa2_eth_disconnect_mac(struct dpaa2_eth_priv *priv)
 		return;
 
 	dpaa2_mac_disconnect(priv->mac);
+	dpaa2_mac_close(priv->mac);
 	kfree(priv->mac);
 	priv->mac = NULL;
 }
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
index 828c177df03d..50dd302abcf4 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
@@ -302,36 +302,20 @@ static void dpaa2_pcs_destroy(struct dpaa2_mac *mac)
 
 int dpaa2_mac_connect(struct dpaa2_mac *mac)
 {
-	struct fsl_mc_device *dpmac_dev = mac->mc_dev;
 	struct net_device *net_dev = mac->net_dev;
 	struct device_node *dpmac_node;
 	struct phylink *phylink;
-	struct dpmac_attr attr;
 	int err;
 
-	err = dpmac_open(mac->mc_io, 0, dpmac_dev->obj_desc.id,
-			 &dpmac_dev->mc_handle);
-	if (err || !dpmac_dev->mc_handle) {
-		netdev_err(net_dev, "dpmac_open() = %d\n", err);
-		return -ENODEV;
-	}
-
-	err = dpmac_get_attributes(mac->mc_io, 0, dpmac_dev->mc_handle, &attr);
-	if (err) {
-		netdev_err(net_dev, "dpmac_get_attributes() = %d\n", err);
-		goto err_close_dpmac;
-	}
-
-	mac->if_link_type = attr.link_type;
+	mac->if_link_type = mac->attr.link_type;
 
-	dpmac_node = dpaa2_mac_get_node(attr.id);
+	dpmac_node = dpaa2_mac_get_node(mac->attr.id);
 	if (!dpmac_node) {
-		netdev_err(net_dev, "No dpmac@%d node found.\n", attr.id);
-		err = -ENODEV;
-		goto err_close_dpmac;
+		netdev_err(net_dev, "No dpmac@%d node found.\n", mac->attr.id);
+		return -ENODEV;
 	}
 
-	err = dpaa2_mac_get_if_mode(dpmac_node, attr);
+	err = dpaa2_mac_get_if_mode(dpmac_node, mac->attr);
 	if (err < 0) {
 		err = -EINVAL;
 		goto err_put_node;
@@ -351,9 +335,9 @@ int dpaa2_mac_connect(struct dpaa2_mac *mac)
 		goto err_put_node;
 	}
 
-	if (attr.link_type == DPMAC_LINK_TYPE_PHY &&
-	    attr.eth_if != DPMAC_ETH_IF_RGMII) {
-		err = dpaa2_pcs_create(mac, dpmac_node, attr.id);
+	if (mac->attr.link_type == DPMAC_LINK_TYPE_PHY &&
+	    mac->attr.eth_if != DPMAC_ETH_IF_RGMII) {
+		err = dpaa2_pcs_create(mac, dpmac_node, mac->attr.id);
 		if (err)
 			goto err_put_node;
 	}
@@ -389,8 +373,7 @@ int dpaa2_mac_connect(struct dpaa2_mac *mac)
 	dpaa2_pcs_destroy(mac);
 err_put_node:
 	of_node_put(dpmac_node);
-err_close_dpmac:
-	dpmac_close(mac->mc_io, 0, dpmac_dev->mc_handle);
+
 	return err;
 }
 
@@ -402,8 +385,40 @@ void dpaa2_mac_disconnect(struct dpaa2_mac *mac)
 	phylink_disconnect_phy(mac->phylink);
 	phylink_destroy(mac->phylink);
 	dpaa2_pcs_destroy(mac);
+}
+
+int dpaa2_mac_open(struct dpaa2_mac *mac)
+{
+	struct fsl_mc_device *dpmac_dev = mac->mc_dev;
+	struct net_device *net_dev = mac->net_dev;
+	int err;
+
+	err = dpmac_open(mac->mc_io, 0, dpmac_dev->obj_desc.id,
+			 &dpmac_dev->mc_handle);
+	if (err || !dpmac_dev->mc_handle) {
+		netdev_err(net_dev, "dpmac_open() = %d\n", err);
+		return -ENODEV;
+	}
+
+	err = dpmac_get_attributes(mac->mc_io, 0, dpmac_dev->mc_handle,
+				   &mac->attr);
+	if (err) {
+		netdev_err(net_dev, "dpmac_get_attributes() = %d\n", err);
+		goto err_close_dpmac;
+	}
+
+	return 0;
+
+err_close_dpmac:
+	dpmac_close(mac->mc_io, 0, dpmac_dev->mc_handle);
+	return err;
+}
+
+void dpaa2_mac_close(struct dpaa2_mac *mac)
+{
+	struct fsl_mc_device *dpmac_dev = mac->mc_dev;
 
-	dpmac_close(mac->mc_io, 0, mac->mc_dev->mc_handle);
+	dpmac_close(mac->mc_io, 0, dpmac_dev->mc_handle);
 }
 
 static char dpaa2_mac_ethtool_stats[][ETH_GSTRING_LEN] = {
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
index 955a52856210..13d42dd58ec9 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
@@ -17,6 +17,7 @@ struct dpaa2_mac {
 	struct dpmac_link_state state;
 	struct net_device *net_dev;
 	struct fsl_mc_io *mc_io;
+	struct dpmac_attr attr;
 
 	struct phylink_config phylink_config;
 	struct phylink *phylink;
@@ -28,6 +29,10 @@ struct dpaa2_mac {
 bool dpaa2_mac_is_type_fixed(struct fsl_mc_device *dpmac_dev,
 			     struct fsl_mc_io *mc_io);
 
+int dpaa2_mac_open(struct dpaa2_mac *mac);
+
+void dpaa2_mac_close(struct dpaa2_mac *mac);
+
 int dpaa2_mac_connect(struct dpaa2_mac *mac);
 
 void dpaa2_mac_disconnect(struct dpaa2_mac *mac);
-- 
2.39.5


