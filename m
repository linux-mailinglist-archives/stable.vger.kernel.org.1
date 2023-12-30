Return-Path: <stable+bounces-9028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D5282089E
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 23:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91DFC1C2157A
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 22:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04FCC8F8;
	Sat, 30 Dec 2023 22:19:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BB1CA47
	for <stable@vger.kernel.org>; Sat, 30 Dec 2023 22:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAFAC433C8;
	Sat, 30 Dec 2023 22:19:25 +0000 (UTC)
Date: Sat, 30 Dec 2023 17:20:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: <gregkh@linuxfoundation.org>
Cc: mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, torvalds@linux-foundation.org,
 <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] ring-buffer: Fix slowpath of interrupted
 event" failed to apply to 6.1-stable tree
Message-ID: <20231230172019.261b6059@gandalf.local.home>
In-Reply-To: <20231230165156.4fd2eef6@gandalf.local.home>
References: <2023123047-tuesday-whooping-6ae3@gregkh>
	<20231230165156.4fd2eef6@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Dec 2023 16:51:56 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Below is the patch for 6.1 of this change, and it depends on:
> 
> 20231230164736.3b8c86c4@gandalf.local.home

And this is for 5.15.

-- Steve


---
 kernel/trace/ring_buffer.c |   77 ++++++++++++++-------------------------------
 1 file changed, 24 insertions(+), 53 deletions(-)

Index: test-linux.git/kernel/trace/ring_buffer.c
===================================================================
--- test-linux.git.orig/kernel/trace/ring_buffer.c	2023-12-30 16:51:29.022248800 -0500
+++ test-linux.git/kernel/trace/ring_buffer.c	2023-12-30 16:51:47.278447539 -0500
@@ -691,44 +691,6 @@ rb_time_read_cmpxchg(local_t *l, unsigne
 	return ret == expect;
 }
 
-static int rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
-{
-	unsigned long cnt, top, bottom;
-	unsigned long cnt2, top2, bottom2;
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
-	 rb_time_split(val, &top, &bottom);
-	 top = rb_time_val_cnt(top, cnt);
-	 bottom = rb_time_val_cnt(bottom, cnt);
-
-	 rb_time_split(set, &top2, &bottom2);
-	 top2 = rb_time_val_cnt(top2, cnt2);
-	 bottom2 = rb_time_val_cnt(bottom2, cnt2);
-
-	if (!rb_time_read_cmpxchg(&t->cnt, cnt, cnt2))
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
@@ -742,13 +704,6 @@ static void rb_time_set(rb_time_t *t, u6
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
@@ -3562,20 +3517,36 @@ __rb_reserve_next(struct ring_buffer_per
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
+		barrier();
+ /*E*/		a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
+		/* Was interrupted before here, write_stamp must be valid */
+		RB_WARN_ON(cpu_buffer, !a_ok);
 		barrier();
- /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
-		    info->after < ts &&
-		    rb_time_cmpxchg(&cpu_buffer->write_stamp,
-				    info->after, ts)) {
-			/* Nothing came after this event between C and E */
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

