Return-Path: <stable+bounces-208086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D69FFD11F14
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 11:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C5F8304D4B6
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D862C08A1;
	Mon, 12 Jan 2026 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tfKQRu5g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178642BEC34
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214193; cv=none; b=H8qdoWZb26OnoXinVIMuK79KvPFC5d+82qkcC7Mqc59g/akODs0gn7pXxwND7qmvEOwq7+yh61WO6pEhDQoGoXzOfaJbXodw6DBdwJdKXYKc7w6v8nocPCjD4TaSDgrR9LeJAnwpDCRxLbUpPQrqJAmDjkpIv5l7CW3ftck76y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214193; c=relaxed/simple;
	bh=z/1ZW2oOk0A43dom6n7mYh4eEBm5zgjBr14Ed+Qkh+g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pxrSDlS7Ri7LDa7gnX6nrLo8FzGqzGpNIWfnTj9SUrnOJj7VmZjDsYWbhj2NolmC/Ik+KJ0+CGQzmbqDI+h2UdF1fsxlyfULkEeYnFJSOWE5kEF6r1rAD8uyCFx2ZfO+LryFdY2CSV2MV50zsox7m6VLe1cZ6Ah+RVldRFA30OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tfKQRu5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FECC16AAE;
	Mon, 12 Jan 2026 10:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768214193;
	bh=z/1ZW2oOk0A43dom6n7mYh4eEBm5zgjBr14Ed+Qkh+g=;
	h=Subject:To:Cc:From:Date:From;
	b=tfKQRu5guwjtoknZ4E6bbLQNrwC3fwZ/y+Bz2BoqntAMdNo54efNV3QeboRJOviNf
	 Q8fZohpxNhiCvFe+AgFdRaWVHRfzMS9SXjT9+vfRBK9ouWktLfHCknqohEyqRZEhXu
	 53kH47h9DOjDE01uxymkG07H2uGCxD3In3qJ4pAo=
Subject: FAILED: patch "[PATCH] tracing: Add recursion protection in kernel stack trace" failed to apply to 6.1-stable tree
To: rostedt@goodmis.org,boqun.feng@gmail.com,joel@joelfernandes.org,mathieu.desnoyers@efficios.com,mhiramat@kernel.org,paulmck@kernel.org,yaokai34@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Jan 2026 11:36:23 +0100
Message-ID: <2026011223-daydream-scolding-50ce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5f1ef0dfcb5b7f4a91a9b0e0ba533efd9f7e2cdb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026011223-daydream-scolding-50ce@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5f1ef0dfcb5b7f4a91a9b0e0ba533efd9f7e2cdb Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Mon, 5 Jan 2026 20:31:41 -0500
Subject: [PATCH] tracing: Add recursion protection in kernel stack trace
 recording

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


