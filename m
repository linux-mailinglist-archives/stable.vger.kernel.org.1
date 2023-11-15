Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AA47ECC8F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjKOTbO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbjKOTbM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:31:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE98A1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:31:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36DAC433C8;
        Wed, 15 Nov 2023 19:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076669;
        bh=RrYx7PgdV3OJrvd9dJ1nFPanPmN8VM5VSQjyWa9zP1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ehyQCbcQYLuXKpi0VzguMGRIZxgCADT8pYKpPry00siFIAGr4vO/BMHQMnTIfl9WR
         VQfHAHPl0d5b2fwHd1v0av+uHTj1Eazh+/DiIS8u4hqw/khY4ppvxQ67c8AKKgu59Y
         18xMiz0TONfdTG7WG9u1ckqYATTXYGzxdFfJBDGk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rogan Dawes <rogan@dawes.za.net>,
        Fabio Estevam <festevam@denx.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 373/550] leds: pwm: Dont disable the PWM when the LED should be off
Date:   Wed, 15 Nov 2023 14:15:57 -0500
Message-ID: <20231115191626.679991746@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 76fe464c8e64e71b2e4af11edeef0e5d85eeb6aa ]

Disabling a PWM (i.e. calling pwm_apply_state with .enabled = false)
gives no guarantees what the PWM output does. It might freeze where it
currently is, or go in a High-Z state or drive the active or inactive
state, it might even continue to toggle.

To ensure that the LED gets really disabled, don't disable the PWM even
when .duty_cycle is zero.

This fixes disabling a leds-pwm LED on i.MX28. The PWM on this SoC is
one of those that freezes its output on disable, so if you disable an
LED that is full on, it stays on. If you disable a LED with half
brightness it goes off in 50% of the cases and full on in the other 50%.

Fixes: 41c42ff5dbe2 ("leds: simple driver for pwm driven LEDs")
Reported-by: Rogan Dawes <rogan@dawes.za.net>
Reported-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Fabio Estevam <festevam@denx.de>
Link: https://lore.kernel.org/r/20230922192834.1695727-1-u.kleine-koenig@pengutronix.de
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-pwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 87c199242f3c8..de695cbd89816 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -53,7 +53,7 @@ static int led_pwm_set(struct led_classdev *led_cdev,
 		duty = led_dat->pwmstate.period - duty;
 
 	led_dat->pwmstate.duty_cycle = duty;
-	led_dat->pwmstate.enabled = duty > 0;
+	led_dat->pwmstate.enabled = true;
 	return pwm_apply_state(led_dat->pwm, &led_dat->pwmstate);
 }
 
-- 
2.42.0



