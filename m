Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199287F512A
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 21:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344560AbjKVUGa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 15:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344565AbjKVUGY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 15:06:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E312D69
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 12:06:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE78AC433C7;
        Wed, 22 Nov 2023 20:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700683579;
        bh=3RcTpLn4kEPFKFseVu8kg+K8HQVdDAdf825bcBhfOUU=;
        h=Subject:To:Cc:From:Date:From;
        b=XeI6JX2bzjKTY1pCFCBXnSELVpFDUtjUdiBPf8CvW/VCSjvFv+Q4iQswRq7KKvvEW
         A7XN9JDnixUbcB+9thIUP7+odLHqQ4cbLRORLkmfansGCEZdjns6TQn3wO/g+xahS8
         /pdymy7gIBKclvHC0Asd0Ua/JOcBTwhGxWYQ29DM=
Subject: FAILED: patch "[PATCH] PCI: exynos: Don't discard .remove() callback" failed to apply to 4.14-stable tree
To:     u.kleine-koenig@pengutronix.de, alim.akhtar@samsung.com,
        bhelgaas@google.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 20:06:11 +0000
Message-ID: <2023112211-carded-sake-3ee5@gregkh>
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 83a939f0fdc208ff3639dd3d42ac9b3c35607fd2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112211-carded-sake-3ee5@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

83a939f0fdc2 ("PCI: exynos: Don't discard .remove() callback")
778f7c194b1d ("PCI: dwc: exynos: Rework the driver to support Exynos5433 variant")
b9ac0f9dc8ea ("PCI: dwc: Move dw_pcie_setup_rc() to DWC common code")
59fbab1ae40e ("PCI: dwc: Move dw_pcie_msi_init() into core")
886a9c134755 ("PCI: dwc: Move link handling into common code")
331e9bcead52 ("PCI: dwc: Drop the .set_num_vectors() host op")
a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common code")
1b6a0e43a1a1 ("PCI: layerscape: Add EP mode support for ls1088a and ls2088a")
cc255eb0bfbe ("PCI: layerscape: Modify the way of getting capability with different PEX")
20e458fb92af ("PCI: layerscape: Fix some format issue of the code")
47a062609a30 ("PCI: designware-ep: Modify MSI and MSIX CAP way of finding")
6bfc9c3a2c70 ("PCI: designware-ep: Move the function of getting MSI capability forward")
24ede430fa49 ("PCI: designware-ep: Add multiple PFs support for DWC")
fdd056ff7af4 ("PCI: dwc: Use DBI accessors")
aeaa0bfe8965 ("PCI: dwc: Move N_FTS setup to common setup")
d439e7edd134 ("PCI: dwc/intel-gw: Drop unused max_width")
441e48fdf0b4 ("PCI: dwc: Set PORT_LINK_DLL_LINK_EN in common setup code")
39bc5006501c ("PCI: dwc: Centralize link gen setting")
84667a416d42 ("PCI: dwc/tegra: Use common Designware port logic register definitions")
fb7652327101 ("PCI: dwc: Remove hardcoded PCI_CAP_ID_EXP offset")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 83a939f0fdc208ff3639dd3d42ac9b3c35607fd2 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Sun, 1 Oct 2023 19:02:51 +0200
Subject: [PATCH] PCI: exynos: Don't discard .remove() callback
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With CONFIG_PCI_EXYNOS=y and exynos_pcie_remove() marked with __exit, the
function is discarded from the driver. In this case a bound device can
still get unbound, e.g via sysfs. Then no cleanup code is run resulting in
resource leaks or worse.

The right thing to do is do always have the remove callback available.
This fixes the following warning by modpost:

  WARNING: modpost: drivers/pci/controller/dwc/pci-exynos: section mismatch in reference: exynos_pcie_driver+0x8 (section: .data) -> exynos_pcie_remove (section: .exit.text)

(with ARCH=x86_64 W=1 allmodconfig).

Fixes: 340cba6092c2 ("pci: Add PCIe driver for Samsung Exynos")
Link: https://lore.kernel.org/r/20231001170254.2506508-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 6319082301d6..c6bede346932 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -375,7 +375,7 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit exynos_pcie_remove(struct platform_device *pdev)
+static int exynos_pcie_remove(struct platform_device *pdev)
 {
 	struct exynos_pcie *ep = platform_get_drvdata(pdev);
 
@@ -431,7 +431,7 @@ static const struct of_device_id exynos_pcie_of_match[] = {
 
 static struct platform_driver exynos_pcie_driver = {
 	.probe		= exynos_pcie_probe,
-	.remove		= __exit_p(exynos_pcie_remove),
+	.remove		= exynos_pcie_remove,
 	.driver = {
 		.name	= "exynos-pcie",
 		.of_match_table = exynos_pcie_of_match,

