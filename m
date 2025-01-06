Return-Path: <stable+bounces-107581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE418A02CBD
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E0A3A8CAD
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA4281728;
	Mon,  6 Jan 2025 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gLCzmjxM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F0F1DA60B;
	Mon,  6 Jan 2025 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178898; cv=none; b=fQCUhHITjQVnVvE6XGlAJxEMFVrma2Xb4+r1u+ruAaK0GkGAYFK6PRVqA0vhdyC7hNcfRaWR7wkApE5Tqreuqp3EM1yghpGMnGmbPCMkRTb7QfdNB4Rr5lw3+78DMSd2O12uG3jjCY+zxdXzvi3NwwpfOLXKcRegjChOFsqrAkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178898; c=relaxed/simple;
	bh=Bl/gVxjesZ4Ed4uzL4HLXE9ECxbv1T5GCGPRMx4n35E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TC/IwfJzx5C4ksuKnEApGevOdedMmDLGtzElNKLLwSsJ5tIZKC1IEqlmh3rvQsexB4+WYrcUO8ynHcfDOQVVMqgZhhV8fwNYEGYKrzKC/++40SsX/216OhGJK3dgKheYl/DaswzEAAWMw97gnM7xde9wCnQ2WWsbQFpchwAXPdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gLCzmjxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C5FC4CED2;
	Mon,  6 Jan 2025 15:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736178898;
	bh=Bl/gVxjesZ4Ed4uzL4HLXE9ECxbv1T5GCGPRMx4n35E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gLCzmjxMtrusOKqzjFz7Y+SswarnlT2PrRDa5ri0QadSaRyiTe1syj0nAA/wElAlR
	 SBUi+HEwQEBSPiOjgW9YHE3OjWMy7BRqQzLW+6Hk4gPbSpUmlUwrm72qqjAr4cPh0o
	 nD7U3xZc+dfKvftHxVfni1CX344CcqyUka1t7T18=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Serge Semin <fancer.lancer@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 129/168] net: stmmac: dont create a MDIO bus if unnecessary
Date: Mon,  6 Jan 2025 16:17:17 +0100
Message-ID: <20250106151143.314171090@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151138.451846855@linuxfoundation.org>
References: <20250106151138.451846855@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Halaney <ahalaney@redhat.com>

[ Upstream commit f3c2caacee824ce4a331cdafb0b8dc8e987f105e ]

Currently a MDIO bus is created if the devicetree description is either:

    1. Not fixed-link
    2. fixed-link but contains a MDIO bus as well

The "1" case above isn't always accurate. If there's a phy-handle,
it could be referencing a phy on another MDIO controller's bus[1]. In
this case, where the MDIO bus is not described at all, currently
stmmac will make a MDIO bus and scan its address space to discover
phys (of which there are none). This process takes time scanning a bus
that is known to be empty, delaying time to complete probe.

There are also a lot of upstream devicetrees[2] that expect a MDIO bus
to be created, scanned for phys, and the first one found connected
to the MAC. This case can be inferred from the platform description by
not having a phy-handle && not being fixed-link. This hits case "1" in
the current driver's logic, and must be handled in any logic change here
since it is a valid legacy dt-binding.

Let's improve the logic to create a MDIO bus if either:

    - Devicetree contains a MDIO bus
    - !fixed-link && !phy-handle (legacy handling)

This way the case where no MDIO bus should be made is handled, as well
as retaining backwards compatibility with the valid cases.

Below devicetree snippets can be found that explain some of
the cases above more concretely.

Here's[0] a devicetree example where the MAC is both fixed-link and
driving a switch on MDIO (case "2" above). This needs a MDIO bus to
be created:

    &fec1 {
            phy-mode = "rmii";

            fixed-link {
                    speed = <100>;
                    full-duplex;
            };

            mdio1: mdio {
                    switch0: switch0@0 {
                            compatible = "marvell,mv88e6190";
                            pinctrl-0 = <&pinctrl_gpio_switch0>;
                    };
            };
    };

Here's[1] an example where there is no MDIO bus or fixed-link for
the ethernet1 MAC, so no MDIO bus should be created since ethernet0
is the MDIO master for ethernet1's phy:

    &ethernet0 {
            phy-mode = "sgmii";
            phy-handle = <&sgmii_phy0>;

            mdio {
                    compatible = "snps,dwmac-mdio";
                    sgmii_phy0: phy@8 {
                            compatible = "ethernet-phy-id0141.0dd4";
                            reg = <0x8>;
                            device_type = "ethernet-phy";
                    };

                    sgmii_phy1: phy@a {
                            compatible = "ethernet-phy-id0141.0dd4";
                            reg = <0xa>;
                            device_type = "ethernet-phy";
                    };
            };
    };

    &ethernet1 {
            phy-mode = "sgmii";
            phy-handle = <&sgmii_phy1>;
    };

Finally there's descriptions like this[2] which don't describe the
MDIO bus but expect it to be created and the whole address space
scanned for a phy since there's no phy-handle or fixed-link described:

    &gmac {
            phy-supply = <&vcc_lan>;
            phy-mode = "rmii";
            snps,reset-gpio = <&gpio3 RK_PB4 GPIO_ACTIVE_HIGH>;
            snps,reset-active-low;
            snps,reset-delays-us = <0 10000 1000000>;
    };

[0] https://elixir.bootlin.com/linux/v6.5-rc5/source/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts
[1] https://elixir.bootlin.com/linux/v6.6-rc5/source/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
[2] https://elixir.bootlin.com/linux/v6.6-rc5/source/arch/arm64/boot/dts/rockchip/rk3368-r88.dts#L164

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 2b6ffcd7873b ("net: stmmac: restructure the error path of stmmac_probe_config_dt()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 91 +++++++++++--------
 1 file changed, 54 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 196fb1ddbec0..7f816f0cf9a5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -294,62 +294,80 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 }
 
 /**
- * stmmac_dt_phy - parse device-tree driver parameters to allocate PHY resources
- * @plat: driver data platform structure
- * @np: device tree node
- * @dev: device pointer
- * Description:
- * The mdio bus will be allocated in case of a phy transceiver is on board;
- * it will be NULL if the fixed-link is configured.
- * If there is the "snps,dwmac-mdio" sub-node the mdio will be allocated
- * in any case (for DSA, mdio must be registered even if fixed-link).
- * The table below sums the supported configurations:
- *	-------------------------------
- *	snps,phy-addr	|     Y
- *	-------------------------------
- *	phy-handle	|     Y
- *	-------------------------------
- *	fixed-link	|     N
- *	-------------------------------
- *	snps,dwmac-mdio	|
- *	  even if	|     Y
- *	fixed-link	|
- *	-------------------------------
+ * stmmac_of_get_mdio() - Gets the MDIO bus from the devicetree.
+ * @np: devicetree node
  *
- * It returns 0 in case of success otherwise -ENODEV.
+ * The MDIO bus will be searched for in the following ways:
+ * 1. The compatible is "snps,dwc-qos-ethernet-4.10" && a "mdio" named
+ *    child node exists
+ * 2. A child node with the "snps,dwmac-mdio" compatible is present
+ *
+ * Return: The MDIO node if present otherwise NULL
  */
-static int stmmac_dt_phy(struct plat_stmmacenet_data *plat,
-			 struct device_node *np, struct device *dev)
+static struct device_node *stmmac_of_get_mdio(struct device_node *np)
 {
-	bool mdio = !of_phy_is_fixed_link(np);
 	static const struct of_device_id need_mdio_ids[] = {
 		{ .compatible = "snps,dwc-qos-ethernet-4.10" },
 		{},
 	};
+	struct device_node *mdio_node = NULL;
 
 	if (of_match_node(need_mdio_ids, np)) {
-		plat->mdio_node = of_get_child_by_name(np, "mdio");
+		mdio_node = of_get_child_by_name(np, "mdio");
 	} else {
 		/**
 		 * If snps,dwmac-mdio is passed from DT, always register
 		 * the MDIO
 		 */
-		for_each_child_of_node(np, plat->mdio_node) {
-			if (of_device_is_compatible(plat->mdio_node,
+		for_each_child_of_node(np, mdio_node) {
+			if (of_device_is_compatible(mdio_node,
 						    "snps,dwmac-mdio"))
 				break;
 		}
 	}
 
-	if (plat->mdio_node) {
+	return mdio_node;
+}
+
+/**
+ * stmmac_mdio_setup() - Populate platform related MDIO structures.
+ * @plat: driver data platform structure
+ * @np: devicetree node
+ * @dev: device pointer
+ *
+ * This searches for MDIO information from the devicetree.
+ * If an MDIO node is found, it's assigned to plat->mdio_node and
+ * plat->mdio_bus_data is allocated.
+ * If no connection can be determined, just plat->mdio_bus_data is allocated
+ * to indicate a bus should be created and scanned for a phy.
+ * If it's determined there's no MDIO bus needed, both are left NULL.
+ *
+ * This expects that plat->phy_node has already been searched for.
+ *
+ * Return: 0 on success, errno otherwise.
+ */
+static int stmmac_mdio_setup(struct plat_stmmacenet_data *plat,
+			     struct device_node *np, struct device *dev)
+{
+	bool legacy_mdio;
+
+	plat->mdio_node = stmmac_of_get_mdio(np);
+	if (plat->mdio_node)
 		dev_dbg(dev, "Found MDIO subnode\n");
-		mdio = true;
-	}
 
-	if (mdio) {
-		plat->mdio_bus_data =
-			devm_kzalloc(dev, sizeof(struct stmmac_mdio_bus_data),
-				     GFP_KERNEL);
+	/* Legacy devicetrees allowed for no MDIO bus description and expect
+	 * the bus to be scanned for devices. If there's no phy or fixed-link
+	 * described assume this is the case since there must be something
+	 * connected to the MAC.
+	 */
+	legacy_mdio = !of_phy_is_fixed_link(np) && !plat->phy_node;
+	if (legacy_mdio)
+		dev_info(dev, "Deprecated MDIO bus assumption used\n");
+
+	if (plat->mdio_node || legacy_mdio) {
+		plat->mdio_bus_data = devm_kzalloc(dev,
+						   sizeof(*plat->mdio_bus_data),
+						   GFP_KERNEL);
 		if (!plat->mdio_bus_data)
 			return -ENOMEM;
 
@@ -453,8 +471,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	if (of_property_read_u32(np, "snps,phy-addr", &plat->phy_addr) == 0)
 		dev_warn(&pdev->dev, "snps,phy-addr property is deprecated\n");
 
-	/* To Configure PHY by using all device-tree supported properties */
-	rc = stmmac_dt_phy(plat, np, &pdev->dev);
+	rc = stmmac_mdio_setup(plat, np, &pdev->dev);
 	if (rc)
 		return ERR_PTR(rc);
 
-- 
2.39.5




