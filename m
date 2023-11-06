Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35727E2528
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjKFN2p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjKFN2o (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:28:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434AC10A
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:28:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C5AC433C7;
        Mon,  6 Nov 2023 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277321;
        bh=URpMQznk22nhQM+KQh+c+BRLFzwplQjM9PZqB+qvriI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E01yzlGowK8Ks1uQdBvQNKjal6LOKsUImE3NjBu5BayDQACtmtoc5O4bz4UCLgVrb
         4GryI57NEdzFLv/Toa0ZWZapHDBaVsJJFxjS/qJUPibBQnLy4rJRxvXoiEtowyy41E
         GxO3ov/Xa/GbuvwbKsXMCFCCSUNePSatHFkes1/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vicki Pfau <vi@endrift.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5.15 113/128] PCI: Prevent xHCI driver from claiming AMD VanGogh USB3 DRD device
Date:   Mon,  6 Nov 2023 14:04:33 +0100
Message-ID: <20231106130314.307271341@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vicki Pfau <vi@endrift.com>

commit 7e6f3b6d2c352b5fde37ce3fed83bdf6172eebd4 upstream.

The AMD VanGogh SoC contains a DesignWare USB3 Dual-Role Device that can be
operated as either a USB Host or a USB Device, similar to on the AMD Nolan
platform.

be6646bfbaec ("PCI: Prevent xHCI driver from claiming AMD Nolan USB3 DRD
device") added a quirk to let the dwc3 driver claim the Nolan device since
it provides more specific support.

Extend that quirk to include the VanGogh SoC USB3 device.

Link: https://lore.kernel.org/r/20230927202212.2388216-1-vi@endrift.com
Signed-off-by: Vicki Pfau <vi@endrift.com>
[bhelgaas: include be6646bfbaec reference, add stable tag]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org	# v3.19+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/quirks.c    |    8 +++++---
 include/linux/pci_ids.h |    1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -592,7 +592,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AT
 /*
  * In the AMD NL platform, this device ([1022:7912]) has a class code of
  * PCI_CLASS_SERIAL_USB_XHCI (0x0c0330), which means the xhci driver will
- * claim it.
+ * claim it. The same applies on the VanGogh platform device ([1022:163a]).
  *
  * But the dwc3 driver is a more specific driver for this device, and we'd
  * prefer to use it instead of xhci. To prevent xhci from claiming the
@@ -600,7 +600,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AT
  * defines as "USB device (not host controller)". The dwc3 driver can then
  * claim it based on its Vendor and Device ID.
  */
-static void quirk_amd_nl_class(struct pci_dev *pdev)
+static void quirk_amd_dwc_class(struct pci_dev *pdev)
 {
 	u32 class = pdev->class;
 
@@ -610,7 +610,9 @@ static void quirk_amd_nl_class(struct pc
 		 class, pdev->class);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
-		quirk_amd_nl_class);
+		quirk_amd_dwc_class);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VANGOGH_USB,
+		quirk_amd_dwc_class);
 
 /*
  * Synopsys USB 3.x host HAPS platform has a class code of
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -556,6 +556,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
 #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
+#define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a
 #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d


