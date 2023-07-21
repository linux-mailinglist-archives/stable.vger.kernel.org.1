Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDE375D196
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjGUSuh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjGUSue (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:50:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E6435AC
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:50:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82828619FD
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9383CC433CA;
        Fri, 21 Jul 2023 18:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965432;
        bh=ucrisWmY7SYXQLOMoDDvvfr7cUK3XRoWG9xkr+XV0f0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xN+yw0behMKxI5yzRT1NUDVVA44dvhtJ1473x5oAXQHx51tKBRGRXDSqjRXQGq8Th
         dOhSY1KBc7afPgThfdewbzaLL20bznsmFx2SBdU+lIS4rzEBgxFkP1SdkZXPIHxdYr
         nIi0WFaWAP87aGSkrEmK6tFtM7wDFlypi88YmmIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 6.4 253/292] pwm: meson: fix handling of period/duty if greater than UINT_MAX
Date:   Fri, 21 Jul 2023 18:06:02 +0200
Message-ID: <20230721160539.807285728@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

commit 87a2cbf02d7701255f9fcca7e5bd864a7bb397cf upstream.

state->period/duty are of type u64, and if their value is greater than
UINT_MAX, then the cast to uint will cause problems. Fix this by
changing the type of the respective local variables to u64.

Fixes: b79c3670e120 ("pwm: meson: Don't duplicate the polarity internally")
Cc: stable@vger.kernel.org
Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pwm/pwm-meson.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -156,8 +156,9 @@ static int meson_pwm_calc(struct meson_p
 			  const struct pwm_state *state)
 {
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
-	unsigned int duty, period, pre_div, cnt, duty_cnt;
+	unsigned int pre_div, cnt, duty_cnt;
 	unsigned long fin_freq;
+	u64 duty, period;
 
 	duty = state->duty_cycle;
 	period = state->period;
@@ -179,19 +180,19 @@ static int meson_pwm_calc(struct meson_p
 
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
@@ -204,14 +205,13 @@ static int meson_pwm_calc(struct meson_p
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


