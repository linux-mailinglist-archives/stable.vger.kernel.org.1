Return-Path: <stable+bounces-6863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381B981574E
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 05:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF663B22053
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 04:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A05156C0;
	Sat, 16 Dec 2023 04:21:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEAC14A8A;
	Sat, 16 Dec 2023 04:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A620AC4339A;
	Sat, 16 Dec 2023 04:21:52 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rEMCJ-00000002yDG-2W0E;
	Fri, 15 Dec 2023 23:22:43 -0500
Message-ID: <20231216042243.383892237@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 15 Dec 2023 23:22:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 06/15] ring-buffer: Do not update before stamp when switching sub-buffers
References: <20231216042214.905262999@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

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
---
 kernel/trace/ring_buffer.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

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
 
-- 
2.42.0



