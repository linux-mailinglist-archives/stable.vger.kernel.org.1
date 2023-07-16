Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FAB755388
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjGPUUC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjGPUUC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:20:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A66BC0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:20:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19B6760E9D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26194C433C8;
        Sun, 16 Jul 2023 20:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538800;
        bh=hMVz/u0DUiBtT3oW4HAV5m38Z1xFxNT68qkd8kJwots=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZCnmT2VtUCKHHhMjJ0JX4XeIoPJ1yGoQNTFNvKoZ1dgjoFtBhQy6HzI6EFWqXaMnt
         WmxksJvugjfoSb6eS81Dz+K/pkUet2FaTkYJoU2/JESWhx7+lrCdAXnmd7vzQnC9H0
         YYDPFI0MyXRXPWV6wikDofTr5j8CGpPS7FXTZz9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 580/800] clk: qcom: dispcc-qcm2290: Fix GPLL0_OUT_DIV handling
Date:   Sun, 16 Jul 2023 21:47:13 +0200
Message-ID: <20230716195002.556865328@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 63d56adf04b5795e54440dc5b7afddecb2966863 ]

GPLL0_OUT_DIV (.fw_name = "gcc_disp_gpll0_div_clk_src") was previously
made to reuse the same parent enum entry as GPLL0_OUT_MAIN
(.fw_name = "gcc_disp_gpll0_clk_src") in parent_map_2.

Resolve it by introducing its own entry in the parent enum and
correctly assigning it in disp_cc_parent_map_2[].

Fixes: cc517ea3333f ("clk: qcom: Add display clock controller driver for QCM2290")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230412-topic-qcm_dispcc-v2-2-bce7dd512fe4@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/dispcc-qcm2290.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-qcm2290.c b/drivers/clk/qcom/dispcc-qcm2290.c
index ee62aca4e5bb2..44dd5cfcc1504 100644
--- a/drivers/clk/qcom/dispcc-qcm2290.c
+++ b/drivers/clk/qcom/dispcc-qcm2290.c
@@ -28,6 +28,7 @@ enum {
 	P_DISP_CC_PLL0_OUT_MAIN,
 	P_DSI0_PHY_PLL_OUT_BYTECLK,
 	P_DSI0_PHY_PLL_OUT_DSICLK,
+	P_GPLL0_OUT_DIV,
 	P_GPLL0_OUT_MAIN,
 	P_SLEEP_CLK,
 };
@@ -84,7 +85,7 @@ static const struct clk_parent_data disp_cc_parent_data_1[] = {
 
 static const struct parent_map disp_cc_parent_map_2[] = {
 	{ P_BI_TCXO_AO, 0 },
-	{ P_GPLL0_OUT_MAIN, 4 },
+	{ P_GPLL0_OUT_DIV, 4 },
 };
 
 static const struct clk_parent_data disp_cc_parent_data_2[] = {
@@ -153,8 +154,8 @@ static struct clk_regmap_div disp_cc_mdss_byte0_div_clk_src = {
 
 static const struct freq_tbl ftbl_disp_cc_mdss_ahb_clk_src[] = {
 	F(19200000, P_BI_TCXO_AO, 1, 0, 0),
-	F(37500000, P_GPLL0_OUT_MAIN, 8, 0, 0),
-	F(75000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
+	F(37500000, P_GPLL0_OUT_DIV, 8, 0, 0),
+	F(75000000, P_GPLL0_OUT_DIV, 4, 0, 0),
 	{ }
 };
 
-- 
2.39.2



