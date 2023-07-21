Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E532275D276
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjGUS7x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjGUS7w (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:59:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D50230CF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:59:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3B6D61D76
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C732BC433C8;
        Fri, 21 Jul 2023 18:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965990;
        bh=VFC5+BT+bSx60f2XJyjNYXM+AlDULRaTHB5AlBn5Zd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MIe93zIaCozHGtQ4uUXNJlPbumu/CjjxVIFG+ghkbDUHjNKD0R/F5GKvvqM8qytKm
         jL8jmYo1AIPNZCOokZF3doirpa7TLWoG/x7Gx0RtsUHPXT6o90ui7Nurcf0jybWk+X
         CcFR9g29GWVvzIuVTNLMjbw16GRylwC69ktOGMt8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 185/532] clk: si5341: check return value of {devm_}kasprintf()
Date:   Fri, 21 Jul 2023 18:01:29 +0200
Message-ID: <20230721160624.414160368@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit 36e4ef82016a2b785cf2317eade77e76699b7bff ]

{devm_}kasprintf() returns a pointer to dynamically allocated memory.
Pointer could be NULL in case allocation fails. Check pointer validity.
Identified with coccinelle (kmerr.cocci script).

Fixes: 3044a860fd09 ("clk: Add Si5341/Si5340 driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230530093913.1656095-5-claudiu.beznea@microchip.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-si5341.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index 883a49a0805c9..4bcfb38cfbebe 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -1698,6 +1698,10 @@ static int si5341_probe(struct i2c_client *client,
 	for (i = 0; i < data->num_synth; ++i) {
 		synth_clock_names[i] = devm_kasprintf(&client->dev, GFP_KERNEL,
 				"%s.N%u", client->dev.of_node->name, i);
+		if (!synth_clock_names[i]) {
+			err = -ENOMEM;
+			goto free_clk_names;
+		}
 		init.name = synth_clock_names[i];
 		data->synth[i].index = i;
 		data->synth[i].data = data;
@@ -1716,6 +1720,10 @@ static int si5341_probe(struct i2c_client *client,
 	for (i = 0; i < data->num_outputs; ++i) {
 		init.name = kasprintf(GFP_KERNEL, "%s.%d",
 			client->dev.of_node->name, i);
+		if (!init.name) {
+			err = -ENOMEM;
+			goto free_clk_names;
+		}
 		init.flags = config[i].synth_master ? CLK_SET_RATE_PARENT : 0;
 		data->clk[i].index = i;
 		data->clk[i].data = data;
-- 
2.39.2



