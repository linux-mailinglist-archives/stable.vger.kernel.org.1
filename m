Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE5779B0B6
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377550AbjIKW07 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238247AbjIKNwT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:52:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9336BCD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:52:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4286C433C8;
        Mon, 11 Sep 2023 13:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440334;
        bh=xBMzTCh0Pce5e2uy3yJTZT0guc0BsHcPJoIawDxmR3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xDDgrzFPeZkAtB9LI12j0KEjwfl/h6y8SSCmsb2VaAW0n8BDjOqVz/nL3qrr9B/6H
         YQAupv7cosuShkqgMyAwRDxmRqCpFFkSVBLHeYL/AKVUmsbNcxEXDyRMb+NbLYtpLk
         WzKmN5ZtBUhhOTH4CqJZcvQoOBU1iXLOqZHs97+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vidya Sagar <vidyas@nvidia.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 6.5 009/739] Revert "PCI: tegra194: Enable support for 256 Byte payload"
Date:   Mon, 11 Sep 2023 15:36:48 +0200
Message-ID: <20230911134651.253205337@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vidya Sagar <vidyas@nvidia.com>

commit ebfde1584d9f037b6309fc682c96e22dac7bcb7a upstream.

After commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte
payload"), we initialize MPS=256 for tegra194 Root Ports before enumerating
the hierarchy.

Consider an Endpoint that supports only MPS=128.  In the default situation
(CONFIG_PCIE_BUS_DEFAULT set and no "pci=pcie_bus_*" parameter), Linux
tries to configure the MPS of every device to match the upstream bridge.
If the Endpoint is directly below the Root Port, Linux can reduce the Root
Port MPS to 128 to match the Endpoint.  But if there's a switch in the
middle, Linux doesn't reduce the Root Port MPS because other devices below
the switch may already be configured with MPS larger than 128.

This scenario results in uncorrectable Malformed TLP errors if the Root
Port sends TLPs with payloads larger than 128 bytes.  These errors can
be avoided by using the "pci=pcie_bus_safe" parameter, but it doesn't
seem to be a good idea to always have this parameter even for basic
functionality to work.

Revert commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte
payload") so the Root Ports default to MPS=128, which all devices
support.

If peer-to-peer DMA is not required, one can use "pci=pcie_bus_perf" to
get the benefit of larger MPS settings.

[bhelgaas: commit log; kwilczynski: retain "u16 val_16" declaration at
the top, add missing acked by tag]
Fixes: 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte payload")
Link: https://lore.kernel.org/linux-pci/20230619102604.3735001-1-vidyas@nvidia.com
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org # v6.0-rc1+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c |   10 ----------
 1 file changed, 10 deletions(-)

--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -900,11 +900,6 @@ static int tegra_pcie_dw_host_init(struc
 		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 							      PCI_CAP_ID_EXP);
 
-	val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
-	val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
-	val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
-	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
-
 	val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
 	val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
 	dw_pcie_writel_dbi(pci, PCI_IO_BASE, val);
@@ -1887,11 +1882,6 @@ static void pex_ep_event_pex_rst_deasser
 	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 						      PCI_CAP_ID_EXP);
 
-	val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
-	val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
-	val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
-	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
-
 	/* Clear Slot Clock Configuration bit if SRNS configuration */
 	if (pcie->enable_srns) {
 		val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +


