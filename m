Return-Path: <stable+bounces-116479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C67AA36BD7
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 04:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E56F7A4494
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 03:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6409018B467;
	Sat, 15 Feb 2025 03:52:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376E418950A;
	Sat, 15 Feb 2025 03:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739591569; cv=none; b=qAeYMznWCwbKtxbgAH+1wkQVfEB+g7YuaoDTpU8CnR7YAmK8CmKxS/Y3MixlhZ++rR7a/v+1M5O8y2U3w7hgzLS2lAihATBc8xE3znhxJb5YzJlhdvRp2ms1g2BBXe7V6rZJ1UtBYoUy/a3b+a/JGHkHaOyouNKzIDCC3p2Hgrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739591569; c=relaxed/simple;
	bh=EBOuzCn9cDnla0fhU5eNtn8IHcG5Hasda2XM8CLZYj8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iLma6XZ0WIMDL4lMXnsh06tCYxZV7t/xGYAXqw/o+vb70TADyZ0aBvXO3EaDUK9PsXwmuLl3M8RCOWtRdYEIOZ3JcNrNohVwHCwePsb/JQMTC1Yxzd0eeaDfoFdS+yYiSmeOMfXISjJm332K8cocY7NLHcQlnmboIjcBAwYH8uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B160AC4CEE7;
	Sat, 15 Feb 2025 03:52:48 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tj9Ek-00000002hF1-2rDX;
	Fri, 14 Feb 2025 22:53:02 -0500
Message-ID: <20250215035302.532467545@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 14 Feb 2025 22:52:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-linus][PATCH 3/5] ring-buffer: Validate the persistent meta data subbuf array
References: <20250215035231.786853904@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The meta data for a mapped ring buffer contains an array of indexes of all
the subbuffers. The first entry is the reader page, and the rest of the
entries lay out the order of the subbuffers in how the ring buffer link
list is to be created.

The validator currently makes sure that all the entries are within the
range of 0 and nr_subbufs. But it does not check if there are any
duplicates.

While working on the ring buffer, I corrupted this array, where I added
duplicates. The validator did not catch it and created the ring buffer
link list on top of it. Luckily, the corruption was only that the reader
page was also in the writer path and only presented corrupted data but did
not crash the kernel. But if there were duplicates in the writer side,
then it could corrupt the ring buffer link list and cause a crash.

Create a bitmask array with the size of the number of subbuffers. Then
clear it. When walking through the subbuf array checking to see if the
entries are within the range, test if its bit is already set in the
subbuf_mask. If it is, then there is duplicates and fail the validation.
If not, set the corresponding bit and continue.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Link: https://lore.kernel.org/20250214102820.7509ddea@gandalf.local.home
Fixes: c76883f18e59b ("ring-buffer: Add test if range of boot buffer is valid")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 07b421115692..0419d41a2060 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1672,7 +1672,8 @@ static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int idx)
  * must be the same.
  */
 static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
-			  struct trace_buffer *buffer, int nr_pages)
+			  struct trace_buffer *buffer, int nr_pages,
+			  unsigned long *subbuf_mask)
 {
 	int subbuf_size = PAGE_SIZE;
 	struct buffer_data_page *subbuf;
@@ -1680,6 +1681,9 @@ static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
 	unsigned long buffers_end;
 	int i;
 
+	if (!subbuf_mask)
+		return false;
+
 	/* Check the meta magic and meta struct size */
 	if (meta->magic != RING_BUFFER_META_MAGIC ||
 	    meta->struct_size != sizeof(*meta)) {
@@ -1712,6 +1716,8 @@ static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
 
 	subbuf = rb_subbufs_from_meta(meta);
 
+	bitmap_clear(subbuf_mask, 0, meta->nr_subbufs);
+
 	/* Is the meta buffers and the subbufs themselves have correct data? */
 	for (i = 0; i < meta->nr_subbufs; i++) {
 		if (meta->buffers[i] < 0 ||
@@ -1725,6 +1731,12 @@ static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
 			return false;
 		}
 
+		if (test_bit(meta->buffers[i], subbuf_mask)) {
+			pr_info("Ring buffer boot meta [%d] array has duplicates\n", cpu);
+			return false;
+		}
+
+		set_bit(meta->buffers[i], subbuf_mask);
 		subbuf = (void *)subbuf + subbuf_size;
 	}
 
@@ -1889,17 +1901,22 @@ static void rb_meta_init_text_addr(struct ring_buffer_meta *meta)
 static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 {
 	struct ring_buffer_meta *meta;
+	unsigned long *subbuf_mask;
 	unsigned long delta;
 	void *subbuf;
 	int cpu;
 	int i;
 
+	/* Create a mask to test the subbuf array */
+	subbuf_mask = bitmap_alloc(nr_pages + 1, GFP_KERNEL);
+	/* If subbuf_mask fails to allocate, then rb_meta_valid() will return false */
+
 	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
 		void *next_meta;
 
 		meta = rb_range_meta(buffer, nr_pages, cpu);
 
-		if (rb_meta_valid(meta, cpu, buffer, nr_pages)) {
+		if (rb_meta_valid(meta, cpu, buffer, nr_pages, subbuf_mask)) {
 			/* Make the mappings match the current address */
 			subbuf = rb_subbufs_from_meta(meta);
 			delta = (unsigned long)subbuf - meta->first_buffer;
@@ -1943,6 +1960,7 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 			subbuf += meta->subbuf_size;
 		}
 	}
+	bitmap_free(subbuf_mask);
 }
 
 static void *rbm_start(struct seq_file *m, loff_t *pos)
-- 
2.47.2



