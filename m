Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE8C75D292
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjGUTBG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjGUTBF (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:01:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3490030CA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:01:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA0E6619FD
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC228C433C7;
        Fri, 21 Jul 2023 19:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966064;
        bh=U/CV4mximLAMnDeyGKflvSOjA4SBbxByojlIKTgRu7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DD83BDFCge3RI9MCYu5J0FS1d6GMnMeC8HjZodlFdW9YcoO7VKkRmyBuFtCrtDQIR
         WdbGlbXNp+r8/DazK6SLRdHB1IJCMvKXAJ3TO3lf8LcSWktKc14NS9Cg4K+42SsXE5
         u1gvu+H7NK1nr64tPqXRxhLP00J9EHIC6KXWdQ5k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 211/532] pinctrl: microchip-sgpio: check return value of devm_kasprintf()
Date:   Fri, 21 Jul 2023 18:01:55 +0200
Message-ID: <20230721160625.850565350@linuxfoundation.org>
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

[ Upstream commit 310cd4c206cd04696ccbfd1927b5ab6973e8cc8e ]

devm_kasprintf() returns a pointer to dynamically allocated memory.
Pointer could be NULL in case allocation fails. Check pointer validity.
Identified with coccinelle (kmerr.cocci script).

Fixes: 7e5ea974e61c ("pinctrl: pinctrl-microchip-sgpio: Add pinctrl driver for Microsemi Serial GPIO")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20230615105333.585304-3-claudiu.beznea@microchip.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-microchip-sgpio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
index dfa374195694d..aceadc9ec0244 100644
--- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
+++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
@@ -729,6 +729,9 @@ static int microchip_sgpio_register_bank(struct device *dev,
 	pctl_desc->name = devm_kasprintf(dev, GFP_KERNEL, "%s-%sput",
 					 dev_name(dev),
 					 bank->is_input ? "in" : "out");
+	if (!pctl_desc->name)
+		return -ENOMEM;
+
 	pctl_desc->pctlops = &sgpio_pctl_ops;
 	pctl_desc->pmxops = &sgpio_pmx_ops;
 	pctl_desc->confops = &sgpio_confops;
-- 
2.39.2



