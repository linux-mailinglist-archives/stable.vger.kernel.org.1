Return-Path: <stable+bounces-131249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6D6A80973
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D65E8C4A82
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B8B26FA7B;
	Tue,  8 Apr 2025 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f2dOHS3V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D8A26FA6C;
	Tue,  8 Apr 2025 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115887; cv=none; b=FiPonrVaey/h8R5kvV4IVvtlnb5NVR+cA3+pUsxta5OxWi1PiqUMW7Z5t0Txb6sY4i1/bzQbobNjbf3fY85Ay6nnCfiVloDCGsJUehIuyEM6d0EEqXSVYb9Uk2qPt1x++RO/ZHxSGYbchPmfGRjg5Sgb4dyqWOZnRxSHl+RLba0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115887; c=relaxed/simple;
	bh=JCwWF9wQSz2/VYDFbDUS0nC5MSFmBO4BkEjEHAOT8QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyz2cQyP0oGsp1m45Z/RKQzo/x+7yy8nsDgedgskW1JYrZ6P9Dh/z0KRu5XKvqK/LWNCS6N5MGyF+BdG9LZAZ7V/OP2/AX78DiSJRyA50bq17PTZKrintTDOLLqktT62TY7eQKuC93ehRLi2beNq6MErFox+Ci6gnK9dj5syfqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f2dOHS3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D793AC4CEE5;
	Tue,  8 Apr 2025 12:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115887;
	bh=JCwWF9wQSz2/VYDFbDUS0nC5MSFmBO4BkEjEHAOT8QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2dOHS3VbLOX+e0q2SL6vKF7M0Tcq69DLTdcW8/0yEmZ/Qob3Vw0rmR18v+XP2b+n
	 diBrLW0ieUOgDGna0zrDXztwM7EPZnrGF0X9HphXHwCK0MyEEMDhFFmctJnxXbcmB1
	 M0cykPJUTC/JZOQP6UUDrpfswqYkljmChgPUSUck=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	yzbot+ed801a886dfdbfe7136d@syzkaller.appspotmail.com,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 141/204] locking/semaphore: Use wake_q to wake up processes outside lock critical section
Date: Tue,  8 Apr 2025 12:51:11 +0200
Message-ID: <20250408104824.432642460@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
References: <20250408104820.266892317@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <longman@redhat.com>

[ Upstream commit 85b2b9c16d053364e2004883140538e73b333cdb ]

A circular lock dependency splat has been seen involving down_trylock():

  ======================================================
  WARNING: possible circular locking dependency detected
  6.12.0-41.el10.s390x+debug
  ------------------------------------------------------
  dd/32479 is trying to acquire lock:
  0015a20accd0d4f8 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0x26/0x90

  but task is already holding lock:
  000000017e461698 (&zone->lock){-.-.}-{2:2}, at: rmqueue_bulk+0xac/0x8f0

  the existing dependency chain (in reverse order) is:
  -> #4 (&zone->lock){-.-.}-{2:2}:
  -> #3 (hrtimer_bases.lock){-.-.}-{2:2}:
  -> #2 (&rq->__lock){-.-.}-{2:2}:
  -> #1 (&p->pi_lock){-.-.}-{2:2}:
  -> #0 ((console_sem).lock){-.-.}-{2:2}:

The console_sem -> pi_lock dependency is due to calling try_to_wake_up()
while holding the console_sem raw_spinlock. This dependency can be broken
by using wake_q to do the wakeup instead of calling try_to_wake_up()
under the console_sem lock. This will also make the semaphore's
raw_spinlock become a terminal lock without taking any further locks
underneath it.

The hrtimer_bases.lock is a raw_spinlock while zone->lock is a
spinlock. The hrtimer_bases.lock -> zone->lock dependency happens via
the debug_objects_fill_pool() helper function in the debugobjects code.

  -> #4 (&zone->lock){-.-.}-{2:2}:
         __lock_acquire+0xe86/0x1cc0
         lock_acquire.part.0+0x258/0x630
         lock_acquire+0xb8/0xe0
         _raw_spin_lock_irqsave+0xb4/0x120
         rmqueue_bulk+0xac/0x8f0
         __rmqueue_pcplist+0x580/0x830
         rmqueue_pcplist+0xfc/0x470
         rmqueue.isra.0+0xdec/0x11b0
         get_page_from_freelist+0x2ee/0xeb0
         __alloc_pages_noprof+0x2c2/0x520
         alloc_pages_mpol_noprof+0x1fc/0x4d0
         alloc_pages_noprof+0x8c/0xe0
         allocate_slab+0x320/0x460
         ___slab_alloc+0xa58/0x12b0
         __slab_alloc.isra.0+0x42/0x60
         kmem_cache_alloc_noprof+0x304/0x350
         fill_pool+0xf6/0x450
         debug_object_activate+0xfe/0x360
         enqueue_hrtimer+0x34/0x190
         __run_hrtimer+0x3c8/0x4c0
         __hrtimer_run_queues+0x1b2/0x260
         hrtimer_interrupt+0x316/0x760
         do_IRQ+0x9a/0xe0
         do_irq_async+0xf6/0x160

Normally a raw_spinlock to spinlock dependency is not legitimate
and will be warned if CONFIG_PROVE_RAW_LOCK_NESTING is enabled,
but debug_objects_fill_pool() is an exception as it explicitly
allows this dependency for non-PREEMPT_RT kernel without causing
PROVE_RAW_LOCK_NESTING lockdep splat. As a result, this dependency is
legitimate and not a bug.

Anyway, semaphore is the only locking primitive left that is still
using try_to_wake_up() to do wakeup inside critical section, all the
other locking primitives had been migrated to use wake_q to do wakeup
outside of the critical section. It is also possible that there are
other circular locking dependencies involving printk/console_sem or
other existing/new semaphores lurking somewhere which may show up in
the future. Let just do the migration now to wake_q to avoid headache
like this.

Reported-by: yzbot+ed801a886dfdbfe7136d@syzkaller.appspotmail.com
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250307232717.1759087-3-boqun.feng@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/semaphore.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 34bfae72f2952..de9117c0e671e 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -29,6 +29,7 @@
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/wake_q.h>
 #include <linux/semaphore.h>
 #include <linux/spinlock.h>
 #include <linux/ftrace.h>
@@ -38,7 +39,7 @@ static noinline void __down(struct semaphore *sem);
 static noinline int __down_interruptible(struct semaphore *sem);
 static noinline int __down_killable(struct semaphore *sem);
 static noinline int __down_timeout(struct semaphore *sem, long timeout);
-static noinline void __up(struct semaphore *sem);
+static noinline void __up(struct semaphore *sem, struct wake_q_head *wake_q);
 
 /**
  * down - acquire the semaphore
@@ -183,13 +184,16 @@ EXPORT_SYMBOL(down_timeout);
 void __sched up(struct semaphore *sem)
 {
 	unsigned long flags;
+	DEFINE_WAKE_Q(wake_q);
 
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(list_empty(&sem->wait_list)))
 		sem->count++;
 	else
-		__up(sem);
+		__up(sem, &wake_q);
 	raw_spin_unlock_irqrestore(&sem->lock, flags);
+	if (!wake_q_empty(&wake_q))
+		wake_up_q(&wake_q);
 }
 EXPORT_SYMBOL(up);
 
@@ -269,11 +273,12 @@ static noinline int __sched __down_timeout(struct semaphore *sem, long timeout)
 	return __down_common(sem, TASK_UNINTERRUPTIBLE, timeout);
 }
 
-static noinline void __sched __up(struct semaphore *sem)
+static noinline void __sched __up(struct semaphore *sem,
+				  struct wake_q_head *wake_q)
 {
 	struct semaphore_waiter *waiter = list_first_entry(&sem->wait_list,
 						struct semaphore_waiter, list);
 	list_del(&waiter->list);
 	waiter->up = true;
-	wake_up_process(waiter->task);
+	wake_q_add(wake_q, waiter->task);
 }
-- 
2.39.5




