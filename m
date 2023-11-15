Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA8E7ED300
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjKOUpq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjKOUpj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:45:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AD5D44
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:45:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FB4C433CB;
        Wed, 15 Nov 2023 20:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081128;
        bh=loxbqbZUH07uLZcEKYZMYimkzAAAo/1jb7XfDCOvSCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OvF61xqbb42MOS5tDVJR0X4Wc12IklzJlWKQ5V9fsiAT+uh4cz7mv+Rpb9dS6M0cb
         zM6xEWEnM0ZJLY9xvypeSBnhVcUWqFi/2+PUsab97Yu+0RjJ+HEfuJuE4x0C99UHRr
         5Qzr6XfiF6klLyl3oBGjjFfGx3E2oITlqPPFVGEo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Jeff LaBundy <jeff@labundy.com>, Pavel Machek <pavel@ucw.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 48/88] leds: pwm: convert to atomic PWM API
Date:   Wed, 15 Nov 2023 15:36:00 -0500
Message-ID: <20231115191429.055692831@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191426.221330369@linuxfoundation.org>
References: <20231115191426.221330369@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <uwe@kleine-koenig.org>

[ Upstream commit dd47a83453e4a5b0d6a91fe702b7fbc1984fb610 ]

pwm_config(), pwm_enable() and pwm_disable() should get removed in the
long run. So update the driver to use the atomic API that is here to
stay.

A few side effects:

 - led_pwm_set() now returns an error when setting the PWM fails.
 - During .probe() the PWM isn't disabled implicitly by pwm_apply_args()
   any more.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
Tested-by: Jeff LaBundy <jeff@labundy.com>
Signed-off-by: Pavel Machek <pavel@ucw.cz>
Stable-dep-of: 76fe464c8e64 ("leds: pwm: Don't disable the PWM when the LED should be off")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-pwm.c | 41 +++++++++--------------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index dc5c6100a419f..16c78df7a7632 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -25,9 +25,8 @@
 struct led_pwm_data {
 	struct led_classdev	cdev;
 	struct pwm_device	*pwm;
+	struct pwm_state	pwmstate;
 	unsigned int		active_low;
-	unsigned int		period;
-	int			duty;
 };
 
 struct led_pwm_priv {
@@ -35,37 +34,23 @@ struct led_pwm_priv {
 	struct led_pwm_data leds[0];
 };
 
-static void __led_pwm_set(struct led_pwm_data *led_dat)
-{
-	int new_duty = led_dat->duty;
-
-	pwm_config(led_dat->pwm, new_duty, led_dat->period);
-
-	if (new_duty == 0)
-		pwm_disable(led_dat->pwm);
-	else
-		pwm_enable(led_dat->pwm);
-}
-
 static int led_pwm_set(struct led_classdev *led_cdev,
 		       enum led_brightness brightness)
 {
 	struct led_pwm_data *led_dat =
 		container_of(led_cdev, struct led_pwm_data, cdev);
 	unsigned int max = led_dat->cdev.max_brightness;
-	unsigned long long duty =  led_dat->period;
+	unsigned long long duty = led_dat->pwmstate.period;
 
 	duty *= brightness;
 	do_div(duty, max);
 
 	if (led_dat->active_low)
-		duty = led_dat->period - duty;
-
-	led_dat->duty = duty;
-
-	__led_pwm_set(led_dat);
+		duty = led_dat->pwmstate.period - duty;
 
-	return 0;
+	led_dat->pwmstate.duty_cycle = duty;
+	led_dat->pwmstate.enabled = duty > 0;
+	return pwm_apply_state(led_dat->pwm, &led_dat->pwmstate);
 }
 
 static inline size_t sizeof_pwm_leds_priv(int num_leds)
@@ -84,7 +69,6 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 		       struct led_pwm *led, struct device_node *child)
 {
 	struct led_pwm_data *led_data = &priv->leds[priv->num_leds];
-	struct pwm_args pargs;
 	int ret;
 
 	led_data->active_low = led->active_low;
@@ -108,17 +92,10 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 
 	led_data->cdev.brightness_set_blocking = led_pwm_set;
 
-	/*
-	 * FIXME: pwm_apply_args() should be removed when switching to the
-	 * atomic PWM API.
-	 */
-	pwm_apply_args(led_data->pwm);
-
-	pwm_get_args(led_data->pwm, &pargs);
+	pwm_init_state(led_data->pwm, &led_data->pwmstate);
 
-	led_data->period = pargs.period;
-	if (!led_data->period)
-		led_data->period = led->pwm_period_ns;
+	if (!led_data->pwmstate.period)
+		led_data->pwmstate.period = led->pwm_period_ns;
 
 	ret = led_classdev_register(dev, &led_data->cdev);
 	if (ret == 0) {
-- 
2.42.0



