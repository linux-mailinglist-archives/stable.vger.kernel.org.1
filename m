Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B506877B035
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 05:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjHNDkT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 23:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjHNDjh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 23:39:37 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26025E7E
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 20:39:37 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-349783c5d43so18104065ab.3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 20:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691984376; x=1692589176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DiCIpLoZIVTvTz8kjgXgLJw3p3qW48GN2/4t5RLPhfo=;
        b=DvwYitdN8bQdpv+VOi4sbNKINK7kNCwMXi/lJo7PRLjRPG0Yx/G8kDH0awEwUYxzbE
         D2T25Y9B39InKXEeSPSVyRLFN/60tS1Y6oeUNfB+LL/nN8A3dHiqoLoQv9X7mMbwkFAs
         5jA03tktkAdIMKAiIRjpYBRMHPMmvTYPBDc/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691984376; x=1692589176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DiCIpLoZIVTvTz8kjgXgLJw3p3qW48GN2/4t5RLPhfo=;
        b=YD+Dm1WzYRYjvmZAXUOXUvYc0pgZJKNKIMbzI3WDvdq8hzsmaIo1FLliI+tG5Xftng
         xrEFZrucFgDkmDJLuNmi1oaz6jalcnyC1/CEB6x5E0AW9saGA3sEluiB6IYCv8slA33f
         BG8K9Hur/24CX3mcooUxdCbfgF/folVXOzEfaNb/76b/R6ztEwTU7x8s9wON9IM4h7nF
         vhrUflx+6jbpKfMhFvwJjIXQaggKDmG9/MsgB5bDhRRD5iiAPv2vzSXuqV7M4BnqhQcd
         pYleoPTpXcNY7JV6S+OKpt/LCNszSZQq6rtAr9/e2SEba0lFVuPxcL6B3C+3g5iw66pV
         0c5A==
X-Gm-Message-State: AOJu0Yy3ggZcQrjkaJJtVmQPROpVv0GsXd9Nfg0CMp35ud1TPrvQnKEE
        TbT2Vn9KA7wSGOHa0KlZrwdQADvfj65CJBp0/AI=
X-Google-Smtp-Source: AGHT+IH/Gfy2SGGDO4YM/UVH39gE7nT3b39ng7+D8E/9++w7bncKr+vGh1N1qiEB4xQvwo4EQMDr4g==
X-Received: by 2002:a05:6e02:1c0f:b0:348:fe78:e9d6 with SMTP id l15-20020a056e021c0f00b00348fe78e9d6mr13268418ilh.0.1691984376025;
        Sun, 13 Aug 2023 20:39:36 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id m16-20020a92cad0000000b003493a5b3858sm2904232ilq.34.2023.08.13.20.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 20:39:35 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 5.10 1/3] torture: Fix hang during kthread shutdown phase
Date:   Mon, 14 Aug 2023 03:39:31 +0000
Message-ID: <20230814033934.1165010-1-joel@joelfernandes.org>
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

