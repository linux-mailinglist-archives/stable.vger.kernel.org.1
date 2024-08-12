Return-Path: <stable+bounces-66948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CE594F337
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224261C219D9
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4C2187561;
	Mon, 12 Aug 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NETi/yXM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19CE178CE4;
	Mon, 12 Aug 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479305; cv=none; b=I3vST0WD0RipUbapLIEKPaO3yXk1S5d7qI+YAChVnNr8+P9FJ4jWQt/oOQjbl6QCoHJXIP1oiJn81mpxZ5PC10jF5Nf06/ogmRW05vHqVfTdzaJVLLrtKJlHHHnpmhCkKRsi3qgDK0zP2VWF2uiXdQfFEKYsb9hqWqQ5l236Ys0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479305; c=relaxed/simple;
	bh=uaDu12NnOtIjRaUGjA5F86JhX1v1yOQuHRjoyY9XImM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MznU5EfAimrMqUkV5Bnge9QYXeVIQFWXKGViclR9cDNLeUvKHsx1asM4kvKnS4UFtTBZteIihJEwBaxtl3l7D4ATEz8SqaOxytxZKVNpyaqF0vN56FZ7hWUlBVCE2NOEgFZEdhPevwdkCoFq8GdB+ZqNvoEMRu6WuVLQyUT4Wng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NETi/yXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B76AC32782;
	Mon, 12 Aug 2024 16:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479305;
	bh=uaDu12NnOtIjRaUGjA5F86JhX1v1yOQuHRjoyY9XImM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NETi/yXMhgUGZZBfrfKleNQJwgH07KmzicuBUeya4P/5hjjpftuhgQkr5npvJzFBK
	 Mr+PO8nHrlvpnkecXluHzJWMEjHd8ET3y2qBuCQE+NNiPRPo/H0ItLt/3ybIe/J5w4
	 r2CJjwRAp3cgXrJeTl0KstF/I4eNlHSJRdrXcqyo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 045/189] net: stmmac: qcom-ethqos: enable SGMII loopback during DMA reset on sa8775p-ride-r3
Date: Mon, 12 Aug 2024 18:01:41 +0200
Message-ID: <20240812160133.881424473@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
References: <20240812160132.135168257@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[ Upstream commit 3c466d6537b99f801b3f68af3d8124d4312437a0 ]

On sa8775p-ride-r3 the RX clocks from the AQR115C PHY are not available at
the time of the DMA reset. We can however extract the RX clock from the
internal SERDES block. Once the link is up, we can revert to the
previous state.

The AQR115C PHY doesn't support in-band signalling so we can count on
getting the link up notification and safely reuse existing callbacks
which are already used by another HW quirk workaround which enables the
functional clock to avoid a DMA reset due to timeout.

Only enable loopback on revision 3 of the board - check the phy_mode to
make sure.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20240703181500.28491-3-brgl@bgdev.pl
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index d5d2a4c776c1c..ded1bbda5266f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -21,6 +21,7 @@
 #define RGMII_IO_MACRO_CONFIG2		0x1C
 #define RGMII_IO_MACRO_DEBUG1		0x20
 #define EMAC_SYSTEM_LOW_POWER_DEBUG	0x28
+#define EMAC_WRAPPER_SGMII_PHY_CNTRL1	0xf4
 
 /* RGMII_IO_MACRO_CONFIG fields */
 #define RGMII_CONFIG_FUNC_CLK_EN		BIT(30)
@@ -79,6 +80,9 @@
 #define ETHQOS_MAC_CTRL_SPEED_MODE		BIT(14)
 #define ETHQOS_MAC_CTRL_PORT_SEL		BIT(15)
 
+/* EMAC_WRAPPER_SGMII_PHY_CNTRL1 bits */
+#define SGMII_PHY_CNTRL1_SGMII_TX_TO_RX_LOOPBACK_EN	BIT(3)
+
 #define SGMII_10M_RX_CLK_DVDR			0x31
 
 struct ethqos_emac_por {
@@ -95,6 +99,7 @@ struct ethqos_emac_driver_data {
 	bool has_integrated_pcs;
 	u32 dma_addr_width;
 	struct dwmac4_addrs dwmac4_addrs;
+	bool needs_sgmii_loopback;
 };
 
 struct qcom_ethqos {
@@ -113,6 +118,7 @@ struct qcom_ethqos {
 	unsigned int num_por;
 	bool rgmii_config_loopback_en;
 	bool has_emac_ge_3;
+	bool needs_sgmii_loopback;
 };
 
 static int rgmii_readl(struct qcom_ethqos *ethqos, unsigned int offset)
@@ -187,8 +193,22 @@ ethqos_update_link_clk(struct qcom_ethqos *ethqos, unsigned int speed)
 	clk_set_rate(ethqos->link_clk, ethqos->link_clk_rate);
 }
 
+static void
+qcom_ethqos_set_sgmii_loopback(struct qcom_ethqos *ethqos, bool enable)
+{
+	if (!ethqos->needs_sgmii_loopback ||
+	    ethqos->phy_mode != PHY_INTERFACE_MODE_2500BASEX)
+		return;
+
+	rgmii_updatel(ethqos,
+		      SGMII_PHY_CNTRL1_SGMII_TX_TO_RX_LOOPBACK_EN,
+		      enable ? SGMII_PHY_CNTRL1_SGMII_TX_TO_RX_LOOPBACK_EN : 0,
+		      EMAC_WRAPPER_SGMII_PHY_CNTRL1);
+}
+
 static void ethqos_set_func_clk_en(struct qcom_ethqos *ethqos)
 {
+	qcom_ethqos_set_sgmii_loopback(ethqos, true);
 	rgmii_updatel(ethqos, RGMII_CONFIG_FUNC_CLK_EN,
 		      RGMII_CONFIG_FUNC_CLK_EN, RGMII_IO_MACRO_CONFIG);
 }
@@ -273,6 +293,7 @@ static const struct ethqos_emac_driver_data emac_v4_0_0_data = {
 	.has_emac_ge_3 = true,
 	.link_clk_name = "phyaux",
 	.has_integrated_pcs = true,
+	.needs_sgmii_loopback = true,
 	.dma_addr_width = 36,
 	.dwmac4_addrs = {
 		.dma_chan = 0x00008100,
@@ -646,6 +667,7 @@ static void ethqos_fix_mac_speed(void *priv, unsigned int speed, unsigned int mo
 {
 	struct qcom_ethqos *ethqos = priv;
 
+	qcom_ethqos_set_sgmii_loopback(ethqos, false);
 	ethqos->speed = speed;
 	ethqos_update_link_clk(ethqos, speed);
 	ethqos_configure(ethqos);
@@ -781,6 +803,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	ethqos->num_por = data->num_por;
 	ethqos->rgmii_config_loopback_en = data->rgmii_config_loopback_en;
 	ethqos->has_emac_ge_3 = data->has_emac_ge_3;
+	ethqos->needs_sgmii_loopback = data->needs_sgmii_loopback;
 
 	ethqos->link_clk = devm_clk_get(dev, data->link_clk_name ?: "rgmii");
 	if (IS_ERR(ethqos->link_clk))
-- 
2.43.0




