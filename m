Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5080A7ED4DE
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344683AbjKOU7Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344692AbjKOU6E (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:58:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7171FC1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBAFC116B9;
        Wed, 15 Nov 2023 20:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081295;
        bh=4yK4PwDVOQgNU4bwEzvVds/RmbUIgicyXzLtHuMLSfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mEHeu98k2ZT8hFZaTc5lMyRd7Ms/A2L+OchmH4NYxtL4bhxVeIPjjYTUfICws6vI6
         JvrgMPzcf99Hl11T4HUUO/UoHLYoe7gdQgrzSKoeDUCq2GIGMyrlfdX/OP8tvJtZCW
         ASKGAaWdfcpK55x/tyzDiWPIeYzkq63eF8Q6o6WM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tony Lindgren <tony@atomide.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 067/244] clk: ti: Update component clocks to use ti_dt_clk_name()
Date:   Wed, 15 Nov 2023 15:34:19 -0500
Message-ID: <20231115203552.379261833@linuxfoundation.org>
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

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit ed06099c5d0b329082cc19c58eace0b20bf7fe70 ]

Let's update all the TI component clocks to use ti_dt_clk_name() instead
of devicetree node name if available.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Link: https://lore.kernel.org/r/20220204071449.16762-9-tony@atomide.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Stable-dep-of: 7af5b9eadd64 ("clk: ti: fix double free in of_ti_divider_clk_setup()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ti/autoidle.c     | 2 +-
 drivers/clk/ti/clk-dra7-atl.c | 6 ++++--
 drivers/clk/ti/composite.c    | 6 ++++--
 drivers/clk/ti/divider.c      | 6 ++++--
 drivers/clk/ti/fixed-factor.c | 2 +-
 drivers/clk/ti/gate.c         | 4 +++-
 drivers/clk/ti/interface.c    | 4 +++-
 drivers/clk/ti/mux.c          | 4 +++-
 8 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
index f6f8a409f148f..d6e5f1511ace8 100644
--- a/drivers/clk/ti/autoidle.c
+++ b/drivers/clk/ti/autoidle.c
@@ -205,7 +205,7 @@ int __init of_ti_clk_autoidle_setup(struct device_node *node)
 		return -ENOMEM;
 
 	clk->shift = shift;
-	clk->name = node->name;
+	clk->name = ti_dt_clk_name(node);
 	ret = ti_clk_get_reg_addr(node, 0, &clk->reg);
 	if (ret) {
 		kfree(clk);
diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
index e2e59d78c173f..5c278d6c985e9 100644
--- a/drivers/clk/ti/clk-dra7-atl.c
+++ b/drivers/clk/ti/clk-dra7-atl.c
@@ -173,6 +173,7 @@ static void __init of_dra7_atl_clock_setup(struct device_node *node)
 	struct dra7_atl_desc *clk_hw = NULL;
 	struct clk_init_data init = { NULL };
 	const char **parent_names = NULL;
+	const char *name;
 	struct clk *clk;
 
 	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
@@ -183,7 +184,8 @@ static void __init of_dra7_atl_clock_setup(struct device_node *node)
 
 	clk_hw->hw.init = &init;
 	clk_hw->divider = 1;
-	init.name = node->name;
+	name = ti_dt_clk_name(node);
+	init.name = name;
 	init.ops = &atl_clk_ops;
 	init.flags = CLK_IGNORE_UNUSED;
 	init.num_parents = of_clk_get_parent_count(node);
@@ -203,7 +205,7 @@ static void __init of_dra7_atl_clock_setup(struct device_node *node)
 
 	init.parent_names = parent_names;
 
-	clk = ti_clk_register(NULL, &clk_hw->hw, node->name);
+	clk = ti_clk_register(NULL, &clk_hw->hw, name);
 
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index eaa43575cfa5e..8d60319be3683 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -125,6 +125,7 @@ static void __init _register_composite(void *user,
 	struct component_clk *comp;
 	int num_parents = 0;
 	const char **parent_names = NULL;
+	const char *name;
 	int i;
 	int ret;
 
@@ -172,7 +173,8 @@ static void __init _register_composite(void *user,
 		goto cleanup;
 	}
 
-	clk = clk_register_composite(NULL, node->name,
+	name = ti_dt_clk_name(node);
+	clk = clk_register_composite(NULL, name,
 				     parent_names, num_parents,
 				     _get_hw(cclk, CLK_COMPONENT_TYPE_MUX),
 				     &ti_clk_mux_ops,
@@ -182,7 +184,7 @@ static void __init _register_composite(void *user,
 				     &ti_composite_gate_ops, 0);
 
 	if (!IS_ERR(clk)) {
-		ret = ti_clk_add_alias(NULL, clk, node->name);
+		ret = ti_clk_add_alias(NULL, clk, name);
 		if (ret) {
 			clk_unregister(clk);
 			goto cleanup;
diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index 28080df92f722..9fbea0997b432 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -320,10 +320,12 @@ static struct clk *_register_divider(struct device_node *node,
 	struct clk *clk;
 	struct clk_init_data init;
 	const char *parent_name;
+	const char *name;
 
 	parent_name = of_clk_get_parent_name(node, 0);
 
-	init.name = node->name;
+	name = ti_dt_clk_name(node);
+	init.name = name;
 	init.ops = &ti_clk_divider_ops;
 	init.flags = flags;
 	init.parent_names = (parent_name ? &parent_name : NULL);
@@ -332,7 +334,7 @@ static struct clk *_register_divider(struct device_node *node,
 	div->hw.init = &init;
 
 	/* register the clock */
-	clk = ti_clk_register(NULL, &div->hw, node->name);
+	clk = ti_clk_register(NULL, &div->hw, name);
 
 	if (IS_ERR(clk))
 		kfree(div);
diff --git a/drivers/clk/ti/fixed-factor.c b/drivers/clk/ti/fixed-factor.c
index 7cbe896db0716..8cb00d0af9662 100644
--- a/drivers/clk/ti/fixed-factor.c
+++ b/drivers/clk/ti/fixed-factor.c
@@ -36,7 +36,7 @@
 static void __init of_ti_fixed_factor_clk_setup(struct device_node *node)
 {
 	struct clk *clk;
-	const char *clk_name = node->name;
+	const char *clk_name = ti_dt_clk_name(node);
 	const char *parent_name;
 	u32 div, mult;
 	u32 flags = 0;
diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
index b1d0fdb40a75a..0033de9beb4cd 100644
--- a/drivers/clk/ti/gate.c
+++ b/drivers/clk/ti/gate.c
@@ -138,6 +138,7 @@ static void __init _of_ti_gate_clk_setup(struct device_node *node,
 	struct clk *clk;
 	const char *parent_name;
 	struct clk_omap_reg reg;
+	const char *name;
 	u8 enable_bit = 0;
 	u32 val;
 	u32 flags = 0;
@@ -164,7 +165,8 @@ static void __init _of_ti_gate_clk_setup(struct device_node *node,
 	if (of_property_read_bool(node, "ti,set-bit-to-disable"))
 		clk_gate_flags |= INVERT_ENABLE;
 
-	clk = _register_gate(NULL, node->name, parent_name, flags, &reg,
+	name = ti_dt_clk_name(node);
+	clk = _register_gate(NULL, name, parent_name, flags, &reg,
 			     enable_bit, clk_gate_flags, ops, hw_ops);
 
 	if (!IS_ERR(clk))
diff --git a/drivers/clk/ti/interface.c b/drivers/clk/ti/interface.c
index 83e34429d3b10..dd2b455183a91 100644
--- a/drivers/clk/ti/interface.c
+++ b/drivers/clk/ti/interface.c
@@ -72,6 +72,7 @@ static void __init _of_ti_interface_clk_setup(struct device_node *node,
 	const char *parent_name;
 	struct clk_omap_reg reg;
 	u8 enable_bit = 0;
+	const char *name;
 	u32 val;
 
 	if (ti_clk_get_reg_addr(node, 0, &reg))
@@ -86,7 +87,8 @@ static void __init _of_ti_interface_clk_setup(struct device_node *node,
 		return;
 	}
 
-	clk = _register_interface(NULL, node->name, parent_name, &reg,
+	name = ti_dt_clk_name(node);
+	clk = _register_interface(NULL, name, parent_name, &reg,
 				  enable_bit, ops);
 
 	if (!IS_ERR(clk))
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index 0069e7cf3ebcc..15de513d2d818 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -176,6 +176,7 @@ static void of_mux_clk_setup(struct device_node *node)
 	struct clk_omap_reg reg;
 	unsigned int num_parents;
 	const char **parent_names;
+	const char *name;
 	u8 clk_mux_flags = 0;
 	u32 mask = 0;
 	u32 shift = 0;
@@ -213,7 +214,8 @@ static void of_mux_clk_setup(struct device_node *node)
 
 	mask = (1 << fls(mask)) - 1;
 
-	clk = _register_mux(NULL, node->name, parent_names, num_parents,
+	name = ti_dt_clk_name(node);
+	clk = _register_mux(NULL, name, parent_names, num_parents,
 			    flags, &reg, shift, mask, latch, clk_mux_flags,
 			    NULL);
 
-- 
2.42.0



