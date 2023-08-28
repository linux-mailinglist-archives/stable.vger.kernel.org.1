Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C076278ACCC
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjH1KmL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjH1Klt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:41:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292A5C5
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B813463F14
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FDAC433C8;
        Mon, 28 Aug 2023 10:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219304;
        bh=qMwyN7YWB5ZSiT/lEABL+F8k9w98Fo7afFoG3mzHzDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aKLF2/67vV7HNSv+xgH0XvUsM9lP9VaUFUu8iBCWqgKW8RTs3LxyTDPj7Y1+1ZAyq
         5TwkiS0Ge0A2RfULPmrD6K59rYatSrdIvn/30N20fPBLcxXrsspl4wr1R73HowtiCD
         oVq1f9QoqdSAiHlIEBpEhTUGnYktgVr2wjES/fWc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Michael Larabel <Michael@michaellarabel.com>
Subject: [PATCH 5.4 146/158] mm: allow a controlled amount of unfairness in the page lock
Date:   Mon, 28 Aug 2023 12:14:03 +0200
Message-ID: <20230828101202.549408518@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 5ef64cc8987a9211d3f3667331ba3411a94ddc79 upstream.

Commit 2a9127fcf229 ("mm: rewrite wait_on_page_bit_common() logic") made
the page locking entirely fair, in that if a waiter came in while the
lock was held, the lock would be transferred to the lockers strictly in
order.

That was intended to finally get rid of the long-reported watchdog
failures that involved the page lock under extreme load, where a process
could end up waiting essentially forever, as other page lockers stole
the lock from under it.

It also improved some benchmarks, but it ended up causing huge
performance regressions on others, simply because fair lock behavior
doesn't end up giving out the lock as aggressively, causing better
worst-case latency, but potentially much worse average latencies and
throughput.

Instead of reverting that change entirely, this introduces a controlled
amount of unfairness, with a sysctl knob to tune it if somebody needs
to.  But the default value should hopefully be good for any normal load,
allowing a few rounds of lock stealing, but enforcing the strict
ordering before the lock has been stolen too many times.

There is also a hint from Matthieu Baerts that the fair page coloring
may end up exposing an ABBA deadlock that is hidden by the usual
optimistic lock stealing, and while the unfairness doesn't fix the
fundamental issue (and I'm still looking at that), it avoids it in
practice.

The amount of unfairness can be modified by writing a new value to the
'sysctl_page_lock_unfairness' variable (default value of 5, exposed
through /proc/sys/vm/page_lock_unfairness), but that is hopefully
something we'd use mainly for debugging rather than being necessary for
any deep system tuning.

This whole issue has exposed just how critical the page lock can be, and
how contended it gets under certain locks.  And the main contention
doesn't really seem to be anything related to IO (which was the origin
of this lock), but for things like just verifying that the page file
mapping is stable while faulting in the page into a page table.

Link: https://lore.kernel.org/linux-fsdevel/ed8442fd-6f54-dd84-cd4a-941e8b7ee603@MichaelLarabel.com/
Link: https://www.phoronix.com/scan.php?page=article&item=linux-50-59&num=1
Link: https://lore.kernel.org/linux-fsdevel/c560a38d-8313-51fb-b1ec-e904bd8836bc@tessares.net/
Reported-and-tested-by: Michael Larabel <Michael@michaellarabel.com>
Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Chris Mason <clm@fb.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mm.h   |    2 
 include/linux/wait.h |    2 
 kernel/sysctl.c      |    8 ++
 mm/filemap.c         |  160 +++++++++++++++++++++++++++++++++++++++++----------
 4 files changed, 141 insertions(+), 31 deletions(-)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -37,6 +37,8 @@ struct user_struct;
 struct writeback_control;
 struct bdi_writeback;
 
+extern int sysctl_page_lock_unfairness;
+
 void init_mm_internals(void);
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES	/* Don't use mapnrs, do it properly */
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -20,6 +20,8 @@ int default_wake_function(struct wait_qu
 #define WQ_FLAG_EXCLUSIVE	0x01
 #define WQ_FLAG_WOKEN		0x02
 #define WQ_FLAG_BOOKMARK	0x04
+#define WQ_FLAG_CUSTOM		0x08
+#define WQ_FLAG_DONE		0x10
 
 /*
  * A single wait-queue entry structure:
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1563,6 +1563,14 @@ static struct ctl_table vm_table[] = {
 		.proc_handler	= percpu_pagelist_fraction_sysctl_handler,
 		.extra1		= SYSCTL_ZERO,
 	},
+	{
+		.procname	= "page_lock_unfairness",
+		.data		= &sysctl_page_lock_unfairness,
+		.maxlen		= sizeof(sysctl_page_lock_unfairness),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
 #ifdef CONFIG_MMU
 	{
 		.procname	= "max_map_count",
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1044,9 +1044,43 @@ struct wait_page_queue {
 	wait_queue_entry_t wait;
 };
 
+/*
+ * The page wait code treats the "wait->flags" somewhat unusually, because
+ * we have multiple different kinds of waits, not just he usual "exclusive"
+ * one.
+ *
+ * We have:
+ *
+ *  (a) no special bits set:
+ *
+ *	We're just waiting for the bit to be released, and when a waker
+ *	calls the wakeup function, we set WQ_FLAG_WOKEN and wake it up,
+ *	and remove it from the wait queue.
+ *
+ *	Simple and straightforward.
+ *
+ *  (b) WQ_FLAG_EXCLUSIVE:
+ *
+ *	The waiter is waiting to get the lock, and only one waiter should
+ *	be woken up to avoid any thundering herd behavior. We'll set the
+ *	WQ_FLAG_WOKEN bit, wake it up, and remove it from the wait queue.
+ *
+ *	This is the traditional exclusive wait.
+ *
+ *  (b) WQ_FLAG_EXCLUSIVE | WQ_FLAG_CUSTOM:
+ *
+ *	The waiter is waiting to get the bit, and additionally wants the
+ *	lock to be transferred to it for fair lock behavior. If the lock
+ *	cannot be taken, we stop walking the wait queue without waking
+ *	the waiter.
+ *
+ *	This is the "fair lock handoff" case, and in addition to setting
+ *	WQ_FLAG_WOKEN, we set WQ_FLAG_DONE to let the waiter easily see
+ *	that it now has the lock.
+ */
 static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync, void *arg)
 {
-	int ret;
+	unsigned int flags;
 	struct wait_page_key *key = arg;
 	struct wait_page_queue *wait_page
 		= container_of(wait, struct wait_page_queue, wait);
@@ -1059,35 +1093,44 @@ static int wake_page_function(wait_queue
 		return 0;
 
 	/*
-	 * If it's an exclusive wait, we get the bit for it, and
-	 * stop walking if we can't.
-	 *
-	 * If it's a non-exclusive wait, then the fact that this
-	 * wake function was called means that the bit already
-	 * was cleared, and we don't care if somebody then
-	 * re-took it.
+	 * If it's a lock handoff wait, we get the bit for it, and
+	 * stop walking (and do not wake it up) if we can't.
 	 */
-	ret = 0;
-	if (wait->flags & WQ_FLAG_EXCLUSIVE) {
-		if (test_and_set_bit(key->bit_nr, &key->page->flags))
+	flags = wait->flags;
+	if (flags & WQ_FLAG_EXCLUSIVE) {
+		if (test_bit(key->bit_nr, &key->page->flags))
 			return -1;
-		ret = 1;
+		if (flags & WQ_FLAG_CUSTOM) {
+			if (test_and_set_bit(key->bit_nr, &key->page->flags))
+				return -1;
+			flags |= WQ_FLAG_DONE;
+		}
 	}
-	wait->flags |= WQ_FLAG_WOKEN;
 
+	/*
+	 * We are holding the wait-queue lock, but the waiter that
+	 * is waiting for this will be checking the flags without
+	 * any locking.
+	 *
+	 * So update the flags atomically, and wake up the waiter
+	 * afterwards to avoid any races. This store-release pairs
+	 * with the load-acquire in wait_on_page_bit_common().
+	 */
+	smp_store_release(&wait->flags, flags | WQ_FLAG_WOKEN);
 	wake_up_state(wait->private, mode);
 
 	/*
 	 * Ok, we have successfully done what we're waiting for,
 	 * and we can unconditionally remove the wait entry.
 	 *
-	 * Note that this has to be the absolute last thing we do,
-	 * since after list_del_init(&wait->entry) the wait entry
+	 * Note that this pairs with the "finish_wait()" in the
+	 * waiter, and has to be the absolute last thing we do.
+	 * After this list_del_init(&wait->entry) the wait entry
 	 * might be de-allocated and the process might even have
 	 * exited.
 	 */
 	list_del_init_careful(&wait->entry);
-	return ret;
+	return (flags & WQ_FLAG_EXCLUSIVE) != 0;
 }
 
 static void wake_up_page_bit(struct page *page, int bit_nr)
@@ -1167,8 +1210,8 @@ enum behavior {
 };
 
 /*
- * Attempt to check (or get) the page bit, and mark the
- * waiter woken if successful.
+ * Attempt to check (or get) the page bit, and mark us done
+ * if successful.
  */
 static inline bool trylock_page_bit_common(struct page *page, int bit_nr,
 					struct wait_queue_entry *wait)
@@ -1179,13 +1222,17 @@ static inline bool trylock_page_bit_comm
 	} else if (test_bit(bit_nr, &page->flags))
 		return false;
 
-	wait->flags |= WQ_FLAG_WOKEN;
+	wait->flags |= WQ_FLAG_WOKEN | WQ_FLAG_DONE;
 	return true;
 }
 
+/* How many times do we accept lock stealing from under a waiter? */
+int sysctl_page_lock_unfairness = 5;
+
 static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	struct page *page, int bit_nr, int state, enum behavior behavior)
 {
+	int unfairness = sysctl_page_lock_unfairness;
 	struct wait_page_queue wait_page;
 	wait_queue_entry_t *wait = &wait_page.wait;
 	bool thrashing = false;
@@ -1203,11 +1250,18 @@ static inline int wait_on_page_bit_commo
 	}
 
 	init_wait(wait);
-	wait->flags = behavior == EXCLUSIVE ? WQ_FLAG_EXCLUSIVE : 0;
 	wait->func = wake_page_function;
 	wait_page.page = page;
 	wait_page.bit_nr = bit_nr;
 
+repeat:
+	wait->flags = 0;
+	if (behavior == EXCLUSIVE) {
+		wait->flags = WQ_FLAG_EXCLUSIVE;
+		if (--unfairness < 0)
+			wait->flags |= WQ_FLAG_CUSTOM;
+	}
+
 	/*
 	 * Do one last check whether we can get the
 	 * page bit synchronously.
@@ -1230,27 +1284,63 @@ static inline int wait_on_page_bit_commo
 
 	/*
 	 * From now on, all the logic will be based on
-	 * the WQ_FLAG_WOKEN flag, and the and the page
-	 * bit testing (and setting) will be - or has
-	 * already been - done by the wake function.
+	 * the WQ_FLAG_WOKEN and WQ_FLAG_DONE flag, to
+	 * see whether the page bit testing has already
+	 * been done by the wake function.
 	 *
 	 * We can drop our reference to the page.
 	 */
 	if (behavior == DROP)
 		put_page(page);
 
+	/*
+	 * Note that until the "finish_wait()", or until
+	 * we see the WQ_FLAG_WOKEN flag, we need to
+	 * be very careful with the 'wait->flags', because
+	 * we may race with a waker that sets them.
+	 */
 	for (;;) {
+		unsigned int flags;
+
 		set_current_state(state);
 
-		if (signal_pending_state(state, current))
+		/* Loop until we've been woken or interrupted */
+		flags = smp_load_acquire(&wait->flags);
+		if (!(flags & WQ_FLAG_WOKEN)) {
+			if (signal_pending_state(state, current))
+				break;
+
+			io_schedule();
+			continue;
+		}
+
+		/* If we were non-exclusive, we're done */
+		if (behavior != EXCLUSIVE)
 			break;
 
-		if (wait->flags & WQ_FLAG_WOKEN)
+		/* If the waker got the lock for us, we're done */
+		if (flags & WQ_FLAG_DONE)
 			break;
 
-		io_schedule();
+		/*
+		 * Otherwise, if we're getting the lock, we need to
+		 * try to get it ourselves.
+		 *
+		 * And if that fails, we'll have to retry this all.
+		 */
+		if (unlikely(test_and_set_bit(bit_nr, &page->flags)))
+			goto repeat;
+
+		wait->flags |= WQ_FLAG_DONE;
+		break;
 	}
 
+	/*
+	 * If a signal happened, this 'finish_wait()' may remove the last
+	 * waiter from the wait-queues, but the PageWaiters bit will remain
+	 * set. That's ok. The next wakeup will take care of it, and trying
+	 * to do it here would be difficult and prone to races.
+	 */
 	finish_wait(q, wait);
 
 	if (thrashing) {
@@ -1260,12 +1350,20 @@ static inline int wait_on_page_bit_commo
 	}
 
 	/*
-	 * A signal could leave PageWaiters set. Clearing it here if
-	 * !waitqueue_active would be possible (by open-coding finish_wait),
-	 * but still fail to catch it in the case of wait hash collision. We
-	 * already can fail to clear wait hash collision cases, so don't
-	 * bother with signals either.
+	 * NOTE! The wait->flags weren't stable until we've done the
+	 * 'finish_wait()', and we could have exited the loop above due
+	 * to a signal, and had a wakeup event happen after the signal
+	 * test but before the 'finish_wait()'.
+	 *
+	 * So only after the finish_wait() can we reliably determine
+	 * if we got woken up or not, so we can now figure out the final
+	 * return value based on that state without races.
+	 *
+	 * Also note that WQ_FLAG_WOKEN is sufficient for a non-exclusive
+	 * waiter, but an exclusive one requires WQ_FLAG_DONE.
 	 */
+	if (behavior == EXCLUSIVE)
+		return wait->flags & WQ_FLAG_DONE ? 0 : -EINTR;
 
 	return wait->flags & WQ_FLAG_WOKEN ? 0 : -EINTR;
 }


