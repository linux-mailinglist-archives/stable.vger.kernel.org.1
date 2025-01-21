Return-Path: <stable+bounces-110065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DFDA1860B
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 21:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC37F16852F
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 20:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F42271F76AC;
	Tue, 21 Jan 2025 20:21:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E151F543E;
	Tue, 21 Jan 2025 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737490879; cv=none; b=hKcBtfaahDjvFkPCkO5AnpJ8SdtMt+5aWadY3SGGI3f9urGdmA+LVmLFVMVrX7iy8kMPu8wYoead2Vb8+pZ9SNUiReLa0fs2y1wcmGgixrC+hqsjqbv2xSpcv/UcwvuhStgLLXgCVQJaQ8vlqqGoZMFkswvQZ9acwUYsshBUNRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737490879; c=relaxed/simple;
	bh=wEIqrpwtO+5fHyTIV6p6E690N4na1u6NCkd9jLIp/2U=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YurVOE7wFQIdm0mSN1S2gFCeFo8Te4pajgBpwExo4GxGJLpOzF9pLPRboY9y2uxHWRrWk1J6xr/3p3JdXSu20smzEg7WU3bMJsQ7x9zHn27EDAsRcWnq3lPzvpOhVjWCBsm6PhVxttrG0jepi7Pn4bq1WSj+KuRCKB+8d91gXeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E699C4CEE2;
	Tue, 21 Jan 2025 20:21:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1taKkV-00000000L78-0qfo;
	Tue, 21 Jan 2025 15:21:23 -0500
Message-ID: <20250121202123.054964518@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 21 Jan 2025 15:19:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andreas Larsson <andreas@gaisler.com>,
 Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Subject: [for-next][PATCH 1/2] ring-buffer: Do not allow events in NMI with generic atomic64
 cmpxchg()
References: <20250121201942.978460684@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Some architectures can not safely do atomic64 operations in NMI context.
Since the ring buffer relies on atomic64 operations to do its time
keeping, if an event is requested in NMI context, reject it for these
architectures.

Cc: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Link: https://lore.kernel.org/20250120235721.407068250@goodmis.org
Fixes: c84897c0ff592 ("ring-buffer: Remove 32bit timestamp logic")
Closes: https://lore.kernel.org/all/86fb4f86-a0e4-45a2-a2df-3154acc4f086@gaisler.com/
Reported-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 6d61ff78926b..b8e0ae15ca5b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4398,8 +4398,13 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	int nr_loops = 0;
 	int add_ts_default;
 
-	/* ring buffer does cmpxchg, make sure it is safe in NMI context */
-	if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) &&
+	/*
+	 * ring buffer does cmpxchg as well as atomic64 operations
+	 * (which some archs use locking for atomic64), make sure this
+	 * is safe in NMI context
+	 */
+	if ((!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) ||
+	     IS_ENABLED(CONFIG_GENERIC_ATOMIC64)) &&
 	    (unlikely(in_nmi()))) {
 		return NULL;
 	}
-- 
2.45.2



