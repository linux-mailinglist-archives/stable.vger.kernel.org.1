Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBA4775C72
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjHIL1Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjHIL1T (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:27:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9EE1FCE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:27:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D27C063234
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB54DC433C7;
        Wed,  9 Aug 2023 11:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580438;
        bh=/G46eWHu+bUDMUzxKT0k2KEYGgnoj3hctBdvpm4fgVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JpOPJ7suUwr1Db2XsDZeKI6d0p6oKyutAa9RFUYDuaxIaikkZBcgjQDvIu5zqHl/e
         PN7ao/BFKnigVnfUsTDcRUzr4NVZZ2mDlWD9QTtSS4tGfza6vn4FdMfascM1IQjzL6
         tAW43/6Q1+wO4K29n83FUTqpYzmpTbyu1mfKsKto=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 025/154] pwm: meson: Simplify duplicated per-channel tracking
Date:   Wed,  9 Aug 2023 12:40:56 +0200
Message-ID: <20230809103637.819992860@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 5f97f18feac9bd5a8163b108aee52d783114b36f ]

The driver tracks per-channel data via struct pwm_device::chip_data and
struct meson_pwm::channels[]. The latter holds the actual data, the former
is only a pointer to the latter. So simplify by using struct
meson_pwm::channels[] consistently.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Stable-dep-of: 87a2cbf02d77 ("pwm: meson: fix handling of period/duty if greater than UINT_MAX")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-meson.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 5cab720d50680..d594dac41f6da 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -147,12 +147,13 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 		return err;
 	}
 
-	return pwm_set_chip_data(pwm, channel);
+	return 0;
 }
 
 static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
+	struct meson_pwm *meson = to_meson_pwm(chip);
+	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 
 	if (channel)
 		clk_disable_unprepare(channel->clk);
@@ -161,7 +162,7 @@ static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 			  const struct pwm_state *state)
 {
-	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
+	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 	unsigned int duty, period, pre_div, cnt, duty_cnt;
 	unsigned long fin_freq;
 
@@ -230,7 +231,7 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 
 static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
 {
-	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
+	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 	struct meson_pwm_channel_data *channel_data;
 	unsigned long flags;
 	u32 value;
@@ -273,8 +274,8 @@ static void meson_pwm_disable(struct meson_pwm *meson, struct pwm_device *pwm)
 static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			   const struct pwm_state *state)
 {
-	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
 	struct meson_pwm *meson = to_meson_pwm(chip);
+	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 	int err = 0;
 
 	if (!state)
-- 
2.39.2



