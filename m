Return-Path: <stable+bounces-217507-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BQzOZt3l2nVywIAu9opvQ
	(envelope-from <stable+bounces-217507-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 21:50:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B89616273C
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 21:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 553E63044146
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 20:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073BE326D73;
	Thu, 19 Feb 2026 20:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIYuzZku"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD19C32694D;
	Thu, 19 Feb 2026 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771534198; cv=none; b=Zvgs/MUDmQmQx4XS8OrVIMPkcN/nyBiPRN/OCO9mPUzfg+mcCfPTcY/0Vwq1fEUTbaf0zrhjG7ruDTWOdNsbyseZeIwpdWASY3Po4ro2bOlC+UQ9YoKEi6qKhQoaFXbF4AqahBgIpjk+Jo7KYrnnW5mNYxoabMc1Xcecw2djj4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771534198; c=relaxed/simple;
	bh=HdS/P0tdqNUoUZPeNdLLdFO4qi/wOAr6/xUSt/yHgqM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sixJsyc0WeULivqdMutIwRksoF8n34tXOJ50nDZzq5Jb0C0zxB/I8+QX9UXfifZ4eTeoA5WMsbiRtAZWMFm+bpLDzVZZ/aula5XUgNn4czR+nc634FUyPjgc2HOKYV59bR+KI36D2w1z7wyxTvTbu0srfAukiU+kc9AlJD4UzYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIYuzZku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97482C2BCB1;
	Thu, 19 Feb 2026 20:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771534198;
	bh=HdS/P0tdqNUoUZPeNdLLdFO4qi/wOAr6/xUSt/yHgqM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=UIYuzZkun41KUKuwyOvXv0jEyKxFYB3G8w6fcKxPKXxZxD5g+Oo0WrSnqQvt0uQEn
	 Png98HwWP2S47M5decjDIT0Li9EJnR0O0WrRK13w9zkB0jWGu8f9sHjxZwD9znZADJ
	 VgWTeQF0pT2YeiOvlGzlLUGWFiWwyl+8xs/VntXrB1GlH2PpM9VLwmfZZT0MqX5VFo
	 jPzZjuw2XrbIz2nTk6ADJ8x4hRQLFRMrMFYEiclmLlJaNM7vEbdxNmsGxhnYCkn1Nf
	 qg/npPLNloNmqu1bbvd/T0XIaQTCKZ5RMDM3j4P+dzagTEg0n3c8j77t1OytwR13J8
	 IT2CxT2Ja8XPw==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vtAyL-00000000khG-23i4;
	Thu, 19 Feb 2026 15:50:05 -0500
Message-ID: <20260219205005.354355145@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 19 Feb 2026 15:49:52 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Tom Zanussi <zanussi@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>
Subject: [for-linus][PATCH 5/5] tracing: Wake up poll waiters for hist files when removing an event
References: <20260219204947.830172370@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-217507-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,efficios.com:email,msgid.link:url,suse.com:email]
X-Rspamd-Queue-Id: 7B89616273C
X-Rspamd-Action: no action

From: Petr Pavlu <petr.pavlu@suse.com>

The event_hist_poll() function attempts to verify whether an event file is
being removed, but this check may not occur or could be unnecessarily
delayed. This happens because hist_poll_wakeup() is currently invoked only
from event_hist_trigger() when a hist command is triggered. If the event
file is being removed, no associated hist command will be triggered and a
waiter will be woken up only after an unrelated hist command is triggered.

Fix the issue by adding a call to hist_poll_wakeup() in
remove_event_file_dir() after setting the EVENT_FILE_FL_FREED flag. This
ensures that a task polling on a hist file is woken up and receives
EPOLLERR.

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://patch.msgid.link/20260219162737.314231-3-petr.pavlu@suse.com
Fixes: 1bd13edbbed6 ("tracing/hist: Add poll(POLLIN) support on hist file")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_events.h | 5 +++++
 kernel/trace/trace_events.c  | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 0a2b8229b999..37eb2f0f3dd8 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -683,6 +683,11 @@ static inline void hist_poll_wakeup(void)
 
 #define hist_poll_wait(file, wait)	\
 	poll_wait(file, &hist_poll_wq, wait)
+
+#else
+static inline void hist_poll_wakeup(void)
+{
+}
 #endif
 
 #define __TRACE_EVENT_FLAGS(name, value)				\
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 61fe01dce7a6..b659653dc03a 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1311,6 +1311,9 @@ static void remove_event_file_dir(struct trace_event_file *file)
 	free_event_filter(file->filter);
 	file->flags |= EVENT_FILE_FL_FREED;
 	event_file_put(file);
+
+	/* Wake up hist poll waiters to notice the EVENT_FILE_FL_FREED flag. */
+	hist_poll_wakeup();
 }
 
 /*
-- 
2.51.0



