Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7B77552B3
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjGPUKx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjGPUKw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:10:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D11C0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:10:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93B2460E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35E0C433C8;
        Sun, 16 Jul 2023 20:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538251;
        bh=V1aIh/4uBNdWElqBuGBZI+ZpWsYxEObAmq2KGrIKBwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VaKTeykkW/XQGcFAAnotJlhlz1g4w7CuJ/KywGdHHc7w+33R60RrpJE7JndCd0dqn
         f29r+GbWrowWVN/wha6nadtD8C6myG6oKBqxwSXP11zZTzLYTJTMC3fWGN/gl0IhZi
         jepNIj1+Sz4W8CIFyivJDFVUIe9Uu9wNzBKlwHnE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bosi Zhang <u201911157@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 383/800] clk: mediatek: fix of_iomap memory leak
Date:   Sun, 16 Jul 2023 21:43:56 +0200
Message-ID: <20230716194957.971100651@linuxfoundation.org>
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

From: Bosi Zhang <u201911157@hust.edu.cn>

[ Upstream commit 3db7285e044144fd88a356f5b641b9cd4b231a77 ]

Smatch reports:
drivers/clk/mediatek/clk-mtk.c:583 mtk_clk_simple_probe() warn:
    'base' from of_iomap() not released on lines: 496.

This problem was also found in linux-next. In mtk_clk_simple_probe(),
base is not released when handling errors
if clk_data is not existed, which may cause a leak.
So free_base should be added here to release base.

Fixes: c58cd0e40ffa ("clk: mediatek: Add mtk_clk_simple_probe() to simplify clock providers")
Signed-off-by: Bosi Zhang <u201911157@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Link: https://lore.kernel.org/r/20230422084331.47198-1-u201911157@hust.edu.cn
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mediatek/clk-mtk.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index fd2214c3242f2..3c50f48e93a7b 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -500,8 +500,10 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 	num_clks += mcd->num_mux_clks + mcd->num_divider_clks;
 
 	clk_data = mtk_alloc_clk_data(num_clks);
-	if (!clk_data)
-		return -ENOMEM;
+	if (!clk_data) {
+		r = -ENOMEM;
+		goto free_base;
+	}
 
 	if (mcd->fixed_clks) {
 		r = mtk_clk_register_fixed_clks(mcd->fixed_clks,
@@ -599,6 +601,7 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 					      mcd->num_fixed_clks, clk_data);
 free_data:
 	mtk_free_clk_data(clk_data);
+free_base:
 	if (mcd->shared_io && base)
 		iounmap(base);
 	return r;
-- 
2.39.2



