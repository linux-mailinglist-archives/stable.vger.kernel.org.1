Return-Path: <stable+bounces-223143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QObPEweuqGmfwQAAu9opvQ
	(envelope-from <stable+bounces-223143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 23:11:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A794720855B
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 23:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31D6D3124950
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 22:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045C43D6CC2;
	Wed,  4 Mar 2026 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXsbM/8O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B835A3D75AE;
	Wed,  4 Mar 2026 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661780; cv=none; b=V6GlZsz+cnwFq56jNyV7V+S66ZJJJA1L6sBysDLJV2OuxhmECySPEqsNn1r3Sks1N6lPezpcdbItQEBtOJPrrpkFJhJMmy1p4Ltz9VP7cgZU4ZtN/uuujwxDC4YRSaHTsux2dKb3bzjpz4LflPkH58uyedAsGq6OjLVwA4yc04c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661780; c=relaxed/simple;
	bh=JtVyn/J1VepzhDKxVBAvYJ/BmMmBffLK0UXbcjin1T8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BzvgEpmAd/FzmiNiCR/BZg2ixI3srSq7sHbZYoTkaEL3nbhcRg3yw+1Z5llf6buWCRNlFmQ26iv3FM+ZLmi6CDqvod219WUdVm6iNlmG9bjVm2jk8Cv8YBL1t3sdYJ+er0092h/bUJdKvQafArbBczuO1DtU/dQPxJFYP/Fi2x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXsbM/8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E03BC2BCAF;
	Wed,  4 Mar 2026 22:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661780;
	bh=JtVyn/J1VepzhDKxVBAvYJ/BmMmBffLK0UXbcjin1T8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=oXsbM/8OCJ2loOoypdiN6faEHTN3RQPgJ+qxtJAqFrbUO6K7BTT9/vvvNwX2BVgal
	 VfYuhhkUlmfSI2/T+05ZtnR/WsFd513QabKX0ZoQdgkMEJdKpTvVJXCLcQTfO896jK
	 KzhqPJ+HNWMnOO6eIWSoSfYFtLJrWR0Uc3ow8fvmflk2FjUyFvQvr9CPD/MNwWwpdn
	 J1XDNCZ+EP4RnSyylzNjox01e+nsE5HFnmxIL5znblKJV76Q76cxawOj0ZyHIJ3Kaf
	 9eSjV7+e/bvYpKZHdnPc+faQIkuLArBtNdl4CZOioqjmS0jJWwtOcCMEpTbH3fNMZJ
	 2zrCZIMpwF3Vg==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vxuJd-00000003CRH-2pWg;
	Wed, 04 Mar 2026 17:03:37 -0500
Message-ID: <20260304220337.531696199@kernel.org>
User-Agent: quilt/0.69
Date: Wed, 04 Mar 2026 17:03:21 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Shengming Hu <hu.shengming@zte.com.cn>
Subject: [for-linus][PATCH 2/6] fgraph: Fix thresh_return nosleeptime double-adjust
References: <20260304220319.218314827@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: A794720855B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223143-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,zte.com.cn:email,goodmis.org:email,msgid.link:url]
X-Rspamd-Action: no action

From: Shengming Hu <hu.shengming@zte.com.cn>

trace_graph_thresh_return() called handle_nosleeptime() and then delegated
to trace_graph_return(), which calls handle_nosleeptime() again. When
sleep-time accounting is disabled this double-adjusts calltime and can
produce bogus durations (including underflow).

Fix this by computing rettime once, applying handle_nosleeptime() only
once, using the adjusted calltime for threshold comparison, and writing
the return event directly via __trace_graph_return() when the threshold is
met.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260221113314048jE4VRwIyZEALiYByGK0My@zte.com.cn
Fixes: 3c9880f3ab52b ("ftrace: Use a running sleeptime instead of saving on shadow stack")
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 817d0f1696b6..0d2d3a2ea7dd 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -403,8 +403,12 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct fgraph_times *ftimes;
 	struct trace_array *tr;
+	unsigned int trace_ctx;
+	u64 calltime, rettime;
 	int size;
 
+	rettime = trace_clock_local();
+
 	ftrace_graph_addr_finish(gops, trace);
 
 	if (*task_var & TRACE_GRAPH_NOTRACE) {
@@ -419,11 +423,13 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 	tr = gops->private;
 	handle_nosleeptime(tr, trace, ftimes, size);
 
-	if (tracing_thresh &&
-	    (trace_clock_local() - ftimes->calltime < tracing_thresh))
+	calltime = ftimes->calltime;
+
+	if (tracing_thresh && (rettime - calltime < tracing_thresh))
 		return;
-	else
-		trace_graph_return(trace, gops, fregs);
+
+	trace_ctx = tracing_gen_ctx();
+	__trace_graph_return(tr, trace, trace_ctx, calltime, rettime);
 }
 
 static struct fgraph_ops funcgraph_ops = {
-- 
2.51.0



