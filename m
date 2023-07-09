Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D91C74C373
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjGILcq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjGILcX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:32:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1522713D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:32:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CF7060BC0
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4A2C433C7;
        Sun,  9 Jul 2023 11:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902342;
        bh=UVor3HjPP/6Ia6VEvtyvhtsbP+3FKNtKYEcEHPQQ/q0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aeyRtMYpu/I5iYxAwCdmjnjmRzw3DCSUf80QMpLo5crQ8CHT30cIKDUg21ZrecnA9
         Yldsru+YcehdRwAcP4Ti6qRcXkt2v6FvKoDtJ7/2Bu3RR+gjb5Mi1NsQnXxNVJEeDx
         7b/XAD7qsIWBIxDihdk0CFr88K05sDduMFWq11rY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 342/431] pinctrl: bcm2835: Handle gpiochip_add_pin_range() errors
Date:   Sun,  9 Jul 2023 13:14:50 +0200
Message-ID: <20230709111459.186224320@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit cdf7e616120065007687fe1df0412154f259daec ]

gpiochip_add_pin_range() can fail, so better return its error code than
a hard coded '0'.

Fixes: d2b67744fd99 ("pinctrl: bcm2835: implement hook for missing gpio-ranges")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/98c3b5890bb72415145c9fe4e1d974711edae376.1681681402.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 7435173e10f43..1489191a213fe 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -376,10 +376,8 @@ static int bcm2835_add_pin_ranges_fallback(struct gpio_chip *gc)
 	if (!pctldev)
 		return 0;
 
-	gpiochip_add_pin_range(gc, pinctrl_dev_get_devname(pctldev), 0, 0,
-			       gc->ngpio);
-
-	return 0;
+	return gpiochip_add_pin_range(gc, pinctrl_dev_get_devname(pctldev), 0, 0,
+				      gc->ngpio);
 }
 
 static const struct gpio_chip bcm2835_gpio_chip = {
-- 
2.39.2



