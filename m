Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89866FAE90
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbjEHLpp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbjEHLpZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:45:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9B94269F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:45:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2650636DC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2902C433EF;
        Mon,  8 May 2023 11:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546303;
        bh=JOeBlXAA3rCBj3nrWTiLinVFbnM4lzOFoVX/TfPLTQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DeiKaqpAy0OweOs/RBp1Wiy/yZ6ORWvrslnuZm9wlStkLScOBLN5HiyQnH/0qEWTz
         sFBR8yTxtuQ2hl5NyYFrSXU8Cd2o1zwy24yS0ug5v2hybGxdolqd81wGBqbLteABNZ
         GSh72D51iQ4vIyJ2M/2/HmL9H30HCtVFUiOqIRLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <error27@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 292/371] clk: at91: clk-sam9x60-pll: fix return value check
Date:   Mon,  8 May 2023 11:48:13 +0200
Message-Id: <20230508094823.622269525@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit 1bd8e27fd0db0fe7f489213836dcbab92934f8fa ]

sam9x60_frac_pll_compute_mul_frac() can't return zero. Remove the check
against zero to reflect this.

Fixes: 43b1bb4a9b3e ("clk: at91: clk-sam9x60-pll: re-factor to support plls with multiple outputs")
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230227105931.2812412-1-claudiu.beznea@microchip.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index 1f52409475e9c..a6600afa21454 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -561,7 +561,7 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 
 		ret = sam9x60_frac_pll_compute_mul_frac(&frac->core, FCORE_MIN,
 							parent_rate, true);
-		if (ret <= 0) {
+		if (ret < 0) {
 			hw = ERR_PTR(ret);
 			goto free;
 		}
-- 
2.39.2



