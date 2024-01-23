Return-Path: <stable+bounces-13535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBFF837C80
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D753F1F28A60
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C0B443E;
	Tue, 23 Jan 2024 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pPgh3PwU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AAF33097;
	Tue, 23 Jan 2024 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969642; cv=none; b=sA6lsnpBg+IiOenK0Fg5SrwMPNiBsN/aSfuZ6OqJ5axojJnGBBSQ/AILU0PtJnNaggV1OKoSbCEosK+/HvxQG+OpssPh7r8BZ/N3+osyQL6YWytvVZx7YlZaF1TZRnBZjVv2lgcSWPuofrEodPNCmZ3qB6WX9gN8F25Wufa+OF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969642; c=relaxed/simple;
	bh=PVG73AvuCnyiJUOw285dfhEpsVT8d7JJTAWFVIqGHV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVqjVQHMthB+Z4KjH32uUSURIS4n2U6Rtd6y4jFNtu2gPWCETFJi5B5xVU0lPd3z+Hb5xeNQl3zfPR2DgnAz5g+IMI8KlAufsuSQPqHaCj3rYRBt64UyIOYaCC9FeRdzieVdlBXIEnVoCIx+mdWc04lQ7L2ZkXXSj8UQEJHz7SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pPgh3PwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58BFC433F1;
	Tue, 23 Jan 2024 00:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969641;
	bh=PVG73AvuCnyiJUOw285dfhEpsVT8d7JJTAWFVIqGHV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pPgh3PwUcs6kb0NHmoZijKhkBg97V4+/TW9ubsOAA+4/mUdHqrAM/ktJkmjK9lSXp
	 XPqxkwaYzzzUkUSbhnAWwBVW8q39Ry03vw/9kcUjHYJRr0PbswzqafNU7NmzkhSg7X
	 9tmK3vtPc11Dh2YXb1cnpJVAmoSy2wa2o0FMw7Bs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Andrea Righi <andrea.righi@canonical.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6.7 378/641] kernfs: convert kernfs_idr_lock to an irq safe raw spinlock
Date: Mon, 22 Jan 2024 15:54:42 -0800
Message-ID: <20240122235829.791311445@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrea Righi <andrea.righi@canonical.com>

commit c312828c37a72fe2d033a961c47c227b0767e9f8 upstream.

bpf_cgroup_from_id() is basically a wrapper to cgroup_get_from_id(),
that is relying on kernfs to determine the right cgroup associated to
the target id.

As a kfunc, it has the potential to be attached to any function through
BPF, particularly in contexts where certain locks are held.

However, kernfs is not using an irq safe spinlock for kernfs_idr_lock,
that means any kernfs function that is acquiring this lock can be
interrupted and potentially hit bpf_cgroup_from_id() in the process,
triggering a deadlock.

For example, it is really easy to trigger a lockdep splat between
kernfs_idr_lock and rq->_lock, attaching a small BPF program to
__set_cpus_allowed_ptr_locked() that just calls bpf_cgroup_from_id():

 =====================================================
 WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
 6.7.0-rc7-virtme #5 Not tainted
 -----------------------------------------------------
 repro/131 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
 ffffffffb2dc4578 (kernfs_idr_lock){+.+.}-{2:2}, at: kernfs_find_and_get_node_by_id+0x1d/0x80

 and this task is already holding:
 ffff911cbecaf218 (&rq->__lock){-.-.}-{2:2}, at: task_rq_lock+0x50/0xc0
 which would create a new lock dependency:
  (&rq->__lock){-.-.}-{2:2} -> (kernfs_idr_lock){+.+.}-{2:2}

 but this new dependency connects a HARDIRQ-irq-safe lock:
  (&rq->__lock){-.-.}-{2:2}

 ... which became HARDIRQ-irq-safe at:
   lock_acquire+0xbf/0x2b0
   _raw_spin_lock_nested+0x2e/0x40
   scheduler_tick+0x5d/0x170
   update_process_times+0x9c/0xb0
   tick_periodic+0x27/0xe0
   tick_handle_periodic+0x24/0x70
   __sysvec_apic_timer_interrupt+0x64/0x1a0
   sysvec_apic_timer_interrupt+0x6f/0x80
   asm_sysvec_apic_timer_interrupt+0x1a/0x20
   memcpy+0xc/0x20
   arch_dup_task_struct+0x15/0x30
   copy_process+0x1ce/0x1eb0
   kernel_clone+0xac/0x390
   kernel_thread+0x6f/0xa0
   kthreadd+0x199/0x230
   ret_from_fork+0x31/0x50
   ret_from_fork_asm+0x1b/0x30

 to a HARDIRQ-irq-unsafe lock:
  (kernfs_idr_lock){+.+.}-{2:2}

 ... which became HARDIRQ-irq-unsafe at:
 ...
   lock_acquire+0xbf/0x2b0
   _raw_spin_lock+0x30/0x40
   __kernfs_new_node.isra.0+0x83/0x280
   kernfs_create_root+0xf6/0x1d0
   sysfs_init+0x1b/0x70
   mnt_init+0xd9/0x2a0
   vfs_caches_init+0xcf/0xe0
   start_kernel+0x58a/0x6a0
   x86_64_start_reservations+0x18/0x30
   x86_64_start_kernel+0xc5/0xe0
   secondary_startup_64_no_verify+0x178/0x17b

 other info that might help us debug this:

  Possible interrupt unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(kernfs_idr_lock);
                                local_irq_disable();
                                lock(&rq->__lock);
                                lock(kernfs_idr_lock);
   <Interrupt>
     lock(&rq->__lock);

  *** DEADLOCK ***

Prevent this deadlock condition converting kernfs_idr_lock to a raw irq
safe spinlock.

The performance impact of this change should be negligible and it also
helps to prevent similar deadlock conditions with any other subsystems
that may depend on kernfs.

Fixes: 332ea1f697be ("bpf: Add bpf_cgroup_from_id() kfunc")
Cc: stable <stable@kernel.org>
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20231229074916.53547-1-andrea.righi@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/kernfs/dir.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -27,7 +27,7 @@ static DEFINE_RWLOCK(kernfs_rename_lock)
  */
 static DEFINE_SPINLOCK(kernfs_pr_cont_lock);
 static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by pr_cont_lock */
-static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
+static DEFINE_RAW_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 #define rb_to_kn(X) rb_entry((X), struct kernfs_node, rb)
 
@@ -539,6 +539,7 @@ void kernfs_put(struct kernfs_node *kn)
 {
 	struct kernfs_node *parent;
 	struct kernfs_root *root;
+	unsigned long flags;
 
 	if (!kn || !atomic_dec_and_test(&kn->count))
 		return;
@@ -563,9 +564,9 @@ void kernfs_put(struct kernfs_node *kn)
 		simple_xattrs_free(&kn->iattr->xattrs, NULL);
 		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
 	}
-	spin_lock(&kernfs_idr_lock);
+	raw_spin_lock_irqsave(&kernfs_idr_lock, flags);
 	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
-	spin_unlock(&kernfs_idr_lock);
+	raw_spin_unlock_irqrestore(&kernfs_idr_lock, flags);
 	kmem_cache_free(kernfs_node_cache, kn);
 
 	kn = parent;
@@ -607,6 +608,7 @@ static struct kernfs_node *__kernfs_new_
 	struct kernfs_node *kn;
 	u32 id_highbits;
 	int ret;
+	unsigned long irqflags;
 
 	name = kstrdup_const(name, GFP_KERNEL);
 	if (!name)
@@ -617,13 +619,13 @@ static struct kernfs_node *__kernfs_new_
 		goto err_out1;
 
 	idr_preload(GFP_KERNEL);
-	spin_lock(&kernfs_idr_lock);
+	raw_spin_lock_irqsave(&kernfs_idr_lock, irqflags);
 	ret = idr_alloc_cyclic(&root->ino_idr, kn, 1, 0, GFP_ATOMIC);
 	if (ret >= 0 && ret < root->last_id_lowbits)
 		root->id_highbits++;
 	id_highbits = root->id_highbits;
 	root->last_id_lowbits = ret;
-	spin_unlock(&kernfs_idr_lock);
+	raw_spin_unlock_irqrestore(&kernfs_idr_lock, irqflags);
 	idr_preload_end();
 	if (ret < 0)
 		goto err_out2;
@@ -659,9 +661,9 @@ static struct kernfs_node *__kernfs_new_
 	return kn;
 
  err_out3:
-	spin_lock(&kernfs_idr_lock);
+	raw_spin_lock_irqsave(&kernfs_idr_lock, irqflags);
 	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
-	spin_unlock(&kernfs_idr_lock);
+	raw_spin_unlock_irqrestore(&kernfs_idr_lock, irqflags);
  err_out2:
 	kmem_cache_free(kernfs_node_cache, kn);
  err_out1:
@@ -702,8 +704,9 @@ struct kernfs_node *kernfs_find_and_get_
 	struct kernfs_node *kn;
 	ino_t ino = kernfs_id_ino(id);
 	u32 gen = kernfs_id_gen(id);
+	unsigned long flags;
 
-	spin_lock(&kernfs_idr_lock);
+	raw_spin_lock_irqsave(&kernfs_idr_lock, flags);
 
 	kn = idr_find(&root->ino_idr, (u32)ino);
 	if (!kn)
@@ -727,10 +730,10 @@ struct kernfs_node *kernfs_find_and_get_
 	if (unlikely(!__kernfs_active(kn) || !atomic_inc_not_zero(&kn->count)))
 		goto err_unlock;
 
-	spin_unlock(&kernfs_idr_lock);
+	raw_spin_unlock_irqrestore(&kernfs_idr_lock, flags);
 	return kn;
 err_unlock:
-	spin_unlock(&kernfs_idr_lock);
+	raw_spin_unlock_irqrestore(&kernfs_idr_lock, flags);
 	return NULL;
 }
 



