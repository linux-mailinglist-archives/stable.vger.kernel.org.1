Return-Path: <stable+bounces-147140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAB6AC5662
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E87DD17F379
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CDD1E89C;
	Tue, 27 May 2025 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="asLAXIp8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7302B19E967;
	Tue, 27 May 2025 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366415; cv=none; b=MGV7vqGnpZJNO6UKrzeYyHRzjvfqTRtDkgRfNXHhA2xnaH7o76N6iUF9RngkXJninLnGb+QAfyJcCs9p9Mzza7k5umkUvW5JbjJNKyHe0/DmxM4eNrUK7+VxLWqhyA9JtLJdClhe9j9SnWNUqkogWWBrK7cDeXH0pDcVEeLfoog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366415; c=relaxed/simple;
	bh=h+ibSuJ47FT8fQy4UVSRp2+vFqpKAhyjWsYtmYiJiio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdSOnPKgrUTVQNbW9p59MTpSviJsNPz2sNmghtF9+ozM9tchhnNHwlAdNgRX2RWccokPh371Kz50z4pvhsuWoBdgcuhQBDr3y2fw5QA0gu3p7YuefjHxJnt2MxjevIOfEVDRp0OHdOTn5PNE/ppEetvJGr2q12/qtmkCmy8Ttm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=asLAXIp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64309C4CEE9;
	Tue, 27 May 2025 17:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748366413;
	bh=h+ibSuJ47FT8fQy4UVSRp2+vFqpKAhyjWsYtmYiJiio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=asLAXIp87OL+d1Fm7vZNliBLYraTbHS1250lXK0R39zGwctSnrPfslUpKRBAw+f/c
	 /3gz2F31bScsLIGQOMKyLF/An5J/6t9O4OzKUaTdoc76yXqSO50emnGnJOTudE7IAU
	 /CUk4ss+8tnkW2o95a2/UBaGoqu5sgPaH6KxTntA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 060/783] ring-buffer: Use kaslr address instead of text delta
Date: Tue, 27 May 2025 18:17:37 +0200
Message-ID: <20250527162515.572573604@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit bcba8d4dbe6880ce9883409df486de35d3946704 ]

Instead of saving off the text and data pointers and using them to compare
with the current boot's text and data pointers, just save off the KASLR
offset. Then that can be used to figure out how to read the previous boots
buffer.

The last_boot_info will now show this offset, but only if it is for a
previous boot:

  ~# cat instances/boot_mapped/last_boot_info
  39000000	[kernel]

  ~# echo function > instances/boot_mapped/current_tracer
  ~# cat instances/boot_mapped/last_boot_info
  # Current

If the KASLR offset saved is for the current boot, the last_boot_info will
show the value of "current".

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/20250305164608.274956504@goodmis.org
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ring_buffer.h |  3 +--
 kernel/trace/ring_buffer.c  | 31 ++++++++++++-------------------
 kernel/trace/trace.c        | 30 +++++++++++++++++++++---------
 kernel/trace/trace.h        |  9 +++++----
 4 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 17fbb78552952..8de035f4f0d9a 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -94,8 +94,7 @@ struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flag
 					       unsigned long range_size,
 					       struct lock_class_key *key);
 
-bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, long *text,
-				 long *data);
+bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, unsigned long *kaslr_addr);
 
 /*
  * Because the ring buffer is generic, if other users of the ring buffer get
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f76bee67a792c..9b1db04c74e25 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -31,6 +31,7 @@
 
 #include <asm/local64.h>
 #include <asm/local.h>
+#include <asm/setup.h>
 
 #include "trace.h"
 
@@ -49,8 +50,7 @@ static void update_pages_handler(struct work_struct *work);
 struct ring_buffer_meta {
 	int		magic;
 	int		struct_size;
-	unsigned long	text_addr;
-	unsigned long	data_addr;
+	unsigned long	kaslr_addr;
 	unsigned long	first_buffer;
 	unsigned long	head_buffer;
 	unsigned long	commit_buffer;
@@ -550,8 +550,7 @@ struct trace_buffer {
 	unsigned long			range_addr_start;
 	unsigned long			range_addr_end;
 
-	long				last_text_delta;
-	long				last_data_delta;
+	unsigned long			kaslr_addr;
 
 	unsigned int			subbuf_size;
 	unsigned int			subbuf_order;
@@ -1893,16 +1892,13 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	}
 }
 
-/* Used to calculate data delta */
-static char rb_data_ptr[] = "";
-
-#define THIS_TEXT_PTR		((unsigned long)rb_meta_init_text_addr)
-#define THIS_DATA_PTR		((unsigned long)rb_data_ptr)
-
 static void rb_meta_init_text_addr(struct ring_buffer_meta *meta)
 {
-	meta->text_addr = THIS_TEXT_PTR;
-	meta->data_addr = THIS_DATA_PTR;
+#ifdef CONFIG_RANDOMIZE_BASE
+	meta->kaslr_addr = kaslr_offset();
+#else
+	meta->kaslr_addr = 0;
+#endif
 }
 
 static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
@@ -1930,8 +1926,7 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 			meta->first_buffer += delta;
 			meta->head_buffer += delta;
 			meta->commit_buffer += delta;
-			buffer->last_text_delta = THIS_TEXT_PTR - meta->text_addr;
-			buffer->last_data_delta = THIS_DATA_PTR - meta->data_addr;
+			buffer->kaslr_addr = meta->kaslr_addr;
 			continue;
 		}
 
@@ -2484,17 +2479,15 @@ struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flag
  *
  * Returns: The true if the delta is non zero
  */
-bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, long *text,
-				 long *data)
+bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, unsigned long *kaslr_addr)
 {
 	if (!buffer)
 		return false;
 
-	if (!buffer->last_text_delta)
+	if (!buffer->kaslr_addr)
 		return false;
 
-	*text = buffer->last_text_delta;
-	*data = buffer->last_data_delta;
+	*kaslr_addr = buffer->kaslr_addr;
 
 	return true;
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 814626bb410b2..c3f1365ec9609 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -50,7 +50,7 @@
 #include <linux/irq_work.h>
 #include <linux/workqueue.h>
 
-#include <asm/setup.h> /* COMMAND_LINE_SIZE */
+#include <asm/setup.h> /* COMMAND_LINE_SIZE and kaslr_offset() */
 
 #include "trace.h"
 #include "trace_output.h"
@@ -4193,7 +4193,7 @@ static enum print_line_t print_trace_fmt(struct trace_iterator *iter)
 		 * safe to use if the array has delta offsets
 		 * Force printing via the fields.
 		 */
-		if ((tr->text_delta || tr->data_delta) &&
+		if ((tr->text_delta) &&
 		    event->type > __TRACE_LAST_TYPE)
 			return print_event_fields(iter, event);
 
@@ -5990,7 +5990,7 @@ ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 
 static void update_last_data(struct trace_array *tr)
 {
-	if (!tr->text_delta && !tr->data_delta)
+	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
 		return;
 
 	/*
@@ -6003,7 +6003,8 @@ static void update_last_data(struct trace_array *tr)
 
 	/* Using current data now */
 	tr->text_delta = 0;
-	tr->data_delta = 0;
+
+	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
 }
 
 /**
@@ -6822,8 +6823,17 @@ tracing_last_boot_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t
 
 	seq_buf_init(&seq, buf, 64);
 
-	seq_buf_printf(&seq, "text delta:\t%ld\n", tr->text_delta);
-	seq_buf_printf(&seq, "data delta:\t%ld\n", tr->data_delta);
+	/*
+	 * Do not leak KASLR address. This only shows the KASLR address of
+	 * the last boot. When the ring buffer is started, the LAST_BOOT
+	 * flag gets cleared, and this should only report "current".
+	 * Otherwise it shows the KASLR address from the previous boot which
+	 * should not be the same as the current boot.
+	 */
+	if (tr->flags & TRACE_ARRAY_FL_LAST_BOOT)
+		seq_buf_printf(&seq, "%lx\t[kernel]\n", tr->kaslr_addr);
+	else
+		seq_buf_puts(&seq, "# Current\n");
 
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, seq_buf_used(&seq));
 }
@@ -9211,8 +9221,10 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
 						      tr->range_addr_start,
 						      tr->range_addr_size);
 
-		ring_buffer_last_boot_delta(buf->buffer,
-					    &tr->text_delta, &tr->data_delta);
+#ifdef CONFIG_RANDOMIZE_BASE
+		if (ring_buffer_last_boot_delta(buf->buffer, &tr->kaslr_addr))
+			tr->text_delta = kaslr_offset() - tr->kaslr_addr;
+#endif
 		/*
 		 * This is basically the same as a mapped buffer,
 		 * with the same restrictions.
@@ -10470,7 +10482,7 @@ __init static void enable_instances(void)
 		 * to it.
 		 */
 		if (start) {
-			tr->flags |= TRACE_ARRAY_FL_BOOT;
+			tr->flags |= TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT;
 			tr->ref++;
 		}
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 9c21ba45b7af6..abe8169c3e879 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -348,8 +348,8 @@ struct trace_array {
 	unsigned int		mapped;
 	unsigned long		range_addr_start;
 	unsigned long		range_addr_size;
+	unsigned long		kaslr_addr;
 	long			text_delta;
-	long			data_delta;
 
 	struct trace_pid_list	__rcu *filtered_pids;
 	struct trace_pid_list	__rcu *filtered_no_pids;
@@ -433,9 +433,10 @@ struct trace_array {
 };
 
 enum {
-	TRACE_ARRAY_FL_GLOBAL	= BIT(0),
-	TRACE_ARRAY_FL_BOOT	= BIT(1),
-	TRACE_ARRAY_FL_MOD_INIT	= BIT(2),
+	TRACE_ARRAY_FL_GLOBAL		= BIT(0),
+	TRACE_ARRAY_FL_BOOT		= BIT(1),
+	TRACE_ARRAY_FL_LAST_BOOT	= BIT(2),
+	TRACE_ARRAY_FL_MOD_INIT		= BIT(3),
 };
 
 #ifdef CONFIG_MODULES
-- 
2.39.5




