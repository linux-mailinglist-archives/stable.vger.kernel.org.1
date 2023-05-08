Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730D76FAC79
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbjEHLY4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbjEHLYh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:24:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1CE39B98
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:24:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46E7A62D37
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56573C433D2;
        Mon,  8 May 2023 11:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545073;
        bh=qsGsqDNzEEAAuLw5D7pi2FKVSXaQPg5MW2RmfWFuMPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BTMjAhQQLHeL9IEugJU3HqcCvE3iuiF8/6reJrSYS2cKEsPO1nXHl79mfna3EASrQ
         UWG43gHUt8Z0o9HCV2U+uo75ZhOqz74184zx6hwI1oslREk4Obk7ShZeaDeC1PybxQ
         3fSTdZJM2Dn3ZBTMFv5fEXsJDFo66UR90ER5J86o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Petr Mladek <pmladek@suse.com>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 584/694] workqueue: Fix hung time report of worker pools
Date:   Mon,  8 May 2023 11:46:59 +0200
Message-Id: <20230508094453.963193325@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Petr Mladek <pmladek@suse.com>

[ Upstream commit 335a42ebb0ca8ee9997a1731aaaae6dcd704c113 ]

The workqueue watchdog prints a warning when there is no progress in
a worker pool. Where the progress means that the pool started processing
a pending work item.

Note that it is perfectly fine to process work items much longer.
The progress should be guaranteed by waking up or creating idle
workers.

show_one_worker_pool() prints state of non-idle worker pool. It shows
a delay since the last pool->watchdog_ts.

The timestamp is updated when a first pending work is queued in
__queue_work(). Also it is updated when a work is dequeued for
processing in worker_thread() and rescuer_thread().

The delay is misleading when there is no pending work item. In this
case it shows how long the last work item is being proceed. Show
zero instead. There is no stall if there is no pending work.

Fixes: 82607adcf9cdf40fb7b ("workqueue: implement lockup detector")
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b8b541caed485..2be9b0ecf22ce 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5002,10 +5002,16 @@ static void show_one_worker_pool(struct worker_pool *pool)
 	struct worker *worker;
 	bool first = true;
 	unsigned long flags;
+	unsigned long hung = 0;
 
 	raw_spin_lock_irqsave(&pool->lock, flags);
 	if (pool->nr_workers == pool->nr_idle)
 		goto next_pool;
+
+	/* How long the first pending work is waiting for a worker. */
+	if (!list_empty(&pool->worklist))
+		hung = jiffies_to_msecs(jiffies - pool->watchdog_ts) / 1000;
+
 	/*
 	 * Defer printing to avoid deadlocks in console drivers that
 	 * queue work while holding locks also taken in their write
@@ -5014,9 +5020,7 @@ static void show_one_worker_pool(struct worker_pool *pool)
 	printk_deferred_enter();
 	pr_info("pool %d:", pool->id);
 	pr_cont_pool_info(pool);
-	pr_cont(" hung=%us workers=%d",
-		jiffies_to_msecs(jiffies - pool->watchdog_ts) / 1000,
-		pool->nr_workers);
+	pr_cont(" hung=%lus workers=%d", hung, pool->nr_workers);
 	if (pool->manager)
 		pr_cont(" manager: %d",
 			task_pid_nr(pool->manager->task));
-- 
2.39.2



