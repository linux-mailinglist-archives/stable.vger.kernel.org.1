Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CA77552B0
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjGPUKr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjGPUKr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:10:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13983FD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:10:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B5FE60E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58968C433C8;
        Sun, 16 Jul 2023 20:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538242;
        bh=aGLB9fTFXhPlTP2UmPn6OU4wIC/bJYMGi5N8HJQwZjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MQcSyzp0SDjTWcRU8dIBvTDNnBAz0YzpI5pUoM6ksmAP2Mj+10VoBIU4fPjIYs929
         F9ojXv/sJttFtiGDzVEYwhPmjZuksA2wCRubIcjtlg5XRhXL7D4zxVenC5YHNrdrrl
         LumRGO5pri3I+ceLGoE3SkWYExp+69xTfOdqiaz8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hao Luo <m202171776@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, Peng Fan <peng.fan@nxp.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 380/800] clk: imx: clk-imx8mn: fix memory leak in imx8mn_clocks_probe
Date:   Sun, 16 Jul 2023 21:43:53 +0200
Message-ID: <20230716194957.901693352@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hao Luo <m202171776@hust.edu.cn>

[ Upstream commit 188d070de9132667956f5aadd98d2bd87d3eac89 ]

Use devm_of_iomap() instead of of_iomap() to automatically handle
the unused ioremap region.

If any error occurs, regions allocated by kzalloc() will leak,
but using devm_kzalloc() instead will automatically free the memory
using devm_kfree().

Fixes: daeb14545514 ("clk: imx: imx8mn: Switch to clk_hw based API")
Fixes: 96d6392b54db ("clk: imx: Add support for i.MX8MN clock driver")
Signed-off-by: Hao Luo <m202171776@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/20230411015107.2645-1-m202171776@hust.edu.cn
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx8mn.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 4b23a46486004..4bd1ed11353b3 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -323,7 +323,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int ret;
 
-	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
 					  IMX8MN_CLK_END), GFP_KERNEL);
 	if (WARN_ON(!clk_hw_data))
 		return -ENOMEM;
@@ -340,10 +340,10 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_CLK_EXT4] = imx_get_clk_hw_by_name(np, "clk_ext4");
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mn-anatop");
-	base = of_iomap(np, 0);
+	base = devm_of_iomap(dev, np, 0, NULL);
 	of_node_put(np);
-	if (WARN_ON(!base)) {
-		ret = -ENOMEM;
+	if (WARN_ON(IS_ERR(base))) {
+		ret = PTR_ERR(base);
 		goto unregister_hws;
 	}
 
-- 
2.39.2



