Return-Path: <stable+bounces-164876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EDBB13357
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 05:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E6F167BF2
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 03:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4982036EC;
	Mon, 28 Jul 2025 03:08:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C7D26ADD
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 03:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753672133; cv=none; b=Z7URBC+mlt+WOENmEPRhDcRDDmpNWkyTsnoQvB6r+m8INF/ah8C+1bp991mcNERmYk8V04szxHCum7Td0j0qnrEypeLE3ESXeAQsEpcKyg14KKynCdC49/B67I9JGGCKSD/kEUbD9ytsKfL+Ezs23L2k8tZH31+y6sD8TiiIDmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753672133; c=relaxed/simple;
	bh=k7f9xVVqnBIV5Abjt6ftreSV9DcoUd/iT8/KPTbL79k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h8QVwAtKl0wXjiy+mGl5gmDDlNK4oqpHRsh1AAuQNv2L5jNelMVTIj9ItDDGptk96hdbiFdjHke6EWfCaj8gSUCgQu2UrM42CXhQmELIiPkjD6KL7pjPX8qPhJEjJSTJeynBZmmyoHsUxyNbZMTKQoVRukmbG55YUiXOn6Wt/C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4br3N23ZVBzYQv5l
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 11:08:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2F2E51A140B
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 11:08:49 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCXExS56YZokj7rBg--.58859S7;
	Mon, 28 Jul 2025 11:08:48 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	rafael@kernel.org,
	pavel@ucw.cz
Cc: stable@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH 6.6 5/5] sched,freezer: Remove unnecessary warning in __thaw_task
Date: Mon, 28 Jul 2025 02:54:44 +0000
Message-Id: <20250728025444.34009-6-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250728025444.34009-1-chenridong@huaweicloud.com>
References: <2025072421-deviate-skintight-bbd5@gregkh>
 <20250728025444.34009-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXExS56YZokj7rBg--.58859S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15JrykWFWrGF48Xr47Jwb_yoW5JFykpw
	s3Ww4xKr48tr1jyrWUJa10qFyDKan3Xw4UGrykGr18XF43XasYqrn7AryYg34jvrWIgry5
	t3Z0gr40y3yDZ3JanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07jxwIDUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

[ Upstream commit 9beb8c5e77dc10e3889ff5f967eeffba78617a88 ]

Commit cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check if not
frozen") modified the cgroup_freezing() logic to verify that the FROZEN
flag is not set, affecting the return value of the freezing() function,
in order to address a warning in __thaw_task.

A race condition exists that may allow tasks to escape being frozen. The
following scenario demonstrates this issue:

CPU 0 (get_signal path)		CPU 1 (freezer.state reader)
try_to_freeze			read freezer.state
__refrigerator			freezer_read
				update_if_frozen
WRITE_ONCE(current->__state, TASK_FROZEN);
				...
				/* Task is now marked frozen */
				/* frozen(task) == true */
				/* Assuming other tasks are frozen */
				freezer->state |= CGROUP_FROZEN;
/* freezing(current) returns false */
/* because cgroup is frozen (not freezing) */
break out
__set_current_state(TASK_RUNNING);
/* Bug: Task resumes running when it should remain frozen */

The existing !frozen(p) check in __thaw_task makes the
WARN_ON_ONCE(freezing(p)) warning redundant. Removing this warning enables
reverting commit cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check if
not frozen") to resolve the issue.

This patch removes the warning from __thaw_task. A subsequent patch will
revert commit cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check if
not frozen") to complete the fix.

Reported-by: Zhong Jiawei<zhongjiawei1@huawei.com>
Signed-off-by: Chen Ridong <chenridong@huawei.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/freezer.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index f57aaf96b829..d8db479af478 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -196,18 +196,9 @@ static int __restore_freezer_state(struct task_struct *p, void *arg)
 
 void __thaw_task(struct task_struct *p)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&freezer_lock, flags);
-	if (WARN_ON_ONCE(freezing(p)))
-		goto unlock;
-
-	if (!frozen(p) || task_call_func(p, __restore_freezer_state, NULL))
-		goto unlock;
-
-	wake_up_state(p, TASK_FROZEN);
-unlock:
-	spin_unlock_irqrestore(&freezer_lock, flags);
+	guard(spinlock_irqsave)(&freezer_lock);
+	if (frozen(p) && !task_call_func(p, __restore_freezer_state, NULL))
+		wake_up_state(p, TASK_FROZEN);
 }
 
 /**
-- 
2.34.1


