Return-Path: <stable+bounces-125980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE9CA6E597
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 22:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056C93A8409
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 21:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBF11DED49;
	Mon, 24 Mar 2025 21:17:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBDA1DE2A6;
	Mon, 24 Mar 2025 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742851075; cv=none; b=nTxTo+XuwYCKMYKmLJYbGd13q5nuJi87sBXKJQ4+73tYAfueH2QLgYn85z6sM1Z4ECAMILAeyayAVlJhRKGhMXY077Ej8N6wLBAlJi2CZF+C6/6/qCMpGuT2EXKEipjqJUWylXcUe3wzcJuKcws6PLCbAS6velsGLahtT0Q7CJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742851075; c=relaxed/simple;
	bh=/7xUjyQ71qt6xLI7T22mNaf0aqdpgvoYzL/3hPcOD7Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mKcY2hi7C0TGeWbB7op9V7qhgX/xJoo54iyoXUpAKpkV9SYw+RWDqcY69BK1+jRzAJiZV1bMohxCu+Gy10qz7XXecz+6w9VFgNVJSR6UalPxT2XvqTkReFMGP8L7+MgYCKpUfpSXNRSuAICdBXaNJwjarVxAOxxpO4UfpwBBVZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BA7C4CEED;
	Mon, 24 Mar 2025 21:17:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1twpBt-00000002AdK-24HW;
	Mon, 24 Mar 2025 17:18:37 -0400
Message-ID: <20250324211837.344696769@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 24 Mar 2025 17:18:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Zheng Yejian <zhengyejian1@huawei.com>,
 Kairui Song <kasong@tencent.com>,
 Tengda Wu <wutengda@huaweicloud.com>
Subject: [for-next][PATCH 2/3] tracing: Fix use-after-free in print_graph_function_flags during
 tracer switching
References: <20250324211821.731702961@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tengda Wu <wutengda@huaweicloud.com>

Kairui reported a UAF issue in print_graph_function_flags() during
ftrace stress testing [1]. This issue can be reproduced if puting a
'mdelay(10)' after 'mutex_unlock(&trace_types_lock)' in s_start(),
and executing the following script:

  $ echo function_graph > current_tracer
  $ cat trace > /dev/null &
  $ sleep 5  # Ensure the 'cat' reaches the 'mdelay(10)' point
  $ echo timerlat > current_tracer

The root cause lies in the two calls to print_graph_function_flags
within print_trace_line during each s_show():

  * One through 'iter->trace->print_line()';
  * Another through 'event->funcs->trace()', which is hidden in
    print_trace_fmt() before print_trace_line returns.

Tracer switching only updates the former, while the latter continues
to use the print_line function of the old tracer, which in the script
above is print_graph_function_flags.

Moreover, when switching from the 'function_graph' tracer to the
'timerlat' tracer, s_start only calls graph_trace_close of the
'function_graph' tracer to free 'iter->private', but does not set
it to NULL. This provides an opportunity for 'event->funcs->trace()'
to use an invalid 'iter->private'.

To fix this issue, set 'iter->private' to NULL immediately after
freeing it in graph_trace_close(), ensuring that an invalid pointer
is not passed to other tracers. Additionally, clean up the unnecessary
'iter->private = NULL' during each 'cat trace' when using wakeup and
irqsoff tracers.

 [1] https://lore.kernel.org/all/20231112150030.84609-1-ryncsn@gmail.com/

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Zheng Yejian <zhengyejian1@huawei.com>
Link: https://lore.kernel.org/20250320122137.23635-1-wutengda@huaweicloud.com
Fixes: eecb91b9f98d ("tracing: Fix memleak due to race between current_tracer and trace")
Closes: https://lore.kernel.org/all/CAMgjq7BW79KDSCyp+tZHjShSzHsScSiJxn5ffskp-QzVM06fxw@mail.gmail.com/
Reported-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 1 +
 kernel/trace/trace_irqsoff.c         | 2 --
 kernel/trace/trace_sched_wakeup.c    | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index ed61ff719aa4..2f077d4158e5 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -1611,6 +1611,7 @@ void graph_trace_close(struct trace_iterator *iter)
 	if (data) {
 		free_percpu(data->cpu_data);
 		kfree(data);
+		iter->private = NULL;
 	}
 }
 
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index c8bfa7310a91..40c39e946940 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -250,8 +250,6 @@ static void irqsoff_trace_open(struct trace_iterator *iter)
 {
 	if (is_graph(iter->tr))
 		graph_trace_open(iter);
-	else
-		iter->private = NULL;
 }
 
 static void irqsoff_trace_close(struct trace_iterator *iter)
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index c9ba4259e03e..a0db3404f7f7 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -188,8 +188,6 @@ static void wakeup_trace_open(struct trace_iterator *iter)
 {
 	if (is_graph(iter->tr))
 		graph_trace_open(iter);
-	else
-		iter->private = NULL;
 }
 
 static void wakeup_trace_close(struct trace_iterator *iter)
-- 
2.47.2



