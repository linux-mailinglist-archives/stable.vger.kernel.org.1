Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654D97ED3E8
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjKOUzX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbjKOUzQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:55:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1C78F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:55:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259E5C4E779;
        Wed, 15 Nov 2023 20:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081712;
        bh=aNHajKTDIkSZLKH9MgdkpgeWc1VDUwnrBv8u4VuwazE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tc9kSN+PbWT+iHFQHczUC8/aXwpXvTXLGm4E4HmJhnrvtBIJKsT+MP+CKFStv8v+u
         EgEnBjwqxTp6RBQi7flxpP0+PJFLpDyzHiM7Y4yrY9Cr5pr0hRiHO8MLsjK+UULXpa
         OKwexTNBVJ6A7mJOLWHnEC/cNOX8fEjSZGZjhBs4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Tony Lindgren <tony@atomide.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 053/191] clk: ti: change ti_clk_register[_omap_hw]() API
Date:   Wed, 15 Nov 2023 15:45:28 -0500
Message-ID: <20231115204647.788350312@linuxfoundation.org>
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

From: Dario Binacchi <dario.binacchi@amarulasolutions.com>

[ Upstream commit 3400d546a741a2b2001d88e7fa29110d45a3930d ]

The ti_clk_register() and ti_clk_register_omap_hw() functions are always
called with the parameter of type "struct device" set to NULL, since the
functions from which they are called always have a parameter of type
"struct device_node". Replacing "struct device" type parameter with
"struct device_node" will allow you to register a TI clock to the common
clock framework by taking advantage of the facilities provided by the
"struct device_node" type. Further, adding the "of_" prefix to the name
of these functions explicitly binds them to the "struct device_node"
type.

The patch has been tested on a Beaglebone board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Link: https://lore.kernel.org/r/20221113181147.1626585-1-dario.binacchi@amarulasolutions.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Stable-dep-of: 7af5b9eadd64 ("clk: ti: fix double free in of_ti_divider_clk_setup()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ti/apll.c         |  4 ++--
 drivers/clk/ti/clk-dra7-atl.c |  2 +-
 drivers/clk/ti/clk.c          | 34 ++++++++++++++++------------------
 drivers/clk/ti/clkctrl.c      |  4 ++--
 drivers/clk/ti/clock.h        | 10 +++++-----
 drivers/clk/ti/composite.c    |  2 +-
 drivers/clk/ti/divider.c      |  2 +-
 drivers/clk/ti/dpll.c         |  4 ++--
 drivers/clk/ti/fixed-factor.c |  2 +-
 drivers/clk/ti/gate.c         |  6 +++---
 drivers/clk/ti/interface.c    |  7 ++++---
 drivers/clk/ti/mux.c          |  6 +++---
 12 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index e4db6b9a55c61..f921c6812852f 100644
--- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -168,7 +168,7 @@ static void __init omap_clk_register_apll(void *user,
 	ad->clk_bypass = __clk_get_hw(clk);
 
 	name = ti_dt_clk_name(node);
-	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, name);
+	clk = of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		kfree(init->parent_names);
@@ -408,7 +408,7 @@ static void __init of_omap2_apll_setup(struct device_node *node)
 		goto cleanup;
 
 	name = ti_dt_clk_name(node);
-	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, name);
+	clk = of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		kfree(init);
diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
index 5c278d6c985e9..62508e74a47a7 100644
--- a/drivers/clk/ti/clk-dra7-atl.c
+++ b/drivers/clk/ti/clk-dra7-atl.c
@@ -205,7 +205,7 @@ static void __init of_dra7_atl_clock_setup(struct device_node *node)
 
 	init.parent_names = parent_names;
 
-	clk = ti_clk_register(NULL, &clk_hw->hw, name);
+	clk = of_ti_clk_register(node, &clk_hw->hw, name);
 
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index b941ce0f3c394..6a39fb051b2ee 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -436,7 +436,7 @@ void __init ti_clk_add_aliases(void)
 		clkspec.np = np;
 		clk = of_clk_get_from_provider(&clkspec);
 
-		ti_clk_add_alias(NULL, clk, ti_dt_clk_name(np));
+		ti_clk_add_alias(clk, ti_dt_clk_name(np));
 	}
 }
 
@@ -489,7 +489,6 @@ void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks)
 
 /**
  * ti_clk_add_alias - add a clock alias for a TI clock
- * @dev: device alias for this clock
  * @clk: clock handle to create alias for
  * @con: connection ID for this clock
  *
@@ -497,7 +496,7 @@ void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks)
  * and assigns the data to it. Returns 0 if successful, negative error
  * value otherwise.
  */
-int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con)
+int ti_clk_add_alias(struct clk *clk, const char *con)
 {
 	struct clk_lookup *cl;
 
@@ -511,8 +510,6 @@ int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con)
 	if (!cl)
 		return -ENOMEM;
 
-	if (dev)
-		cl->dev_id = dev_name(dev);
 	cl->con_id = con;
 	cl->clk = clk;
 
@@ -522,8 +519,8 @@ int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con)
 }
 
 /**
- * ti_clk_register - register a TI clock to the common clock framework
- * @dev: device for this clock
+ * of_ti_clk_register - register a TI clock to the common clock framework
+ * @node: device node for this clock
  * @hw: hardware clock handle
  * @con: connection ID for this clock
  *
@@ -531,17 +528,18 @@ int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con)
  * alias for it. Returns a handle to the registered clock if successful,
  * ERR_PTR value in failure.
  */
-struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
-			    const char *con)
+struct clk *of_ti_clk_register(struct device_node *node, struct clk_hw *hw,
+			       const char *con)
 {
 	struct clk *clk;
 	int ret;
 
-	clk = clk_register(dev, hw);
-	if (IS_ERR(clk))
-		return clk;
+	ret = of_clk_hw_register(node, hw);
+	if (ret)
+		return ERR_PTR(ret);
 
-	ret = ti_clk_add_alias(dev, clk, con);
+	clk = hw->clk;
+	ret = ti_clk_add_alias(clk, con);
 	if (ret) {
 		clk_unregister(clk);
 		return ERR_PTR(ret);
@@ -551,8 +549,8 @@ struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
 }
 
 /**
- * ti_clk_register_omap_hw - register a clk_hw_omap to the clock framework
- * @dev: device for this clock
+ * of_ti_clk_register_omap_hw - register a clk_hw_omap to the clock framework
+ * @node: device node for this clock
  * @hw: hardware clock handle
  * @con: connection ID for this clock
  *
@@ -561,13 +559,13 @@ struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
  * Returns a handle to the registered clock if successful, ERR_PTR value
  * in failure.
  */
-struct clk *ti_clk_register_omap_hw(struct device *dev, struct clk_hw *hw,
-				    const char *con)
+struct clk *of_ti_clk_register_omap_hw(struct device_node *node,
+				       struct clk_hw *hw, const char *con)
 {
 	struct clk *clk;
 	struct clk_hw_omap *oclk;
 
-	clk = ti_clk_register(dev, hw, con);
+	clk = of_ti_clk_register(node, hw, con);
 	if (IS_ERR(clk))
 		return clk;
 
diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 157abc46dcf44..1424b615a4cc5 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -317,7 +317,7 @@ _ti_clkctrl_clk_register(struct omap_clkctrl_provider *provider,
 	init.ops = ops;
 	init.flags = 0;
 
-	clk = ti_clk_register(NULL, clk_hw, init.name);
+	clk = of_ti_clk_register(node, clk_hw, init.name);
 	if (IS_ERR_OR_NULL(clk)) {
 		ret = -EINVAL;
 		goto cleanup;
@@ -701,7 +701,7 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 		init.ops = &omap4_clkctrl_clk_ops;
 		hw->hw.init = &init;
 
-		clk = ti_clk_register_omap_hw(NULL, &hw->hw, init.name);
+		clk = of_ti_clk_register_omap_hw(node, &hw->hw, init.name);
 		if (IS_ERR_OR_NULL(clk))
 			goto cleanup;
 
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 938f34e290ed2..821f33ee330e4 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -210,12 +210,12 @@ extern const struct omap_clkctrl_data dm816_clkctrl_data[];
 
 typedef void (*ti_of_clk_init_cb_t)(void *, struct device_node *);
 
-struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
-			    const char *con);
-struct clk *ti_clk_register_omap_hw(struct device *dev, struct clk_hw *hw,
-				    const char *con);
+struct clk *of_ti_clk_register(struct device_node *node, struct clk_hw *hw,
+			       const char *con);
+struct clk *of_ti_clk_register_omap_hw(struct device_node *node,
+				       struct clk_hw *hw, const char *con);
 const char *ti_dt_clk_name(struct device_node *np);
-int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con);
+int ti_clk_add_alias(struct clk *clk, const char *con);
 void ti_clk_add_aliases(void);
 
 void ti_clk_latch(struct clk_omap_reg *reg, s8 shift);
diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index 8d60319be3683..78d44158fb7d9 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -184,7 +184,7 @@ static void __init _register_composite(void *user,
 				     &ti_composite_gate_ops, 0);
 
 	if (!IS_ERR(clk)) {
-		ret = ti_clk_add_alias(NULL, clk, name);
+		ret = ti_clk_add_alias(clk, name);
 		if (ret) {
 			clk_unregister(clk);
 			goto cleanup;
diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index 9fbea0997b432..83931cc299713 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -334,7 +334,7 @@ static struct clk *_register_divider(struct device_node *node,
 	div->hw.init = &init;
 
 	/* register the clock */
-	clk = ti_clk_register(NULL, &div->hw, name);
+	clk = of_ti_clk_register(node, &div->hw, name);
 
 	if (IS_ERR(clk))
 		kfree(div);
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 6013c1d30c266..13d01594516d1 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -195,7 +195,7 @@ static void __init _register_dpll(void *user,
 
 	/* register the clock */
 	name = ti_dt_clk_name(node);
-	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, name);
+	clk = of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
@@ -267,7 +267,7 @@ static void _register_dpll_x2(struct device_node *node,
 #endif
 
 	/* register the clock */
-	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, name);
+	clk = of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 
 	if (IS_ERR(clk))
 		kfree(clk_hw);
diff --git a/drivers/clk/ti/fixed-factor.c b/drivers/clk/ti/fixed-factor.c
index 8cb00d0af9662..a4f9c1c156137 100644
--- a/drivers/clk/ti/fixed-factor.c
+++ b/drivers/clk/ti/fixed-factor.c
@@ -62,7 +62,7 @@ static void __init of_ti_fixed_factor_clk_setup(struct device_node *node)
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		of_ti_clk_autoidle_setup(node);
-		ti_clk_add_alias(NULL, clk, clk_name);
+		ti_clk_add_alias(clk, clk_name);
 	}
 }
 CLK_OF_DECLARE(ti_fixed_factor_clk, "ti,fixed-factor-clock",
diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
index 2fee7d681a678..0cc1babad661d 100644
--- a/drivers/clk/ti/gate.c
+++ b/drivers/clk/ti/gate.c
@@ -93,7 +93,7 @@ static int omap36xx_gate_clk_enable_with_hsdiv_restore(struct clk_hw *hw)
 	return ret;
 }
 
-static struct clk *_register_gate(struct device *dev, const char *name,
+static struct clk *_register_gate(struct device_node *node, const char *name,
 				  const char *parent_name, unsigned long flags,
 				  struct clk_omap_reg *reg, u8 bit_idx,
 				  u8 clk_gate_flags, const struct clk_ops *ops,
@@ -123,7 +123,7 @@ static struct clk *_register_gate(struct device *dev, const char *name,
 
 	init.flags = flags;
 
-	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, name);
+	clk = of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 
 	if (IS_ERR(clk))
 		kfree(clk_hw);
@@ -166,7 +166,7 @@ static void __init _of_ti_gate_clk_setup(struct device_node *node,
 		clk_gate_flags |= INVERT_ENABLE;
 
 	name = ti_dt_clk_name(node);
-	clk = _register_gate(NULL, name, parent_name, flags, &reg,
+	clk = _register_gate(node, name, parent_name, flags, &reg,
 			     enable_bit, clk_gate_flags, ops, hw_ops);
 
 	if (!IS_ERR(clk))
diff --git a/drivers/clk/ti/interface.c b/drivers/clk/ti/interface.c
index dd2b455183a91..1ccd5dbf2bb48 100644
--- a/drivers/clk/ti/interface.c
+++ b/drivers/clk/ti/interface.c
@@ -32,7 +32,8 @@ static const struct clk_ops ti_interface_clk_ops = {
 	.is_enabled	= &omap2_dflt_clk_is_enabled,
 };
 
-static struct clk *_register_interface(struct device *dev, const char *name,
+static struct clk *_register_interface(struct device_node *node,
+				       const char *name,
 				       const char *parent_name,
 				       struct clk_omap_reg *reg, u8 bit_idx,
 				       const struct clk_hw_omap_ops *ops)
@@ -57,7 +58,7 @@ static struct clk *_register_interface(struct device *dev, const char *name,
 	init.num_parents = 1;
 	init.parent_names = &parent_name;
 
-	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, name);
+	clk = of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 
 	if (IS_ERR(clk))
 		kfree(clk_hw);
@@ -88,7 +89,7 @@ static void __init _of_ti_interface_clk_setup(struct device_node *node,
 	}
 
 	name = ti_dt_clk_name(node);
-	clk = _register_interface(NULL, name, parent_name, &reg,
+	clk = _register_interface(node, name, parent_name, &reg,
 				  enable_bit, ops);
 
 	if (!IS_ERR(clk))
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index 15de513d2d818..4205ff4bad217 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -126,7 +126,7 @@ const struct clk_ops ti_clk_mux_ops = {
 	.restore_context = clk_mux_restore_context,
 };
 
-static struct clk *_register_mux(struct device *dev, const char *name,
+static struct clk *_register_mux(struct device_node *node, const char *name,
 				 const char * const *parent_names,
 				 u8 num_parents, unsigned long flags,
 				 struct clk_omap_reg *reg, u8 shift, u32 mask,
@@ -156,7 +156,7 @@ static struct clk *_register_mux(struct device *dev, const char *name,
 	mux->table = table;
 	mux->hw.init = &init;
 
-	clk = ti_clk_register(dev, &mux->hw, name);
+	clk = of_ti_clk_register(node, &mux->hw, name);
 
 	if (IS_ERR(clk))
 		kfree(mux);
@@ -215,7 +215,7 @@ static void of_mux_clk_setup(struct device_node *node)
 	mask = (1 << fls(mask)) - 1;
 
 	name = ti_dt_clk_name(node);
-	clk = _register_mux(NULL, name, parent_names, num_parents,
+	clk = _register_mux(node, name, parent_names, num_parents,
 			    flags, &reg, shift, mask, latch, clk_mux_flags,
 			    NULL);
 
-- 
2.42.0



