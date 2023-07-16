Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E64375537A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjGPUT3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjGPUT2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:19:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF562126
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:19:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6565860EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7213DC433C7;
        Sun, 16 Jul 2023 20:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538766;
        bh=XAn90j28PlqBuotgxphtM4hf5LN+4nlSWCgByg1PUkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uDIqdcJexn+aE8aghM0ik0Osp3UHba4l4cgiEj43gF8JrLJSIsAXmnX6QDlXMYysV
         JklGiT/3TyQDsBYL6Yviymu/L2ugjloN83wH7tMYI2HOBqemkONe3vBV3NV/Kpykzm
         hHnLlmJu5UAwkl2joUtuV2XIpYp4IcCgWcBBKqFM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 561/800] clk: qcom: mmcc-msm8974: remove oxili_ocmemgx_clk
Date:   Sun, 16 Jul 2023 21:46:54 +0200
Message-ID: <20230716195002.119626164@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 853c064b57491d739bfd0cc35ff75c5ea9c5e8f5 ]

After the internal discussions, it looks like this clock is managed by
RPM itself. Linux kernel should not touch it on its own, as this causes
disagreement with RPM. Shutting down this clock causes the OCMEM<->GPU
interface to stop working, resulting in GPU hangchecks/timeouts.

Fixes: d8b212014e69 ("clk: qcom: Add support for MSM8974's multimedia clock controller (MMCC)")
Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230508153319.2371645-1-dmitry.baryshkov@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/mmcc-msm8974.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
index 4273fce9a4a4c..b90a9f362f5f7 100644
--- a/drivers/clk/qcom/mmcc-msm8974.c
+++ b/drivers/clk/qcom/mmcc-msm8974.c
@@ -2204,23 +2204,6 @@ static struct clk_branch ocmemcx_ocmemnoc_clk = {
 	},
 };
 
-static struct clk_branch oxili_ocmemgx_clk = {
-	.halt_reg = 0x402c,
-	.clkr = {
-		.enable_reg = 0x402c,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "oxili_ocmemgx_clk",
-			.parent_data = (const struct clk_parent_data[]){
-				{ .fw_name = "gfx3d_clk_src", .name = "gfx3d_clk_src" },
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch ocmemnoc_clk = {
 	.halt_reg = 0x50b4,
 	.clkr = {
@@ -2512,7 +2495,6 @@ static struct clk_regmap *mmcc_msm8226_clocks[] = {
 	[MMSS_MMSSNOC_AXI_CLK] = &mmss_mmssnoc_axi_clk.clkr,
 	[MMSS_S0_AXI_CLK] = &mmss_s0_axi_clk.clkr,
 	[OCMEMCX_AHB_CLK] = &ocmemcx_ahb_clk.clkr,
-	[OXILI_OCMEMGX_CLK] = &oxili_ocmemgx_clk.clkr,
 	[OXILI_GFX3D_CLK] = &oxili_gfx3d_clk.clkr,
 	[OXILICX_AHB_CLK] = &oxilicx_ahb_clk.clkr,
 	[OXILICX_AXI_CLK] = &oxilicx_axi_clk.clkr,
@@ -2670,7 +2652,6 @@ static struct clk_regmap *mmcc_msm8974_clocks[] = {
 	[MMSS_S0_AXI_CLK] = &mmss_s0_axi_clk.clkr,
 	[OCMEMCX_AHB_CLK] = &ocmemcx_ahb_clk.clkr,
 	[OCMEMCX_OCMEMNOC_CLK] = &ocmemcx_ocmemnoc_clk.clkr,
-	[OXILI_OCMEMGX_CLK] = &oxili_ocmemgx_clk.clkr,
 	[OCMEMNOC_CLK] = &ocmemnoc_clk.clkr,
 	[OXILI_GFX3D_CLK] = &oxili_gfx3d_clk.clkr,
 	[OXILICX_AHB_CLK] = &oxilicx_ahb_clk.clkr,
-- 
2.39.2



