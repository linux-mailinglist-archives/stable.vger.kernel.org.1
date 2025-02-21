Return-Path: <stable+bounces-118617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C60DDA3F9CA
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 17:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98A319E146B
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 15:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF1721507B;
	Fri, 21 Feb 2025 15:52:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1691215067;
	Fri, 21 Feb 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153143; cv=none; b=iqP9K+dQjSJBvBMN18Ek16vnlW7xlFpbmYeHbDfR6ojB7G7zQUowS92dbZKemuT8dx9D0fPOwlno7GBTJsTne1GjrUPqRw4wwAZhI2/GfStkIirdHcDZv22qwqfRV+3GToM9KTe5OwbSrnZyc1OwVIEC5UzRCG0pVh/D76Yer18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153143; c=relaxed/simple;
	bh=ArlzHz5sHRcomKQ7ycDmntfz8f0x2xGW9b/ECO602Vk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=F8DJ5A0hMRL8Y0AsjRH6iExmEcOipCg0Ryz4FoqJpJjYv6ebgcsLobK5jEzEeb0ZeVHa+tFL6ykVnE4CnIumyPq48DFKDXl0i3w7JI9duArE9lywjwoBgBfSiVmIp8/k+6QEV5IKufZTdp94+/EZ8wW0JujRDfQKQ8wkLeooZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B9BC4CED6;
	Fri, 21 Feb 2025 15:52:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tlVKe-00000006KU6-2oSI;
	Fri, 21 Feb 2025 10:52:52 -0500
Message-ID: <20250221155252.520741008@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 21 Feb 2025 10:52:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Wander Lairson Costa <wander@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [for-linus][PATCH 6/7] ftrace: Correct preemption accounting for function tracing.
References: <20250221155210.755295517@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The function tracer should record the preemption level at the point when
the function is invoked. If the tracing subsystem decrement the
preemption counter it needs to correct this before feeding the data into
the trace buffer. This was broken in the commit cited below while
shifting the preempt-disabled section.

Use tracing_gen_ctx_dec() which properly subtracts one from the
preemption counter on a preemptible kernel.

Cc: stable@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/20250220140749.pfw8qoNZ@linutronix.de
Fixes: ce5e48036c9e7 ("ftrace: disable preemption when recursion locked")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index d358c9935164..df56f9b76010 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -216,7 +216,7 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 
 	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
 
-	trace_ctx = tracing_gen_ctx();
+	trace_ctx = tracing_gen_ctx_dec();
 
 	data = this_cpu_ptr(tr->array_buffer.data);
 	if (!atomic_read(&data->disabled))
@@ -321,7 +321,6 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	struct trace_array *tr = op->private;
 	struct trace_array_cpu *data;
 	unsigned int trace_ctx;
-	unsigned long flags;
 	int bit;
 
 	if (unlikely(!tr->function_enabled))
@@ -347,8 +346,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	if (is_repeat_check(tr, last_info, ip, parent_ip))
 		goto out;
 
-	local_save_flags(flags);
-	trace_ctx = tracing_gen_ctx_flags(flags);
+	trace_ctx = tracing_gen_ctx_dec();
 	process_repeats(tr, ip, parent_ip, last_info, trace_ctx);
 
 	trace_function(tr, ip, parent_ip, trace_ctx);
-- 
2.47.2



