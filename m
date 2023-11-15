Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81C47ED45C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344630AbjKOU5x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344629AbjKOU5a (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985AF10F4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8FBC116B1;
        Wed, 15 Nov 2023 20:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081279;
        bh=bJNRL5OnLkp5GfzPVxPPlmYJoe45rPmHrmaDjlucwYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KX9ewAZgtOsqBhnvNdHdFZAI/WOSOomkYphXPY9zoOgvjdGYCWLtOJCGJP1r9Kibc
         j942/3J5NBpQtiEz3AQeGtqP9/Emgp44tuCZlumhjA3ZygsAt6IVhXFi44KNMtnP20
         lQyyUgem93/S/nqIOzwC93RsVRhgKInBfP15zi2w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 060/244] clk: renesas: rzg2l: Simplify multiplication/shift logic
Date:   Wed, 15 Nov 2023 15:34:12 -0500
Message-ID: <20231115203551.955939762@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 29db30c45f07c929c86c40a5b85f18b69c89c638 ]

"a * (1 << b)" == "a << b".

No change in generated code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/71e1cf2e30fb2d7966fc8ec6bab23eb7e24aa1c4.1645460687.git.geert+renesas@glider.be
Stable-dep-of: a2b23159499e ("clk: renesas: rzg2l: Fix computation formula")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/rzg2l-cpg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 1c92e73cd2b8c..e435d88d9da89 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -155,7 +155,7 @@ static unsigned long rzg2l_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
 	val1 = readl(priv->base + GET_REG_SAMPLL_CLK1(pll_clk->conf));
 	val2 = readl(priv->base + GET_REG_SAMPLL_CLK2(pll_clk->conf));
 	mult = MDIV(val1) + KDIV(val1) / 65536;
-	div = PDIV(val1) * (1 << SDIV(val2));
+	div = PDIV(val1) << SDIV(val2);
 
 	return DIV_ROUND_CLOSEST_ULL((u64)parent_rate * mult, div);
 }
-- 
2.42.0



