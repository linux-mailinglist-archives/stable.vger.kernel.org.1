Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EE77556F1
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjGPUzc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjGPUzb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:55:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5005E41
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:55:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A0B360EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7D6C433C8;
        Sun, 16 Jul 2023 20:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540929;
        bh=YRyv2HMm1P3wTe896p1Pw96XjAeQQKwjsOMocaSndYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HYkCOTRm8yVdTR0mnsg8RR8mL5X1GGMNdKfY/j7f32B0X3IM7E45vPaK2sPW6oezs
         Sac2XrIHCXX1h5MYjNLF/gDz3jwu0BZj0RS9vAfN9yozkmkaG5sNzXpmNerUik9xCj
         UNfgbohSuNYLvtbmP1QAJ8obMdq+UmVddaUEAtA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 521/591] extcon: usbc-tusb320: Convert to i2cs .probe_new()
Date:   Sun, 16 Jul 2023 21:51:00 +0200
Message-ID: <20230716194937.353508607@linuxfoundation.org>
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

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 5313121b22fd11db0d14f305c110168b8176efdc ]

The probe function doesn't make use of the i2c_device_id * parameter so it
can be trivially converted.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Stable-dep-of: 3adbaa30d973 ("extcon: usbc-tusb320: Unregister typec port on driver removal")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/extcon/extcon-usbc-tusb320.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
index 9dfa545427ca1..b408ce989c223 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -428,8 +428,7 @@ static int tusb320_typec_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int tusb320_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int tusb320_probe(struct i2c_client *client)
 {
 	struct tusb320_priv *priv;
 	const void *match_data;
@@ -502,7 +501,7 @@ static const struct of_device_id tusb320_extcon_dt_match[] = {
 MODULE_DEVICE_TABLE(of, tusb320_extcon_dt_match);
 
 static struct i2c_driver tusb320_extcon_driver = {
-	.probe		= tusb320_probe,
+	.probe_new	= tusb320_probe,
 	.driver		= {
 		.name	= "extcon-tusb320",
 		.of_match_table = tusb320_extcon_dt_match,
-- 
2.39.2



