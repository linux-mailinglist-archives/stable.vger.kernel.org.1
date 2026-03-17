Return-Path: <stable+bounces-225867-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJ69D4FDuWkk+QEAu9opvQ
	(envelope-from <stable+bounces-225867-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:05:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF12E2A97AA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB4A0307E258
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C74346792;
	Tue, 17 Mar 2026 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2FuGsBRw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132BEFC0A
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748897; cv=none; b=Ss3kLo0cSXUo4bZY8bIH+Sp0918GklqYn1R/PNihAO911eGEUuHxdrVYClb871VmKKGWlmqK/3avsK2FCCPyU+QBsSaSwtqs5YSyDsDI+1Gmoz9Lqv1liWoBvqb9FsqXR6KUM6mlBOeRGPebfYysUSW+iSXG/Z2kFyUEzl/x5y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748897; c=relaxed/simple;
	bh=HkmCEtlK96jGju+gXGb1+lXlVMU6SvMY5QbBYE1iCUs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RSwvgCxDoRM0IOj/i0a2lDtFAHVp0NE42OSU1bDkcSWt2U0ezcAZykJIf9zSYuoTsMzH3S/TmzKB+9IlUN47HNfryk2wuLIJllj86bPdrEgjIyjfwqnkYI4XMTwax9GAvoZTQVuNRQf2OihT826ucw5Ug0iMAu0NVGyzpoLN/bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2FuGsBRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5810FC19425;
	Tue, 17 Mar 2026 12:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773748896;
	bh=HkmCEtlK96jGju+gXGb1+lXlVMU6SvMY5QbBYE1iCUs=;
	h=Subject:To:Cc:From:Date:From;
	b=2FuGsBRww2b3Gy79uTO6+Bn8r2Ze5IzbT9AYHkmmZIhEd6+XfYOhrF+x2cKdVzjVX
	 ybmNBZC3BKe5GzYzkhkqY9418DgY7Sge12i8qY1AI62WUP08/qw3JJ2x3ZZLP9Al8Q
	 jcm0z0Auz/zMtll5J8WAYZX3V9YbalminHlZpszs=
Subject: FAILED: patch "[PATCH] tracing: Fix syscall events activation by ensuring refcount" failed to apply to 5.15-stable tree
To: hehuiwen@kylinos.cn,mathieu.desnoyers@efficios.com,mhiramat@kernel.org,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:01:21 +0100
Message-ID: <2026031720-unclaimed-kerosene-1b97@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225867-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.961];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,efficios.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,goodmis.org:email]
X-Rspamd-Queue-Id: CF12E2A97AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0a663b764dbdf135a126284f454c9f01f95a87d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031720-unclaimed-kerosene-1b97@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0a663b764dbdf135a126284f454c9f01f95a87d4 Mon Sep 17 00:00:00 2001
From: Huiwen He <hehuiwen@kylinos.cn>
Date: Tue, 24 Feb 2026 10:35:44 +0800
Subject: [PATCH] tracing: Fix syscall events activation by ensuring refcount
 hits zero

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


