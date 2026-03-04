Return-Path: <stable+bounces-223141-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLsiFkGvqGmfwQAAu9opvQ
	(envelope-from <stable+bounces-223141-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 23:16:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0C320866A
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 23:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38B02311FFAC
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 22:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3B33D7D64;
	Wed,  4 Mar 2026 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecZCVQQ5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA333D6CB6;
	Wed,  4 Mar 2026 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661780; cv=none; b=b7Vfu5TsJZx5A21WJ9faVpBXbA815GsYcNjhQdopXMEdEyC+Ke7KQvVEL3fifEkp/7HQihWWLQdslWmCTX69z959P0mZpuWaXiMJoaHKpVF2xwhH+JtZTgzYkjKfFMgmzY12LPy4pW4LgQ/2vpD7l8aNJwl8MyfSn2IoK2CySSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661780; c=relaxed/simple;
	bh=9ndavW1imuK8pKglSZjcoS6XER79HDMTjVejRGF0FhE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ij5xceAssp+PJ9fHQWYXAaQ7AAhPe1Y1ePEE2hLA/Lnv0tQodZWcppKQHdDRqCjxeqYUFnf7ZhaqzCCsXweqWi6p7M0p/oLkBLXdvghaPFybt1VqDOv41ASy01eAl/hocMqyK+DwaVzO69SGKJpLbVuay2im4fosM/Y2wkui5cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecZCVQQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7181CC4CEF7;
	Wed,  4 Mar 2026 22:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661780;
	bh=9ndavW1imuK8pKglSZjcoS6XER79HDMTjVejRGF0FhE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ecZCVQQ5dB9AzMXOw3pei4CuO7/cUPYIY49TdBJD1Ubiv5tiPD9GXacYJH/Dc746j
	 nbX8i4/PgoxShYycVVg8dFiQx58UPGcPuWENE+amojWYC7WzEGep1we784ypz4ZtX4
	 qntEtxsYalm4ZfVLFIwi54J73QX++c9Zo6UqHENzb1GCvmw0HFlpB1dXcfV6rZ0n5X
	 xKUo2H6xaomvlgaIv75bKmdAnJzY3PoUeuBeec2hxU0s1C1rhHHbgtklYBOLtP2vHz
	 t7yL8hC2kKd5u2GCt9rXKca9rJH+LocwizH4c4MaWxgB5QrJZMKWuc3SEQfKR87w3+
	 qIy2i5DO6iYcA==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vxuJd-00000003CQm-29W1;
	Wed, 04 Mar 2026 17:03:37 -0500
Message-ID: <20260304220337.372201163@kernel.org>
User-Agent: quilt/0.69
Date: Wed, 04 Mar 2026 17:03:20 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Shengming Hu <hu.shengming@zte.com.cn>
Subject: [for-linus][PATCH 1/6] fgraph: Fix thresh_return clear per-task notrace
References: <20260304220319.218314827@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: AF0C320866A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223141-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
---
 kernel/trace/trace_functions_graph.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

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
 
-- 
2.51.0



