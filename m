Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1457375D4D4
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjGUTZY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjGUTZX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:25:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54CD30E1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:25:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34D4A61D54
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43232C433C9;
        Fri, 21 Jul 2023 19:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967520;
        bh=P2nzFaOh88wi6SizWl8zl/ryn8FlEmXuddHIQ3YIDAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gn5EMRyqIv59+5+B6IRclaAZ6Y+lay/jy3lMK0vFfUoeM/WSn6fj5+SMo025E8oxD
         2iglUxcJG8F6LmSo7SffownOtTJVLqfeBCNYvNCKSRYXvez3jibVdZ64YZu4BWHIo9
         t1Ixkmv6OmnUuyEzqDDJRMOEFJ6Fp8GNEIPHV1PM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 6.1 191/223] pwm: meson: modify and simplify calculation in meson_pwm_get_state
Date:   Fri, 21 Jul 2023 18:07:24 +0200
Message-ID: <20230721160529.029287883@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

commit 6b9352f3f8a1a35faf0efc1ad1807ee303467796 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pwm/pwm-meson.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -351,18 +351,8 @@ static int meson_pwm_get_state(struct pw
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
 


