Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751D7755239
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjGPUFS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjGPUFS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:05:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC459D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:05:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D6A160EA2
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6A5C433C7;
        Sun, 16 Jul 2023 20:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537916;
        bh=mCzF67IMLzGbRzEoXNmbp5j4Wa06crgi6TgOYVWOW68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wru0Zl2/RKUW7iu8F2/Vyx53V43Kc0Woyi569a/H1Vyg9eA+NqKVskOozFB12DwnP
         iQrYQSIhnhlFamLwwAw2F1lk/hQJ1gZdqTFi8nUhpLYFuTL4RxredPmYNiTQMdcuzk
         hsHkWQXYd/07Y8S+ihVE1BLSXW9a3nOdObneqgrY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 266/800] clk: imx: scu: use _safe list iterator to avoid a use after free
Date:   Sun, 16 Jul 2023 21:41:59 +0200
Message-ID: <20230716194955.274807626@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 632c60ecd25dbacee54d5581fe3aeb834b57010a ]

This loop is freeing "clk" so it needs to use list_for_each_entry_safe().
Otherwise it dereferences a freed variable to get the next item on the
loop.

Fixes: 77d8f3068c63 ("clk: imx: scu: add two cells binding support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Link: https://lore.kernel.org/r/0793fbd1-d2b5-4ec2-9403-3c39343a3e2d@kili.mountain
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-scu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 1e6870f3671f6..db307890e4c16 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -707,11 +707,11 @@ struct clk_hw *imx_clk_scu_alloc_dev(const char *name,
 
 void imx_clk_scu_unregister(void)
 {
-	struct imx_scu_clk_node *clk;
+	struct imx_scu_clk_node *clk, *n;
 	int i;
 
 	for (i = 0; i < IMX_SC_R_LAST; i++) {
-		list_for_each_entry(clk, &imx_scu_clks[i], node) {
+		list_for_each_entry_safe(clk, n, &imx_scu_clks[i], node) {
 			clk_hw_unregister(clk->hw);
 			kfree(clk);
 		}
-- 
2.39.2



