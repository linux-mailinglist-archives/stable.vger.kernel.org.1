Return-Path: <stable+bounces-69278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 554719540FB
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 07:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6381F2454B
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 05:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B02E8002A;
	Fri, 16 Aug 2024 05:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CwCNvAjC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB3E78C7A;
	Fri, 16 Aug 2024 05:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723785416; cv=none; b=JOLiST38ba7ky5J7KbmLbxEfC+B1OlvD34zH1to/gFdTGiwBvnJo6yRkTlsVgBlp9cGWCNGMRPczPflJlHaa4drBrqQZpy4GihbSjKNuOrjakNltXNIVThISNURBvDV1YQzLSPb3jxT/zD9niG5n3OIDd3/D4QYOsF7TOrJ+Uxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723785416; c=relaxed/simple;
	bh=Ox/EL5U1+Z8vk7aJGjY/0MfiqMn8bj4QbmKLNFXfIXg=;
	h=Date:To:From:Subject:Message-Id; b=E/DkY82VLRyjc2a+vMBiEVpZ+MS6VN+w71AtVNlTsBjvjLBm8UOQtQVd+vjJbp0dpZhyn44lBuFTZAXrTLQgSkZ31unTkuGUHRIHjltigt/pqA9xWE7z296+dQSkzyRGfs91w8vlq3p3XfnZc8sIMftwZ21FnE8m6IAMqzGMnnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CwCNvAjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD82C4AF0B;
	Fri, 16 Aug 2024 05:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723785416;
	bh=Ox/EL5U1+Z8vk7aJGjY/0MfiqMn8bj4QbmKLNFXfIXg=;
	h=Date:To:From:Subject:From;
	b=CwCNvAjCWtxqFYUnp86fKOeiP9t6ngBxOzFOpjf5J2Q0VNs06I4cV56huO9kYVnmE
	 2jA1XDfsoQ2T5MP4hbyKfjo+ofSsKxePxPuMS+7DGTFN9Kuy8q8Pdnlwq7zokXQob5
	 e8i2Hi00trjQ3ZrFJhg8Xn2DXbQQbPtcJFEZ/wsQ=
Date: Thu, 15 Aug 2024 22:16:55 -0700
To: mm-commits@vger.kernel.org,ying.huang@intel.com,stable@vger.kernel.org,nao.horiguchi@gmail.com,linmiaohe@huawei.com,len.brown@intel.com,juri.lelli@redhat.com,longman@redhat.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-memory-failure-use-raw_spinlock_t-in-struct-memory_failure_cpu.patch removed from -mm tree
Message-Id: <20240816051656.2AD82C4AF0B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: mm/memory-failure: use raw_spinlock_t in struct memory_failure_cpu
has been removed from the -mm tree.  Its filename was
     mm-memory-failure-use-raw_spinlock_t-in-struct-memory_failure_cpu.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Waiman Long <longman@redhat.com>
Subject: mm/memory-failure: use raw_spinlock_t in struct memory_failure_cpu
Date: Tue, 6 Aug 2024 12:41:07 -0400

The memory_failure_cpu structure is a per-cpu structure.  Access to its
content requires the use of get_cpu_var() to lock in the current CPU and
disable preemption.  The use of a regular spinlock_t for locking purpose
is fine for a non-RT kernel.

Since the integration of RT spinlock support into the v5.15 kernel, a
spinlock_t in a RT kernel becomes a sleeping lock and taking a sleeping
lock in a preemption disabled context is illegal resulting in the
following kind of warning.

  [12135.732244] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
  [12135.732248] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 270076, name: kworker/0:0
  [12135.732252] preempt_count: 1, expected: 0
  [12135.732255] RCU nest depth: 2, expected: 2
    :
  [12135.732420] Hardware name: Dell Inc. PowerEdge R640/0HG0J8, BIOS 2.10.2 02/24/2021
  [12135.732423] Workqueue: kacpi_notify acpi_os_execute_deferred
  [12135.732433] Call Trace:
  [12135.732436]  <TASK>
  [12135.732450]  dump_stack_lvl+0x57/0x81
  [12135.732461]  __might_resched.cold+0xf4/0x12f
  [12135.732479]  rt_spin_lock+0x4c/0x100
  [12135.732491]  memory_failure_queue+0x40/0xe0
  [12135.732503]  ghes_do_memory_failure+0x53/0x390
  [12135.732516]  ghes_do_proc.constprop.0+0x229/0x3e0
  [12135.732575]  ghes_proc+0xf9/0x1a0
  [12135.732591]  ghes_notify_hed+0x6a/0x150
  [12135.732602]  notifier_call_chain+0x43/0xb0
  [12135.732626]  blocking_notifier_call_chain+0x43/0x60
  [12135.732637]  acpi_ev_notify_dispatch+0x47/0x70
  [12135.732648]  acpi_os_execute_deferred+0x13/0x20
  [12135.732654]  process_one_work+0x41f/0x500
  [12135.732695]  worker_thread+0x192/0x360
  [12135.732715]  kthread+0x111/0x140
  [12135.732733]  ret_from_fork+0x29/0x50
  [12135.732779]  </TASK>

Fix it by using a raw_spinlock_t for locking instead.

Also move the pr_err() out of the lock critical section and after
put_cpu_ptr() to avoid indeterminate latency and the possibility of sleep
with this call.

[longman@redhat.com: don't hold percpu ref across pr_err(), per Miaohe]
  Link: https://lkml.kernel.org/r/20240807181130.1122660-1-longman@redhat.com
Link: https://lkml.kernel.org/r/20240806164107.1044956-1-longman@redhat.com
Fixes: 0f383b6dc96e ("locking/spinlock: Provide RT variant")
Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memory-failure.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/mm/memory-failure.c~mm-memory-failure-use-raw_spinlock_t-in-struct-memory_failure_cpu
+++ a/mm/memory-failure.c
@@ -2417,7 +2417,7 @@ struct memory_failure_entry {
 struct memory_failure_cpu {
 	DECLARE_KFIFO(fifo, struct memory_failure_entry,
 		      MEMORY_FAILURE_FIFO_SIZE);
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct work_struct work;
 };
 
@@ -2443,20 +2443,22 @@ void memory_failure_queue(unsigned long
 {
 	struct memory_failure_cpu *mf_cpu;
 	unsigned long proc_flags;
+	bool buffer_overflow;
 	struct memory_failure_entry entry = {
 		.pfn =		pfn,
 		.flags =	flags,
 	};
 
 	mf_cpu = &get_cpu_var(memory_failure_cpu);
-	spin_lock_irqsave(&mf_cpu->lock, proc_flags);
-	if (kfifo_put(&mf_cpu->fifo, entry))
+	raw_spin_lock_irqsave(&mf_cpu->lock, proc_flags);
+	buffer_overflow = !kfifo_put(&mf_cpu->fifo, entry);
+	if (!buffer_overflow)
 		schedule_work_on(smp_processor_id(), &mf_cpu->work);
-	else
+	raw_spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
+	put_cpu_var(memory_failure_cpu);
+	if (buffer_overflow)
 		pr_err("buffer overflow when queuing memory failure at %#lx\n",
 		       pfn);
-	spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
-	put_cpu_var(memory_failure_cpu);
 }
 EXPORT_SYMBOL_GPL(memory_failure_queue);
 
@@ -2469,9 +2471,9 @@ static void memory_failure_work_func(str
 
 	mf_cpu = container_of(work, struct memory_failure_cpu, work);
 	for (;;) {
-		spin_lock_irqsave(&mf_cpu->lock, proc_flags);
+		raw_spin_lock_irqsave(&mf_cpu->lock, proc_flags);
 		gotten = kfifo_get(&mf_cpu->fifo, &entry);
-		spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
+		raw_spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
 		if (!gotten)
 			break;
 		if (entry.flags & MF_SOFT_OFFLINE)
@@ -2501,7 +2503,7 @@ static int __init memory_failure_init(vo
 
 	for_each_possible_cpu(cpu) {
 		mf_cpu = &per_cpu(memory_failure_cpu, cpu);
-		spin_lock_init(&mf_cpu->lock);
+		raw_spin_lock_init(&mf_cpu->lock);
 		INIT_KFIFO(mf_cpu->fifo);
 		INIT_WORK(&mf_cpu->work, memory_failure_work_func);
 	}
_

Patches currently in -mm which might be from longman@redhat.com are

watchdog-handle-the-enodev-failure-case-of-lockup_detector_delay_init-separately.patch


