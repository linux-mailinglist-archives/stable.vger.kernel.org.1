Return-Path: <stable+bounces-172518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E34B323B5
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 22:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1C11705D3
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 20:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7932D7804;
	Fri, 22 Aug 2025 20:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6yx4KGU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05772D6E43
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755895264; cv=none; b=BeDLdbLHiSNOsovrXQIrEWTtOHWI47QN++zmWfwarTlDSGUYcKs3nykRQfhg7MnG+cJQFy9VcPc8bWV+ZGwDgG7eE0gVF+45Z/4Kh38eh1LSGpq2P8l5oil4FIwWgoWURciwlBehuwspXGM8EXMOlPH3wPviK/6oq4rQXQQQ/sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755895264; c=relaxed/simple;
	bh=NaJHpuHgj3juBZrAz4p4MWfBgFkD9ua6A/uqKf8p0+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tl3Z7P43RbHEuhpBD66xmQwE9050olMXwmR2enevZp6kG9790Ikg3oMXcVK2jZ7dym2VGXKMiz1k0buraEL19jrgt4DRqBuzvKCcCEoWcxpLRbNPeoIxK5/QJj7Pc5gbdgDRrNwo0bUgIBHjIvCAiCuSI58EfeBWtGZlV99NhCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6yx4KGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FF2C4CEED;
	Fri, 22 Aug 2025 20:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755895263;
	bh=NaJHpuHgj3juBZrAz4p4MWfBgFkD9ua6A/uqKf8p0+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i6yx4KGUc66XMkU/nXJ/1Jz+UrdYmaY9ndX5OtCqhyT4C4t+2GdxEcBRPE8dNwzmD
	 nwG8xRPum4Dn69LSWbf/UA+DHFVr1KsUFVdBf3cu+01A48y2L0u+v4NcJGn9g5Fvss
	 5LxC792CETwfBorRUjClf1zCqD2N90AaIWAS+LsbjYViCfqg6/NxARURTS4IgjCvMM
	 qJlA/1OBTWW/Tgkst2wZuEfbrbbVL3J0XQv3TTdcLcshuxudPA+naX1kY9h10GOUkE
	 nYLhSDta1aI+6GXsjeFjnrLEsRac2OK/IOPnNBjczNLw7HgAGhwHO/bptFmolEOf6I
	 /uDMOkR2tSpVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geraldo Nascimento <geraldogabriel@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] PCI: rockchip: Use standard PCIe definitions
Date: Fri, 22 Aug 2025 16:40:58 -0400
Message-ID: <20250822204059.1520239-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082126-primp-scoff-af34@gregkh>
References: <2025082126-primp-scoff-af34@gregkh>
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
index 6ff20d585396..b262480a12b0 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -11,6 +11,7 @@
  * ARM PCI Host generic driver.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitrev.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -40,18 +41,18 @@ static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
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
@@ -269,7 +270,7 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
 	scale = 3; /* 0.001x */
 	curr = curr / 1000; /* convert to mA */
 	power = (curr * 3300) / 1000; /* milliwatt */
-	while (power > PCIE_RC_CONFIG_DCR_CSPL_LIMIT) {
+	while (power > FIELD_MAX(PCI_EXP_DEVCAP_PWR_VAL)) {
 		if (!scale) {
 			dev_warn(rockchip->dev, "invalid power supply\n");
 			return;
@@ -278,10 +279,10 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
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
@@ -309,14 +310,14 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
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
@@ -338,9 +339,9 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
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
@@ -377,15 +378,15 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 
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


