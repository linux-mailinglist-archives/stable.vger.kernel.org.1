Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721676FAC3E
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbjEHLWY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbjEHLWV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:22:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4524D37001
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:22:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39FCF62CB9
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAB9C433D2;
        Mon,  8 May 2023 11:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544931;
        bh=tUzZwBidde6xtSinxYe2xVHPpnOjyXOU14PA1HMpBwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wnJVdSepXcbf6LNlcNJavAd49uOPGAuox7UIphBG1O4QMrH+wOkwFVN+cWYMeQ4wy
         DxwVYxXKkmv6sncCOEWwSOG/3wDeM4eLBJA5k4vGiX0fo2PclE8SmUQOwb//mHX2mA
         EyG2pWzpDIQdpJ9WLH5reMUYRJ+j4xV2z7S3/nNk=
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
Subject: [PATCH 6.3 569/694] sched/rt: Fix bad task migration for rt tasks
Date:   Mon,  8 May 2023 11:46:44 +0200
Message-Id: <20230508094453.276126653@linuxfoundation.org>
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
index 71b24371a6f77..ac8010f6f3a22 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2246,6 +2246,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
 				     task_on_cpu(rq, task) ||
 				     !dl_task(task) ||
+				     is_migration_disabled(task) ||
 				     !task_on_rq_queued(task))) {
 				double_unlock_balance(rq, later_rq);
 				later_rq = NULL;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 0a11f44adee57..4f5796dd26a56 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2000,11 +2000,15 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			 * the mean time, task could have
 			 * migrated already or had its affinity changed.
 			 * Also make sure that it wasn't scheduled on its rq.
+			 * It is possible the task was scheduled, set
+			 * "migrate_disabled" and then got preempted, so we must
+			 * check the task migration disable flag here too.
 			 */
 			if (unlikely(task_rq(task) != rq ||
 				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
 				     task_on_cpu(rq, task) ||
 				     !rt_task(task) ||
+				     is_migration_disabled(task) ||
 				     !task_on_rq_queued(task))) {
 
 				double_unlock_balance(rq, lowest_rq);
-- 
2.39.2



