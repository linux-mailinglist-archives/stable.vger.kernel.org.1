Return-Path: <stable+bounces-147181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF46AC5686
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAE3188943F
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F241F27E7C1;
	Tue, 27 May 2025 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bVOza0kQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE961185E7F;
	Tue, 27 May 2025 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366537; cv=none; b=DUQnJLQXg6kdZx0kwBuyRmORPBFRc58AozEcUz1D39JV+pa6q+CwU/7AcFo8G5jKOyqF20rDIzl9yL7xv12YXIHBS/H81X58dRoNjGVQV+Krr5dQ5N1o8wUEsokXjVDNos++VEtm81OHwhTInWxRCetLdxq0Ta5QxG8/XUHzuPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366537; c=relaxed/simple;
	bh=zx7eillJqVfHTN37E0uTtResbLiZpr1GSyxahV+HVNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHM+c2F6u+oLqbrWj2lrSNv2XozzubbV90ohkDfu4CNz5mvyJCEQKbPesLcZ+3iiW8VBhPku/fdoWa6L5ZABQR8Bam9FJ+UfDkwNzeKssbVp4TQFKzqsOHicVN1DfXRBRV+DwRQ0QwyEGR/q2jahIK1RcDFht/U9z3YLsGGepJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bVOza0kQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34752C4CEE9;
	Tue, 27 May 2025 17:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748366537;
	bh=zx7eillJqVfHTN37E0uTtResbLiZpr1GSyxahV+HVNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bVOza0kQoTFm8hrsG8kxkDkqsrJpgnmCyego9M38vluvdRtXYino4ua4l24iIJdgd
	 lpQk2KCLMRV5p7BvAgybxpeqSzgFLZE4wvlb/tlGL/YmMHBX5SeXKLHc7M7QkKLiQU
	 wf8TIEHd+8GRAUF6+eGnOl3FjU/sb4O2GmmSAIVA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans-Frieder Vogt <hfdevel@gmx.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 083/783] net: tn40xx: create swnode for mdio and aqr105 phy and add to mdiobus
Date: Tue, 27 May 2025 18:18:00 +0200
Message-ID: <20250527162516.521915386@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans-Frieder Vogt <hfdevel@gmx.net>

[ Upstream commit 25b6a6d29d4082f6ac231c056ac321a996eb55c9 ]

In case of an AQR105-based device, create a software node for the mdio
function, with a child node for the Aquantia AQR105 PHY, providing a
firmware-name (and a bit more, which may be used for future checks) to
allow the PHY to load a MAC specific firmware from the file system.

The name of the PHY software node follows the naming convention suggested
in the patch for the mdiobus_scan function (in the same patch series).

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250322-tn9510-v3a-v7-5-672a9a3d8628@gmx.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/tehuti/tn40.c      |  5 +-
 drivers/net/ethernet/tehuti/tn40.h      | 33 ++++++++++
 drivers/net/ethernet/tehuti/tn40_mdio.c | 82 ++++++++++++++++++++++++-
 3 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
index a6965258441c4..558b791a97edd 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1778,7 +1778,7 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ret = tn40_phy_register(priv);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to set up PHY.\n");
-		goto err_free_irq;
+		goto err_cleanup_swnodes;
 	}
 
 	ret = tn40_priv_init(priv);
@@ -1795,6 +1795,8 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 err_unregister_phydev:
 	tn40_phy_unregister(priv);
+err_cleanup_swnodes:
+	tn40_swnodes_cleanup(priv);
 err_free_irq:
 	pci_free_irq_vectors(pdev);
 err_unset_drvdata:
@@ -1816,6 +1818,7 @@ static void tn40_remove(struct pci_dev *pdev)
 	unregister_netdev(ndev);
 
 	tn40_phy_unregister(priv);
+	tn40_swnodes_cleanup(priv);
 	pci_free_irq_vectors(priv->pdev);
 	pci_set_drvdata(pdev, NULL);
 	iounmap(priv->regs);
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index 490781fe51205..25da8686d4691 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -4,10 +4,13 @@
 #ifndef _TN40_H_
 #define _TN40_H_
 
+#include <linux/property.h>
 #include "tn40_regs.h"
 
 #define TN40_DRV_NAME "tn40xx"
 
+#define PCI_DEVICE_ID_TEHUTI_TN9510	0x4025
+
 #define TN40_MDIO_SPEED_1MHZ (1)
 #define TN40_MDIO_SPEED_6MHZ (6)
 
@@ -102,10 +105,39 @@ struct tn40_txdb {
 	int size; /* Number of elements in the db */
 };
 
+#define NODE_PROP(_NAME, _PROP)	(		\
+	(const struct software_node) {		\
+		.name = _NAME,			\
+		.properties = _PROP,		\
+	})
+
+#define NODE_PAR_PROP(_NAME, _PAR, _PROP)	(	\
+	(const struct software_node) {		\
+		.name = _NAME,			\
+		.parent = _PAR,			\
+		.properties = _PROP,		\
+	})
+
+enum tn40_swnodes {
+	SWNODE_MDIO,
+	SWNODE_PHY,
+	SWNODE_MAX
+};
+
+struct tn40_nodes {
+	char phy_name[32];
+	char mdio_name[32];
+	struct property_entry phy_props[3];
+	struct software_node swnodes[SWNODE_MAX];
+	const struct software_node *group[SWNODE_MAX + 1];
+};
+
 struct tn40_priv {
 	struct net_device *ndev;
 	struct pci_dev *pdev;
 
+	struct tn40_nodes nodes;
+
 	struct napi_struct napi;
 	/* RX FIFOs: 1 for data (full) descs, and 2 for free descs */
 	struct tn40_rxd_fifo rxd_fifo0;
@@ -225,6 +257,7 @@ static inline void tn40_write_reg(struct tn40_priv *priv, u32 reg, u32 val)
 
 int tn40_set_link_speed(struct tn40_priv *priv, u32 speed);
 
+void tn40_swnodes_cleanup(struct tn40_priv *priv);
 int tn40_mdiobus_init(struct tn40_priv *priv);
 
 int tn40_phy_register(struct tn40_priv *priv);
diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/ethernet/tehuti/tn40_mdio.c
index af18615d64a8a..5bb0cbc87d064 100644
--- a/drivers/net/ethernet/tehuti/tn40_mdio.c
+++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
@@ -14,6 +14,8 @@
 	 (FIELD_PREP(TN40_MDIO_PRTAD_MASK, (port))))
 #define TN40_MDIO_CMD_READ BIT(15)
 
+#define AQR105_FIRMWARE "tehuti/aqr105-tn40xx.cld"
+
 static void tn40_mdio_set_speed(struct tn40_priv *priv, u32 speed)
 {
 	void __iomem *regs = priv->regs;
@@ -111,6 +113,56 @@ static int tn40_mdio_write_c45(struct mii_bus *mii_bus, int addr, int devnum,
 	return  tn40_mdio_write(mii_bus->priv, addr, devnum, regnum, val);
 }
 
+/* registers an mdio node and an aqr105 PHY at address 1
+ * tn40_mdio-%id {
+ *	ethernet-phy@1 {
+ *		compatible = "ethernet-phy-id03a1.b4a3";
+ *		reg = <1>;
+ *		firmware-name = AQR105_FIRMWARE;
+ *	};
+ * };
+ */
+static int tn40_swnodes_register(struct tn40_priv *priv)
+{
+	struct tn40_nodes *nodes = &priv->nodes;
+	struct pci_dev *pdev = priv->pdev;
+	struct software_node *swnodes;
+	u32 id;
+
+	id = pci_dev_id(pdev);
+
+	snprintf(nodes->phy_name, sizeof(nodes->phy_name), "ethernet-phy@1");
+	snprintf(nodes->mdio_name, sizeof(nodes->mdio_name), "tn40_mdio-%x",
+		 id);
+
+	swnodes = nodes->swnodes;
+
+	swnodes[SWNODE_MDIO] = NODE_PROP(nodes->mdio_name, NULL);
+
+	nodes->phy_props[0] = PROPERTY_ENTRY_STRING("compatible",
+						    "ethernet-phy-id03a1.b4a3");
+	nodes->phy_props[1] = PROPERTY_ENTRY_U32("reg", 1);
+	nodes->phy_props[2] = PROPERTY_ENTRY_STRING("firmware-name",
+						    AQR105_FIRMWARE);
+	swnodes[SWNODE_PHY] = NODE_PAR_PROP(nodes->phy_name,
+					    &swnodes[SWNODE_MDIO],
+					    nodes->phy_props);
+
+	nodes->group[SWNODE_PHY] = &swnodes[SWNODE_PHY];
+	nodes->group[SWNODE_MDIO] = &swnodes[SWNODE_MDIO];
+	return software_node_register_node_group(nodes->group);
+}
+
+void tn40_swnodes_cleanup(struct tn40_priv *priv)
+{
+	/* cleanup of swnodes is only needed for AQR105-based cards */
+	if (priv->pdev->device == PCI_DEVICE_ID_TEHUTI_TN9510) {
+		fwnode_handle_put(dev_fwnode(&priv->mdio->dev));
+		device_remove_software_node(&priv->mdio->dev);
+		software_node_unregister_node_group(priv->nodes.group);
+	}
+}
+
 int tn40_mdiobus_init(struct tn40_priv *priv)
 {
 	struct pci_dev *pdev = priv->pdev;
@@ -129,14 +181,40 @@ int tn40_mdiobus_init(struct tn40_priv *priv)
 
 	bus->read_c45 = tn40_mdio_read_c45;
 	bus->write_c45 = tn40_mdio_write_c45;
+	priv->mdio = bus;
+
+	/* provide swnodes for AQR105-based cards only */
+	if (pdev->device == PCI_DEVICE_ID_TEHUTI_TN9510) {
+		ret = tn40_swnodes_register(priv);
+		if (ret) {
+			pr_err("swnodes failed\n");
+			return ret;
+		}
+
+		ret = device_add_software_node(&bus->dev,
+					       priv->nodes.group[SWNODE_MDIO]);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"device_add_software_node failed: %d\n", ret);
+			goto err_swnodes_unregister;
+		}
+	}
 
 	ret = devm_mdiobus_register(&pdev->dev, bus);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register mdiobus %d %u %u\n",
 			ret, bus->state, MDIOBUS_UNREGISTERED);
-		return ret;
+		goto err_swnodes_cleanup;
 	}
 	tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_6MHZ);
-	priv->mdio = bus;
 	return 0;
+
+err_swnodes_unregister:
+	software_node_unregister_node_group(priv->nodes.group);
+	return ret;
+err_swnodes_cleanup:
+	tn40_swnodes_cleanup(priv);
+	return ret;
 }
+
+MODULE_FIRMWARE(AQR105_FIRMWARE);
-- 
2.39.5




