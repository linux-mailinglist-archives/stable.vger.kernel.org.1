Return-Path: <stable+bounces-225868-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG/2A4VDuWmK+QEAu9opvQ
	(envelope-from <stable+bounces-225868-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:05:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CCA2A97B1
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C99543081BD3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAFA346792;
	Tue, 17 Mar 2026 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jHsfe5d7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1681FC0A
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748903; cv=none; b=ey8pV4DFFwBb9a12mcfPZFK5x0xCmJDEq3L71a5BRPqIfkH9ZmgJknu+02rekKK9TeAJBlEKgLbwDEmjuFObiSJkx1Yp4u8t7Wrh+XDWsOCt3Jrx7L4JPEwtDQIwbX7RaCQEsZkZxvybBifCxvgSa9yyH6CDYGLTwt6+Cmu9TEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748903; c=relaxed/simple;
	bh=okqSv7+u2cnHCbnPXJxbAJWALfr9D7Yg1BR1li6T6Mo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qPjCjTbhmQE5ibwgfRcpqre4C9GafJz2DWssA0XRRI0iiHsOMPqHDWpFdKOh/yfa7Bj5kxa+y4uAnt61gN8pFd5YGpsce6BKDukJ+mTjitAEtyh3CEpOyeQs17BNfNnX6yjBQVhYqJ01y949a73svgXFOBQKZBKY8scopkeonDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jHsfe5d7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93F5C4CEF7;
	Tue, 17 Mar 2026 12:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773748903;
	bh=okqSv7+u2cnHCbnPXJxbAJWALfr9D7Yg1BR1li6T6Mo=;
	h=Subject:To:Cc:From:Date:From;
	b=jHsfe5d7jalzeb+wWKyHSmn0n4zRzR9ALrWpcRIfIvQlC1zI9T+wgzrPloVPdbFg+
	 FDs2IlNuSSgNecS+O3ZOhs1H5xs18zH4s6OfDpKw7lZ2tpZKO8eTfKanJjnqxRiiDJ
	 ADESwawiy9d09S0MBWYcq8J1rptGE6uBNLbum9/c=
Subject: FAILED: patch "[PATCH] fgraph: Fix thresh_return nosleeptime double-adjust" failed to apply to 6.18-stable tree
To: hu.shengming@zte.com.cn,mhiramat@kernel.org,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:01:39 +0100
Message-ID: <2026031739-bride-reproduce-be1c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225868-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zte.com.cn:email,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,goodmis.org:email]
X-Rspamd-Queue-Id: 67CCA2A97B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x b96d0c59cdbb2a22b2545f6f3d5c6276b05761dd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031739-bride-reproduce-be1c@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b96d0c59cdbb2a22b2545f6f3d5c6276b05761dd Mon Sep 17 00:00:00 2001
From: Shengming Hu <hu.shengming@zte.com.cn>
Date: Sat, 21 Feb 2026 11:33:14 +0800
Subject: [PATCH] fgraph: Fix thresh_return nosleeptime double-adjust

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


