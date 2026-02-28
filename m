Return-Path: <stable+bounces-220916-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yD9gAUFMo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220916-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:12:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 717431C805D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57A803114565
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E7042CCDD;
	Sat, 28 Feb 2026 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5TNLsOD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D917642CCD5;
	Sat, 28 Feb 2026 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300804; cv=none; b=jPW9NkjnWWyJYytsomu9MHMFzgFQAI9sV5Fr8zQw2VQAhL1vuZ0nV5p0wUaoYGnVLT1qokmZPrwYjKZp0dmUnHCKREdlpMXlNI2wGb4r+xik6CJ1mWeTkY98+hSDj32eety101fa4ysgop9iBjpT5ptlTcpIt+7bfnUM7pPnXkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300804; c=relaxed/simple;
	bh=u6XffEUn8okCWeW12Hb68HWqNxZELSMa3aZJCkbcFKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ul3ixAkcVIz/FW2nTeQu0YwLiUD70RzVZvtuZEblA0vGH7rjIX6FWfHEKgWvlmdbM+55WFZA9+5pBJNy+o+LoeP9R1pgiSMm8oByx5hfpY4fGWqpFnzPc49AvFVFL8gOA77WgXBCBT5ZxRKzpShx7BwCRUUMmzQGZR9UjxlFbW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5TNLsOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05896C19424;
	Sat, 28 Feb 2026 17:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300804;
	bh=u6XffEUn8okCWeW12Hb68HWqNxZELSMa3aZJCkbcFKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t5TNLsODFJTp1lOxIeF8hv74H20XH6wyMj0NBu8TODnUejOpGKGUAyQxL5IjVJEhD
	 c9DBjhADEluq6W13TWUu6ghEWH0Xl7u10bhCMZxqHQdhKh3yArLG3K7AoaOHJk5GBI
	 QpSVn8pbbxs57S/NiD/NW8NuRBG55qxNmHgns6yzPpn1L+yQEXFlPhDg3FTCthMcAh
	 +9SIBY6XvjSXU9fjJJQ4DZ+ZrhjUddfQL5vncukurQlKdDZW4+WEQpJjt+RWwnfSER
	 UKBrogRdveDaYTMFp0GDQQVfQYz8qKb/Feabdn8iE6eWdBgLfvMcMKpn2ro2SPa6DF
	 kH6iKHXPnA6Cw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 837/844] fgraph: Do not call handlers direct when not using ftrace_ops
Date: Sat, 28 Feb 2026 12:32:30 -0500
Message-ID: <20260228173244.1509663-838-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220916-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,efficios.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,goodmis.org:email,arm.com:email]
X-Rspamd-Queue-Id: 717431C805D
X-Rspamd-Action: no action

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit f4ff9f646a4d373f9e895c2f0073305da288bc0a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ftrace.h | 13 ++++++++++---
 kernel/trace/fgraph.c  | 12 +++++++++++-
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index fa74ae5cc9dae..d029afcd22a5d 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1064,10 +1064,17 @@ static inline bool is_ftrace_trampoline(unsigned long addr)
 
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


