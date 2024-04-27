Return-Path: <stable+bounces-41558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C518B46A5
	for <lists+stable@lfdr.de>; Sat, 27 Apr 2024 16:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 473F5B20D2C
	for <lists+stable@lfdr.de>; Sat, 27 Apr 2024 14:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01CB370;
	Sat, 27 Apr 2024 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KyxR+Wo2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD7C631
	for <stable@vger.kernel.org>; Sat, 27 Apr 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714228270; cv=none; b=MXYDdUIxcG3G+cUQCi9A9xeBtA5SCZ0SEMM+17vpdifunIdh74fA3Dec84KYEIWhgxo2+D/zMC7wtvIXPt2Jz4kO77nKCseQ390ATuSZqTvkx2vyDYpFvt/W2JiRzvk8b2sxfshHGTt6aSu8Pct8c/4JuwG/RXY0ggYkyYwe1xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714228270; c=relaxed/simple;
	bh=SCurlMMgRDDjUISVWyEsW0kpLVUvc0o3MqZJW5pkhaU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Pa6GsXCGRYGVn9bX3+OSk+3Y9g0FdOfP5V389kCqW19dAga6gGgtqdnQ02CJLEcUxjWu1qR+XaTcsSIvJvcCxwvgds3UISIR9JoSUnDda1L1rWfzNVVJeHhtivKe8MY17npLGMvLhtw6Zl41E/fxvALgO0dwIEXRKRi/YbORvXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KyxR+Wo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3414BC113CE;
	Sat, 27 Apr 2024 14:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714228269;
	bh=SCurlMMgRDDjUISVWyEsW0kpLVUvc0o3MqZJW5pkhaU=;
	h=Subject:To:Cc:From:Date:From;
	b=KyxR+Wo2q6qNw1ea7o7nmdqWyVWHKVOA23Qdl5EhlOEwgJg+n6Pg9uh6h4m4hEIfb
	 TKS4kEXYVQxKYTIYXcPvIrv38S6Z7AfB9cfwy1zv4ixF+Pphf/OjyoVRObV2KAm/Wb
	 oZVy2HxKB/vySeY9VDSTFw5n0ewe2gj1PSt+0DTA=
Subject: FAILED: patch "[PATCH] ring-buffer: Only update pages_touched when a new page is" failed to apply to 5.4-stable tree
To: rostedt@goodmis.org,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Apr 2024 16:31:06 +0200
Message-ID: <2024042706--0fec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x ffe3986fece696cf65e0ef99e74c75f848be8e30
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042706--0fec@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

ffe3986fece6 ("ring-buffer: Only update pages_touched when a new page is touched")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ffe3986fece696cf65e0ef99e74c75f848be8e30 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Tue, 9 Apr 2024 15:13:09 -0400
Subject: [PATCH] ring-buffer: Only update pages_touched when a new page is
 touched

The "buffer_percent" logic that is used by the ring buffer splice code to
only wake up the tasks when there's no data after the buffer is filled to
the percentage of the "buffer_percent" file is dependent on three
variables that determine the amount of data that is in the ring buffer:

 1) pages_read - incremented whenever a new sub-buffer is consumed
 2) pages_lost - incremented every time a writer overwrites a sub-buffer
 3) pages_touched - incremented when a write goes to a new sub-buffer

The percentage is the calculation of:

  (pages_touched - (pages_lost + pages_read)) / nr_pages

Basically, the amount of data is the total number of sub-bufs that have been
touched, minus the number of sub-bufs lost and sub-bufs consumed. This is
divided by the total count to give the buffer percentage. When the
percentage is greater than the value in the "buffer_percent" file, it
wakes up splice readers waiting for that amount.

It was observed that over time, the amount read from the splice was
constantly decreasing the longer the trace was running. That is, if one
asked for 60%, it would read over 60% when it first starts tracing, but
then it would be woken up at under 60% and would slowly decrease the
amount of data read after being woken up, where the amount becomes much
less than the buffer percent.

This was due to an accounting of the pages_touched incrementation. This
value is incremented whenever a writer transfers to a new sub-buffer. But
the place where it was incremented was incorrect. If a writer overflowed
the current sub-buffer it would go to the next one. If it gets preempted
by an interrupt at that time, and the interrupt performs a trace, it too
will end up going to the next sub-buffer. But only one should increment
the counter. Unfortunately, that was not the case.

Change the cmpxchg() that does the real switch of the tail-page into a
try_cmpxchg(), and on success, perform the increment of pages_touched. This
will only increment the counter once for when the writer moves to a new
sub-buffer, and not when there's a race and is incremented for when a
writer and its preempting writer both move to the same new sub-buffer.

Link: https://lore.kernel.org/linux-trace-kernel/20240409151309.0d0e5056@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 2c2b0a78b3739 ("ring-buffer: Add percentage of ring buffer full to wake up reader")
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 25476ead681b..6511dc3a00da 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1393,7 +1393,6 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
 	old_write = local_add_return(RB_WRITE_INTCNT, &next_page->write);
 	old_entries = local_add_return(RB_WRITE_INTCNT, &next_page->entries);
 
-	local_inc(&cpu_buffer->pages_touched);
 	/*
 	 * Just make sure we have seen our old_write and synchronize
 	 * with any interrupts that come in.
@@ -1430,8 +1429,9 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
 		 */
 		local_set(&next_page->page->commit, 0);
 
-		/* Again, either we update tail_page or an interrupt does */
-		(void)cmpxchg(&cpu_buffer->tail_page, tail_page, next_page);
+		/* Either we update tail_page or an interrupt does */
+		if (try_cmpxchg(&cpu_buffer->tail_page, &tail_page, next_page))
+			local_inc(&cpu_buffer->pages_touched);
 	}
 }
 


