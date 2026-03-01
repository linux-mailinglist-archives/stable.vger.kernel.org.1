Return-Path: <stable+bounces-221526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONStCaaWo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:30:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A2C1CAD3C
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F89E30217DD
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74026296BD3;
	Sun,  1 Mar 2026 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIvz4n48"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AB072631;
	Sun,  1 Mar 2026 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328485; cv=none; b=Tfq42jBjns3XuQB1HYxDtaOQ4LOOzUG1iDL0+xZpTpL4w8qhtoME7aKoArhbcXKhpzeBBGMW54F+F1wS4WwVSFFzwIlZVChIDPh4sXHVE8rOchOLkOX/d8j1YhF60e96TnLBE6bs3XZ2fBgdBZzLnijHzmFdV8EPonpB94PiWj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328485; c=relaxed/simple;
	bh=WTOUF83UYU2jVYOgULKxRPuaJ8uBlQIoaUgFlqkIA0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TE+0vLe84dwUiww9fFaHfMBWsKwxZmA7K0eTOsy0kevCnbZKOeuLUKTdEwPt+nGhzLMei2jUVsQYs3lEUBk/rEp7isdzMoCquEgrA1foTaQy5OYyKHbkZidoC/XXA+dwrL478JOoQ/qo0ZJEAf97Tyh6q/Bjoc21gzCWCTAdYlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIvz4n48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85439C19421;
	Sun,  1 Mar 2026 01:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328485;
	bh=WTOUF83UYU2jVYOgULKxRPuaJ8uBlQIoaUgFlqkIA0o=;
	h=From:To:Cc:Subject:Date:From;
	b=hIvz4n48NCDP9J1Sp+BrvN0T4Kf9p9g6kMNxjtPeU5jSMZAQDOqVEU9bvGLu+jRDt
	 DofBbKhI7Ifx7dd324BBxi8ncWEjd16OBXgqEowIxpyY7rykxO9TzTUnA15pECfK9h
	 Wk0Mqb1CjS+L2Y8cIxQBsCvcPMEwtT6XjVm+5k8bWM9RQuurCg8ULdLF0WacSIA6eA
	 TY3BfA3dX5g2dXVgHsj7IpT4yD+DjfkD/T9+KZTo1EhgJ1y/4YIoXlKY3d1B/QsT3x
	 L56ZQYoR60LzWATsoIN0OCZML7EMOlkbD+ovmTYpHycCp+LX40hvkMiNlvu3L+fHcW
	 vKhB2/ct5lHdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mhiramat@kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Subject: FAILED: Patch "tracing: Fix to set write permission to per-cpu buffer_size_kb" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:28:02 -0500
Message-ID: <20260301012803.1685713-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221526-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,efficios.com:email,goodmis.org:email]
X-Rspamd-Queue-Id: B5A2C1CAD3C
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f844282deed7481cf2f813933229261e27306551 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Tue, 10 Feb 2026 17:43:36 +0900
Subject: [PATCH] tracing: Fix to set write permission to per-cpu
 buffer_size_kb

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
index 845b8a165daf3..fd470675809b3 100644
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





