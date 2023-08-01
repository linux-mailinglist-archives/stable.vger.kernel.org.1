Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710B876ACF2
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjHAJYd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjHAJYQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:24:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E732CF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:23:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05EA5614FB
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119F6C433C8;
        Tue,  1 Aug 2023 09:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881793;
        bh=FCShCS+fCSQ+GKKgeu38iIvgOPgpJor28S1Rai/MqqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=teJBKoQw8QP9jv8Sbsuzw66DPoGnSACJfGMRF34L6sQZ0X8yYX9ObnRvH+Ul1MNG0
         EipAxH6nflqjoWz4smD3NHDXAXTqco6eYT629sh/rEO9v2+jndDlpX6nEr+zx+fWMC
         QTg2E6nwD0M9u7oXUXt7cRzXOHUTCSbvRHaIi7g8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 032/155] pwm: meson: fix handling of period/duty if greater than UINT_MAX
Date:   Tue,  1 Aug 2023 11:19:04 +0200
Message-ID: <20230801091911.338480266@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 87a2cbf02d7701255f9fcca7e5bd864a7bb397cf ]

state->period/duty are of type u64, and if their value is greater than
UINT_MAX, then the cast to uint will cause problems. Fix this by
changing the type of the respective local variables to u64.

Fixes: b79c3670e120 ("pwm: meson: Don't duplicate the polarity internally")
Cc: stable@vger.kernel.org
Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-meson.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 37bbad88a3ee5..ec6a544d6f526 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -163,8 +163,9 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 			  const struct pwm_state *state)
 {
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
-	unsigned int duty, period, pre_div, cnt, duty_cnt;
+	unsigned int pre_div, cnt, duty_cnt;
 	unsigned long fin_freq;
+	u64 duty, period;
 
 	duty = state->duty_cycle;
 	period = state->period;
@@ -186,19 +187,19 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 
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
@@ -211,14 +212,13 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
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
-- 
2.39.2



