Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208167552D2
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjGPUMV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjGPUMU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:12:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D9F90
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:12:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45DAA60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A48C433C9;
        Sun, 16 Jul 2023 20:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538338;
        bh=+m9bvWEQPAGLwKZF/Wcbhzo/GlF94TIOApA2HLekngU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dxhq5wys64oYvynFZpL2Kn/IJU5veaPlhtj7KJP/N4vep4gf8Pt9j1yOBhxMUW/ic
         qk6eN4rBa8SUtiGQB4bZy5SSnLdWctOrhxypOfLgugsa8hL/ziOhZB1/gFLgAwB7Q2
         B6c7NBRFj2OoV4dH1qlGV/tNff/HlViQ+or4LKHE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 415/800] clk: mediatek: clk-mt8173-apmixedsys: Fix iomap not released issue
Date:   Sun, 16 Jul 2023 21:44:28 +0200
Message-ID: <20230716194958.726971259@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit b270ae61730e0ebccee39a21dd3311d6896a38ae ]

In case of error after of_ioremap() the resource must be released:
call iounmap() where appropriate to fix that.

Fixes: 41138fbf876c ("clk: mediatek: mt8173: Migrate to platform driver and common probe")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20230615122051.546985-4-angelogioacchino.delregno@collabora.com
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
index c7adcfcc12e27..307c24aa1fb41 100644
--- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
@@ -151,8 +151,10 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
-	if (IS_ERR_OR_NULL(clk_data))
+	if (IS_ERR_OR_NULL(clk_data)) {
+		iounmap(base);
 		return -ENOMEM;
+	}
 
 	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
 	r = mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
@@ -186,6 +188,7 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
 				  ARRAY_SIZE(pllfhs), clk_data);
 free_clk_data:
 	mtk_free_clk_data(clk_data);
+	iounmap(base);
 	return r;
 }
 
-- 
2.39.2



