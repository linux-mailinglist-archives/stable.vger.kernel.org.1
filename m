Return-Path: <stable+bounces-214777-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNRsHw5Ph2mjWAQAu9opvQ
	(envelope-from <stable+bounces-214777-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 15:41:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0470D1063B0
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 15:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFA59301725E
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 14:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF7F3033F5;
	Sat,  7 Feb 2026 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uUTXQTzn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008DE227563
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770475276; cv=none; b=Aa1iy9/tMYapvWdBg3t88e9DtyZ8z+Plp/n9fktf6VwcaKVk4szxJGdcrgS+JPs8aZ0DBfd6kDSTP/L3ff3BI+SgOuECduyVgNcqRD6kRqcxogAy0OoUNcqy3hDFRmdleu55JQAN3qLIy1Q5Jr7M7FQ+UTvf1B4Kq+IoyvhpU+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770475276; c=relaxed/simple;
	bh=GyA5acxyVDhTWrJUYd1j0VAaiET9HC+I43M+xOB7sGc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aWUo2a3zmKs9dAzg6IRSUoXis+BTMN/FEOQxdv0clbL8ZvTfuRrXcga4DlqJtl6hXQptHv2uOofnT/qRwRQmFeFkkD/0zy/A4NW+FmwqkeqSqyVp4KvMUb4ty/r39fL+/l3SGShavSK6i+Ul8pwOMT5ppCGZsjs2B0dhU8JSC20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uUTXQTzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A06C116D0;
	Sat,  7 Feb 2026 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770475275;
	bh=GyA5acxyVDhTWrJUYd1j0VAaiET9HC+I43M+xOB7sGc=;
	h=Subject:To:Cc:From:Date:From;
	b=uUTXQTznz2YYSCp31WrWUtZNdZM+aVOK7uTYff1pa5IpqfzOS7SIfCXiDncURtMZl
	 O6f1zF1eWDeUoxULBpSWtoL64tUfXSUf7CjXcSxjXcWd+K3ryQsTD7PX9a9V11OkcH
	 9jCf31yQbZUwLGGKOTS7msio092d36GYw1DFBiS0=
Subject: FAILED: patch "[PATCH] tracing: Fix ftrace event field alignments" failed to apply to 5.10-stable tree
To: rostedt@goodmis.org,imntjempty@163.com,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 07 Feb 2026 15:41:04 +0100
Message-ID: <2026020704-deranged-unwind-6beb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214777-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[goodmis.org,163.com,arm.com,efficios.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goodmis.org:email,msgid.link:url,efficios.com:email,gregkh:email,linuxfoundation.org:dkim,arm.com:email]
X-Rspamd-Queue-Id: 0470D1063B0
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 033c55fe2e326bea022c3cc5178ecf3e0e459b82
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026020704-deranged-unwind-6beb@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 033c55fe2e326bea022c3cc5178ecf3e0e459b82 Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 4 Feb 2026 11:36:28 -0500
Subject: [PATCH] tracing: Fix ftrace event field alignments

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

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b6d42fe06115..c11edec5d8f5 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -68,14 +68,17 @@ enum trace_type {
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
index f6a8d29c0d76..54417468fdeb 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -79,8 +79,8 @@ FTRACE_ENTRY(funcgraph_entry, ftrace_graph_ent_entry,
 
 	F_STRUCT(
 		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
-		__field_packed(	unsigned long,	graph_ent,	func		)
-		__field_packed(	unsigned long,	graph_ent,	depth		)
+		__field_desc_packed(unsigned long,	graph_ent,	func	)
+		__field_desc_packed(unsigned long,	graph_ent,	depth	)
 		__dynamic_array(unsigned long,	args				)
 	),
 
@@ -96,9 +96,9 @@ FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgraph_retaddr_ent_entry,
 
 	F_STRUCT(
 		__field_struct(	struct fgraph_retaddr_ent,	graph_rent	)
-		__field_packed(	unsigned long,	graph_rent.ent,	func		)
-		__field_packed(	unsigned long,	graph_rent.ent,	depth		)
-		__field_packed(	unsigned long,	graph_rent,	retaddr		)
+		__field_desc_packed(	unsigned long,	graph_rent.ent,	func	)
+		__field_desc_packed(	unsigned long,	graph_rent.ent,	depth	)
+		__field_desc_packed(	unsigned long,	graph_rent,	retaddr	)
 		__dynamic_array(unsigned long,	args				)
 	),
 
@@ -123,12 +123,12 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 
 	F_STRUCT(
 		__field_struct(	struct ftrace_graph_ret,	ret	)
-		__field_packed(	unsigned long,	ret,		func	)
-		__field_packed(	unsigned long,	ret,		retval	)
-		__field_packed(	unsigned int,	ret,		depth	)
-		__field_packed(	unsigned int,	ret,		overrun	)
-		__field(unsigned long long,	calltime		)
-		__field(unsigned long long,	rettime			)
+		__field_desc_packed(	unsigned long,	ret,	func	)
+		__field_desc_packed(	unsigned long,	ret,	retval	)
+		__field_desc_packed(	unsigned int,	ret,	depth	)
+		__field_desc_packed(	unsigned int,	ret,	overrun	)
+		__field_packed(unsigned long long,	calltime)
+		__field_packed(unsigned long long,	rettime	)
 	),
 
 	F_printk("<-- %ps (%u) (start: %llx  end: %llx) over: %u retval: %lx",
@@ -146,11 +146,11 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 
 	F_STRUCT(
 		__field_struct(	struct ftrace_graph_ret,	ret	)
-		__field_packed(	unsigned long,	ret,		func	)
-		__field_packed(	unsigned int,	ret,		depth	)
-		__field_packed(	unsigned int,	ret,		overrun	)
-		__field(unsigned long long,	calltime		)
-		__field(unsigned long long,	rettime			)
+		__field_desc_packed(	unsigned long,	ret,	func	)
+		__field_desc_packed(	unsigned int,	ret,	depth	)
+		__field_desc_packed(	unsigned int,	ret,	overrun	)
+		__field_packed(unsigned long long,	calltime	)
+		__field_packed(unsigned long long,	rettime		)
 	),
 
 	F_printk("<-- %ps (%u) (start: %llx  end: %llx) over: %u",
diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index 1698fc22afa0..32a42ef31855 100644
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


