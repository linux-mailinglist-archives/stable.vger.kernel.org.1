Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999ED77A4D3
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 05:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjHMDQH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 23:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHMDQG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 23:16:06 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276C2E8
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 20:16:08 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a6f3ef3155so2736439b6e.1
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 20:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691896567; x=1692501367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eQk/DvHXwDm/vjttceN09hBUZvnOhdElRxFKmg4QSaI=;
        b=ZjPw/qT9kk3YEL6h3EXNxFEYnkajlOrg4Ez1GPehDvsIyLQRYK1+uzelRLHJiswB0W
         V9voNrw3WS07GmGBbI/h/MZi8SNmV+YS3JX39mt0E3b/O2J3BWEW6+bBoGvuToHkbSbL
         3rQHyXoYyg9oOC7oWqkPMq9GiPAqydRk26WtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691896567; x=1692501367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQk/DvHXwDm/vjttceN09hBUZvnOhdElRxFKmg4QSaI=;
        b=bHT0ecBukL2cOx1lBNi/tBUfkX3CkhJJgunTfB7edAGaK6AASu65fvx3nB+NjHPYqT
         3oyJACz/93DDiKnK/ykPyv6ZUb6NZsPl8g0LuVKqNhPbHfJMNKgj7CDc9RR5UFzoTkct
         et9X6Xn7XiTmupT8oHOgxv//CzXXofEThMAgCdAry0pPIoTIDV89RJW++bOcB9t8AZOJ
         zSxLMfqNVQjWE+EozCpZi323Bsido5p9C294bmn5e7hh91rAb+nXa1/Rtp/WIlsLe63d
         HwV99kV6A30tH7tPq/vX1Iq8LyE0uUW4quFNfbPke59AFJfpMMFxk/qVnhpJeimxFcf0
         mmqQ==
X-Gm-Message-State: AOJu0Yx2ndx8gqgvjtOJYkwRHnGg6c+LU3MtrWeOndjIvvS3QW7S85yU
        Fflbi1LpPd8+LaXxwyTfk1Nr7yr6XjfkCDn7+C8=
X-Google-Smtp-Source: AGHT+IE2kLPDq9vm0g5vtfD9GGb0oN3xwCMXeexB3SbQwfCsWcJF9xZ4SKGN3fT9rG/VPpXfbY3XCA==
X-Received: by 2002:a54:4819:0:b0:3a7:38c5:bc18 with SMTP id j25-20020a544819000000b003a738c5bc18mr5713306oij.32.1691896566923;
        Sat, 12 Aug 2023 20:16:06 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id y19-20020a02a393000000b0042b0f3f9367sm2169737jak.129.2023.08.12.20.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 20:16:06 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 5.10 1/3] torture: Fix hang during kthread shutdown phase
Date:   Sun, 13 Aug 2023 03:15:34 +0000
Message-ID: <20230813031536.2166337-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
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

From: Joel Fernandes <joel@joelfernandes.org>

During shutdown of rcutorture, the shutdown thread in
rcu_torture_cleanup() calls torture_cleanup_begin() which sets fullstop
to FULLSTOP_RMMOD. This is enough to cause the rcutorture threads for
readers and fakewriters to breakout of their main while loop and start
shutting down.

Once out of their main loop, they then call torture_kthread_stopping()
which in turn waits for kthread_stop() to be called, however
rcu_torture_cleanup() has not even called kthread_stop() on those
threads yet, it does that a bit later.  However, before it gets a chance
to do so, torture_kthread_stopping() calls
schedule_timeout_interruptible(1) in a tight loop. Tracing confirmed
this makes the timer softirq constantly execute timer callbacks, while
never returning back to the softirq exit path and is essentially "locked
up" because of that. If the softirq preempts the shutdown thread,
kthread_stop() may never be called.

This commit improves the situation dramatically, by increasing timeout
passed to schedule_timeout_interruptible() 1/20th of a second. This
causes the timer softirq to not lock up a CPU and everything works fine.
Testing has shown 100 runs of TREE07 passing reliably, which was not the
case before because of RCU stalls.

Cc: Paul McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc: <stable@vger.kernel.org> # 6.0.x
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 kernel/torture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 1061492f14bd..477d9b601438 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -788,7 +788,7 @@ void torture_kthread_stopping(char *title)
 	VERBOSE_TOROUT_STRING(buf);
 	while (!kthread_should_stop()) {
 		torture_shutdown_absorb(title);
-		schedule_timeout_uninterruptible(1);
+		schedule_timeout_uninterruptible(HZ/20);
 	}
 }
 EXPORT_SYMBOL_GPL(torture_kthread_stopping);
-- 
2.41.0.640.ga95def55d0-goog

