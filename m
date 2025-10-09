Return-Path: <stable+bounces-183716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB70BC9BD9
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 17:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23F044E3548
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC401E2307;
	Thu,  9 Oct 2025 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQyinkCl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C822A1DEFE8;
	Thu,  9 Oct 2025 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023460; cv=none; b=te3DTI0QeFyoJ7NYyGe+d+zgJKQuYqqyHGgBGZtlMRMdhpyOR5++fJ0mrqCV7Mi/MNVMLQe9yvwY/cBzX41lrwYyTmmo2ARuu/oFyLJHmgg+jUJ3v1p3irRQvNe2Y96WwCE0/xnBSU829d/J4aBIaf9FzydARkGBwraN1v+qFAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023460; c=relaxed/simple;
	bh=I86A0fe87JOXmldNxDNMnzYDIsvvi8u+ypJiMen65zM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=SHaU4y8Ed4VO6s4wb3hGrsPFSFD3sHjxOGNuf+GBs3tEI0wddQvPhFNMx9uusewZGXAOChFFr6hRdKP0k+kacg/ihrnKjGmWrutepA1YjYkcDJrq9FoRlzJKlF6HCY2gopqMDN+K9cjIY1wR2DePoD5OuZenLZdyy5X2jKjxZ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQyinkCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D695C116B1;
	Thu,  9 Oct 2025 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760023460;
	bh=I86A0fe87JOXmldNxDNMnzYDIsvvi8u+ypJiMen65zM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=BQyinkClFf6MtgevKzDyxpHc1OFo4TC5+bsxWLkvjQWALJsAAcUfaVZJzOI86goo6
	 SntLxJHN+3x5Keca+LRy05wWwX7cA0OwWZwnKTpb0gbk77RKqBGuNAyzLbtdy7fQTl
	 fYeyN2THJ49SMfcze2x/vE+VomaGpjU0XGCyxx1fOHh29lgQ5B3IJSLnNLnECrBy1r
	 uGGcMniMUGm3FK2SwDxcEJIlDb4T+5q2QHbCKGLi/nKD3bGFeSBs20zHhC2txYSCkc
	 8ShnSYYjL8kYHIOY6WhdJ5H6uoDX3vWvePiV2JnyOYyxTUQz8QE5xw0/3yUrKU/bqE
	 thbfbMQdMJ3zg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v6sVB-00000000BdU-0H6r;
	Thu, 09 Oct 2025 11:24:21 -0400
Message-ID: <20251009152420.913227393@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 09 Oct 2025 11:24:02 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
Subject: [for-linus][PATCH 3/5] tracing: Fix irqoff tracers on failure of acquiring calltime
References: <20251009152359.604267051@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The functions irqsoff_graph_entry() and irqsoff_graph_return() both call
func_prolog_dec() that will test if the data->disable is already set and
if not, increment it and return. If it was set, it returns false and the
caller exits.

The caller of this function must decrement the disable counter, but misses
doing so if the calltime fails to be acquired.

Instead of exiting out when calltime is NULL, change the logic to do the
work if it is not NULL and still do the clean up at the end of the
function if it is NULL.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20251008114943.6f60f30f@gandalf.local.home
Fixes: a485ea9e3ef3 ("tracing: Fix irqsoff and wakeup latency tracers when using function graph")
Reported-by: Sasha Levin <sashal@kernel.org>
Closes: https://lore.kernel.org/linux-trace-kernel/20251006175848.1906912-2-sashal@kernel.org/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_irqsoff.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 5496758b6c76..4c45c49b06c8 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -184,7 +184,7 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
 	unsigned long flags;
 	unsigned int trace_ctx;
 	u64 *calltime;
-	int ret;
+	int ret = 0;
 
 	if (ftrace_graph_ignore_func(gops, trace))
 		return 0;
@@ -202,13 +202,11 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
 		return 0;
 
 	calltime = fgraph_reserve_data(gops->idx, sizeof(*calltime));
-	if (!calltime)
-		return 0;
-
-	*calltime = trace_clock_local();
-
-	trace_ctx = tracing_gen_ctx_flags(flags);
-	ret = __trace_graph_entry(tr, trace, trace_ctx);
+	if (calltime) {
+		*calltime = trace_clock_local();
+		trace_ctx = tracing_gen_ctx_flags(flags);
+		ret = __trace_graph_entry(tr, trace, trace_ctx);
+	}
 	local_dec(&data->disabled);
 
 	return ret;
@@ -233,11 +231,10 @@ static void irqsoff_graph_return(struct ftrace_graph_ret *trace,
 
 	rettime = trace_clock_local();
 	calltime = fgraph_retrieve_data(gops->idx, &size);
-	if (!calltime)
-		return;
-
-	trace_ctx = tracing_gen_ctx_flags(flags);
-	__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
+	if (calltime) {
+		trace_ctx = tracing_gen_ctx_flags(flags);
+		__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
+	}
 	local_dec(&data->disabled);
 }
 
-- 
2.51.0



