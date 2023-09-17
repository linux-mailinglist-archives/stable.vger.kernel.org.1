Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7F47A3800
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbjIQTaG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239586AbjIQT3h (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:29:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F84CD9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:29:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE80DC433CB;
        Sun, 17 Sep 2023 19:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978972;
        bh=OyTChRcvK0NQMkw6EtW9y1whvxJLEs92R8Ava2grK2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZrJjt+X6ryhPk9KXBKSND50hoAI5ZpBtvMTkZeTegjwMPaSUt51Njt+H9BRQ+RUQa
         FtTZ5AUoTnYC0UstmDm7szn2UZIMLaH+90SCYNC1sl5ysdOR+Q1jzOaKIkbP3j09DY
         tCLH/mPoYysQjrO9v54ZlsYmA5194JJBiXxEGjpc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan ODonoghue <bryan.odonoghue@linaro.org>,
        Patrick Whewell <patrick.whewell@sightlineapplications.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 177/406] clk: qcom: gcc-sm8250: Fix gcc_sdcc2_apps_clk_src
Date:   Sun, 17 Sep 2023 21:10:31 +0200
Message-ID: <20230917191105.865890874@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrick Whewell <patrick.whewell@sightlineapplications.com>

[ Upstream commit 783cb693828ce487cf0bc6ad16cbcf2caae6f8d9 ]

GPLL9 is not on by default, which causes a "gcc_sdcc2_apps_clk_src: rcg
didn't update its configuration" error when booting. Set .flags =
CLK_OPS_PARENT_ENABLE to fix the error.

Fixes: 3e5770921a88 ("clk: qcom: gcc: Add global clock controller driver for SM8250")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Patrick Whewell <patrick.whewell@sightlineapplications.com>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Link: https://lore.kernel.org/r/20230802210359.408-1-patrick.whewell@sightlineapplications.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-sm8250.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-sm8250.c b/drivers/clk/qcom/gcc-sm8250.c
index 68a31f208d904..70723e4dab008 100644
--- a/drivers/clk/qcom/gcc-sm8250.c
+++ b/drivers/clk/qcom/gcc-sm8250.c
@@ -722,6 +722,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_4,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
+		.flags = CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_rcg2_floor_ops,
 	},
 };
-- 
2.40.1



