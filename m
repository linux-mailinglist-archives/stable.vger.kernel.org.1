Return-Path: <stable+bounces-221159-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KSgM+hNo2nw/QQAu9opvQ
	(envelope-from <stable+bounces-221159-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:19:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 737C51C8399
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A1CE3245DB1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05169373144;
	Sat, 28 Feb 2026 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHYkeb8k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB3A373141;
	Sat, 28 Feb 2026 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301511; cv=none; b=drADyRNYEnIIfvQsQ4ELnhyDX1IivOZMsbor8l8dl8jwqxp0PoJRJ5r1+4lm8VQ3bK0oXx5LxgTa0xsNzvc9jHt7QnBC6doOpDHpH5Qlanui5anXutyOcFlgNC7U6XILUMBNOd6O6KHnrY3zXBorzhvIbSy1vaNObgxpK16hvVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301511; c=relaxed/simple;
	bh=G4eFtNv3Fsch3fZYKLdT73Hxi+luVylOgZvfXpQleOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AujUmNZboWVAVnBi1vsSWe9CwK9Z4xC2c4lgmapd5O8a8062t4XwLAc5yPk7yGnYRzAXGiVhXXGJt6Zxa4dMUzzxSbeKUjVoQyqTGOCcNx9eYisdu3GU5Mlh77WZUUz0a8+I7KJB7Y+/CFtBaITwsC6dXW/JhbkYfk/Cw1zVCzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHYkeb8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00120C19423;
	Sat, 28 Feb 2026 17:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301511;
	bh=G4eFtNv3Fsch3fZYKLdT73Hxi+luVylOgZvfXpQleOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gHYkeb8k2htw2/kE5eorRxMH3u0Q1Vcn4WgvvxxMOUyKMgjPZfTCyFnYNZnw6kW8O
	 MC+3IYUScMtfPI1iu/4rV2pIWYDXcwqE1bOFi1Bvp7Fcy/liKsEtYKIzPOA7DjPQgK
	 vtuyz3qwumrFpsURJiWvZU0bHJgB2zu8SCpT9iBqosHNtP1TeSd2BYOwnQqY3jmlfM
	 si2F5F4GdV/pN1dea8mhAsUf9gUFT0gSNG0mk5lsjgJW4QAl4nO2t2Ths+T50DV6r8
	 M5o7j/8bFeVkgxIns7wFPYepZzvLJsOgm+f9vsD+9KE363ejnzboNlkpOt9spBNdhj
	 PmP33N8YQFOug==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	stable@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 697/752] tracing: Fix to set write permission to per-cpu buffer_size_kb
Date: Sat, 28 Feb 2026 12:46:48 -0500
Message-ID: <20260228174750.1542406-697-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221159-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,efficios.com:email]
X-Rspamd-Queue-Id: 737C51C8399
X-Rspamd-Action: no action

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit f844282deed7481cf2f813933229261e27306551 ]

Since the per-cpu buffer_size_kb file is writable for changing
per-cpu ring buffer size, the file should have the write access
permission.

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/177071301597.2293046.11683339475076917920.stgit@mhiramat.tok.corp.google.com
Fixes: 21ccc9cd7211 ("tracing: Disable "other" permission bits in the tracefs files")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 907923d5f8bbb..e1d902464e080 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9183,7 +9183,7 @@ tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
 	trace_create_cpu_file("stats", TRACE_MODE_READ, d_cpu,
 				tr, cpu, &tracing_stats_fops);
 
-	trace_create_cpu_file("buffer_size_kb", TRACE_MODE_READ, d_cpu,
+	trace_create_cpu_file("buffer_size_kb", TRACE_MODE_WRITE, d_cpu,
 				tr, cpu, &tracing_entries_fops);
 
 	if (tr->range_addr_start)
-- 
2.51.0


