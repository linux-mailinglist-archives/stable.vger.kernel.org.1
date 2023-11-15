Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5C07ECE2A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjKOTlR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjKOTlQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:41:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E223B9E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:41:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB15C433C7;
        Wed, 15 Nov 2023 19:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077273;
        bh=XFj5LeBsG/yBoIEQCjfrDwtrRXgtnei4tjfeAL8DC1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SpgM4LyNkondU8VQCRDacI2ayqsspsa1xMHCQwu5elCS+fuVRhvLJwjE9YkCL6EuF
         KrxLPa4R/8aOg5S/rddizoAmai2eoibX2T/hbKchz0nnLRpDkzk1v2Nf4o4bZ611D8
         xj37Y3wZUfb883T2pbTo1Y2+N9dLssLenv6d0hoc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 184/603] clk: ti: fix double free in of_ti_divider_clk_setup()
Date:   Wed, 15 Nov 2023 14:12:09 -0500
Message-ID: <20231115191625.967570708@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 7af5b9eadd64c9e02a71f97c45bcdf3b64841f6b ]

The "div" pointer is freed in _register_divider() and again in
of_ti_divider_clk_setup().  Delete the free in _register_divider()

Fixes: fbbc18591585 ("clk: ti: divider: cleanup _register_divider and ti_clk_get_div_table")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/6d36eeec-6c8a-4f11-a579-aa3cd7c38749@moroto.mountain
Reviewed-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ti/divider.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index 768a1f3398b47..5d5bb123ba949 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -309,7 +309,6 @@ static struct clk *_register_divider(struct device_node *node,
 				     u32 flags,
 				     struct clk_omap_divider *div)
 {
-	struct clk *clk;
 	struct clk_init_data init;
 	const char *parent_name;
 	const char *name;
@@ -326,12 +325,7 @@ static struct clk *_register_divider(struct device_node *node,
 	div->hw.init = &init;
 
 	/* register the clock */
-	clk = of_ti_clk_register(node, &div->hw, name);
-
-	if (IS_ERR(clk))
-		kfree(div);
-
-	return clk;
+	return of_ti_clk_register(node, &div->hw, name);
 }
 
 int ti_clk_parse_divider_data(int *div_table, int num_dividers, int max_div,
-- 
2.42.0



