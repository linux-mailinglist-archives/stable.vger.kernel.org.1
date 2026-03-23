Return-Path: <stable+bounces-228249-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDESCJlRwWnqSAQAu9opvQ
	(envelope-from <stable+bounces-228249-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:43:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 747512F50E4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C4FC31E724A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2574387563;
	Mon, 23 Mar 2026 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DJtUCoT4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58573B27DE;
	Mon, 23 Mar 2026 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274577; cv=none; b=Lel+WYh5GywLlGkdDM6BTYji0U+Pi749ltkXFGLzo9QF2tRHLFCLDyDHbQL8MT38PDMQ7/Eq7DKHq8PORkeeiNDiH3Jxx7k3ExLXFAfWZ7HuTR5ejhorBIfH1YN+YIp+P+PpC+kxn/ziNK7yicsaEPYT755/sM9PANuV6/SV9gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274577; c=relaxed/simple;
	bh=i01wzw7+hKCOC3hzJ9Lq5ULBvjYO928SJnDOvtZLKNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKwPII9aNYR7qubVDjQmBmApK89XcL2F3tEEd6odCaB7uDuwDDIpbRWvGfOMdpDOwEAas8HhH3R3Akh6aCcvKCakxdZt6wVNSsjNHJIJ1pO6+P/5RZCDJxJhEN6JXx/MOAUte2NJy1g5J+tjoXYEcIxSLw5TY6fxa2lFUS0mR+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DJtUCoT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA4DC4CEF7;
	Mon, 23 Mar 2026 14:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274577;
	bh=i01wzw7+hKCOC3hzJ9Lq5ULBvjYO928SJnDOvtZLKNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DJtUCoT4JeR1trmyFM19v67HImtTdwDqYApoU0DN3IolCGF3k/OdIZEcYL8lO3vqh
	 kp45AS8D0Yqbq2oX1N9DsWn9+eTcMY9NCzyfBIIiaDPIhk981Pi/auWUBzjbQNoaKs
	 51rfw9f8mqpoAtP9NFErnIDvDxetCWjJ8/7k8ncc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Shengming Hu <hu.shengming@zte.com.cn>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 042/212] fgraph: Fix thresh_return nosleeptime double-adjust
Date: Mon, 23 Mar 2026 14:44:23 +0100
Message-ID: <20260323134505.097517677@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228249-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 747512F50E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shengming Hu <hu.shengming@zte.com.cn>

[ Upstream commit b96d0c59cdbb2a22b2545f6f3d5c6276b05761dd ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_functions_graph.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -378,9 +378,14 @@ static void trace_graph_thresh_return(st
 				      struct fgraph_ops *gops,
 				      struct ftrace_regs *fregs)
 {
+	struct trace_array *tr = gops->private;
 	struct fgraph_times *ftimes;
+	unsigned int trace_ctx;
+	u64 calltime, rettime;
 	int size;
 
+	rettime = trace_clock_local();
+
 	ftrace_graph_addr_finish(gops, trace);
 
 	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT)) {
@@ -394,11 +399,13 @@ static void trace_graph_thresh_return(st
 
 	handle_nosleeptime(trace, ftimes, size);
 
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



