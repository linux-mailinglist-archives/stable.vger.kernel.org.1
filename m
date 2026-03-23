Return-Path: <stable+bounces-227926-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G51N6AEwWlUPgQAu9opvQ
	(envelope-from <stable+bounces-227926-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:15:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4BE2EED0E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C285E3015E03
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E82D38643A;
	Mon, 23 Mar 2026 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aXK3aqbp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25D5339870
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 09:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774256939; cv=none; b=V2hItuxbJ/+q9EhH/wFR6ypJIytQkG5smNs2oKFiwhQHTy3K4Wo3puph0T3MfkBsLiX+i1TXoHYRO3Yes3cW02hDSaCapm2GUfvdlMYchdiveQx/fkLqOUVyNYw8aocpZHhX+7W603ywC4VLKlyLWRKt1LWAyPqObDKVkh+G/g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774256939; c=relaxed/simple;
	bh=ocQfAlqVqzHGPOTBRsx0F/yr19XOOV0AADyRRcfqyWQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=m1u5/Id/Sd2ku9MG/KduLSGbcZkNWek68wVE+14ES0EEU/VoclzYqZaDceG/BupALqIfOqJAFHan6pPwlmNjQKqk8JI7XZwIMvdJ4PgaDNOwL3kUFaLUn2kkd2oJKi6N23bHmIYzKIvRTmhL9MqeZuGlmMwCujC1XVXgxrFeWj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aXK3aqbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46601C4CEF7;
	Mon, 23 Mar 2026 09:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774256938;
	bh=ocQfAlqVqzHGPOTBRsx0F/yr19XOOV0AADyRRcfqyWQ=;
	h=Subject:To:Cc:From:Date:From;
	b=aXK3aqbpoKSAXJONpD/57CAtB85MnJP2lhL9eVc5Kfi5oNSldrH+fMTahJLHNgsE4
	 skgNg7h26ssVj9p0cR8nRJVM7pXvqA+9qAO3UqkkrbSLnNKr0INdcbf02vpRlIq9p1
	 UX092/Uqcj3sEQxE7pcKKlvw4V7t6aLzbPzQxqVY=
Subject: FAILED: patch "[PATCH] tracing: Fix trace_marker copy link list updates" failed to apply to 6.18-stable tree
To: rostedt@goodmis.org,mathieu.desnoyers@efficios.com,mhiramat@kernel.org,sashal@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Mar 2026 10:08:37 +0100
Message-ID: <2026032336-exhale-bounce-7a32@gregkh>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227926-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,10.30.226.201:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,gregkh:email,efficios.com:email,goodmis.org:email]
X-Rspamd-Queue-Id: 3F4BE2EED0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 07183aac4a6828e474f00b37c9d795d0d99e18a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032336-exhale-bounce-7a32@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 07183aac4a6828e474f00b37c9d795d0d99e18a7 Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 18 Mar 2026 18:55:12 -0400
Subject: [PATCH] tracing: Fix trace_marker copy link list updates

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

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bb4a62f4b953..a626211ceb9a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -555,7 +555,7 @@ static bool update_marker_trace(struct trace_array *tr, int enabled)
 	lockdep_assert_held(&event_mutex);
 
 	if (enabled) {
-		if (!list_empty(&tr->marker_list))
+		if (tr->trace_flags & TRACE_ITER(COPY_MARKER))
 			return false;
 
 		list_add_rcu(&tr->marker_list, &marker_copies);
@@ -563,10 +563,10 @@ static bool update_marker_trace(struct trace_array *tr, int enabled)
 		return true;
 	}
 
-	if (list_empty(&tr->marker_list))
+	if (!(tr->trace_flags & TRACE_ITER(COPY_MARKER)))
 		return false;
 
-	list_del_init(&tr->marker_list);
+	list_del_rcu(&tr->marker_list);
 	tr->trace_flags &= ~TRACE_ITER(COPY_MARKER);
 	return true;
 }
@@ -9761,18 +9761,19 @@ static int __remove_instance(struct trace_array *tr)
 
 	list_del(&tr->list);
 
+	if (printk_trace == tr)
+		update_printk_trace(&global_trace);
+
+	/* Must be done before disabling all the flags */
+	if (update_marker_trace(tr, 0))
+		synchronize_rcu();
+
 	/* Disable all the flags that were enabled coming in */
 	for (i = 0; i < TRACE_FLAGS_MAX_SIZE; i++) {
 		if ((1ULL << i) & ZEROED_TRACE_FLAGS)
 			set_tracer_flag(tr, 1ULL << i, 0);
 	}
 
-	if (printk_trace == tr)
-		update_printk_trace(&global_trace);
-
-	if (update_marker_trace(tr, 0))
-		synchronize_rcu();
-
 	tracing_set_nop(tr);
 	clear_ftrace_function_probes(tr);
 	event_trace_del_tracer(tr);


