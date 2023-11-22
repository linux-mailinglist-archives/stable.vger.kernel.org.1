Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62837F5110
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 21:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjKVUFT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 15:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjKVUFS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 15:05:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDF0A3
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 12:05:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E23C433C8;
        Wed, 22 Nov 2023 20:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700683513;
        bh=xZrtd203HWaEDu6baupSwlQx2mZM4vflx9lKRDZq3HY=;
        h=Subject:To:Cc:From:Date:From;
        b=qivv/BqR1eh0tVwZmyzi5lZbHoy+HedMJuAOL8Wr4kLd9Xc2ipZu/22hS1XUraKNL
         InM+cJygmOjwGppLUXhwuY/g3hxb314ZSeoPKSXNJ/IDARKIpNTzZvtGNSuaSkQpQR
         k2VHyNc8T6N8MkHdwiEbGFTdpbymPr7UsWE+nF9A=
Subject: FAILED: patch "[PATCH] PCI: qcom-ep: Add dedicated callback for writing to DBI2" failed to apply to 6.5-stable tree
To:     mani@kernel.org, fancer.lancer@gmail.com, kwilczynski@kernel.org,
        manivannan.sadhasivam@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 20:05:11 +0000
Message-ID: <2023112211-rush-provolone-6433@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x a07d2497ed657eb2efeb967af47e22f573dcd1d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112211-rush-provolone-6433@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

a07d2497ed65 ("PCI: qcom-ep: Add dedicated callback for writing to DBI2 registers")
01794236666a ("PCI: qcom-ep: Add ICC bandwidth voting support")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a07d2497ed657eb2efeb967af47e22f573dcd1d6 Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Wed, 25 Oct 2023 18:30:29 +0530
Subject: [PATCH] PCI: qcom-ep: Add dedicated callback for writing to DBI2
 registers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The DWC core driver exposes the write_dbi2() callback for writing to the
DBI2 registers in a vendor-specific way.

On the Qcom EP platforms, the DBI_CS2 bit in the ELBI region needs to be
asserted before writing to any DBI2 registers and deasserted once done.

So, let's implement the callback for the Qcom PCIe EP driver so that the
DBI2 writes are correctly handled in the hardware.

Without this callback, the DBI2 register writes like BAR size won't go
through and as a result, the default BAR size is set for all BARs.

[kwilczynski: commit log, renamed function to match the DWC convention]
Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Link: https://lore.kernel.org/linux-pci/20231025130029.74693-2-manivannan.sadhasivam@linaro.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Cc: stable@vger.kernel.org # 5.16+

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 8bd8107690a6..9b62ee6992f0 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -123,6 +123,7 @@
 
 /* ELBI registers */
 #define ELBI_SYS_STTS				0x08
+#define ELBI_CS2_ENABLE				0xa4
 
 /* DBI registers */
 #define DBI_CON_STATUS				0x44
@@ -263,6 +264,21 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
 	disable_irq(pcie_ep->perst_irq);
 }
 
+static void qcom_pcie_dw_write_dbi2(struct dw_pcie *pci, void __iomem *base,
+				    u32 reg, size_t size, u32 val)
+{
+	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
+	int ret;
+
+	writel(1, pcie_ep->elbi + ELBI_CS2_ENABLE);
+
+	ret = dw_pcie_write(pci->dbi_base2 + reg, size, val);
+	if (ret)
+		dev_err(pci->dev, "Failed to write DBI2 register (0x%x): %d\n", reg, ret);
+
+	writel(0, pcie_ep->elbi + ELBI_CS2_ENABLE);
+}
+
 static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
 {
 	struct dw_pcie *pci = &pcie_ep->pci;
@@ -519,6 +535,7 @@ static const struct dw_pcie_ops pci_ops = {
 	.link_up = qcom_pcie_dw_link_up,
 	.start_link = qcom_pcie_dw_start_link,
 	.stop_link = qcom_pcie_dw_stop_link,
+	.write_dbi2 = qcom_pcie_dw_write_dbi2,
 };
 
 static int qcom_pcie_ep_get_io_resources(struct platform_device *pdev,

