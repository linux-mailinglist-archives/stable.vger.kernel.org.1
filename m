Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3447BDDF4
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376754AbjJINO0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376856AbjJINOZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:14:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2D3B4
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:14:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A7DC433C7;
        Mon,  9 Oct 2023 13:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857260;
        bh=MdOCCOqG/vqfOqiwP03GCS63X4YwP7uKHGfnWihVGL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vZG4MUTwsQOtAJXdbX+yUXxT2lxZNTbyrP10orx8MeAkXU8UQwF3iZzIz88/eQkg4
         9Pl0BeILPzgSS6ogrMXaiwsAC3FtYYkV4CJqEq59EUyaR/rm3FPN8xl5XjgxIuOQqP
         3RrK0VOK2XjzDkqE9fjD8GW3p7zP3Q470TDs2MIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 124/163] net: stmmac: dwmac-stm32: fix resume on STM32 MCU
Date:   Mon,  9 Oct 2023 15:01:28 +0200
Message-ID: <20231009130127.461498323@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Wolsieffer <ben.wolsieffer@hefring.com>

[ Upstream commit 6f195d6b0da3b689922ba9e302af2f49592fa9fc ]

The STM32MP1 keeps clk_rx enabled during suspend, and therefore the
driver does not enable the clock in stm32_dwmac_init() if the device was
suspended. The problem is that this same code runs on STM32 MCUs, which
do disable clk_rx during suspend, causing the clock to never be
re-enabled on resume.

This patch adds a variant flag to indicate that clk_rx remains enabled
during suspend, and uses this to decide whether to enable the clock in
stm32_dwmac_init() if the device was suspended.

This approach fixes this specific bug with limited opportunity for
unintended side-effects, but I have a follow up patch that will refactor
the clock configuration and hopefully make it less error prone.

Fixes: 6528e02cc9ff ("net: ethernet: stmmac: add adaptation for stm32mp157c.")
Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://lore.kernel.org/r/20230927175749.1419774-1-ben.wolsieffer@hefring.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index bdb4de59a6727..28c8ca5fba6c5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -105,6 +105,7 @@ struct stm32_ops {
 	int (*parse_data)(struct stm32_dwmac *dwmac,
 			  struct device *dev);
 	u32 syscfg_eth_mask;
+	bool clk_rx_enable_in_suspend;
 };
 
 static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
@@ -122,7 +123,8 @@ static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
 	if (ret)
 		return ret;
 
-	if (!dwmac->dev->power.is_suspended) {
+	if (!dwmac->ops->clk_rx_enable_in_suspend ||
+	    !dwmac->dev->power.is_suspended) {
 		ret = clk_prepare_enable(dwmac->clk_rx);
 		if (ret) {
 			clk_disable_unprepare(dwmac->clk_tx);
@@ -514,7 +516,8 @@ static struct stm32_ops stm32mp1_dwmac_data = {
 	.suspend = stm32mp1_suspend,
 	.resume = stm32mp1_resume,
 	.parse_data = stm32mp1_parse_data,
-	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK
+	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK,
+	.clk_rx_enable_in_suspend = true
 };
 
 static const struct of_device_id stm32_dwmac_match[] = {
-- 
2.40.1



