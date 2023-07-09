Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC25474C363
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjGILcG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjGILcC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:32:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B84119B2
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:31:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B53B060C03
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C221BC433C8;
        Sun,  9 Jul 2023 11:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902297;
        bh=m3MN6iNSXzX7PWvHuaNtSu/W2QwNhkIubJYUn40I3X4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eyC9kLGuAnDXoUgPm0oTt5hOw9ywUPS94R9Bz/0uHnxX80/ALSvbdcBZfmlw2QRmm
         mjerVa+Blvbxoz18W0vnNjmLKBElz8O1M0qehfp657oTiQFowYEboULCFXaBmvcSD9
         xfLyHlVufn2gr/9BH40fUHm3lp8TN3QlKgyYz9u0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 325/431] clk: si5341: free unused memory on probe failure
Date:   Sun,  9 Jul 2023 13:14:33 +0200
Message-ID: <20230709111458.796333564@linuxfoundation.org>
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
index b2cf7edc8b308..c7d8cbd22bacc 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -1744,7 +1744,7 @@ static int si5341_probe(struct i2c_client *client)
 		if (err) {
 			dev_err(&client->dev,
 				"output %u registration failed\n", i);
-			goto cleanup;
+			goto free_clk_names;
 		}
 		if (config[i].always_on)
 			clk_prepare(data->clk[i].hw.clk);
@@ -1754,7 +1754,7 @@ static int si5341_probe(struct i2c_client *client)
 			data);
 	if (err) {
 		dev_err(&client->dev, "unable to add clk provider\n");
-		goto cleanup;
+		goto free_clk_names;
 	}
 
 	if (initialization_required) {
@@ -1762,11 +1762,11 @@ static int si5341_probe(struct i2c_client *client)
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
@@ -1775,21 +1775,19 @@ static int si5341_probe(struct i2c_client *client)
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



