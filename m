Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A402F75D275
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjGUS7u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjGUS7t (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:59:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F1130D7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:59:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3DE161D80
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C6CC433C9;
        Fri, 21 Jul 2023 18:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965987;
        bh=7wTKVBBZ4kOR7tOMqrnSGylSNd1BlNLIYT/Lqfhb+Kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ebju31WNK0S2KT62kBbz88zW/xHljAXKq5EZb2Q+6f88KJ1Cx0yig8RbS0W8j8nOu
         BO8gSgWxlwtzxQ5xELKrHmmEusaHtg7/pAGffJOWeP3mIWr+0rJpmKmDj2t2nO5MMG
         fsjuJkuyu3ywi7ugLxoRGhi5kegI5fbLdvPDO3RM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 184/532] clk: si5341: return error if one synth clock registration fails
Date:   Fri, 21 Jul 2023 18:01:28 +0200
Message-ID: <20230721160624.351684932@linuxfoundation.org>
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

[ Upstream commit 2560114c06d7a752b3f4639f28cece58fed11267 ]

In case devm_clk_hw_register() fails for one of synth clocks the probe
continues. Later on, when registering output clocks which have as parents
all the synth clocks, in case there is registration failure for at least
one synth clock the information passed to clk core for registering output
clock is not right: init.num_parents is fixed but init.parents may contain
an array with less parents.

Fixes: 3044a860fd09 ("clk: Add Si5341/Si5340 driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230530093913.1656095-4-claudiu.beznea@microchip.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-si5341.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index 4de098b6b0d4e..883a49a0805c9 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -1554,7 +1554,7 @@ static int si5341_probe(struct i2c_client *client,
 	struct clk_init_data init;
 	struct clk *input;
 	const char *root_clock_name;
-	const char *synth_clock_names[SI5341_NUM_SYNTH];
+	const char *synth_clock_names[SI5341_NUM_SYNTH] = { NULL };
 	int err;
 	unsigned int i;
 	struct clk_si5341_output_config config[SI5341_MAX_NUM_OUTPUTS];
@@ -1706,6 +1706,7 @@ static int si5341_probe(struct i2c_client *client,
 		if (err) {
 			dev_err(&client->dev,
 				"synth N%u registration failed\n", i);
+			goto free_clk_names;
 		}
 	}
 
@@ -1783,16 +1784,17 @@ static int si5341_probe(struct i2c_client *client,
 		goto cleanup;
 	}
 
+free_clk_names:
 	/* Free the names, clk framework makes copies */
 	for (i = 0; i < data->num_synth; ++i)
 		 devm_kfree(&client->dev, (void *)synth_clock_names[i]);
 
-	return 0;
-
 cleanup:
-	for (i = 0; i < SI5341_MAX_NUM_OUTPUTS; ++i) {
-		if (data->clk[i].vddo_reg)
-			regulator_disable(data->clk[i].vddo_reg);
+	if (err) {
+		for (i = 0; i < SI5341_MAX_NUM_OUTPUTS; ++i) {
+			if (data->clk[i].vddo_reg)
+				regulator_disable(data->clk[i].vddo_reg);
+		}
 	}
 	return err;
 }
-- 
2.39.2



