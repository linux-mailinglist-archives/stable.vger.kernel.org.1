Return-Path: <stable+bounces-225864-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI4xBo1CuWnM+AEAu9opvQ
	(envelope-from <stable+bounces-225864-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:01:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A255C2A96C3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17C273019820
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E090B3A6B79;
	Tue, 17 Mar 2026 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sp0CqSBM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C6A35C1B8
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748874; cv=none; b=ge/bOYGdXtxjAho/PS0J2bAPvH5vGaLX6D9E8pNY8+AhST3gO/wxIbR6VjEyr36ZYtlohI4/+hbWnT9bbpq3ayNaxng4z0tqP9p1bEBzR4k4UfBOi2/DRywpw4hAJ64VIv1GOMn0PQbl30FsDomfX1JpUJgLHZLDY2rxeAPNkIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748874; c=relaxed/simple;
	bh=eosgbT6pO68KS4FE2Pd/uF5dQSqL4E2z8RdrW8aQmqc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YI9NiIEhzObeR3E/XRQz1H2ks1ZK/6VhYo1gYcohp8eSRA/5JOtyMXx+hmoZf0rP1bo5NPW8qquYQox5jCcunb70v3OX8/+u01qkNs/aezqtdJ9edRYFHITD02aEv1lzGrX712R12ZGIQOX6sDFjuVd0yv7Jvzhj159uDirZiy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sp0CqSBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0917EC4CEF7;
	Tue, 17 Mar 2026 12:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773748874;
	bh=eosgbT6pO68KS4FE2Pd/uF5dQSqL4E2z8RdrW8aQmqc=;
	h=Subject:To:Cc:From:Date:From;
	b=Sp0CqSBM7AQzSB1XxKA+eO/CrYMB4zUQD07rvFjilsjmuRgxL2X6gB1FkfNfdti4z
	 mT5+heTv+fqAu78oFiYwEQsSTxE+2jVcbAfL7sFCoYBGJ8k0XbBjruu+0L7k6Pi+3U
	 WW3RaNQNBr6zwVRaM+PAr7G5PzpPSFPutJOcs4V0=
Subject: FAILED: patch "[PATCH] fgraph: Fix thresh_return clear per-task notrace" failed to apply to 6.12-stable tree
To: hu.shengming@zte.com.cn,mhiramat@kernel.org,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:01:02 +0100
Message-ID: <2026031702-deduct-voucher-50a9@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225864-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim,goodmis.org:email,zte.com.cn:email]
X-Rspamd-Queue-Id: A255C2A96C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6ca8379b5d36e22b04e6315c3e49a6083377c862
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031702-deduct-voucher-50a9@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6ca8379b5d36e22b04e6315c3e49a6083377c862 Mon Sep 17 00:00:00 2001
From: Shengming Hu <hu.shengming@zte.com.cn>
Date: Sat, 21 Feb 2026 11:30:07 +0800
Subject: [PATCH] fgraph: Fix thresh_return clear per-task notrace

When tracing_thresh is enabled, function graph tracing uses
trace_graph_thresh_return() as the return handler. Unlike
trace_graph_return(), it did not clear the per-task TRACE_GRAPH_NOTRACE
flag set by the entry handler for set_graph_notrace addresses. This could
leave the task permanently in "notrace" state and effectively disable
function graph tracing for that task.

Mirror trace_graph_return()'s per-task notrace handling by clearing
TRACE_GRAPH_NOTRACE and returning early when set.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260221113007819YgrZsMGABff4Rc-O_fZxL@zte.com.cn
Fixes: b84214890a9bc ("function_graph: Move graph notrace bit to shadow stack global var")
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 3d8239fee004..817d0f1696b6 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -400,14 +400,15 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 				      struct fgraph_ops *gops,
 				      struct ftrace_regs *fregs)
 {
+	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct fgraph_times *ftimes;
 	struct trace_array *tr;
 	int size;
 
 	ftrace_graph_addr_finish(gops, trace);
 
-	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT)) {
-		trace_recursion_clear(TRACE_GRAPH_NOTRACE_BIT);
+	if (*task_var & TRACE_GRAPH_NOTRACE) {
+		*task_var &= ~TRACE_GRAPH_NOTRACE;
 		return;
 	}
 


