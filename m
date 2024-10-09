Return-Path: <stable+bounces-83129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0EF995E55
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 05:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B477D28145A
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 03:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2F9136982;
	Wed,  9 Oct 2024 03:50:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234CA44C8F;
	Wed,  9 Oct 2024 03:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728445820; cv=none; b=kaQogrCLyqtejqLZBgfcKfjaA1VzZkjVFb6hbKEpMaFk19NdX8sF0pzq2Z1i/h4DIaxApeM0ci21BBDSsRyFUVvY+0gSd52Q9ywFsLIM9Y5HhLfugcxgjWWqEjTmtvBlDQj4yF2MGf4NQ6eQ98aTQI2mXX6eJLIygxkr+QK4sZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728445820; c=relaxed/simple;
	bh=RsLBSffGM2Eu0Txsa+zkfPa3ino/gDkNdPh8ud2n3sg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=IEudWdoEfvw8gw7ZGJ8xDkhVFoMLouBmApXafwQeyodpysqSAG6cwEZ6Se8kZm1Jinj+N0uqeeAFxAQGRnyviANuE1mV9Q/gOKKn9xv8bUSi0aVzdwaRiQoqhqBqn06VQy7si+GZkbhJxtyJfuRW2C9rZhCc/M7G4N0yMajNvAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5C8BF200BBB;
	Wed,  9 Oct 2024 05:50:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D2D6200083;
	Wed,  9 Oct 2024 05:50:15 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4C448183DC03;
	Wed,  9 Oct 2024 11:50:13 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	Frank.Li@nxp.com,
	marcel.ziswiler@toradex.com
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	Richard Zhu <hongxing.zhu@nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH] phy: freescale: imx8m-pcie: Do CMN_RST just before PHY PLL lock check
Date: Wed,  9 Oct 2024 11:25:03 +0800
Message-Id: <1728444303-32416-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

When enable initcall_debug together with higher debug level below.
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=9
CONFIG_CONSOLE_LOGLEVEL_QUIET=9
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=7

The initialization of i.MX8MP PCIe PHY might be timeout failed randomly.
To fix this issue, adjust the sequence of the resets refer to the power
up sequence listed below.

i.MX8MP PCIe PHY power up sequence:
                          /---------------------------------------------
1.8v supply     ---------/
                    /---------------------------------------------------
0.8v supply     ---/

                ---\ /--------------------------------------------------
                    X        REFCLK Valid
Reference Clock ---/ \--------------------------------------------------
                             -------------------------------------------
                             |
i_init_restn    --------------
                                    ------------------------------------
                                    |
i_cmn_rstn      ---------------------
                                         -------------------------------
                                         |
o_pll_lock_done --------------------------

Logs:
imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 ranges:
imx6q-pcie 33800000.pcie:       IO 0x001ff80000..0x001ff8ffff -> 0x0000000000
imx6q-pcie 33800000.pcie:      MEM 0x0018000000..0x001fefffff -> 0x0018000000
probe of clk_imx8mp_audiomix.reset.0 returned 0 after 1052 usecs
probe of 30e20000.clock-controller returned 0 after 32971 usecs
phy phy-32f00000.pcie-phy.4: phy poweron failed --> -110
probe of 30e10000.dma-controller returned 0 after 10235 usecs
imx6q-pcie 33800000.pcie: waiting for PHY ready timeout!
dwhdmi-imx 32fd8000.hdmi: Detected HDMI TX controller v2.13a with HDCP (samsung_dw_hdmi_phy2)
imx6q-pcie 33800000.pcie: probe with driver imx6q-pcie failed with error -110

Fixes: dce9edff16ee ("phy: freescale: imx8m-pcie: Add i.MX8MP PCIe PHY support")
Cc: stable@vger.kernel.org
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index 8e7834e84af8c..694a6e6e5eafb 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -218,11 +218,6 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 		       imx8_phy->base + IMX8MP_PCIE_PHY_TRSV_REG206);
 	}
 
-	/* Do the PHY common block reset */
-	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
-			   IMX8MM_GPR_PCIE_CMN_RST,
-			   IMX8MM_GPR_PCIE_CMN_RST);
-
 	switch (imx8_phy->drvdata->variant) {
 	case IMX8MP:
 		reset_control_deassert(imx8_phy->perst);
@@ -233,6 +228,11 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 		break;
 	}
 
+	/* Do the PHY common block reset */
+	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
+			   IMX8MM_GPR_PCIE_CMN_RST,
+			   IMX8MM_GPR_PCIE_CMN_RST);
+
 	/* Polling to check the phy is ready or not. */
 	ret = readl_poll_timeout(imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG075,
 				 val, val == ANA_PLL_DONE, 10, 20000);
-- 
2.37.1


