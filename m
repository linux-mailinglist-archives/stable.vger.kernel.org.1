Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E2D79BB93
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240801AbjIKVEk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239153AbjIKONI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:13:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F97DDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:13:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E816DC433C8;
        Mon, 11 Sep 2023 14:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441584;
        bh=zzaxbCRiJ20QLCspOUFSSdYuPIp8lI+XlrwNmRB4GA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E3Nqgywk84WVNowSYdx7O2vySdUyfcDtnS2f58fXi1eI6oSQVmdB2UGLPxlpK3aoF
         wJNaax9SFOdqchzAf3d6k6T8fwwPLR6fAWz/JAKmPjowjJKOouGuXXFAR7p/YoROUX
         6bpfRar5Ji6uYW/9LcyZARMXHShGSvebB093l0CM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Frank Li <Frank.Li@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 433/739] PCI: layerscape: Add workaround for lost link capabilities during reset
Date:   Mon, 11 Sep 2023 15:43:52 +0200
Message-ID: <20230911134703.268526269@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiaowei Bao <xiaowei.bao@nxp.com>

[ Upstream commit 17cf8661ee0f065c08152e611a568dd1fb0285f1 ]

The endpoint controller loses the Maximum Link Width and Supported Link Speed
value from the Link Capabilities Register - initially configured by the Reset
Configuration Word (RCW) - during a link-down or hot reset event.

Address this issue in the endpoint event handler.

Link: https://lore.kernel.org/r/20230720135834.1977616-2-Frank.Li@nxp.com
Fixes: a805770d8a22 ("PCI: layerscape: Add EP mode support")
Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../pci/controller/dwc/pci-layerscape-ep.c    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index de4c1758a6c33..19595e93dd4b6 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -45,6 +45,7 @@ struct ls_pcie_ep {
 	struct pci_epc_features		*ls_epc;
 	const struct ls_pcie_ep_drvdata *drvdata;
 	int				irq;
+	u32				lnkcap;
 	bool				big_endian;
 };
 
@@ -73,6 +74,7 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
 	struct ls_pcie_ep *pcie = dev_id;
 	struct dw_pcie *pci = pcie->pci;
 	u32 val, cfg;
+	u8 offset;
 
 	val = ls_lut_readl(pcie, PEX_PF0_PME_MES_DR);
 	ls_lut_writel(pcie, PEX_PF0_PME_MES_DR, val);
@@ -81,6 +83,19 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	if (val & PEX_PF0_PME_MES_DR_LUD) {
+
+		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+
+		/*
+		 * The values of the Maximum Link Width and Supported Link
+		 * Speed from the Link Capabilities Register will be lost
+		 * during link down or hot reset. Restore initial value
+		 * that configured by the Reset Configuration Word (RCW).
+		 */
+		dw_pcie_dbi_ro_wr_en(pci);
+		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, pcie->lnkcap);
+		dw_pcie_dbi_ro_wr_dis(pci);
+
 		cfg = ls_lut_readl(pcie, PEX_PF0_CONFIG);
 		cfg |= PEX_PF0_CFG_READY;
 		ls_lut_writel(pcie, PEX_PF0_CONFIG, cfg);
@@ -215,6 +230,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 	struct ls_pcie_ep *pcie;
 	struct pci_epc_features *ls_epc;
 	struct resource *dbi_base;
+	u8 offset;
 	int ret;
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
@@ -251,6 +267,9 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	pcie->lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
+
 	ret = dw_pcie_ep_init(&pci->ep);
 	if (ret)
 		return ret;
-- 
2.40.1



