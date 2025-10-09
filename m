Return-Path: <stable+bounces-183714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A689BC9BD3
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 17:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5BF84E1481
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 15:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0117F1E0E14;
	Thu,  9 Oct 2025 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AixpemUv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEB31DED49;
	Thu,  9 Oct 2025 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023460; cv=none; b=mFjVU09L7Y5SktQ6QIrraUHRDxNGMypPA1yxSDEMVfhpkbF6fyXNOS2/C33WDE1bzCRtWZ/h9t8lstR5C4v0v4KRr6QNcsoGOdRS9VrDbIyPSxK/kfoBVgNFUEsdTMmLapNEua+heDsEC0ikYAVKSSWABEYiAA6DZbo2HC8KAko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023460; c=relaxed/simple;
	bh=1Y0Od/59Zu1UrtLmqOIhDT1IqNj+kYPGue1ekRxCScA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BE6G5fcmFI8ANs43HlfEt8EPfg8GyrUzWwXRJjdf4fCB0ondXkgaS5lY5HPEzKouktCoBxeQJ6kr5X7ujcVnG15WsKQJvnLdBP7xV56YSd7hO7QEhVt3UeobfvVLIEWZLdL5+uWpWKG6qz3W3MS0WqMtxZ27/88iGzS4l3ucnjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AixpemUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D78C4AF09;
	Thu,  9 Oct 2025 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760023460;
	bh=1Y0Od/59Zu1UrtLmqOIhDT1IqNj+kYPGue1ekRxCScA=;
	h=Date:From:To:Cc:Subject:References:From;
	b=AixpemUvpzPp56vbYZAgADGuDORAsDPeGR28al9RrZKwMrc5DjxmFIfVvKPrW0FH2
	 cJpr1DhLsEshY/ufG8eqEBNMyz9ErobvLvt8ax6f3veaLCQqtpX56LA0uJduhUJox8
	 10wQNMenzY8YCxMye3UIJjfSi/CaQPSZ21bWBcUJ9qlfulc+n6PrCOe6l20QLcKbMu
	 6iQEEoiyI4VxcrZD7r41ZaeGpml6hmKkG+qnOmNMMHb+6ARAEUGWbGNF7uoBWrFzTr
	 RDunRwUXj8lfbAFo3DDSnQnakiXSLj0DZ0SvtAPbDD5QukZk+mfzdQ4gVCMqvyqIhe
	 L/xKFhc+ghwDw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v6sVA-00000000Bd0-3kTC;
	Thu, 09 Oct 2025 11:24:20 -0400
Message-ID: <20251009152420.751067844@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 09 Oct 2025 11:24:01 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
Subject: [for-linus][PATCH 2/5] tracing: Fix wakeup tracers on failure of acquiring calltime
References: <20251009152359.604267051@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The functions wakeup_graph_entry() and wakeup_graph_return() both call
func_prolog_preempt_disable() that will test if the data->disable is
already set and if not, increment it and disable preemption. If it was
set, it returns false and the caller exits.

The caller of this function must decrement the disable counter, but misses
doing so if the calltime fails to be acquired.

Instead of exiting out when calltime is NULL, change the logic to do the
work if it is not NULL and still do the clean up at the end of the
function if it is NULL.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20251008114835.027b878a@gandalf.local.home
Fixes: a485ea9e3ef3 ("tracing: Fix irqsoff and wakeup latency tracers when using function graph")
Reported-by: Sasha Levin <sashal@kernel.org>
Closes: https://lore.kernel.org/linux-trace-kernel/20251006175848.1906912-1-sashal@kernel.org/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_sched_wakeup.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index bf1cb80742ae..e3f2e4f56faa 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -138,12 +138,10 @@ static int wakeup_graph_entry(struct ftrace_graph_ent *trace,
 		return 0;
 
 	calltime = fgraph_reserve_data(gops->idx, sizeof(*calltime));
-	if (!calltime)
-		return 0;
-
-	*calltime = trace_clock_local();
-
-	ret = __trace_graph_entry(tr, trace, trace_ctx);
+	if (calltime) {
+		*calltime = trace_clock_local();
+		ret = __trace_graph_entry(tr, trace, trace_ctx);
+	}
 	local_dec(&data->disabled);
 	preempt_enable_notrace();
 
@@ -169,12 +167,10 @@ static void wakeup_graph_return(struct ftrace_graph_ret *trace,
 	rettime = trace_clock_local();
 
 	calltime = fgraph_retrieve_data(gops->idx, &size);
-	if (!calltime)
-		return;
+	if (calltime)
+		__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
 
-	__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
 	local_dec(&data->disabled);
-
 	preempt_enable_notrace();
 	return;
 }
-- 
2.51.0



