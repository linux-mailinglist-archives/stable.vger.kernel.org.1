Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D1B7ED2AB
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjKOUm4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjKOTlI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:41:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D7BB9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:41:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67714C433CB;
        Wed, 15 Nov 2023 19:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077265;
        bh=90cg2F85DS4xTWW5miLxsCtoXXfskhBU0R2rZl9ZnS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UFAxMzSGwkgdKHuo5ibDqpQ3wdR6Qo0xTL2sjCStSK0jM1dmtyh0iXUeIXo14SL/8
         zaxeA/UDw4ZDSqybE4l6amINhku6v4FLPDpnqGOp9mYy20km//8d/8VQ0arJEgv1JW
         r6J8HkhPBZY/0g6JjddAR6cUV0709lO88W0QoG0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 197/603] clk: qcom: ipq9574: drop the CLK_SET_RATE_PARENT flag from GPLL clocks
Date:   Wed, 15 Nov 2023 14:12:22 -0500
Message-ID: <20231115191626.890628864@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>

[ Upstream commit 99a8f8764b70158a712992640a6be46a8fd79d15 ]

GPLL clock rates are fixed and shouldn't be scaled based on the request
from dependent clocks. Doing so will result in the unexpected behaviour.
So drop the CLK_SET_RATE_PARENT flag from the GPLL clocks.

----
Changes in V2:
	- No changes

Fixes: d75b82cff488 ("clk: qcom: Add Global Clock Controller driver for IPQ9574")
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230913-gpll_cleanup-v2-4-c8ceb1a37680@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-ipq9574.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index 8f430367299e6..e8190108e1aef 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -87,7 +87,6 @@ static struct clk_fixed_factor gpll0_out_main_div2 = {
 			&gpll0_main.clkr.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_fixed_factor_ops,
 	},
 };
@@ -102,7 +101,6 @@ static struct clk_alpha_pll_postdiv gpll0 = {
 			&gpll0_main.clkr.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
 	},
 };
@@ -132,7 +130,6 @@ static struct clk_alpha_pll_postdiv gpll4 = {
 			&gpll4_main.clkr.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
 	},
 };
@@ -162,7 +159,6 @@ static struct clk_alpha_pll_postdiv gpll2 = {
 			&gpll2_main.clkr.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
 	},
 };
-- 
2.42.0



