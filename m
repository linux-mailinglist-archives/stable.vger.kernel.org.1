Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0374F7ECBAD
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjKOTXq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjKOTXp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:23:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC0A1A5
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:23:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6A5C433CA;
        Wed, 15 Nov 2023 19:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076221;
        bh=+zcZIR1Re97GozRCr1svH+c/peIairX9tGFAg8XGwdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wTfVlb7cGp5G8X06LnpYGSdec/O6ZVZLBZ188qLSDAcBpyAJDlnI9Ybo106jz8HbK
         DhMhAuQe70f+RieaGCWOgdy8h+XLKDAVC1VwOZXOJuFFZ69mddbIyj2MGIN92f92i2
         a1bgkVStpwgIgBfVEdGTzclVwjpM0TA/e8AhuNII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 153/550] clk: qcom: ipq5332: Drop set rate parent from gpll0 dependent clocks
Date:   Wed, 15 Nov 2023 14:12:17 -0500
Message-ID: <20231115191611.311138721@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Varadarajan Narayanan <quic_varada@quicinc.com>

[ Upstream commit ccd8ab030643040600a663edde56b434b6f4fb6c ]

IPQ5332's GPLL0's nominal/turbo frequency is 800MHz.
This must not be scaled based on the requirement of
dependent clocks. Hence remove the CLK_SET_RATE_PARENT
flag.

Fixes: 3d89d52970fd ("clk: qcom: add Global Clock controller (GCC) driver for IPQ5332 SoC")
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Reviewed-by: Kathiravan T <quic_kathirav@quicinc.com>
Link: https://lore.kernel.org/r/1693474133-10467-1-git-send-email-quic_varada@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-ipq5332.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index a75ab88ed14c6..1077d03cefe5b 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -70,7 +70,6 @@ static struct clk_fixed_factor gpll0_div2 = {
 				&gpll0_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_fixed_factor_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -84,7 +83,6 @@ static struct clk_alpha_pll_postdiv gpll0 = {
 				&gpll0_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
-- 
2.42.0



