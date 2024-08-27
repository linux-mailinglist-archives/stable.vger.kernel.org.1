Return-Path: <stable+bounces-70408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B120960DF5
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB461C229C8
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3921C578B;
	Tue, 27 Aug 2024 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hfWcxwI6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665EB1C4EE8;
	Tue, 27 Aug 2024 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769801; cv=none; b=Aq5okmyH2XUnriSrFvy0NCJ5Mw43zlQre90sW1fcXxQt/2F7rTzAYAAWH70yuFgLuiYLdEJUHfDmyW5G2vfERuxGcxJCOZEF4BBmT/+C5SqKCvVcaLyDRRRdqooswKGgR1E4HudZe7cXYmiZxvaR6Xhw1AT8MkjBloB+ykJg4MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769801; c=relaxed/simple;
	bh=pios9mFspg8IJ3rNrhtv52aMVtx+asNf1mVWhftTooU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BoaOLgtYBl3+0V9jx202H9ATo2Pitt1joDBfyEPZLzY/amumsbBgCE1hdXlNorZ+kH8ldqraMhO7VQD4sceMk3qlULtGXFJOXQepkMG/LtsSbfP7uCclHd89PUWP68D7ivvXfecTYYXBbjPQV7f6O/jcLKZJkSpZHKaobgXCcBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hfWcxwI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC3CC6104E;
	Tue, 27 Aug 2024 14:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724769801;
	bh=pios9mFspg8IJ3rNrhtv52aMVtx+asNf1mVWhftTooU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hfWcxwI6/C0ZnJcwmT4DIRg3aqWX/71py9rw5QtWlzTZWqVTC9/HltWN2jLyzMPIC
	 sd88YO0Lk79pyO+llFNwviFEqrHOuisI9KSSa3hSVoPYSTRho/1Ro9FdTN7eBYTez0
	 CMDSEI0hGXDOwVBhgbT5WOoSX4OnpORWEZK/WkNw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Waiman Long <longman@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Len Brown <len.brown@intel.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 039/341] mm/memory-failure: use raw_spinlock_t in struct memory_failure_cpu
Date: Tue, 27 Aug 2024 16:34:30 +0200
Message-ID: <20240827143844.900307219@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <longman@redhat.com>

commit d75abd0d0bc29e6ebfebbf76d11b4067b35844af upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory-failure.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2395,7 +2395,7 @@ struct memory_failure_entry {
 struct memory_failure_cpu {
 	DECLARE_KFIFO(fifo, struct memory_failure_entry,
 		      MEMORY_FAILURE_FIFO_SIZE);
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct work_struct work;
 };
 
@@ -2421,20 +2421,22 @@ void memory_failure_queue(unsigned long
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
 
@@ -2447,9 +2449,9 @@ static void memory_failure_work_func(str
 
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
@@ -2479,7 +2481,7 @@ static int __init memory_failure_init(vo
 
 	for_each_possible_cpu(cpu) {
 		mf_cpu = &per_cpu(memory_failure_cpu, cpu);
-		spin_lock_init(&mf_cpu->lock);
+		raw_spin_lock_init(&mf_cpu->lock);
 		INIT_KFIFO(mf_cpu->fifo);
 		INIT_WORK(&mf_cpu->work, memory_failure_work_func);
 	}



