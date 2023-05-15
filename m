Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC807039EC
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244593AbjEORqu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244594AbjEORq2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:46:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA731561B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:45:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0A1C62EAC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22F3C4339B;
        Mon, 15 May 2023 17:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172700;
        bh=aBBCA1aXK0AKvxDXedzNMKgiEz5iwmDxJ1EHM0QpqOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sQa7FKsh0XU9PD0NYEWAj8eWF3a3u7I7y5s1W6qASUPeLHnred9/RND5Bo7/wi+Jm
         +yaMLmHmYW0EWmUjIdvdVJSD4uB5Ec4mi51HlNpWmzo6MbZAxEHqj1ofVRp+rIP7r4
         F/dJgBlY4TRL4ZNUViUmp6WzejxBYgHaKlvU93dk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Petr Mladek <pmladek@suse.com>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 239/381] workqueue: Fix hung time report of worker pools
Date:   Mon, 15 May 2023 18:28:10 +0200
Message-Id: <20230515161747.500995746@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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
 kernel/workqueue.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7f57fed719957..b9041ab881bc8 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4816,16 +4816,19 @@ void show_workqueue_state(void)
 	for_each_pool(pool, pi) {
 		struct worker *worker;
 		bool first = true;
+		unsigned long hung = 0;
 
 		raw_spin_lock_irqsave(&pool->lock, flags);
 		if (pool->nr_workers == pool->nr_idle)
 			goto next_pool;
 
+		/* How long the first pending work is waiting for a worker. */
+		if (!list_empty(&pool->worklist))
+			hung = jiffies_to_msecs(jiffies - pool->watchdog_ts) / 1000;
+
 		pr_info("pool %d:", pool->id);
 		pr_cont_pool_info(pool);
-		pr_cont(" hung=%us workers=%d",
-			jiffies_to_msecs(jiffies - pool->watchdog_ts) / 1000,
-			pool->nr_workers);
+		pr_cont(" hung=%lus workers=%d", hung, pool->nr_workers);
 		if (pool->manager)
 			pr_cont(" manager: %d",
 				task_pid_nr(pool->manager->task));
-- 
2.39.2



