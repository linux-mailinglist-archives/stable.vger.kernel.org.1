Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2E977B032
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 05:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjHNDjt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 23:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjHNDij (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 23:38:39 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25126130
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 20:38:04 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-34a91e9e9a5so8048995ab.2
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 20:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691984283; x=1692589083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpAA6A4kQ5WLnkQwEOiIbl0MYH36QSxS7aU0fFOPHYE=;
        b=PmwL6tzcrkXrbOCNUSO9Mf054REWoZpK04Ifnc8ZeeYHX9Sc4jts0fhgpwlw688UNk
         CEh2ELUomaYuboBD7ZO/N8Erm2BtK7CQPARSyR6ykvlQt94YlYT+NGUBOryxzwUW0HzE
         WoelYatrrhTY27ovse6X9gAVJ9DimK2DRwn3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691984283; x=1692589083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpAA6A4kQ5WLnkQwEOiIbl0MYH36QSxS7aU0fFOPHYE=;
        b=VG5EE4xCu+pA5GLcas3GhIktb5v+BVRdhaq3nNQPC4W2AXEEBSCknTBpWOFvJZw9sW
         084SV1B4y7xxzTIgTSjlsai4pQBvizDXx9fmOxbm8vb4qZMkk90OIMJEMKD2L9LxAvIC
         xpyMnTNl0yAhRmhXSwQu8Y50NtCz4Sh5nWyKclSW1JXmdHIZ/Kk0O/oyh+hZlZ8vAs1q
         63OCjM7lBzMKv0wxdFjmfhqJff2xWGC+GcjUtzvPVaA+HKIY7J3RA6eqDzCMbIMvoeso
         rVWVuayKsyMO0OMsShwOOVY20ZIbLHi7m/cmDKSsGYwfkNSlfCKIBqXdbdcF0NXWwWQ6
         4geA==
X-Gm-Message-State: AOJu0Yx3btIcnwsmsVpbJ1MwcgE3c8MrIisVUVB3/BAwsJHqy7ZCzIAa
        UALDgpavekcfVCKjXTWnxYv9KFXl7tsrmnDVoh4=
X-Google-Smtp-Source: AGHT+IGYWINOSfT4UsC8I4qqZsCVnQorK70SREvGLKhIFsFcsgyzz+QLilUvqFcGIEkjs0T2VcVNQQ==
X-Received: by 2002:a92:c213:0:b0:34a:a340:c04b with SMTP id j19-20020a92c213000000b0034aa340c04bmr1155483ilo.28.1691984283163;
        Sun, 13 Aug 2023 20:38:03 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id f3-20020a02b783000000b0042b2d43ee3fsm2829449jam.82.2023.08.13.20.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 20:38:02 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     paulmck@kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 3/3] timers/nohz: Switch to ONESHOT_STOPPED in the low-res handler when the tick is stopped
Date:   Mon, 14 Aug 2023 03:37:59 +0000
Message-ID: <20230814033759.1163527-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
In-Reply-To: <20230814033759.1163527-1-joel@joelfernandes.org>
References: <20230814033759.1163527-1-joel@joelfernandes.org>
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

