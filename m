Return-Path: <stable+bounces-258513-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPZPLCIoG2qS/ggAu9opvQ
	(envelope-from <stable+bounces-258513-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:10:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A46086112C7
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC951300E14A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A1E362157;
	Sat, 30 May 2026 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GvEIZgWh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C40352027;
	Sat, 30 May 2026 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164602; cv=none; b=YvszaCY58SeJ17dIYi7yzYOz2/TlhVaoXWmVzuWDpkuny4qAcJgvLbNqGf4fX7taJG4wPKMRhRI92p4+TB159GU5mGRKGBiFpXRjoASIAp+BKDQrkkd3WUvtaOvVh2th9SJhH1F6eKggSNgmtUnjFjIHqr4VMVYHf1GZk85tzzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164602; c=relaxed/simple;
	bh=r56/sTfiUmj661dTDlzjKYrJKLvozZC8dHU2hDtJFBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBB7NqUi7mPjI72rP498rkGhkelDGtUHH0+2m05mR+eP9fx3dhOk4vIQECy13o6EIPqy5MZkzRiXEiI7qX+/DEOMTBU7NpJgKcHKyWsE0EgKKh4yi4YqAm/hfIf1mlHVHqZ8t2H96lcNVXvIpy45sUxM7m2oEVgl8No5+h1S55w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GvEIZgWh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93A01F00893;
	Sat, 30 May 2026 18:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164601;
	bh=8MNilqjAgMZ7atf0tJzg0CxHO08U4Pb1rz0DJVuYd2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GvEIZgWhnByk73rtEjy0cqxj+1/y7blE5tKUnI38pkJ9HjIXpooaCkjX9v3yAJgru
	 /eBX4t+SXu+mBvxbKwIX0aiLnqmKRc4WEOptheVwB4o9lryjJ6KFiP+E54JG5ibAxY
	 X61LfxX//r2uGx3Y2OOCKx7EyRHFpVQXbyqcF9QA=
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
Subject: [PATCH 5.15 604/776] tracing: branch: Fix inverted check on stat tracer registration
Date: Sat, 30 May 2026 18:05:18 +0200
Message-ID: <20260530160255.632000620@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258513-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,efficios.com,elte.hu,gmail.com,debian.org,kernel.org,goodmis.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A46086112C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

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




