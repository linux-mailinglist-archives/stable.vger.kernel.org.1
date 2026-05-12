Return-Path: <stable+bounces-246188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF8zBmhsA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:07:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88073526D04
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ED153236305
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C7039060B;
	Tue, 12 May 2026 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XeOM7nPL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85703BB106;
	Tue, 12 May 2026 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608584; cv=none; b=YcRDCxDIU7F4DSfqucybpWuWxxicxVadk63c9jcSkCZM8U/pQ8FIGKM/CpmReJ5B7+bmLZbHTo4taGhegDEY2ov1HT91d3qCRQPZIAo/QQhei6bh7YeQH4zjSbLMS2xU2Hq8kcrEr8paPYtrCcCukabnJr+6F5/lsvBpRzfo12M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608584; c=relaxed/simple;
	bh=S2XMlmduH34w/Grx5pl+GXlvTy55A7AP7whliyZxyCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgwHSr/+CIqe+9zH+cgqhYBIv9smV28J4pCehPqD7psAUOlCH5YmsudGIgqYixCn7HB0R+uihygpnE0stqEbvlRBvTsBB/QdncvkVHrkYE01q2MXZ2mB50CxWZhgxnM8X8bmVe/Qnu016dIa9xwWc1MvWaD38rBq0NfFg66ub50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XeOM7nPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FAFC2BCB0;
	Tue, 12 May 2026 17:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608584;
	bh=S2XMlmduH34w/Grx5pl+GXlvTy55A7AP7whliyZxyCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XeOM7nPLPwOKB9AA8ZjHLFoUM8lZMTihmdxuXbTKiwm/MdKRRLOKcgYCTE+IzYQad
	 VVaw2xWWeB1uZeFsNSi6EEWNiXdQxI04dMpHNkKjxnuFt8Y64F+Ljn43hQ8/LYXnRn
	 DMCe2SVsW0KXigPBNLmyS2wVjkIjmdaVXqySGEyc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 6.18 137/270] tracing/probes: Limit size of event probe to 3K
Date: Tue, 12 May 2026 19:38:58 +0200
Message-ID: <20260512173941.337269117@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 88073526D04
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246188-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[efficios.com:email,goodmis.org:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt <rostedt@goodmis.org>

commit b2aa3b4d64e460ac606f386c24e7d8a873ce6f1a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_probe.c |    6 ++++++
 kernel/trace/trace_probe.h |    4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1523,6 +1523,12 @@ static int traceprobe_parse_probe_arg_bo
 	parg->offset = *size;
 	*size += parg->type->size * (parg->count ?: 1);
 
+	if (*size > MAX_PROBE_EVENT_SIZE) {
+		ret = -E2BIG;
+		trace_probe_log_err(ctx->offset, EVENT_TOO_BIG);
+		goto fail;
+	}
+
 	if (parg->count) {
 		len = strlen(parg->type->fmttype) + 6;
 		parg->fmt = kmalloc(len, GFP_KERNEL);
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -38,6 +38,7 @@
 #define MAX_BTF_ARGS_LEN	128
 #define MAX_DENTRY_ARGS_LEN	256
 #define MAX_STRING_SIZE		PATH_MAX
+#define MAX_PROBE_EVENT_SIZE	3072
 
 /* Reserved field names */
 #define FIELD_STRING_IP		"__probe_ip"
@@ -561,7 +562,8 @@ extern int traceprobe_define_arg_fields(
 	C(BAD_TYPE4STR,		"This type does not fit for string."),\
 	C(NEED_STRING_TYPE,	"$comm and immediate-string only accepts string type"),\
 	C(TOO_MANY_ARGS,	"Too many arguments are specified"),	\
-	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),
+	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),	\
+	C(EVENT_TOO_BIG,	"Event too big (too many fields?)"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a



