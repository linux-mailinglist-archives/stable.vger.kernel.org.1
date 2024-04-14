Return-Path: <stable+bounces-38408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C95BD8A0E6F
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6B01F21813
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA19146009;
	Thu, 11 Apr 2024 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gi84wbIf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D5E145B08;
	Thu, 11 Apr 2024 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830478; cv=none; b=MvyUbxz0B5sb4PsHHc5eqXGMNvOasig/vt65M2cDVQGYHxaOBYsh8gYznPJuQGaNSszVAkinRgymnhkDSkwUC+ncdKzVMHrjJv5yEwtt8PumjvYHJGdJqcUX4od7LYYk0FX/bkwpCtUMTwj1KBM7Y9G+S9xRCApRYsLeNQWkxCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830478; c=relaxed/simple;
	bh=u6d+gXrHfRyhpLUWOYD/CMziLZ1WzBr9jldqI6qfhuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnwenMrnWlzQkj+4rJ8sVY9pyCHJDH9pCE5zCi9SwS9epO+Et1bvdz+z4NWa/4c5EgoV/TeIDYDOMSXkJkFu6nH5iKds9zFYQzyj8KC24MZ7U0JaQAv19HZpx+ngMwVZXqUQcoKZ43M9FkjgKkAnXM9SyuE4QzHaioTc6dQOxHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gi84wbIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AF9C433F1;
	Thu, 11 Apr 2024 10:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712830478;
	bh=u6d+gXrHfRyhpLUWOYD/CMziLZ1WzBr9jldqI6qfhuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gi84wbIfUERpgN5WliYWOyzspnZiC4DD36KIo/6N81XliZA2tHVhd+8cnCvYqL+8G
	 Kmdg4QzspUsoMnAp4S2A/8vV7OG73byncUUQid8hyLpEd9u2f4SZjKDd5lMyRXxVs1
	 xyJtoghS0ZHz0UObZWhjdE57uYMtx6pDwScTJOMU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Matlack <dmatlack@google.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 016/215] KVM: Always flush async #PF workqueue when vCPU is being destroyed
Date: Thu, 11 Apr 2024 11:53:45 +0200
Message-ID: <20240411095425.371097973@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>
References: <20240411095424.875421572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 3d75b8aa5c29058a512db29da7cbee8052724157 ]

Always flush the per-vCPU async #PF workqueue when a vCPU is clearing its
completion queue, e.g. when a VM and all its vCPUs is being destroyed.
KVM must ensure that none of its workqueue callbacks is running when the
last reference to the KVM _module_ is put.  Gifting a reference to the
associated VM prevents the workqueue callback from dereferencing freed
vCPU/VM memory, but does not prevent the KVM module from being unloaded
before the callback completes.

Drop the misguided VM refcount gifting, as calling kvm_put_kvm() from
async_pf_execute() if kvm_put_kvm() flushes the async #PF workqueue will
result in deadlock.  async_pf_execute() can't return until kvm_put_kvm()
finishes, and kvm_put_kvm() can't return until async_pf_execute() finishes:

 WARNING: CPU: 8 PID: 251 at virt/kvm/kvm_main.c:1435 kvm_put_kvm+0x2d/0x320 [kvm]
 Modules linked in: vhost_net vhost vhost_iotlb tap kvm_intel kvm irqbypass
 CPU: 8 PID: 251 Comm: kworker/8:1 Tainted: G        W          6.6.0-rc1-e7af8d17224a-x86/gmem-vm #119
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 Workqueue: events async_pf_execute [kvm]
 RIP: 0010:kvm_put_kvm+0x2d/0x320 [kvm]
 Call Trace:
  <TASK>
  async_pf_execute+0x198/0x260 [kvm]
  process_one_work+0x145/0x2d0
  worker_thread+0x27e/0x3a0
  kthread+0xba/0xe0
  ret_from_fork+0x2d/0x50
  ret_from_fork_asm+0x11/0x20
  </TASK>
 ---[ end trace 0000000000000000 ]---
 INFO: task kworker/8:1:251 blocked for more than 120 seconds.
       Tainted: G        W          6.6.0-rc1-e7af8d17224a-x86/gmem-vm #119
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:kworker/8:1     state:D stack:0     pid:251   ppid:2      flags:0x00004000
 Workqueue: events async_pf_execute [kvm]
 Call Trace:
  <TASK>
  __schedule+0x33f/0xa40
  schedule+0x53/0xc0
  schedule_timeout+0x12a/0x140
  __wait_for_common+0x8d/0x1d0
  __flush_work.isra.0+0x19f/0x2c0
  kvm_clear_async_pf_completion_queue+0x129/0x190 [kvm]
  kvm_arch_destroy_vm+0x78/0x1b0 [kvm]
  kvm_put_kvm+0x1c1/0x320 [kvm]
  async_pf_execute+0x198/0x260 [kvm]
  process_one_work+0x145/0x2d0
  worker_thread+0x27e/0x3a0
  kthread+0xba/0xe0
  ret_from_fork+0x2d/0x50
  ret_from_fork_asm+0x11/0x20
  </TASK>

If kvm_clear_async_pf_completion_queue() actually flushes the workqueue,
then there's no need to gift async_pf_execute() a reference because all
invocations of async_pf_execute() will be forced to complete before the
vCPU and its VM are destroyed/freed.  And that in turn fixes the module
unloading bug as __fput() won't do module_put() on the last vCPU reference
until the vCPU has been freed, e.g. if closing the vCPU file also puts the
last reference to the KVM module.

Note that kvm_check_async_pf_completion() may also take the work item off
the completion queue and so also needs to flush the work queue, as the
work will not be seen by kvm_clear_async_pf_completion_queue().  Waiting
on the workqueue could theoretically delay a vCPU due to waiting for the
work to complete, but that's a very, very small chance, and likely a very
small delay.  kvm_arch_async_page_present_queued() unconditionally makes a
new request, i.e. will effectively delay entering the guest, so the
remaining work is really just:

        trace_kvm_async_pf_completed(addr, cr2_or_gpa);

        __kvm_vcpu_wake_up(vcpu);

        mmput(mm);

and mmput() can't drop the last reference to the page tables if the vCPU is
still alive, i.e. the vCPU won't get stuck tearing down page tables.

Add a helper to do the flushing, specifically to deal with "wakeup all"
work items, as they aren't actually work items, i.e. are never placed in a
workqueue.  Trying to flush a bogus workqueue entry rightly makes
__flush_work() complain (kudos to whoever added that sanity check).

Note, commit 5f6de5cbebee ("KVM: Prevent module exit until all VMs are
freed") *tried* to fix the module refcounting issue by having VMs grab a
reference to the module, but that only made the bug slightly harder to hit
as it gave async_pf_execute() a bit more time to complete before the KVM
module could be unloaded.

Fixes: af585b921e5d ("KVM: Halt vcpu if page it tries to access is swapped out")
Cc: stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20240110011533.503302-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/async_pf.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index d8ef708a2ef67..d0a1113b0e55c 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -98,7 +98,27 @@ static void async_pf_execute(struct work_struct *work)
 		swake_up_one(&vcpu->wq);
 
 	mmput(mm);
-	kvm_put_kvm(vcpu->kvm);
+}
+
+static void kvm_flush_and_free_async_pf_work(struct kvm_async_pf *work)
+{
+	/*
+	 * The async #PF is "done", but KVM must wait for the work item itself,
+	 * i.e. async_pf_execute(), to run to completion.  If KVM is a module,
+	 * KVM must ensure *no* code owned by the KVM (the module) can be run
+	 * after the last call to module_put().  Note, flushing the work item
+	 * is always required when the item is taken off the completion queue.
+	 * E.g. even if the vCPU handles the item in the "normal" path, the VM
+	 * could be terminated before async_pf_execute() completes.
+	 *
+	 * Wake all events skip the queue and go straight done, i.e. don't
+	 * need to be flushed (but sanity check that the work wasn't queued).
+	 */
+	if (work->wakeup_all)
+		WARN_ON_ONCE(work->work.func);
+	else
+		flush_work(&work->work);
+	kmem_cache_free(async_pf_cache, work);
 }
 
 void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
@@ -125,7 +145,6 @@ void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
 #else
 		if (cancel_work_sync(&work->work)) {
 			mmput(work->mm);
-			kvm_put_kvm(vcpu->kvm); /* == work->vcpu->kvm */
 			kmem_cache_free(async_pf_cache, work);
 		}
 #endif
@@ -137,7 +156,10 @@ void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
 			list_first_entry(&vcpu->async_pf.done,
 					 typeof(*work), link);
 		list_del(&work->link);
-		kmem_cache_free(async_pf_cache, work);
+
+		spin_unlock(&vcpu->async_pf.lock);
+		kvm_flush_and_free_async_pf_work(work);
+		spin_lock(&vcpu->async_pf.lock);
 	}
 	spin_unlock(&vcpu->async_pf.lock);
 
@@ -161,7 +183,7 @@ void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu)
 
 		list_del(&work->queue);
 		vcpu->async_pf.queued--;
-		kmem_cache_free(async_pf_cache, work);
+		kvm_flush_and_free_async_pf_work(work);
 	}
 }
 
@@ -190,7 +212,6 @@ int kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	work->arch = *arch;
 	work->mm = current->mm;
 	mmget(work->mm);
-	kvm_get_kvm(work->vcpu->kvm);
 
 	/* this can't really happen otherwise gfn_to_pfn_async
 	   would succeed */
-- 
2.43.0




