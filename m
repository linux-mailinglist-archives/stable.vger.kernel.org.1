Return-Path: <stable+bounces-9472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D138823287
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A761C23BB8
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2219A1C284;
	Wed,  3 Jan 2024 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="isTdSd++"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1BE1BDFC;
	Wed,  3 Jan 2024 17:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6A5C433C7;
	Wed,  3 Jan 2024 17:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301697;
	bh=dCZofSVTAbqoh5jL2VBdrDJG2nyoL6svkqEFwPtjyfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=isTdSd++EKwJXOZeeyDErUj5UnP4jmPeb+WIMwxNTN+2HdhwPJzJ2M9kxHJbhjWhK
	 cFnXfYGWixo+vScWt2mEnlLpdey0KT75HS4eo6C94T2q/HDi4zgkoLJ1l8HF9wNMN3
	 fij+1uAv5YIixbiHzQr3eIMQRgdPysKWbscTnPYk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 5.15 92/95] ring-buffer: Fix slowpath of interrupted event
Date: Wed,  3 Jan 2024 17:55:40 +0100
Message-ID: <20240103164907.849910320@linuxfoundation.org>
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

commit b803d7c664d55705831729d2f2e29c874bcd62ea upstream.

To synchronize the timestamps with the ring buffer reservation, there are
two timestamps that are saved in the buffer meta data.

1. before_stamp
2. write_stamp

When the two are equal, the write_stamp is considered valid, as in, it may
be used to calculate the delta of the next event as the write_stamp is the
timestamp of the previous reserved event on the buffer.

This is done by the following:

 /*A*/	w = current position on the ring buffer
	before = before_stamp
	after = write_stamp
	ts = read current timestamp

	if (before != after) {
		write_stamp is not valid, force adding an absolute
		timestamp.
	}

 /*B*/	before_stamp = ts

 /*C*/	write = local_add_return(event length, position on ring buffer)

	if (w == write - event length) {
		/* Nothing interrupted between A and C */
 /*E*/		write_stamp = ts;
		delta = ts - after
		/*
		 * If nothing interrupted again,
		 * before_stamp == write_stamp and write_stamp
		 * can be used to calculate the delta for
		 * events that come in after this one.
		 */
	} else {

		/*
		 * The slow path!
		 * Was interrupted between A and C.
		 */

This is the place that there's a bug. We currently have:

		after = write_stamp
		ts = read current timestamp

 /*F*/		if (write == current position on the ring buffer &&
		    after < ts && cmpxchg(write_stamp, after, ts)) {

			delta = ts - after;

		} else {
			delta = 0;
		}

The assumption is that if the current position on the ring buffer hasn't
moved between C and F, then it also was not interrupted, and that the last
event written has a timestamp that matches the write_stamp. That is the
write_stamp is valid.

But this may not be the case:

If a task context event was interrupted by softirq between B and C.

And the softirq wrote an event that got interrupted by a hard irq between
C and E.

and the hard irq wrote an event (does not need to be interrupted)

We have:

 /*B*/ before_stamp = ts of normal context

   ---> interrupted by softirq

	/*B*/ before_stamp = ts of softirq context

	  ---> interrupted by hardirq

		/*B*/ before_stamp = ts of hard irq context
		/*E*/ write_stamp = ts of hard irq context

		/* matches and write_stamp valid */
	  <----

	/*E*/ write_stamp = ts of softirq context

	/* No longer matches before_stamp, write_stamp is not valid! */

   <---

 w != write - length, go to slow path

// Right now the order of events in the ring buffer is:
//
// |-- softirq event --|-- hard irq event --|-- normal context event --|
//

 after = write_stamp (this is the ts of softirq)
 ts = read current timestamp

 if (write == current position on the ring buffer [true] &&
     after < ts [true] && cmpxchg(write_stamp, after, ts) [true]) {

	delta = ts - after  [Wrong!]

The delta is to be between the hard irq event and the normal context
event, but the above logic made the delta between the softirq event and
the normal context event, where the hard irq event is between the two. This
will shift all the remaining event timestamps on the sub-buffer
incorrectly.

The write_stamp is only valid if it matches the before_stamp. The cmpxchg
does nothing to help this.

Instead, the following logic can be done to fix this:

	before = before_stamp
	ts = read current timestamp
	before_stamp = ts

	after = write_stamp

	if (write == current position on the ring buffer &&
	    after == before && after < ts) {

		delta = ts - after

	} else {
		delta = 0;
	}

The above will only use the write_stamp if it still matches before_stamp
and was tested to not have changed since C.

As a bonus, with this logic we do not need any 64-bit cmpxchg() at all!

This means the 32-bit rb_time_t workaround can finally be removed. But
that's for a later time.

Link: https://lore.kernel.org/linux-trace-kernel/20231218175229.58ec3daf@gandalf.local.home/
Link: https://lore.kernel.org/linux-trace-kernel/20231218230712.3a76b081@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: dd93942570789 ("ring-buffer: Do not try to put back write_stamp")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/ring_buffer.c |   77 ++++++++++++++-------------------------------
 1 file changed, 24 insertions(+), 53 deletions(-)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
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
@@ -3568,20 +3523,36 @@ __rb_reserve_next(struct ring_buffer_per
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



