Return-Path: <stable+bounces-227028-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PgLMLuPumnSXgIAu9opvQ
	(envelope-from <stable+bounces-227028-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:42:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 190002BAFC1
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A25C311FF08
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31B83CD8AA;
	Wed, 18 Mar 2026 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNudknZH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9883936F41F
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773833955; cv=none; b=dvCVL52GuY/mV/4BdluedC32ilFtYu74gPA2zYsupmaEFsEtGycnNrsUbAuY17CSJZFnkjPxzK5QwRIJH37aZHqj3Iet0tRV9Fuk62xMzk44Ym5DMmFGsoOtoyLQFxBqX0Uj4uFQzvw4ZGxKeyCzMo5h2CWm5DHAW1D6QMg8ZPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773833955; c=relaxed/simple;
	bh=UvSMwqcpukM/Ibk+Ft3J3rVQhYOXTh62lwMI9e0mC8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxkgY/uIpkHBmSPxZuyznCkXGUJGOYPMKv1PsCbomS9JMYiCrVW8pByUHlmfxWKEFIeUaFRgLUq2//2IGvtwMSLib1Yvkdz0ybDCJG1dIXBJEMFWiJgv721C7LWUjD7gJeqvgeQZbVjIvWP5jpZN2zafAMWyrUSFGwqOFC2qi/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNudknZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A64EC19424;
	Wed, 18 Mar 2026 11:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773833955;
	bh=UvSMwqcpukM/Ibk+Ft3J3rVQhYOXTh62lwMI9e0mC8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DNudknZHCGZIvBvYCNLlqTEBZxJ5UOqXXAw+c3R/rrNswI3lwtltHbyrmu6yHsD6O
	 TUSLcCMD9i++z7r5KI78bwXiLNHjD8qV4nJN9Cp2w0SYzndjgODoJteD4FWKmkDYDD
	 ffb7g2cLeYMt8a3SQITGG709XS4gOYiqK83bQ055Xnw+YAVjZnLHNVN1WzlROM94EW
	 vnuWXYCt8pxxsJyZ8WCXbJrICfqg4c2BUGJq3TyzdPhgjhlfllWsc+p1uymXZvnCY9
	 aymwKN9VkrYB963/j2jpYG3A59KHnXz+t66Pj9FNabeb+eGQfTQ6sWirbO/Jw2MWdb
	 p8AIKpvbCUqXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shengming Hu <hu.shengming@zte.com.cn>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] fgraph: Fix thresh_return clear per-task notrace
Date: Wed, 18 Mar 2026 07:39:12 -0400
Message-ID: <20260318113912.631601-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031702-deduct-voucher-50a9@gregkh>
References: <2026031702-deduct-voucher-50a9@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227028-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,goodmis.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 190002BAFC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shengming Hu <hu.shengming@zte.com.cn>

[ Upstream commit 6ca8379b5d36e22b04e6315c3e49a6083377c862 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_functions_graph.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 655246a9bec34..47ea114ca9f46 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -271,10 +271,12 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 				      struct fgraph_ops *gops)
 {
+	unsigned long *task_var = fgraph_get_task_var(gops);
+
 	ftrace_graph_addr_finish(gops, trace);
 
-	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT)) {
-		trace_recursion_clear(TRACE_GRAPH_NOTRACE_BIT);
+	if (*task_var & TRACE_GRAPH_NOTRACE) {
+		*task_var &= ~TRACE_GRAPH_NOTRACE;
 		return;
 	}
 
-- 
2.51.0


