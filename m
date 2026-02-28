Return-Path: <stable+bounces-220918-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JeiHUxMo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220918-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:13:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CF71C806B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F98C34CBE3E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F48C42D96C;
	Sat, 28 Feb 2026 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TG3iifcC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2219A42D964;
	Sat, 28 Feb 2026 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300807; cv=none; b=QVryTY55L8JrBgwi4lxG+qnkGC9El4c3BQvA5UFLSDgq6mXJGnuRmbbz00Zn9FSiJUCmGqsWSH3UG8fdu0EPlm0RvZDBBRxD8V7y1f6ZPnY7vvNVLFGY4Qb/c1OlKjAQXCMSoMEwA0Qw2XzuR55yGkcWAcW5YnBXyp6TxMfFCoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300807; c=relaxed/simple;
	bh=AmLdO0QPKnhH6ZGLu6FlqBEAVfRFCPeqGx5cMIZlodw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umLJiixN/6goZC67O8RYC0Q9NZEP7AOGyg2ER7Lfags+ULIJLsTfLOddmeC0xfsNZFp0LV/uhtbAMATaTXXuGI3os2AwkPE0ylJwZMC6TvEHQ0MeBZewcLqsbFjZl1Bk5ZcewL5uo58e4KvLlpTSQr7ch9fUoZecRj706dT/s74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TG3iifcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8AAC116D0;
	Sat, 28 Feb 2026 17:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300807;
	bh=AmLdO0QPKnhH6ZGLu6FlqBEAVfRFCPeqGx5cMIZlodw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TG3iifcCQGCJW7QZL7BsvLcuNJNV+ln7rG3iDiIIj8t9pRPL7f0e7lmCr7bDZXaOR
	 iN20GUqvXOTzP6FnHDdaw0bKFZKXgKkXwSQs+GWRHjTRyiLHEHyV53pGkhC2mf8jJt
	 2b398RSm+WO+pUfsfMv5Ufg1nXpsFXouWQz1N+euejJsw6zuXZ47e9QMBzxU8jsLUB
	 tEyJsHFrlQs7du6gDu64uNYpD3aKsE8elV3yM5ymQ0dWt0EQcfhR2SzJqwzbZ+QDVg
	 acJW+bnSgLkBfSce4s27F6UTFddZmnBLDg4n/MkYUjzGui4VevwaTIM4KyqA90+Kv0
	 Cko7C87C82aXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Petr Pavlu <petr.pavlu@suse.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 839/844] tracing: Wake up poll waiters for hist files when removing an event
Date: Sat, 28 Feb 2026 12:32:32 -0500
Message-ID: <20260228173244.1509663-840-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220918-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[efficios.com:email,suse.com:email,msgid.link:url,goodmis.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8CF71C806B
X-Rspamd-Action: no action

From: Petr Pavlu <petr.pavlu@suse.com>

[ Upstream commit 9678e53179aa7e907360f5b5b275769008a69b80 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/trace_events.h | 5 +++++
 kernel/trace/trace_events.c  | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 3690221ba3d80..f925034e402dc 100644
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
index 2c6d3e33b9fb4..ec66170637102 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1295,6 +1295,9 @@ static void remove_event_file_dir(struct trace_event_file *file)
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


