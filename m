Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A066B7A3C2A
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240888AbjIQU1p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239690AbjIQU1O (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:27:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC381101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:27:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84D3C433C7;
        Sun, 17 Sep 2023 20:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982428;
        bh=/gMtv0zdYWDSWA4rZgL0gPJveZZP3KrsC4hO8kKHadU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QwVwte29ZuZFZKTU4CXH7GDJfaW2ndOVefA6XGyO/c3xEGfVJ0aayhRwL/MRXDiar
         BBZdR2I62MpbPnZLThARZX/4Juh/om8TPiC8k7nazaDy9eTO6iuoLZrBz7EKK1SAAs
         gF0JEPpA3b9LqJxTshfab3Q1yWQXeqMWmX0Pqz0M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 220/511] PCI: dwc: Add start_link/stop_link inlines
Date:   Sun, 17 Sep 2023 21:10:47 +0200
Message-ID: <20230917191119.124688401@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

[ Upstream commit a37beefbde8802a4eab2545fee1b1780a03f2aa0 ]

Factor out this pattern:

  if (!pci->ops || !pci->ops->start_link)
    return -EINVAL;

  return pci->ops->start_link(pci);

into a new dw_pcie_start_link() wrapper and do the same for the stop_link()
method.

Note that dw_pcie_ep_start() previously returned -EINVAL if there was no
platform start_link() method, which didn't make much sense since that is
not an error.  It will now return 0 in that case.

As a side-effect, drop the empty start_link() and dummy dw_pcie_ops
instances from the generic DW PCIe and Layerscape EP platform drivers.

[bhelgaas: commit log]
Link: https://lore.kernel.org/r/20220624143428.8334-14-Sergey.Semin@baikalelectronics.ru
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Stable-dep-of: 17cf8661ee0f ("PCI: layerscape: Add workaround for lost link capabilities during reset")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-layerscape-ep.c    | 12 ------------
 drivers/pci/controller/dwc/pcie-designware-ep.c   |  8 ++------
 drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++------
 drivers/pci/controller/dwc/pcie-designware-plat.c | 10 ----------
 drivers/pci/controller/dwc/pcie-designware.h      | 14 ++++++++++++++
 5 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 39f4664bd84c7..ad99707b3b994 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -32,15 +32,6 @@ struct ls_pcie_ep {
 	const struct ls_pcie_ep_drvdata *drvdata;
 };
 
-static int ls_pcie_establish_link(struct dw_pcie *pci)
-{
-	return 0;
-}
-
-static const struct dw_pcie_ops dw_ls_pcie_ep_ops = {
-	.start_link = ls_pcie_establish_link,
-};
-
 static const struct pci_epc_features*
 ls_pcie_ep_get_features(struct dw_pcie_ep *ep)
 {
@@ -106,19 +97,16 @@ static const struct dw_pcie_ep_ops ls_pcie_ep_ops = {
 
 static const struct ls_pcie_ep_drvdata ls1_ep_drvdata = {
 	.ops = &ls_pcie_ep_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ep_ops,
 };
 
 static const struct ls_pcie_ep_drvdata ls2_ep_drvdata = {
 	.func_offset = 0x20000,
 	.ops = &ls_pcie_ep_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ep_ops,
 };
 
 static const struct ls_pcie_ep_drvdata lx2_ep_drvdata = {
 	.func_offset = 0x8000,
 	.ops = &ls_pcie_ep_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ep_ops,
 };
 
 static const struct of_device_id ls_pcie_ep_of_match[] = {
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 2af4ed90e12b3..5023b7f704d2f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -434,8 +434,7 @@ static void dw_pcie_ep_stop(struct pci_epc *epc)
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	if (pci->ops && pci->ops->stop_link)
-		pci->ops->stop_link(pci);
+	dw_pcie_stop_link(pci);
 }
 
 static int dw_pcie_ep_start(struct pci_epc *epc)
@@ -443,10 +442,7 @@ static int dw_pcie_ep_start(struct pci_epc *epc)
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	if (!pci->ops || !pci->ops->start_link)
-		return -EINVAL;
-
-	return pci->ops->start_link(pci);
+	return dw_pcie_start_link(pci);
 }
 
 static const struct pci_epc_features*
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 7cd4593ad12fa..f561e87cd5f6e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -402,8 +402,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 
-	if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
-		ret = pci->ops->start_link(pci);
+	if (!dw_pcie_link_up(pci)) {
+		ret = dw_pcie_start_link(pci);
 		if (ret)
 			goto err_free_msi;
 	}
@@ -420,8 +420,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	return 0;
 
 err_stop_link:
-	if (pci->ops && pci->ops->stop_link)
-		pci->ops->stop_link(pci);
+	dw_pcie_stop_link(pci);
 
 err_free_msi:
 	if (pp->has_msi_ctrl)
@@ -437,8 +436,7 @@ void dw_pcie_host_deinit(struct pcie_port *pp)
 	pci_stop_root_bus(pp->bridge->bus);
 	pci_remove_root_bus(pp->bridge->bus);
 
-	if (pci->ops && pci->ops->stop_link)
-		pci->ops->stop_link(pci);
+	dw_pcie_stop_link(pci);
 
 	if (pp->has_msi_ctrl)
 		dw_pcie_free_msi(pp);
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 8851eb161a0eb..107318ad22817 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -36,15 +36,6 @@ static const struct of_device_id dw_plat_pcie_of_match[];
 static const struct dw_pcie_host_ops dw_plat_pcie_host_ops = {
 };
 
-static int dw_plat_pcie_establish_link(struct dw_pcie *pci)
-{
-	return 0;
-}
-
-static const struct dw_pcie_ops dw_pcie_ops = {
-	.start_link = dw_plat_pcie_establish_link,
-};
-
 static void dw_plat_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -142,7 +133,6 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pci->dev = dev;
-	pci->ops = &dw_pcie_ops;
 
 	dw_plat_pcie->pci = pci;
 	dw_plat_pcie->mode = mode;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 7d6e9b7576be5..8ba2392926346 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -365,6 +365,20 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
 	dw_pcie_writel_dbi(pci, reg, val);
 }
 
+static inline int dw_pcie_start_link(struct dw_pcie *pci)
+{
+	if (pci->ops && pci->ops->start_link)
+		return pci->ops->start_link(pci);
+
+	return 0;
+}
+
+static inline void dw_pcie_stop_link(struct dw_pcie *pci)
+{
+	if (pci->ops && pci->ops->stop_link)
+		pci->ops->stop_link(pci);
+}
+
 #ifdef CONFIG_PCIE_DW_HOST
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
-- 
2.40.1



