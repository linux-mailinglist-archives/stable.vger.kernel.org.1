Return-Path: <stable+bounces-172520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E99DB323D1
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 22:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4A11D62187
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 20:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754A12FC01D;
	Fri, 22 Aug 2025 20:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYi20M1y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BF32ED14B
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 20:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755896148; cv=none; b=OWnjSAr6FYQcGg+fGyGo7x4GR0sneWaMN7M4eiMAXH7sXUGGSO2MjaH5YOcduDIAev+mtI2qaTaS1v665Gi55ZYQaznNXjeobTPJd0RAAflnfZ8gwy10sMTKVT/mf2nwNffWUv5L3Bm3BO6TJx4UaDpKAlGPVHrSFY/iaLeVaqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755896148; c=relaxed/simple;
	bh=REwiQDGBQu4i4SFc/kKvvVZBr21eg54I//GnsYU1Fr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eb4A/XK5/tcgkWsrvKn+tAS9YjzhxvITYtdl58aAdZEmNWcu+Agn0FmkDyyLS5pL9lkbvis4YtBiVgyx57jBzBK1XDB6AykqWB9hgPsvkMxMlRrdFEG1hP9iKok+4riuE1XmqreGhfIXj17J5ixAw/56zY7MiIA3KE4/qp6/mRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYi20M1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03669C4CEF1;
	Fri, 22 Aug 2025 20:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755896147;
	bh=REwiQDGBQu4i4SFc/kKvvVZBr21eg54I//GnsYU1Fr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TYi20M1yNGXh4d++Znzl1Lac80Lg3ojUZUgtfsjRqsQx16NEwDCRUljOCqwS5xBPG
	 PWwBUdEqKSkuC44qPVApaSC6WAWK5WY+I0TSy8BIkPrUs1h3zs/SbKhsnMhYr6apBr
	 mbYAATGlmION9edSq6A1LXHePLpcysXw5nx5Wdi1sq4dwNDcp35Z3OhZPdvxeXIWVy
	 FOxDrPufm82zNbPQuETHsH3QN9Y6HbR93HzU206ZXPUbXygRUJbN/dG7yQ8wY0y/tC
	 LuH9LZCqXwGkeNxBsGwS+4Mh+vPORHyuv7+yzIR/OBUr8x4gDY7aMc7jxx9Q+XKaq8
	 AWp2MdTKGD5tg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geraldo Nascimento <geraldogabriel@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] PCI: rockchip: Use standard PCIe definitions
Date: Fri, 22 Aug 2025 16:55:43 -0400
Message-ID: <20250822205544.1528134-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082127-dreamy-chase-b12a@gregkh>
References: <2025082127-dreamy-chase-b12a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geraldo Nascimento <geraldogabriel@gmail.com>

[ Upstream commit cbbfe9f683f0f9b6a1da2eaa53b995a4b5961086 ]

Current code uses custom-defined register offsets and bitfields for the
standard PCIe registers. This creates duplication as the PCI header already
defines them. So, switch to using the standard PCIe definitions and drop
the custom ones.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
[mani: commit message rewording]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
[bhelgaas: include bitfield.h]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/e81700ef4b49f584bc8834bfb07b6d8995fc1f42.1751322015.git.geraldogabriel@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-host.c | 45 +++++++++++----------
 drivers/pci/controller/pcie-rockchip.h      | 11 +----
 2 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index bd982390e04c..f10023fb59ee 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -11,6 +11,7 @@
  * ARM PCI Host generic driver.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitrev.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -43,18 +44,18 @@ static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
 {
 	u32 status;
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 	status |= (PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 }
 
 static void rockchip_pcie_clr_bw_int(struct rockchip_pcie *rockchip)
 {
 	u32 status;
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 	status |= (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS) << 16;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 }
 
 static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
@@ -272,7 +273,7 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
 	scale = 3; /* 0.001x */
 	curr = curr / 1000; /* convert to mA */
 	power = (curr * 3300) / 1000; /* milliwatt */
-	while (power > PCIE_RC_CONFIG_DCR_CSPL_LIMIT) {
+	while (power > FIELD_MAX(PCI_EXP_DEVCAP_PWR_VAL)) {
 		if (!scale) {
 			dev_warn(rockchip->dev, "invalid power supply\n");
 			return;
@@ -281,10 +282,10 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
 		power = power / 10;
 	}
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCR);
-	status |= (power << PCIE_RC_CONFIG_DCR_CSPL_SHIFT) |
-		  (scale << PCIE_RC_CONFIG_DCR_CPLS_SHIFT);
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCR);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCAP);
+	status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_VAL, power);
+	status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_SCL, scale);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCAP);
 }
 
 /**
@@ -312,14 +313,14 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_set_power_limit(rockchip);
 
 	/* Set RC's clock architecture as common clock */
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 	status |= PCI_EXP_LNKSTA_SLC << 16;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 
 	/* Set RC's RCB to 128 */
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 	status |= PCI_EXP_LNKCTL_RCB;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 
 	/* Enable Gen1 training */
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
@@ -341,9 +342,9 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		 * Enable retrain for gen2. This should be configured only after
 		 * gen1 finished.
 		 */
-		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 		status |= PCI_EXP_LNKCTL_RL;
-		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 
 		err = readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
 					 status, PCIE_LINK_IS_GEN2(status), 20,
@@ -380,15 +381,15 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 
 	/* Clear L0s from RC's link cap */
 	if (of_property_read_bool(dev->of_node, "aspm-no-l0s")) {
-		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LINK_CAP);
-		status &= ~PCIE_RC_CONFIG_LINK_CAP_L0S;
-		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LINK_CAP);
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP);
+		status &= ~PCI_EXP_LNKCAP_ASPM_L0S;
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP);
 	}
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCSR);
-	status &= ~PCIE_RC_CONFIG_DCSR_MPS_MASK;
-	status |= PCIE_RC_CONFIG_DCSR_MPS_256;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCSR);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL);
+	status &= ~PCI_EXP_DEVCTL_PAYLOAD;
+	status |= PCI_EXP_DEVCTL_PAYLOAD_256B;
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL);
 
 	return 0;
 err_power_off_phy:
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 15ee949f2485..049ad984a416 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -144,16 +144,7 @@
 #define PCIE_EP_CONFIG_BASE		0xa00000
 #define PCIE_EP_CONFIG_DID_VID		(PCIE_EP_CONFIG_BASE + 0x00)
 #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
-#define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
-#define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
-#define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
-#define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
-#define PCIE_RC_CONFIG_DCSR		(PCIE_RC_CONFIG_BASE + 0xc8)
-#define   PCIE_RC_CONFIG_DCSR_MPS_MASK		GENMASK(7, 5)
-#define   PCIE_RC_CONFIG_DCSR_MPS_256		(0x1 << 5)
-#define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_BASE + 0xcc)
-#define   PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
-#define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
+#define PCIE_RC_CONFIG_CR		(PCIE_RC_CONFIG_BASE + 0xc0)
 #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
 #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
 #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
-- 
2.50.1


