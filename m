Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2F47ED2EB
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjKOUpI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbjKOUpE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:45:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6D2A1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:45:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410ABC433C9;
        Wed, 15 Nov 2023 20:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081100;
        bh=wj6k97fiFFNcM62uGwytbJ8C5ZMPLyKRXadCrA5Vo2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itNSJVzLptB8Hxfmp5awbSl24b7QQBrcvN+K6o9Z9a97ItrVjmQJX0R3qGzloPUg/
         rFdaXNIR1xlzXXxnjQtZ8wY2P9B8tGsmo87Q0B4cCq1skGs2KVaG2tJPDClqv83FbW
         8jKRAKVizkyq9sAnUw7xahIxtKv4UCsZAfcXmIIQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 21/88] clk: keystone: pll: fix a couple NULL vs IS_ERR() checks
Date:   Wed, 15 Nov 2023 15:35:33 -0500
Message-ID: <20231115191427.458822273@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191426.221330369@linuxfoundation.org>
References: <20231115191426.221330369@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit a5d14f8b551eb1551c10053653ee8e27f19672fa ]

The clk_register_divider() and clk_register_mux() functions returns
error pointers on error but this code checks for NULL.  Fix that.

Fixes: b9e0d40c0d83 ("clk: keystone: add Keystone PLL clock driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/d9da4c97-0da9-499f-9a21-1f8e3f148dc1@moroto.mountain
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/keystone/pll.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/keystone/pll.c b/drivers/clk/keystone/pll.c
index 526694c2a6c97..a75ece5992394 100644
--- a/drivers/clk/keystone/pll.c
+++ b/drivers/clk/keystone/pll.c
@@ -285,12 +285,13 @@ static void __init of_pll_div_clk_init(struct device_node *node)
 
 	clk = clk_register_divider(NULL, clk_name, parent_name, 0, reg, shift,
 				 mask, 0, NULL);
-	if (clk) {
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-	} else {
+	if (IS_ERR(clk)) {
 		pr_err("%s: error registering divider %s\n", __func__, clk_name);
 		iounmap(reg);
+		return;
 	}
+
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
 }
 CLK_OF_DECLARE(pll_divider_clock, "ti,keystone,pll-divider-clock", of_pll_div_clk_init);
 
@@ -332,9 +333,11 @@ static void __init of_pll_mux_clk_init(struct device_node *node)
 	clk = clk_register_mux(NULL, clk_name, (const char **)&parents,
 				ARRAY_SIZE(parents) , 0, reg, shift, mask,
 				0, NULL);
-	if (clk)
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-	else
+	if (IS_ERR(clk)) {
 		pr_err("%s: error registering mux %s\n", __func__, clk_name);
+		return;
+	}
+
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
 }
 CLK_OF_DECLARE(pll_mux_clock, "ti,keystone,pll-mux-clock", of_pll_mux_clk_init);
-- 
2.42.0



