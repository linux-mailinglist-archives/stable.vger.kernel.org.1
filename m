Return-Path: <stable+bounces-605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 831CC7F7BC8
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26A4DB20C4B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D3939FF8;
	Fri, 24 Nov 2023 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aUuHeJya"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEB439FDD;
	Fri, 24 Nov 2023 18:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDACC433C8;
	Fri, 24 Nov 2023 18:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849317;
	bh=cdp92z9FkSuUM1Rm8dSA0+1ceu947BbDJNisZSqnMrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aUuHeJyaYHH2GB/6P2L3P3snx0avUZbBmGyHUyAgMYIAsj3+YA0sBuJ27KDP1+Jw8
	 957BmB837+6KWOxbnQ/ASZow4TPqpWknNK0BA31xCS1+Rw2d3jm3yCV4rRLpIqRuv/
	 zF7TdVeBB0VLGruKxai5a46bwJRO4MtX4gZSU25s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 109/530] PCI: dwc: Add dw_pcie_link_set_max_link_width()
Date: Fri, 24 Nov 2023 17:44:35 +0000
Message-ID: <20231124172031.440998379@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit a9a1bcba90254975d4adbcca53f720318cf81c0c ]

This is a preparation before adding the Max-Link-width capability
setup which would in its turn complete the max-link-width setup
procedure defined by Synopsys in the HW-manual.

Seeing there is a max-link-speed setup method defined in the DW PCIe
core driver it would be good to have a similar function for the link
width setup.

That's why we need to define a dedicated function first from already
implemented but incomplete link-width setting up code.

Link: https://lore.kernel.org/linux-pci/20231018085631.1121289-3-yoshihiro.shimoda.uh@renesas.com
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 86 ++++++++++----------
 1 file changed, 41 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 1c1c7348972b0..da4aba4aee623 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -732,6 +732,46 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
 
 }
 
+static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
+{
+	u32 lwsc, plc;
+
+	if (!num_lanes)
+		return;
+
+	/* Set the number of lanes */
+	plc = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
+	plc &= ~PORT_LINK_FAST_LINK_MODE;
+	plc &= ~PORT_LINK_MODE_MASK;
+
+	/* Set link width speed control register */
+	lwsc = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	lwsc &= ~PORT_LOGIC_LINK_WIDTH_MASK;
+	switch (num_lanes) {
+	case 1:
+		plc |= PORT_LINK_MODE_1_LANES;
+		lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
+		break;
+	case 2:
+		plc |= PORT_LINK_MODE_2_LANES;
+		lwsc |= PORT_LOGIC_LINK_WIDTH_2_LANES;
+		break;
+	case 4:
+		plc |= PORT_LINK_MODE_4_LANES;
+		lwsc |= PORT_LOGIC_LINK_WIDTH_4_LANES;
+		break;
+	case 8:
+		plc |= PORT_LINK_MODE_8_LANES;
+		lwsc |= PORT_LOGIC_LINK_WIDTH_8_LANES;
+		break;
+	default:
+		dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
+		return;
+	}
+	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
+	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
+}
+
 void dw_pcie_iatu_detect(struct dw_pcie *pci)
 {
 	int max_region, ob, ib;
@@ -1013,49 +1053,5 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	val |= PORT_LINK_DLL_LINK_EN;
 	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
 
-	if (!pci->num_lanes) {
-		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
-		return;
-	}
-
-	/* Set the number of lanes */
-	val &= ~PORT_LINK_FAST_LINK_MODE;
-	val &= ~PORT_LINK_MODE_MASK;
-	switch (pci->num_lanes) {
-	case 1:
-		val |= PORT_LINK_MODE_1_LANES;
-		break;
-	case 2:
-		val |= PORT_LINK_MODE_2_LANES;
-		break;
-	case 4:
-		val |= PORT_LINK_MODE_4_LANES;
-		break;
-	case 8:
-		val |= PORT_LINK_MODE_8_LANES;
-		break;
-	default:
-		dev_err(pci->dev, "num-lanes %u: invalid value\n", pci->num_lanes);
-		return;
-	}
-	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
-
-	/* Set link width speed control register */
-	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
-	switch (pci->num_lanes) {
-	case 1:
-		val |= PORT_LOGIC_LINK_WIDTH_1_LANES;
-		break;
-	case 2:
-		val |= PORT_LOGIC_LINK_WIDTH_2_LANES;
-		break;
-	case 4:
-		val |= PORT_LOGIC_LINK_WIDTH_4_LANES;
-		break;
-	case 8:
-		val |= PORT_LOGIC_LINK_WIDTH_8_LANES;
-		break;
-	}
-	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
 }
-- 
2.42.0




