Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D88377B037
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 05:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjHNDkV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 23:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjHNDjj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 23:39:39 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DF210F5
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 20:39:39 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34961362f67so11743575ab.0
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 20:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691984378; x=1692589178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpAA6A4kQ5WLnkQwEOiIbl0MYH36QSxS7aU0fFOPHYE=;
        b=qDHJ3Lt37oNct7eb2CQ9jVXKiFy55njvFvxpl8FVjROt/Gm+yZiOI1/v9cavd+4wfY
         W6KHNPSf3A9i4wHmyXk3XQUJ/mjPl6xzlrcK6T3eeJL/FTW7Y9XL9hOhzsJx7YX8Ei94
         SeUy0+p1j4VaLXS7FVtbuWTUv+DzwnEuHDJzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691984378; x=1692589178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpAA6A4kQ5WLnkQwEOiIbl0MYH36QSxS7aU0fFOPHYE=;
        b=Gm3hOXyaM1x3u3AkQxfzycneHUGX1DXcQgClG1mUxKRhnmqRK/nazgBDg1Lfpk4ew+
         RdWCIikj8FVdKvds2KR8nG1mHOTFFO4DhPSyGcltvwTTzuMcXyXyC6UbPt84dGZ+mV4u
         2hCYwe7M4L7CIWmnXmFbxtR5Fc21IllvAMUm2y/VL1iiNERCdAxEBXy5LTYuSPaIadK7
         tyVOpjayKI7WIPlg5sKN+xpKrrmEkxGvPQqPE1Fa7Pa8efgktNQjeP1+wevt0vngR6Jx
         d9/0IQTGRCm6DGF7dL+TolpBaxBWZuTpJQIiE1HZUP7CQHWp+Yn9KnIZpYzXVkpmr1eJ
         vM5A==
X-Gm-Message-State: AOJu0YyaKMHWeB+vcNhV7eIVQ46HcONzYAe7wuOpRvfEOaJJvEB0eTfO
        JurLvM+SKoqt5xA4AUMegEnRYAhx31gZ052kNo0=
X-Google-Smtp-Source: AGHT+IHwyb990j/NbE++LXhOxqMN9zAxb1QFAbNqUfHwwCW3dPgGL/VP9XAJV7Vo7KaVjWy8tPPfHw==
X-Received: by 2002:a05:6e02:1789:b0:348:cb33:a3a6 with SMTP id y9-20020a056e02178900b00348cb33a3a6mr13124509ilu.0.1691984378071;
        Sun, 13 Aug 2023 20:39:38 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id m16-20020a92cad0000000b003493a5b3858sm2904232ilq.34.2023.08.13.20.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 20:39:37 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 5.10 3/3] timers/nohz: Switch to ONESHOT_STOPPED in the low-res handler when the tick is stopped
Date:   Mon, 14 Aug 2023 03:39:33 +0000
Message-ID: <20230814033934.1165010-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
In-Reply-To: <20230814033934.1165010-1-joel@joelfernandes.org>
References: <20230814033934.1165010-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit 62c1256d544747b38e77ca9b5bfe3a26f9592576 ]

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
index bb51619c9b63..fc79b04b5947 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -884,6 +884,8 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	if (unlikely(expires == KTIME_MAX)) {
 		if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
 			hrtimer_cancel(&ts->sched_timer);
+		else
+			tick_program_event(KTIME_MAX, 1);
 		return;
 	}
 
@@ -1274,9 +1276,15 @@ static void tick_nohz_handler(struct clock_event_device *dev)
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

