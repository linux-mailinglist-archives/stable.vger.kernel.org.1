Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C227555D3
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjGPUpA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjGPUo7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:44:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39AFE45
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:44:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D28F60E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B82C433C7;
        Sun, 16 Jul 2023 20:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540296;
        bh=g2hguSafZg+GmzcksWcO1pOba7zrKI0L7w3SPFdmEYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0+6Qp7PMEaqaZtsKd0gysw0kfb6MipVfHTgWu4WrKytAf5jsYojnLy24KsT0AGdH0
         ++ERmETSoiWIxZlR+5MHyjgbEa2nqdgs4XsxQcow7sLjP+5rn8k6ZByFNb31yabwck
         MIp+zCrbtRl20HgMTmU6wySBEi2H4XNk4D6Lbzc8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Siddharth Vadapalli <s-vadapalli@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 285/591] PCI: cadence: Fix Gen2 Link Retraining process
Date:   Sun, 16 Jul 2023 21:47:04 +0200
Message-ID: <20230716194931.267534625@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Siddharth Vadapalli <s-vadapalli@ti.com>

[ Upstream commit 0e12f830236928b6fadf40d917a7527f0a048d2f ]

The Link Retraining process is initiated to account for the Gen2 defect in
the Cadence PCIe controller in J721E SoC. The errata corresponding to this
is i2085, documented at:
https://www.ti.com/lit/er/sprz455c/sprz455c.pdf

The existing workaround implemented for the errata waits for the Data Link
initialization to complete and assumes that the link retraining process
at the Physical Layer has completed. However, it is possible that the
Physical Layer training might be ongoing as indicated by the
PCI_EXP_LNKSTA_LT bit in the PCI_EXP_LNKSTA register.

Fix the existing workaround, to ensure that the Physical Layer training
has also completed, in addition to the Data Link initialization.

Link: https://lore.kernel.org/r/20230315070800.1615527-1-s-vadapalli@ti.com
Fixes: 4740b969aaf5 ("PCI: cadence: Retrain Link to work around Gen2 training defect")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../controller/cadence/pcie-cadence-host.c    | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 940c7dd701d68..5b14f7ee3c798 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -12,6 +12,8 @@
 
 #include "pcie-cadence.h"
 
+#define LINK_RETRAIN_TIMEOUT HZ
+
 static u64 bar_max_size[] = {
 	[RP_BAR0] = _ULL(128 * SZ_2G),
 	[RP_BAR1] = SZ_2G,
@@ -77,6 +79,27 @@ static struct pci_ops cdns_pcie_host_ops = {
 	.write		= pci_generic_config_write,
 };
 
+static int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
+{
+	u32 pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
+	unsigned long end_jiffies;
+	u16 lnk_stat;
+
+	/* Wait for link training to complete. Exit after timeout. */
+	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
+	do {
+		lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
+		if (!(lnk_stat & PCI_EXP_LNKSTA_LT))
+			break;
+		usleep_range(0, 1000);
+	} while (time_before(jiffies, end_jiffies));
+
+	if (!(lnk_stat & PCI_EXP_LNKSTA_LT))
+		return 0;
+
+	return -ETIMEDOUT;
+}
+
 static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -118,6 +141,10 @@ static int cdns_pcie_retrain(struct cdns_pcie *pcie)
 		cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
 				    lnk_ctl);
 
+		ret = cdns_pcie_host_training_complete(pcie);
+		if (ret)
+			return ret;
+
 		ret = cdns_pcie_host_wait_for_link(pcie);
 	}
 	return ret;
-- 
2.39.2



