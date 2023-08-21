Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C169C7832E4
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjHUUBn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjHUUBm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:01:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFDE128
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C9AE647C7
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF7BC433C8;
        Mon, 21 Aug 2023 20:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648099;
        bh=nYQ534AgAn8dKFj2eDDVOGvRxDwOp8dGYeN2R0plA/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=09dUHqBe3QZ7OlaNMwQVG9m+cKAz/9dgnHSK7m4GKWYWZobbg+CdFueVVUq3GASrp
         p9oB1POP/4W5BaKDJwNcyUGW3w1Etr4HP+aNEkWFBmxGXaa73hzicG/Qv12Uzq2JXi
         Cww0LchKBPh8ie6YYQXwXTkvaFxhyk2Gqt0lEDDc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 054/234] xhci: get rid of XHCI_PLAT quirk that used to prevent MSI setup
Date:   Mon, 21 Aug 2023 21:40:17 +0200
Message-ID: <20230821194131.132847452@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit 0a4776205b16d038ec6fedef2094951fcb6f441b ]

The XHCI_PLAT quirk was only needed to ensure non-PCI xHC host avoided
setting up MSI interrupts in generic xhci codepaths.

The MSI setup code is now moved to PCI specific xhci-pci.c file so
the quirk is no longer needed.

Remove setting the XHCI_PLAT quirk for HiSilocon SoC xHC, NVIDIA Tegra xHC,
MediaTek xHC, the generic xhci-plat driver, and the checks for XHCI_PLAT
in xhci-pci.c MSI setup code.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <20230602144009.1225632-5-mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-histb.c | 12 +-----------
 drivers/usb/host/xhci-mtk.c   |  6 ------
 drivers/usb/host/xhci-pci.c   |  7 -------
 drivers/usb/host/xhci-plat.c  |  7 +------
 drivers/usb/host/xhci-tegra.c |  1 -
 drivers/usb/host/xhci.h       |  2 +-
 6 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/host/xhci-histb.c b/drivers/usb/host/xhci-histb.c
index 91ce97821de51..7c20477550830 100644
--- a/drivers/usb/host/xhci-histb.c
+++ b/drivers/usb/host/xhci-histb.c
@@ -164,16 +164,6 @@ static void xhci_histb_host_disable(struct xhci_hcd_histb *histb)
 	clk_disable_unprepare(histb->bus_clk);
 }
 
-static void xhci_histb_quirks(struct device *dev, struct xhci_hcd *xhci)
-{
-	/*
-	 * As of now platform drivers don't provide MSI support so we ensure
-	 * here that the generic code does not try to make a pci_dev from our
-	 * dev struct in order to setup MSI
-	 */
-	xhci->quirks |= XHCI_PLAT;
-}
-
 /* called during probe() after chip reset completes */
 static int xhci_histb_setup(struct usb_hcd *hcd)
 {
@@ -186,7 +176,7 @@ static int xhci_histb_setup(struct usb_hcd *hcd)
 			return ret;
 	}
 
-	return xhci_gen_setup(hcd, xhci_histb_quirks);
+	return xhci_gen_setup(hcd, NULL);
 }
 
 static const struct xhci_driver_overrides xhci_histb_overrides __initconst = {
diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index b60521e1a9a63..9a40da3b0064b 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -418,12 +418,6 @@ static void xhci_mtk_quirks(struct device *dev, struct xhci_hcd *xhci)
 	struct usb_hcd *hcd = xhci_to_hcd(xhci);
 	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
 
-	/*
-	 * As of now platform drivers don't provide MSI support so we ensure
-	 * here that the generic code does not try to make a pci_dev from our
-	 * dev struct in order to setup MSI
-	 */
-	xhci->quirks |= XHCI_PLAT;
 	xhci->quirks |= XHCI_MTK_HOST;
 	/*
 	 * MTK host controller gives a spurious successful event after a
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index db9826c38b20b..9540f0e48c215 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -108,9 +108,6 @@ static void xhci_cleanup_msix(struct xhci_hcd *xhci)
 	struct usb_hcd *hcd = xhci_to_hcd(xhci);
 	struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
 
-	if (xhci->quirks & XHCI_PLAT)
-		return;
-
 	/* return if using legacy interrupt */
 	if (hcd->irq > 0)
 		return;
@@ -208,10 +205,6 @@ static int xhci_try_enable_msi(struct usb_hcd *hcd)
 	struct pci_dev  *pdev;
 	int ret;
 
-	/* The xhci platform device has set up IRQs through usb_add_hcd. */
-	if (xhci->quirks & XHCI_PLAT)
-		return 0;
-
 	pdev = to_pci_dev(xhci_to_hcd(xhci)->self.controller);
 	/*
 	 * Some Fresco Logic host controllers advertise MSI, but fail to
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index f36633fa83624..80da67a6c3bf2 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -78,12 +78,7 @@ static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
 {
 	struct xhci_plat_priv *priv = xhci_to_priv(xhci);
 
-	/*
-	 * As of now platform drivers don't provide MSI support so we ensure
-	 * here that the generic code does not try to make a pci_dev from our
-	 * dev struct in order to setup MSI
-	 */
-	xhci->quirks |= XHCI_PLAT | priv->quirks;
+	xhci->quirks |= priv->quirks;
 }
 
 /* called during probe() after chip reset completes */
diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index d28fa892c2866..07a319db58034 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -2662,7 +2662,6 @@ static void tegra_xhci_quirks(struct device *dev, struct xhci_hcd *xhci)
 {
 	struct tegra_xusb *tegra = dev_get_drvdata(dev);
 
-	xhci->quirks |= XHCI_PLAT;
 	if (tegra && tegra->soc->lpm_support)
 		xhci->quirks |= XHCI_LPM_SUPPORT;
 }
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 4474d540f6b49..0b1928851a2a9 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1874,7 +1874,7 @@ struct xhci_hcd {
 #define XHCI_SPURIOUS_REBOOT	BIT_ULL(13)
 #define XHCI_COMP_MODE_QUIRK	BIT_ULL(14)
 #define XHCI_AVOID_BEI		BIT_ULL(15)
-#define XHCI_PLAT		BIT_ULL(16)
+#define XHCI_PLAT		BIT_ULL(16) /* Deprecated */
 #define XHCI_SLOW_SUSPEND	BIT_ULL(17)
 #define XHCI_SPURIOUS_WAKEUP	BIT_ULL(18)
 /* For controllers with a broken beyond repair streams implementation */
-- 
2.40.1



