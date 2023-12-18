Return-Path: <stable+bounces-7413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B25381726F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13C41C24E33
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FBA4FF98;
	Mon, 18 Dec 2023 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dYUwKiZn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B54FF8B;
	Mon, 18 Dec 2023 14:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BA3C433C7;
	Mon, 18 Dec 2023 14:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908399;
	bh=ctNDPGFIII3sT41wXKVgu1rZ/yXfzTtfYoW9n8xVUyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dYUwKiZnbCEB5fbfiH1vCihKM1SARm0MR5XmFfHf8h57sgokcohF3EvM6QYmQYhm/
	 iYZ9GNitriopSFw24Ez4CDlhjlwe9rmc2WKKcawWm4Gt8lNcIeenkfk1U73QbHAb9y
	 LBUXDwFRJTm4bQ6kCEIQedgblz+z2lhcgVbfo41U=
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
Subject: [PATCH 6.6 163/166] ring-buffer: Do not try to put back write_stamp
Date: Mon, 18 Dec 2023 14:52:09 +0100
Message-ID: <20231218135112.417013353@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
References: <20231218135104.927894164@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

commit dd939425707898da992e59ab0fcfae4652546910 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/ring_buffer.c |   29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3614,14 +3614,14 @@ __rb_reserve_next(struct ring_buffer_per
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
@@ -3629,24 +3629,7 @@ __rb_reserve_next(struct ring_buffer_per
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



