Return-Path: <stable+bounces-215501-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EZIHQH6iWkiFQAAu9opvQ
	(envelope-from <stable+bounces-215501-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:15:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A82BE111C6B
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD8D23074F0F
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1906437BE7F;
	Mon,  9 Feb 2026 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CUa+K4IV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11413033D2;
	Mon,  9 Feb 2026 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770649004; cv=none; b=sEV9UJX1UgvkZbRaQjYpLMoFO3JMtal29ShGlVMNLY/44Z849iVFgfc32O/dOD3uZbi/HUckbPUpM2xRVRmWmL5wMX+YbE/rSezwHkNaD6EMkCDM7YWlywXL0pjxQjhsxqM3pFyEHJJyUl0vLc/2mc80Mi7j28CaA1Pxk0yIiqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770649004; c=relaxed/simple;
	bh=p1aHKLsC0RMmuY5Y8PQQ6oBGbaawp+XspaelzZ6pcnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxYWdbCO5gX53N44ANCyUYiC0RfpkSMJ3Chn3+ru1gKhv61uYggJ9PzmXCNv80RqwlSbO3ko85ivsOo4nBV2uA7KTyidflWYw+pD9Doo0cKufOM7M0c9TZDH7PAOlZVVPqKLA0SuocaRmDlHzP8Upp2vqVfNgtGO1aebhmHmOfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CUa+K4IV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108B9C116C6;
	Mon,  9 Feb 2026 14:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770649004;
	bh=p1aHKLsC0RMmuY5Y8PQQ6oBGbaawp+XspaelzZ6pcnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CUa+K4IVyQZQnj4MB/NitNKlAkbCAU1CLr42ovx6USNqHc04g71B0IlqfOxnCT0CX
	 MLF7eX/wj2k9vL4Q8VfLASu7w6lOtdcB6qoyLcM+4ES8P9l5EhLuOpCbAxt6rd3vAS
	 JVyJlMefvpX7tEZi4w7G9WarjUeYlAc5eo/vp01s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"jempty.liang" <imntjempty@163.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 64/75] tracing: Fix ftrace event field alignments
Date: Mon,  9 Feb 2026 15:25:01 +0100
Message-ID: <20260209142304.148190676@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142301.830618238@linuxfoundation.org>
References: <20260209142301.830618238@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215501-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,efficios.com,arm.com,kernel.org,163.com,goodmis.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,efficios.com:email]
X-Rspamd-Queue-Id: A82BE111C6B
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 033c55fe2e326bea022c3cc5178ecf3e0e459b82 ]

The fields of ftrace specific events (events used to save ftrace internal
events like function traces and trace_printk) are generated similarly to
how normal trace event fields are generated. That is, the fields are added
to a trace_events_fields array that saves the name, offset, size,
alignment and signness of the field. It is used to produce the output in
the format file in tracefs so that tooling knows how to parse the binary
data of the trace events.

The issue is that some of the ftrace event structures are packed. The
function graph exit event structures are one of them. The 64 bit calltime
and rettime fields end up 4 byte aligned, but the algorithm to show to
userspace shows them as 8 byte aligned.

The macros that create the ftrace events has one for embedded structure
fields. There's two macros for theses fields:

  __field_desc() and __field_packed()

The difference of the latter macro is that it treats the field as packed.

Rename that field to __field_desc_packed() and create replace the
__field_packed() to be a normal field that is packed and have the calltime
and rettime use those.

This showed up on 32bit architectures for function graph time fields. It
had:

 ~# cat /sys/kernel/tracing/events/ftrace/funcgraph_exit/format
[..]
        field:unsigned long func;       offset:8;       size:4; signed:0;
        field:unsigned int depth;       offset:12;      size:4; signed:0;
        field:unsigned int overrun;     offset:16;      size:4; signed:0;
        field:unsigned long long calltime;      offset:24;      size:8; signed:0;
        field:unsigned long long rettime;       offset:32;      size:8; signed:0;

Notice that overrun is at offset 16 with size 4, where in the structure
calltime is at offset 20 (16 + 4), but it shows the offset at 24. That's
because it used the alignment of unsigned long long when used as a
declaration and not as a member of a structure where it would be aligned
by word size (in this case 4).

By using the proper structure alignment, the format has it at the correct
offset:

 ~# cat /sys/kernel/tracing/events/ftrace/funcgraph_exit/format
[..]
        field:unsigned long func;       offset:8;       size:4; signed:0;
        field:unsigned int depth;       offset:12;      size:4; signed:0;
        field:unsigned int overrun;     offset:16;      size:4; signed:0;
        field:unsigned long long calltime;      offset:20;      size:8; signed:0;
        field:unsigned long long rettime;       offset:28;      size:8; signed:0;

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reported-by: "jempty.liang" <imntjempty@163.com>
Link: https://patch.msgid.link/20260204113628.53faec78@gandalf.local.home
Fixes: 04ae87a52074e ("ftrace: Rework event_create_dir()")
Closes: https://lore.kernel.org/all/20260130015740.212343-1-imntjempty@163.com/
Closes: https://lore.kernel.org/all/20260202123342.2544795-1-imntjempty@163.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
[ Context / renames ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace.h         |    7 +++++--
 kernel/trace/trace_entries.h |   14 +++++++-------
 kernel/trace/trace_export.c  |   21 +++++++++++++++------
 3 files changed, 27 insertions(+), 15 deletions(-)

--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -65,14 +65,17 @@ enum trace_type {
 #undef __field_fn
 #define __field_fn(type, item)		type	item;
 
+#undef __field_packed
+#define __field_packed(type, item)	type	item;
+
 #undef __field_struct
 #define __field_struct(type, item)	__field(type, item)
 
 #undef __field_desc
 #define __field_desc(type, container, item)
 
-#undef __field_packed
-#define __field_packed(type, container, item)
+#undef __field_desc_packed
+#define __field_desc_packed(type, container, item)
 
 #undef __array
 #define __array(type, item, size)	type	item[size];
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -78,8 +78,8 @@ FTRACE_ENTRY_PACKED(funcgraph_entry, ftr
 
 	F_STRUCT(
 		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
-		__field_packed(	unsigned long,	graph_ent,	func		)
-		__field_packed(	int,		graph_ent,	depth		)
+		__field_desc_packed(	unsigned long,	graph_ent,	func	)
+		__field_desc_packed(	int,		graph_ent,	depth	)
 	),
 
 	F_printk("--> %ps (%d)", (void *)__entry->func, __entry->depth)
@@ -92,11 +92,11 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftra
 
 	F_STRUCT(
 		__field_struct(	struct ftrace_graph_ret,	ret	)
-		__field_packed(	unsigned long,	ret,		func	)
-		__field_packed(	int,		ret,		depth	)
-		__field_packed(	unsigned int,	ret,		overrun	)
-		__field_packed(	unsigned long long, ret,	calltime)
-		__field_packed(	unsigned long long, ret,	rettime	)
+		__field_desc_packed(	unsigned long,	ret,	func	)
+		__field_desc_packed(	int,		ret,	depth	)
+		__field_desc_packed(	unsigned int,	ret,	overrun	)
+		__field_desc_packed(	unsigned long long, ret,	calltime)
+		__field_desc_packed(	unsigned long long, ret,	rettime	)
 	),
 
 	F_printk("<-- %ps (%d) (start: %llx  end: %llx) over: %d",
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -42,11 +42,14 @@ static int ftrace_event_register(struct
 #undef __field_fn
 #define __field_fn(type, item)				type item;
 
+#undef __field_packed
+#define __field_packed(type, item)			type item;
+
 #undef __field_desc
 #define __field_desc(type, container, item)		type item;
 
-#undef __field_packed
-#define __field_packed(type, container, item)		type item;
+#undef __field_desc_packed
+#define __field_desc_packed(type, container, item)	type item;
 
 #undef __array
 #define __array(type, item, size)			type item[size];
@@ -101,11 +104,14 @@ static void __always_unused ____ftrace_c
 #undef __field_fn
 #define __field_fn(_type, _item) __field_ext(_type, _item, FILTER_TRACE_FN)
 
+#undef __field_packed
+#define __field_packed(_type, _item) __field_ext_packed(_type, _item, FILTER_OTHER)
+
 #undef __field_desc
 #define __field_desc(_type, _container, _item) __field_ext(_type, _item, FILTER_OTHER)
 
-#undef __field_packed
-#define __field_packed(_type, _container, _item) __field_ext_packed(_type, _item, FILTER_OTHER)
+#undef __field_desc_packed
+#define __field_desc_packed(_type, _container, _item) __field_ext_packed(_type, _item, FILTER_OTHER)
 
 #undef __array
 #define __array(_type, _item, _len) {					\
@@ -139,11 +145,14 @@ static struct trace_event_fields ftrace_
 #undef __field_fn
 #define __field_fn(type, item)
 
+#undef __field_packed
+#define __field_packed(type, item)
+
 #undef __field_desc
 #define __field_desc(type, container, item)
 
-#undef __field_packed
-#define __field_packed(type, container, item)
+#undef __field_desc_packed
+#define __field_desc_packed(type, container, item)
 
 #undef __array
 #define __array(type, item, len)



