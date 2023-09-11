Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937BB79B8D6
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbjIKVKZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242193AbjIKPYj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:24:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B85D8
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:24:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB97DC433C9;
        Mon, 11 Sep 2023 15:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445875;
        bh=4kJaWg4mADHgUuw2LKw4yO9zf1h7oR5tCs4zZrNaqT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dsd7NcJOChyxXkYV17vSiX3R7QhDi7seph7GhsFtn8c8eXNtBebg8rpqTVbtfUsqX
         dwSqDjmIumxYmFK57WRhLu9Ccbp9qNREzwdr62DlrQy5DGP+RCvxMmBWc38UZNU+V9
         84XtuWURaJI09vPv10VNMocIyZFIkaOMPYIupfM8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonas Karlman <jonas@kwiboo.se>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 502/600] phy/rockchip: inno-hdmi: use correct vco_div_5 macro on rk3328
Date:   Mon, 11 Sep 2023 15:48:55 +0200
Message-ID: <20230911134648.443072820@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Karlman <jonas@kwiboo.se>

[ Upstream commit 644c06dfbd0da713f772abf0a8f8581ac78e6264 ]

inno_hdmi_phy_rk3328_clk_set_rate() is using the RK3228 macro
when configuring vco_div_5 on RK3328.

Fix this by using correct vco_div_5 macro for RK3328.

Fixes: 53706a116863 ("phy: add Rockchip Innosilicon hdmi phy")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Link: https://lore.kernel.org/r/20230615171005.2251032-2-jonas@kwiboo.se
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
index 80acca4e9e146..15339338aae35 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
@@ -790,8 +790,8 @@ static int inno_hdmi_phy_rk3328_clk_set_rate(struct clk_hw *hw,
 			 RK3328_PRE_PLL_POWER_DOWN);
 
 	/* Configure pre-pll */
-	inno_update_bits(inno, 0xa0, RK3228_PCLK_VCO_DIV_5_MASK,
-			 RK3228_PCLK_VCO_DIV_5(cfg->vco_div_5_en));
+	inno_update_bits(inno, 0xa0, RK3328_PCLK_VCO_DIV_5_MASK,
+			 RK3328_PCLK_VCO_DIV_5(cfg->vco_div_5_en));
 	inno_write(inno, 0xa1, RK3328_PRE_PLL_PRE_DIV(cfg->prediv));
 
 	val = RK3328_SPREAD_SPECTRUM_MOD_DISABLE;
-- 
2.40.1



