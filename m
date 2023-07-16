Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C507555DC
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjGPUpY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjGPUpX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:45:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9868D9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8021D60E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936B9C433C7;
        Sun, 16 Jul 2023 20:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540322;
        bh=DCEjJBDbUc/pG+MkgnjkrYlp49q1Hq/lvRVYjaX1IOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CICYa8VR84k/bT97+r0RFxSyhCw+TrTha4ikiYDGX/0l8anf46hRniU9jGkSqxsdU
         utPX5rzR81lVHysVNkrqMjheTmiCPOZQrTVY2kCOQulOOSR6GvP6d7yeXjcbzaFcNi
         MSK3Ay851rZS/Uk+aHsiBE3rfWoln82IeuX4bik0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 322/591] PCI: qcom: Sort and group registers and bitfield definitions
Date:   Sun, 16 Jul 2023 21:47:41 +0200
Message-ID: <20230716194932.221779273@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit 769e49d87b15c302c9aadd87c7d114cfe7052320 ]

Sorting the registers and their bit definitions will make it easier to add
more definitions in the future and it also helps in maintenance.

While at it, let's also group the registers and bit definitions separately
as done in the pcie-qcom-ep driver.

Link: https://lore.kernel.org/r/20230316081117.14288-4-manivannan.sadhasivam@linaro.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Stable-dep-of: 60f0072d7fb7 ("PCI: qcom: Use DWC helpers for modifying the read-only DBI registers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 108 ++++++++++++++-----------
 1 file changed, 63 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b587957211c3f..1c8200656aef9 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -31,7 +31,36 @@
 #include "../../pci.h"
 #include "pcie-designware.h"
 
+/* PARF registers */
 #define PARF_SYS_CTRL				0x00
+#define PARF_PM_CTRL				0x20
+#define PARF_PCS_DEEMPH				0x34
+#define PARF_PCS_SWING				0x38
+#define PARF_PHY_CTRL				0x40
+#define PARF_PHY_REFCLK				0x4C
+#define PARF_CONFIG_BITS			0x50
+#define PARF_DBI_BASE_ADDR			0x168
+#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16C /* Register offset specific to IP ver 2.3.3 */
+#define PARF_MHI_CLOCK_RESET_CTRL		0x174
+#define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
+#define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1A8
+#define PARF_Q2A_FLUSH				0x1AC
+#define PARF_LTSSM				0x1B0
+#define PARF_SID_OFFSET				0x234
+#define PARF_BDF_TRANSLATE_CFG			0x24C
+#define PARF_SLV_ADDR_SPACE_SIZE		0x358
+#define PARF_DEVICE_TYPE			0x1000
+#define PARF_BDF_TO_SID_TABLE_N			0x2000
+
+/* ELBI registers */
+#define ELBI_SYS_CTRL				0x04
+
+/* DBI registers */
+#define AXI_MSTR_RESP_COMP_CTRL0		0x818
+#define AXI_MSTR_RESP_COMP_CTRL1		0x81c
+#define MISC_CONTROL_1_REG			0x8BC
+
+/* PARF_SYS_CTRL register fields */
 #define MST_WAKEUP_EN				BIT(13)
 #define SLV_WAKEUP_EN				BIT(12)
 #define MSTR_ACLK_CGC_DIS			BIT(10)
@@ -41,45 +70,56 @@
 #define L23_CLK_RMV_DIS				BIT(2)
 #define L1_CLK_RMV_DIS				BIT(1)
 
-#define PARF_PM_CTRL				0x20
+/* PARF_PM_CTRL register fields */
 #define REQ_NOT_ENTR_L1				BIT(5)
 
-#define PARF_PHY_CTRL				0x40
+/* PARF_PCS_DEEMPH register fields */
+#define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		((x) << 16)
+#define PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(x)	((x) << 8)
+#define PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(x)	((x) << 0)
+
+/* PARF_PCS_SWING register fields */
+#define PCS_SWING_TX_SWING_FULL(x)		((x) << 8)
+#define PCS_SWING_TX_SWING_LOW(x)		((x) << 0)
+
+/* PARF_PHY_CTRL register fields */
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
 
-#define PARF_PHY_REFCLK				0x4C
+/* PARF_PHY_REFCLK register fields */
 #define PHY_REFCLK_SSP_EN			BIT(16)
 #define PHY_REFCLK_USE_PAD			BIT(12)
 
-#define PARF_DBI_BASE_ADDR			0x168
-#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16C /* Register offset specific to IP rev 2.3.3 */
-#define PARF_MHI_CLOCK_RESET_CTRL		0x174
+/* PARF_CONFIG_BITS register fields */
+#define PHY_RX0_EQ(x)				((x) << 24)
+
+/* PARF_SLV_ADDR_SPACE_SIZE register value */
+#define SLV_ADDR_SPACE_SZ			0x10000000
+
+/* PARF_MHI_CLOCK_RESET_CTRL register fields */
 #define AHB_CLK_EN				BIT(0)
 #define MSTR_AXI_CLK_EN				BIT(1)
 #define BYPASS					BIT(4)
 
-#define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
-#define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1A8
-#define PARF_LTSSM				0x1B0
-#define PARF_SID_OFFSET				0x234
-#define PARF_BDF_TRANSLATE_CFG			0x24C
-#define PARF_DEVICE_TYPE			0x1000
-#define PARF_BDF_TO_SID_TABLE_N			0x2000
+/* PARF_DEVICE_TYPE register fields */
+#define DEVICE_TYPE_RC				0x4
 
-#define ELBI_SYS_CTRL				0x04
+/* ELBI_SYS_CTRL register fields */
 #define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
 
-#define AXI_MSTR_RESP_COMP_CTRL0		0x818
+/* AXI_MSTR_RESP_COMP_CTRL0 register fields */
 #define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K	0x4
 #define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_4K	0x5
-#define AXI_MSTR_RESP_COMP_CTRL1		0x81c
+
+/* AXI_MSTR_RESP_COMP_CTRL1 register fields */
 #define CFG_BRIDGE_SB_INIT			BIT(0)
 
-#define PCIE_CAP_SLOT_POWER_LIMIT_VAL		FIELD_PREP(PCI_EXP_SLTCAP_SPLV, \
-						250)
-#define PCIE_CAP_SLOT_POWER_LIMIT_SCALE		FIELD_PREP(PCI_EXP_SLTCAP_SPLS, \
-						1)
+/* MISC_CONTROL_1_REG register fields */
+#define DBI_RO_WR_EN				1
+
+/* PCI_EXP_SLTCAP register fields */
+#define PCIE_CAP_SLOT_POWER_LIMIT_VAL		FIELD_PREP(PCI_EXP_SLTCAP_SPLV, 250)
+#define PCIE_CAP_SLOT_POWER_LIMIT_SCALE		FIELD_PREP(PCI_EXP_SLTCAP_SPLS, 1)
 #define PCIE_CAP_SLOT_VAL			(PCI_EXP_SLTCAP_ABP | \
 						PCI_EXP_SLTCAP_PCP | \
 						PCI_EXP_SLTCAP_MRLSP | \
@@ -91,34 +131,12 @@
 						PCIE_CAP_SLOT_POWER_LIMIT_VAL | \
 						PCIE_CAP_SLOT_POWER_LIMIT_SCALE)
 
-#define PARF_Q2A_FLUSH				0x1AC
-
-#define MISC_CONTROL_1_REG			0x8BC
-#define DBI_RO_WR_EN				1
-
 #define PERST_DELAY_US				1000
-/* PARF registers */
-#define PARF_PCS_DEEMPH				0x34
-#define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		((x) << 16)
-#define PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(x)	((x) << 8)
-#define PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(x)	((x) << 0)
-
-#define PARF_PCS_SWING				0x38
-#define PCS_SWING_TX_SWING_FULL(x)		((x) << 8)
-#define PCS_SWING_TX_SWING_LOW(x)		((x) << 0)
-
-#define PARF_CONFIG_BITS			0x50
-#define PHY_RX0_EQ(x)				((x) << 24)
-
-#define PARF_SLV_ADDR_SPACE_SIZE		0x358
-#define SLV_ADDR_SPACE_SZ			0x10000000
-
-#define DEVICE_TYPE_RC				0x4
 
-#define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
-#define QCOM_PCIE_2_1_0_MAX_CLOCKS	5
+#define QCOM_PCIE_2_1_0_MAX_SUPPLY		3
+#define QCOM_PCIE_2_1_0_MAX_CLOCKS		5
 
-#define QCOM_PCIE_CRC8_POLYNOMIAL (BIT(2) | BIT(1) | BIT(0))
+#define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
 
 struct qcom_pcie_resources_2_1_0 {
 	struct clk_bulk_data clks[QCOM_PCIE_2_1_0_MAX_CLOCKS];
-- 
2.39.2



