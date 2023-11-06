Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFB97E25B8
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjKFNea (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjKFNe2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:34:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9E210B
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:34:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F47C433C7;
        Mon,  6 Nov 2023 13:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277665;
        bh=d0GlEE3htWJA93CiEwqUzvnZjmwzcZz6gHckoXaDyM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w+LvqLOgsa8uIoaLPCH15K8OwR46Et4Huzv8UgcxLOy7rF2qTureRJ40Sh7SlPpB6
         SPHS39pBavh0eIDY/qN/yN+w6uFraVRmbHoLxMxf8CGqubl9mD1aIQLUU5RrGfUM1k
         nwic/O1EFbz0rLgZWysWNdHMh8IsxSZfnCV1UnaU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vicki Pfau <vi@endrift.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5.10 88/95] PCI: Prevent xHCI driver from claiming AMD VanGogh USB3 DRD device
Date:   Mon,  6 Nov 2023 14:04:56 +0100
Message-ID: <20231106130307.908253334@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130304.678610325@linuxfoundation.org>
References: <20231106130304.678610325@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -597,7 +597,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AT
 /*
  * In the AMD NL platform, this device ([1022:7912]) has a class code of
  * PCI_CLASS_SERIAL_USB_XHCI (0x0c0330), which means the xhci driver will
- * claim it.
+ * claim it. The same applies on the VanGogh platform device ([1022:163a]).
  *
  * But the dwc3 driver is a more specific driver for this device, and we'd
  * prefer to use it instead of xhci. To prevent xhci from claiming the
@@ -605,7 +605,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AT
  * defines as "USB device (not host controller)". The dwc3 driver can then
  * claim it based on its Vendor and Device ID.
  */
-static void quirk_amd_nl_class(struct pci_dev *pdev)
+static void quirk_amd_dwc_class(struct pci_dev *pdev)
 {
 	u32 class = pdev->class;
 
@@ -615,7 +615,9 @@ static void quirk_amd_nl_class(struct pc
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
@@ -555,6 +555,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
 #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
+#define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a
 #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000


