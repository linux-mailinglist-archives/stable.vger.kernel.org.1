Return-Path: <stable+bounces-252690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AD/YOJ4HDmp25gUAu9opvQ
	(envelope-from <stable+bounces-252690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:12:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E42A6597F09
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87075308E8F3
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A113F9280;
	Wed, 20 May 2026 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TzXkGx2S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6261A348C55;
	Wed, 20 May 2026 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301334; cv=none; b=NjV4l8NmHD9nDWkE52WIU289Jz6IfznRto7JOCf6YwckLlDDRoSuM+ipQeN4/CEnvwnSMxu4VRRTbCMz8GTk5w+7uBjGOlPwst0Z7akvuL7KYJEqG150l1tT+2fIUTaneOlgVPz11DftWlcWw9SljslIW3OGlmoa0uatTZozM08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301334; c=relaxed/simple;
	bh=NmgH9e+TXicOqcjREQ1b+tOIXBG+MtXmdrjv7TBoXjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYV4yseDe2PdeKpKmJ8ku/SwFXoeE/hyiayMCsQgv7hfv4XaQou+/4wtF+udlZYxtJOeHzuBnXOO7oNFJ2drKMUtHNZE1w4QzYJM73zpdJt+QFnRw8vcPSjciSz2uj7OepVTKAK2tHDswqyf1ewEPni2vB3b5B24ZTtvV6Jv6ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TzXkGx2S; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBD91F00894;
	Wed, 20 May 2026 18:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301333;
	bh=+aJLyq9FT39J+IRJ7An5kzV1xIi5F2yf6yO/6GA5WXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TzXkGx2SVrhwhSTZvFT7myFZyo4igXwc6MFUffKhZh19WPnQpRoEVVhEMfX4Gi1z6
	 9+Um43TD5h8i9YgvoqctBqC09fmaDJdWgmRW35fA+4tca4N2gaewWiQSy5Y/+l02BH
	 J2BP5d/Hp62PbI2nsFsV0V4Hl9d/d3R+Z0IkgeAk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@elte.hu>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 514/666] tracing: branch: Fix inverted check on stat tracer registration
Date: Wed, 20 May 2026 18:22:05 +0200
Message-ID: <20260520162122.401979019@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252690-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,efficios.com,elte.hu,gmail.com,debian.org,kernel.org,goodmis.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,elte.hu:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,goodmis.org:email,efficios.com:email]
X-Rspamd-Queue-Id: E42A6597F09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 3b75dd76e64a04771861bb5647951c264919e563 ]

init_annotated_branch_stats() and all_annotated_branch_stats() check the
return value of register_stat_tracer() with "if (!ret)", but
register_stat_tracer() returns 0 on success and a negative errno on
failure. The inverted check causes the warning to be printed on every
successful registration, e.g.:

  Warning: could not register annotated branches stats

while leaving real failures silent. The initcall also returned a
hard-coded 1 instead of the actual error.

Invert the check and propagate ret so that the warning fires on real
errors and the initcall reports the correct status.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Link: https://patch.msgid.link/20260420-tracing-v1-1-d8f4cd0d6af1@debian.org
Fixes: 002bb86d8d42 ("tracing/ftrace: separate events tracing and stats tracing engine")
Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_branch.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
index e47fdb4c92fbc..30f72e0ecb5d4 100644
--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -379,10 +379,10 @@ __init static int init_annotated_branch_stats(void)
 	int ret;
 
 	ret = register_stat_tracer(&annotated_branch_stats);
-	if (!ret) {
+	if (ret) {
 		printk(KERN_WARNING "Warning: could not register "
 				    "annotated branches stats\n");
-		return 1;
+		return ret;
 	}
 	return 0;
 }
@@ -444,10 +444,10 @@ __init static int all_annotated_branch_stats(void)
 	int ret;
 
 	ret = register_stat_tracer(&all_branch_stats);
-	if (!ret) {
+	if (ret) {
 		printk(KERN_WARNING "Warning: could not register "
 				    "all branches stats\n");
-		return 1;
+		return ret;
 	}
 	return 0;
 }
-- 
2.53.0




