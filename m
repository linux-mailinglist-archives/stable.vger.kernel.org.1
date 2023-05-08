Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2236FA90E
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbjEHKr0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbjEHKqt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:46:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5362A9D3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:46:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C2B3628D3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B0DC433D2;
        Mon,  8 May 2023 10:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542793;
        bh=gHmSPUit+cKJJVg0Qx4WIqjFeLzHHhRYRl9x57STIbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0AsK2HxskFAzrwxKGaedVW3R7YOnqGVm9vKOzABR6Z/8f7aF689VmQ4Vq63h/A7gU
         j742iWCHDDBkW2P6pqWdfyqCr/m/XZw/sF0rhUptY/ydsJmLu2zYnmAy3/Anbc3OuH
         28dv9Pi3qIYD6PlRfq7CQl7StgQYMcKCEQcn/9xQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 523/663] clk: mediatek: mt8135: Properly use CLK_IS_CRITICAL flag
Date:   Mon,  8 May 2023 11:45:49 +0200
Message-Id: <20230508094445.807087375@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit f4f9a9c003b52ea3cffda186753bfb3e37b970f8 ]

Instead of calling clk_prepare_enable() for clocks that shall stay
enabled, use the CLK_IS_CRITICAL flag, which purpose is exactly that.

Fixes: a8aede794843 ("clk: mediatek: Add basic clocks for Mediatek MT8135.")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Link: https://lore.kernel.org/r/20230306140543.1813621-52-angelogioacchino.delregno@collabora.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mediatek/clk-mt8135.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 1cbe0958d9cd0..3ea06d2ec2f11 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -2,6 +2,8 @@
 /*
  * Copyright (c) 2014 MediaTek Inc.
  * Author: James Liao <jamesjj.liao@mediatek.com>
+ * Copyright (c) 2023 Collabora, Ltd.
+ *               AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
  */
 
 #include <linux/clk.h>
@@ -390,7 +392,7 @@ static const struct mtk_composite top_muxes[] __initconst = {
 	MUX_GATE(CLK_TOP_GCPU_SEL, "gcpu_sel", gcpu_parents, 0x0164, 24, 3, 31),
 	/* CLK_CFG_9 */
 	MUX_GATE(CLK_TOP_DPI1_SEL, "dpi1_sel", dpi1_parents, 0x0168, 0, 2, 7),
-	MUX_GATE(CLK_TOP_CCI_SEL, "cci_sel", cci_parents, 0x0168, 8, 3, 15),
+	MUX_GATE_FLAGS(CLK_TOP_CCI_SEL, "cci_sel", cci_parents, 0x0168, 8, 3, 15, CLK_IS_CRITICAL),
 	MUX_GATE(CLK_TOP_APLL_SEL, "apll_sel", apll_parents, 0x0168, 16, 3, 23),
 	MUX_GATE(CLK_TOP_HDMIPLL_SEL, "hdmipll_sel", hdmipll_parents, 0x0168, 24, 2, 31),
 };
@@ -404,6 +406,10 @@ static const struct mtk_gate_regs infra_cg_regs = {
 #define GATE_ICG(_id, _name, _parent, _shift)	\
 	GATE_MTK(_id, _name, _parent, &infra_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
+#define GATE_ICG_AO(_id, _name, _parent, _shift)	\
+	GATE_MTK_FLAGS(_id, _name, _parent, &infra_cg_regs, _shift,	\
+		       &mtk_clk_gate_ops_setclr, CLK_IS_CRITICAL)
+
 static const struct mtk_gate infra_clks[] __initconst = {
 	GATE_ICG(CLK_INFRA_PMIC_WRAP, "pmic_wrap_ck", "axi_sel", 23),
 	GATE_ICG(CLK_INFRA_PMICSPI, "pmicspi_ck", "pmicspi_sel", 22),
@@ -411,7 +417,7 @@ static const struct mtk_gate infra_clks[] __initconst = {
 	GATE_ICG(CLK_INFRA_CCIF0_AP_CTRL, "ccif0_ap_ctrl", "axi_sel", 20),
 	GATE_ICG(CLK_INFRA_KP, "kp_ck", "axi_sel", 16),
 	GATE_ICG(CLK_INFRA_CPUM, "cpum_ck", "cpum_tck_in", 15),
-	GATE_ICG(CLK_INFRA_M4U, "m4u_ck", "mem_sel", 8),
+	GATE_ICG_AO(CLK_INFRA_M4U, "m4u_ck", "mem_sel", 8),
 	GATE_ICG(CLK_INFRA_MFGAXI, "mfgaxi_ck", "axi_sel", 7),
 	GATE_ICG(CLK_INFRA_DEVAPC, "devapc_ck", "axi_sel", 6),
 	GATE_ICG(CLK_INFRA_AUDIO, "audio_ck", "aud_intbus_sel", 5),
@@ -533,8 +539,6 @@ static void __init mtk_topckgen_init(struct device_node *node)
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
 			&mt8135_clk_lock, clk_data);
 
-	clk_prepare_enable(clk_data->hws[CLK_TOP_CCI_SEL]->clk);
-
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
@@ -552,8 +556,6 @@ static void __init mtk_infrasys_init(struct device_node *node)
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 						clk_data);
 
-	clk_prepare_enable(clk_data->hws[CLK_INFRA_M4U]->clk);
-
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
-- 
2.39.2



