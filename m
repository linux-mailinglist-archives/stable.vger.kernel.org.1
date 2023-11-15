Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5F67ED1AC
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbjKOUE0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344260AbjKOUE0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:04:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AF092
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:04:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B93C433C8;
        Wed, 15 Nov 2023 20:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078662;
        bh=43HnX4Nj7M+jZQtO6prwyS/n7GWhbYA5twGoWE6DOwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w6pTFYfojsCy1rQhXjQG3PUCBkUEnEjojSP9kGyeQ10pcorVKvE/7T3odHrQ/+1kh
         ps1fZqEyPmWYRZhT0mqZ0qHupJ674ZkGE//Qx3PrGJiDOXup2OG9ThykDKvAqouKxT
         LnV44qHIUlYq01Tlmmx0ugVug/mOvf+axHaN9pKo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 09/45] clk: keystone: pll: fix a couple NULL vs IS_ERR() checks
Date:   Wed, 15 Nov 2023 14:32:46 -0500
Message-ID: <20231115191420.220727107@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191419.641552204@linuxfoundation.org>
References: <20231115191419.641552204@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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



