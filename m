Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB247783A9
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 00:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjHJWbp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 10 Aug 2023 18:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHJWbo (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 Aug 2023 18:31:44 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541B72D40
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 15:31:44 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79194701ce9so21829839f.1
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 15:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691706703; x=1692311503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvKdE8ov3ErXeQo1tSmUbnT+zcxhKxhVI+I04ceBn70=;
        b=j0RxOooc1Wm4XSFrbZw1NRX+klj04YstmGYAaOElQTxNp9D+O+Nxdhkh8EFAmrkH0T
         J9/IMk13xp5nCqiZ8t1HUMQI+ha6SkShozT8Xx7iNav1wnwvpReJCxxILFYcTOIeH9KB
         A067hGHKG3OwUEmPxsV6Qms9LcVoXiNsPwA+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691706703; x=1692311503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvKdE8ov3ErXeQo1tSmUbnT+zcxhKxhVI+I04ceBn70=;
        b=OwqPOvYTPfaWvJBJGxAUhiE37cIbWuChbZWSLZgVuUDZiuYYT5YuQdktvqeZAOoENI
         mW9A6xkBbiG2cyt5iLamPMPnReldy5zRDMJMGBKl02lkd6HjZ/gkcJZwIfiznofrK/wk
         hFdNcerh1xPaNxB30qolZIXhtd9apIfRNoi9L78X8POc5/eNwf7X6Yr81arTIzguniuL
         vP91ueqx4GXfO8dPoxPSgX2ksiPjF/fWYxbbTaWlDOnKdPsSH5LzMGETsGw/7g7XoWfx
         XzbTgmz8InEx8OsxgHUgY4diqecBn9wF4mLwUj3eMfLHwuA1kMXFVUhKH1JoG2nkPvup
         Xknw==
X-Gm-Message-State: AOJu0YzzVPb5HVpwaBhBu8TrBSDmz1u+0aX4dTQ9kAq4Xjf0D63kJXCC
        1+joMDmnarRWk0epGT/5eSJTzXIGz35HPILrnxI=
X-Google-Smtp-Source: AGHT+IGAb7iuOCkGn1QBac4mKngnucb1lKdcXgNIPLpHm7chJZgLGfap+aO1TwtJd3kAUwmYwNqvQg==
X-Received: by 2002:a05:6602:1b0e:b0:790:9460:6305 with SMTP id dk14-20020a0566021b0e00b0079094606305mr416239iob.9.1691706703232;
        Thu, 10 Aug 2023 15:31:43 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id t4-20020a02c484000000b0042b6cb44429sm676604jam.46.2023.08.10.15.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 15:31:42 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 5.15 2/3] timers/nohz: Switch to ONESHOT_STOPPED in the low-res handler when the tick is stopped
Date:   Thu, 10 Aug 2023 22:31:36 +0000
Message-ID: <20230810223137.596671-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
In-Reply-To: <20230810223137.596671-1-joel@joelfernandes.org>
References: <20230810223137.596671-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit 5417ddc1cf1f5c8cba31ab217cf57ada7ab6ea88 ]

When tick_nohz_stop_tick() stops the tick and high resolution timers are
disabled, then the clock event device is not put into ONESHOT_STOPPED
mode. This can lead to spurious timer interrupts with some clock event
device drivers that don't shut down entirely after firing.

Eliminate these by putting the device into ONESHOT_STOPPED mode at points
where it is not being reprogrammed. When there are no timers active, then
tick_program_event() with KTIME_MAX can be used to stop the device. When
there is a timer active, the device can be stopped at the next tick (any
new timer added by timers will reprogram the tick).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220422141446.915024-1-npiggin@gmail.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/time/tick-sched.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 7701c720dc1f..5786e2794ae1 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -950,6 +950,8 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	if (unlikely(expires == KTIME_MAX)) {
 		if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
 			hrtimer_cancel(&ts->sched_timer);
+		else
+			tick_program_event(KTIME_MAX, 1);
 		return;
 	}
 
@@ -1356,9 +1358,15 @@ static void tick_nohz_handler(struct clock_event_device *dev)
 	tick_sched_do_timer(ts, now);
 	tick_sched_handle(ts, regs);
 
-	/* No need to reprogram if we are running tickless  */
-	if (unlikely(ts->tick_stopped))
+	if (unlikely(ts->tick_stopped)) {
+		/*
+		 * The clockevent device is not reprogrammed, so change the
+		 * clock event device to ONESHOT_STOPPED to avoid spurious
+		 * interrupts on devices which might not be truly one shot.
+		 */
+		tick_program_event(KTIME_MAX, 1);
 		return;
+	}
 
 	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
 	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
-- 
2.41.0.640.ga95def55d0-goog

