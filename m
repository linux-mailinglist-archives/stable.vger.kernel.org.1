Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4739875D267
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjGUS7N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjGUS7M (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:59:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E9130D7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:59:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9F1F61D7C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC923C433C8;
        Fri, 21 Jul 2023 18:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965950;
        bh=Z+HrDnWT/2OH/UnVyH76qWqsJ6YzRFJjkmKUluTmfcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0UFcQAR/ydPN5ZmD6OsPFvc0DZbTOOL1dOnUfZLQ3d2lrUQFg0vq1gSijDgxF2I5S
         h4UEonOP1oI31WKL2TIkTPhhntN+o7Hd/hQ7EN8cle0LCAiHelElUjcXQUsX25fVyt
         iR5Kp87NyNNOzExOV2Y/rYJBKYYepyneisownBHE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuxing Liu <lyx2022@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 172/532] clk: imx: clk-imx8mp: improve error handling in imx8mp_clocks_probe()
Date:   Fri, 21 Jul 2023 18:01:16 +0200
Message-ID: <20230721160623.728953373@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yuxing Liu <lyx2022@hust.edu.cn>

[ Upstream commit 878b02d5f3b56cb090dbe2c70c89273be144087f ]

Replace of_iomap() and kzalloc() with devm_of_iomap() and devm_kzalloc()
which can automatically release the related memory when the device
or driver is removed or unloaded to avoid potential memory leak.

In this case, iounmap(anatop_base) in line 427,433 are removed
as manual release is not required.

Besides, referring to clk-imx8mq.c, check the return code of
of_clk_add_hw_provider, if it returns negtive, print error info
and unregister hws, which makes the program more robust.

Fixes: 9c140d992676 ("clk: imx: Add support for i.MX8MP clock driver")
Signed-off-by: Yuxing Liu <lyx2022@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Link: https://lore.kernel.org/r/20230503070607.2462-1-lyx2022@hust.edu.cn
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx8mp.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index b173c30093946..0191457fb3cfc 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -407,25 +407,22 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np;
 	void __iomem *anatop_base, *ccm_base;
+	int err;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mp-anatop");
-	anatop_base = of_iomap(np, 0);
+	anatop_base = devm_of_iomap(dev, np, 0, NULL);
 	of_node_put(np);
-	if (WARN_ON(!anatop_base))
-		return -ENOMEM;
+	if (WARN_ON(IS_ERR(anatop_base)))
+		return PTR_ERR(anatop_base);
 
 	np = dev->of_node;
 	ccm_base = devm_platform_ioremap_resource(pdev, 0);
-	if (WARN_ON(IS_ERR(ccm_base))) {
-		iounmap(anatop_base);
+	if (WARN_ON(IS_ERR(ccm_base)))
 		return PTR_ERR(ccm_base);
-	}
 
-	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws, IMX8MP_CLK_END), GFP_KERNEL);
-	if (WARN_ON(!clk_hw_data)) {
-		iounmap(anatop_base);
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, IMX8MP_CLK_END), GFP_KERNEL);
+	if (WARN_ON(!clk_hw_data))
 		return -ENOMEM;
-	}
 
 	clk_hw_data->num = IMX8MP_CLK_END;
 	hws = clk_hw_data->hws;
@@ -710,7 +707,12 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	imx_check_clk_hws(hws, IMX8MP_CLK_END);
 
-	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
+	err = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
+	if (err < 0) {
+		dev_err(dev, "failed to register hws for i.MX8MP\n");
+		imx_unregister_hw_clocks(hws, IMX8MP_CLK_END);
+		return err;
+	}
 
 	imx_register_uart_clocks(4);
 
-- 
2.39.2



