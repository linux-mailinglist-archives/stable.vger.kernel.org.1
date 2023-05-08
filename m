Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429B86FA571
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjEHKJb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbjEHKJa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:09:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF4E3292B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:09:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22CF2623A3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A43C433D2;
        Mon,  8 May 2023 10:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540568;
        bh=YKs2xlajF6rMfHTq4lvzYc6WKpfFDkhKdQbPBTqa+4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H+pYKTi36/Khj/Ai8PXc0wOOp5Qk0goq/ArA6R+jK0zV/KzDtBXUEm/g1Bd86HAwC
         zziPj8nw4dEe47jrkg8aUM8PNHbag2fucx9Erku/4PKgJbXkgiah/L73k9lYnuRfcv
         OAbB/6V06s4sR79ogX+QpqSVeQ7aHyTtjS+DRA5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 413/611] PCI: imx6: Install the fault handler only on compatible match
Date:   Mon,  8 May 2023 11:44:15 +0200
Message-Id: <20230508094435.658993277@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: H. Nikolaus Schaller <hns@goldelico.com>

[ Upstream commit 5f5ac460dfe7f4e11f99de9870f240e39189cf72 ]

commit bb38919ec56e ("PCI: imx6: Add support for i.MX6 PCIe controller")
added a fault hook to this driver in the probe function. So it was only
installed if needed.

commit bde4a5a00e76 ("PCI: imx6: Allow probe deferral by reset GPIO")
moved it from probe to driver init which installs the hook unconditionally
as soon as the driver is compiled into a kernel.

When this driver is compiled as a module, the hook is not registered
until after the driver has been matched with a .compatible and
loaded.

commit 415b6185c541 ("PCI: imx6: Fix config read timeout handling")
extended the fault handling code.

commit 2d8ed461dbc9 ("PCI: imx6: Add support for i.MX8MQ")
added some protection for non-ARM architectures, but this does not
protect non-i.MX ARM architectures.

Since fault handlers can be triggered on any architecture for different
reasons, there is no guarantee that they will be triggered only for the
assumed situation, leading to improper error handling (i.MX6-specific
imx6q_pcie_abort_handler) on foreign systems.

I had seen strange L3 imprecise external abort messages several times on
OMAP4 and OMAP5 devices and couldn't make sense of them until I realized
they were related to this unused imx6q driver because I had
CONFIG_PCI_IMX6=y.

Note that CONFIG_PCI_IMX6=y is useful for kernel binaries that are designed
to run on different ARM SoC and be differentiated only by device tree
binaries. So turning off CONFIG_PCI_IMX6 is not a solution.

Therefore we check the compatible in the init function before registering
the fault handler.

Link: https://lore.kernel.org/r/e1bcfc3078c82b53aa9b78077a89955abe4ea009.1678380991.git.hns@goldelico.com
Fixes: bde4a5a00e76 ("PCI: imx6: Allow probe deferral by reset GPIO")
Fixes: 415b6185c541 ("PCI: imx6: Fix config read timeout handling")
Fixes: 2d8ed461dbc9 ("PCI: imx6: Add support for i.MX8MQ")
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1dde5c579edc8..47db2d20568ef 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1402,6 +1402,13 @@ DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd,
 static int __init imx6_pcie_init(void)
 {
 #ifdef CONFIG_ARM
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, imx6_pcie_of_match);
+	if (!np)
+		return -ENODEV;
+	of_node_put(np);
+
 	/*
 	 * Since probe() can be deferred we need to make sure that
 	 * hook_fault_code is not called after __init memory is freed
-- 
2.39.2



