Return-Path: <stable+bounces-98380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437D99E40B5
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC75A16356C
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2154A157A5C;
	Wed,  4 Dec 2024 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKZWYEag"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCDB2941C;
	Wed,  4 Dec 2024 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331606; cv=none; b=T+dTaxNix/bdIIVJsQXBXAC9VLRhTaf0/6pgJZoOnGqEAsPo/z1JF1E6iztFHSrgmRniHWcLHpKCP12rLV/4VYBsMP9bafTtIuFXppkDR05lFzQPNFKU69QKT0spqleR+UXQ5S/tyhdMAxdMCRfdSi98n+to4a09v3RvHE8TjhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331606; c=relaxed/simple;
	bh=M8PWP365zmorQDzp6q7GFS1f5y5PWf8j4UtCCX7A9uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkzmdEIM0IJfbPCCUebH5Z0Yka2OGZOT99ImSnlhCoxzd1v7/pv4dejU61+vbYdNNP4dR+J9wmf1j13AeIsfUQN0lzVlR9Dru5EroMsBIdz3jrEt0d7tshYxfBd5Jmi08intMeY/fZaA3jQgyTAE+AvESmxMUkEpiIFi4EDnRHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKZWYEag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A332C4CECD;
	Wed,  4 Dec 2024 17:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331606;
	bh=M8PWP365zmorQDzp6q7GFS1f5y5PWf8j4UtCCX7A9uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKZWYEagajMtqznKLB9QbzUDLW1d3Yj4n1DIUWk+7e7Nqwas9CEB7eNhY0kXr0MVO
	 dz4shhfFCGRL6+sPSjZ4vbNwqpse+0Pvy0556HMf2wIsH0ggc4I/GHAlP9fT6jPCkf
	 uc5BYAq2fWQQjStnO7glVSIiolFA+/S1/BTv6NBNPwr27DdwHEoE+u4LCu0PLMaQk5
	 TLgJXII7NPtkFDiDY/szM/Nm/H0s6qfy0aTsQNFBTlQ5dfWUSbtzwK9IxvCKdQJ1X+
	 5/PRh8LRdiUS5dyE8/6v8FdjwMpFL/p2JmipZZMDUXMCTT2CZ4hDhEKvBaSszv7M1n
	 NTHsY7t0ceJIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Petr Pavlu <petr.pavlu@suse.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 11/33] ring-buffer: Limit time with disabled interrupts in rb_check_pages()
Date: Wed,  4 Dec 2024 10:47:24 -0500
Message-ID: <20241204154817.2212455-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204154817.2212455-1-sashal@kernel.org>
References: <20241204154817.2212455-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Petr Pavlu <petr.pavlu@suse.com>

[ Upstream commit b237e1f7d2273fdcffac20100b72c002bdd770dd ]

The function rb_check_pages() validates the integrity of a specified
per-CPU tracing ring buffer. It does so by traversing the underlying
linked list and checking its next and prev links.

To guarantee that the list isn't modified during the check, a caller
typically needs to take cpu_buffer->reader_lock. This prevents the check
from running concurrently, for example, with a potential reader which
can make the list temporarily inconsistent when swapping its old reader
page into the buffer.

A problem with this approach is that the time when interrupts are
disabled is non-deterministic, dependent on the ring buffer size. This
particularly affects PREEMPT_RT because the reader_lock is a raw
spinlock which doesn't become sleepable on PREEMPT_RT kernels.

Modify the check so it still attempts to traverse the entire list, but
gives up the reader_lock between checking individual pages. Introduce
for this purpose a new variable ring_buffer_per_cpu.cnt which is bumped
any time the list is modified. The value is used by rb_check_pages() to
detect such a change and restart the check.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20241015112810.27203-1-petr.pavlu@suse.com
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 98 ++++++++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fb7b092e79313..f282c1335edc9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -462,6 +462,8 @@ struct ring_buffer_per_cpu {
 	unsigned long			nr_pages;
 	unsigned int			current_context;
 	struct list_head		*pages;
+	/* pages generation counter, incremented when the list changes */
+	unsigned long			cnt;
 	struct buffer_page		*head_page;	/* read from head */
 	struct buffer_page		*tail_page;	/* write to tail */
 	struct buffer_page		*commit_page;	/* committed pages */
@@ -1442,40 +1444,87 @@ static void rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
 	RB_WARN_ON(cpu_buffer, val & RB_FLAG_MASK);
 }
 
+static bool rb_check_links(struct ring_buffer_per_cpu *cpu_buffer,
+			   struct list_head *list)
+{
+	if (RB_WARN_ON(cpu_buffer,
+		       rb_list_head(rb_list_head(list->next)->prev) != list))
+		return false;
+
+	if (RB_WARN_ON(cpu_buffer,
+		       rb_list_head(rb_list_head(list->prev)->next) != list))
+		return false;
+
+	return true;
+}
+
 /**
  * rb_check_pages - integrity check of buffer pages
  * @cpu_buffer: CPU buffer with pages to test
  *
  * As a safety measure we check to make sure the data pages have not
  * been corrupted.
- *
- * Callers of this function need to guarantee that the list of pages doesn't get
- * modified during the check. In particular, if it's possible that the function
- * is invoked with concurrent readers which can swap in a new reader page then
- * the caller should take cpu_buffer->reader_lock.
  */
 static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	struct list_head *head = rb_list_head(cpu_buffer->pages);
-	struct list_head *tmp;
+	struct list_head *head, *tmp;
+	unsigned long buffer_cnt;
+	unsigned long flags;
+	int nr_loops = 0;
 
-	if (RB_WARN_ON(cpu_buffer,
-			rb_list_head(rb_list_head(head->next)->prev) != head))
+	/*
+	 * Walk the linked list underpinning the ring buffer and validate all
+	 * its next and prev links.
+	 *
+	 * The check acquires the reader_lock to avoid concurrent processing
+	 * with code that could be modifying the list. However, the lock cannot
+	 * be held for the entire duration of the walk, as this would make the
+	 * time when interrupts are disabled non-deterministic, dependent on the
+	 * ring buffer size. Therefore, the code releases and re-acquires the
+	 * lock after checking each page. The ring_buffer_per_cpu.cnt variable
+	 * is then used to detect if the list was modified while the lock was
+	 * not held, in which case the check needs to be restarted.
+	 *
+	 * The code attempts to perform the check at most three times before
+	 * giving up. This is acceptable because this is only a self-validation
+	 * to detect problems early on. In practice, the list modification
+	 * operations are fairly spaced, and so this check typically succeeds at
+	 * most on the second try.
+	 */
+again:
+	if (++nr_loops > 3)
 		return;
 
-	if (RB_WARN_ON(cpu_buffer,
-			rb_list_head(rb_list_head(head->prev)->next) != head))
-		return;
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+	head = rb_list_head(cpu_buffer->pages);
+	if (!rb_check_links(cpu_buffer, head))
+		goto out_locked;
+	buffer_cnt = cpu_buffer->cnt;
+	tmp = head;
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
-	for (tmp = rb_list_head(head->next); tmp != head; tmp = rb_list_head(tmp->next)) {
-		if (RB_WARN_ON(cpu_buffer,
-				rb_list_head(rb_list_head(tmp->next)->prev) != tmp))
-			return;
+	while (true) {
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 
-		if (RB_WARN_ON(cpu_buffer,
-				rb_list_head(rb_list_head(tmp->prev)->next) != tmp))
-			return;
+		if (buffer_cnt != cpu_buffer->cnt) {
+			/* The list was updated, try again. */
+			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+			goto again;
+		}
+
+		tmp = rb_list_head(tmp->next);
+		if (tmp == head)
+			/* The iteration circled back, all is done. */
+			goto out_locked;
+
+		if (!rb_check_links(cpu_buffer, tmp))
+			goto out_locked;
+
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	}
+
+out_locked:
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 }
 
 static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
@@ -1862,6 +1911,7 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 
 	/* make sure pages points to a valid page in the ring buffer */
 	cpu_buffer->pages = next_page;
+	cpu_buffer->cnt++;
 
 	/* update head page */
 	if (head_bit)
@@ -1968,6 +2018,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 			 * pointer to point to end of list
 			 */
 			head_page->prev = last_page;
+			cpu_buffer->cnt++;
 			success = true;
 			break;
 		}
@@ -2203,12 +2254,8 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		 */
 		synchronize_rcu();
 		for_each_buffer_cpu(buffer, cpu) {
-			unsigned long flags;
-
 			cpu_buffer = buffer->buffers[cpu];
-			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 			rb_check_pages(cpu_buffer);
-			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 		}
 		atomic_dec(&buffer->record_disabled);
 	}
@@ -4599,6 +4646,7 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	rb_list_head(reader->list.next)->prev = &cpu_buffer->reader_page->list;
 	rb_inc_page(&cpu_buffer->head_page);
 
+	cpu_buffer->cnt++;
 	local_inc(&cpu_buffer->pages_read);
 
 	/* Finally update the reader page to the new head */
@@ -5138,12 +5186,9 @@ void
 ring_buffer_read_finish(struct ring_buffer_iter *iter)
 {
 	struct ring_buffer_per_cpu *cpu_buffer = iter->cpu_buffer;
-	unsigned long flags;
 
 	/* Use this opportunity to check the integrity of the ring buffer. */
-	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 	rb_check_pages(cpu_buffer);
-	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
 	atomic_dec(&cpu_buffer->resize_disabled);
 	kfree(iter->event);
@@ -6040,6 +6085,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		/* Install the new pages, remove the head from the list */
 		cpu_buffer->pages = cpu_buffer->new_pages.next;
 		list_del_init(&cpu_buffer->new_pages);
+		cpu_buffer->cnt++;
 
 		cpu_buffer->head_page
 			= list_entry(cpu_buffer->pages, struct buffer_page, list);
-- 
2.43.0


