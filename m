Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AD275563C
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbjGPUtG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjGPUs5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:48:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D549E6D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:48:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C374360EBD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29CFC433C7;
        Sun, 16 Jul 2023 20:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540518;
        bh=iZtEMpetjq9RvHLXlACO4Mf0j3utTALl6hRW+zLAfnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EDu51uy884QapTNmLxuUymWJmbGDnMq9b4PEkFULxzPsfqkqr2rEdarotBfnS+k5b
         YEXATmYVCfCqKvKs8nBRddRTXs+xaKv+4GHMoi9kJcvyw96vm3XdGhxFGPPfCp6st9
         Lr/K9oPsYY99bzgyLlhoOpQk4JV4vu5mY+kH2SKc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Taniya Das <quic_tdas@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bryan ODonoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 391/591] clk: qcom: camcc-sc7180: Add parent dependency to all camera GDSCs
Date:   Sun, 16 Jul 2023 21:48:50 +0200
Message-ID: <20230716194934.031956068@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Taniya Das <quic_tdas@quicinc.com>

[ Upstream commit 3e4d179532423f299554cd0dedabdd9d2fdd238d ]

Camera titan top GDSC is a parent supply to all other camera GDSCs. Titan
top GDSC is required to be enabled before enabling any other camera GDSCs
and it should be disabled only after all other camera GDSCs are disabled.
Ensure this behavior by marking titan top GDSC as parent of all other
camera GDSCs.

Fixes: 15d09e830bbc ("clk: qcom: camcc: Add camera clock controller driver for SC7180")
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230501142932.13049-1-quic_tdas@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/camcc-sc7180.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/qcom/camcc-sc7180.c b/drivers/clk/qcom/camcc-sc7180.c
index e2b4804695f37..8a4ba7a19ed12 100644
--- a/drivers/clk/qcom/camcc-sc7180.c
+++ b/drivers/clk/qcom/camcc-sc7180.c
@@ -1480,12 +1480,21 @@ static struct clk_branch cam_cc_sys_tmr_clk = {
 	},
 };
 
+static struct gdsc titan_top_gdsc = {
+	.gdscr = 0xb134,
+	.pd = {
+		.name = "titan_top_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
 static struct gdsc bps_gdsc = {
 	.gdscr = 0x6004,
 	.pd = {
 		.name = "bps_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &titan_top_gdsc.pd,
 	.flags = HW_CTRL,
 };
 
@@ -1495,6 +1504,7 @@ static struct gdsc ife_0_gdsc = {
 		.name = "ife_0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &titan_top_gdsc.pd,
 };
 
 static struct gdsc ife_1_gdsc = {
@@ -1503,6 +1513,7 @@ static struct gdsc ife_1_gdsc = {
 		.name = "ife_1_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &titan_top_gdsc.pd,
 };
 
 static struct gdsc ipe_0_gdsc = {
@@ -1512,15 +1523,9 @@ static struct gdsc ipe_0_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = HW_CTRL,
+	.parent = &titan_top_gdsc.pd,
 };
 
-static struct gdsc titan_top_gdsc = {
-	.gdscr = 0xb134,
-	.pd = {
-		.name = "titan_top_gdsc",
-	},
-	.pwrsts = PWRSTS_OFF_ON,
-};
 
 static struct clk_hw *cam_cc_sc7180_hws[] = {
 	[CAM_CC_PLL2_OUT_EARLY] = &cam_cc_pll2_out_early.hw,
-- 
2.39.2



