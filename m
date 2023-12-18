Return-Path: <stable+bounces-7322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BA0817207
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAC21F26342
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4B64FF6D;
	Mon, 18 Dec 2023 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1IxoO4QB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55359498BA;
	Mon, 18 Dec 2023 14:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F85C433C8;
	Mon, 18 Dec 2023 14:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908157;
	bh=yg1wNAkOHX+KCv+PBXiRvibKO7B7nhOJiOSno6bsVaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1IxoO4QBLPNc1yX3hfEULmThoQy2JcI9NCwoGqesTXESYPrWiGSCgByA31Gxjxffz
	 26FCsY8Oz4WwRx+MdLnHIpL9a1Va1zzdY5wlOpTwDKdamxIWpmBzRHJWNtivJ3KbBo
	 8gjLUO7YuIGybiiJLATaPjTxYZOH3/z4juyWHa/g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.6 074/166] PCI: loongson: Limit MRRS to 256
Date: Mon, 18 Dec 2023 14:50:40 +0100
Message-ID: <20231218135108.370530046@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
References: <20231218135104.927894164@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

commit ef61a0405742a9f7f6051bc6fd2f017d87d07911 upstream.

This is a partial revert of 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS
increases") for MIPS-based Loongson.

Some MIPS Loongson systems don't support arbitrary Max_Read_Request_Size
(MRRS) settings.  8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS
increases") worked around that by (1) assuming that firmware configured
MRRS to the maximum supported value and (2) preventing the PCI core from
increasing MRRS.

Unfortunately, some firmware doesn't set that maximum MRRS correctly, which
results in devices not being initialized correctly.  One symptom, from the
Debian report below, is this:

  ata4.00: exception Emask 0x0 SAct 0x20000000 SErr 0x0 action 0x6 frozen
  ata4.00: failed command: WRITE FPDMA QUEUED
  ata4.00: cmd 61/20:e8:00:f0:e1/00:00:00:00:00/40 tag 29 ncq dma 16384 out
           res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
  ata4.00: status: { DRDY }
  ata4: hard resetting link

Limit MRRS to 256 because MIPS Loongson with higher MRRS support is
considered rare.

This must be done at device enablement stage because the MRRS setting may
get lost if PCI_COMMAND_MASTER on the parent bridge is cleared, and we are
only sure parent bridge is enabled at this point.

Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217680
Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1035587
Link: https://lore.kernel.org/r/20231201115028.84351-1-jiaxun.yang@flygoat.com
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/pci-loongson.c |   46 ++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 5 deletions(-)

--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -80,13 +80,49 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LO
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_LS7A_LPC, system_bus_quirk);
 
+/*
+ * Some Loongson PCIe ports have hardware limitations on their Maximum Read
+ * Request Size. They can't handle anything larger than this.  Sane
+ * firmware will set proper MRRS at boot, so we only need no_inc_mrrs for
+ * bridges. However, some MIPS Loongson firmware doesn't set MRRS properly,
+ * so we have to enforce maximum safe MRRS, which is 256 bytes.
+ */
+#ifdef CONFIG_MIPS
+static void loongson_set_min_mrrs_quirk(struct pci_dev *pdev)
+{
+	struct pci_bus *bus = pdev->bus;
+	struct pci_dev *bridge;
+	static const struct pci_device_id bridge_devids[] = {
+		{ PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },
+		{ 0, },
+	};
+
+	/* look for the matching bridge */
+	while (!pci_is_root_bus(bus)) {
+		bridge = bus->self;
+		bus = bus->parent;
+
+		if (pci_match_id(bridge_devids, bridge)) {
+			if (pcie_get_readrq(pdev) > 256) {
+				pci_info(pdev, "limiting MRRS to 256\n");
+				pcie_set_readrq(pdev, 256);
+			}
+			break;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_set_min_mrrs_quirk);
+#endif
+
 static void loongson_mrrs_quirk(struct pci_dev *pdev)
 {
-	/*
-	 * Some Loongson PCIe ports have h/w limitations of maximum read
-	 * request size. They can't handle anything larger than this. So
-	 * force this limit on any devices attached under these ports.
-	 */
 	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
 
 	bridge->no_inc_mrrs = 1;



