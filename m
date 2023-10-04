Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DEF7B8444
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 17:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242929AbjJDPyy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 11:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243191AbjJDPyx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 11:54:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357A89E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 08:54:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B713C433C7;
        Wed,  4 Oct 2023 15:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696434889;
        bh=4WnWhJ3YbiiyssajDrRjbDByK4q1hAlg9coWLiw7h9k=;
        h=Subject:To:Cc:From:Date:From;
        b=R5A8RrUM/Cra70YTLk4GfNa59WPNiVbbQSRXJHdwJwBhH2X8mEXw9ORk7Uvn6wIxt
         00GE9VEBNJ/66yROUNxKeEt5xauo7k2tRmbb3Z25X1QGhe1Oq0BLUVeA3vW7bl942v
         xYIJedU+/JEog8AO83MyYoEpBFxx5sj2huHLXIWU=
Subject: FAILED: patch "[PATCH] ring-buffer: Fix bytes info in per_cpu buffer stats" failed to apply to 4.19-stable tree
To:     zhengyejian1@huawei.com, rostedt@goodmis.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 04 Oct 2023 17:54:39 +0200
Message-ID: <2023100438-palpable-marina-68c8@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 45d99ea451d0c30bfd4864f0fe485d7dac014902
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100438-palpable-marina-68c8@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 45d99ea451d0c30bfd4864f0fe485d7dac014902 Mon Sep 17 00:00:00 2001
From: Zheng Yejian <zhengyejian1@huawei.com>
Date: Thu, 21 Sep 2023 20:54:25 +0800
Subject: [PATCH] ring-buffer: Fix bytes info in per_cpu buffer stats

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

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a1651edc48d5..28daf0ce95c5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -354,6 +354,11 @@ static void rb_init_page(struct buffer_data_page *bpage)
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
@@ -2003,7 +2008,7 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 			 * Increment overrun to account for the lost events.
 			 */
 			local_add(page_entries, &cpu_buffer->overrun);
-			local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
+			local_sub(rb_page_commit(to_remove_page), &cpu_buffer->entries_bytes);
 			local_inc(&cpu_buffer->pages_lost);
 		}
 
@@ -2367,11 +2372,6 @@ rb_reader_event(struct ring_buffer_per_cpu *cpu_buffer)
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
@@ -2517,7 +2517,7 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 		 * the counters.
 		 */
 		local_add(entries, &cpu_buffer->overrun);
-		local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
+		local_sub(rb_page_commit(next_page), &cpu_buffer->entries_bytes);
 		local_inc(&cpu_buffer->pages_lost);
 
 		/*
@@ -2660,9 +2660,6 @@ rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 
 	event = __rb_page_index(tail_page, tail);
 
-	/* account for padding bytes */
-	local_add(BUF_PAGE_SIZE - tail, &cpu_buffer->entries_bytes);
-
 	/*
 	 * Save the original length to the meta data.
 	 * This will be used by the reader to add lost event
@@ -2676,7 +2673,8 @@ rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	 * write counter enough to allow another writer to slip
 	 * in on this page.
 	 * We put in a discarded commit instead, to make sure
-	 * that this space is not used again.
+	 * that this space is not used again, and this space will
+	 * not be accounted into 'entries_bytes'.
 	 *
 	 * If we are less than the minimum size, we don't need to
 	 * worry about it.
@@ -2701,6 +2699,9 @@ rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	/* time delta must be non zero */
 	event->time_delta = 1;
 
+	/* account for padding bytes */
+	local_add(BUF_PAGE_SIZE - tail, &cpu_buffer->entries_bytes);
+
 	/* Make sure the padding is visible before the tail_page->write update */
 	smp_wmb();
 
@@ -4215,7 +4216,7 @@ u64 ring_buffer_oldest_event_ts(struct trace_buffer *buffer, int cpu)
 EXPORT_SYMBOL_GPL(ring_buffer_oldest_event_ts);
 
 /**
- * ring_buffer_bytes_cpu - get the number of bytes consumed in a cpu buffer
+ * ring_buffer_bytes_cpu - get the number of bytes unconsumed in a cpu buffer
  * @buffer: The ring buffer
  * @cpu: The per CPU buffer to read from.
  */
@@ -4723,6 +4724,7 @@ static void rb_advance_reader(struct ring_buffer_per_cpu *cpu_buffer)
 
 	length = rb_event_length(event);
 	cpu_buffer->reader_page->read += length;
+	cpu_buffer->read_bytes += length;
 }
 
 static void rb_advance_iter(struct ring_buffer_iter *iter)
@@ -5816,7 +5818,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	} else {
 		/* update the entry counter */
 		cpu_buffer->read += rb_page_entries(reader);
-		cpu_buffer->read_bytes += BUF_PAGE_SIZE;
+		cpu_buffer->read_bytes += rb_page_commit(reader);
 
 		/* swap the pages */
 		rb_init_page(bpage);

