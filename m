Return-Path: <stable+bounces-208083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 148C1D11EF6
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 11:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 899AF30188EF
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E9D29D28A;
	Mon, 12 Jan 2026 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yLx5mY2w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDACE2701D1
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214184; cv=none; b=A5oWtGl1hHv3PrngF7Fb0Saq78AsI2LO5eS4GV/Zo++kJfmqa9NgIha835zxFgjPWG13Th4yYFXDRhAvOq8B+rG4PBk2A6qk3cixI0RZVhWOKQoEB5VKkVYWiD9BNNc0jEQf0UcfkAQHXOIiQ4WXUXpJvAUq8pjuxPdZ7pd+x4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214184; c=relaxed/simple;
	bh=79HY/RUNZ3LPifMUACcAkZMLG6hD9xFUE2sWO+2c6mE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Un7tLcKOljabdU9GD1cJt1/5drAB/dgc4rbE58i1H2BNn3An1wEkBCmT3HPmqaDUP+pTEWIhjkWBIeet915LgHMyNFUP2JSPy2ZXFriL0XWKVGKCoujpzqRqRaRYPz84C9+yHoYB/xxuIAfSrnqJ09HeGpDg92coVaIYtj8XFCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yLx5mY2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17AFC19422;
	Mon, 12 Jan 2026 10:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768214184;
	bh=79HY/RUNZ3LPifMUACcAkZMLG6hD9xFUE2sWO+2c6mE=;
	h=Subject:To:Cc:From:Date:From;
	b=yLx5mY2wDOqLJd0Mv4CtVZAoTQ+NIANgoQ3XxEjQXbQvnnFapxrDUPYBC11qMjZA2
	 03EP54DI4RgyBdl4lPsPiuT641A17PiK+ryWl1I6fpwPBPl/kN7obcjy2xnYK0OBg0
	 EOg4RChlOMD62wqNJYFmqNp5VHayulQ56Pz6xk/o=
Subject: FAILED: patch "[PATCH] tracing: Add recursion protection in kernel stack trace" failed to apply to 6.12-stable tree
To: rostedt@goodmis.org,boqun.feng@gmail.com,joel@joelfernandes.org,mathieu.desnoyers@efficios.com,mhiramat@kernel.org,paulmck@kernel.org,yaokai34@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Jan 2026 11:36:16 +0100
Message-ID: <2026011216-preacher-swampland-24d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5f1ef0dfcb5b7f4a91a9b0e0ba533efd9f7e2cdb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026011216-preacher-swampland-24d3@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


