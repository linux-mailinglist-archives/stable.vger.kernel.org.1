Return-Path: <stable+bounces-221560-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ApDOeWYo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221560-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:39:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E10C1CB426
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E927A30608A6
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4022C0294;
	Sun,  1 Mar 2026 01:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A49+uHsa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35F525228C;
	Sun,  1 Mar 2026 01:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328579; cv=none; b=gFtIqyugV/IoxRABXeAw1ffLiABhfYjf3oM4KBCIUkfVVv+FN3/n74tOJ2TNUDyXB5C9+PPdAWPxkRLOtQP7HthWAU7Csa6jOWLtWMwOAXSuxprukHmMwawO9qOO5wIUQQBpR4ZD3Fu7V50W6qeBWiqk0ipt/oeRtpbGGx8zx4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328579; c=relaxed/simple;
	bh=PuUBMvIxAzwGqm7TaFduO5+FkiVH/Mb5aHjNDYNMxMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HdJkRqOczqRQtIE5L8JMFfqu7pMGpWE5ZJ6gYZ2WIsRoR6RJj3jGWAZJUpBzUhnp2yCB4ysmQN5zXav5ob3LOgmnKC14XqFFpDMbNvtcPwakPavsWHVVeFaZ43RXCt2SQ/wh4gnfUHCegtRs5pJTccTVoE2388XhoyI5CMp4/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A49+uHsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5CEC19421;
	Sun,  1 Mar 2026 01:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328579;
	bh=PuUBMvIxAzwGqm7TaFduO5+FkiVH/Mb5aHjNDYNMxMM=;
	h=From:To:Cc:Subject:Date:From;
	b=A49+uHsa1pnjU9CEFHkO3YMKGlfpnanEktfzmN5UVJze3s65JPP1rprsPzlhPGbTA
	 x+36cGOGREBQJLJTB0S7WxLrmVP0yWBIIhAPaZGUoqvW5v5u0pJ11p3jdT8FT+nIHy
	 hDaYa7VA8xYNW8XNrta6we7CYBV38ZG3t5uAMxIwkN0BbksqZqhGYttD88yE+mEEM3
	 OgVLynjOmV/V+KUEHAArE9r09iBXttzsfSv/+AfgU2afwHv739lfEB+4aJocRUt68R
	 +BvguCzySx0WqB/xybEIVvhE158BgZUJ6xe3Hgtey7owSOcRRHdlZ/EoS8pVJN9M04
	 X7iZnWFWBcNIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	rostedt@goodmis.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-trace-kernel@vger.kernel.org
Subject: FAILED: Patch "fgraph: Do not call handlers direct when not using ftrace_ops" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:29:37 -0500
Message-ID: <20260301012938.1687441-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221560-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1E10C1CB426
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f4ff9f646a4d373f9e895c2f0073305da288bc0a Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 18 Feb 2026 10:42:44 -0500
Subject: [PATCH] fgraph: Do not call handlers direct when not using ftrace_ops

The function graph tracer was modified to us the ftrace_ops of the
function tracer. This simplified the code as well as allowed more features
of the function graph tracer.

Not all architectures were converted over as it required the
implementation of HAVE_DYNAMIC_FTRACE_WITH_ARGS to implement. For those
architectures, it still did it the old way where the function graph tracer
handle was called by the function tracer trampoline. The handler then had
to check the hash to see if the registered handlers wanted to be called by
that function or not.

In order to speed up the function graph tracer that used ftrace_ops, if
only one callback was registered with function graph, it would call its
function directly via a static call.

Now, if the architecture does not support the use of using ftrace_ops and
still has the ftrace function trampoline calling the function graph
handler, then by doing a direct call it removes the check against the
handler's hash (list of functions it wants callbacks to), and it may call
that handler for functions that the handler did not request calls for.

On 32bit x86, which does not support the ftrace_ops use with function
graph tracer, it shows the issue:

 ~# trace-cmd start -p function -l schedule
 ~# trace-cmd show
 # tracer: function_graph
 #
 # CPU  DURATION                  FUNCTION CALLS
 # |     |   |                     |   |   |   |
  2) * 11898.94 us |  schedule();
  3) # 1783.041 us |  schedule();
  1)               |  schedule() {
  ------------------------------------------
  1)   bash-8369    =>  kworker-7669
  ------------------------------------------
  1)               |        schedule() {
  ------------------------------------------
  1)  kworker-7669  =>   bash-8369
  ------------------------------------------
  1) + 97.004 us   |  }
  1)               |  schedule() {
 [..]

Now by starting the function tracer is another instance:

 ~# trace-cmd start -B foo -p function

This causes the function graph tracer to trace all functions (because the
function trace calls the function graph tracer for each on, and the
function graph trace is doing a direct call):

 ~# trace-cmd show
 # tracer: function_graph
 #
 # CPU  DURATION                  FUNCTION CALLS
 # |     |   |                     |   |   |   |
  1)   1.669 us    |          } /* preempt_count_sub */
  1) + 10.443 us   |        } /* _raw_spin_unlock_irqrestore */
  1)               |        tick_program_event() {
  1)               |          clockevents_program_event() {
  1)   1.044 us    |            ktime_get();
  1)   6.481 us    |            lapic_next_event();
  1) + 10.114 us   |          }
  1) + 11.790 us   |        }
  1) ! 181.223 us  |      } /* hrtimer_interrupt */
  1) ! 184.624 us  |    } /* __sysvec_apic_timer_interrupt */
  1)               |    irq_exit_rcu() {
  1)   0.678 us    |      preempt_count_sub();

When it should still only be tracing the schedule() function.

To fix this, add a macro FGRAPH_NO_DIRECT to be set to 0 when the
architecture does not support function graph use of ftrace_ops, and set to
1 otherwise. Then use this macro to know to allow function graph tracer to
call the handlers directly or not.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Link: https://patch.msgid.link/20260218104244.5f14dade@gandalf.local.home
Fixes: cc60ee813b503 ("function_graph: Use static_call and branch to optimize entry function")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h | 13 ++++++++++---
 kernel/trace/fgraph.c  | 12 +++++++++++-
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 1a4d36fc90852..c242fe49af4c9 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1092,10 +1092,17 @@ static inline bool is_ftrace_trampoline(unsigned long addr)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 #ifndef ftrace_graph_func
-#define ftrace_graph_func ftrace_stub
-#define FTRACE_OPS_GRAPH_STUB FTRACE_OPS_FL_STUB
+# define ftrace_graph_func ftrace_stub
+# define FTRACE_OPS_GRAPH_STUB FTRACE_OPS_FL_STUB
+/*
+ * The function graph is called every time the function tracer is called.
+ * It must always test the ops hash and cannot just directly call
+ * the handler.
+ */
+# define FGRAPH_NO_DIRECT	1
 #else
-#define FTRACE_OPS_GRAPH_STUB 0
+# define FTRACE_OPS_GRAPH_STUB	0
+# define FGRAPH_NO_DIRECT	0
 #endif
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 4df766c690f92..40d373d65f9b9 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -539,7 +539,11 @@ static struct fgraph_ops fgraph_stub = {
 static struct fgraph_ops *fgraph_direct_gops = &fgraph_stub;
 DEFINE_STATIC_CALL(fgraph_func, ftrace_graph_entry_stub);
 DEFINE_STATIC_CALL(fgraph_retfunc, ftrace_graph_ret_stub);
+#if FGRAPH_NO_DIRECT
+static DEFINE_STATIC_KEY_FALSE(fgraph_do_direct);
+#else
 static DEFINE_STATIC_KEY_TRUE(fgraph_do_direct);
+#endif
 
 /**
  * ftrace_graph_stop - set to permanently disable function graph tracing
@@ -843,7 +847,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 	bitmap = get_bitmap_bits(current, offset);
 
 #ifdef CONFIG_HAVE_STATIC_CALL
-	if (static_branch_likely(&fgraph_do_direct)) {
+	if (!FGRAPH_NO_DIRECT && static_branch_likely(&fgraph_do_direct)) {
 		if (test_bit(fgraph_direct_gops->idx, &bitmap))
 			static_call(fgraph_retfunc)(&trace, fgraph_direct_gops, fregs);
 	} else
@@ -1285,6 +1289,9 @@ static void ftrace_graph_enable_direct(bool enable_branch, struct fgraph_ops *go
 	trace_func_graph_ret_t retfunc = NULL;
 	int i;
 
+	if (FGRAPH_NO_DIRECT)
+		return;
+
 	if (gops) {
 		func = gops->entryfunc;
 		retfunc = gops->retfunc;
@@ -1308,6 +1315,9 @@ static void ftrace_graph_enable_direct(bool enable_branch, struct fgraph_ops *go
 
 static void ftrace_graph_disable_direct(bool disable_branch)
 {
+	if (FGRAPH_NO_DIRECT)
+		return;
+
 	if (disable_branch)
 		static_branch_disable(&fgraph_do_direct);
 	static_call_update(fgraph_func, ftrace_graph_entry_stub);
-- 
2.51.0





