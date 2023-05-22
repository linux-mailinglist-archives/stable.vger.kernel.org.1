Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6A870C901
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbjEVToN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbjEVToJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:44:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C218B5
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:44:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BFFD621A1
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E86C433EF;
        Mon, 22 May 2023 19:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784647;
        bh=VRBMOAthZcWh7p7Zd4HD+qU//YN0XSOn9uaq3l6VrNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zYWIxOmZbdHrUmptOUHfQ+toQjr6aAXbq847v+R2VyXQ48ZOJdlUtPGRH7OVW3Y3M
         G33cAV5/7LTrKlOxCjC6nWyrwWsrAgxFvySHo/yjHIjq5baofX516RmLmHorSJDLtW
         iMmRvF9miLHIqfYBpk5gmk5TFzjnbo7IIgbasgCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Josue David Hernandez Gutierrez 
        <josue.d.hernandez.gutierrez@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 150/364] xhci: Avoid PCI MSI/MSIX interrupt reinitialization at resume
Date:   Mon, 22 May 2023 20:07:35 +0100
Message-Id: <20230522190416.505102998@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Josue David Hernandez Gutierrez <josue.d.hernandez.gutierrez@intel.com>

[ Upstream commit 944e7deb4238d10cd16905474574236ac8a8e847 ]

xhci MSI setup is currently done at the same time as xHC host is started
in xhci_run(). This couples the generic xhci code with PCI, and will
reconfigure MSI/MSIX interrupts every time xHC is started.

Decouple MSI/MSIX configuration from generic xhci code by moving MSI/MSIX
part to a PCI specific xhci_pci_run() function overriding xhci_run().

This allows us to remove unnecessay MSI/MSIX reconfiguration done every
time PCI xhci resumes from suspend. i.e. remove the xhci_cleanup_msix()
call from xhci_resume() and the xhci_try_enale_msi() call in xhci_run()
called a bit later by xhci_resume()

[minor changes and commit message rewrite -Mathias]

Signed-off-by: Josue David Hernandez Gutierrez <josue.d.hernandez.gutierrez@intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20230317154715.535523-10-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-pci.c | 15 +++++++++++++++
 drivers/usb/host/xhci.c     |  8 ++------
 drivers/usb/host/xhci.h     |  1 +
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 6db07ca419c31..8060782a2367d 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -78,14 +78,29 @@ static const char hcd_name[] = "xhci_hcd";
 static struct hc_driver __read_mostly xhci_pci_hc_driver;
 
 static int xhci_pci_setup(struct usb_hcd *hcd);
+static int xhci_pci_run(struct usb_hcd *hcd);
 static int xhci_pci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
 				      struct usb_tt *tt, gfp_t mem_flags);
 
 static const struct xhci_driver_overrides xhci_pci_overrides __initconst = {
 	.reset = xhci_pci_setup,
+	.start = xhci_pci_run,
 	.update_hub_device = xhci_pci_update_hub_device,
 };
 
+static int xhci_pci_run(struct usb_hcd *hcd)
+{
+	int ret;
+
+	if (usb_hcd_is_primary_hcd(hcd)) {
+		ret = xhci_try_enable_msi(hcd);
+		if (ret)
+			return ret;
+	}
+
+	return xhci_run(hcd);
+}
+
 /* called after powerup, by probe or system-pm "wakeup" */
 static int xhci_pci_reinit(struct xhci_hcd *xhci, struct pci_dev *pdev)
 {
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 6307bae9cddff..f498df6b02c80 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -436,7 +436,7 @@ static void __maybe_unused xhci_msix_sync_irqs(struct xhci_hcd *xhci)
 	}
 }
 
-static int xhci_try_enable_msi(struct usb_hcd *hcd)
+int xhci_try_enable_msi(struct usb_hcd *hcd)
 {
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 	struct pci_dev  *pdev;
@@ -490,6 +490,7 @@ static int xhci_try_enable_msi(struct usb_hcd *hcd)
 	hcd->irq = pdev->irq;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(xhci_try_enable_msi);
 
 #else
 
@@ -705,10 +706,6 @@ int xhci_run(struct usb_hcd *hcd)
 
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "xhci_run");
 
-	ret = xhci_try_enable_msi(hcd);
-	if (ret)
-		return ret;
-
 	temp_64 = xhci_read_64(xhci, &ir->ir_set->erst_dequeue);
 	temp_64 &= ~ERST_PTR_MASK;
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
@@ -1250,7 +1247,6 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
 		spin_unlock_irq(&xhci->lock);
 		if (retval)
 			return retval;
-		xhci_cleanup_msix(xhci);
 
 		xhci_dbg(xhci, "// Disabling event ring interrupts\n");
 		temp = readl(&xhci->op_regs->status);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 786002bb35db0..26fccc8d90556 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -2143,6 +2143,7 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated);
 
 irqreturn_t xhci_irq(struct usb_hcd *hcd);
 irqreturn_t xhci_msi_irq(int irq, void *hcd);
+int xhci_try_enable_msi(struct usb_hcd *hcd);
 int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev);
 int xhci_alloc_tt_info(struct xhci_hcd *xhci,
 		struct xhci_virt_device *virt_dev,
-- 
2.39.2



