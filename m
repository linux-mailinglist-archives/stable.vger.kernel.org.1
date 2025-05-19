Return-Path: <stable+bounces-144809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B10DABBE0E
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0FC7A8B03
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CD3275840;
	Mon, 19 May 2025 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IKIsGiBV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25E326D4E3
	for <stable@vger.kernel.org>; Mon, 19 May 2025 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747658270; cv=none; b=gd87B545wlvgLJs+3LfupZFPnqOZ/mYCWhaKdqn3MEZBlJE8gw5L+BDA8W/h4HlxI07Um0YTFJR0Awy6IxTL0d8/HX9M8B+zxxyvyuzTYNCvt9YGmeXZyzN/YHNvt8GGYaLw0jzolRXaR0PZfFT9YY37j4UQU7sbaBn/AJUkPQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747658270; c=relaxed/simple;
	bh=1cc0TPmUTJj9XE5IV0pzoD7HQ94+X0nD8sPgA8J8XrA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N/xjHp0DhSuVMZ8g6lghsOZ5nxCiYPHKq0vEzDutD8pXg7Vpu889yW3gw+qjogF6ZsXYUH2XgqC+4aT44lumv0HMldrhoAkKI2vILSuTdz6CdTzQaZaATeoMzCzRbywVpx70ZoJMam8r8Vej1Bi/vjJ6SL+9MapCVPpsGQvqTW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IKIsGiBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6245C4CEF0;
	Mon, 19 May 2025 12:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747658270;
	bh=1cc0TPmUTJj9XE5IV0pzoD7HQ94+X0nD8sPgA8J8XrA=;
	h=Subject:To:Cc:From:Date:From;
	b=IKIsGiBVT2/RMrNAxdoZ3ql+KCgVXBKy7e+wCVESc0GUgt+cCKZgDgBgNSfYn49cG
	 nyTDW/ctHZe+fxv/4XvQ4L73bHF3S0W8RA6moVTi3Bj7SPOr0hbTglCGp+fLmrFaxm
	 gXHEwGNYDXZnYS33xaNhpni8VK90ljqJE59QSamE=
Subject: FAILED: patch "[PATCH] ftrace: Fix preemption accounting for stacktrace filter" failed to apply to 5.4-stable tree
To: pengdonglin@xiaomi.com,dolinux.peng@gmail.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 14:37:39 +0200
Message-ID: <2025051939-front-expediter-3ddd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 11aff32439df6ca5b3b891b43032faf88f4a6a29
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051939-front-expediter-3ddd@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 11aff32439df6ca5b3b891b43032faf88f4a6a29 Mon Sep 17 00:00:00 2001
From: pengdonglin <pengdonglin@xiaomi.com>
Date: Mon, 12 May 2025 17:42:46 +0800
Subject: [PATCH] ftrace: Fix preemption accounting for stacktrace filter
 command

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


