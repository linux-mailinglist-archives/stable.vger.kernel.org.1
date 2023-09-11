Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EC679B8CB
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355421AbjIKV6H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241925AbjIKPSC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:18:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC06FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:17:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E9DC433C8;
        Mon, 11 Sep 2023 15:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445477;
        bh=u33/xWUJL3IWKnwW84Tmj/YV2Pyb8QUo9WnamCn+Jz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Na789qsuItHHi4hE3Cp/zjxvJWL7ztpdwTnKiBasTc4lZ/eMFyePPENc2cZpvlEbR
         cNNX82ASkACnHBGt/kntVJZvVXHmWsUDLgXznj7D8YVaWYBS6RdKwI8lST7YXxKOQF
         e5WS6qTnV9LYxNYNr6btSJVGQFIhjAKG+78SWX4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alibek Omarov <a1ba.omarov@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 334/600] clk: rockchip: rk3568: Fix PLL rate setting for 78.75MHz
Date:   Mon, 11 Sep 2023 15:46:07 +0200
Message-ID: <20230911134643.546713393@linuxfoundation.org>
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

From: Alibek Omarov <a1ba.omarov@gmail.com>

[ Upstream commit dafebd0f9a4f56b10d7fbda0bff1f540d16a2ea4 ]

PLL rate on RK356x is calculated through the simple formula:
((24000000 / _refdiv) * _fbdiv) / (_postdiv1 * _postdiv2)

The PLL rate setting for 78.75MHz seems to be copied from 96MHz
so this patch fixes it and configures it properly.

Signed-off-by: Alibek Omarov <a1ba.omarov@gmail.com>
Fixes: 842f4cb72639 ("clk: rockchip: Add more PLL rates for rk3568")
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Link: https://lore.kernel.org/r/20230614134750.1056293-1-a1ba.omarov@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/rockchip/clk-rk3568.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3568.c b/drivers/clk/rockchip/clk-rk3568.c
index f85902e2590c7..2f54f630c8b65 100644
--- a/drivers/clk/rockchip/clk-rk3568.c
+++ b/drivers/clk/rockchip/clk-rk3568.c
@@ -81,7 +81,7 @@ static struct rockchip_pll_rate_table rk3568_pll_rates[] = {
 	RK3036_PLL_RATE(108000000, 2, 45, 5, 1, 1, 0),
 	RK3036_PLL_RATE(100000000, 1, 150, 6, 6, 1, 0),
 	RK3036_PLL_RATE(96000000, 1, 96, 6, 4, 1, 0),
-	RK3036_PLL_RATE(78750000, 1, 96, 6, 4, 1, 0),
+	RK3036_PLL_RATE(78750000, 4, 315, 6, 4, 1, 0),
 	RK3036_PLL_RATE(74250000, 2, 99, 4, 4, 1, 0),
 	{ /* sentinel */ },
 };
-- 
2.40.1



