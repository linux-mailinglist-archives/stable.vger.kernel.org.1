Return-Path: <stable+bounces-206375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C40D049AB
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 17:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CE72324080E
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E361F12E0;
	Thu,  8 Jan 2026 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Co0aASMi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35D1CEAB2;
	Thu,  8 Jan 2026 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887469; cv=none; b=uxdWOEBhgLDSVaAFub/oRld93nZMoeOqBOGuizvAQHbupze+YkW3jzjqKEg2yD0sm0sj9d/QMeo7596WtIJz80hDxyIZp6NeeQisQ1apQqJhTqiaZLmkV8GFJ6bQU+l8UWYldrzhXSS0DAFOvhJ/94brhnUegx+Is91xkkC5mjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887469; c=relaxed/simple;
	bh=JnAQNxKo3/kFpTWk7ALS9nsKn6/ADJVmJ4apj2OWGX4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=enoc2I09Wf55mwplZwmcWtIe/uih+cMd2X/3vAbLv4H5YovP28t5BW+3gaY5qfMsmpijnSg5LOhgG4HFzYyDsukA+3gO360mQiuTJSxDWWfU6dqHKA0S0Y4IsqdydpozxJzsXGGscuFYbZK7VlSenc1dQlj3Xm74gnyQYS7G3XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Co0aASMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF788C19423;
	Thu,  8 Jan 2026 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767887469;
	bh=JnAQNxKo3/kFpTWk7ALS9nsKn6/ADJVmJ4apj2OWGX4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Co0aASMi2dAGOZUFk0hKLB8fymAXgpOAiLhN1Q6cdzfBX4KhOm983MMCqjeVMPmCw
	 +92w9L0b0nQfBDXP7Qt+iMFt7o5pzrs+VVqRsQKcWs8iR8OCBtcv1yNBHEBM/uxvuH
	 YGR3qZjXknZocXTpkZYzZPbgI8XYrXJXpB1z3vApr84KK82LbxNGAFg81QjW+UGfwJ
	 C8EvVlRqeUwemOxd/DjBKO/okj5N+aULxXV11CCtX1oHzkZZLgwE8sOzxE4Icbeq3T
	 X7pcllQKoH0xH2S2y7X/7W+C6TD6wbBQywkde3w00LIj6tz2//c8EBkMqca9v0sxEP
	 1Lj+eaC7Ji6Qw==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vdsIU-00000004aW2-2vV2;
	Thu, 08 Jan 2026 10:51:38 -0500
Message-ID: <20260108155138.481872797@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 08 Jan 2026 10:51:24 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Yao Kai <yaokai34@huawei.com>
Subject: [for-linus][PATCH 4/5] tracing: Add recursion protection in kernel stack trace recording
References: <20260108155120.023038025@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

A bug was reported about an infinite recursion caused by tracing the rcu
events with the kernel stack trace trigger enabled. The stack trace code
called back into RCU which then called the stack trace again.

Expand the ftrace recursion protection to add a set of bits to protect
events from recursion. Each bit represents the context that the event is
in (normal, softirq, interrupt and NMI).

Have the stack trace code use the interrupt context to protect against
recursion.

Note, the bug showed an issue in both the RCU code as well as the tracing
stacktrace code. This only handles the tracing stack trace side of the
bug. The RCU fix will be handled separately.

Link: https://lore.kernel.org/all/20260102122807.7025fc87@gandalf.local.home/

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20260105203141.515cd49f@gandalf.local.home
Reported-by: Yao Kai <yaokai34@huawei.com>
Tested-by: Yao Kai <yaokai34@huawei.com>
Fixes: 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in __rcu_read_unlock()")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_recursion.h | 9 +++++++++
 kernel/trace/trace.c            | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index ae04054a1be3..e6ca052b2a85 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -34,6 +34,13 @@ enum {
 	TRACE_INTERNAL_SIRQ_BIT,
 	TRACE_INTERNAL_TRANSITION_BIT,
 
+	/* Internal event use recursion bits */
+	TRACE_INTERNAL_EVENT_BIT,
+	TRACE_INTERNAL_EVENT_NMI_BIT,
+	TRACE_INTERNAL_EVENT_IRQ_BIT,
+	TRACE_INTERNAL_EVENT_SIRQ_BIT,
+	TRACE_INTERNAL_EVENT_TRANSITION_BIT,
+
 	TRACE_BRANCH_BIT,
 /*
  * Abuse of the trace_recursion.
@@ -58,6 +65,8 @@ enum {
 
 #define TRACE_LIST_START	TRACE_INTERNAL_BIT
 
+#define TRACE_EVENT_START	TRACE_INTERNAL_EVENT_BIT
+
 #define TRACE_CONTEXT_MASK	((1 << (TRACE_LIST_START + TRACE_CONTEXT_BITS)) - 1)
 
 /*
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6f2148df14d9..aef9058537d5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3012,6 +3012,11 @@ static void __ftrace_trace_stack(struct trace_array *tr,
 	struct ftrace_stack *fstack;
 	struct stack_entry *entry;
 	int stackidx;
+	int bit;
+
+	bit = trace_test_and_set_recursion(_THIS_IP_, _RET_IP_, TRACE_EVENT_START);
+	if (bit < 0)
+		return;
 
 	/*
 	 * Add one, for this function and the call to save_stack_trace()
@@ -3080,6 +3085,7 @@ static void __ftrace_trace_stack(struct trace_array *tr,
 	/* Again, don't let gcc optimize things here */
 	barrier();
 	__this_cpu_dec(ftrace_stack_reserve);
+	trace_clear_recursion(bit);
 }
 
 static inline void ftrace_trace_stack(struct trace_array *tr,
-- 
2.51.0



