Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D98755524
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjGPUhy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjGPUhu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:37:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994809F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:37:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3820560E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1EEC433C8;
        Sun, 16 Jul 2023 20:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539868;
        bh=zPvrFdTJXXriIUIzrupghhzvO3q1jogI7a+dNEBfXfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xTh2C+X7h5HhxNf5vS4h85gHwnp1hVqXPCp+VIZK0gEJ4LmFRq/VfPSG43w1pJceO
         BqlAXmRv1XnEJZNjf9vR3XV+J5Vo0h3i3QyHguht3/GfYOmbWMU79EJVGfFrghfl1a
         yfQDMsJhWEF6EIkKh4PEWXNvilrCf9Go9ulOSqig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lars-Peter Clausen <lars@metafoo.de>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 160/591] clk: vc5: Use `clamp()` to restrict PLL range
Date:   Sun, 16 Jul 2023 21:44:59 +0200
Message-ID: <20230716194928.006521758@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Lars-Peter Clausen <lars@metafoo.de>

[ Upstream commit 3ed741db04f58e8df0d46cec7ecfc4bfd075f047 ]

The VCO frequency needs to be within a certain range and the driver
enforces this.

Make use of the clamp macro to implement this instead of open-coding it.
This makes the code a bit shorter and also semanticly stronger.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Link: https://lore.kernel.org/r/20230114233500.3294789-1-lars@metafoo.de
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Stable-dep-of: be3471c5bd9b ("clk: vc5: Fix .driver_data content in i2c_device_id")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-versaclock5.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 88689415aff9c..abfe59ac4e487 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -450,10 +450,7 @@ static long vc5_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 	u32 div_int;
 	u64 div_frc;
 
-	if (rate < VC5_PLL_VCO_MIN)
-		rate = VC5_PLL_VCO_MIN;
-	if (rate > VC5_PLL_VCO_MAX)
-		rate = VC5_PLL_VCO_MAX;
+	rate = clamp(rate, VC5_PLL_VCO_MIN, VC5_PLL_VCO_MAX);
 
 	/* Determine integer part, which is 12 bit wide */
 	div_int = rate / *parent_rate;
-- 
2.39.2



