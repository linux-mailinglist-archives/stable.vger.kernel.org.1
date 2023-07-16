Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96CB75538B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjGPUUL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjGPUUK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:20:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5C3C0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:20:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58E3360E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6621EC433C7;
        Sun, 16 Jul 2023 20:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538808;
        bh=psNUI6KgNChWI587a5OvaWvBZ/4JoIIHQaGUOcAZTKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CRpkEJtm9CEctuwxeAZycIMIGAq/FRGUvMDe+0jScH7lPyjztR3viWHiN6T8R32vH
         qbSbZlbMZKb7BX3AJA6jVcBa+aJX+V24cVNu6w/m9gbsYVYzZMabVNIIQXbIh44PA5
         zYLtaQLjsNIDPrlCHWmrfSQE/mGe/4+kOlbc5DDE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 583/800] clk: qcom: mmcc-msm8974: use clk_rcg2_shared_ops for mdp_clk_src clock
Date:   Sun, 16 Jul 2023 21:47:16 +0200
Message-ID: <20230716195002.627512489@linuxfoundation.org>
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

[ Upstream commit 8fd492e77ff71f68f7311c22f7bc960182465cd7 ]

The mdp_clk_src clock should not be turned off. Instead it should be
'parked' to the XO, as most of other mdp_clk_src clocks. Fix that by
using the clk_rcg2_shared_ops.

Fixes: d8b212014e69 ("clk: qcom: Add support for MSM8974's multimedia clock controller (MMCC)")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Luca Weiss <luca@z3ntu.xyz>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230507175335.2321503-1-dmitry.baryshkov@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/mmcc-msm8974.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
index b90a9f362f5f7..d2fec5d5b22e2 100644
--- a/drivers/clk/qcom/mmcc-msm8974.c
+++ b/drivers/clk/qcom/mmcc-msm8974.c
@@ -485,7 +485,7 @@ static struct clk_rcg2 mdp_clk_src = {
 		.name = "mdp_clk_src",
 		.parent_data = mmcc_xo_mmpll0_dsi_hdmi_gpll0,
 		.num_parents = ARRAY_SIZE(mmcc_xo_mmpll0_dsi_hdmi_gpll0),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
-- 
2.39.2



