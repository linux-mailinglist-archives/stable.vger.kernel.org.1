Return-Path: <stable+bounces-227809-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJBWIIBdv2ku3gMAu9opvQ
	(envelope-from <stable+bounces-227809-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 04:09:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EB22E80CE
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 04:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 887CF301778E
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 03:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6033837DEAE;
	Sun, 22 Mar 2026 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="St4VISp/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAD737C92D;
	Sun, 22 Mar 2026 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774148974; cv=none; b=hHUaowAFXKr/rE/FMz9/bFMUFWfPzlYcUQbrOipmCYHRx0W6UbxpAjPXOdVcKIr0JCQ2r57fjNZ2+1h/3Z1bHRz6QhJzmDo45Wjlayt/TwABpdmRHcdhqckV9T4mE6qH8BEAl2nPzTVacyj1MGSglSdx9d5E/zhhVb5mDSD/l9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774148974; c=relaxed/simple;
	bh=qtH6bG4u2QFvuoi0sHppW45t1BcXTOUZnSN9m4ZE0F8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Q7My+2b4A3vNv/d7Wlk94A8w2bOLXjLLCDHeam/QB8ZPP6pPLnAS05OpUTBjyNdFn1kIku3pz8iKcc8oUq9E152Z1zTiRCPARK4G1NbmrKtF2NeoHq+KJNRJmdmKlFJBSWPakNEJfzXOLIBPdBK1u+4x/66Y6D4+dHbXYPa5foY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=St4VISp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBEEC2BCB7;
	Sun, 22 Mar 2026 03:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774148974;
	bh=qtH6bG4u2QFvuoi0sHppW45t1BcXTOUZnSN9m4ZE0F8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=St4VISp/eESYD9sFLI8+jZcJ+y51aMmXU8RaUbgrIBErHzVXw2bMy04DDTSf8C5qh
	 CiN6Xt8KdWyi3gFjBw5vs6Zmc3oFAcfiZITcDNbSvhwRvrhmFOsFDFQ27yrmKWCOeF
	 lTxveF0SexiCdf5FLt7wXqtF7snosM9BGbOvHyyHznG8FezG78siG3GFBjcACxlZ4X
	 hewim5eoKKFuAzqmkDd5+NZuGlMmWArnWG0J0wnoAT4CSiKOaKtwTJmw/kGyCvHPvo
	 HpXoVov9K/WQDC/ZQTOI6VREFHxUkLoU82eNZDqZq35/dytlqrayR8Su+y5GZS52ly
	 ohWuN9+grUDdg==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1w49Cc-0000000B7kH-2AUe;
	Sat, 21 Mar 2026 23:10:10 -0400
Message-ID: <20260322031010.367354466@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 21 Mar 2026 23:09:57 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
Subject: [for-linus][PATCH 3/5] tracing: Fix trace_marker copy link list updates
References: <20260322030954.198361547@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227809-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[efficios.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 19EB22E80CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Steven Rostedt <rostedt@goodmis.org>

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
---
 kernel/trace/trace.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

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
 
-	/* Disable all the flags that were enabled coming in */
-	for (i = 0; i < TRACE_FLAGS_MAX_SIZE; i++) {
-		if ((1ULL << i) & ZEROED_TRACE_FLAGS)
-			set_tracer_flag(tr, 1ULL << i, 0);
-	}
-
 	if (printk_trace == tr)
 		update_printk_trace(&global_trace);
 
+	/* Must be done before disabling all the flags */
 	if (update_marker_trace(tr, 0))
 		synchronize_rcu();
 
+	/* Disable all the flags that were enabled coming in */
+	for (i = 0; i < TRACE_FLAGS_MAX_SIZE; i++) {
+		if ((1ULL << i) & ZEROED_TRACE_FLAGS)
+			set_tracer_flag(tr, 1ULL << i, 0);
+	}
+
 	tracing_set_nop(tr);
 	clear_ftrace_function_probes(tr);
 	event_trace_del_tracer(tr);
-- 
2.51.0



