Return-Path: <stable+bounces-109579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B750FA17519
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 00:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B47169E96
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 23:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079C41F0E2B;
	Mon, 20 Jan 2025 23:57:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76681EEA5F;
	Mon, 20 Jan 2025 23:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737417439; cv=none; b=rB8NFLP4873aJNf1ESAuCSsZUOJhSVQMjPQ2a70xBPQBEUOlF7DtiRSmSAezrIcciYjy8u5wcZRcPvMzTYltFU765Lw0vkLYEEr8l27xTqgNVQEp1Ug3WNMY/6C8HnPMmj3nSAe4k1FSquY7Nx8Tc/DrCbbe7LdvhUlJYDq7/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737417439; c=relaxed/simple;
	bh=5vVFnxa83jtShI+yZbv7VJ1NuPbkhqKij9W9TGLo2nc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=J2cOvoeAhhWzPqa2GlUaJrgQ87OJ3AObDJCKqYaxjDpIuM9m6xjmPapk9xLOOGnEetuTc7Rp20+IwRcleMBeJw/YVO1wOyoEmXn+GnOGRzoxb0V7U9TLJVX0eCw4G15678Jcu3TgxGEx3PxpT+8oee4OBGN0qT0kHrNeXb3QnfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AE5C4CEE1;
	Mon, 20 Jan 2025 23:57:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1ta1dx-0000000097F-2KEF;
	Mon, 20 Jan 2025 18:57:21 -0500
Message-ID: <20250120235721.407068250@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 20 Jan 2025 18:56:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ludwig Rydberg <ludwig.rydberg@gaisler.com>,
 Andreas Larsson <andreas@gaisler.com>,
 stable@vger.kernel.org
Subject: [PATCH 1/2] ring-buffer: Do not allow events in NMI with generic atomic64
 cmpxchg()
References: <20250120235655.144537620@goodmis.org>
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
Fixes: c84897c0ff592 ("ring-buffer: Remove 32bit timestamp logic")
Closes: https://lore.kernel.org/all/86fb4f86-a0e4-45a2-a2df-3154acc4f086@gaisler.com/
Reported-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
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



