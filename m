Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB2675D273
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjGUS7p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjGUS7n (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:59:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19AE30CF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:59:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FAFB61D82
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA2BC433C8;
        Fri, 21 Jul 2023 18:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965981;
        bh=i/REAkM4E+9dkt28BeXvOyHa8TqZ8RzaJuX/6uuDxjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ib4TBq7yxo7VFrsNBD93I5DAQarVjMdWuqzN591p/aMzTXCGxjJ/qJ1qwbqOkJyeC
         WmORqO19bt2BLDv6+zIBcLz8spqyw06b2m8wHi8FGi+3JvKvsc9gTJLM6W0FT5JBke
         rv8l8crRvx9H3gJcqhHMnWbYyhWxl/ApG2fWbQmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 182/532] clk: vc5: check memory returned by kasprintf()
Date:   Fri, 21 Jul 2023 18:01:26 +0200
Message-ID: <20230721160624.246146727@linuxfoundation.org>
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
index 5f8bd49b0810c..c52f02471bb4f 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -992,6 +992,11 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
@@ -1006,6 +1011,10 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
@@ -1021,6 +1030,10 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
@@ -1038,6 +1051,10 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
@@ -1057,6 +1074,10 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
@@ -1075,6 +1096,10 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
@@ -1101,6 +1126,10 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
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



