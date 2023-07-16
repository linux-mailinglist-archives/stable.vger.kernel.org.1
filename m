Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2657552D0
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjGPUMP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjGPUMO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:12:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E1190
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:12:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB5E560EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8765C433C7;
        Sun, 16 Jul 2023 20:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538333;
        bh=WtZMSZavogw1qLmzFJ8c7eR7mUYPIH7mNgbUM/eN0Fo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QglPmHH+Ae3hQv0rVa14lt6KL+fQ4GSFzTpbVx3ozA5imgJPNOEPv8YTrbq9Yzx6U
         iKLrTQ+ogf2FRp4hxHkC2JDu9VfaFai9w0fe+JQW9ZC5X7WQXrx4Tra/1Q1iO8gW4f
         1eBcHXEQE0ZodBNiQ55UIelo+AJ/yN+dRKEXQqHA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 413/800] clk: mediatek: clk-mtk: Grab iomem pointer for divider clocks
Date:   Sun, 16 Jul 2023 21:44:26 +0200
Message-ID: <20230716194958.678849899@linuxfoundation.org>
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

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit 51821765e89906090753421580a61d25a4668186 ]

In the rare case in which one of the clock drivers has divider clocks
but not composite clocks, mtk_clk_simple_probe() would not io(re)map,
hence passing a NULL pointer to mtk_clk_register_dividers().

To fix this issue, extend the `if` conditional to also check if any
divider clocks are present. While at it, also make sure the iomem
pointer is NULL if no composite/divider clocks are declared, as we
are checking for that when iounmapping it in the error path.

This hasn't been seen on any MediaTek clock driver as the current ones
always declare composite clocks along with divider clocks, but this is
still an important fix for a future potential KP.

Fixes: 1fe074b1f112 ("clk: mediatek: Add divider clocks to mtk_clk_simple_{probe,remove}()")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20230615122051.546985-2-angelogioacchino.delregno@collabora.com
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mediatek/clk-mtk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 3c50f48e93a7b..affaf52c82bd4 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -469,7 +469,7 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 	const struct platform_device_id *id;
 	const struct mtk_clk_desc *mcd;
 	struct clk_hw_onecell_data *clk_data;
-	void __iomem *base;
+	void __iomem *base = NULL;
 	int num_clks, r;
 
 	mcd = device_get_match_data(&pdev->dev);
@@ -483,8 +483,8 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 			return -EINVAL;
 	}
 
-	/* Composite clocks needs us to pass iomem pointer */
-	if (mcd->composite_clks) {
+	/* Composite and divider clocks needs us to pass iomem pointer */
+	if (mcd->composite_clks || mcd->divider_clks) {
 		if (!mcd->shared_io)
 			base = devm_platform_ioremap_resource(pdev, 0);
 		else
-- 
2.39.2



