Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD92719DBF
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbjFAN0O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjFANZz (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B879198
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:25:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4FE26447B
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B005CC433D2;
        Thu,  1 Jun 2023 13:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625936;
        bh=kfCji33tP3engLPwCPTMoQkxImsQ/d3ZtMKTiTCcSrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qrspXRjOPx6xlJrdFsLCb89M9cCQYDKvup3BEitNokiw0zzk/lyDhy8T6bqPGTtJI
         vyCbsRZUoIweYsOzAw7uGmvqWTGqb/y3H/o0AVauvjI8PcYWEUrHGNzdyVHw2e2MDQ
         ArlvbS2FSIELfxn+a8B3464Ol9aesZiRl07JaUxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andreas Kemnade <andreas@kemnade.info>,
        christophe.leroy@csgroup.eu,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 10/45] gpiolib: fix allocation of mixed dynamic/static GPIOs
Date:   Thu,  1 Jun 2023 14:21:06 +0100
Message-Id: <20230601131939.179196890@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andreas Kemnade <andreas@kemnade.info>

[ Upstream commit 7dd3d9bd873f138675cb727eaa51a498d99f0e89 ]

If static allocation and dynamic allocation GPIOs are present,
dynamic allocation pollutes the numberspace for static allocation,
causing static allocation to fail.
Enforce dynamic allocation above GPIO_DYNAMIC_BASE.

Seen on a GTA04 when omap-gpio (static) and twl-gpio (dynamic)
raced:
[some successful registrations of omap_gpio instances]
[    2.553833] twl4030_gpio twl4030-gpio: gpio (irq 145) chaining IRQs 161..178
[    2.561401] gpiochip_find_base: found new base at 160
[    2.564392] gpio gpiochip5: (twl4030): added GPIO chardev (254:5)
[    2.564544] gpio gpiochip5: registered GPIOs 160 to 177 on twl4030
[...]
[    2.692169] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
[    2.697357] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
[    2.703643] gpiochip_find_base: found new base at 178
[    2.704376] gpio gpiochip6: (omap-gpmc): added GPIO chardev (254:6)
[    2.704589] gpio gpiochip6: registered GPIOs 178 to 181 on omap-gpmc
[...]
[    2.840393] gpio gpiochip7: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    2.849365] gpio gpiochip7: (gpio-160-191): GPIO integer space overlap, cannot add chip
[    2.857513] gpiochip_add_data_with_key: GPIOs 160..191 (gpio-160-191) failed to register, -16
[    2.866149] omap_gpio 48310000.gpio: error -EBUSY: Could not register gpio chip

On that device it is fixed invasively by
commit 92bf78b33b0b4 ("gpio: omap: use dynamic allocation of base")
but let's also fix that for devices where there is still
a mixture of static and dynamic allocation.

Fixes: 7b61212f2a07 ("gpiolib: Get rid of ARCH_NR_GPIOS")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reviewed-by: <christophe.leroy@csgroup.eu>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 19bd23044b017..4472214fcd43a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -193,6 +193,8 @@ static int gpiochip_find_base(int ngpio)
 			break;
 		/* nope, check the space right after the chip */
 		base = gdev->base + gdev->ngpio;
+		if (base < GPIO_DYNAMIC_BASE)
+			base = GPIO_DYNAMIC_BASE;
 	}
 
 	if (gpio_is_valid(base)) {
-- 
2.39.2



