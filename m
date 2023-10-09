Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6347F7BE08D
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377353AbjJINl1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377364AbjJINl0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:41:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDFFCF
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:41:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00789C433C7;
        Mon,  9 Oct 2023 13:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858883;
        bh=0G0hg7UukneNEO0Z4Kf+o1IoQs0+bZyYOKOyfcuM37E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0tBzNjCf+M7x/UqmQ2e3L7guiRrWlqPN+64wg/QBV6jXvEkx8aA5LaJOHlIWcNqwt
         CS/vwL/PAoA4UAS5aGtWleTeldWeYA4ci/7nyJCukTNpAWRkd83KECPG90ibcsOX7Z
         FHwtUURC+Ic18Kh7buUUwyl1iTNV0lzWns/peb78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Ovidiu Panait <ovidiu.panait@windriver.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 131/226] sched/cpuacct: Optimize away RCU read lock
Date:   Mon,  9 Oct 2023 15:01:32 +0200
Message-ID: <20231009130130.186737130@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengming Zhou <zhouchengming@bytedance.com>

commit dc6e0818bc9a0336d9accf3ea35d146d72aa7a18 upstream.

Since cpuacct_charge() is called from the scheduler update_curr(),
we must already have rq lock held, then the RCU read lock can
be optimized away.

And do the same thing in it's wrapper cgroup_account_cputime(),
but we can't use lockdep_assert_rq_held() there, which defined
in kernel/sched/sched.h.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220220051426.5274-2-zhouchengming@bytedance.com
[OP: adjusted lockdep_assert_rq_held() -> lockdep_assert_held()]
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/cgroup.h | 2 --
 kernel/sched/cpuacct.c | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 959b370733f09..7653f54189502 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -779,11 +779,9 @@ static inline void cgroup_account_cputime(struct task_struct *task,
 
 	cpuacct_charge(task, delta_exec);
 
-	rcu_read_lock();
 	cgrp = task_dfl_cgroup(task);
 	if (cgroup_parent(cgrp))
 		__cgroup_account_cputime(cgrp, delta_exec);
-	rcu_read_unlock();
 }
 
 static inline void cgroup_account_cputime_field(struct task_struct *task,
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 3c59c541dd314..8ee298321d78b 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -331,12 +331,10 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 	unsigned int cpu = task_cpu(tsk);
 	struct cpuacct *ca;
 
-	rcu_read_lock();
+	lockdep_assert_held(&cpu_rq(cpu)->lock);
 
 	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
 		*per_cpu_ptr(ca->cpuusage, cpu) += cputime;
-
-	rcu_read_unlock();
 }
 
 /*
-- 
2.40.1



