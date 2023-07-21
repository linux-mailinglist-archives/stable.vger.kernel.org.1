Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2B575C9FA
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjGUO0m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjGUO0l (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:26:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5514510FC
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF79061CB8
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32CAC433C7;
        Fri, 21 Jul 2023 14:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689949599;
        bh=aziOfRLKzs49xgS+NgcM1X6Xr7UGdW5cG0nipoafh5g=;
        h=Subject:To:Cc:From:Date:From;
        b=qqaBjcLfWTTg2z2fShub83HcIXJXFw6unD3nuf9Dyx+wjfOEbL4wd3krSWMjZftHB
         an45h88EYxEiqh5/NSbweUk4kXL3qvyKPqFY6ZI+3/IaRpO3N3nosRelewpY9prpaN
         LdcDJoBmMawrI0eqQoKbwI0B9xXK718TUPzWpLj0=
Subject: FAILED: patch "[PATCH] pwm: meson: fix handling of period/duty if greater than" failed to apply to 5.4-stable tree
To:     hkallweit1@gmail.com, martin.blumenstingl@googlemail.com,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:26:33 +0200
Message-ID: <2023072133-plank-glorified-2d3f@gregkh>
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
git cherry-pick -x 87a2cbf02d7701255f9fcca7e5bd864a7bb397cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072133-plank-glorified-2d3f@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

87a2cbf02d77 ("pwm: meson: fix handling of period/duty if greater than UINT_MAX")
5f97f18feac9 ("pwm: meson: Simplify duplicated per-channel tracking")
437fb760d046 ("pwm: meson: Remove redundant assignment to variable fin_freq")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 87a2cbf02d7701255f9fcca7e5bd864a7bb397cf Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Wed, 24 May 2023 21:48:36 +0200
Subject: [PATCH] pwm: meson: fix handling of period/duty if greater than
 UINT_MAX
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

state->period/duty are of type u64, and if their value is greater than
UINT_MAX, then the cast to uint will cause problems. Fix this by
changing the type of the respective local variables to u64.

Fixes: b79c3670e120 ("pwm: meson: Don't duplicate the polarity internally")
Cc: stable@vger.kernel.org
Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 3865538dd2d6..33107204a951 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -156,8 +156,9 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 			  const struct pwm_state *state)
 {
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
-	unsigned int duty, period, pre_div, cnt, duty_cnt;
+	unsigned int pre_div, cnt, duty_cnt;
 	unsigned long fin_freq;
+	u64 duty, period;
 
 	duty = state->duty_cycle;
 	period = state->period;
@@ -179,19 +180,19 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 
 	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
 
-	pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
+	pre_div = div64_u64(fin_freq * period, NSEC_PER_SEC * 0xffffLL);
 	if (pre_div > MISC_CLK_DIV_MASK) {
 		dev_err(meson->chip.dev, "unable to get period pre_div\n");
 		return -EINVAL;
 	}
 
-	cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
+	cnt = div64_u64(fin_freq * period, NSEC_PER_SEC * (pre_div + 1));
 	if (cnt > 0xffff) {
 		dev_err(meson->chip.dev, "unable to get period cnt\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(meson->chip.dev, "period=%u pre_div=%u cnt=%u\n", period,
+	dev_dbg(meson->chip.dev, "period=%llu pre_div=%u cnt=%u\n", period,
 		pre_div, cnt);
 
 	if (duty == period) {
@@ -204,14 +205,13 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 		channel->lo = cnt;
 	} else {
 		/* Then check is we can have the duty with the same pre_div */
-		duty_cnt = div64_u64(fin_freq * (u64)duty,
-				     NSEC_PER_SEC * (pre_div + 1));
+		duty_cnt = div64_u64(fin_freq * duty, NSEC_PER_SEC * (pre_div + 1));
 		if (duty_cnt > 0xffff) {
 			dev_err(meson->chip.dev, "unable to get duty cycle\n");
 			return -EINVAL;
 		}
 
-		dev_dbg(meson->chip.dev, "duty=%u pre_div=%u duty_cnt=%u\n",
+		dev_dbg(meson->chip.dev, "duty=%llu pre_div=%u duty_cnt=%u\n",
 			duty, pre_div, duty_cnt);
 
 		channel->pre_div = pre_div;

