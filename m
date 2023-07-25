Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB5076149D
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbjGYLVB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjGYLU7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:20:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DFB13D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:20:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A0826167D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AFCC433C8;
        Tue, 25 Jul 2023 11:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284057;
        bh=3TaVZdnIpCoyTAQzKUAwO0jDgXkECI8KUZVrzvjer/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z/f/P8tMA9QkL9LLNkDVYk+wQM9d3qNVucnNv+OtKUdZAHaV592kMNIa6hnmMbvz8
         fxtmctH5/gUhB5KRaMY+fy0enLgxYbf+eAgYeG3rKftIX7akgbnPx3MKa3iEoGUWji
         86mFwiJVhKyFj589jK1k2eNKddVRV78wfRRkdKK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 190/509] pinctrl: at91-pio4: check return value of devm_kasprintf()
Date:   Tue, 25 Jul 2023 12:42:09 +0200
Message-ID: <20230725104602.422622452@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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

[ Upstream commit f6fd5d4ff8ca0b24cee1af4130bcb1fa96b61aa0 ]

devm_kasprintf() returns a pointer to dynamically allocated memory.
Pointer could be NULL in case allocation fails. Check pointer validity.
Identified with coccinelle (kmerr.cocci script).

Fixes: 776180848b57 ("pinctrl: introduce driver for Atmel PIO4 controller")
Depends-on: 1c4e5c470a56 ("pinctrl: at91: use devm_kasprintf() to avoid potential leaks")
Depends-on: 5a8f9cf269e8 ("pinctrl: at91-pio4: use proper format specifier for unsigned int")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20230615105333.585304-4-claudiu.beznea@microchip.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-at91-pio4.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 315a6c4d9ade0..bf8aa0ea35d1b 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -1083,6 +1083,8 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 		/* Pin naming convention: P(bank_name)(bank_pin_number). */
 		pin_desc[i].name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "P%c%d",
 						  bank + 'A', line);
+		if (!pin_desc[i].name)
+			return -ENOMEM;
 
 		group->name = group_names[i] = pin_desc[i].name;
 		group->pin = pin_desc[i].number;
-- 
2.39.2



