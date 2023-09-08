Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775A9798054
	for <lists+stable@lfdr.de>; Fri,  8 Sep 2023 03:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjIHBma (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 21:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjIHBma (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 21:42:30 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA0919BD
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 18:42:26 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-501bef6e0d3so2671225e87.1
        for <stable@vger.kernel.org>; Thu, 07 Sep 2023 18:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694137344; x=1694742144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNhDAr9U/KJFxgkGy8ktzjClHhQu/DsNA4z0+swql8k=;
        b=GHLFS9P0zlYJGHJt/cHjC2X0PWFrSq6t5zvnyU7UHFb3tpJzZvBxdgxYpf32AzpSf6
         RtLAi714Xe9YrG5WxdKn2U9uELZNTA1rHCZyX1nfKDzg7RaAr6Po+ZTMpM5X0Lvmr/w6
         eR+JwbCrfXYHzs3SbOc3uiIwXGbHi/UkHuPe+zvw5pnYbHmvD4bHLvP02q+ChQ/biQ0N
         bjoL4KDZfde3HdlP8kQPx6Y/yA/4Sv0QUgnN/isvNOcGdrKo02RmXRvI2Io1+TV1WB/k
         Wu007k0YZoQTRplrMb3hgySMY3wbHGIp5c3g4lJ6rHrKF1o6ZR7qsFNjvfpq4a1k776c
         azJQ==
X-Gm-Message-State: AOJu0YyrB8dpMlV0MkD0JPLx1iHZBM7l42EEO8BUyK1C1+WLRwlfI2kb
        dOzF6aklQ5IBLNqPanY4uSsKK7jLyViKWg==
X-Google-Smtp-Source: AGHT+IF7PAen8skStxwHFQre2QEKCiEIDPP5xEaeU5hQIF1bfYSgTML7U76wVK1gwSWIvRMXXgVabw==
X-Received: by 2002:ac2:5b4d:0:b0:4fd:fd97:a77b with SMTP id i13-20020ac25b4d000000b004fdfd97a77bmr691860lfp.50.1694137343807;
        Thu, 07 Sep 2023 18:42:23 -0700 (PDT)
Received: from white.. ([94.204.198.68])
        by smtp.googlemail.com with ESMTPSA id z13-20020a19f70d000000b005007fc9cccasm122899lfe.94.2023.09.07.18.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 18:42:23 -0700 (PDT)
From:   "Denis Efremov (Oracle)" <efremov@linux.com>
To:     stable@vger.kernel.org
Cc:     Duoming Zhou <duoming@zju.edu.cn>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Denis Efremov <efremov@linux.com>
Subject: [PATCH] Input: cyttsp4_core - change del_timer_sync() to timer_shutdown_sync()
Date:   Fri,  8 Sep 2023 05:41:35 +0400
Message-ID: <20230908014144.61151-1-efremov@linux.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Duoming Zhou <duoming@zju.edu.cn>

The watchdog_timer can schedule tx_timeout_task and watchdog_work
can also arm watchdog_timer. The process is shown below:

----------- timer schedules work ------------
cyttsp4_watchdog_timer() //timer handler
  schedule_work(&cd->watchdog_work)

----------- work arms timer ------------
cyttsp4_watchdog_work() //workqueue callback function
  cyttsp4_start_wd_timer()
    mod_timer(&cd->watchdog_timer, ...)

Although del_timer_sync() and cancel_work_sync() are called in
cyttsp4_remove(), the timer and workqueue could still be rearmed.
As a result, the possible use after free bugs could happen. The
process is shown below:

  (cleanup routine)           |  (timer and workqueue routine)
cyttsp4_remove()              | cyttsp4_watchdog_timer() //timer
  cyttsp4_stop_wd_timer()     |   schedule_work()
    del_timer_sync()          |
                              | cyttsp4_watchdog_work() //worker
                              |   cyttsp4_start_wd_timer()
                              |     mod_timer()
    cancel_work_sync()        |
                              | cyttsp4_watchdog_timer() //timer
                              |   schedule_work()
    del_timer_sync()          |
  kfree(cd) //FREE            |
                              | cyttsp4_watchdog_work() // reschedule!
                              |   cd-> //USE

This patch changes del_timer_sync() to timer_shutdown_sync(),
which could prevent rearming of the timer from the workqueue.

Cc: stable@vger.kernel.org
Fixes: CVE-2023-4134
Fixes: 17fb1563d69b ("Input: cyttsp4 - add core driver for Cypress TMA4XX touchscreen devices")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Link: https://lore.kernel.org/r/20230421082919.8471-1-duoming@zju.edu.cn
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Denis Efremov (Oracle) <efremov@linux.com>
---

I've only added Cc: stable and Fixes tag.

 drivers/input/touchscreen/cyttsp4_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
index dccbcb942fe5..f999265896f4 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -1263,9 +1263,8 @@ static void cyttsp4_stop_wd_timer(struct cyttsp4 *cd)
 	 * Ensure we wait until the watchdog timer
 	 * running on a different CPU finishes
 	 */
-	del_timer_sync(&cd->watchdog_timer);
+	timer_shutdown_sync(&cd->watchdog_timer);
 	cancel_work_sync(&cd->watchdog_work);
-	del_timer_sync(&cd->watchdog_timer);
 }
 
 static void cyttsp4_watchdog_timer(struct timer_list *t)
-- 
2.42.0

