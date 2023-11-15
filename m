Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381D87ECBCB
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjKOTYc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjKOTYb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:24:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459AA12C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:24:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D428C433C9;
        Wed, 15 Nov 2023 19:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076267;
        bh=zs+fsk/04UpO9kRwf5jaIyZKhofjQ3GdOJ2peZjcNP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nLBOirfmDDD0hI+lswsXYQwvaPVd2hmy4N+pwgRKuwts3rNSnd849DQrYIU2AUmaj
         9sj643s7+x4yT+QWKkM6dM9b48zmD3mHSVhn0FyvD2Asg7miFAGf2O9ChOwLEYcTCR
         jVIQY4WjPY9yIuM82CzLgmDvosFqQOlqCW08ydV8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 183/550] clk: qcom: apss-ipq-pll: Use stromer plus ops for stromer plus pll
Date:   Wed, 15 Nov 2023 14:12:47 -0500
Message-ID: <20231115191613.410198898@linuxfoundation.org>
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

[ Upstream commit 267e29198436a8cb6770213471f72502c895096a ]

The set rate and determine rate operations are different between
Stromer and Stromer Plus PLLs. Since the programming sequence is
different, the PLLs dont get configured properly and random,
inexplicable crash/freeze is seen. Hence, use stromer plus ops
for ipq_pll_stromer_plus.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Fixes: c7ef7fbb1ccf ("clk: qcom: apss-ipq-pll: add support for IPQ5332")
Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Link: https://lore.kernel.org/r/c86ecaa23dc4f39650bcf4a3bd54a617a932e4fd.1697781921.git.quic_varada@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/apss-ipq-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index ce28d882ee785..f44be99999ec0 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -68,7 +68,7 @@ static struct clk_alpha_pll ipq_pll_stromer_plus = {
 				.fw_name = "xo",
 			},
 			.num_parents = 1,
-			.ops = &clk_alpha_pll_stromer_ops,
+			.ops = &clk_alpha_pll_stromer_plus_ops,
 		},
 	},
 };
-- 
2.42.0



