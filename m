Return-Path: <stable+bounces-9469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF514823284
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA3E281EE3
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978901C2AF;
	Wed,  3 Jan 2024 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mCtaqqZ7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8001C2A8;
	Wed,  3 Jan 2024 17:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8645C433C8;
	Wed,  3 Jan 2024 17:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301684;
	bh=omO9YTWPlyf7Ih5IRBzUfiJDc73eXD9arv8aJeZixq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mCtaqqZ731+BBgeLZJSvlphdfjxFfyNU+x/VAAOhLaOePq37tfHSh3k2IWuR7TPEX
	 c9IpG5pqoH05KpniK3aE1cz3ngHwkC8AtFZBh4kUGhtpcSVEY2JAiFMdsvSemwHDqW
	 f5u99+s12lDt4odXMbaUQMa86YbXVscxB3rrYBdw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 5.15 89/95] ring-buffer: Remove useless update to write_stamp in rb_try_to_discard()
Date: Wed,  3 Jan 2024 17:55:37 +0100
Message-ID: <20240103164907.409614313@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164853.921194838@linuxfoundation.org>
References: <20240103164853.921194838@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

commit 083e9f65bd215582bf8f6a920db729fadf16704f upstream.

When filtering is enabled, a temporary buffer is created to place the
content of the trace event output so that the filter logic can decide
from the trace event output if the trace event should be filtered out or
not. If it is to be filtered out, the content in the temporary buffer is
simply discarded, otherwise it is written into the trace buffer.

But if an interrupt were to come in while a previous event was using that
temporary buffer, the event written by the interrupt would actually go
into the ring buffer itself to prevent corrupting the data on the
temporary buffer. If the event is to be filtered out, the event in the
ring buffer is discarded, or if it fails to discard because another event
were to have already come in, it is turned into padding.

The update to the write_stamp in the rb_try_to_discard() happens after a
fix was made to force the next event after the discard to use an absolute
timestamp by setting the before_stamp to zero so it does not match the
write_stamp (which causes an event to use the absolute timestamp).

But there's an effort in rb_try_to_discard() to put back the write_stamp
to what it was before the event was added. But this is useless and
wasteful because nothing is going to be using that write_stamp for
calculations as it still will not match the before_stamp.

Remove this useless update, and in doing so, we remove another
cmpxchg64()!

Also update the comments to reflect this change as well as remove some
extra white space in another comment.

Link: https://lore.kernel.org/linux-trace-kernel/20231215081810.1f4f38fe@rorschach.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Vincent Donnefort   <vdonnefort@google.com>
Fixes: b2dd797543cf ("ring-buffer: Force absolute timestamp on discard of event")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/ring_buffer.c |   47 ++++++++++-----------------------------------
 1 file changed, 11 insertions(+), 36 deletions(-)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2942,25 +2942,6 @@ static unsigned rb_calculate_event_lengt
 	return length;
 }
 
-static u64 rb_time_delta(struct ring_buffer_event *event)
-{
-	switch (event->type_len) {
-	case RINGBUF_TYPE_PADDING:
-		return 0;
-
-	case RINGBUF_TYPE_TIME_EXTEND:
-		return rb_event_time_stamp(event);
-
-	case RINGBUF_TYPE_TIME_STAMP:
-		return 0;
-
-	case RINGBUF_TYPE_DATA:
-		return event->time_delta;
-	default:
-		return 0;
-	}
-}
-
 static inline int
 rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 		  struct ring_buffer_event *event)
@@ -2969,8 +2950,6 @@ rb_try_to_discard(struct ring_buffer_per
 	struct buffer_page *bpage;
 	unsigned long index;
 	unsigned long addr;
-	u64 write_stamp;
-	u64 delta;
 
 	new_index = rb_event_index(event);
 	old_index = new_index + rb_event_ts_length(event);
@@ -2979,14 +2958,10 @@ rb_try_to_discard(struct ring_buffer_per
 
 	bpage = READ_ONCE(cpu_buffer->tail_page);
 
-	delta = rb_time_delta(event);
-
-	if (!rb_time_read(&cpu_buffer->write_stamp, &write_stamp))
-		return 0;
-
-	/* Make sure the write stamp is read before testing the location */
-	barrier();
-
+	/*
+	 * Make sure the tail_page is still the same and
+	 * the next write location is the end of this event
+	 */
 	if (bpage->page == (void *)addr && rb_page_write(bpage) == old_index) {
 		unsigned long write_mask =
 			local_read(&bpage->write) & ~RB_WRITE_MASK;
@@ -2997,20 +2972,20 @@ rb_try_to_discard(struct ring_buffer_per
 		 * to make sure that the next event adds an absolute
 		 * value and does not rely on the saved write stamp, which
 		 * is now going to be bogus.
+		 *
+		 * By setting the before_stamp to zero, the next event
+		 * is not going to use the write_stamp and will instead
+		 * create an absolute timestamp. This means there's no
+		 * reason to update the wirte_stamp!
 		 */
 		rb_time_set(&cpu_buffer->before_stamp, 0);
 
-		/* Something came in, can't discard */
-		if (!rb_time_cmpxchg(&cpu_buffer->write_stamp,
-				       write_stamp, write_stamp - delta))
-			return 0;
-
 		/*
 		 * If an event were to come in now, it would see that the
 		 * write_stamp and the before_stamp are different, and assume
 		 * that this event just added itself before updating
 		 * the write stamp. The interrupting event will fix the
-		 * write stamp for us, and use the before stamp as its delta.
+		 * write stamp for us, and use an absolute timestamp.
 		 */
 
 		/*
@@ -3449,7 +3424,7 @@ static void check_buffer(struct ring_buf
 		return;
 
 	/*
-	 * If this interrupted another event, 
+	 * If this interrupted another event,
 	 */
 	if (atomic_inc_return(this_cpu_ptr(&checking)) != 1)
 		goto out;



