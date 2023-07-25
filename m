Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D699C76145F
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjGYLSg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbjGYLSf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:18:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824339D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:18:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 205AF615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1E7C433C7;
        Tue, 25 Jul 2023 11:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283913;
        bh=l0aasEG3H8wHczWqoFqLFvn+KtlTzbVAzBC39L6J/ZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZP1ZeRAi2YJwnTeF0YCsZJDDNQPCXlNmCkIIbWumWyfmj1ojlckmVxBrj8n/0TVqU
         JI66TQJEH05or+OyERtBgA8cjh4MpKoMLpRNuRJLeC2Li2xHmtC0gKmFAEky91GMar
         dQ2iqonwHcRGHBlaKBnsE8MeJi0G9162/Gb7H9cE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 168/509] clk: si5341: check return value of {devm_}kasprintf()
Date:   Tue, 25 Jul 2023 12:41:47 +0200
Message-ID: <20230725104601.412385659@linuxfoundation.org>
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
index baa5e2ad22668..af66097f9ac5a 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -1685,6 +1685,10 @@ static int si5341_probe(struct i2c_client *client,
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
@@ -1703,6 +1707,10 @@ static int si5341_probe(struct i2c_client *client,
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



