Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE9E75C977
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjGUOOx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjGUOOw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:14:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236432D4E
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:14:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 872FB61B23
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AF5C433C7;
        Fri, 21 Jul 2023 14:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689948887;
        bh=eFxB49sMC7FTxiff7dqk7rCATm/tkRLjEs2HgDQRH7k=;
        h=Subject:To:Cc:From:Date:From;
        b=P2Y3r/TeLp7hbiu8kJ76rsUDkL1ghE1jV7wIzpKCEal7BCU8pURHxj3ReWHlu9NRX
         1Upk9aObNgs+NEweFxEnbk6YOBSVn4AuYbC5hhUrQIZ0N71XOJKsWvvKGOqBsqpAoR
         c7gmfxzJlyg0Z/hL39brDn71/kUw2NJfza90EPb8=
Subject: FAILED: patch "[PATCH] xhci: Fix TRB prefetch issue of ZHAOXIN hosts" failed to apply to 5.4-stable tree
To:     WeitaoWang-oc@zhaoxin.com, gregkh@linuxfoundation.org,
        mathias.nyman@linux.intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:14:44 +0200
Message-ID: <2023072143-ethically-doable-6e0d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 2a865a652299f5666f3b785cbe758c5f57453036
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072143-ethically-doable-6e0d@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

2a865a652299 ("xhci: Fix TRB prefetch issue of ZHAOXIN hosts")
f927728186f0 ("xhci: Fix resume issue of some ZHAOXIN hosts")
a611bf473d1f ("xhci-pci: Set runtime PM as default policy on all xHC 1.2 or later devices")
34cd2db408d5 ("xhci: Add quirk to reset host back to default state at shutdown")
a956f91247da ("Merge 6.0-rc4 into usb-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2a865a652299f5666f3b785cbe758c5f57453036 Mon Sep 17 00:00:00 2001
From: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Date: Fri, 2 Jun 2023 17:40:07 +0300
Subject: [PATCH] xhci: Fix TRB prefetch issue of ZHAOXIN hosts

On some ZHAOXIN hosts, xHCI will prefetch TRB for performance
improvement. However this TRB prefetch mechanism may cross page boundary,
which may access memory not allocated by xHCI driver. In order to fix
this issue, two pages was allocated for a segment and only the first
page will be used. And add a quirk XHCI_ZHAOXIN_TRB_FETCH for this issue.

Cc: stable@vger.kernel.org
Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <20230602144009.1225632-10-mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index a8e9a4bb1537..c4170421bc9c 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2345,8 +2345,12 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	 * and our use of dma addresses in the trb_address_map radix tree needs
 	 * TRB_SEGMENT_SIZE alignment, so we pick the greater alignment need.
 	 */
-	xhci->segment_pool = dma_pool_create("xHCI ring segments", dev,
-			TRB_SEGMENT_SIZE, TRB_SEGMENT_SIZE, xhci->page_size);
+	if (xhci->quirks & XHCI_ZHAOXIN_TRB_FETCH)
+		xhci->segment_pool = dma_pool_create("xHCI ring segments", dev,
+				TRB_SEGMENT_SIZE * 2, TRB_SEGMENT_SIZE * 2, xhci->page_size * 2);
+	else
+		xhci->segment_pool = dma_pool_create("xHCI ring segments", dev,
+				TRB_SEGMENT_SIZE, TRB_SEGMENT_SIZE, xhci->page_size);
 
 	/* See Table 46 and Note on Figure 55 */
 	xhci->device_pool = dma_pool_create("xHCI input/output contexts", dev,
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 2103c6c0a967..3aad946bab68 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -522,8 +522,13 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_NO_SOFT_RETRY;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ZHAOXIN) {
-		if (pdev->device == 0x9202)
+		if (pdev->device == 0x9202) {
 			xhci->quirks |= XHCI_RESET_ON_RESUME;
+			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
+		}
+
+		if (pdev->device == 0x9203)
+			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
 	}
 
 	/* xHC spec requires PCI devices to support D3hot and D3cold */
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 456e1c8ca005..5a495126c8ba 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1904,6 +1904,7 @@ struct xhci_hcd {
 #define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(42)
 #define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(43)
 #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
+#define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;

