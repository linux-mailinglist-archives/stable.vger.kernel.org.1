Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095C17ECBD6
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjKOTYt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjKOTYt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:24:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44BB1A8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:24:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55677C433C7;
        Wed, 15 Nov 2023 19:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076285;
        bh=EYLa1g5TuWQJuHidIG4ASDu3Zb84iFt/TDnZ9KSTOv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jEIW/YceuNHo2GompMLLI/sK5dM6GiOvl8O/+hzuFUIBT5Pov1ZsF4o9KEKjPLuvq
         gmXkZ8YqUFWn3ixk48rszE7oXHemMEX3E+lw7i3eIL6nTvkSENwt3wPhX1OOabw9vG
         +C+G63ZvVKfG3Kl3NVyF9uaifyeavH/Pdad4L6Hg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 168/550] clk: renesas: rzg2l: Fix computation formula
Date:   Wed, 15 Nov 2023 14:12:32 -0500
Message-ID: <20231115191612.357569639@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit a2b23159499efd36b2d63b3c4534075d12ddc97a ]

According to the hardware manual for RZ/G2L
(r01uh0914ej0130-rzg2l-rzg2lc.pdf), the computation formula for PLL rate
is as follows:

    Fout = ((m + k/65536) * Fin) / (p * 2^s)

and k has values in the range [-32768, 32767].  Dividing k by 65536 with
integer arithmetic gives zero all the time, causing slight differences
b/w what has been set vs. what is displayed.  Thus, get rid of this and
decompose the formula before dividing k by 65536.

Fixes: ef3c613ccd68a ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-6-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/rzg2l-cpg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 03028362cf619..a3b20c898a391 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -43,7 +43,7 @@
 #define GET_SHIFT(val)		((val >> 12) & 0xff)
 #define GET_WIDTH(val)		((val >> 8) & 0xf)
 
-#define KDIV(val)		FIELD_GET(GENMASK(31, 16), val)
+#define KDIV(val)		((s16)FIELD_GET(GENMASK(31, 16), val))
 #define MDIV(val)		FIELD_GET(GENMASK(15, 6), val)
 #define PDIV(val)		FIELD_GET(GENMASK(5, 0), val)
 #define SDIV(val)		FIELD_GET(GENMASK(2, 0), val)
@@ -702,18 +702,18 @@ static unsigned long rzg2l_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
 	struct pll_clk *pll_clk = to_pll(hw);
 	struct rzg2l_cpg_priv *priv = pll_clk->priv;
 	unsigned int val1, val2;
-	unsigned int mult = 1;
-	unsigned int div = 1;
+	u64 rate;
 
 	if (pll_clk->type != CLK_TYPE_SAM_PLL)
 		return parent_rate;
 
 	val1 = readl(priv->base + GET_REG_SAMPLL_CLK1(pll_clk->conf));
 	val2 = readl(priv->base + GET_REG_SAMPLL_CLK2(pll_clk->conf));
-	mult = MDIV(val1) + KDIV(val1) / 65536;
-	div = PDIV(val1) << SDIV(val2);
 
-	return DIV_ROUND_CLOSEST_ULL((u64)parent_rate * mult, div);
+	rate = mul_u64_u32_shr(parent_rate, (MDIV(val1) << 16) + KDIV(val1),
+			       16 + SDIV(val2));
+
+	return DIV_ROUND_CLOSEST_ULL(rate, PDIV(val1));
 }
 
 static const struct clk_ops rzg2l_cpg_pll_ops = {
-- 
2.42.0



