Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BBC7ED3BA
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjKOUy0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbjKOUyU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:54:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2785AD73
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:54:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CE4C4E778;
        Wed, 15 Nov 2023 20:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081652;
        bh=rzAna7fHfVvZbaIz/Bps1OT+3emFv8sMUtdYfokLJnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N28bnI8/K088bowSbKuDJ0DkRZVzg7AaJyXP7sLVjoHBeBcOG95xBvDQD7Q2hitXI
         CGKKDKYJlG52x2eO1nT7VMnFyznRsaH3PSN4DW3MqVLs04Obod2A/e8kwmTB7LHKl9
         apx5Z8dt787LMPTKhxGptXw2uAoTY1LoMGRR1POE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 040/191] clk: qcom: mmcc-msm8998: Set bimc_smmu_gdsc always on
Date:   Wed, 15 Nov 2023 15:45:15 -0500
Message-ID: <20231115204646.968341976@linuxfoundation.org>
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

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

[ Upstream commit 68e1d106eb4dceb61bc2818d829786b364fd502b ]

This GDSC enables (or cuts!) power to the Multimedia Subsystem IOMMU
(mmss smmu), which has bootloader pre-set secure contexts.
In the event of a complete power loss, the secure contexts will be
reset and the hypervisor will crash the SoC.

To prevent this, and get a working multimedia subsystem, set this
GDSC as always on.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Link: https://lore.kernel.org/r/20210114221059.483390-10-angelogioacchino.delregno@somainline.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Stable-dep-of: 1fc62c834739 ("clk: qcom: mmcc-msm8998: Fix the SMMU GDSC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/mmcc-msm8998.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/mmcc-msm8998.c b/drivers/clk/qcom/mmcc-msm8998.c
index c0bdefcbb2946..8768cdcf0aa3c 100644
--- a/drivers/clk/qcom/mmcc-msm8998.c
+++ b/drivers/clk/qcom/mmcc-msm8998.c
@@ -2666,7 +2666,7 @@ static struct gdsc bimc_smmu_gdsc = {
 		.name = "bimc_smmu",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL,
+	.flags = HW_CTRL | ALWAYS_ON,
 };
 
 static struct clk_regmap *mmcc_msm8998_clocks[] = {
-- 
2.42.0



