Return-Path: <stable+bounces-227065-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK8XGxqlummaaAIAu9opvQ
	(envelope-from <stable+bounces-227065-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 14:14:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 771DE2BC03A
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 14:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 990963008D04
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 13:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5AE3B894E;
	Wed, 18 Mar 2026 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1MswW95"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECC53793BA
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773839636; cv=none; b=Q4wHckZE2PqZ4YVYyScYnvZ7Los10JpNn4Ow29t490dU6eAaILsbWnPABiRRnKdtf9kJFcPjEYcHY2TLDRuhrQlBPyh+DAdJrUD9jYerIf6lrSCnqImSktNV5Jy3UGKyrfbx6cPbFA1TWK7j14OWtIoWFZEfEJgGQcPPtg5Tj4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773839636; c=relaxed/simple;
	bh=pg5b/sFk+xMixvySpdHTHu2wf33qexzP6uHrG5HlZFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDyiJ/5du4FmW4D3qew+eOrt/Jh45r60ELr3fPTXqZtI1qwyZbS77Y3Ld4F8idVwkEVYp3p4OsW4NCd30L3Y44c6TSLy3E2c1cXK9M3kTdtG2QXajtQhrx8XzqLa55kn+tNKvrbLJkUFB2VEh8T6+JNnibp99Vt2DGZTAKT/v4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1MswW95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1FFC19421;
	Wed, 18 Mar 2026 13:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773839635;
	bh=pg5b/sFk+xMixvySpdHTHu2wf33qexzP6uHrG5HlZFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O1MswW951yzuViay0FPLdB/VEb1yxVJ7HPAd//R8xv8IEVUUVwtIrEzbvkL86LPxV
	 nbaiDKXSxG7SvNIO+D/75McmOV4iErUn5KYYm/JNio39YDQsSA6byI1gKjFNp0njs8
	 dgc/a+mnhGlLUTKkMD4g5zmPcf6dz+BIJ9Pq0JEukcP6O9W2umYEvTou9eLclztzsx
	 Q0IuOrvuLobU/IMaVtRHBLFTMe8qddKi9iJdYQTPQLXSPapaSD6czbKixLOE/gadHX
	 pO9TQS9+1G0AHgJi4wgolGlVUFnOMQOB2AafdxxaTxHmGbUxWeN0uauzPM52wk/xXM
	 I1V2gaUWfGtBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shengming Hu <hu.shengming@zte.com.cn>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] fgraph: Fix thresh_return nosleeptime double-adjust
Date: Wed, 18 Mar 2026 09:13:53 -0400
Message-ID: <20260318131353.723405-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031739-bride-reproduce-be1c@gregkh>
References: <2026031739-bride-reproduce-be1c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227065-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,goodmis.org:email]
X-Rspamd-Queue-Id: 771DE2BC03A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 kernel/trace/trace_functions_graph.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index a7f4b9a47a71a..0e65d1f452657 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -378,9 +378,14 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
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
@@ -394,11 +399,13 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 
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
-- 
2.51.0


