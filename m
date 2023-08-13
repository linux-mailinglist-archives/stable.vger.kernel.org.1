Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3FC77A4D8
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 05:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjHMDQ0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 23:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjHMDQZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 23:16:25 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C1FE9
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 20:16:28 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-3499936a13eso11745145ab.0
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 20:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691896587; x=1692501387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvKdE8ov3ErXeQo1tSmUbnT+zcxhKxhVI+I04ceBn70=;
        b=X3OsfEu/L3Ab31DBmIy1EdHg0mNupKhdgmJE41Otb7zovusKmDxHSPFKvdibeAWtKX
         4RECC816zlJiyZ/k+RzW7xzmQSP2ocj/s6Y2X+IhUqp2pv0Tu9s5DJBj1IjyMoexyFXC
         rzOtS+gLW3Jdrt0jqy3v9Fq+j3aPYgJ8A4uE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691896587; x=1692501387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvKdE8ov3ErXeQo1tSmUbnT+zcxhKxhVI+I04ceBn70=;
        b=FEg4vZK/S1pFC0fUUQnHgvmCSIaC8THA4mI32btrdyeYCZLEj+DfyNOiyonjGezo2X
         PP1EFNncAnLiYZY2w7E3CAvWgAdZ1MGNnVcR0RGePGqKbFCgMT+rqXa7E/H2uXk0YO4I
         sP7SRWugARd7yUmyKN2pBPlqTRab+EysVt/PPINx4tUbQ33Pm+QVfngPxe5UrqxnfBSw
         LTE0Tezj2LVFUNmC5FK0zaCIDIQBJ54zToNiQWoy84hGvLvNoYbIsQeYJF0AFFXAFVQH
         XLJ7nPgvl7aBPKHhH9qfddqsaV9GlgXNzppj7xOJ3fOfYDV0s5xBYTbDPLKCFAEBThAs
         6JQg==
X-Gm-Message-State: AOJu0YynMhodk0v05Gae/fdRH+1yjaeSyo5KVjZDPgbSmQiRD3ZPIj7z
        cyc0oXtpmadheD6XrsjAeGwgRo/NRp9+iUdnW/0=
X-Google-Smtp-Source: AGHT+IFDf1alcMETbJkKeZ8KPG90hPqOtLYDKASqFB346d05rID2KFynwyCDuOZtttuM+bmYnVA2JQ==
X-Received: by 2002:a05:6e02:b2f:b0:348:8ebc:835d with SMTP id e15-20020a056e020b2f00b003488ebc835dmr9378380ilu.8.1691896587450;
        Sat, 12 Aug 2023 20:16:27 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id em6-20020a0566384da600b0042b0a6d899fsm2106263jab.60.2023.08.12.20.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 20:16:26 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 5.15 2/3] timers/nohz: Switch to ONESHOT_STOPPED in the low-res handler when the tick is stopped
Date:   Sun, 13 Aug 2023 03:16:19 +0000
Message-ID: <20230813031620.2218302-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
In-Reply-To: <20230813031620.2218302-1-joel@joelfernandes.org>
References: <20230813031620.2218302-1-joel@joelfernandes.org>
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

