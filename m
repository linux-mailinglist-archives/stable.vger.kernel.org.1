Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9146FAE97
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbjEHLqM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbjEHLpv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:45:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2895629FE8
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:45:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C5D263636
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41D0C433D2;
        Mon,  8 May 2023 11:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546300;
        bh=HpIR1NVYib/iXzFR4Xo2Lqf1vAQpfvKrvs576Kn8Hbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=alDb0xfGGStb/O/MoA+kfB7KrgB+AWjYCRTwgAlFs7YjT/QqQJLc/xqrTMMNlOJNq
         IAH6FRAKbtxONNpdTbsEx40HF25Ot1ZHchBhH17A7qnvZSnoZXRBforWt5MJY/Wg7k
         8mwyfFpI+25G/OL51wj96Y8bRwGkFyIGHQFMAd4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Schspa Shi <schspa@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dwaine Gonyier <dgonyier@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 291/371] sched/rt: Fix bad task migration for rt tasks
Date:   Mon,  8 May 2023 11:48:12 +0200
Message-Id: <20230508094823.576866468@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Schspa Shi <schspa@gmail.com>

[ Upstream commit feffe5bb274dd3442080ef0e4053746091878799 ]

Commit 95158a89dd50 ("sched,rt: Use the full cpumask for balancing")
allows find_lock_lowest_rq() to pick a task with migration disabled.
The purpose of the commit is to push the current running task on the
CPU that has the migrate_disable() task away.

However, there is a race which allows a migrate_disable() task to be
migrated. Consider:

  CPU0                                    CPU1
  push_rt_task
    check is_migration_disabled(next_task)

                                          task not running and
                                          migration_disabled == 0

    find_lock_lowest_rq(next_task, rq);
      _double_lock_balance(this_rq, busiest);
        raw_spin_rq_unlock(this_rq);
        double_rq_lock(this_rq, busiest);
          <<wait for busiest rq>>
                                              <wakeup>
                                          task become running
                                          migrate_disable();
                                            <context out>
    deactivate_task(rq, next_task, 0);
    set_task_cpu(next_task, lowest_rq->cpu);
      WARN_ON_ONCE(is_migration_disabled(p));

Fixes: 95158a89dd50 ("sched,rt: Use the full cpumask for balancing")
Signed-off-by: Schspa Shi <schspa@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Dwaine Gonyier <dgonyier@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/deadline.c | 1 +
 kernel/sched/rt.c       | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3aad381f42ed4..b3e2064983952 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2084,6 +2084,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
 				     task_running(rq, task) ||
 				     !dl_task(task) ||
+				     is_migration_disabled(task) ||
 				     !task_on_rq_queued(task))) {
 				double_unlock_balance(rq, later_rq);
 				later_rq = NULL;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8d170b5bdae92..4b9281e6b1ccd 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1842,11 +1842,15 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			 * the mean time, task could have
 			 * migrated already or had its affinity changed.
 			 * Also make sure that it wasn't scheduled on its rq.
+			 * It is possible the task was scheduled, set
+			 * "migrate_disabled" and then got preempted, so we must
+			 * check the task migration disable flag here too.
 			 */
 			if (unlikely(task_rq(task) != rq ||
 				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
 				     task_running(rq, task) ||
 				     !rt_task(task) ||
+				     is_migration_disabled(task) ||
 				     !task_on_rq_queued(task))) {
 
 				double_unlock_balance(rq, lowest_rq);
-- 
2.39.2



