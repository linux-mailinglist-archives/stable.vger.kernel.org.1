Return-Path: <stable+bounces-272170-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LH1xAX1/S2qWSQEAu9opvQ
	(envelope-from <stable+bounces-272170-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 12:12:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 806EA70EF43
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 12:12:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=dmaygNQU;
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272170-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272170-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B777303E51A
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 10:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8833FCB1F;
	Mon,  6 Jul 2026 09:55:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57976431498;
	Mon,  6 Jul 2026 09:55:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331716; cv=none; b=q6ncUgz9ynKdFcUoMPIbfoPCaiQqLFFK2hkRigjKeE8J6Uh6ArvJ1twSf5goGC0DusZWWHZLad/Vv6mYXfGhm9AiqTmS1EITgoIKLfVOBjZv4xEioppeUkBgHppgRQ4NpjL517xqIl/dr8shrRaFq2DsotIx+gTcvd5z8L9GBrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331716; c=relaxed/simple;
	bh=Eripl9vQSxPv4KujcVDrZN3otdTYf43Zp+lcUYKnkJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FwcUahXrPOYqnYLFqgGJc4HRntVRNXKi8+4mUtBiLI5xvv2ARtPFoPncklwE0JWZqI+2Pn3fD9bBsNcQndWL1S3L36x64vIQNxKy/LAMJWKiVV+TkyvWIJtEqpDvA//xxCKopuw5p4fJ/zpXPhi2wdJmdTkJXylt2esAUc0qfrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dmaygNQU; arc=none smtp.client-ip=115.124.30.119
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783331700; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xfq7F+Q8AODgLh3MJ/odHv+Zcpwf/BRIqVh6hDn9FRM=;
	b=dmaygNQUYmfsvc2psUVm56qN+N/JgE/LNevEphYXQ4RIR8PqX46SP1COh6NWrB2pl/H5grm4HebyjEoqS1swxTRs5FNyGqbl6yPky6/awcqeKxloCy6du6j92XwSA6ATpVYEERNtG9UnJkVESwyVa87uRKjIt2iUyXP3eoXd0J0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X6UFuet_1783331687;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0X6UFuet_1783331687 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 06 Jul 2026 17:54:59 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H . Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuanhe Shu <xiangzao@linux.alibaba.com>
Subject: [PATCH] x86/stacktrace: Mark arch_stack_walk() and unwinder functions notrace
Date: Mon,  6 Jul 2026 17:54:45 +0800
Message-Id: <20260706095445.1683434-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[xiangzao@linux.alibaba.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jpoimboe@kernel.org,m:peterz@infradead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:xiangzao@linux.alibaba.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-272170-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiangzao@linux.alibaba.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 806EA70EF43

When the function tracer's func_stack_trace option and the function graph
profiler (function_profile_enabled) are both active, a recursive ftrace
reentrance can occur, leading to a hard lockup. This was observed during
ftrace selftest (ftracetest-ktap) execution:

  watchdog: Watchdog detected hard LOCKUP on cpu 204
  RIP: profile_graph_entry+0xa0/0x160
  Call Trace:
   function_graph_enter+0xc9/0x120
   arch_ftrace_ops_list_func+0x112/0x230
   ftrace_call+0x5/0x44
   unwind_next_frame+0x5/0x870     <-- traced by ftrace
   arch_stack_walk+0x88/0xf0
   stack_trace_save+0x4b/0x70
   __ftrace_trace_stack+0x12e/0x170
   function_stack_trace_call+0x7c/0xa0
   arch_ftrace_ops_list_func+0x112/0x230
   ftrace_call+0x5/0x44
   irqtime_account_irq+0x5/0xb0
   __irq_exit_rcu+0x12/0xc0
   ...

The root cause is a recursive ftrace reentrance:
function_stack_trace_call() invokes __trace_stack() ->
arch_stack_walk() -> unwind_next_frame() to capture a backtrace.
Since the unwinder functions (__unwind_start(),
unwind_next_frame(), unwind_get_return_address(),
unwind_get_return_address_ptr()) are not marked notrace, the
function graph tracer instruments them, re-entering the ftrace
infrastructure from within an ftrace callback. This results in a
hard lockup with interrupts disabled, detected by the watchdog NMI.

On arm64 and riscv, arch_stack_walk() has already been marked
noinstr to prevent this class of bugs. See
commit 0fbcd8abf337 ("arm64: Prohibit instrumentation on arch_stack_walk()")
and commit 23b2188920a2 ("riscv: stacktrace: convert arch_stack_walk() to noinstr").
However, x86 was not fixed because:

 1) x86's return_address() uses the generic
    __builtin_return_address() instead of arch_stack_walk(), so the
    lockdep recursion path that triggered the arm64 fix does not
    exist on x86.

 2) On arm64, all unwinder helpers are __always_inline within
    arch_stack_walk(), so a single noinstr annotation suffices.
    On riscv, the helper walk_stackframe() was already marked
    notrace. On x86 however, the ORC unwinder implements
    __unwind_start(), unwind_next_frame(), and
    unwind_get_return_address() as separate non-inline exported
    functions without any instrumentation protection, so marking
    only arch_stack_walk() is insufficient.

Fix this by marking arch_stack_walk() and the non-inline unwinder
functions it calls (__unwind_start(), unwind_next_frame(),
unwind_get_return_address(), unwind_get_return_address_ptr())
as notrace, preventing ftrace from instrumenting the entire stack
unwinding path.

Fixes: 3599fe12a125 ("x86/stacktrace: Use common infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
 arch/x86/include/asm/unwind.h  | 10 +++++-----
 arch/x86/kernel/stacktrace.c   | 12 ++++++++++--
 arch/x86/kernel/unwind_frame.c | 10 +++++-----
 arch/x86/kernel/unwind_guess.c | 10 +++++-----
 arch/x86/kernel/unwind_orc.c   | 10 +++++-----
 5 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
index 7cede4dc21f0..15b699f2edc0 100644
--- a/arch/x86/include/asm/unwind.h
+++ b/arch/x86/include/asm/unwind.h
@@ -39,11 +39,11 @@ struct unwind_state {
 #endif
 };
 
-void __unwind_start(struct unwind_state *state, struct task_struct *task,
-		    struct pt_regs *regs, unsigned long *first_frame);
-bool unwind_next_frame(struct unwind_state *state);
-unsigned long unwind_get_return_address(struct unwind_state *state);
-unsigned long *unwind_get_return_address_ptr(struct unwind_state *state);
+void notrace __unwind_start(struct unwind_state *state, struct task_struct *task,
+			    struct pt_regs *regs, unsigned long *first_frame);
+bool notrace unwind_next_frame(struct unwind_state *state);
+unsigned long notrace unwind_get_return_address(struct unwind_state *state);
+unsigned long *notrace unwind_get_return_address_ptr(struct unwind_state *state);
 
 static inline bool unwind_done(struct unwind_state *state)
 {
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index ee117fcf46ed..1e5a06439adb 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -12,8 +12,16 @@
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
 
-void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
-		     struct task_struct *task, struct pt_regs *regs)
+/*
+ * arch_stack_walk() and the functions it calls (__unwind_start(),
+ * unwind_next_frame(), unwind_get_return_address(),
+ * unwind_get_return_address_ptr()) must not be instrumented by ftrace,
+ * as they are invoked from within ftrace callbacks (e.g.,
+ * function_stack_trace_call). Tracing these functions would cause
+ * recursive ftrace reentrance, leading to a hard lockup.
+ */
+void notrace arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
+			     struct task_struct *task, struct pt_regs *regs)
 {
 	struct unwind_state state;
 	unsigned long addr;
diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index d8ba93778ae3..07d1b9f0208f 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -11,7 +11,7 @@
 
 #define FRAME_HEADER_SIZE (sizeof(long) * 2)
 
-unsigned long unwind_get_return_address(struct unwind_state *state)
+unsigned long notrace unwind_get_return_address(struct unwind_state *state)
 {
 	if (unwind_done(state))
 		return 0;
@@ -20,7 +20,7 @@ unsigned long unwind_get_return_address(struct unwind_state *state)
 }
 EXPORT_SYMBOL_GPL(unwind_get_return_address);
 
-unsigned long *unwind_get_return_address_ptr(struct unwind_state *state)
+unsigned long *notrace unwind_get_return_address_ptr(struct unwind_state *state)
 {
 	if (unwind_done(state))
 		return NULL;
@@ -261,7 +261,7 @@ static bool update_stack_state(struct unwind_state *state,
 }
 
 __no_kmsan_checks
-bool unwind_next_frame(struct unwind_state *state)
+bool notrace unwind_next_frame(struct unwind_state *state)
 {
 	struct pt_regs *regs;
 	unsigned long *next_bp;
@@ -370,8 +370,8 @@ bool unwind_next_frame(struct unwind_state *state)
 }
 EXPORT_SYMBOL_GPL(unwind_next_frame);
 
-void __unwind_start(struct unwind_state *state, struct task_struct *task,
-		    struct pt_regs *regs, unsigned long *first_frame)
+void notrace __unwind_start(struct unwind_state *state, struct task_struct *task,
+			    struct pt_regs *regs, unsigned long *first_frame)
 {
 	unsigned long *bp;
 
diff --git a/arch/x86/kernel/unwind_guess.c b/arch/x86/kernel/unwind_guess.c
index 884d68a6e714..22d12e79984b 100644
--- a/arch/x86/kernel/unwind_guess.c
+++ b/arch/x86/kernel/unwind_guess.c
@@ -6,7 +6,7 @@
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
 
-unsigned long unwind_get_return_address(struct unwind_state *state)
+unsigned long notrace unwind_get_return_address(struct unwind_state *state)
 {
 	unsigned long addr;
 
@@ -19,12 +19,12 @@ unsigned long unwind_get_return_address(struct unwind_state *state)
 }
 EXPORT_SYMBOL_GPL(unwind_get_return_address);
 
-unsigned long *unwind_get_return_address_ptr(struct unwind_state *state)
+unsigned long *notrace unwind_get_return_address_ptr(struct unwind_state *state)
 {
 	return NULL;
 }
 
-bool unwind_next_frame(struct unwind_state *state)
+bool notrace unwind_next_frame(struct unwind_state *state)
 {
 	struct stack_info *info = &state->stack_info;
 
@@ -48,8 +48,8 @@ bool unwind_next_frame(struct unwind_state *state)
 }
 EXPORT_SYMBOL_GPL(unwind_next_frame);
 
-void __unwind_start(struct unwind_state *state, struct task_struct *task,
-		    struct pt_regs *regs, unsigned long *first_frame)
+void notrace __unwind_start(struct unwind_state *state, struct task_struct *task,
+			    struct pt_regs *regs, unsigned long *first_frame)
 {
 	memset(state, 0, sizeof(*state));
 
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 6407bc9256bf..f2a450ee66e6 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -377,7 +377,7 @@ void __init unwind_init(void)
 	orc_init = true;
 }
 
-unsigned long unwind_get_return_address(struct unwind_state *state)
+unsigned long notrace unwind_get_return_address(struct unwind_state *state)
 {
 	if (unwind_done(state))
 		return 0;
@@ -386,7 +386,7 @@ unsigned long unwind_get_return_address(struct unwind_state *state)
 }
 EXPORT_SYMBOL_GPL(unwind_get_return_address);
 
-unsigned long *unwind_get_return_address_ptr(struct unwind_state *state)
+unsigned long *notrace unwind_get_return_address_ptr(struct unwind_state *state)
 {
 	if (unwind_done(state))
 		return NULL;
@@ -481,7 +481,7 @@ static bool get_reg(struct unwind_state *state, unsigned int reg_off,
 	return false;
 }
 
-bool unwind_next_frame(struct unwind_state *state)
+bool notrace unwind_next_frame(struct unwind_state *state)
 {
 	unsigned long ip_p, sp, tmp, orig_ip = state->ip, prev_sp = state->sp;
 	enum stack_type prev_type = state->stack_info.type;
@@ -709,8 +709,8 @@ bool unwind_next_frame(struct unwind_state *state)
 }
 EXPORT_SYMBOL_GPL(unwind_next_frame);
 
-void __unwind_start(struct unwind_state *state, struct task_struct *task,
-		    struct pt_regs *regs, unsigned long *first_frame)
+void notrace __unwind_start(struct unwind_state *state, struct task_struct *task,
+			    struct pt_regs *regs, unsigned long *first_frame)
 {
 	memset(state, 0, sizeof(*state));
 	state->task = task;
-- 
2.39.3


