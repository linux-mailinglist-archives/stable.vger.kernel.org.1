Return-Path: <stable+bounces-3246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68307FF2DC
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 15:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1257A1C21007
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6251E48CD8;
	Thu, 30 Nov 2023 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hxrjKzZI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6B84778E
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 14:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27746C433CB;
	Thu, 30 Nov 2023 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701355779;
	bh=I5auG9HX6bjkHLteCKiEJ/xxTQTIfQjncY29AodRMpg=;
	h=Subject:To:Cc:From:Date:From;
	b=hxrjKzZIrNlMJ3xWYLjwTKUPTC+i3HK4srnaCpC3KQL/PJ4T5SK2HBM/ONPxo0fzH
	 /P6ckjmQw05UbckXx2BrJx0BF6NGztVRvfINDHzheEeXKM8caefyUurLLTxwIn1fuS
	 rVIWYavhY9iQohV2/zYTo5qNqXxpMSoQTuCDui+s=
Subject: FAILED: patch "[PATCH] USB: xhci-plat: fix legacy PHY double init" failed to apply to 5.10-stable tree
To: johan+linaro@kernel.org,gregkh@linuxfoundation.org,mripard@kernel.org,stanley_chang@realtek.com,stefan.eichenberger@toradex.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 30 Nov 2023 14:49:34 +0000
Message-ID: <2023113034-dill-come-1127@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 16b7e0cccb243033de4406ffb4d892365041a1e7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023113034-dill-come-1127@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

16b7e0cccb24 ("USB: xhci-plat: fix legacy PHY double init")
424e02931e2b ("usb: xhci: plat: remove error log for failure to get usb-phy")
9134c1fd0503 ("usb: xhci: plat: Add USB 3.0 phy support")
e0fe986972f5 ("usb: host: xhci-plat: prepare operation w/o shared hcd")
0cf1ea040a7e ("usb: host: xhci-plat: create shared hcd after having added main hcd")
8e10548f7f48 ("Revert "usb: host: xhci: mvebu: make USB 3.0 PHY optional for Armada 3720"")
3241929b67d2 ("usb: host: xhci: mvebu: make USB 3.0 PHY optional for Armada 3720")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 16b7e0cccb243033de4406ffb4d892365041a1e7 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Fri, 3 Nov 2023 17:43:23 +0100
Subject: [PATCH] USB: xhci-plat: fix legacy PHY double init

Commits 7b8ef22ea547 ("usb: xhci: plat: Add USB phy support") and
9134c1fd0503 ("usb: xhci: plat: Add USB 3.0 phy support") added support
for looking up legacy PHYs from the sysdev devicetree node and
initialising them.

This broke drivers such as dwc3 which manages PHYs themself as the PHYs
would now be initialised twice, something which specifically can lead to
resources being left enabled during suspend (e.g. with the
usb_phy_generic PHY driver).

As the dwc3 driver uses driver-name matching for the xhci platform
device, fix this by only looking up and initialising PHYs for devices
that have been matched using OF.

Note that checking that the platform device has a devicetree node would
currently be sufficient, but that could lead to subtle breakages in case
anyone ever tries to reuse an ancestor's node.

Fixes: 7b8ef22ea547 ("usb: xhci: plat: Add USB phy support")
Fixes: 9134c1fd0503 ("usb: xhci: plat: Add USB 3.0 phy support")
Cc: stable@vger.kernel.org      # 4.1
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Stanley Chang <stanley_chang@realtek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Tested-by: Stanley Chang <stanley_chang@realtek.com>
Link: https://lore.kernel.org/r/20231103164323.14294-1-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index b93161374293..732cdeb73920 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/usb/phy.h>
 #include <linux/slab.h>
@@ -148,7 +149,7 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 	int			ret;
 	int			irq;
 	struct xhci_plat_priv	*priv = NULL;
-
+	bool			of_match;
 
 	if (usb_disabled())
 		return -ENODEV;
@@ -253,16 +254,23 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 					 &xhci->imod_interval);
 	}
 
-	hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
-	if (IS_ERR(hcd->usb_phy)) {
-		ret = PTR_ERR(hcd->usb_phy);
-		if (ret == -EPROBE_DEFER)
-			goto disable_clk;
-		hcd->usb_phy = NULL;
-	} else {
-		ret = usb_phy_init(hcd->usb_phy);
-		if (ret)
-			goto disable_clk;
+	/*
+	 * Drivers such as dwc3 manages PHYs themself (and rely on driver name
+	 * matching for the xhci platform device).
+	 */
+	of_match = of_match_device(pdev->dev.driver->of_match_table, &pdev->dev);
+	if (of_match) {
+		hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
+		if (IS_ERR(hcd->usb_phy)) {
+			ret = PTR_ERR(hcd->usb_phy);
+			if (ret == -EPROBE_DEFER)
+				goto disable_clk;
+			hcd->usb_phy = NULL;
+		} else {
+			ret = usb_phy_init(hcd->usb_phy);
+			if (ret)
+				goto disable_clk;
+		}
 	}
 
 	hcd->tpl_support = of_usb_host_tpl_support(sysdev->of_node);
@@ -285,15 +293,17 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 			goto dealloc_usb2_hcd;
 		}
 
-		xhci->shared_hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev,
-			    "usb-phy", 1);
-		if (IS_ERR(xhci->shared_hcd->usb_phy)) {
-			xhci->shared_hcd->usb_phy = NULL;
-		} else {
-			ret = usb_phy_init(xhci->shared_hcd->usb_phy);
-			if (ret)
-				dev_err(sysdev, "%s init usb3phy fail (ret=%d)\n",
-					    __func__, ret);
+		if (of_match) {
+			xhci->shared_hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev,
+										"usb-phy", 1);
+			if (IS_ERR(xhci->shared_hcd->usb_phy)) {
+				xhci->shared_hcd->usb_phy = NULL;
+			} else {
+				ret = usb_phy_init(xhci->shared_hcd->usb_phy);
+				if (ret)
+					dev_err(sysdev, "%s init usb3phy fail (ret=%d)\n",
+						__func__, ret);
+			}
 		}
 
 		xhci->shared_hcd->tpl_support = hcd->tpl_support;


