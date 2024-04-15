Return-Path: <stable+bounces-39895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 636E18A5540
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4C2FB247C3
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4859878C9E;
	Mon, 15 Apr 2024 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VWnEjBPr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0624A2119;
	Mon, 15 Apr 2024 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192140; cv=none; b=myNo/xTMalmYi5X4Acop+GaI61k0jzmFxGGbBDu209cNvl4+xavTyA5OpzxnDf63W5CFvQBUxVCgNASsZW58WQss+WOeYlQnRC/6JImfDh72u0HEXUe7iqkbJQSGzNyfajfbDnSWS6LdVgdMuspb+5SP9J2tu8STRBScYxfhIkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192140; c=relaxed/simple;
	bh=Hqch7t3AGWNOijQmwKHwgy+EtlDb+f4mOEwFAzQ/T1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCjx1ZA8ik5GI29dcXcSYMQNkGJNdALwYV45mozIWSkQHQUvxnNgYxlTT5hQtnHy9jMF3Z2YjGgA+syDW7V1sLCBKLzN5HEuArldU1emb18KfKi9v92NSwXiLpCt2Jg6kKHRI057mIfZ5OhmNfBMaIl780EZEkkG70a5sNXTgxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VWnEjBPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84390C113CC;
	Mon, 15 Apr 2024 14:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713192139;
	bh=Hqch7t3AGWNOijQmwKHwgy+EtlDb+f4mOEwFAzQ/T1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VWnEjBPrIajagm2kd1vStXf1kBGXhUhLRQZ41uTYX5x7BV8ogk06BX1gVHu7FmKnH
	 a6KLF+1n62dn7fwHSp87dySH502fJ7HXMRZq5jtvheE2VIDg0p5CRAejVfUqwylVZe
	 d0kYL5ANbPJImmvtMSmLw56Ed2J/iLHO3sUaqLwg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 5.15 02/45] ring-buffer: Only update pages_touched when a new page is touched
Date: Mon, 15 Apr 2024 16:21:09 +0200
Message-ID: <20240415141942.313051761@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141942.235939111@linuxfoundation.org>
References: <20240415141942.235939111@linuxfoundation.org>
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

commit ffe3986fece696cf65e0ef99e74c75f848be8e30 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/ring_buffer.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1509,7 +1509,6 @@ static void rb_tail_page_update(struct r
 	old_write = local_add_return(RB_WRITE_INTCNT, &next_page->write);
 	old_entries = local_add_return(RB_WRITE_INTCNT, &next_page->entries);
 
-	local_inc(&cpu_buffer->pages_touched);
 	/*
 	 * Just make sure we have seen our old_write and synchronize
 	 * with any interrupts that come in.
@@ -1546,8 +1545,9 @@ static void rb_tail_page_update(struct r
 		 */
 		local_set(&next_page->page->commit, 0);
 
-		/* Again, either we update tail_page or an interrupt does */
-		(void)cmpxchg(&cpu_buffer->tail_page, tail_page, next_page);
+		/* Either we update tail_page or an interrupt does */
+		if (try_cmpxchg(&cpu_buffer->tail_page, &tail_page, next_page))
+			local_inc(&cpu_buffer->pages_touched);
 	}
 }
 



