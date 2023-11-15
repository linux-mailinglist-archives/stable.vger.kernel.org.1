Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FDC7ECE2F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbjKOTlZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbjKOTlY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:41:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDD4B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:41:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FADC433C7;
        Wed, 15 Nov 2023 19:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077281;
        bh=UXdzNbYoK8FiFqvXrZPhSXIhHcnecqfmuw8qzCv17tM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oje2ve52IuzO9oj0y47Uq3d73Ju7Vpxj3gxI37U5nAHPffI66hv7lLL+jRYUDzHkY
         3mtM70AZxcu5QaATn+54bGRKc9UdBqBSGsc1LpUqqcC5Wnw7mRZvhe5nrW3ZAiIBn+
         7ZQkf/+VTvqXgPgyIrosM71aZm0GOig8OZlH/jGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 186/603] clk: mediatek: clk-mt6765: Add check for mtk_alloc_clk_data
Date:   Wed, 15 Nov 2023 14:12:11 -0500
Message-ID: <20231115191626.119111831@linuxfoundation.org>
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

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit b82681042724924ae3ba0f2f2eeec217fa31e830 ]

Add the check for the return value of mtk_alloc_clk_data() in order to
avoid NULL pointer dereference.

Fixes: 1aca9939bf72 ("clk: mediatek: Add MT6765 clock support")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Link: https://lore.kernel.org/r/20230912093407.21505-1-jiasheng@iscas.ac.cn
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mediatek/clk-mt6765.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index 1f4c8d0c041ab..9c7f7407d7980 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -737,6 +737,8 @@ static int clk_mt6765_apmixed_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
@@ -769,6 +771,8 @@ static int clk_mt6765_top_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks),
 				    clk_data);
@@ -807,6 +811,8 @@ static int clk_mt6765_ifr_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_IFR_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_gates(&pdev->dev, node, ifr_clks,
 			       ARRAY_SIZE(ifr_clks), clk_data);
-- 
2.42.0



