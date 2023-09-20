Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C817A7B55
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbjITLvS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbjITLvO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:51:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31763123
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:51:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A539C433C7;
        Wed, 20 Sep 2023 11:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210662;
        bh=R3VJcJGvWo1CGSgS/HY74S8kfIsxB5Gef0pchBpgptk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HqtSNgn6HP5gXHHppo4IqCno5iBjIfnDHqgJivu7jSdJbib4az27O18aEw1A2Pxid
         WrgOk0lVtPBv5cCgDOReLgm6JdFZfVrOEoLGJo1Qa5PSF/Yti3b/brF2e7H71SW8uO
         pyN4TfyVjpT8Py92KWR590Co8Jt12G5mP6LJhWEo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 132/211] printk: Rename abandon_console_lock_in_panic() to other_cpu_in_panic()
Date:   Wed, 20 Sep 2023 13:29:36 +0200
Message-ID: <20230920112849.909622784@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Ogness <john.ogness@linutronix.de>

[ Upstream commit 132a90d1527fedba2d95085c951ccf00dbbebe41 ]

Currently abandon_console_lock_in_panic() is only used to determine if
the current CPU should immediately release the console lock because
another CPU is in panic. However, later this function will be used by
the CPU to immediately release other resources in this situation.

Rename the function to other_cpu_in_panic(), which is a better
description and does not assume it is related to the console lock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20230717194607.145135-8-john.ogness@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/internal.h |  2 ++
 kernel/printk/printk.c   | 15 ++++++++-------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 2a17704136f1d..7d4979d5c3ce6 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -103,3 +103,5 @@ struct printk_message {
 	u64			seq;
 	unsigned long		dropped;
 };
+
+bool other_cpu_in_panic(void);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d5e29fad84234..08a9419046b65 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2590,11 +2590,12 @@ static int console_cpu_notify(unsigned int cpu)
 }
 
 /*
- * Return true when this CPU should unlock console_sem without pushing all
- * messages to the console. This reduces the chance that the console is
- * locked when the panic CPU tries to use it.
+ * Return true if a panic is in progress on a remote CPU.
+ *
+ * On true, the local CPU should immediately release any printing resources
+ * that may be needed by the panic CPU.
  */
-static bool abandon_console_lock_in_panic(void)
+bool other_cpu_in_panic(void)
 {
 	if (!panic_in_progress())
 		return false;
@@ -2621,7 +2622,7 @@ void console_lock(void)
 	might_sleep();
 
 	/* On panic, the console_lock must be left to the panic cpu. */
-	while (abandon_console_lock_in_panic())
+	while (other_cpu_in_panic())
 		msleep(1000);
 
 	down_console_sem();
@@ -2643,7 +2644,7 @@ EXPORT_SYMBOL(console_lock);
 int console_trylock(void)
 {
 	/* On panic, the console_lock must be left to the panic cpu. */
-	if (abandon_console_lock_in_panic())
+	if (other_cpu_in_panic())
 		return 0;
 	if (down_trylock_console_sem())
 		return 0;
@@ -2959,7 +2960,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 			any_progress = true;
 
 			/* Allow panic_cpu to take over the consoles safely. */
-			if (abandon_console_lock_in_panic())
+			if (other_cpu_in_panic())
 				goto abandon;
 
 			if (do_cond_resched)
-- 
2.40.1



