Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A6D70C846
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbjEVTh2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbjEVThW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:37:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4D31BC
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:37:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B0DD629A5
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D4CC433EF;
        Mon, 22 May 2023 19:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784229;
        bh=xEG9VDstyVHAmm2BjboZPv1h847TxQkuNGGGg/uko/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sm6qrGimeBPnJP8n3OLzMpjanxcdGPrJZCkXorBlFe/KeaFLhJsjGx1FSQTrijn+1
         PxzV3hfMU1EahUlWtGG0XsZjcbhjiDyJg5Zq1OF9o0NvsOqlAIDzFIl2uW4rHgWiR2
         Bml6mTwnbLazPtH+4Uj3szLbPzxXYBz3vg8MDr+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Harald Seiler <hws@denx.de>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 013/364] net: stmmac: Initialize MAC_ONEUS_TIC_COUNTER register
Date:   Mon, 22 May 2023 20:05:18 +0100
Message-Id: <20230522190413.158569246@linuxfoundation.org>
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

From: Marek Vasut <marex@denx.de>

[ Upstream commit 8efbdbfa99381a017dd2c0f6375a7d80a8118b74 ]

Initialize MAC_ONEUS_TIC_COUNTER register with correct value derived
from CSR clock, otherwise EEE is unstable on at least NXP i.MX8M Plus
and Micrel KSZ9131RNX PHY, to the point where not even ARP request can
be sent out.

i.MX 8M Plus Applications Processor Reference Manual, Rev. 1, 06/2021
11.7.6.1.34 One-microsecond Reference Timer (MAC_ONEUS_TIC_COUNTER)
defines this register as:
"
This register controls the generation of the Reference time (1 microsecond
tic) for all the LPI timers. This timer has to be programmed by the software
initially.
...
The application must program this counter so that the number of clock cycles
of CSR clock is 1us. (Subtract 1 from the value before programming).
For example if the CSR clock is 100MHz then this field needs to be programmed
to value 100 - 1 = 99 (which is 0x63).
This is required to generate the 1US events that are used to update some of
the EEE related counters.
"

The reset value is 0x63 on i.MX8M Plus, which means expected CSR clock are
100 MHz. However, the i.MX8M Plus "enet_qos_root_clk" are 266 MHz instead,
which means the LPI timers reach their count much sooner on this platform.

This is visible using a scope by monitoring e.g. exit from LPI mode on TX_CTL
line from MAC to PHY. This should take 30us per STMMAC_DEFAULT_TWT_LS setting,
during which the TX_CTL line transitions from tristate to low, and 30 us later
from low to high. On i.MX8M Plus, this transition takes 11 us, which matches
the 30us * 100/266 formula for misconfigured MAC_ONEUS_TIC_COUNTER register.

Configure MAC_ONEUS_TIC_COUNTER based on CSR clock, so that the LPI timers
have correct 1us reference. This then fixes EEE on i.MX8M Plus with Micrel
KSZ9131RNX PHY.

Fixes: 477286b53f55 ("stmmac: add GMAC4 core support")
Signed-off-by: Marek Vasut <marex@denx.de>
Tested-by: Harald Seiler <hws@denx.de>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # Toradex Verdin iMX8MP
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Link: https://lore.kernel.org/r/20230506235845.246105-1-marex@denx.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h      | 1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index ccd49346d3b30..a70b0d8a622d6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -181,6 +181,7 @@ enum power_event {
 #define GMAC4_LPI_CTRL_STATUS	0xd0
 #define GMAC4_LPI_TIMER_CTRL	0xd4
 #define GMAC4_LPI_ENTRY_TIMER	0xd8
+#define GMAC4_MAC_ONEUS_TIC_COUNTER	0xdc
 
 /* LPI control and status defines */
 #define GMAC4_LPI_CTRL_STATUS_LPITCSE	BIT(21)	/* LPI Tx Clock Stop Enable */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 36251ec2589c9..24d6ec06732d9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -25,6 +25,7 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 	struct stmmac_priv *priv = netdev_priv(dev);
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value = readl(ioaddr + GMAC_CONFIG);
+	u32 clk_rate;
 
 	value |= GMAC_CORE_INIT;
 
@@ -47,6 +48,10 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 
 	writel(value, ioaddr + GMAC_CONFIG);
 
+	/* Configure LPI 1us counter to number of CSR clock ticks in 1us - 1 */
+	clk_rate = clk_get_rate(priv->plat->stmmac_clk);
+	writel((clk_rate / 1000000) - 1, ioaddr + GMAC4_MAC_ONEUS_TIC_COUNTER);
+
 	/* Enable GMAC interrupts */
 	value = GMAC_INT_DEFAULT_ENABLE;
 
-- 
2.39.2



