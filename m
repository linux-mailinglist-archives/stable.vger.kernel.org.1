Return-Path: <stable+bounces-144379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E534AB6CF3
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 15:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 677167ABC7D
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 13:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C502D27B4ED;
	Wed, 14 May 2025 13:39:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9301F27A93D;
	Wed, 14 May 2025 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229953; cv=none; b=R84PmKz8bbBM7hKTn70W2Z6D0UXdt9FFR8AT1b6Ih8PNL3NchwZ8ABfzizoL1ge0gL1f9BnsX5I3R/KELSZwLrYlD4/GbPVMbvLNMPD0iE4wyndAz8kgS7ynvSJTgA+qLMWbhgx2rqX4I9g4USoy6GSxZ3CnkYCZO8dg1+yG1cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229953; c=relaxed/simple;
	bh=qbwUGFv1DkuSVC49ZkVjHRjYMnyc2G0IE7s8hrins3I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KTVkX53MJBD8k8uJIks0qSQd1+dl/fklVdnO84mdukNJClZS2cqV7yd8nWS6jRlc5+ygOj/RO0fnhu26001T+P+9Yjx/87vTW0mmjQiDzx01HVrohFwogwE4rgTJ3MARvE9xs+td4BT68i9l/w2QyYDXlNG96JF/RbyPR06E+5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFDDC4CEF0;
	Wed, 14 May 2025 13:39:13 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uFCKi-00000005IFw-2kmN;
	Wed, 14 May 2025 09:39:40 -0400
Message-ID: <20250514133940.513093734@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 14 May 2025 09:38:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 pengdonglin <dolinux.peng@gmail.com>
Subject: [for-linus][PATCH 3/4] ftrace: Fix preemption accounting for stacktrace filter command
References: <20250514133831.110736154@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: pengdonglin <pengdonglin@xiaomi.com>

The preemption count of the stacktrace filter command to trace ksys_read
is consistently incorrect:

$ echo ksys_read:stacktrace > set_ftrace_filter

   <...>-453     [004] ...1.    38.308956: <stack trace>
=> ksys_read
=> do_syscall_64
=> entry_SYSCALL_64_after_hwframe

The root cause is that the trace framework disables preemption when
invoking the filter command callback in function_trace_probe_call:

   preempt_disable_notrace();
   probe_ops->func(ip, parent_ip, probe_opsbe->tr, probe_ops, probe->data);
   preempt_enable_notrace();

Use tracing_gen_ctx_dec() to account for the preempt_disable_notrace(),
which will output the correct preemption count:

$ echo ksys_read:stacktrace > set_ftrace_filter

   <...>-410     [006] .....    31.420396: <stack trace>
=> ksys_read
=> do_syscall_64
=> entry_SYSCALL_64_after_hwframe

Cc: stable@vger.kernel.org
Fixes: 36590c50b2d07 ("tracing: Merge irqflags + preempt counter.")
Link: https://lore.kernel.org/20250512094246.1167956-2-dolinux.peng@gmail.com
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 98ccf3f00c51..4e37a0f6aaa3 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -633,11 +633,7 @@ ftrace_traceoff(unsigned long ip, unsigned long parent_ip,
 
 static __always_inline void trace_stack(struct trace_array *tr)
 {
-	unsigned int trace_ctx;
-
-	trace_ctx = tracing_gen_ctx();
-
-	__trace_stack(tr, trace_ctx, FTRACE_STACK_SKIP);
+	__trace_stack(tr, tracing_gen_ctx_dec(), FTRACE_STACK_SKIP);
 }
 
 static void
-- 
2.47.2



