Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B74979B85D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243990AbjIKVj2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242196AbjIKPYm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:24:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D816D8
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:24:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A78C433C8;
        Mon, 11 Sep 2023 15:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445878;
        bh=GH9BgkS5esxtJX2tP7G46h+fDnrqQpxlc4PLsE+eGro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s5XrczTkNYAvrDODylTFeyG2WdpeFMDqbHDAUGhDUMrPmlvsz/NOm3IvUl/x2ER9u
         aJd1xAmCL1hp9er3Jrb466Lk3GiUff1PoZAoVjrjaWiP1B6Ao31J+0xbXmKolPf7Nj
         HZdS68l56Ry4ypOMh7L20+zwf09o80Xw7D/H4Te0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Yang <zhengyang@rock-chips.com>,
        Jonas Karlman <jonas@kwiboo.se>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 503/600] phy/rockchip: inno-hdmi: round fractal pixclock in rk3328 recalc_rate
Date:   Mon, 11 Sep 2023 15:48:56 +0200
Message-ID: <20230911134648.471099335@linuxfoundation.org>
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

From: Zheng Yang <zhengyang@rock-chips.com>

[ Upstream commit d5ef343c1d62bc4c4c2c393af654a41cb34b449f ]

inno_hdmi_phy_rk3328_clk_recalc_rate() is returning a rate not found
in the pre pll config table when the fractal divider is used.
This can prevent proper power_on because a tmdsclock for the new rate
is not found in the pre pll config table.

Fix this by saving and returning a rounded pixel rate that exist
in the pre pll config table.

Fixes: 53706a116863 ("phy: add Rockchip Innosilicon hdmi phy")
Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Link: https://lore.kernel.org/r/20230615171005.2251032-3-jonas@kwiboo.se
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
index 15339338aae35..15a008a1ac7b9 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
@@ -745,10 +745,12 @@ unsigned long inno_hdmi_phy_rk3328_clk_recalc_rate(struct clk_hw *hw,
 		do_div(vco, (nd * (no_a == 1 ? no_b : no_a) * no_d * 2));
 	}
 
-	inno->pixclock = vco;
-	dev_dbg(inno->dev, "%s rate %lu\n", __func__, inno->pixclock);
+	inno->pixclock = DIV_ROUND_CLOSEST((unsigned long)vco, 1000) * 1000;
 
-	return vco;
+	dev_dbg(inno->dev, "%s rate %lu vco %llu\n",
+		__func__, inno->pixclock, vco);
+
+	return inno->pixclock;
 }
 
 static long inno_hdmi_phy_rk3328_clk_round_rate(struct clk_hw *hw,
-- 
2.40.1



