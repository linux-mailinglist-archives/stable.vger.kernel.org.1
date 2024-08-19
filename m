Return-Path: <stable+bounces-69512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B59956787
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383BC1C2184B
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771EE15C14A;
	Mon, 19 Aug 2024 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OjO42p98"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F6415696E
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061149; cv=none; b=WFzdScNnruJ9ksMu4NiStpKy0PftgbnYVFyu37gY+Znl+7N5yATVyHIoGpZ7yZGLZmjOHNZcRyUhcc3Bp6mGpnZPZBK9sKEOnPSSd1JtVoqlM7Mv0F8bbPNvTHCAT6mWNvCwm6FykM9bJnuhHKw3PjqbGEjnYo6XHqRxgj/Ok60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061149; c=relaxed/simple;
	bh=cxHwvMPQEVdCngC2pvbmGkuGLE84AQcZkR1luhxPIUE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=b3oW+rtE6gE1sVIh3OLnyHzCAg36y5BIU3YIkKhVJOeGZ/BD5G8YKqfjjiNxbWKtQciY1hlz/cHDfkK3WwTNIcRgy44kv7+xyD+P70/f8eMWiYL2lpVXGeoeZ8IOdYZEa14Tw5fvLCBP/FZQRAwO3RKP2zoeTemz0BYGBmVGDqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OjO42p98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F447C32782;
	Mon, 19 Aug 2024 09:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724061148;
	bh=cxHwvMPQEVdCngC2pvbmGkuGLE84AQcZkR1luhxPIUE=;
	h=Subject:To:Cc:From:Date:From;
	b=OjO42p98M71Gys70TqpXi4XezzSu0tKW3pYJJOy3WpTUIjnkmQf1gMnNHF3+8ov5m
	 RSbtsnUfH3y8NdL8Yrk4B65c6QGbClwBWgt3xDnXUhV6O0Mct0bdYJsptBzGtg3anb
	 e3A2pSICF7aaKyPQ57aEapzZy1p2HUC8aV+uYLrw=
Subject: FAILED: patch "[PATCH] mm/memory-failure: use raw_spinlock_t in struct" failed to apply to 5.15-stable tree
To: longman@redhat.com,akpm@linux-foundation.org,juri.lelli@redhat.com,len.brown@intel.com,linmiaohe@huawei.com,nao.horiguchi@gmail.com,stable@vger.kernel.org,ying.huang@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:52:25 +0200
Message-ID: <2024081925-stardust-create-e577@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d75abd0d0bc29e6ebfebbf76d11b4067b35844af
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081925-stardust-create-e577@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

d75abd0d0bc2 ("mm/memory-failure: use raw_spinlock_t in struct memory_failure_cpu")
96f96763de26 ("mm: memory-failure: convert to pr_fmt()")
98931dd95fd4 ("Merge tag 'mm-stable-2022-05-25' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d75abd0d0bc29e6ebfebbf76d11b4067b35844af Mon Sep 17 00:00:00 2001
From: Waiman Long <longman@redhat.com>
Date: Tue, 6 Aug 2024 12:41:07 -0400
Subject: [PATCH] mm/memory-failure: use raw_spinlock_t in struct
 memory_failure_cpu

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

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 581d3e5c9117..7066fc84f351 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2417,7 +2417,7 @@ struct memory_failure_entry {
 struct memory_failure_cpu {
 	DECLARE_KFIFO(fifo, struct memory_failure_entry,
 		      MEMORY_FAILURE_FIFO_SIZE);
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct work_struct work;
 };
 
@@ -2443,20 +2443,22 @@ void memory_failure_queue(unsigned long pfn, int flags)
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
 
@@ -2469,9 +2471,9 @@ static void memory_failure_work_func(struct work_struct *work)
 
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
@@ -2501,7 +2503,7 @@ static int __init memory_failure_init(void)
 
 	for_each_possible_cpu(cpu) {
 		mf_cpu = &per_cpu(memory_failure_cpu, cpu);
-		spin_lock_init(&mf_cpu->lock);
+		raw_spin_lock_init(&mf_cpu->lock);
 		INIT_KFIFO(mf_cpu->fifo);
 		INIT_WORK(&mf_cpu->work, memory_failure_work_func);
 	}


