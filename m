Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAA67ED6CA
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344127AbjKOWDe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344235AbjKOWDd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:03:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4584519B
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:03:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C098EC433C8;
        Wed, 15 Nov 2023 22:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700085809;
        bh=8EJCCRIQUd5SAO5uHjQfQCLWf1APQ/HNu5YZJwmXKzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t4cFU9lHM7SivFWLSUrGSTIjGqGR0A5GlJlzLxtm9G6hQLHKPkdchSGsKP1Kaap8g
         AVxEktBQDsYA7qt7Um4RbGTGYV9RHhSUjcf3FgArDM92dGLsKEcxfIrP3hOvkSaoE8
         HdClKFTNw2KbgTdzClr64b1Pr1VCDY/zgA7pjNfM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Jeff LaBundy <jeff@labundy.com>, Pavel Machek <pavel@ucw.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 067/119] leds: pwm: simplify if condition
Date:   Wed, 15 Nov 2023 17:00:57 -0500
Message-ID: <20231115220134.715696526@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
References: <20231115220132.607437515@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <uwe@kleine-koenig.org>

[ Upstream commit b43a8f01fccbfdddbc7f9b2bbad11b7db3fda4e1 ]

.pwm_period_ns is an unsigned integer. So when led->pwm_period_ns > 0
is false, we now assign 0 to a value that is already 0, so it doesn't
hurt and we can skip checking the actual value.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
Tested-by: Jeff LaBundy <jeff@labundy.com>
Signed-off-by: Pavel Machek <pavel@ucw.cz>
Stable-dep-of: 76fe464c8e64 ("leds: pwm: Don't disable the PWM when the LED should be off")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-pwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 8b6965a563e9b..b72fd89ff3903 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -102,7 +102,7 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 	pwm_get_args(led_data->pwm, &pargs);
 
 	led_data->period = pargs.period;
-	if (!led_data->period && (led->pwm_period_ns > 0))
+	if (!led_data->period)
 		led_data->period = led->pwm_period_ns;
 
 	ret = devm_led_classdev_register(dev, &led_data->cdev);
-- 
2.42.0



