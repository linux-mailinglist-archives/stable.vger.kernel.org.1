Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BB774C361
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjGILcE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbjGILcB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:32:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22CCE4D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:31:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF90760BEC
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD88CC433C7;
        Sun,  9 Jul 2023 11:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902283;
        bh=pkTyLnTXoNNImM0BC9ZLSeogMBrGkxl1xXEMvkA8rJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UDGVddiIhpUFPg+N5Ol8l8BsX5rkS3I2HBQ12sGijrK4Qi+ZDTKR5a/kaYkmTmSTs
         hivWGjQM99c9e3ExwM7IyEI2/u0LmoC1TwvnYb0C+KOuxWBOZc9zSQtf1vb+RAD33x
         LkA+TEoqiwctt47QAH45oL1jVsxXZd58ynxAMN20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 321/431] clk: vc5: check memory returned by kasprintf()
Date:   Sun,  9 Jul 2023 13:14:29 +0200
Message-ID: <20230709111458.703690787@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
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

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit 144601f6228de5598f03e693822b60a95c367a17 ]

kasprintf() returns a pointer to dynamically allocated memory.
Pointer could be NULL in case allocation fails. Check pointer validity.
Identified with coccinelle (kmerr.cocci script).

Fixes: f491276a5168 ("clk: vc5: Allow Versaclock driver to support multiple instances")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230530093913.1656095-2-claudiu.beznea@microchip.com
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-versaclock5.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 5452471b7ba55..e9a7f3c91ae0e 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -1028,6 +1028,11 @@ static int vc5_probe(struct i2c_client *client)
 	}
 
 	init.name = kasprintf(GFP_KERNEL, "%pOFn.mux", client->dev.of_node);
+	if (!init.name) {
+		ret = -ENOMEM;
+		goto err_clk;
+	}
+
 	init.ops = &vc5_mux_ops;
 	init.flags = 0;
 	init.parent_names = parent_names;
@@ -1042,6 +1047,10 @@ static int vc5_probe(struct i2c_client *client)
 		memset(&init, 0, sizeof(init));
 		init.name = kasprintf(GFP_KERNEL, "%pOFn.dbl",
 				      client->dev.of_node);
+		if (!init.name) {
+			ret = -ENOMEM;
+			goto err_clk;
+		}
 		init.ops = &vc5_dbl_ops;
 		init.flags = CLK_SET_RATE_PARENT;
 		init.parent_names = parent_names;
@@ -1057,6 +1066,10 @@ static int vc5_probe(struct i2c_client *client)
 	/* Register PFD */
 	memset(&init, 0, sizeof(init));
 	init.name = kasprintf(GFP_KERNEL, "%pOFn.pfd", client->dev.of_node);
+	if (!init.name) {
+		ret = -ENOMEM;
+		goto err_clk;
+	}
 	init.ops = &vc5_pfd_ops;
 	init.flags = CLK_SET_RATE_PARENT;
 	init.parent_names = parent_names;
@@ -1074,6 +1087,10 @@ static int vc5_probe(struct i2c_client *client)
 	/* Register PLL */
 	memset(&init, 0, sizeof(init));
 	init.name = kasprintf(GFP_KERNEL, "%pOFn.pll", client->dev.of_node);
+	if (!init.name) {
+		ret = -ENOMEM;
+		goto err_clk;
+	}
 	init.ops = &vc5_pll_ops;
 	init.flags = CLK_SET_RATE_PARENT;
 	init.parent_names = parent_names;
@@ -1093,6 +1110,10 @@ static int vc5_probe(struct i2c_client *client)
 		memset(&init, 0, sizeof(init));
 		init.name = kasprintf(GFP_KERNEL, "%pOFn.fod%d",
 				      client->dev.of_node, idx);
+		if (!init.name) {
+			ret = -ENOMEM;
+			goto err_clk;
+		}
 		init.ops = &vc5_fod_ops;
 		init.flags = CLK_SET_RATE_PARENT;
 		init.parent_names = parent_names;
@@ -1111,6 +1132,10 @@ static int vc5_probe(struct i2c_client *client)
 	memset(&init, 0, sizeof(init));
 	init.name = kasprintf(GFP_KERNEL, "%pOFn.out0_sel_i2cb",
 			      client->dev.of_node);
+	if (!init.name) {
+		ret = -ENOMEM;
+		goto err_clk;
+	}
 	init.ops = &vc5_clk_out_ops;
 	init.flags = CLK_SET_RATE_PARENT;
 	init.parent_names = parent_names;
@@ -1137,6 +1162,10 @@ static int vc5_probe(struct i2c_client *client)
 		memset(&init, 0, sizeof(init));
 		init.name = kasprintf(GFP_KERNEL, "%pOFn.out%d",
 				      client->dev.of_node, idx + 1);
+		if (!init.name) {
+			ret = -ENOMEM;
+			goto err_clk;
+		}
 		init.ops = &vc5_clk_out_ops;
 		init.flags = CLK_SET_RATE_PARENT;
 		init.parent_names = parent_names;
-- 
2.39.2



