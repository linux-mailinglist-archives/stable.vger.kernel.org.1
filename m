Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8618377A4D5
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 05:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjHMDQJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 23:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjHMDQH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 23:16:07 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5A0E54
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 20:16:09 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34911a634edso12610215ab.0
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 20:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691896569; x=1692501369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4TcyAdXtvQmY1m7YqyEig6CsLGhynC1fUmr3aQGp7w=;
        b=TGpcG9junm1yPR7uSRWjpiMJWbTpdxIDcVEEgQeIBsufZjm8YLM9+mfyb4na3HShbm
         WqhV37JYZyftI6Q4YW3Edx8TkbhiF33DJXjQs66I5FvPjdhW+AVZgiOzxn5fhirHbNI3
         kEDn5o479+2LQGDdGhqiSGeFgrsC/yP7CTnXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691896569; x=1692501369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4TcyAdXtvQmY1m7YqyEig6CsLGhynC1fUmr3aQGp7w=;
        b=Y74T6HnOyL/Cvl5emNakkt20BnXsa97MxX8OcA65d2aRAg+MN0udQnzppwL2Ao+4VT
         frK+Xfup0lkIP1A+ya3vDmFeA+5MYjtZcoa+MbCBqZLulQV6okSzfcuYvYHpQzQjkTh+
         KzQUHG+WmA4FDojOzncp5nkhhcZRJnAd5ugWbhCL55XOiMEX903dC0TXQxOL+5ODpy1k
         1iPBFghGgILo+103WSouMiSmprtyKkj7Ac408vajFITCsS1tUE1bKM4guvJZC5E87Fwn
         PsSaadPslvobHYQjwCNdBAO15wGBvxh8aA6QCC3HHBe1Y67f7RrCF/I1QUUIAYwNPftp
         Pvlg==
X-Gm-Message-State: AOJu0YxwJBIBJ1kH/ETJN0immCUiLgzbNHF4Nj/xHu9Y2RwzZqK2hGGB
        apw9UJDUIe+luzAknEuOCi3AWp49nVJn8MCTDsw=
X-Google-Smtp-Source: AGHT+IFg2mIPnR7CkFoHhKL33O+R/HUm/oKLzR/rzVk3TKo0f1Yo4Ad/eGpXQ2VlRDG5HWTBfiUKmA==
X-Received: by 2002:a5d:89c1:0:b0:791:1e87:b47e with SMTP id a1-20020a5d89c1000000b007911e87b47emr7771943iot.15.1691896568822;
        Sat, 12 Aug 2023 20:16:08 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id y19-20020a02a393000000b0042b0f3f9367sm2169737jak.129.2023.08.12.20.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 20:16:08 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 5.10 3/3] timers/nohz: Switch to ONESHOT_STOPPED in the low-res handler when the tick is stopped
Date:   Sun, 13 Aug 2023 03:15:36 +0000
Message-ID: <20230813031536.2166337-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
In-Reply-To: <20230813031536.2166337-1-joel@joelfernandes.org>
References: <20230813031536.2166337-1-joel@joelfernandes.org>
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

