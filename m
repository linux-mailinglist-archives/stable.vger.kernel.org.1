Return-Path: <stable+bounces-24323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6298693ED
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8357A292C62
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26951420D3;
	Tue, 27 Feb 2024 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dE3kMBpO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928621420D2;
	Tue, 27 Feb 2024 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041668; cv=none; b=uBoe7bD3HqhGirKhrF1WIF18Fb/zqVJP62g5ce7NxhrEa2dtmWHrDFWgil3e9sOoundnc36PHJ1rcpkm79XBOzRHwL/t1Tc9UDCQQWjJI5Lmdc5FeIh3kuZsZN7tdTeNsmPmaAXHmW0TMZolIknxMSgUsy1twi1LSws11fUpRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041668; c=relaxed/simple;
	bh=0za/+E+I5SyRuGqhG1ChRvJmVCKiBS2AmQ7h4O2apYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2VS2np7Dw5WktW6++BDIcDjgcMnJXTI2pdim2gZKe3G4zalDFXYas10+GTAidXoZt38oQgRzWgrSxeS14B4WX0PTmEAx7e4WepRrtH4SEC0NV/k7W2XIotQMOHO0HEhHj92az08pYPsY4lEoWBAEXMQ1lWcx2Hk2bE93XacOH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dE3kMBpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223B8C433C7;
	Tue, 27 Feb 2024 13:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041668;
	bh=0za/+E+I5SyRuGqhG1ChRvJmVCKiBS2AmQ7h4O2apYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dE3kMBpORXsp8Ht+kJ37aAyavSre4ORNObVMEKSWPieFGICLjVdXW7wgaAL66ceja
	 fdcwadHLSDNQiSPK2+kcWndr2UOeWXBuf2XcU/Po9CbPA5wB5Mngxs7qUMqyvQpWK2
	 IX9YE4xFUtCpWDY1mklFqQCexG9G2tsnCNAzP8MI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lennert Buytenhek <kernel@wantstofly.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 029/299] ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers
Date: Tue, 27 Feb 2024 14:22:20 +0100
Message-ID: <20240227131626.762952699@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
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

From: Lennert Buytenhek <kernel@wantstofly.org>

[ Upstream commit 20730e9b277873deeb6637339edcba64468f3da3 ]

With one of the on-board ASM1061 AHCI controllers (1b21:0612) on an
ASUSTeK Pro WS WRX80E-SAGE SE WIFI mainboard, a controller hang was
observed that was immediately preceded by the following kernel
messages:

ahci 0000:28:00.0: Using 64-bit DMA addresses
ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00000 flags=0x0000]
ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00300 flags=0x0000]
ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00380 flags=0x0000]
ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00400 flags=0x0000]
ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00680 flags=0x0000]
ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00700 flags=0x0000]

The first message is produced by code in drivers/iommu/dma-iommu.c
which is accompanied by the following comment that seems to apply:

        /*
         * Try to use all the 32-bit PCI addresses first. The original SAC vs.
         * DAC reasoning loses relevance with PCIe, but enough hardware and
         * firmware bugs are still lurking out there that it's safest not to
         * venture into the 64-bit space until necessary.
         *
         * If your device goes wrong after seeing the notice then likely either
         * its driver is not setting DMA masks accurately, the hardware has
         * some inherent bug in handling >32-bit addresses, or not all the
         * expected address bits are wired up between the device and the IOMMU.
         */

Asking the ASM1061 on a discrete PCIe card to DMA from I/O virtual
address 0xffffffff00000000 produces the following I/O page faults:

vfio-pci 0000:07:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0021 address=0x7ff00000000 flags=0x0010]
vfio-pci 0000:07:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0021 address=0x7ff00000500 flags=0x0010]

Note that the upper 21 bits of the logged DMA address are zero.  (When
asking a different PCIe device in the same PCIe slot to DMA to the
same I/O virtual address, we do see all the upper 32 bits of the DMA
address as 1, so this is not an issue with the chipset or IOMMU
configuration on the test system.)

Also, hacking libahci to always set the upper 21 bits of all DMA
addresses to 1 produces no discernible effect on the behavior of the
ASM1061, and mkfs/mount/scrub/etc work as without this hack.

This all strongly suggests that the ASM1061 has a 43 bit DMA address
limit, and this commit therefore adds a quirk to deal with this limit.

This issue probably applies to (some of) the other supported ASMedia
parts as well, but we limit it to the PCI IDs known to refer to
ASM1061 parts, as that's the only part we know for sure to be affected
by this issue at this point.

Link: https://lore.kernel.org/linux-ide/ZaZ2PIpEId-rl6jv@wantstofly.org/
Signed-off-by: Lennert Buytenhek <kernel@wantstofly.org>
[cassel: drop date from error messages in commit log]
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/ahci.c | 29 +++++++++++++++++++++++------
 drivers/ata/ahci.h |  1 +
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2b8f0c3c3879a..20761eeea4100 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -48,6 +48,7 @@ enum {
 enum board_ids {
 	/* board IDs by feature in alphabetical order */
 	board_ahci,
+	board_ahci_43bit_dma,
 	board_ahci_ign_iferr,
 	board_ahci_low_power,
 	board_ahci_no_debounce_delay,
@@ -128,6 +129,13 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	[board_ahci_43bit_dma] = {
+		AHCI_HFLAGS	(AHCI_HFLAG_43BIT_ONLY),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	[board_ahci_ign_iferr] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR),
 		.flags		= AHCI_FLAG_COMMON,
@@ -596,11 +604,11 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(PROMISE, 0x3f20), board_ahci },	/* PDC42819 */
 	{ PCI_VDEVICE(PROMISE, 0x3781), board_ahci },   /* FastTrak TX8660 ahci-mode */
 
-	/* Asmedia */
+	/* ASMedia */
 	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci },	/* ASM1060 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci },	/* ASM1060 */
-	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci },	/* ASM1061 */
-	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
+	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci_43bit_dma },	/* ASM1061 */
+	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci_43bit_dma },	/* ASM1061/1062 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
 	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
 	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci },   /* ASM1062+JMB575 */
@@ -948,11 +956,20 @@ static int ahci_pci_device_resume(struct device *dev)
 
 #endif /* CONFIG_PM */
 
-static int ahci_configure_dma_masks(struct pci_dev *pdev, int using_dac)
+static int ahci_configure_dma_masks(struct pci_dev *pdev,
+				    struct ahci_host_priv *hpriv)
 {
-	const int dma_bits = using_dac ? 64 : 32;
+	int dma_bits;
 	int rc;
 
+	if (hpriv->cap & HOST_CAP_64) {
+		dma_bits = 64;
+		if (hpriv->flags & AHCI_HFLAG_43BIT_ONLY)
+			dma_bits = 43;
+	} else {
+		dma_bits = 32;
+	}
+
 	/*
 	 * If the device fixup already set the dma_mask to some non-standard
 	 * value, don't extend it here. This happens on STA2X11, for example.
@@ -1925,7 +1942,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ahci_gtf_filter_workaround(host);
 
 	/* initialize adapter */
-	rc = ahci_configure_dma_masks(pdev, hpriv->cap & HOST_CAP_64);
+	rc = ahci_configure_dma_masks(pdev, hpriv);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 4bae95b06ae3c..df8f8a1a3a34c 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -247,6 +247,7 @@ enum {
 	AHCI_HFLAG_SUSPEND_PHYS		= BIT(26), /* handle PHYs during
 						      suspend/resume */
 	AHCI_HFLAG_NO_SXS		= BIT(28), /* SXS not supported */
+	AHCI_HFLAG_43BIT_ONLY		= BIT(29), /* 43bit DMA addr limit */
 
 	/* ap->flags bits */
 
-- 
2.43.0




