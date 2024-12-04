Return-Path: <stable+bounces-98366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2899E9E4092
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B95167751
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B25233D91;
	Wed,  4 Dec 2024 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTu7d3a1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174920E037;
	Wed,  4 Dec 2024 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331533; cv=none; b=iMCwXYHAhk6DB1SeLFq0MQs6SFyvqBmiTGPkWKqnK9vfX9elWkIOybSiNioK6g5M8yzK73EklBk9c4aChYIihld+K6UBe+LsEvsX+n6uHAkh46iqaKzf8b12hnB/F/zKnF1OaXLWfQaOibjKZnefu3QSqLp2uS95PzDXoI3puH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331533; c=relaxed/simple;
	bh=Y+M6Ju5s92/n8wJKiY38brJg0HJKpvXZeYRvtorhhNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVQg9v+YS8iQtSFZ/jMMj5AE3yPZnU5tOjV6JVaCNl7Vf3Icpey+KRqgXocH/mtPnC5q1/tG2fRMgRixSNQfDeHGDRhatfQbJkhBvpoy28/ds5rP6Pnzvd0hVQw7tl25WZb+7xMB64G6jTncuoiwAHkfbZzWZvxmhe6gk9gd+KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTu7d3a1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F66CC4CECD;
	Wed,  4 Dec 2024 16:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331533;
	bh=Y+M6Ju5s92/n8wJKiY38brJg0HJKpvXZeYRvtorhhNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jTu7d3a1+f2ukvnGPW5YlUaOi7rzXKVIlkkUlk0oW3ILozldlNzKjg4Lf3b6moygY
	 CfIpYn+97wyrJRMdmDptFVoJQjlKKS0gwrLMibhlEmTvZ6V88w/00Kw9bNhM5SRRGG
	 wx3scLrF9f9vAab2m1+4bK6OVbqq7/fZBPbNYeT675IQ6kF6an+ubztsOGqiTjy0lj
	 /G+PQmB21kmB/3tXqg8kjCRk6Ds0IYi1nrADXI1tbW7dbU8E1V4l9eDLnyPgsoYOOT
	 wV9Y3VlpXs9jQ//zFoWyUuD7VdWm6IEw8lrdLZ8gbUIW7FCH1dPo+CIRBxQHbyjSsD
	 3hX4dH/tF9UCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tatsuya S <tatsuya.s2862@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 33/36] tracing: Fix function name for trampoline
Date: Wed,  4 Dec 2024 10:45:49 -0500
Message-ID: <20241204154626.2211476-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204154626.2211476-1-sashal@kernel.org>
References: <20241204154626.2211476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Tatsuya S <tatsuya.s2862@gmail.com>

[ Upstream commit 6ce5a6f0a07d37cc377df08a8d8a9c283420f323 ]

The issue that unrelated function name is shown on stack trace like
following even though it should be trampoline code address is caused by
the creation of trampoline code in the area where .init.text section
of module was freed after module is loaded.

bash-1344    [002] .....    43.644608: <stack trace>
=> (MODULE INIT FUNCTION)
=> vfs_write
=> ksys_write
=> do_syscall_64
=> entry_SYSCALL_64_after_hwframe

To resolve this, when function address of stack trace entry is in
trampoline, output without looking up symbol name.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20241021071454.34610-2-tatsuya.s2862@gmail.com
Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c        | 33 +++++++++++++++++++++++++--------
 kernel/trace/trace.h        |  7 +++++++
 kernel/trace/trace_output.c |  4 ++++
 3 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6a891e00aa7f4..17d2ffde0bb60 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -988,7 +988,8 @@ static inline void trace_access_lock_init(void)
 #endif
 
 #ifdef CONFIG_STACKTRACE
-static void __ftrace_trace_stack(struct trace_buffer *buffer,
+static void __ftrace_trace_stack(struct trace_array *tr,
+				 struct trace_buffer *buffer,
 				 unsigned int trace_ctx,
 				 int skip, struct pt_regs *regs);
 static inline void ftrace_trace_stack(struct trace_array *tr,
@@ -997,7 +998,8 @@ static inline void ftrace_trace_stack(struct trace_array *tr,
 				      int skip, struct pt_regs *regs);
 
 #else
-static inline void __ftrace_trace_stack(struct trace_buffer *buffer,
+static inline void __ftrace_trace_stack(struct trace_array *tr,
+					struct trace_buffer *buffer,
 					unsigned int trace_ctx,
 					int skip, struct pt_regs *regs)
 {
@@ -2947,7 +2949,8 @@ struct ftrace_stacks {
 static DEFINE_PER_CPU(struct ftrace_stacks, ftrace_stacks);
 static DEFINE_PER_CPU(int, ftrace_stack_reserve);
 
-static void __ftrace_trace_stack(struct trace_buffer *buffer,
+static void __ftrace_trace_stack(struct trace_array *tr,
+				 struct trace_buffer *buffer,
 				 unsigned int trace_ctx,
 				 int skip, struct pt_regs *regs)
 {
@@ -2994,6 +2997,20 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 		nr_entries = stack_trace_save(fstack->calls, size, skip);
 	}
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+	/* Mark entry of stack trace as trampoline code */
+	if (tr->ops && tr->ops->trampoline) {
+		unsigned long tramp_start = tr->ops->trampoline;
+		unsigned long tramp_end = tramp_start + tr->ops->trampoline_size;
+		unsigned long *calls = fstack->calls;
+
+		for (int i = 0; i < nr_entries; i++) {
+			if (calls[i] >= tramp_start && calls[i] < tramp_end)
+				calls[i] = FTRACE_TRAMPOLINE_MARKER;
+		}
+	}
+#endif
+
 	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
 				    struct_size(entry, caller, nr_entries),
 				    trace_ctx);
@@ -3024,7 +3041,7 @@ static inline void ftrace_trace_stack(struct trace_array *tr,
 	if (!(tr->trace_flags & TRACE_ITER_STACKTRACE))
 		return;
 
-	__ftrace_trace_stack(buffer, trace_ctx, skip, regs);
+	__ftrace_trace_stack(tr, buffer, trace_ctx, skip, regs);
 }
 
 void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
@@ -3033,7 +3050,7 @@ void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
 
 	if (rcu_is_watching()) {
-		__ftrace_trace_stack(buffer, trace_ctx, skip, NULL);
+		__ftrace_trace_stack(tr, buffer, trace_ctx, skip, NULL);
 		return;
 	}
 
@@ -3050,7 +3067,7 @@ void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
 		return;
 
 	ct_irq_enter_irqson();
-	__ftrace_trace_stack(buffer, trace_ctx, skip, NULL);
+	__ftrace_trace_stack(tr, buffer, trace_ctx, skip, NULL);
 	ct_irq_exit_irqson();
 }
 
@@ -3067,8 +3084,8 @@ void trace_dump_stack(int skip)
 	/* Skip 1 to skip this function. */
 	skip++;
 #endif
-	__ftrace_trace_stack(printk_trace->array_buffer.buffer,
-			     tracing_gen_ctx(), skip, NULL);
+	__ftrace_trace_stack(printk_trace, printk_trace->array_buffer.buffer,
+				tracing_gen_ctx(), skip, NULL);
 }
 EXPORT_SYMBOL_GPL(trace_dump_stack);
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index c866991b9c78b..30d6675c78cfe 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2176,4 +2176,11 @@ static inline int rv_init_interface(void)
 }
 #endif
 
+/*
+ * This is used only to distinguish
+ * function address from trampoline code.
+ * So this value has no meaning.
+ */
+#define FTRACE_TRAMPOLINE_MARKER  ((unsigned long) INT_MAX)
+
 #endif /* _LINUX_KERNEL_TRACE_H */
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 868f2f912f280..c14573e5a9033 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1246,6 +1246,10 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
 			break;
 
 		trace_seq_puts(s, " => ");
+		if ((*p) == FTRACE_TRAMPOLINE_MARKER) {
+			trace_seq_puts(s, "[FTRACE TRAMPOLINE]\n");
+			continue;
+		}
 		seq_print_ip_sym(s, (*p) + delta, flags);
 		trace_seq_putc(s, '\n');
 	}
-- 
2.43.0


