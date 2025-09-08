Return-Path: <stable+bounces-178861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 580CBB487AF
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 10:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5DE1B21170
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 09:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FDB2EC555;
	Mon,  8 Sep 2025 08:59:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD8C224891;
	Mon,  8 Sep 2025 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757321983; cv=none; b=WkTB3Up/pxaDEf6OUC7Nvz2KexHLBoByniVShibMeAUZ7Ga/ikj2tVy74CyaJ2amRVtTvwhzDVrJfK6ShQ5V42psL84SiLKaEGW0fUW/cjMbfwoUpDUrJPQXXYFO2EyUbA44rzB6volIug8QtdkX9IAR25EXPVaNy7GPkeylqaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757321983; c=relaxed/simple;
	bh=8yOvBX+cJ58Nd86qf3UVRoxpmvGuv3h/l9QnQQ/2rPc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dme+1+AUpyn5DaXjHyoTP7hvgaggY06y1wUDpAEwyTSu4uY7sQIo7s2VjHn1VF3lYsS3epTedpmKvRc5gSrQxzggnpKhNZQ/PBNb1oCj1BLZWxK4KdeBVBZrrn9C6whhR90pQ8PWghaExrcmhpKsoukGbgsCcqPRtT8YHpuCbQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cL1445trrzRkJX;
	Mon,  8 Sep 2025 16:55:00 +0800 (CST)
Received: from dggpemf100009.china.huawei.com (unknown [7.185.36.128])
	by mail.maildlp.com (Postfix) with ESMTPS id AF8391402CC;
	Mon,  8 Sep 2025 16:59:37 +0800 (CST)
Received: from huawei.com (10.67.175.29) by dggpemf100009.china.huawei.com
 (7.185.36.128) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 8 Sep
 2025 16:59:36 +0800
From: Wang Tao <wangtao554@huawei.com>
To: <stable@vger.kernel.org>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <tglx@linutronix.de>, <frederic@kernel.org>,
	<linux-kernel@vger.kernel.org>, <tanghui20@huawei.com>,
	<zhangqiao22@huawei.com>
Subject: [PATCH stable/linux-5.10.y] sched/core: Fix potential deadlock on rq lock
Date: Mon, 8 Sep 2025 08:42:30 +0000
Message-ID: <20250908084230.848195-1-wangtao554@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf100009.china.huawei.com (7.185.36.128)

When CPU 1 enters the nohz_full state, and the kworker on CPU 0 executes
the function sched_tick_remote, holding the lock on CPU1's rq
and triggering the warning WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3).
This leads to the process of printing the warning message, where the
console_sem semaphore is held. At this point, the print task on the
CPU1's rq cannot acquire the console_sem and joins the wait queue,
entering the UNINTERRUPTIBLE state. It waits for the console_sem to be
released and then wakes up. After the task on CPU 0 releases
the console_sem, it wakes up the waiting console_sem task.
In try_to_wake_up, it attempts to acquire the lock on CPU1's rq again,
resulting in a deadlock.

The triggering scenario is as follows:

CPU 0								CPU1
sched_tick_remote
WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3)

report_bug							con_write
printk

console_unlock
								do_con_write
								console_lock
								down(&console_sem)
								list_add_tail(&waiter.list, &sem->wait_list);
up(&console_sem)
wake_up_q(&wake_q)
try_to_wake_up
__task_rq_lock
_raw_spin_lock

This patch fixes the issue by deffering all printk console printing
during the lock holding period.

Fixes: d84b31313ef8 ("sched/isolation: Offload residual 1Hz scheduler tick")
Signed-off-by: Wang Tao <wangtao554@huawei.com>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 40f40f359c5d..fd2c83058ec2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4091,6 +4091,7 @@ static void sched_tick_remote(struct work_struct *work)
 		goto out_requeue;
 
 	rq_lock_irq(rq, &rf);
+	printk_deferred_enter();
 	curr = rq->curr;
 	if (cpu_is_offline(cpu))
 		goto out_unlock;
@@ -4109,6 +4110,7 @@ static void sched_tick_remote(struct work_struct *work)
 
 	calc_load_nohz_remote(rq);
 out_unlock:
+	printk_deferred_exit();
 	rq_unlock_irq(rq, &rf);
 out_requeue:
 
-- 
2.34.1


