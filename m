Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085327552D4
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjGPUM1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjGPUM0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:12:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4714D90
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:12:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA53060DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D84C433C7;
        Sun, 16 Jul 2023 20:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538344;
        bh=HcsqPUeGc2FOtbnnD3NpeFGeKDw4x7uxq1jshOGEJ0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RL+tEzFTtJjC4xOOrv7RxqQhDuKmc4XlQWLtjNnKRytYclBucIoTDrHd6VzumGnBP
         jgOHjYNPcEJYAE8wh6ToCmVrt2iMfW+SoYeEiTjacIbjUh8HVaUGqU6yGLIXEknzGX
         kC40TaJH93Gs+8RKyVln/eYGfKyATEujiDc4khWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 417/800] clk: cdce925: check return value of kasprintf()
Date:   Sun, 16 Jul 2023 21:44:30 +0200
Message-ID: <20230716194958.772080194@linuxfoundation.org>
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

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit bb7d09ddbf361d51eae46f38e7c8a2b85914ea2a ]

kasprintf() returns a pointer to dynamically allocated memory.
Pointer could be NULL in case allocation fails. Check pointer validity.
Identified with coccinelle (kmerr.cocci script).

Fixes: 19fbbbbcd3a3 ("Add TI CDCE925 I2C controlled clock synthesizer driver")
Depends-on: e665f029a283 ("clk: Convert to using %pOFn instead of device_node.name")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230530093913.1656095-3-claudiu.beznea@microchip.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-cdce925.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/clk-cdce925.c b/drivers/clk/clk-cdce925.c
index 6350682f7e6d2..87890669297d8 100644
--- a/drivers/clk/clk-cdce925.c
+++ b/drivers/clk/clk-cdce925.c
@@ -701,6 +701,10 @@ static int cdce925_probe(struct i2c_client *client)
 	for (i = 0; i < data->chip_info->num_plls; ++i) {
 		pll_clk_name[i] = kasprintf(GFP_KERNEL, "%pOFn.pll%d",
 			client->dev.of_node, i);
+		if (!pll_clk_name[i]) {
+			err = -ENOMEM;
+			goto error;
+		}
 		init.name = pll_clk_name[i];
 		data->pll[i].chip = data;
 		data->pll[i].hw.init = &init;
@@ -742,6 +746,10 @@ static int cdce925_probe(struct i2c_client *client)
 	init.num_parents = 1;
 	init.parent_names = &parent_name; /* Mux Y1 to input */
 	init.name = kasprintf(GFP_KERNEL, "%pOFn.Y1", client->dev.of_node);
+	if (!init.name) {
+		err = -ENOMEM;
+		goto error;
+	}
 	data->clk[0].chip = data;
 	data->clk[0].hw.init = &init;
 	data->clk[0].index = 0;
@@ -760,6 +768,10 @@ static int cdce925_probe(struct i2c_client *client)
 	for (i = 1; i < data->chip_info->num_outputs; ++i) {
 		init.name = kasprintf(GFP_KERNEL, "%pOFn.Y%d",
 			client->dev.of_node, i+1);
+		if (!init.name) {
+			err = -ENOMEM;
+			goto error;
+		}
 		data->clk[i].chip = data;
 		data->clk[i].hw.init = &init;
 		data->clk[i].index = i;
-- 
2.39.2



