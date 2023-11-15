Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2A47ED3C0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjKOUyd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjKOUy0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:54:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1580E192
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:54:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFB4C4E77A;
        Wed, 15 Nov 2023 20:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081661;
        bh=NvDZR3W8jz3n/QR6wl3hzCEnwRQPWzOrFR2u9yeNSHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hp3g5nPocEulimKy7a6E/gn6DTxraRkOCwQh1Au4S8z1+tXZukcU4RuCZKHmidtt7
         tdf7rY+89lPSqB+ZUV1IwAz6vl3nZANKgAm27yjCoWVTWZxMQiQvMNN6ckY+7/pZK/
         Q8k8hQlVwJgB3EweFLa/z93bD5aeo3JsjEJ+ngk8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 046/191] clk: asm9260: use parent index to link the reference clock
Date:   Wed, 15 Nov 2023 15:45:21 -0500
Message-ID: <20231115204647.370945023@linuxfoundation.org>
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit f5290d8e4f0caa81a491448a27dd70e726095d07 ]

Rewrite clk-asm9260 to use parent index to use the reference clock.
During this rework two helpers are added:

- clk_hw_register_mux_table_parent_data() to supplement
  clk_hw_register_mux_table() but using parent_data instead of
  parent_names

- clk_hw_register_fixed_rate_parent_accuracy() to be used instead of
  directly calling __clk_hw_register_fixed_rate(). The later function is
  an internal API, which is better not to be called directly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20220916061740.87167-2-dmitry.baryshkov@linaro.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Stable-dep-of: 84aefafe6b29 ("clk: linux/clk-provider.h: fix kernel-doc warnings and typos")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-asm9260.c    | 29 ++++++++++++-----------------
 include/linux/clk-provider.h | 21 +++++++++++++++++++++
 2 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/clk-asm9260.c b/drivers/clk/clk-asm9260.c
index bacebd457e6f3..8b3c059e19a12 100644
--- a/drivers/clk/clk-asm9260.c
+++ b/drivers/clk/clk-asm9260.c
@@ -80,7 +80,7 @@ struct asm9260_mux_clock {
 	u8			mask;
 	u32			*table;
 	const char		*name;
-	const char		**parent_names;
+	const struct clk_parent_data *parent_data;
 	u8			num_parents;
 	unsigned long		offset;
 	unsigned long		flags;
@@ -232,10 +232,10 @@ static const struct asm9260_gate_data asm9260_ahb_gates[] __initconst = {
 		HW_AHBCLKCTRL1,	16 },
 };
 
-static const char __initdata *main_mux_p[] =   { NULL, NULL };
-static const char __initdata *i2s0_mux_p[] =   { NULL, NULL, "i2s0m_div"};
-static const char __initdata *i2s1_mux_p[] =   { NULL, NULL, "i2s1m_div"};
-static const char __initdata *clkout_mux_p[] = { NULL, NULL, "rtc"};
+static struct clk_parent_data __initdata main_mux_p[] =   { { .index = 0, }, { .name = "pll" } };
+static struct clk_parent_data __initdata i2s0_mux_p[] =   { { .index = 0, }, { .name = "pll" }, { .name = "i2s0m_div"} };
+static struct clk_parent_data __initdata i2s1_mux_p[] =   { { .index = 0, }, { .name = "pll" }, { .name = "i2s1m_div"} };
+static struct clk_parent_data __initdata clkout_mux_p[] = { { .index = 0, }, { .name = "pll" }, { .name = "rtc"} };
 static u32 three_mux_table[] = {0, 1, 3};
 
 static struct asm9260_mux_clock asm9260_mux_clks[] __initdata = {
@@ -255,9 +255,10 @@ static struct asm9260_mux_clock asm9260_mux_clks[] __initdata = {
 
 static void __init asm9260_acc_init(struct device_node *np)
 {
-	struct clk_hw *hw;
+	struct clk_hw *hw, *pll_hw;
 	struct clk_hw **hws;
-	const char *ref_clk, *pll_clk = "pll";
+	const char *pll_clk = "pll";
+	struct clk_parent_data pll_parent_data = { .index = 0 };
 	u32 rate;
 	int n;
 
@@ -274,21 +275,15 @@ static void __init asm9260_acc_init(struct device_node *np)
 	/* register pll */
 	rate = (ioread32(base + HW_SYSPLLCTRL) & 0xffff) * 1000000;
 
-	/* TODO: Convert to DT parent scheme */
-	ref_clk = of_clk_get_parent_name(np, 0);
-	hw = __clk_hw_register_fixed_rate(NULL, NULL, pll_clk,
-			ref_clk, NULL, NULL, 0, rate, 0,
-			CLK_FIXED_RATE_PARENT_ACCURACY);
-
-	if (IS_ERR(hw))
+	pll_hw = clk_hw_register_fixed_rate_parent_accuracy(NULL, pll_clk, &pll_parent_data,
+							0, rate);
+	if (IS_ERR(pll_hw))
 		panic("%pOFn: can't register REFCLK. Check DT!", np);
 
 	for (n = 0; n < ARRAY_SIZE(asm9260_mux_clks); n++) {
 		const struct asm9260_mux_clock *mc = &asm9260_mux_clks[n];
 
-		mc->parent_names[0] = ref_clk;
-		mc->parent_names[1] = pll_clk;
-		hw = clk_hw_register_mux_table(NULL, mc->name, mc->parent_names,
+		hw = clk_hw_register_mux_table_parent_data(NULL, mc->name, mc->parent_data,
 				mc->num_parents, mc->flags, base + mc->offset,
 				0, mc->mask, 0, mc->table, &asm9260_clk_lock);
 	}
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 03a5de5f99f4a..d199f79c70915 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -439,6 +439,20 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 	__clk_hw_register_fixed_rate((dev), NULL, (name), NULL, NULL,	      \
 				     (parent_data), NULL, (flags),	      \
 				     (fixed_rate), (fixed_accuracy), 0)
+/**
+ * clk_hw_register_fixed_rate_parent_accuracy - register fixed-rate clock with
+ * the clock framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_name: name of clock's parent
+ * @flags: framework-specific flags
+ * @fixed_rate: non-adjustable clock rate
+ */
+#define clk_hw_register_fixed_rate_parent_accuracy(dev, name, parent_data,    \
+						   flags, fixed_rate)	      \
+	__clk_hw_register_fixed_rate((dev), NULL, (name), NULL, NULL,      \
+				     (parent_data), (flags), (fixed_rate), 0,    \
+				     CLK_FIXED_RATE_PARENT_ACCURACY)
 
 void clk_unregister_fixed_rate(struct clk *clk);
 void clk_hw_unregister_fixed_rate(struct clk_hw *hw);
@@ -858,6 +872,13 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 			      (parent_names), NULL, NULL, (flags), (reg),     \
 			      (shift), (mask), (clk_mux_flags), (table),      \
 			      (lock))
+#define clk_hw_register_mux_table_parent_data(dev, name, parent_data,	      \
+				  num_parents, flags, reg, shift, mask,	      \
+				  clk_mux_flags, table, lock)		      \
+	__clk_hw_register_mux((dev), NULL, (name), (num_parents),	      \
+			      NULL, NULL, (parent_data), (flags), (reg),      \
+			      (shift), (mask), (clk_mux_flags), (table),      \
+			      (lock))
 #define clk_hw_register_mux(dev, name, parent_names, num_parents, flags, reg, \
 			    shift, width, clk_mux_flags, lock)		      \
 	__clk_hw_register_mux((dev), NULL, (name), (num_parents),	      \
-- 
2.42.0



