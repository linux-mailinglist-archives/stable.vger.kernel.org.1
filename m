Return-Path: <stable+bounces-124698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFE3A658CE
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585A5176582
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E93A2080F6;
	Mon, 17 Mar 2025 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfgrEpIi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348FF1D89FA;
	Mon, 17 Mar 2025 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229593; cv=none; b=Yn4+zu6l5C1AXXVJfiWG8Qy5SnyUbsRZwRrc75+T/UFj/16UWeky38fgxZtJ808koLZASjmmGJBEg4i/caRJCxPnjqPjcRdgamFTvxkCCjo5ZmFyUQ5cn1OFN4sjCuTzRGyOGajoYuM3eIIdSUboN1k1m0inJKycZRKhcltetGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229593; c=relaxed/simple;
	bh=Ueo8+OP46BR7h+ZjlZaKgwvjpsOiazfbnA/5jazPig8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mmi8K+N8vDXN+x5xXLlawuCJi9PweV9xOg4ZzicVqsAsPos6bpFNEQ5w+gZTap+CsTGQsZ5xj4c3NHNuzmek9zvaLCm9Q938EiFwqwjd4zToV+SMT9Z+XnpAZjmDMJ4a8cgmfuYukTDg0FByOj4w545wCrIaCwTo6Tnd2xse5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfgrEpIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B293CC4CEF1;
	Mon, 17 Mar 2025 16:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229592;
	bh=Ueo8+OP46BR7h+ZjlZaKgwvjpsOiazfbnA/5jazPig8=;
	h=From:To:Cc:Subject:Date:From;
	b=lfgrEpIisp2sJ0cKbeWTZnOPXAytuQl2lHp0HS9xM82q8L9C8mAhEYdqPPaol9gWF
	 G4+oOzIrgdVdyriQO41xcBQT76FpOu7f8n3HF5IIsO4m3x3yGHoy/sPyHODWB2GPyp
	 HNAUZf/fud6ZENNtopnYrD3Ezmt6+LRlLFQndly5vGwaowRlHCMhuyEdbn4TO7T/zC
	 2rQyQCE3bi+zxns7pyQVAc9YWeQGrUyba+B3hSmPmlwcTdMx34wgIiLABbyRLU4fq/
	 m6VKN8L7JCPzFxQLjisZe7CIj0hYofWRWLdKVEScfA8JTd1ZczaH2iXVmy0PtAh+8V
	 mBj4gUBMxH06w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	yzbot+ed801a886dfdbfe7136d@syzkaller.appspotmail.com,
	Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 1/4] locking/semaphore: Use wake_q to wake up processes outside lock critical section
Date: Mon, 17 Mar 2025 12:39:46 -0400
Message-Id: <20250317163949.1893632-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
Content-Transfer-Encoding: 8bit

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
index 9ee381e4d2a4d..a26c915430ba0 100644
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
@@ -37,7 +38,7 @@ static noinline void __down(struct semaphore *sem);
 static noinline int __down_interruptible(struct semaphore *sem);
 static noinline int __down_killable(struct semaphore *sem);
 static noinline int __down_timeout(struct semaphore *sem, long timeout);
-static noinline void __up(struct semaphore *sem);
+static noinline void __up(struct semaphore *sem, struct wake_q_head *wake_q);
 
 /**
  * down - acquire the semaphore
@@ -182,13 +183,16 @@ EXPORT_SYMBOL(down_timeout);
 void up(struct semaphore *sem)
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
 
@@ -256,11 +260,12 @@ static noinline int __sched __down_timeout(struct semaphore *sem, long timeout)
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


