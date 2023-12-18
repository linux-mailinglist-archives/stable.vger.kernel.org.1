Return-Path: <stable+bounces-6965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F01816782
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 08:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29E9282C2A
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 07:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A01A8481;
	Mon, 18 Dec 2023 07:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g4sWMTGS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05897DF6F
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719FEC433C8;
	Mon, 18 Dec 2023 07:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702885108;
	bh=Mhx6LSrXIZK2VaDq0BVuqjoLWVfqbXJ9pi9pGnJtjVk=;
	h=Subject:To:Cc:From:Date:From;
	b=g4sWMTGSXMgFkBEXGCEQlc9idCtBjQGsbwK2TR0gawfsE9Qy+a3g1nupLSfq0YyOf
	 Fw8lbVKN6TJMfKX4j6fQwsR+SO4d7KRE66oEIjet3H14FSEE3QfHbm7HVkcJDoGgwW
	 q93ozY45NWCrZR4TmMuPBzXcEplQPxVLdOIP6iIU=
Subject: FAILED: patch "[PATCH] ring-buffer: Do not try to put back write_stamp" failed to apply to 5.10-stable tree
To: rostedt@goodmis.org,joel@joelfernandes.org,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org,vdonnefort@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Dec 2023 08:38:26 +0100
Message-ID: <2023121825-overbuilt-uncivil-a968@gregkh>
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
git cherry-pick -x dd939425707898da992e59ab0fcfae4652546910
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121825-overbuilt-uncivil-a968@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

dd9394257078 ("ring-buffer: Do not try to put back write_stamp")
5b7be9c709e1 ("ring-buffer: Add test to validate the time stamp deltas")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dd939425707898da992e59ab0fcfae4652546910 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Thu, 14 Dec 2023 22:29:21 -0500
Subject: [PATCH] ring-buffer: Do not try to put back write_stamp

If an update to an event is interrupted by another event between the time
the initial event allocated its buffer and where it wrote to the
write_stamp, the code try to reset the write stamp back to the what it had
just overwritten. It knows that it was overwritten via checking the
before_stamp, and if it didn't match what it wrote to the before_stamp
before it allocated its space, it knows it was overwritten.

To put back the write_stamp, it uses the before_stamp it read. The problem
here is that by writing the before_stamp to the write_stamp it makes the
two equal again, which means that the write_stamp can be considered valid
as the last timestamp written to the ring buffer. But this is not
necessarily true. The event that interrupted the event could have been
interrupted in a way that it was interrupted as well, and can end up
leaving with an invalid write_stamp. But if this happens and returns to
this context that uses the before_stamp to update the write_stamp again,
it can possibly incorrectly make it valid, causing later events to have in
correct time stamps.

As it is OK to leave this function with an invalid write_stamp (one that
doesn't match the before_stamp), there's no reason to try to make it valid
again in this case. If this race happens, then just leave with the invalid
write_stamp and the next event to come along will just add a absolute
timestamp and validate everything again.

Bonus points: This gets rid of another cmpxchg64!

Link: https://lore.kernel.org/linux-trace-kernel/20231214222921.193037a7@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Vincent Donnefort <vdonnefort@google.com>
Fixes: a389d86f7fd09 ("ring-buffer: Have nested events still record running time stamp")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1d9caee7f542..2668dde23343 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3612,14 +3612,14 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	}
 
 	if (likely(tail == w)) {
-		u64 save_before;
-		bool s_ok;
-
 		/* Nothing interrupted us between A and C */
  /*D*/		rb_time_set(&cpu_buffer->write_stamp, info->ts);
-		barrier();
- /*E*/		s_ok = rb_time_read(&cpu_buffer->before_stamp, &save_before);
-		RB_WARN_ON(cpu_buffer, !s_ok);
+		/*
+		 * If something came in between C and D, the write stamp
+		 * may now not be in sync. But that's fine as the before_stamp
+		 * will be different and then next event will just be forced
+		 * to use an absolute timestamp.
+		 */
 		if (likely(!(info->add_timestamp &
 			     (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE))))
 			/* This did not interrupt any time update */
@@ -3627,24 +3627,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		else
 			/* Just use full timestamp for interrupting event */
 			info->delta = info->ts;
-		barrier();
 		check_buffer(cpu_buffer, info, tail);
-		if (unlikely(info->ts != save_before)) {
-			/* SLOW PATH - Interrupted between C and E */
-
-			a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
-			RB_WARN_ON(cpu_buffer, !a_ok);
-
-			/* Write stamp must only go forward */
-			if (save_before > info->after) {
-				/*
-				 * We do not care about the result, only that
-				 * it gets updated atomically.
-				 */
-				(void)rb_time_cmpxchg(&cpu_buffer->write_stamp,
-						      info->after, save_before);
-			}
-		}
 	} else {
 		u64 ts;
 		/* SLOW PATH - Interrupted between A and C */


