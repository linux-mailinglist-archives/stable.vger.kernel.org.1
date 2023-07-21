Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3A675C9F8
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGUO0f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjGUO0e (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C52E6F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74C3B61CB8
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BEDC433C9;
        Fri, 21 Jul 2023 14:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689949592;
        bh=t+rl9K6rA7/z+asqYLcKCSn7cIzFUXMHhksPRB+Q4ws=;
        h=Subject:To:Cc:From:Date:From;
        b=pCqlTNqRLT+hpqbE38Bm7AZYPzvrDVx8E9Pz3icNr655vhA8mL4FYwWSS11CuvYgY
         EUrZJ7R+OHZyMXOr9rYlOlPTKaNhBveqfsIDooXonxaWIyCvTR8oQ75o7ZkvYvkdQb
         RA8ZbwIQRALIHmYp5/rdjbHUa2VObcQm6D9n1VW8=
Subject: FAILED: patch "[PATCH] pwm: meson: modify and simplify calculation in" failed to apply to 5.4-stable tree
To:     hkallweit1@gmail.com, ddrokosov@sberdevices.ru,
        martin.blumenstingl@googlemail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:26:20 +0200
Message-ID: <2023072120-spectrum-handyman-51b8@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 6b9352f3f8a1a35faf0efc1ad1807ee303467796
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072120-spectrum-handyman-51b8@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

6b9352f3f8a1 ("pwm: meson: modify and simplify calculation in meson_pwm_get_state")
6c452cff79f8 ("pwm: Make .get_state() callback return an error code")
8eca6b0a647a ("Merge tag 'pwm/for-5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6b9352f3f8a1a35faf0efc1ad1807ee303467796 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Wed, 24 May 2023 21:47:43 +0200
Subject: [PATCH] pwm: meson: modify and simplify calculation in
 meson_pwm_get_state
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I don't see a reason why we should treat the case lo < hi differently
and return 0 as period and duty_cycle. The current logic was added with
c375bcbaabdb ("pwm: meson: Read the full hardware state in
meson_pwm_get_state()"), Martin as original author doesn't remember why
it was implemented this way back then.
So let's handle it as normal use case and also remove the optimization
for lo == 0. I think the improved readability is worth it.

Fixes: c375bcbaabdb ("pwm: meson: Read the full hardware state in meson_pwm_get_state()")
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 5732300eb004..3865538dd2d6 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -351,18 +351,8 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	channel->lo = FIELD_GET(PWM_LOW_MASK, value);
 	channel->hi = FIELD_GET(PWM_HIGH_MASK, value);
 
-	if (channel->lo == 0) {
-		state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
-		state->duty_cycle = state->period;
-	} else if (channel->lo >= channel->hi) {
-		state->period = meson_pwm_cnt_to_ns(chip, pwm,
-						    channel->lo + channel->hi);
-		state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm,
-							channel->hi);
-	} else {
-		state->period = 0;
-		state->duty_cycle = 0;
-	}
+	state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->lo + channel->hi);
+	state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
 
 	state->polarity = PWM_POLARITY_NORMAL;
 

