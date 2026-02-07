Return-Path: <stable+bounces-214808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMU+He5th2miXwQAu9opvQ
	(envelope-from <stable+bounces-214808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 17:53:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F6710691B
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 17:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86CE9302C91F
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 16:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB33337BAA;
	Sat,  7 Feb 2026 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7W/HKTt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE7A337B81
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770483142; cv=none; b=fUCeCbxikS87a0cW3TXjI5PhQtHtirDdS9obRFOAbOgEj682uVNd7i3RHErwRMYUjKDgP5SYjs4+xPkjm6zNmQdFKiLdUMithXLrhUmAuaUIQ9fb/7tYTucRSjWqgDNf0XoHG0tHKo+WxAu9ICDCWQS+txHAXOta3x+J+Omr1zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770483142; c=relaxed/simple;
	bh=fDvO0U1kWGQQsQiiE33dtDXDyNNpaFoqoDpz/LF6o6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvIFtzZ5D92L9sp2QBL5PeFwJ72fPu6F0WWv7J+UY4rQ9H82/BKorM+CkWBNcfG/A89LlQu6QxKn486ndtTy4jDiMUPN83s1fRe+tBLAZlR5ddoqF2ckWKRw9iK8+r2d1t7WXJd/m1tXfJi+19GJv32kSYXQeIOL7UcK1SZ9n1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7W/HKTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF758C116D0;
	Sat,  7 Feb 2026 16:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770483141;
	bh=fDvO0U1kWGQQsQiiE33dtDXDyNNpaFoqoDpz/LF6o6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d7W/HKTtO7fLVVAlJLzsVEEV1ktersaj2V3KSBu4lt7ALfSH92ZLRYyxHf+h45o/H
	 Szxym1JI6FiJBMvm0bO9/96UwDPa/nNoHZYzjoxNuVJFP63j+QQ9k38lJRrGPS2PbV
	 Lmr+QtKPk9CdRXoGBXBCltW2/leiCTo/XX/Vt4p5cLvZiI5psob8krDWt1CHR7MkuZ
	 zLSgI5LtDmt+ae/PulmkCwTtxhGYeSfL7QhRoffNmZRc3NPl6hIKPrZ8uSmX5BDOPr
	 qUan0xrXHgiQN0X6lHHDUI0DEBmDNnJngatXJnyh2C1x7par2wR6X6QLidFmhj5Chc
	 iArEhtPYpvkDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"jempty.liang" <imntjempty@163.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] tracing: Fix ftrace event field alignments
Date: Sat,  7 Feb 2026 11:52:19 -0500
Message-ID: <20260207165219.435349-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020757-contented-untagged-12fa@gregkh>
References: <2026020757-contented-untagged-12fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[goodmis.org,efficios.com,arm.com,kernel.org,163.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214808-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: C5F6710691B
X-Rspamd-Action: no action

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
[ adapted field types and macro arguments ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.h         |  7 +++++--
 kernel/trace/trace_entries.h | 26 +++++++++++++-------------
 kernel/trace/trace_export.c  | 21 +++++++++++++++------
 3 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index c91f3c47ac642..7ba372c21fee6 100644
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
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index c47422b209085..3e3c08a18cafc 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -78,8 +78,8 @@ FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
 
 	F_STRUCT(
 		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
-		__field_packed(	unsigned long,	graph_ent,	func		)
-		__field_packed(	int,		graph_ent,	depth		)
+		__field_desc_packed(	unsigned long,	graph_ent,	func	)
+		__field_desc_packed(	int,		graph_ent,	depth	)
 	),
 
 	F_printk("--> %ps (%d)", (void *)__entry->func, __entry->depth)
@@ -94,12 +94,12 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 
 	F_STRUCT(
 		__field_struct(	struct ftrace_graph_ret,	ret	)
-		__field_packed(	unsigned long,	ret,		func	)
-		__field_packed(	unsigned long,	ret,		retval	)
-		__field_packed(	int,		ret,		depth	)
-		__field_packed(	unsigned int,	ret,		overrun	)
-		__field_packed(	unsigned long long, ret,	calltime)
-		__field_packed(	unsigned long long, ret,	rettime	)
+		__field_desc_packed(	unsigned long,	ret,	func	)
+		__field_desc_packed(	unsigned long,	ret,	retval	)
+		__field_desc_packed(	int,		ret,	depth	)
+		__field_desc_packed(	unsigned int,	ret,	overrun	)
+		__field_packed(unsigned long long,	calltime)
+		__field_packed(unsigned long long,	rettime	)
 	),
 
 	F_printk("<-- %ps (%d) (start: %llx  end: %llx) over: %d retval: %lx",
@@ -116,11 +116,11 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 
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
+		__field_packed(unsigned long long,	calltime)
+		__field_packed(unsigned long long,	rettime	)
 	),
 
 	F_printk("<-- %ps (%d) (start: %llx  end: %llx) over: %d",
diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index 1698fc22afa0a..32a42ef31855d 100644
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -42,11 +42,14 @@ static int ftrace_event_register(struct trace_event_call *call,
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
@@ -104,11 +107,14 @@ static void __always_unused ____ftrace_check_##name(void)		\
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
@@ -146,11 +152,14 @@ static struct trace_event_fields ftrace_event_fields_##name[] = {	\
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
-- 
2.51.0


