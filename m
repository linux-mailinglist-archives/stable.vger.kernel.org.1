Return-Path: <stable+bounces-247838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F4bD6xAB2oCvAIAu9opvQ
	(envelope-from <stable+bounces-247838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:50:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DDE552644
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBCAC3022B8F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E2D3FBB4E;
	Fri, 15 May 2026 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZIx6wpX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B55A3FBB42
	for <stable@vger.kernel.org>; Fri, 15 May 2026 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859375; cv=none; b=qPQxjtfIThz7JyKOpvPWI7Uf6MKwQV99+l08zLApvACNbh7nQbB0w6fknV4JdKcdQfKycGMff49wVBKUUPQfNNhmr8EtGFgwbGOLkM38S3mZVvz/loeuDE6hKlmcOcahzNAJnlxKumgIYcON5d+oNL1Pul1WtwZf0+dy84POEN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859375; c=relaxed/simple;
	bh=yWVMXUNdSbi4nbx3ES5QHZvji96NWf8BvbVEqb7jMns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLzxQFdrFAeintpxF0QJZS2Af2BcuBf4fdJwekR8/9HkUbAIXqzXcfGKqU3iIGvPBulNVGxro28xe/xMLjLN420kgNe0wL+WrMYwYHJ4ROy+QnKOYeeGhcorWAJf5AE6Tpjx87M09cmzH/7WuIUCRTBGPWYvusjCVx5Rr+N3HYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZIx6wpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAC7C2BCB0;
	Fri, 15 May 2026 15:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778859375;
	bh=yWVMXUNdSbi4nbx3ES5QHZvji96NWf8BvbVEqb7jMns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZIx6wpXmvQJDjlNNkWmV4ISS2HdBivDb3PO2kWjVlSo0bI96DIufB+l7nTf4Y4UI
	 81cCQi6sOKCbCZCeS6W1yrEH9xfmDkwsdPsN2as+b13/5uHTMqVBVPwCvJQE15s/Wt
	 DKZK/EG8qjZBT4TtiedHklbYrImN1iQCHraYA0+I9cOx+p40YK2DbAzEH5ubb/YNqH
	 bzgurIGo7v3JmEiqKt21kR++o+kulkpkT7W/W4HoM1pDr04CfOyWFi04G/lCH61VLZ
	 ndNKQpYklmhGTX5/LK22jGO+xjRdVmkIaeIozSMghMfYPHjC47zf6ULv7YmPDOWh79
	 KGccN9MdBNwEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tracing/probes: Limit size of event probe to 3K
Date: Fri, 15 May 2026 11:36:12 -0400
Message-ID: <20260515153612.3302611-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051226-maybe-angling-76ae@gregkh>
References: <2026051226-maybe-angling-76ae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D0DDE552644
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247838-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,goodmis.org:email,msgid.link:url,efficios.com:email]
X-Rspamd-Action: no action

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit b2aa3b4d64e460ac606f386c24e7d8a873ce6f1a ]

There currently isn't a max limit an event probe can be. One could make an
event greater than PAGE_SIZE, which makes the event useless because if
it's bigger than the max event that can be recorded into the ring buffer,
then it will never be recorded.

A event probe should never need to be greater than 3K, so make that the
max size. As long as the max is less than the max that can be recorded
onto the ring buffer, it should be fine.

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: 93ccae7a22274 ("tracing/kprobes: Support basic types on dynamic events")
Link: https://patch.msgid.link/20260428122302.706610ba@gandalf.local.home
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe.c | 5 +++++
 kernel/trace/trace_probe.h | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 1893fe5460acb..cd230b337e398 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -610,6 +610,11 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 	parg->offset = *size;
 	*size += parg->type->size * (parg->count ?: 1);
 
+	if (*size > MAX_PROBE_EVENT_SIZE) {
+		trace_probe_log_err(offset, EVENT_TOO_BIG);
+		return -E2BIG;
+	}
+
 	if (parg->count) {
 		len = strlen(parg->type->fmttype) + 6;
 		parg->fmt = kmalloc(len, GFP_KERNEL);
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 9be69ba07cd28..5d4dc7ac3d198 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -33,6 +33,7 @@
 #define MAX_ARRAY_LEN		64
 #define MAX_ARG_NAME_LEN	32
 #define MAX_STRING_SIZE		PATH_MAX
+#define MAX_PROBE_EVENT_SIZE	3072
 
 /* Reserved field names */
 #define FIELD_STRING_IP		"__probe_ip"
@@ -439,7 +440,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(FAIL_REG_PROBE,	"Failed to register probe event"),\
 	C(DIFF_PROBE_TYPE,	"Probe type is different from existing probe"),\
 	C(DIFF_ARG_TYPE,	"Argument type or name is different from existing probe"),\
-	C(SAME_PROBE,		"There is already the exact same probe event"),
+	C(SAME_PROBE,		"There is already the exact same probe event"),\
+	C(EVENT_TOO_BIG,	"Event too big (too many fields?)"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a
-- 
2.53.0


