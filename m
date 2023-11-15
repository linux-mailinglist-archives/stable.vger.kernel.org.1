Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98ED27ED3E3
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343572AbjKOUzN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343571AbjKOUzM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:55:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2888F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:55:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCB6C4E779;
        Wed, 15 Nov 2023 20:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081709;
        bh=+YI/he3qqVizyKoID569gX+W3m+yy6jpfRTK5IybGeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N6FZi4yvpNwDS73JA3M27be4Y6hCGhjfZencKqwD/yoUputXyP7NNta/PXIUJVXPL
         4Yjdz7EoUCZAMEBVnCLM+uI1z2lNFjFQxZZkPYCqvDKbRqxHakhofCawdn619WEdZP
         UR+RNUIfD+SmWeS0/tKq11wMCsoeDP1NRGssW0Zc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tony Lindgren <tony@atomide.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 051/191] clk: ti: Update pll and clockdomain clocks to use ti_dt_clk_name()
Date:   Wed, 15 Nov 2023 15:45:26 -0500
Message-ID: <20231115204647.668731541@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 9e56a7d4263ca1c51d867e811cf2dd7e61b6469e ]

Let's update the TI pll and clockdomain clocks to use ti_dt_clk_name()
instead of devicetree node name if available.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Link: https://lore.kernel.org/r/20220204071449.16762-8-tony@atomide.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Stable-dep-of: 7af5b9eadd64 ("clk: ti: fix double free in of_ti_divider_clk_setup()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ti/apll.c        | 13 +++++++++----
 drivers/clk/ti/clockdomain.c |  2 +-
 drivers/clk/ti/dpll.c        |  8 +++++---
 drivers/clk/ti/fapll.c       | 11 +++++++----
 4 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index ac5bc8857a514..e4db6b9a55c61 100644
--- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -139,6 +139,7 @@ static void __init omap_clk_register_apll(void *user,
 	struct clk_hw *hw = user;
 	struct clk_hw_omap *clk_hw = to_clk_hw_omap(hw);
 	struct dpll_data *ad = clk_hw->dpll_data;
+	const char *name;
 	struct clk *clk;
 	const struct clk_init_data *init = clk_hw->hw.init;
 
@@ -166,7 +167,8 @@ static void __init omap_clk_register_apll(void *user,
 
 	ad->clk_bypass = __clk_get_hw(clk);
 
-	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, node->name);
+	name = ti_dt_clk_name(node);
+	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, name);
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		kfree(init->parent_names);
@@ -198,7 +200,7 @@ static void __init of_dra7_apll_setup(struct device_node *node)
 	clk_hw->dpll_data = ad;
 	clk_hw->hw.init = init;
 
-	init->name = node->name;
+	init->name = ti_dt_clk_name(node);
 	init->ops = &apll_ck_ops;
 
 	init->num_parents = of_clk_get_parent_count(node);
@@ -347,6 +349,7 @@ static void __init of_omap2_apll_setup(struct device_node *node)
 	struct dpll_data *ad = NULL;
 	struct clk_hw_omap *clk_hw = NULL;
 	struct clk_init_data *init = NULL;
+	const char *name;
 	struct clk *clk;
 	const char *parent_name;
 	u32 val;
@@ -362,7 +365,8 @@ static void __init of_omap2_apll_setup(struct device_node *node)
 	clk_hw->dpll_data = ad;
 	clk_hw->hw.init = init;
 	init->ops = &omap2_apll_ops;
-	init->name = node->name;
+	name = ti_dt_clk_name(node);
+	init->name = name;
 	clk_hw->ops = &omap2_apll_hwops;
 
 	init->num_parents = of_clk_get_parent_count(node);
@@ -403,7 +407,8 @@ static void __init of_omap2_apll_setup(struct device_node *node)
 	if (ret)
 		goto cleanup;
 
-	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, node->name);
+	name = ti_dt_clk_name(node);
+	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, name);
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		kfree(init);
diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
index 700b7f44f6716..e5f447f4377b7 100644
--- a/drivers/clk/ti/clockdomain.c
+++ b/drivers/clk/ti/clockdomain.c
@@ -131,7 +131,7 @@ static void __init of_ti_clockdomain_setup(struct device_node *node)
 {
 	struct clk *clk;
 	struct clk_hw *clk_hw;
-	const char *clkdm_name = node->name;
+	const char *clkdm_name = ti_dt_clk_name(node);
 	int i;
 	unsigned int num_clks;
 
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 247510e306e2a..6013c1d30c266 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -164,6 +164,7 @@ static void __init _register_dpll(void *user,
 	struct clk_hw *hw = user;
 	struct clk_hw_omap *clk_hw = to_clk_hw_omap(hw);
 	struct dpll_data *dd = clk_hw->dpll_data;
+	const char *name;
 	struct clk *clk;
 	const struct clk_init_data *init = hw->init;
 
@@ -193,7 +194,8 @@ static void __init _register_dpll(void *user,
 	dd->clk_bypass = __clk_get_hw(clk);
 
 	/* register the clock */
-	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, node->name);
+	name = ti_dt_clk_name(node);
+	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, name);
 
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
@@ -227,7 +229,7 @@ static void _register_dpll_x2(struct device_node *node,
 	struct clk *clk;
 	struct clk_init_data init = { NULL };
 	struct clk_hw_omap *clk_hw;
-	const char *name = node->name;
+	const char *name = ti_dt_clk_name(node);
 	const char *parent_name;
 
 	parent_name = of_clk_get_parent_name(node, 0);
@@ -302,7 +304,7 @@ static void __init of_ti_dpll_setup(struct device_node *node,
 	clk_hw->ops = &clkhwops_omap3_dpll;
 	clk_hw->hw.init = init;
 
-	init->name = node->name;
+	init->name = ti_dt_clk_name(node);
 	init->ops = ops;
 
 	init->num_parents = of_clk_get_parent_count(node);
diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index 8024c6d2b9e95..749c6b73abff3 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -19,6 +19,8 @@
 #include <linux/of_address.h>
 #include <linux/clk/ti.h>
 
+#include "clock.h"
+
 /* FAPLL Control Register PLL_CTRL */
 #define FAPLL_MAIN_MULT_N_SHIFT	16
 #define FAPLL_MAIN_DIV_P_SHIFT	8
@@ -542,6 +544,7 @@ static void __init ti_fapll_setup(struct device_node *node)
 	struct clk_init_data *init = NULL;
 	const char *parent_name[2];
 	struct clk *pll_clk;
+	const char *name;
 	int i;
 
 	fd = kzalloc(sizeof(*fd), GFP_KERNEL);
@@ -559,7 +562,8 @@ static void __init ti_fapll_setup(struct device_node *node)
 		goto free;
 
 	init->ops = &ti_fapll_ops;
-	init->name = node->name;
+	name = ti_dt_clk_name(node);
+	init->name = name;
 
 	init->num_parents = of_clk_get_parent_count(node);
 	if (init->num_parents != 2) {
@@ -591,7 +595,7 @@ static void __init ti_fapll_setup(struct device_node *node)
 	if (fapll_is_ddr_pll(fd->base))
 		fd->bypass_bit_inverted = true;
 
-	fd->name = node->name;
+	fd->name = name;
 	fd->hw.init = init;
 
 	/* Register the parent PLL */
@@ -638,8 +642,7 @@ static void __init ti_fapll_setup(struct device_node *node)
 				freq = NULL;
 		}
 		synth_clk = ti_fapll_synth_setup(fd, freq, div, output_instance,
-						 output_name, node->name,
-						 pll_clk);
+						 output_name, name, pll_clk);
 		if (IS_ERR(synth_clk))
 			continue;
 
-- 
2.42.0



