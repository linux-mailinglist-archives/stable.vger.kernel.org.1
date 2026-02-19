Return-Path: <stable+bounces-217506-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEGpMYx3l2nVywIAu9opvQ
	(envelope-from <stable+bounces-217506-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 21:50:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FD716270C
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 21:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26587303AF2B
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 20:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7952326951;
	Thu, 19 Feb 2026 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYg63Xpf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8983632572C;
	Thu, 19 Feb 2026 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771534198; cv=none; b=Z8xUEOPS14ZjAucfQNeg09toPxYGPCVkYY8iFJwVQ0ZvYD+9ci+bLAX7RnW121VdI8rywO6+fsJz4Tr/IZhwJsYICfKr6N7tsx1oOXQ+LarTJ44OJZt4el7kVMhbX5l/+6Ch7VbOc14t0CYDB1xjbXPpbQVFOGLu2HbhSV0Y5lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771534198; c=relaxed/simple;
	bh=AO1s0ZwsAwaiASVhsmyjGkQ1JXVRT89ksdTYvzU7lAM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ToiMw0kVhSTv2ZOf6xMk3mouNuVUurbYE7EUeVIQ1WinnLOvMYWnGsUu0JcKSstyZs+ccus7UyHBq27QKFtbWTDM5Xs2LaQsTGpUCF/q/ZFRuUl2Dvjvk2Zi8asGDUBLmeOcBPETNQiTceHa+KGcA21esunKfipXnQj5Vihm9SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYg63Xpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A39C2BCB0;
	Thu, 19 Feb 2026 20:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771534198;
	bh=AO1s0ZwsAwaiASVhsmyjGkQ1JXVRT89ksdTYvzU7lAM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=mYg63XpfZGfoa091lztuIrvyUJt0Jt663A/VqtQQ8E+uYo7r35rr12FJFnjj787hi
	 6lMlJs5oVgq+RNdftQRYGL/nIBM1reA3rWOKlhtsW7Nctq/0IawbwzbDbmfB4kLZLq
	 /u0uBGR5c7k2MWxliGkATl5LlQOS2j1PEheH7Fgmx7jfwKOk/Gs6+2q3s1C5vz2X19
	 3LHWcn3J8mh46ui21/Be9Yjvn/GEcNjj5MNolxEDPaI4hz1y/ORY870yx8bWx6FSLK
	 JCWaR70QtWIMttjK9wr+NCUkgK38ZnCRZwoeSBw6qcyt+ZNKyhRPZD1okAi+NulMmj
	 8dNyVpOZnzE+A==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vtAyL-00000000kgm-1Q3p;
	Thu, 19 Feb 2026 15:50:05 -0500
Message-ID: <20260219205005.194297642@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 19 Feb 2026 15:49:51 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Tom Zanussi <zanussi@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>
Subject: [for-linus][PATCH 4/5] tracing: Fix checking of freed trace_event_file for hist files
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217506-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 04FD716270C
X-Rspamd-Action: no action

From: Petr Pavlu <petr.pavlu@suse.com>

The event_hist_open() and event_hist_poll() functions currently retrieve
a trace_event_file pointer from a file struct by invoking
event_file_data(), which simply returns file->f_inode->i_private. The
functions then check if the pointer is NULL to determine whether the event
is still valid. This approach is flawed because i_private is assigned when
an eventfs inode is allocated and remains set throughout its lifetime.
Instead, the code should call event_file_file(), which checks for
EVENT_FILE_FL_FREED. Using the incorrect access function may result in the
code potentially opening a hist file for an event that is being removed or
becoming stuck while polling on this file.

Correct the access method to event_file_file() in both functions.

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Link: https://patch.msgid.link/20260219162737.314231-2-petr.pavlu@suse.com
Fixes: 1bd13edbbed6 ("tracing/hist: Add poll(POLLIN) support on hist file")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index e6f449f53afc..768df987419e 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5784,7 +5784,7 @@ static __poll_t event_hist_poll(struct file *file, struct poll_table_struct *wai
 
 	guard(mutex)(&event_mutex);
 
-	event_file = event_file_data(file);
+	event_file = event_file_file(file);
 	if (!event_file)
 		return EPOLLERR;
 
@@ -5822,7 +5822,7 @@ static int event_hist_open(struct inode *inode, struct file *file)
 
 	guard(mutex)(&event_mutex);
 
-	event_file = event_file_data(file);
+	event_file = event_file_file(file);
 	if (!event_file) {
 		ret = -ENODEV;
 		goto err;
-- 
2.51.0



