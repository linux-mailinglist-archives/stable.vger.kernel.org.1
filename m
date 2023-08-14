Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B7477B030
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 05:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjHNDjr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 23:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjHNDii (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 23:38:38 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF2D93
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 20:38:03 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7914633a110so186337839f.0
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 20:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691984282; x=1692589082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DiCIpLoZIVTvTz8kjgXgLJw3p3qW48GN2/4t5RLPhfo=;
        b=LlRshHx64L/ZUY2wqqNvjrn7x0zLTypM0Pd4h7cfuqAp913HBhfVriXaD+7nvuR2x/
         +sTgOjh2cynKxukKWB2hXjmAUK46guFmJ3vDoxf2c8tRDVomWI/1oW4DpBLuqmKEvdwb
         uSeSVhL+Vp+pvtQqlop3u8nOtj9fJfr6SWodM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691984282; x=1692589082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DiCIpLoZIVTvTz8kjgXgLJw3p3qW48GN2/4t5RLPhfo=;
        b=PcAHG5dTlPEzYv8bI5sXKl7ksTPaoBAVMEZgyinDSc8LpgbhJb4X3QTui4H4kZETUz
         GHQOZ57iz2fhVGFCZhUa+rQ4ieKHLYs4+XhFMM1DCwQzHFRNqR9LUm0wWkhcRohWRQ0S
         1bBs9hPL1E5oMQA5Jc7aI2hddmDcawotm/cLq1dUoQQESwIA3B7BAf0YUtXajsGdj3mW
         cxZVMZdYfbmCRxoWwXovkKHlEBcRB4L14i4K3iMF6pEph1nhiVTq9tHWFCqOQZK0TTqG
         /Jmv+ZSXAIfT/njAX+lW5G5Zt40tqFzV1hJca6hvZiawZwXn1ecQu3hNwvQU9X9Cuxif
         moAg==
X-Gm-Message-State: AOJu0Yxy6b9TFLeKMaomD+CPLlHM0kBJpw7WIY0PeFldK1KTOQFXmxSe
        H/92y+fUbsZM7VLdn45UMGBaqFi5hAwnvql/mg0=
X-Google-Smtp-Source: AGHT+IFDazEtyqHnedSIw2uDM1kejw3ilJkEdiAWXGgmX8XgltFMJgRjK393mXZ9o+7dNgdQJ0sUyg==
X-Received: by 2002:a5e:aa0d:0:b0:791:31e4:b5da with SMTP id s13-20020a5eaa0d000000b0079131e4b5damr11627795ioe.12.1691984281733;
        Sun, 13 Aug 2023 20:38:01 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id f3-20020a02b783000000b0042b2d43ee3fsm2829449jam.82.2023.08.13.20.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 20:38:01 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     paulmck@kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 1/3] torture: Fix hang during kthread shutdown phase
Date:   Mon, 14 Aug 2023 03:37:57 +0000
Message-ID: <20230814033759.1163527-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
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

From: Joel Fernandes <joel@joelfernandes.org>

[ Upstream commit d52d3a2bf408ff86f3a79560b5cce80efb340239 ]

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

