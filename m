Return-Path: <stable+bounces-227966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCu+OHM4wWm7RQQAu9opvQ
	(envelope-from <stable+bounces-227966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:56:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA2E2F24DE
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 227A6301D56D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 12:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38733A9002;
	Mon, 23 Mar 2026 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kM2hGPKX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D8B39BFF4
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270378; cv=none; b=TEo0KbIC2cufax+MTtScaScLOgODE8zgHQ8rn0S6k3C7Fm0XCTKKWQ+XiLY07rkgAmUtIxfbgBlw0Ux6YoHdSnDj89dfASCXSOGtVzCTB9gJ07mbutHrngAKE/sDZi/GKOHNbVpn5b3g/CmrDgABaFZIuxQgTDGYCBBdCAJh360=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270378; c=relaxed/simple;
	bh=CQwFQPWlhS8jL+AgKYwZLtL/BEGJKAnmnfbhNFpjV5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqZz4yeohI+81UE/4OLrOwppxt3Jvgo62FZQ35tnRQYcsbtaVCcXnM6RWfy0yFy40DAn7iu8vl0vvRBtlAr41S5OrOa0Uk5L3Hyre6DUL1tzgAGpLVK8pAoQ8+Gpkhgax8GAiMxZXEtk2yMREp6nTTCKCrhHZPWboDA2JAal930=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kM2hGPKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADFDC4CEF7;
	Mon, 23 Mar 2026 12:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774270378;
	bh=CQwFQPWlhS8jL+AgKYwZLtL/BEGJKAnmnfbhNFpjV5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kM2hGPKXmJSbH8bdyG2jOYsOINTFGQ4LyhRZkLmv9eJ+iL3mMfSDlZ9mnUfeUSVwd
	 3d/EatW4FWOhWXmiwhyeufwTfBc+wTK84fLOZo+zZJUm2MHVkd3G1vLk25GPJJg8JS
	 +1a2ly6POXxdndlUZCiW9flSNe3rBOElQdIHvBGjGLLwcDDJ/mllMv0t+UVCQEDccG
	 jRzZCTkQVY3IYRA+LUqofvAaU0OlON7KJAAgYjAl3hd/9EAdCmYhYg6QUUX2Zza2uV
	 w/DvwHvDYGyERTSK3D81fstAJ6OxMqfB98LSCw7HpLmcPSjBF4kR2I3Pi+JsQ8ybw3
	 GVaC8tHHXfbqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] tracing: Fix trace_marker copy link list updates
Date: Mon, 23 Mar 2026 08:52:55 -0400
Message-ID: <20260323125255.1649344-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026032336-exhale-bounce-7a32@gregkh>
References: <2026032336-exhale-bounce-7a32@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227966-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,efficios.com:email]
X-Rspamd-Queue-Id: BBA2E2F24DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 07183aac4a6828e474f00b37c9d795d0d99e18a7 ]

When the "copy_trace_marker" option is enabled for an instance, anything
written into /sys/kernel/tracing/trace_marker is also copied into that
instances buffer. When the option is set, that instance's trace_array
descriptor is added to the marker_copies link list. This list is protected
by RCU, as all iterations uses an RCU protected list traversal.

When the instance is deleted, all the flags that were enabled are cleared.
This also clears the copy_trace_marker flag and removes the trace_array
descriptor from the list.

The issue is after the flags are called, a direct call to
update_marker_trace() is performed to clear the flag. This function
returns true if the state of the flag changed and false otherwise. If it
returns true here, synchronize_rcu() is called to make sure all readers
see that its removed from the list.

But since the flag was already cleared, the state does not change and the
synchronization is never called, leaving a possible UAF bug.

Move the clearing of all flags below the updating of the copy_trace_marker
option which then makes sure the synchronization is performed.

Also use the flag for checking the state in update_marker_trace() instead
of looking at if the list is empty.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20260318185512.1b6c7db4@gandalf.local.home
Fixes: 7b382efd5e8a ("tracing: Allow the top level trace_marker to write into another instances")
Reported-by: Sasha Levin <sashal@kernel.org>
Closes: https://lore.kernel.org/all/20260225133122.237275-1-sashal@kernel.org/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ff5d0b6d52e03..b5f88fcfd4ddc 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -569,7 +569,7 @@ static bool update_marker_trace(struct trace_array *tr, int enabled)
 	lockdep_assert_held(&event_mutex);
 
 	if (enabled) {
-		if (!list_empty(&tr->marker_list))
+		if (tr->trace_flags & TRACE_ITER_COPY_MARKER)
 			return false;
 
 		list_add_rcu(&tr->marker_list, &marker_copies);
@@ -577,10 +577,10 @@ static bool update_marker_trace(struct trace_array *tr, int enabled)
 		return true;
 	}
 
-	if (list_empty(&tr->marker_list))
+	if (!(tr->trace_flags & TRACE_ITER_COPY_MARKER))
 		return false;
 
-	list_del_init(&tr->marker_list);
+	list_del_rcu(&tr->marker_list);
 	tr->trace_flags &= ~TRACE_ITER_COPY_MARKER;
 	return true;
 }
@@ -10215,18 +10215,19 @@ static int __remove_instance(struct trace_array *tr)
 
 	list_del(&tr->list);
 
-	/* Disable all the flags that were enabled coming in */
-	for (i = 0; i < TRACE_FLAGS_MAX_SIZE; i++) {
-		if ((1 << i) & ZEROED_TRACE_FLAGS)
-			set_tracer_flag(tr, 1 << i, 0);
-	}
-
 	if (printk_trace == tr)
 		update_printk_trace(&global_trace);
 
+	/* Must be done before disabling all the flags */
 	if (update_marker_trace(tr, 0))
 		synchronize_rcu();
 
+	/* Disable all the flags that were enabled coming in */
+	for (i = 0; i < TRACE_FLAGS_MAX_SIZE; i++) {
+		if ((1 << i) & ZEROED_TRACE_FLAGS)
+			set_tracer_flag(tr, 1 << i, 0);
+	}
+
 	tracing_set_nop(tr);
 	clear_ftrace_function_probes(tr);
 	event_trace_del_tracer(tr);
-- 
2.51.0


