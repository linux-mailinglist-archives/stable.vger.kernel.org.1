Return-Path: <stable+bounces-265716-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CH1zJxOPMWqzmgUAu9opvQ
	(envelope-from <stable+bounces-265716-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:59:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17734693B1C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:59:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=aaFIv0sa;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265716-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265716-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6E6231484F7
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5714779B3;
	Tue, 16 Jun 2026 17:57:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA663043C8;
	Tue, 16 Jun 2026 17:57:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632621; cv=none; b=J8NVNJDw1DL40jG1QOuZ9OJ0rn/wVhLcJpJT01Mk/viK/QD8y/cWBJgW42MqOv9ytXOjgNbHYbtHaKYbRQI4L1VZ1AjIvX61WZV9XiIGcwCtv+UJAjm3oxkEwly6UGVqpzS6r0CZZs2RyngrDPoIcS2snpMc5KHtKwO0VlJiDq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632621; c=relaxed/simple;
	bh=eIEQFJRaVY10reXlrd3MK/QGT8HU8EtlCGIF1tcKAJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oojvfwr1KdxMUY65owefBGSio+AKSEf8G9pGl6KR/SrPrwD/jtJo8jYiOxxC+bz/H0MTEh5NamULU8SS6LGK5SYFtsdXjv+v2iJaZ59fNBO5d6RQyz4iFHnA73tILvpqiuIGjoXQ0k/pzCKISOv44ejb2SB1BSb2Brph7F/G5UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aaFIv0sa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306511F000E9;
	Tue, 16 Jun 2026 17:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781632620;
	bh=DJ/x4HX7/Nbo3s/CPBAxw3S7ZeLFzM9ms2YgPEnS9BQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aaFIv0saDd/cp3hc1mObAhoP4mcsmcsTWLBbOZ36NlhkXsiNCd5XATVLPX+S6feGO
	 ZEBC0Pw2ZTJHigKLkz8c8VUtYmb+NwcbqjSWuwCSzrPMGFbRqDqwPL9ldVo5wrSbYk
	 4S0dTZP4CvOzuzkWVk6wxHCZZLXxzbM6Xg0EG9TQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 413/522] tracing/probes: Limit size of event probe to 3K
Date: Tue, 16 Jun 2026 20:29:20 +0530
Message-ID: <20260616145145.372143718@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265716-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:mathieu.desnoyers@efficios.com,m:mhiramat@kernel.org,m:rostedt@goodmis.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,efficios.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17734693B1C

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_probe.c |    6 ++++++
 kernel/trace/trace_probe.h |    4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -651,6 +651,12 @@ static int traceprobe_parse_probe_arg_bo
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
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -33,6 +33,7 @@
 #define MAX_ARRAY_LEN		64
 #define MAX_ARG_NAME_LEN	32
 #define MAX_STRING_SIZE		PATH_MAX
+#define MAX_PROBE_EVENT_SIZE	3072
 
 /* Reserved field names */
 #define FIELD_STRING_IP		"__probe_ip"
@@ -458,7 +459,8 @@ extern int traceprobe_define_arg_fields(
 	C(NO_EVENT_INFO,	"This requires both group and event name to attach"),\
 	C(BAD_ATTACH_EVENT,	"Attached event does not exist"),\
 	C(BAD_ATTACH_ARG,	"Attached event does not have this field"),\
-	C(NO_EP_FILTER,		"No filter rule after 'if'"),
+	C(NO_EP_FILTER,		"No filter rule after 'if'"),		\
+	C(EVENT_TOO_BIG,	"Event too big (too many fields?)"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a



