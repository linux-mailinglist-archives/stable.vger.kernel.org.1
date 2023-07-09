Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EF974C37C
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjGILdI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjGILcq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:32:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF36191
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:32:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C96EB60BC9
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F10C433C7;
        Sun,  9 Jul 2023 11:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902364;
        bh=QR7icJWg8kFVed04lTN7wMSBBqjWqg4mSdPgC278FkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=asGXxsghR4L5EkNMFyPgIoohVQAiNMcMRmwzTHUZORh507S8+UJO9FGIOwKfpaDIH
         4rWlpUe9biBYW94wVGd7JECWdXlJuU+xcyZrJJatPTfX6CgqxF5vyqkwh+vXTG2305
         Y7aVizFYlwFYAtwrj9M/JgHum+imUaAk6PjP6zqg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ryan Wanner <ryan.wanner@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 350/431] pinctrl: at91: fix a couple NULL vs IS_ERR() checks
Date:   Sun,  9 Jul 2023 13:14:58 +0200
Message-ID: <20230709111459.372507955@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 35216718c9ac2aef934ea9cd229572d4996807b2 ]

The devm_kasprintf_strarray() function doesn't return NULL on error,
it returns error pointers.  Update the checks accordingly.

Fixes: f494c1913cbb ("pinctrl: at91: use devm_kasprintf() to avoid potential leaks (part 2)")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Ryan Wanner <ryan.wanner@microchip.com>
Link: https://lore.kernel.org/r/5697980e-f687-47a7-9db8-2af34ae464bd@kili.mountain
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-at91.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index e3664aafccef9..9184d457edf8d 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1399,8 +1399,8 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
 		char **names;
 
 		names = devm_kasprintf_strarray(dev, "pio", MAX_NB_GPIO_PER_BANK);
-		if (!names)
-			return -ENOMEM;
+		if (IS_ERR(names))
+			return PTR_ERR(names);
 
 		for (j = 0; j < MAX_NB_GPIO_PER_BANK; j++, k++) {
 			char *name = names[j];
@@ -1860,8 +1860,8 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	}
 
 	names = devm_kasprintf_strarray(dev, "pio", chip->ngpio);
-	if (!names)
-		return -ENOMEM;
+	if (IS_ERR(names))
+		return PTR_ERR(names);
 
 	for (i = 0; i < chip->ngpio; i++)
 		strreplace(names[i], '-', alias_idx + 'A');
-- 
2.39.2



