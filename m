Return-Path: <stable+bounces-221207-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JpbI+Fdo2lxBQUAu9opvQ
	(envelope-from <stable+bounces-221207-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:28:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE261C916B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2AEA3749E61
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E37637523A;
	Sat, 28 Feb 2026 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8Ksfy6k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F2F375249;
	Sat, 28 Feb 2026 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301564; cv=none; b=WU2LfUPVaJq4xTd/XCdLNZrd+w8k4chi92fRDOkbn0iwaPbgR7jMToIUno28PcbRvqfQhFG+Mw7EpWfFCmFVO2xNWXoRsb5YYmPw0sSUufZx03yuGOgizb6MKMOr2qVCnTOln60HSShd5pxVkvRezmXfI0AARZe0oeHDSqzAV7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301564; c=relaxed/simple;
	bh=cXUT2m/Buo3w8m1m3gfvVg09mDyDB+BPLUmn0QzseLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIa8cZ5Gd2EiHogCk4551wq/Gs0FldqKGVjmn8slUul1LyTD18m24YFWzzfIS62PSiqvT6x+RDc+7d69Bc+jFxC34NTLIZqmYKIjPK/JQecTziNx3JVF2MQPdW9qFe8yAFGKRzTj4kh2bPxH59E//+w0rJEDPXDv1/4asRujUlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8Ksfy6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8E7C2BC87;
	Sat, 28 Feb 2026 17:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301564;
	bh=cXUT2m/Buo3w8m1m3gfvVg09mDyDB+BPLUmn0QzseLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W8Ksfy6kwr9472rD2SBT7YCkKVTCXk0ZXw1jccHmz1RXefS4TZWiOuZpYNG1mabSs
	 IFqlhdU579oDxsbcUb56X+/CeyGvcH3RRo8s8MvmkETlF03IUROXgF6qtBdmX85h6B
	 eCHRiXyVSAv+2RpAiHAEoOLjx+SG1ayaAZfepmvcU333TE9YfqZ3SzvgjkE6WHrFy9
	 pMKRWQRN21unRtu0Hun0PVsov+67rX2rKXaU6CJYDBhmUy2EErCrke1Jtw+bZ5aT+K
	 xoz9dSzqIgGn1KbNHG6a85tpwJO2aA3egZ2TwOCU8/QEQ7GLWYuUf2jjmtQqJA1zng
	 dxkq9E/usXw3g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Petr Pavlu <petr.pavlu@suse.com>,
	stable@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 747/752] tracing: Wake up poll waiters for hist files when removing an event
Date: Sat, 28 Feb 2026 12:47:38 -0500
Message-ID: <20260228174750.1542406-747-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221207-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,goodmis.org:email,efficios.com:email]
X-Rspamd-Queue-Id: 1AE261C916B
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
index 04307a19cde30..64ada9cc38864 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -682,6 +682,11 @@ static inline void hist_poll_wakeup(void)
 
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
index 5cf55a9c6fad4..e4ce7f856f630 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1296,6 +1296,9 @@ static void remove_event_file_dir(struct trace_event_file *file)
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


