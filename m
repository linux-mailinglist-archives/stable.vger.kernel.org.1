Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB597761460
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbjGYLSj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbjGYLSi (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:18:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4172699
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:18:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D46E1615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E531CC433C7;
        Tue, 25 Jul 2023 11:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283916;
        bh=ZqttU1RqoU7jwj7QWeWlUJo7bwwPS292qRgdsWZja1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uCBZzn7nTuoWQrSMzTwi+A1MOxepR071zEO28bO1D5uH0JckwPHuYO1rUtK+tABHt
         U/xwmf4/1I0obxuTqMSN8ZhSLss9U008MJhqO0Wsuh4YfkXy7p76IjfqXd1uBaVOvc
         7xk5iIws1t6l2/4J5RoczIDxhsBOgsNWWzfVQI7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 169/509] clk: si5341: free unused memory on probe failure
Date:   Tue, 25 Jul 2023 12:41:48 +0200
Message-ID: <20230725104601.462133414@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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

[ Upstream commit 267ad94b13c53d8c99a336f0841b1fa1595b1d0f ]

Pointers from synth_clock_names[] should be freed at the end of probe
either on probe success or failure path.

Fixes: b7bbf6ec4940 ("clk: si5341: Allow different output VDD_SEL values")
Fixes: 9b13ff4340df ("clk: si5341: Add sysfs properties to allow checking/resetting device faults")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230530093913.1656095-6-claudiu.beznea@microchip.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-si5341.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index af66097f9ac5a..4dea29fa901d4 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -1732,7 +1732,7 @@ static int si5341_probe(struct i2c_client *client,
 		if (err) {
 			dev_err(&client->dev,
 				"output %u registration failed\n", i);
-			goto cleanup;
+			goto free_clk_names;
 		}
 		if (config[i].always_on)
 			clk_prepare(data->clk[i].hw.clk);
@@ -1742,7 +1742,7 @@ static int si5341_probe(struct i2c_client *client,
 			data);
 	if (err) {
 		dev_err(&client->dev, "unable to add clk provider\n");
-		goto cleanup;
+		goto free_clk_names;
 	}
 
 	if (initialization_required) {
@@ -1750,11 +1750,11 @@ static int si5341_probe(struct i2c_client *client,
 		regcache_cache_only(data->regmap, false);
 		err = regcache_sync(data->regmap);
 		if (err < 0)
-			goto cleanup;
+			goto free_clk_names;
 
 		err = si5341_finalize_defaults(data);
 		if (err < 0)
-			goto cleanup;
+			goto free_clk_names;
 	}
 
 	/* wait for device to report input clock present and PLL lock */
@@ -1763,21 +1763,19 @@ static int si5341_probe(struct i2c_client *client,
 	       10000, 250000);
 	if (err) {
 		dev_err(&client->dev, "Error waiting for input clock or PLL lock\n");
-		goto cleanup;
+		goto free_clk_names;
 	}
 
 	/* clear sticky alarm bits from initialization */
 	err = regmap_write(data->regmap, SI5341_STATUS_STICKY, 0);
 	if (err) {
 		dev_err(&client->dev, "unable to clear sticky status\n");
-		goto cleanup;
+		goto free_clk_names;
 	}
 
 	err = sysfs_create_files(&client->dev.kobj, si5341_attributes);
-	if (err) {
+	if (err)
 		dev_err(&client->dev, "unable to create sysfs files\n");
-		goto cleanup;
-	}
 
 free_clk_names:
 	/* Free the names, clk framework makes copies */
-- 
2.39.2



