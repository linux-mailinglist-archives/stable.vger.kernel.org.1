Return-Path: <stable+bounces-221563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ20AQGZo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:40:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F061CB472
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18E7E30634E4
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B872BE033;
	Sun,  1 Mar 2026 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gg/NBiRm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F074D242D72;
	Sun,  1 Mar 2026 01:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328588; cv=none; b=WtwtqCz6P/Iqp1NlnP9phnnj8AvyPQunO80D+L4oI8baqlDtLcj7VEil5qAKK9QKAaXaiqSo6aB2vXwnQc5MvIVoogOZRJJ+W628P41dsnUHdABShQpTzQZeyK4kglwZKkaqq1rrMxiWdjEgHNwzIPlYWkFD+IjRkgAY4UbhZtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328588; c=relaxed/simple;
	bh=IrY0eGxSChiRY4Cxlu1YtDyRdH9huQg1/FmQrUI6izs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tZw9FfVicyMEYUxm0D3BJMc1qnn9gT2/we87MZuSTk3ht6ubXUj3JRpch1FJjQgO8Aeah6PD7VsL6vjNwsRzps2z81p+Yy+ZM9fN3Bbs4EvD05Kufh1JlRS5M7q4q9ms2k0swWIwIXLRE/u3FlILpb7iTfNrK0jDBLtmtTOzqR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gg/NBiRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62153C19421;
	Sun,  1 Mar 2026 01:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328587;
	bh=IrY0eGxSChiRY4Cxlu1YtDyRdH9huQg1/FmQrUI6izs=;
	h=From:To:Cc:Subject:Date:From;
	b=Gg/NBiRmo9mYR8tQ+OxxH5Kjy3TK1eYCTEgVG0bLv7BZIthzThvP4gDKzLB7KHq+S
	 B4uwtNd1fNc+bGjJfzoZ0IQT6s03oVyx/MkQdpRMYr7NpULxV1WNvuKCDwGpOQXhVM
	 eJpwfVCpMcAM99knDvx4TFmi8VA2XSbLkCPtDQyTQWaWtemRBNkZmCn3wo1gw7R6hB
	 HVQLetx0BmNn9k6ABQHtsV8JpGvpN5RSTl+FOPPAGDuVz2anR4tAnIoUej7ZKf1kJA
	 HWaeOnLaKIgUh/GBCYutWCSrc77+oHxPqWwX+wMdm7AG1lRIFdzB5BfOCkSICCDgQM
	 nL0/AbdNGWeEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	petr.pavlu@suse.com
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Subject: FAILED: Patch "tracing: Fix checking of freed trace_event_file for hist files" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:29:44 -0500
Message-ID: <20260301012945.1687606-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221563-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 20F061CB472
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f0a0da1f907e8488826d91c465f7967a56a95aca Mon Sep 17 00:00:00 2001
From: Petr Pavlu <petr.pavlu@suse.com>
Date: Thu, 19 Feb 2026 17:27:01 +0100
Subject: [PATCH] tracing: Fix checking of freed trace_event_file for hist
 files

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
index e6f449f53afcc..768df987419e3 100644
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





