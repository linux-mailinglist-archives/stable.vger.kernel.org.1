Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112A67BDF01
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376500AbjJINZZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376466AbjJINZX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:25:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBA99D
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:25:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C13BC433C7;
        Mon,  9 Oct 2023 13:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857922;
        bh=Gufg5VoBhUW2ZM8+iLwr7vKQi2JBfHNAK5jkm2dILtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cm8IygkZ9mXi2enCH/JgMGyPELciDtVRlC+SSZDVcZQrl6wHWGbMYcrwA0jnBPDd2
         NdCiEDkGLzs8YnHlbcqMH1tzn8k2qbjBo9cEzghdZIE0vYU78iwEW7XbkG7xELRuzP
         3L9E/9IMviUWxDBNC3SguL1cxGkyibth7xv7XZxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Yejian <zhengyejian1@huawei.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 09/75] ring-buffer: Fix bytes info in per_cpu buffer stats
Date:   Mon,  9 Oct 2023 15:01:31 +0200
Message-ID: <20231009130111.541174327@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
References: <20231009130111.200710898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zheng Yejian <zhengyejian1@huawei.com>

[ Upstream commit 45d99ea451d0c30bfd4864f0fe485d7dac014902 ]

The 'bytes' info in file 'per_cpu/cpu<X>/stats' means the number of
bytes in cpu buffer that have not been consumed. However, currently
after consuming data by reading file 'trace_pipe', the 'bytes' info
was not changed as expected.

  # cat per_cpu/cpu0/stats
  entries: 0
  overrun: 0
  commit overrun: 0
  bytes: 568             <--- 'bytes' is problematical !!!
  oldest event ts:  8651.371479
  now ts:  8653.912224
  dropped events: 0
  read events: 8

The root cause is incorrect stat on cpu_buffer->read_bytes. To fix it:
  1. When stat 'read_bytes', account consumed event in rb_advance_reader();
  2. When stat 'entries_bytes', exclude the discarded padding event which
     is smaller than minimum size because it is invisible to reader. Then
     use rb_page_commit() instead of BUF_PAGE_SIZE at where accounting for
     page-based read/remove/overrun.

Also correct the comments of ring_buffer_bytes_cpu() in this patch.

Link: https://lore.kernel.org/linux-trace-kernel/20230921125425.1708423-1-zhengyejian1@huawei.com

Cc: stable@vger.kernel.org
Fixes: c64e148a3be3 ("trace: Add ring buffer stats to measure rate of events")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 352a7de4fc458..e5dc7b5a261c6 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -346,6 +346,11 @@ static void rb_init_page(struct buffer_data_page *bpage)
 	local_set(&bpage->commit, 0);
 }
 
+static __always_inline unsigned int rb_page_commit(struct buffer_page *bpage)
+{
+	return local_read(&bpage->page->commit);
+}
+
 static void free_buffer_page(struct buffer_page *bpage)
 {
 	free_page((unsigned long)bpage->page);
@@ -1984,7 +1989,7 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 			 * Increment overrun to account for the lost events.
 			 */
 			local_add(page_entries, &cpu_buffer->overrun);
-			local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
+			local_sub(rb_page_commit(to_remove_page), &cpu_buffer->entries_bytes);
 			local_inc(&cpu_buffer->pages_lost);
 		}
 
@@ -2328,11 +2333,6 @@ rb_reader_event(struct ring_buffer_per_cpu *cpu_buffer)
 			       cpu_buffer->reader_page->read);
 }
 
-static __always_inline unsigned rb_page_commit(struct buffer_page *bpage)
-{
-	return local_read(&bpage->page->commit);
-}
-
 static struct ring_buffer_event *
 rb_iter_head_event(struct ring_buffer_iter *iter)
 {
@@ -2478,7 +2478,7 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 		 * the counters.
 		 */
 		local_add(entries, &cpu_buffer->overrun);
-		local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
+		local_sub(rb_page_commit(next_page), &cpu_buffer->entries_bytes);
 		local_inc(&cpu_buffer->pages_lost);
 
 		/*
@@ -2621,9 +2621,6 @@ rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 
 	event = __rb_page_index(tail_page, tail);
 
-	/* account for padding bytes */
-	local_add(BUF_PAGE_SIZE - tail, &cpu_buffer->entries_bytes);
-
 	/*
 	 * Save the original length to the meta data.
 	 * This will be used by the reader to add lost event
@@ -2637,7 +2634,8 @@ rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	 * write counter enough to allow another writer to slip
 	 * in on this page.
 	 * We put in a discarded commit instead, to make sure
-	 * that this space is not used again.
+	 * that this space is not used again, and this space will
+	 * not be accounted into 'entries_bytes'.
 	 *
 	 * If we are less than the minimum size, we don't need to
 	 * worry about it.
@@ -2662,6 +2660,9 @@ rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	/* time delta must be non zero */
 	event->time_delta = 1;
 
+	/* account for padding bytes */
+	local_add(BUF_PAGE_SIZE - tail, &cpu_buffer->entries_bytes);
+
 	/* Make sure the padding is visible before the tail_page->write update */
 	smp_wmb();
 
@@ -4177,7 +4178,7 @@ u64 ring_buffer_oldest_event_ts(struct trace_buffer *buffer, int cpu)
 EXPORT_SYMBOL_GPL(ring_buffer_oldest_event_ts);
 
 /**
- * ring_buffer_bytes_cpu - get the number of bytes consumed in a cpu buffer
+ * ring_buffer_bytes_cpu - get the number of bytes unconsumed in a cpu buffer
  * @buffer: The ring buffer
  * @cpu: The per CPU buffer to read from.
  */
@@ -4685,6 +4686,7 @@ static void rb_advance_reader(struct ring_buffer_per_cpu *cpu_buffer)
 
 	length = rb_event_length(event);
 	cpu_buffer->reader_page->read += length;
+	cpu_buffer->read_bytes += length;
 }
 
 static void rb_advance_iter(struct ring_buffer_iter *iter)
@@ -5778,7 +5780,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	} else {
 		/* update the entry counter */
 		cpu_buffer->read += rb_page_entries(reader);
-		cpu_buffer->read_bytes += BUF_PAGE_SIZE;
+		cpu_buffer->read_bytes += rb_page_commit(reader);
 
 		/* swap the pages */
 		rb_init_page(bpage);
-- 
2.40.1



