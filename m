Return-Path: <stable+bounces-9027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA55820893
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 22:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A94B1C21A2B
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 21:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE619C2FD;
	Sat, 30 Dec 2023 21:51:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B277ACA49
	for <stable@vger.kernel.org>; Sat, 30 Dec 2023 21:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63282C433C8;
	Sat, 30 Dec 2023 21:51:02 +0000 (UTC)
Date: Sat, 30 Dec 2023 16:51:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: <gregkh@linuxfoundation.org>
Cc: mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, torvalds@linux-foundation.org,
 <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] ring-buffer: Fix slowpath of interrupted
 event" failed to apply to 6.1-stable tree
Message-ID: <20231230165156.4fd2eef6@gandalf.local.home>
In-Reply-To: <2023123047-tuesday-whooping-6ae3@gregkh>
References: <2023123047-tuesday-whooping-6ae3@gregkh>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Dec 2023 11:00:47 +0000
<gregkh@linuxfoundation.org> wrote:

> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x b803d7c664d55705831729d2f2e29c874bcd62ea
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023123047-tuesday-whooping-6ae3@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> Possible dependencies:
> 
> b803d7c664d5 ("ring-buffer: Fix slowpath of interrupted event")
> 0aa0e5289cfe ("ring-buffer: Have rb_time_cmpxchg() set the msb counter too")
> fff88fa0fbc7 ("ring-buffer: Fix a race in rb_time_cmpxchg() for 32 bit archs")
> 00a8478f8f5c ("ring_buffer: Use try_cmpxchg instead of cmpxchg")
> bc92b9562abc ("ring_buffer: Change some static functions to bool")
> 88ca6a71dcab ("ring-buffer: Handle resize in early boot up")
> 
> thanks,

Below is the patch for 6.1 of this change, and it depends on:

20231230164736.3b8c86c4@gandalf.local.home

-- Steve

---
 kernel/trace/ring_buffer.c |   81 +++++++++++++--------------------------------
 1 file changed, 24 insertions(+), 57 deletions(-)

Index: test-linux.git/kernel/trace/ring_buffer.c
===================================================================
--- test-linux.git.orig/kernel/trace/ring_buffer.c	2023-12-30 16:10:20.179497134 -0500
+++ test-linux.git/kernel/trace/ring_buffer.c	2023-12-30 16:10:20.175497066 -0500
@@ -705,48 +705,6 @@ rb_time_read_cmpxchg(local_t *l, unsigne
 	return ret == expect;
 }
 
-static int rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
-{
-	unsigned long cnt, top, bottom, msb;
-	unsigned long cnt2, top2, bottom2, msb2;
-	u64 val;
-
-	/* Any interruptions in this function should cause a failure */
-	cnt = local_read(&t->cnt);
-
-	/* The cmpxchg always fails if it interrupted an update */
-	 if (!__rb_time_read(t, &val, &cnt2))
-		 return false;
-
-	 if (val != expect)
-		 return false;
-
-	 if ((cnt & 3) != cnt2)
-		 return false;
-
-	 cnt2 = cnt + 1;
-
-	 rb_time_split(val, &top, &bottom, &msb);
-	 msb = rb_time_val_cnt(msb, cnt);
-	 top = rb_time_val_cnt(top, cnt);
-	 bottom = rb_time_val_cnt(bottom, cnt);
-
-	 rb_time_split(set, &top2, &bottom2, &msb2);
-	 msb2 = rb_time_val_cnt(msb2, cnt);
-	 top2 = rb_time_val_cnt(top2, cnt2);
-	 bottom2 = rb_time_val_cnt(bottom2, cnt2);
-
-	if (!rb_time_read_cmpxchg(&t->cnt, cnt, cnt2))
-		return false;
-	if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
-		return false;
-	if (!rb_time_read_cmpxchg(&t->top, top, top2))
-		return false;
-	if (!rb_time_read_cmpxchg(&t->bottom, bottom, bottom2))
-		return false;
-	return true;
-}
-
 #else /* 64 bits */
 
 /* local64_t always succeeds */
@@ -760,13 +718,6 @@ static void rb_time_set(rb_time_t *t, u6
 {
 	local64_set(&t->time, val);
 }
-
-static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
-{
-	u64 val;
-	val = local64_cmpxchg(&t->time, expect, set);
-	return val == expect;
-}
 #endif
 
 /*
@@ -3607,20 +3558,36 @@ __rb_reserve_next(struct ring_buffer_per
 	} else {
 		u64 ts;
 		/* SLOW PATH - Interrupted between A and C */
-		a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
-		/* Was interrupted before here, write_stamp must be valid */
+
+		/* Save the old before_stamp */
+		a_ok = rb_time_read(&cpu_buffer->before_stamp, &info->before);
 		RB_WARN_ON(cpu_buffer, !a_ok);
+
+		/*
+		 * Read a new timestamp and update the before_stamp to make
+		 * the next event after this one force using an absolute
+		 * timestamp. This is in case an interrupt were to come in
+		 * between E and F.
+		 */
 		ts = rb_time_stamp(cpu_buffer->buffer);
+		rb_time_set(&cpu_buffer->before_stamp, ts);
+
 		barrier();
- /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
-		    info->after < ts &&
-		    rb_time_cmpxchg(&cpu_buffer->write_stamp,
-				    info->after, ts)) {
-			/* Nothing came after this event between C and E */
+ /*E*/		a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
+		/* Was interrupted before here, write_stamp must be valid */
+		RB_WARN_ON(cpu_buffer, !a_ok);
+		barrier();
+ /*F*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
+		    info->after == info->before && info->after < ts) {
+			/*
+			 * Nothing came after this event between C and F, it is
+			 * safe to use info->after for the delta as it
+			 * matched info->before and is still valid.
+			 */
 			info->delta = ts - info->after;
 		} else {
 			/*
-			 * Interrupted between C and E:
+			 * Interrupted between C and F:
 			 * Lost the previous events time stamp. Just set the
 			 * delta to zero, and this will be the same time as
 			 * the event this event interrupted. And the events that

