Return-Path: <stable+bounces-179260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D64B532FA
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 15:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76152188E245
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 13:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E1F320CDD;
	Thu, 11 Sep 2025 13:00:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545C9322DB0;
	Thu, 11 Sep 2025 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595608; cv=none; b=gXF/f+U7OzSt64BfQV0IQTykhhVKu1wruvEZrnilgiR+E8hLtrx/D0aVE0uDtjd6rkbvF0Rtn0ukBQ8hkWxTwjdpTya8n5GYzj5rWGG6npLarysZO6tn5isGmu2kZDF92t4tq1Ao8bP2SYKodzSMpv6ar65WkLRc/Cp6HS2toFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595608; c=relaxed/simple;
	bh=dSQIkuFLrVeNIYU8GjhDduUU6G0rUWLuGLNdc+idMjk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sxj1wcTNgQ4JCt1s1n4qI+HsRi46PwBIOqSzsv0GJjughi6CWUf+3jfl45OM9XjSAWBTgUdpD+wFfwIZjZZ6ep9Nd+EEKAh91okucmqKP28JuFFTAs9cgZsJZZHoYdSYE2EksPTnioHs8ftjbLAXh1qo7iAUHNS4fqEGH1TWx5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cMyHc6MtCz2VRjF;
	Thu, 11 Sep 2025 20:56:44 +0800 (CST)
Received: from dggpemf100009.china.huawei.com (unknown [7.185.36.128])
	by mail.maildlp.com (Postfix) with ESMTPS id 464471402CC;
	Thu, 11 Sep 2025 21:00:02 +0800 (CST)
Received: from huawei.com (10.67.175.29) by dggpemf100009.china.huawei.com
 (7.185.36.128) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 11 Sep
 2025 21:00:01 +0800
From: Wang Tao <wangtao554@huawei.com>
To: <stable@vger.kernel.org>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <tglx@linutronix.de>, <frederic@kernel.org>,
	<linux-kernel@vger.kernel.org>, <tanghui20@huawei.com>,
	<zhangqiao22@huawei.com>
Subject: [PATCH] sched/core: Fix potential deadlock on rq lock
Date: Thu, 11 Sep 2025 12:42:49 +0000
Message-ID: <20250911124249.1154043-1-wangtao554@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

CPU0								CPU1
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
index be00629f0ba4..8b2d5b5bfb93 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5723,8 +5723,10 @@ static void sched_tick_remote(struct work_struct *work)
 				 * Make sure the next tick runs within a
 				 * reasonable amount of time.
 				 */
+				printk_deferred_enter();
 				u64 delta = rq_clock_task(rq) - curr->se.exec_start;
 				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
+				printk_deferred_exit();
 			}
 			curr->sched_class->task_tick(rq, curr, 0);
 
-- 
2.34.1


