Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8F07A3962
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240022AbjIQTss (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240074AbjIQTsV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:48:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF99A13E
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:48:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8E2C433CB;
        Sun, 17 Sep 2023 19:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980095;
        bh=hTOAsfiY43lOyOlS24RxzyU7xwTUPzYWIHy0q4+sDzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AYbQJ29nzHOTub0jtA//oqyFIPI5N8YelI0CTZVKbFh1cEpeIxnNFowqjDOIeMNAa
         gF8AAGHDkqkFukIHMyfAqF/di/kn+d4VYM2Stfawv+2ESf9IwTTMz2/nUf6yhcuzP4
         AYTIZiw2pSYgzupV1egY/A4B8tH3VU1e3MzDUpyM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Artur Weber <aweber.kernel@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 069/285] backlight: lp855x: Initialize PWM state on first brightness change
Date:   Sun, 17 Sep 2023 21:11:09 +0200
Message-ID: <20230917191054.111835571@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Artur Weber <aweber.kernel@gmail.com>

[ Upstream commit 4c09e20b3c85f60353ace21092e34f35f5e3ab00 ]

As pointed out by Uwe Kleine-König[1], the changes introduced in
commit c1ff7da03e16 ("video: backlight: lp855x: Get PWM for PWM mode
during probe") caused the PWM state set up by the bootloader to be
re-set when the driver is probed. This differs from the behavior from
before that patch, where the PWM state would be initialized on the
first brightness change.

Fix this by moving the PWM state initialization into the PWM control
function. Add a new variable, needs_pwm_init, to the device info struct
to allow us to check whether we need the initialization, or whether it
has already been done.

[1] https://lore.kernel.org/lkml/20230614083953.e4kkweddjz7wztby@pengutronix.de/

Fixes: c1ff7da03e16 ("video: backlight: lp855x: Get PWM for PWM mode during probe")
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20230714121440.7717-2-aweber.kernel@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/lp855x_bl.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index 1c9e921bca14a..349ec324bc1ea 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -71,6 +71,7 @@ struct lp855x {
 	struct device *dev;
 	struct lp855x_platform_data *pdata;
 	struct pwm_device *pwm;
+	bool needs_pwm_init;
 	struct regulator *supply;	/* regulator for VDD input */
 	struct regulator *enable;	/* regulator for EN/VDDIO input */
 };
@@ -220,7 +221,15 @@ static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
 {
 	struct pwm_state state;
 
-	pwm_get_state(lp->pwm, &state);
+	if (lp->needs_pwm_init) {
+		pwm_init_state(lp->pwm, &state);
+		/* Legacy platform data compatibility */
+		if (lp->pdata->period_ns > 0)
+			state.period = lp->pdata->period_ns;
+		lp->needs_pwm_init = false;
+	} else {
+		pwm_get_state(lp->pwm, &state);
+	}
 
 	state.duty_cycle = div_u64(br * state.period, max_br);
 	state.enabled = state.duty_cycle;
@@ -387,7 +396,6 @@ static int lp855x_probe(struct i2c_client *cl)
 	const struct i2c_device_id *id = i2c_client_get_device_id(cl);
 	const struct acpi_device_id *acpi_id = NULL;
 	struct device *dev = &cl->dev;
-	struct pwm_state pwmstate;
 	struct lp855x *lp;
 	int ret;
 
@@ -470,15 +478,11 @@ static int lp855x_probe(struct i2c_client *cl)
 		else
 			return dev_err_probe(dev, ret, "getting PWM\n");
 
+		lp->needs_pwm_init = false;
 		lp->mode = REGISTER_BASED;
 		dev_dbg(dev, "mode: register based\n");
 	} else {
-		pwm_init_state(lp->pwm, &pwmstate);
-		/* Legacy platform data compatibility */
-		if (lp->pdata->period_ns > 0)
-			pwmstate.period = lp->pdata->period_ns;
-		pwm_apply_state(lp->pwm, &pwmstate);
-
+		lp->needs_pwm_init = true;
 		lp->mode = PWM_BASED;
 		dev_dbg(dev, "mode: PWM based\n");
 	}
-- 
2.40.1



