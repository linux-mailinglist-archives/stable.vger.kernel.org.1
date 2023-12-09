Return-Path: <stable+bounces-5120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BD980B427
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 13:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81428B20AEC
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 12:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4851114282;
	Sat,  9 Dec 2023 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="evwZDbqp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B2113FE5
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 12:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFFAC433C8;
	Sat,  9 Dec 2023 12:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702124704;
	bh=d03UJdZaeQ8gjZAYZ1qpZKOn99QiFzkGcCSZgrOuluc=;
	h=Subject:To:Cc:From:Date:From;
	b=evwZDbqpsMTpjVysPEOccHdYVpjLIKHm2asweXNvKTd2tFdU7ApBLzqmxrmhz9Jvn
	 kE5coI/ILNr/MNBZY1aRt9yfJo0Ph3DVUmW8KWc0qZd+xPwEM3GoAFmUHbsRHal8ki
	 hyqBlmgtiYYcuuUIQgR7PF42e1Zgve8Ljhhij5Yg=
Subject: FAILED: patch "[PATCH] ring-buffer: Force absolute timestamp on discard of event" failed to apply to 6.1-stable tree
To: rostedt@goodmis.org,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Dec 2023 13:24:38 +0100
Message-ID: <2023120938-unclamped-fleshy-688e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b2dd797543cfa6580eac8408dd67fa02164d9e56
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120938-unclamped-fleshy-688e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

b2dd797543cf ("ring-buffer: Force absolute timestamp on discard of event")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b2dd797543cfa6580eac8408dd67fa02164d9e56 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Wed, 6 Dec 2023 10:02:44 -0500
Subject: [PATCH] ring-buffer: Force absolute timestamp on discard of event

There's a race where if an event is discarded from the ring buffer and an
interrupt were to happen at that time and insert an event, the time stamp
is still used from the discarded event as an offset. This can screw up the
timings.

If the event is going to be discarded, set the "before_stamp" to zero.
When a new event comes in, it compares the "before_stamp" with the
"write_stamp" and if they are not equal, it will insert an absolute
timestamp. This will prevent the timings from getting out of sync due to
the discarded event.

Link: https://lore.kernel.org/linux-trace-kernel/20231206100244.5130f9b3@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 6f6be606e763f ("ring-buffer: Force before_stamp and write_stamp to be different on discard")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 43cc47d7faaf..a6da2d765c78 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3030,22 +3030,19 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 			local_read(&bpage->write) & ~RB_WRITE_MASK;
 		unsigned long event_length = rb_event_length(event);
 
+		/*
+		 * For the before_stamp to be different than the write_stamp
+		 * to make sure that the next event adds an absolute
+		 * value and does not rely on the saved write stamp, which
+		 * is now going to be bogus.
+		 */
+		rb_time_set(&cpu_buffer->before_stamp, 0);
+
 		/* Something came in, can't discard */
 		if (!rb_time_cmpxchg(&cpu_buffer->write_stamp,
 				       write_stamp, write_stamp - delta))
 			return false;
 
-		/*
-		 * It's possible that the event time delta is zero
-		 * (has the same time stamp as the previous event)
-		 * in which case write_stamp and before_stamp could
-		 * be the same. In such a case, force before_stamp
-		 * to be different than write_stamp. It doesn't
-		 * matter what it is, as long as its different.
-		 */
-		if (!delta)
-			rb_time_set(&cpu_buffer->before_stamp, 0);
-
 		/*
 		 * If an event were to come in now, it would see that the
 		 * write_stamp and the before_stamp are different, and assume


