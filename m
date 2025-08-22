Return-Path: <stable+bounces-172505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A1EB322B9
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 21:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8386850E5
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 19:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92877299A90;
	Fri, 22 Aug 2025 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQYqTuyK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510A54A1A
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890274; cv=none; b=d64+dtzjKFYlTLjuTFKdron2/6wr/L9sXAhQwkXOaODSBKvQoC7qC0I2bhmDmDuG5l2eaTSwdkEcrNZcosdrYqUOOrVSBZ8JK1a4drOBRu7+UBMsibOS3XZt75+S2c98GTRCdvpOQW5+gj3dvQl4i+Rs7IKLGtEysVlEVDm0eG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890274; c=relaxed/simple;
	bh=l/PUsOvuG3TAOj0DxY0H8ODLlkIDgamiTbU9cRqo2Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKeCTmRtD9MGyGZtKrtn/TJU0ls2iaR7RRSXR5GHRCtCadVIGItr1UZF+BdQyzqsAhcXnpNc9cX6OBI3E3gVatw4Q3PhY6CqV3ZA23sXW4EWVcRYkHwhIKSMOVhnrgrDhcR5g0VrXwivQi5jy4EsVWi7kfPxnUD3ckEAh+zj1gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQYqTuyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801F6C4CEED;
	Fri, 22 Aug 2025 19:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755890273;
	bh=l/PUsOvuG3TAOj0DxY0H8ODLlkIDgamiTbU9cRqo2Rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQYqTuyKd8dtkDK/NhP3Vpqu+yRCgM5YsxCPZ/o5VxIqu4JeK2OSP42Qb7SfWJBsr
	 xPl/yGnoFeDlTK68LxHJYGlCjmw4cHQA5xY/BCXudT8LFSfY5zhTYJZpWCHVI+kJDn
	 chG8nYSmQ3MzAYR0Ob/mjWEmi51Ixd5Z+yOyFYkqmRNXYwXkinuXPDMosbdYr8sy+Y
	 MsVaCFJ+oLCxLIkstBj+KXlCXD0nDl+FXBhm6iwCmkofVsDeQtFRqMAGWdoyYsLX01
	 5PMMy3P/HmdE4g8QpLBxOVqlMar/uwhPsUjiA02Bm3mrINOCJVk1OUnow2ZWmFlKLi
	 fUuH/pnvSa3zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support
Date: Fri, 22 Aug 2025 15:17:49 -0400
Message-ID: <20250822191750.1437890-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082145-scrap-ride-31b5@gregkh>
References: <2025082145-scrap-ride-31b5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit 687aedb73a401addf151c5f60e481e574b4c9ad9 ]

Add support for the i.MX8Q series (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe
Endpoint (EP). On the i.MX8Q platforms, the PCI bus addresses differ
from the CPU addresses. However, the DesignWare (DWC) driver already
handles this in the common code.

Link: https://lore.kernel.org/r/20241119-pci_fixup_addr-v8-7-c4bfa5193288@nxp.com
Signed-off-by: Frank Li <Frank.Li@nxp.com>
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Stable-dep-of: c523fa63ac1d ("PCI: imx6: Add IMX8MQ_EP third 64-bit BAR in epc_features")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 3b24fed3177d..70f281abb607 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -72,6 +72,7 @@ enum imx_pcie_variants {
 	IMX8MQ_EP,
 	IMX8MM_EP,
 	IMX8MP_EP,
+	IMX8Q_EP,
 	IMX95_EP,
 };
 
@@ -1100,6 +1101,16 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 	.align = SZ_64K,
 };
 
+static const struct pci_epc_features imx8q_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+	.bar[BAR_1] = { .type = BAR_RESERVED, },
+	.bar[BAR_3] = { .type = BAR_RESERVED, },
+	.bar[BAR_5] = { .type = BAR_RESERVED, },
+	.align = SZ_64K,
+};
+
 /*
  * BAR#	| Default BAR enable	| Default BAR Type	| Default BAR Size	| BAR Sizing Scheme
  * ================================================================================================
@@ -1695,6 +1706,14 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.epc_features = &imx8m_pcie_epc_features,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
+	[IMX8Q_EP] = {
+		.variant = IMX8Q_EP,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
+		.mode = DW_PCIE_EP_TYPE,
+		.epc_features = &imx8q_pcie_epc_features,
+		.clk_names = imx8q_clks,
+		.clks_cnt = ARRAY_SIZE(imx8q_clks),
+	},
 	[IMX95_EP] = {
 		.variant = IMX95_EP,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
@@ -1724,6 +1743,7 @@ static const struct of_device_id imx_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
+	{ .compatible = "fsl,imx8q-pcie-ep", .data = &drvdata[IMX8Q_EP], },
 	{ .compatible = "fsl,imx95-pcie-ep", .data = &drvdata[IMX95_EP], },
 	{},
 };
-- 
2.50.1


