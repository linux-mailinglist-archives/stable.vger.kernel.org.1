Return-Path: <stable+bounces-245634-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULcdOkMxA2oA1gEAu9opvQ
	(envelope-from <stable+bounces-245634-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:55:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDD8521C08
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E71F30059AD
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9C8399889;
	Tue, 12 May 2026 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YkygmAH3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15313911DC
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593833; cv=none; b=OZG+pI0wECXT3kNJCcxqJy/nXa7Qdz3WNLEjHXkN87YMEjW51ay9hxDgIT77tNruJf7rWm2yvloZa97aIofM4QZRyd9+WRRWEEhDEKAqE2eMZaAfdrqK/RZadLVkxW9QFjeCf/gfVSPjw5FU1/oPwhdTMROeYIarY1r3szKd1cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593833; c=relaxed/simple;
	bh=tjXbe7RSRaGStPpB6EcyWU5kY9Bu1lRaPIm2T5AJ6C8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P9XXdUqiohgXkhB8HlNVBI6/iMax1Y4MkrHk7CQHdWcYr+/ACTN/AvPfltgRy8PcRuJzblEAEHipHCJYaGNM949TTwYottBpM8p0IabJnYbediWIze478CorF+4uDLIlH124rnw2eqyiycg6FVsVUUZUnfIGx0uKzjfOdju1Fnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YkygmAH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AC9C2BCB0;
	Tue, 12 May 2026 13:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778593833;
	bh=tjXbe7RSRaGStPpB6EcyWU5kY9Bu1lRaPIm2T5AJ6C8=;
	h=Subject:To:Cc:From:Date:From;
	b=YkygmAH3jMmRfP0cQIjFvigOqlzkeywSVHqlIXByiY88cuUqEkv9CuaWEeHINaP/U
	 ylAUkde7yyZ6nBEoNYz7Tp2OXibqCCWmUG6prx4InGoGI7KCJHIOXogEGDKRVCs1zR
	 CWlDMM+QSN/aBgD0wNmeE3yASnz5l4jtMnhDSwoo=
Subject: FAILED: patch "[PATCH] tracing/probes: Limit size of event probe to 3K" failed to apply to 5.10-stable tree
To: rostedt@goodmis.org,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 15:50:26 +0200
Message-ID: <2026051226-maybe-angling-76ae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8EDD8521C08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245634-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,gregkh:email,goodmis.org:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b2aa3b4d64e460ac606f386c24e7d8a873ce6f1a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051226-maybe-angling-76ae@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b2aa3b4d64e460ac606f386c24e7d8a873ce6f1a Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 28 Apr 2026 12:23:02 -0400
Subject: [PATCH] tracing/probes: Limit size of event probe to 3K

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

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index e1c73065dae5..e0d3a0da26af 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1523,6 +1523,12 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
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
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 9fc56c937130..262d8707a3df 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -38,6 +38,7 @@
 #define MAX_BTF_ARGS_LEN	128
 #define MAX_DENTRY_ARGS_LEN	256
 #define MAX_STRING_SIZE		PATH_MAX
+#define MAX_PROBE_EVENT_SIZE	3072
 
 /* Reserved field names */
 #define FIELD_STRING_IP		"__probe_ip"
@@ -561,7 +562,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_TYPE4STR,		"This type does not fit for string."),\
 	C(NEED_STRING_TYPE,	"$comm and immediate-string only accepts string type"),\
 	C(TOO_MANY_ARGS,	"Too many arguments are specified"),	\
-	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),
+	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),	\
+	C(EVENT_TOO_BIG,	"Event too big (too many fields?)"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a


