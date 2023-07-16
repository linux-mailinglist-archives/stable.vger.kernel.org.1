Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F32755674
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjGPUuk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjGPUuk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:50:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB9CD9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09C9360DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E39C433C7;
        Sun, 16 Jul 2023 20:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540638;
        bh=2wbe0hGX14Fm2Tn8K1uRdJrIlrXJFve5ZTWq9eaZbhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BcP0ZlZ7rdVkHs7oBgBTqizyhIYQ6yC/UCkvtvbX6aKLv7exbo8uatRAjr6sd0zd1
         +BuiUPvjwWk67iGopHCN+fytOtzAGeqRyStcCFGKrS3wqQ3IsvT3671dmcP4olUjtP
         3+xc3KOlNiU9uPpeVifZ9Im80DhZ6R/5W+LEeVGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 407/591] clk: qcom: mmcc-msm8974: use clk_rcg2_shared_ops for mdp_clk_src clock
Date:   Sun, 16 Jul 2023 21:49:06 +0200
Message-ID: <20230716194934.444142181@linuxfoundation.org>
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
 drivers/clk/qcom/mmcc-msm8974.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/qcom/mmcc-msm8974.c
+++ b/drivers/clk/qcom/mmcc-msm8974.c
@@ -473,7 +473,7 @@ static struct clk_rcg2 mdp_clk_src = {
 		.name = "mdp_clk_src",
 		.parent_names = mmcc_xo_mmpll0_dsi_hdmi_gpll0,
 		.num_parents = 6,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 


