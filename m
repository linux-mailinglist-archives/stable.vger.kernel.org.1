Return-Path: <stable+bounces-215966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKo0EGfgjWnE8AAAu9opvQ
	(envelope-from <stable+bounces-215966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 15:15:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7396712E2F8
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 15:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68ECB30490EB
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 14:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00E935CB7F;
	Thu, 12 Feb 2026 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6+72HzA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F7E35CB69;
	Thu, 12 Feb 2026 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770905691; cv=none; b=sS8d/Tj+cKNhAKGVOW75M8dA0lsDu3wQkJyGQaFaNG/xsBzSh0bVXZVj4oDmFXKjTVP1pas5i4BQX5ohyrYda01fb+IYFxQsnV46KIZwHm7zZInGQVwYVo7tfmLOygeV9IPnZK+uMPiYQbdD5zuLWIrPQDAifrkh1EZTGlj0WkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770905691; c=relaxed/simple;
	bh=RdzQsLETYKvlriLm/NMGW7KYXfnHS0fq0aSeOOeoJXM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Hha+tGHRoOjxV197JIAe5QNS+J7FNkP8d6LYeCyQNTOptIf6rDiKONaSjKMDshVltqGaql8ctv5xy0rLUwi/ZuieSTgIVj1QNqlTttdIinEWjCjZmRti5333jJtqXxzWG/ArCytY5XTWI/OZa3voHPSBUGHPHyttlmb4efGYDVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6+72HzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A82C16AAE;
	Thu, 12 Feb 2026 14:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770905691;
	bh=RdzQsLETYKvlriLm/NMGW7KYXfnHS0fq0aSeOOeoJXM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=U6+72HzAW8FxFV6oUXlwSZk2p48eMlFl3nXeoy38Tj5xmoYh2SkIijLNBHo9lKnFC
	 /nQhQSLw0DC9KoLy8ndz6ZAT8ms2208rxf4RnObv37l3QNmrEUpYQYfTLEvH4RxvmS
	 myEitn3p35eyio47PqLzx5M9TMX7n+FdLRkhRjGpLYfjXW1NN8arvxmR8bKdtFcT9/
	 cdv51Kyoio1vOzu5v3V7sUH3C9DenPz+Gs8VQd5KG/hUg5XfnGzOM7ldH6Nc81Osuk
	 IL+QkGMQZFRhwfdfDSGVO3/ANwUrO6ljO3n8ufFj/XRdb0+x40zcjq1BmAGqg1QnSV
	 Z6ak7yDdnWhCQ==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vqXT0-000000002lq-1q1L;
	Thu, 12 Feb 2026 09:14:50 -0500
Message-ID: <20260212141450.296763331@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 12 Feb 2026 09:14:34 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-next][PATCH 1/3] tracing: Fix to set write permission to per-cpu buffer_size_kb
References: <20260212141433.849771751@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215966-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7396712E2F8
X-Rspamd-Action: no action

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Since the per-cpu buffer_size_kb file is writable for changing
per-cpu ring buffer size, the file should have the write access
permission.

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/177071301597.2293046.11683339475076917920.stgit@mhiramat.tok.corp.google.com
Fixes: 21ccc9cd7211 ("tracing: Disable "other" permission bits in the tracefs files")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 845b8a165daf..fd470675809b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8613,7 +8613,7 @@ tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
 	trace_create_cpu_file("stats", TRACE_MODE_READ, d_cpu,
 				tr, cpu, &tracing_stats_fops);
 
-	trace_create_cpu_file("buffer_size_kb", TRACE_MODE_READ, d_cpu,
+	trace_create_cpu_file("buffer_size_kb", TRACE_MODE_WRITE, d_cpu,
 				tr, cpu, &tracing_entries_fops);
 
 	if (tr->range_addr_start)
-- 
2.51.0



