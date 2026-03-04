Return-Path: <stable+bounces-223142-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mA85EEWvqGmfwQAAu9opvQ
	(envelope-from <stable+bounces-223142-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 23:16:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB180208679
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 23:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04EA23120AF6
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 22:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DA03DA5B4;
	Wed,  4 Mar 2026 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkVBo3Bx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45233D6CB7;
	Wed,  4 Mar 2026 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661780; cv=none; b=leRFBgalXHXVCVMZy5msWiSmrFs0qnuui2t5SreVsNmoaLDhPeyXTVwNnrP/kg4AM9dWHCEsSpQF2Nu/q8soQJexY+HNHmObliwenYpJMdV4kuy6WEEz6vyDoJnD6uL7u8wfrWZbBQAbjI13t0Mi96NYFDlV+4xYkaSGgPV+hYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661780; c=relaxed/simple;
	bh=0i5hT8Z74T93H/wO2F164L4qWNE1jCWR+upwBp3w7H0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=WM7RMS8ZMxp3mabJdXt5B78eWlWFKZKTqiEbKH2KuBZIh4J9Q9Wq8NV0SwZWH4vwfaorwGNMdDFkX2lDPyriItDXDMu+g2St8P5H8YBTJo6b1PEoqvWJMjoDSU4AbKBeRPLVrxEqVK1ZIeNTWpJ3AiYiz1gx0/l2dCGL0RU3qLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkVBo3Bx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DB3C2BCB3;
	Wed,  4 Mar 2026 22:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661780;
	bh=0i5hT8Z74T93H/wO2F164L4qWNE1jCWR+upwBp3w7H0=;
	h=Date:From:To:Cc:Subject:References:From;
	b=nkVBo3Bx8zLhbD74iM/DcXMIMOv1JB2YkeP7ECoVfKnHdIXaH53G0DyH2vJvBPzw/
	 qG/igAG7l0Aia8NSFS27Dejb7Tco7Nc0COOx5xv7N6XGspDY4YGwE+oZ0R82f8N1w2
	 5riOUv408AeocbTTwiZHOfeJJE7O+Pz4RsLpsGB+H6XXebLvrcjUoFyU6GEO1FP1As
	 S98SmANlsthhD+t2pIbNlxt+4iMq9kBrqCpfaiBG67vgpyMavyKrwUb6kwg/UjOTIG
	 Tm4R2crvcsdMDNXQaviERWny4I+Cv9Z17LrQ1XMakfNGh5k2oZQb8M+IIJFIyrv4tB
	 wE82oBccjs8SQ==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vxuJd-00000003CRl-3W2W;
	Wed, 04 Mar 2026 17:03:37 -0500
Message-ID: <20260304220337.692328724@kernel.org>
User-Agent: quilt/0.69
Date: Wed, 04 Mar 2026 17:03:22 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Huiwen He <hehuiwen@kylinos.cn>
Subject: [for-linus][PATCH 3/6] tracing: Fix syscall events activation by ensuring refcount hits zero
References: <20260304220319.218314827@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: AB180208679
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223142-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,efficios.com:email,goodmis.org:email,msgid.link:url,kylinos.cn:email]
X-Rspamd-Action: no action

From: Huiwen He <hehuiwen@kylinos.cn>

When multiple syscall events are specified in the kernel command line
(e.g., trace_event=syscalls:sys_enter_openat,syscalls:sys_enter_close),
they are often not captured after boot, even though they appear enabled
in the tracing/set_event file.

The issue stems from how syscall events are initialized. Syscall
tracepoints require the global reference count (sys_tracepoint_refcount)
to transition from 0 to 1 to trigger the registration of the syscall
work (TIF_SYSCALL_TRACEPOINT) for tasks, including the init process (pid 1).

The current implementation of early_enable_events() with disable_first=true
used an interleaved sequence of "Disable A -> Enable A -> Disable B -> Enable B".
If multiple syscalls are enabled, the refcount never drops to zero,
preventing the 0->1 transition that triggers actual registration.

Fix this by splitting early_enable_events() into two distinct phases:
1. Disable all events specified in the buffer.
2. Enable all events specified in the buffer.

This ensures the refcount hits zero before re-enabling, allowing syscall
events to be properly activated during early boot.

The code is also refactored to use a helper function to avoid logic
duplication between the disable and enable phases.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20260224023544.1250787-1-hehuiwen@kylinos.cn
Fixes: ce1039bd3a89 ("tracing: Fix enabling of syscall events on the command line")
Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 52 ++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9928da636c9d..9c7f26cbe171 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -4668,26 +4668,22 @@ static __init int event_trace_memsetup(void)
 	return 0;
 }
 
-__init void
-early_enable_events(struct trace_array *tr, char *buf, bool disable_first)
+/*
+ * Helper function to enable or disable a comma-separated list of events
+ * from the bootup buffer.
+ */
+static __init void __early_set_events(struct trace_array *tr, char *buf, bool enable)
 {
 	char *token;
-	int ret;
-
-	while (true) {
-		token = strsep(&buf, ",");
-
-		if (!token)
-			break;
 
+	while ((token = strsep(&buf, ","))) {
 		if (*token) {
-			/* Restarting syscalls requires that we stop them first */
-			if (disable_first)
+			if (enable) {
+				if (ftrace_set_clr_event(tr, token, 1))
+					pr_warn("Failed to enable trace event: %s\n", token);
+			} else {
 				ftrace_set_clr_event(tr, token, 0);
-
-			ret = ftrace_set_clr_event(tr, token, 1);
-			if (ret)
-				pr_warn("Failed to enable trace event: %s\n", token);
+			}
 		}
 
 		/* Put back the comma to allow this to be called again */
@@ -4696,6 +4692,32 @@ early_enable_events(struct trace_array *tr, char *buf, bool disable_first)
 	}
 }
 
+/**
+ * early_enable_events - enable events from the bootup buffer
+ * @tr: The trace array to enable the events in
+ * @buf: The buffer containing the comma separated list of events
+ * @disable_first: If true, disable all events in @buf before enabling them
+ *
+ * This function enables events from the bootup buffer. If @disable_first
+ * is true, it will first disable all events in the buffer before enabling
+ * them.
+ *
+ * For syscall events, which rely on a global refcount to register the
+ * SYSCALL_WORK_SYSCALL_TRACEPOINT flag (especially for pid 1), we must
+ * ensure the refcount hits zero before re-enabling them. A simple
+ * "disable then enable" per-event is not enough if multiple syscalls are
+ * used, as the refcount will stay above zero. Thus, we need a two-phase
+ * approach: disable all, then enable all.
+ */
+__init void
+early_enable_events(struct trace_array *tr, char *buf, bool disable_first)
+{
+	if (disable_first)
+		__early_set_events(tr, buf, false);
+
+	__early_set_events(tr, buf, true);
+}
+
 static __init int event_trace_enable(void)
 {
 	struct trace_array *tr = top_trace_array();
-- 
2.51.0



