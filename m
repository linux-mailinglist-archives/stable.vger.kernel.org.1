Return-Path: <stable+bounces-226943-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yC1zKIf6uWlfQAIAu9opvQ
	(envelope-from <stable+bounces-226943-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 02:06:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 001CF2B4D47
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 02:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7FDE3070B37
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D69B21D3F4;
	Wed, 18 Mar 2026 01:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKp6a11+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57BB63CB
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 01:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773795972; cv=none; b=YRznfgi6mUzzMjiegzyhpjfFk+WwS2xH6a59f6qsbrVVSUoQapZLTK+5Iw3WfwWD4DKK9R/iT5Gr2vYdZf6qqagSd/z+IM8DycPLsEDQDqSEjTlICq3norT35Rxp/BYYz897Ho+ZXuqJtE4vQcBbmwHJYku/LqE3xEPATjixtkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773795972; c=relaxed/simple;
	bh=XcTbHL7L+1XtFaHDFCyWiKo5HsBDPtqMEMdsXjX34Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2tZc0I1tmJCVNwC3V4sddPetb1ZfQ1OsyhGuPfg1nq3RUhqGBFluRP176f137Mp8mEkiYlVTDqZ0GpaZqHl51q2Du3UxQMAuTCCLA1Ny0Jiebx6Mw39SeDS42ZNk12ZkSjQ/6Sckj71RunqCYhfRh6P9YcVTqMQjwpGn3iRPN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKp6a11+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBE8C4CEF7;
	Wed, 18 Mar 2026 01:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773795972;
	bh=XcTbHL7L+1XtFaHDFCyWiKo5HsBDPtqMEMdsXjX34Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WKp6a11+7zzHkuRl4DSi8oberAiDGIZHAgBWOEpILI2xhP02jdlt2RjqLFSAOzNi5
	 Pbg9faffwTx2miZ0E900E18OrM+gi4ptaDgbCjeix2X+3HHNy9WgBD8Z+VG5mt5lDb
	 4PMeO2lKW8i67InkpFzWNCGgDOZ+khtgXIbLJqSXoWORw/0V4hDO4OnqSZMaNA/Qdu
	 ZDH6zZipRmLp2Shs4HjQMRCEJPI/KFkl0/cbMuWK3aakdxP//q02q7sI6fH84eVwzc
	 CwnPdyqE6zjaz5IJmI2fKKa1FOGDfj4Xe4AAtSJ5AtlKtL8T+0FQWW1Cvr5LpxOKkY
	 PogmDqie4Fwhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shengming Hu <hu.shengming@zte.com.cn>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] fgraph: Fix thresh_return clear per-task notrace
Date: Tue, 17 Mar 2026 21:06:09 -0400
Message-ID: <20260318010609.419414-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031701-backer-clumsy-6f09@gregkh>
References: <2026031701-backer-clumsy-6f09@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226943-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goodmis.org:email]
X-Rspamd-Queue-Id: 001CF2B4D47
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
 kernel/trace/trace_functions_graph.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index a7f4b9a47a71a..b53d83b619401 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -378,13 +378,14 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 				      struct fgraph_ops *gops,
 				      struct ftrace_regs *fregs)
 {
+	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct fgraph_times *ftimes;
 	int size;
 
 	ftrace_graph_addr_finish(gops, trace);
 
-	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT)) {
-		trace_recursion_clear(TRACE_GRAPH_NOTRACE_BIT);
+	if (*task_var & TRACE_GRAPH_NOTRACE) {
+		*task_var &= ~TRACE_GRAPH_NOTRACE;
 		return;
 	}
 
-- 
2.51.0


