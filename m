Return-Path: <stable+bounces-247799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHGQCFAyB2qQswIAu9opvQ
	(envelope-from <stable+bounces-247799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:48:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A94551AA8
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CE2030028BA
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F068246781;
	Fri, 15 May 2026 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cen0u0Wm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD69A29BD88
	for <stable@vger.kernel.org>; Fri, 15 May 2026 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778856523; cv=none; b=pUPryRcOX1b3cRcyy9m40OOd+7yGIkxOMfbHSwOM2ferSYy8eJb/PQlgG1Y5Hba96ksO37S0O44jauwXGuxqHDXkSxKPGwLoubf3EiCSKB7NKjekN13XygbOH5hswjII8rIkgmBFglOTjku9mCalmoBivB3iuffx4VjupCkPiDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778856523; c=relaxed/simple;
	bh=p/i06LtXBRSNlf++kDbfQGGDq6frpv5pUZNuhCrcRZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRAfpnW89MfLxCOPreAQxWutSiJPNzkjQOqD5kwDnliHpOg4E0BI+5pcEwlHUV+FhWflbnvOeHJ2loTu1osdXwJSRmo9TGDflTn+9KMQJQnTWR5k/VhRXWX79DC4+FQONcF53a3cVUQUaaSYVAY8CKEF6OcnsvCbAHisvqJ8Uqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cen0u0Wm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C17C2BCB0;
	Fri, 15 May 2026 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778856523;
	bh=p/i06LtXBRSNlf++kDbfQGGDq6frpv5pUZNuhCrcRZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cen0u0WmM5HKgbdCYMUjnImXjnu9CWRh0ZpqqmLVGH6sfZnEJ0UDFAo8Y35736mCn
	 Mfg0KViD4UxsKdes08NmGyiAJe7L5X2CCqq1LI1CMP54S5PsgAt5cISmrjsZwAJlw2
	 SmZve2VRnSjiWQI6jV341/823KlByqguEBVxSBz1c3gGZ5pq63YQCDqdEsKemvuadw
	 KkWedcQ0Y4OG5sEoTtdTy3mfNMk/6FOiQv7gXmgRVR1GVDnwXiFnDs6T1swOxM9q15
	 VcTvS2OUn4NLas484s9abhA2DeZXnjAk7PAg3QGNj+wwWBfSqDnaKZI3v6WSZrYhWV
	 B3xjk4goWRxDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] tracing/probes: Limit size of event probe to 3K
Date: Fri, 15 May 2026 10:48:40 -0400
Message-ID: <20260515144840.3249487-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051225-barrack-cesarean-e05c@gregkh>
References: <2026051225-barrack-cesarean-e05c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B8A94551AA8
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
	TAGGED_FROM(0.00)[bounces-247799-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
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
[ changed `ctx->offset` to `offset` and `goto fail` to `goto out` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe.c | 6 ++++++
 kernel/trace/trace_probe.h | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 3888a59c9dfe9..607f8b787e9b6 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -651,6 +651,12 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	parg->offset = *size;
 	*size += parg->type->size * (parg->count ?: 1);
 
+	if (*size > MAX_PROBE_EVENT_SIZE) {
+		ret = -E2BIG;
+		trace_probe_log_err(offset, EVENT_TOO_BIG);
+		goto out;
+	}
+
 	ret = -ENOMEM;
 	if (parg->count) {
 		len = strlen(parg->type->fmttype) + 6;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index aab5066667ee4..eef819796fceb 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -33,6 +33,7 @@
 #define MAX_ARRAY_LEN		64
 #define MAX_ARG_NAME_LEN	32
 #define MAX_STRING_SIZE		PATH_MAX
+#define MAX_PROBE_EVENT_SIZE	3072
 
 /* Reserved field names */
 #define FIELD_STRING_IP		"__probe_ip"
@@ -458,7 +459,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(NO_EVENT_INFO,	"This requires both group and event name to attach"),\
 	C(BAD_ATTACH_EVENT,	"Attached event does not exist"),\
 	C(BAD_ATTACH_ARG,	"Attached event does not have this field"),\
-	C(NO_EP_FILTER,		"No filter rule after 'if'"),
+	C(NO_EP_FILTER,		"No filter rule after 'if'"),		\
+	C(EVENT_TOO_BIG,	"Event too big (too many fields?)"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a
-- 
2.53.0


