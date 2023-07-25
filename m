Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C497616C3
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjGYLmS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbjGYLmD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:42:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E12F1FD6
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E12DA616B1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F061FC433C8;
        Tue, 25 Jul 2023 11:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285269;
        bh=P2vZzc0yNunCqRygLB+U5x07HDrOjbYvb8i+mkvc/aI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aR81TN6OgggbxGmbRPynoNYrjOgb91TPat+3C64AWsfNIbEMXTobYYMuEZAVLSQNF
         zRZBDxL4i1Dkt8viVacwXLTN66XtSwJr7CSGpoiHypo2zH/H2keuDIVdjxJnpW4hg0
         Mpaln4ssGEoeVzAQZICyeFrdyHQIpYxhJ/7migK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Brian Norris <briannorris@chromium.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 144/313] pwm: sysfs: Do not apply state to already disabled PWMs
Date:   Tue, 25 Jul 2023 12:44:57 +0200
Message-ID: <20230725104527.222886527@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
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

From: Marek Vasut <marex@denx.de>

[ Upstream commit 38ba83598633373f47951384cfc389181c8d1bed ]

If the PWM is exported but not enabled, do not call pwm_class_apply_state().
First of all, in this case, period may still be unconfigured and this would
make pwm_class_apply_state() return -EINVAL, and then suspend would fail.
Second, it makes little sense to apply state onto PWM that is not enabled
before suspend.

Failing case:
"
$ echo 1 > /sys/class/pwm/pwmchip4/export
$ echo mem > /sys/power/state
...
pwm pwmchip4: PM: dpm_run_callback(): pwm_class_suspend+0x1/0xa8 returns -22
pwm pwmchip4: PM: failed to suspend: error -22
PM: Some devices failed to suspend, or early wake event detected
"

Working case:
"
$ echo 1 > /sys/class/pwm/pwmchip4/export
$ echo 100 > /sys/class/pwm/pwmchip4/pwm1/period
$ echo 10 > /sys/class/pwm/pwmchip4/pwm1/duty_cycle
$ echo mem > /sys/power/state
...
"

Do not call pwm_class_apply_state() in case the PWM is disabled
to fix this issue.

Fixes: 7fd4edc57bbae ("pwm: sysfs: Add suspend/resume support")
Signed-off-by: Marek Vasut <marex@denx.de>
Fixes: ef2bf4997f7d ("pwm: Improve args checking in pwm_apply_state()")
Reviewed-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/sysfs.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 2389b86698468..986f3a29a13d5 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -424,6 +424,13 @@ static int pwm_class_resume_npwm(struct device *parent, unsigned int npwm)
 		if (!export)
 			continue;
 
+		/* If pwmchip was not enabled before suspend, do nothing. */
+		if (!export->suspend.enabled) {
+			/* release lock taken in pwm_class_get_state */
+			mutex_unlock(&export->lock);
+			continue;
+		}
+
 		state.enabled = export->suspend.enabled;
 		ret = pwm_class_apply_state(export, pwm, &state);
 		if (ret < 0)
@@ -448,7 +455,17 @@ static int __maybe_unused pwm_class_suspend(struct device *parent)
 		if (!export)
 			continue;
 
+		/*
+		 * If pwmchip was not enabled before suspend, save
+		 * state for resume time and do nothing else.
+		 */
 		export->suspend = state;
+		if (!state.enabled) {
+			/* release lock taken in pwm_class_get_state */
+			mutex_unlock(&export->lock);
+			continue;
+		}
+
 		state.enabled = false;
 		ret = pwm_class_apply_state(export, pwm, &state);
 		if (ret < 0) {
-- 
2.39.2



