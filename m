Return-Path: <stable+bounces-6964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E938C81677C
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 08:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F11B1F2241F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 07:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449D5846E;
	Mon, 18 Dec 2023 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kAXwx1ZB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8EC79EE
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8625EC433C8;
	Mon, 18 Dec 2023 07:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702885042;
	bh=MMDN/nOMHf/iVphToNhDFtNVpMgi1N/rbsR2r9QAt7U=;
	h=Subject:To:Cc:From:Date:From;
	b=kAXwx1ZBBrqr00ucpCsdIVdJmrWgJOXjMmuMEpbvbB+893ngeSoFI67NxB+qJucIB
	 pWxM3MKCIwwU4QA9m6l3S2gPlrmfKM2w31woOPOvD2cC/ctlU3PUrO6h90lvCjR66J
	 2Bd0ojrPEhziiXZJW/h6PpMGYOmU1mq+DQ1LA16g=
Subject: FAILED: patch "[PATCH] ring-buffer: Do not update before stamp when switching" failed to apply to 5.10-stable tree
To: rostedt@goodmis.org,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Dec 2023 08:37:20 +0100
Message-ID: <2023121820-unpicked-galore-00e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9e45e39dc249c970d99d2681f6bcb55736fd725c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121820-unpicked-galore-00e7@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

9e45e39dc249 ("ring-buffer: Do not update before stamp when switching sub-buffers")
09c0796adf0c ("Merge tag 'trace-v5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9e45e39dc249c970d99d2681f6bcb55736fd725c Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Mon, 11 Dec 2023 11:44:20 -0500
Subject: [PATCH] ring-buffer: Do not update before stamp when switching
 sub-buffers

The ring buffer timestamps are synchronized by two timestamp placeholders.
One is the "before_stamp" and the other is the "write_stamp" (sometimes
referred to as the "after stamp" but only in the comments. These two
stamps are key to knowing how to handle nested events coming in with a
lockless system.

When moving across sub-buffers, the before stamp is updated but the write
stamp is not. There's an effort to put back the before stamp to something
that seems logical in case there's nested events. But as the current event
is about to cross sub-buffers, and so will any new nested event that happens,
updating the before stamp is useless, and could even introduce new race
conditions.

The first event on a sub-buffer simply uses the sub-buffer's timestamp
and keeps a "delta" of zero. The "before_stamp" and "write_stamp" are not
used in the algorithm in this case. There's no reason to try to fix the
before_stamp when this happens.

As a bonus, it removes a cmpxchg() when crossing sub-buffers!

Link: https://lore.kernel.org/linux-trace-kernel/20231211114420.36dde01b@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: a389d86f7fd09 ("ring-buffer: Have nested events still record running time stamp")
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index dcd47895b424..c7abcc215fe2 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3607,14 +3607,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 
 	/* See if we shot pass the end of this buffer page */
 	if (unlikely(write > BUF_PAGE_SIZE)) {
-		/* before and after may now different, fix it up*/
-		b_ok = rb_time_read(&cpu_buffer->before_stamp, &info->before);
-		a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
-		if (a_ok && b_ok && info->before != info->after)
-			(void)rb_time_cmpxchg(&cpu_buffer->before_stamp,
-					      info->before, info->after);
-		if (a_ok && b_ok)
-			check_buffer(cpu_buffer, info, CHECK_FULL_PAGE);
+		check_buffer(cpu_buffer, info, CHECK_FULL_PAGE);
 		return rb_move_tail(cpu_buffer, tail, info);
 	}
 


