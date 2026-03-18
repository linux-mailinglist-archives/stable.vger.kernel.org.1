Return-Path: <stable+bounces-227027-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IjXCCePumnSXgIAu9opvQ
	(envelope-from <stable+bounces-227027-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:40:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 830B42BAF53
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DE54302A50F
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621B337998A;
	Wed, 18 Mar 2026 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3uJpPa9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265D83C5522
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773833841; cv=none; b=Tdob2fYLpeEwCHueZneV08VOYtZMvMTvJbYprhSM3dyTM7nDMpmcHWQX+bmGeqRvUC/gnm41qJO7vUQgEIv2vD10NQktO0dIKV1l+U8VgzTkrgdQ2nMWuRheCCIKnd6fvzjDNKRr7zTwVE+JZB+LZRyTKP1OOEljsRdL0ZVceX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773833841; c=relaxed/simple;
	bh=iWoDGKb/PtRoCjsKx3HvRfo08Vyd+OWzjmXSWc4z4/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CG8LbyPzgnkzjG3Ah3p7kenOdQSqQU2bCnWp4dOjqDKAJGdh/awtPi+XV6ZNEwCtdqGVFB7P2krs1Hq2gocoh492XfJrYc/MFH4UzN43vnanGLNyHApQ96IZos3WdEdiPOCR65v2ktGIstGEI0kuthe5rWbSR60mlgIm8PqNnsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3uJpPa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C83FC19421;
	Wed, 18 Mar 2026 11:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773833840;
	bh=iWoDGKb/PtRoCjsKx3HvRfo08Vyd+OWzjmXSWc4z4/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a3uJpPa9hnV07kN/C1ra/25krpRda4CHuWHDQVvv+hBBCQlD/ZN8LertrruSc1eMC
	 C4mGAZdKXE5jCzUBqGVSViu70O1v8mK7rWJZBp8/zJ1c9VGNapdJelucyYWe+z7+L6
	 QwpX+CQmRDDzy9g9GeMZotNNzjcTP3blh9y+Zx0riwvZnx13LuTzM53s24ZCC6FtoH
	 SdMiopnAjLEYabu63rRtWpvlmOdO1ViYnrWOHfieNltl7UfCJmbWauis4Vu7dhGloM
	 wpZpxuZnc/UbvpbcXpENcrlR5aiH3DhhYf/nlf8Wl94DQvVLQWA9mtxq90QfMDG4NR
	 BXYJt67Ed5aMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huiwen He <hehuiwen@kylinos.cn>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tracing: Fix syscall events activation by ensuring refcount hits zero
Date: Wed, 18 Mar 2026 07:37:18 -0400
Message-ID: <20260318113718.630011-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031720-unclaimed-kerosene-1b97@gregkh>
References: <2026031720-unclaimed-kerosene-1b97@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227027-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,msgid.link:url,efficios.com:email]
X-Rspamd-Queue-Id: 830B42BAF53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Huiwen He <hehuiwen@kylinos.cn>

[ Upstream commit 0a663b764dbdf135a126284f454c9f01f95a87d4 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events.c | 51 ++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 1dfdbd365c8c2..622e9030c6d18 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3841,27 +3841,23 @@ static __init int event_trace_memsetup(void)
 	return 0;
 }
 
-static __init void
-early_enable_events(struct trace_array *tr, bool disable_first)
+/*
+ * Helper function to enable or disable a comma-separated list of events
+ * from the bootup buffer.
+ */
+static __init void __early_set_events(struct trace_array *tr, bool enable)
 {
 	char *buf = bootup_event_buf;
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
@@ -3870,6 +3866,31 @@ early_enable_events(struct trace_array *tr, bool disable_first)
 	}
 }
 
+/**
+ * early_enable_events - enable events from the bootup buffer
+ * @tr: The trace array to enable the events in
+ * @disable_first: If true, disable all events before enabling them
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
+static __init void
+early_enable_events(struct trace_array *tr, bool disable_first)
+{
+	if (disable_first)
+		__early_set_events(tr, false);
+
+	__early_set_events(tr, true);
+}
+
 static __init int event_trace_enable(void)
 {
 	struct trace_array *tr = top_trace_array();
-- 
2.51.0


