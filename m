Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69177555A5
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjGPUnJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjGPUnI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:43:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B99D9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:43:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2907160EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38AA5C433C8;
        Sun, 16 Jul 2023 20:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540186;
        bh=YQT8KVtWNhjDaujSuQLdd9B+Gx7sa9jqy+gpapRjzm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cuZY9S1TgtmgYTzUNkn5j/Lp/kLHqgAR2b24Zy+CgVqNRJGQD+wOzseGSnAPXk7A+
         4VN3H5Luwmo/r4skyIjqXiTfzZLlZJN/93GB6EVdynywfvBxiiPhOyYYuzOOM49FXi
         h/MQ5xKk0y1L5wIprTCwDdd4ez7jcFDfqF0dgz+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 273/591] clk: si5341: return error if one synth clock registration fails
Date:   Sun, 16 Jul 2023 21:46:52 +0200
Message-ID: <20230716194930.959275675@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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
index 0e528d7ba656e..6dca3288c8940 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -1553,7 +1553,7 @@ static int si5341_probe(struct i2c_client *client)
 	struct clk_init_data init;
 	struct clk *input;
 	const char *root_clock_name;
-	const char *synth_clock_names[SI5341_NUM_SYNTH];
+	const char *synth_clock_names[SI5341_NUM_SYNTH] = { NULL };
 	int err;
 	unsigned int i;
 	struct clk_si5341_output_config config[SI5341_MAX_NUM_OUTPUTS];
@@ -1705,6 +1705,7 @@ static int si5341_probe(struct i2c_client *client)
 		if (err) {
 			dev_err(&client->dev,
 				"synth N%u registration failed\n", i);
+			goto free_clk_names;
 		}
 	}
 
@@ -1782,16 +1783,17 @@ static int si5341_probe(struct i2c_client *client)
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



