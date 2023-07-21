Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0DB75BEAA
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 08:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjGUGTX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 02:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjGUGSy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 02:18:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDA23592
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 23:15:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AD7E6131A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 06:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631F4C433C8;
        Fri, 21 Jul 2023 06:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689920142;
        bh=TAadOM6EHzo/Op/efiGPWH4JyiWirLDmN3sF6A4tRNs=;
        h=Subject:To:Cc:From:Date:From;
        b=COonqh18inUoZLrvm2p/TpCeYHrGQsCif11ib5NaCkYWr1sBbtqS8qx2ErMtXLJWI
         +mS77HqHC9yQ7oFII8bqR9+uLF0xb8uCPsveC7WV/oG3231X8kmbE8saY5pIHODopk
         llKtzOxKXUnnGSasM4XKjdO/wLKvY6z2/X4zNszw=
Subject: FAILED: patch "[PATCH] PCI: rockchip: Don't advertise MSI-X in PCIe capabilities" failed to apply to 6.4-stable tree
To:     rick.wertenbroek@gmail.com, dlemoal@kernel.org,
        lpieralisi@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 08:15:30 +0200
Message-ID: <2023072130-scouts-chewer-5d93@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x a52587e0bee14cbeeadf48a24013828cb04b8df8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072130-scouts-chewer-5d93@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a52587e0bee14cbeeadf48a24013828cb04b8df8 Mon Sep 17 00:00:00 2001
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Tue, 18 Apr 2023 09:46:57 +0200
Subject: [PATCH] PCI: rockchip: Don't advertise MSI-X in PCIe capabilities

The RK3399 PCIe endpoint controller cannot generate MSI-X IRQs.
This is documented in the RK3399 technical reference manual (TRM)
section 17.5.9 "Interrupt Support".

MSI-X capability should therefore not be advertised. Remove the
MSI-X capability by editing the capability linked-list. The
previous entry is the MSI capability, therefore get the next
entry from the MSI-X capability entry and set it as next entry
for the MSI capability. This in effect removes MSI-X from the list.

Linked list before : MSI cap -> MSI-X cap -> PCIe Device cap -> ...
Linked list now : MSI cap -> PCIe Device cap -> ...

Link: https://lore.kernel.org/r/20230418074700.1083505-11-rick.wertenbroek@gmail.com
Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
Tested-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Cc: stable@vger.kernel.org

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 63fbb379638b..edfced311a9f 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -507,6 +507,7 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	size_t max_regions;
 	struct pci_epc_mem_window *windows = NULL;
 	int err, i;
+	u32 cfg_msi, cfg_msix_cp;
 
 	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
 	if (!ep)
@@ -582,6 +583,29 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 
 	ep->irq_pci_addr = ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR;
 
+	/*
+	 * MSI-X is not supported but the controller still advertises the MSI-X
+	 * capability by default, which can lead to the Root Complex side
+	 * allocating MSI-X vectors which cannot be used. Avoid this by skipping
+	 * the MSI-X capability entry in the PCIe capabilities linked-list: get
+	 * the next pointer from the MSI-X entry and set that in the MSI
+	 * capability entry (which is the previous entry). This way the MSI-X
+	 * entry is skipped (left out of the linked-list) and not advertised.
+	 */
+	cfg_msi = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
+				     ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
+
+	cfg_msi &= ~ROCKCHIP_PCIE_EP_MSI_CP1_MASK;
+
+	cfg_msix_cp = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
+					 ROCKCHIP_PCIE_EP_MSIX_CAP_REG) &
+					 ROCKCHIP_PCIE_EP_MSIX_CAP_CP_MASK;
+
+	cfg_msi |= cfg_msix_cp;
+
+	rockchip_pcie_write(rockchip, cfg_msi,
+			    PCIE_EP_CONFIG_BASE + ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
+
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_CONF_ENABLE,
 			    PCIE_CLIENT_CONFIG);
 
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 501d859420b4..fe0333778fd9 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -227,6 +227,8 @@
 #define ROCKCHIP_PCIE_EP_CMD_STATUS			0x4
 #define   ROCKCHIP_PCIE_EP_CMD_STATUS_IS		BIT(19)
 #define ROCKCHIP_PCIE_EP_MSI_CTRL_REG			0x90
+#define   ROCKCHIP_PCIE_EP_MSI_CP1_OFFSET		8
+#define   ROCKCHIP_PCIE_EP_MSI_CP1_MASK			GENMASK(15, 8)
 #define   ROCKCHIP_PCIE_EP_MSI_FLAGS_OFFSET		16
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET		17
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_MASK		GENMASK(19, 17)
@@ -234,6 +236,9 @@
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MME_MASK		GENMASK(22, 20)
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_ME				BIT(16)
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MASK_MSI_CAP	BIT(24)
+#define ROCKCHIP_PCIE_EP_MSIX_CAP_REG			0xb0
+#define   ROCKCHIP_PCIE_EP_MSIX_CAP_CP_OFFSET		8
+#define   ROCKCHIP_PCIE_EP_MSIX_CAP_CP_MASK		GENMASK(15, 8)
 #define ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR				0x1
 #define ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR		0x3
 #define ROCKCHIP_PCIE_EP_FUNC_BASE(fn) \

