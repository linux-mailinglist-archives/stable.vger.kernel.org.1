Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB5073E96A
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjFZSfr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjFZSfq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:35:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D966E94
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:35:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59F7A60F40
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6622AC433CA;
        Mon, 26 Jun 2023 18:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804543;
        bh=6NclyYsBb5XjbhRVTJgjJBi+5sN6i0iTbxIZhe4wOic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=whI5cl0Cb9su8IQ3/QCecJNIC+CMaG/f1gxi8wLJ0IemY42IxVJXLRBasSm4Tehfq
         aQw3PUU3CCpc/nIchOZI7TW/syLH1bAX+1bm+6YhP8xDuA4bMr+C3DdP4M0mBLDrX5
         vpgbmSGAP1foHJMBjzUpmjeMrU6htY3BjG7u2QAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oleg Nesterov <oleg@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 02/60] mm: rewrite wait_on_page_bit_common() logic
Date:   Mon, 26 Jun 2023 20:11:41 +0200
Message-ID: <20230626180739.640524541@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180739.558575012@linuxfoundation.org>
References: <20230626180739.558575012@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 2a9127fcf2296674d58024f83981f40b128fffea ]

It turns out that wait_on_page_bit_common() had several problems,
ranging from just unfair behavioe due to re-queueing at the end of the
wait queue when re-trying, and an outright bug that could result in
missed wakeups (but probably never happened in practice).

This rewrites the whole logic to avoid both issues, by simply moving the
logic to check (and possibly take) the bit lock into the wakeup path
instead.

That makes everything much more straightforward, and means that we never
need to re-queue the wait entry: if we get woken up, we'll be notified
through WQ_FLAG_WOKEN, and the wait queue entry will have been removed,
and everything will have been done for us.

Link: https://lore.kernel.org/lkml/CAHk-=wjJA2Z3kUFb-5s=6+n0qbTs8ELqKFt9B3pH85a8fGD73w@mail.gmail.com/
Link: https://lore.kernel.org/lkml/alpine.LSU.2.11.2007221359450.1017@eggly.anvils/
Reported-by: Oleg Nesterov <oleg@redhat.com>
Reported-by: Hugh Dickins <hughd@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Stable-dep-of: 2192bba03d80 ("epoll: ep_autoremove_wake_function should use list_del_init_careful")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/filemap.c | 132 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 85 insertions(+), 47 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index c094103191a6e..83b324420046b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1046,6 +1046,7 @@ struct wait_page_queue {
 
 static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync, void *arg)
 {
+	int ret;
 	struct wait_page_key *key = arg;
 	struct wait_page_queue *wait_page
 		= container_of(wait, struct wait_page_queue, wait);
@@ -1058,17 +1059,40 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 		return 0;
 
 	/*
-	 * Stop walking if it's locked.
-	 * Is this safe if put_and_wait_on_page_locked() is in use?
-	 * Yes: the waker must hold a reference to this page, and if PG_locked
-	 * has now already been set by another task, that task must also hold
-	 * a reference to the *same usage* of this page; so there is no need
-	 * to walk on to wake even the put_and_wait_on_page_locked() callers.
+	 * If it's an exclusive wait, we get the bit for it, and
+	 * stop walking if we can't.
+	 *
+	 * If it's a non-exclusive wait, then the fact that this
+	 * wake function was called means that the bit already
+	 * was cleared, and we don't care if somebody then
+	 * re-took it.
 	 */
-	if (test_bit(key->bit_nr, &key->page->flags))
-		return -1;
+	ret = 0;
+	if (wait->flags & WQ_FLAG_EXCLUSIVE) {
+		if (test_and_set_bit(key->bit_nr, &key->page->flags))
+			return -1;
+		ret = 1;
+	}
+	wait->flags |= WQ_FLAG_WOKEN;
 
-	return autoremove_wake_function(wait, mode, sync, key);
+	wake_up_state(wait->private, mode);
+
+	/*
+	 * Ok, we have successfully done what we're waiting for,
+	 * and we can unconditionally remove the wait entry.
+	 *
+	 * Note that this has to be the absolute last thing we do,
+	 * since after list_del_init(&wait->entry) the wait entry
+	 * might be de-allocated and the process might even have
+	 * exited.
+	 *
+	 * We _really_ should have a "list_del_init_careful()" to
+	 * properly pair with the unlocked "list_empty_careful()"
+	 * in finish_wait().
+	 */
+	smp_mb();
+	list_del_init(&wait->entry);
+	return ret;
 }
 
 static void wake_up_page_bit(struct page *page, int bit_nr)
@@ -1147,16 +1171,31 @@ enum behavior {
 			 */
 };
 
+/*
+ * Attempt to check (or get) the page bit, and mark the
+ * waiter woken if successful.
+ */
+static inline bool trylock_page_bit_common(struct page *page, int bit_nr,
+					struct wait_queue_entry *wait)
+{
+	if (wait->flags & WQ_FLAG_EXCLUSIVE) {
+		if (test_and_set_bit(bit_nr, &page->flags))
+			return false;
+	} else if (test_bit(bit_nr, &page->flags))
+		return false;
+
+	wait->flags |= WQ_FLAG_WOKEN;
+	return true;
+}
+
 static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	struct page *page, int bit_nr, int state, enum behavior behavior)
 {
 	struct wait_page_queue wait_page;
 	wait_queue_entry_t *wait = &wait_page.wait;
-	bool bit_is_set;
 	bool thrashing = false;
 	bool delayacct = false;
 	unsigned long pflags;
-	int ret = 0;
 
 	if (bit_nr == PG_locked &&
 	    !PageUptodate(page) && PageWorkingset(page)) {
@@ -1174,48 +1213,47 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	wait_page.page = page;
 	wait_page.bit_nr = bit_nr;
 
-	for (;;) {
-		spin_lock_irq(&q->lock);
+	/*
+	 * Do one last check whether we can get the
+	 * page bit synchronously.
+	 *
+	 * Do the SetPageWaiters() marking before that
+	 * to let any waker we _just_ missed know they
+	 * need to wake us up (otherwise they'll never
+	 * even go to the slow case that looks at the
+	 * page queue), and add ourselves to the wait
+	 * queue if we need to sleep.
+	 *
+	 * This part needs to be done under the queue
+	 * lock to avoid races.
+	 */
+	spin_lock_irq(&q->lock);
+	SetPageWaiters(page);
+	if (!trylock_page_bit_common(page, bit_nr, wait))
+		__add_wait_queue_entry_tail(q, wait);
+	spin_unlock_irq(&q->lock);
 
-		if (likely(list_empty(&wait->entry))) {
-			__add_wait_queue_entry_tail(q, wait);
-			SetPageWaiters(page);
-		}
+	/*
+	 * From now on, all the logic will be based on
+	 * the WQ_FLAG_WOKEN flag, and the and the page
+	 * bit testing (and setting) will be - or has
+	 * already been - done by the wake function.
+	 *
+	 * We can drop our reference to the page.
+	 */
+	if (behavior == DROP)
+		put_page(page);
 
+	for (;;) {
 		set_current_state(state);
 
-		spin_unlock_irq(&q->lock);
-
-		bit_is_set = test_bit(bit_nr, &page->flags);
-		if (behavior == DROP)
-			put_page(page);
-
-		if (likely(bit_is_set))
-			io_schedule();
-
-		if (behavior == EXCLUSIVE) {
-			if (!test_and_set_bit_lock(bit_nr, &page->flags))
-				break;
-		} else if (behavior == SHARED) {
-			if (!test_bit(bit_nr, &page->flags))
-				break;
-		}
-
-		if (signal_pending_state(state, current)) {
-			ret = -EINTR;
+		if (signal_pending_state(state, current))
 			break;
-		}
 
-		if (behavior == DROP) {
-			/*
-			 * We can no longer safely access page->flags:
-			 * even if CONFIG_MEMORY_HOTREMOVE is not enabled,
-			 * there is a risk of waiting forever on a page reused
-			 * for something that keeps it locked indefinitely.
-			 * But best check for -EINTR above before breaking.
-			 */
+		if (wait->flags & WQ_FLAG_WOKEN)
 			break;
-		}
+
+		io_schedule();
 	}
 
 	finish_wait(q, wait);
@@ -1234,7 +1272,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	 * bother with signals either.
 	 */
 
-	return ret;
+	return wait->flags & WQ_FLAG_WOKEN ? 0 : -EINTR;
 }
 
 void wait_on_page_bit(struct page *page, int bit_nr)
-- 
2.39.2



