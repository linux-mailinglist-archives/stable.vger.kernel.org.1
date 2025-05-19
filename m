Return-Path: <stable+bounces-144808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1515BABBE0D
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A24189DF22
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC25278E5D;
	Mon, 19 May 2025 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vNP+baHC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C17226D4E3
	for <stable@vger.kernel.org>; Mon, 19 May 2025 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747658261; cv=none; b=mGN8ZCSXC4aChGEFJnQUK3yJkJd/56rYzNCS7PSdz6p0CC99K5LYhqAS3uvHpraYZfhaaLf3KXjVA8UOG/mMl6FSYcqlFT0wYPcdqIg00hEpCKdYjAjf0xb8J2w1pLtpyxGFbNB/9tz8mOHRVGayZqmAcWdXlWDkElVUb5+5htI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747658261; c=relaxed/simple;
	bh=1nLwIKDmsuJmqE8zxyepsQztMs6FvxrWiXNrVJZVlNw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UDNrrMY+cKkjv3XpoJB9Nis9i0AA0sSMMP9kSr/mqJEVHaB/pwzFJysKZnY+FcwgwyZtyKTlbcvlk7FKDEmpbR2Ytrd0yXeufYcC2AKEFrw/gaRUuYBw4LghjCB9NQx/TtQl6TXUQr88JNHmWoOVpia5jBL/vtF/s/fD4JmqNOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vNP+baHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF74C4CEE4;
	Mon, 19 May 2025 12:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747658261;
	bh=1nLwIKDmsuJmqE8zxyepsQztMs6FvxrWiXNrVJZVlNw=;
	h=Subject:To:Cc:From:Date:From;
	b=vNP+baHCh6MUK+jTSLB9ZYWQjH5wWQHmcBDpaZL2y0g4vap5EfFFZlUSrudZx35cc
	 +zu8cE+9rV3UkwbBClTFnAf6D4sspB9cGsgy4dWdPmuV82X3mvKPdekRBcR+ZzzAko
	 AtUGp5Ovq+uc36hssZTRg75GeGmqh4Jg+rzAcWAA=
Subject: FAILED: patch "[PATCH] ftrace: Fix preemption accounting for stacktrace filter" failed to apply to 5.10-stable tree
To: pengdonglin@xiaomi.com,dolinux.peng@gmail.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 14:37:38 +0200
Message-ID: <2025051938-tweezers-vendor-8ef7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 11aff32439df6ca5b3b891b43032faf88f4a6a29
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051938-tweezers-vendor-8ef7@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


