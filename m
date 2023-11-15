Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBEF7ED69D
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343761AbjKOWCb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343795AbjKOWCa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:02:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CD71B6
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:02:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AC6C433C7;
        Wed, 15 Nov 2023 22:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700085746;
        bh=ZX8dZ/yme8nh//R79DXrq0/1tS/ksbnRLlFR4kXQZi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K84jl2suosN3CMfgWiM1rx4cJoS4B8qGcqq4xCTz0jM8eE7I+KTIO/kSJ9OcypFcT
         AYEAuWYfQs7wkrkEAoko8IZUjE7ah2r1tyiGWswMvKA6/b06I1MGwH0eD23hxw0XdJ
         zACXQyaDAazA38ggsp6DooRs0VOSId7rIKo/0u1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arseniy Velikanov <adomerlee@gmail.com>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 026/119] clk: qcom: gcc-sm8150: Fix gcc_sdcc2_apps_clk_src
Date:   Wed, 15 Nov 2023 17:00:16 -0500
Message-ID: <20231115220133.441074493@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
References: <20231115220132.607437515@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Danila Tikhonov <danila@jiaxyga.com>

[ Upstream commit 7138c244fb293f24ce8ab782961022eff00a10c4 ]

Set .flags = CLK_OPS_PARENT_ENABLE to fix "gcc_sdcc2_apps_clk_src: rcg
didn't update its configuration" error.

Fixes: 2a1d7eb854bb ("clk: qcom: gcc: Add global clock controller driver for SM8150")
Tested-by: Arseniy Velikanov <adomerlee@gmail.com>
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230913175612.8685-1-danila@jiaxyga.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-sm8150.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
index f18502cdc46e0..68ea6a846a154 100644
--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -801,7 +801,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parents_6,
 		.num_parents = ARRAY_SIZE(gcc_parents_6),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_rcg2_floor_ops,
 	},
 };
-- 
2.42.0



