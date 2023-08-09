Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45F6775C03
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbjHILXD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjHILXC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:23:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24759FA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:23:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B93D263221
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B75C433C8;
        Wed,  9 Aug 2023 11:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580181;
        bh=dyfCt21jG7dEehc0wGrz4En5hdJTniNBsHHSDE4cSlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BY4Te4Esxz2KQT7qXW9sN6af2FAZAQ108Bd1BtmaV0lGQ/HX0YrwV4irM2DUzILo1
         BMbL51/iq0NF+tPjAnAquDwRJS7dU1VENRliywHDeoinPK8pHUvhqXAdqU8NpRofF3
         hE+OPzFm8R0TDMUhlFFdkgYMjaKPPFMkij6DUYL8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, mhiramat@kernel.org,
        vnagarnaik@google.com, Zheng Yejian <zhengyejian1@huawei.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 256/323] ring-buffer: Fix wrong stat of cpu_buffer->read
Date:   Wed,  9 Aug 2023 12:41:34 +0200
Message-ID: <20230809103709.799141475@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zheng Yejian <zhengyejian1@huawei.com>

[ Upstream commit 2d093282b0d4357373497f65db6a05eb0c28b7c8 ]

When pages are removed in rb_remove_pages(), 'cpu_buffer->read' is set
to 0 in order to make sure any read iterators reset themselves. However,
this will mess 'entries' stating, see following steps:

  # cd /sys/kernel/tracing/
  # 1. Enlarge ring buffer prepare for later reducing:
  # echo 20 > per_cpu/cpu0/buffer_size_kb
  # 2. Write a log into ring buffer of cpu0:
  # taskset -c 0 echo "hello1" > trace_marker
  # 3. Read the log:
  # cat per_cpu/cpu0/trace_pipe
       <...>-332     [000] .....    62.406844: tracing_mark_write: hello1
  # 4. Stop reading and see the stats, now 0 entries, and 1 event readed:
  # cat per_cpu/cpu0/stats
   entries: 0
   [...]
   read events: 1
  # 5. Reduce the ring buffer
  # echo 7 > per_cpu/cpu0/buffer_size_kb
  # 6. Now entries became unexpected 1 because actually no entries!!!
  # cat per_cpu/cpu0/stats
   entries: 1
   [...]
   read events: 0

To fix it, introduce 'page_removed' field to count total removed pages
since last reset, then use it to let read iterators reset themselves
instead of changing the 'read' pointer.

Link: https://lore.kernel.org/linux-trace-kernel/20230724054040.3489499-1-zhengyejian1@huawei.com

Cc: <mhiramat@kernel.org>
Cc: <vnagarnaik@google.com>
Fixes: 83f40318dab0 ("ring-buffer: Make removal of ring buffer pages atomic")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 211a8163c9bb5..c8a7de7a1d635 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -493,6 +493,8 @@ struct ring_buffer_per_cpu {
 	unsigned long			read_bytes;
 	u64				write_stamp;
 	u64				read_stamp;
+	/* pages removed since last reset */
+	unsigned long			pages_removed;
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
@@ -528,6 +530,7 @@ struct ring_buffer_iter {
 	struct buffer_page		*head_page;
 	struct buffer_page		*cache_reader_page;
 	unsigned long			cache_read;
+	unsigned long			cache_pages_removed;
 	u64				read_stamp;
 };
 
@@ -1514,6 +1517,8 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 		to_remove = rb_list_head(to_remove)->next;
 		head_bit |= (unsigned long)to_remove & RB_PAGE_HEAD;
 	}
+	/* Read iterators need to reset themselves when some pages removed */
+	cpu_buffer->pages_removed += nr_removed;
 
 	next_page = rb_list_head(to_remove)->next;
 
@@ -1535,12 +1540,6 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 		cpu_buffer->head_page = list_entry(next_page,
 						struct buffer_page, list);
 
-	/*
-	 * change read pointer to make sure any read iterators reset
-	 * themselves
-	 */
-	cpu_buffer->read = 0;
-
 	/* pages are removed, resume tracing and then free the pages */
 	atomic_dec(&cpu_buffer->record_disabled);
 	raw_spin_unlock_irq(&cpu_buffer->reader_lock);
@@ -3582,6 +3581,7 @@ static void rb_iter_reset(struct ring_buffer_iter *iter)
 
 	iter->cache_reader_page = iter->head_page;
 	iter->cache_read = cpu_buffer->read;
+	iter->cache_pages_removed = cpu_buffer->pages_removed;
 
 	if (iter->head)
 		iter->read_stamp = cpu_buffer->read_stamp;
@@ -4022,12 +4022,13 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	buffer = cpu_buffer->buffer;
 
 	/*
-	 * Check if someone performed a consuming read to
-	 * the buffer. A consuming read invalidates the iterator
-	 * and we need to reset the iterator in this case.
+	 * Check if someone performed a consuming read to the buffer
+	 * or removed some pages from the buffer. In these cases,
+	 * iterator was invalidated and we need to reset it.
 	 */
 	if (unlikely(iter->cache_read != cpu_buffer->read ||
-		     iter->cache_reader_page != cpu_buffer->reader_page))
+		     iter->cache_reader_page != cpu_buffer->reader_page ||
+		     iter->cache_pages_removed != cpu_buffer->pages_removed))
 		rb_iter_reset(iter);
 
  again:
@@ -4454,6 +4455,7 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->last_overrun = 0;
 
 	rb_head_page_activate(cpu_buffer);
+	cpu_buffer->pages_removed = 0;
 }
 
 /**
-- 
2.40.1



