Return-Path: <stable+bounces-139499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8940AAA7544
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 16:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D0F1C03033
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 14:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C7B256C99;
	Fri,  2 May 2025 14:46:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88359255F5A;
	Fri,  2 May 2025 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746197203; cv=none; b=nsA1G0It+rH8ZB1Q6coTId3L1OYz9tgzVdpFqL+hHboMgC3iMB4gwbg7y8AnhoIoMBMW/KCCggUppesJlFtV0htDH0An1dWUxfAj6rOV6enQHQQOfss/jObQODXbVNN1tuRySv7ksls3yB+paDGgISwmT3hcNlnf0BCLN8kNGmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746197203; c=relaxed/simple;
	bh=UuuKgeE+zprAuA6fZuA79Fi7jQ7fBKhV8Bq5rjoWyvw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HdudS1jWJeBge0LkIADTbvhj6NjXjLxMbKwAnsOl/yusUFMbmebQWy3TTI5zseZkMYIBBmVOY01PVc92qQ+aZO5FJx6fgk/023rQs48zmkQvAu4EJmpx7xgp3aqIPpehy9rs081VT+Ju8t8qguL4rEEmvUaOifHNuCPNthIPfk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332CEC4CEF5;
	Fri,  2 May 2025 14:46:43 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uArf9-000000032vy-3Hmf;
	Fri, 02 May 2025 10:46:51 -0400
Message-ID: <20250502144651.638397805@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 02 May 2025 10:46:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 syzbot+441582c1592938fccf09@syzkaller.appspotmail.com
Subject: [for-linus][PATCH 4/4] tracing: Do not take trace_event_sem in print_event_fields()
References: <20250502144607.785079223@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

On some paths in print_event_fields() it takes the trace_event_sem for
read, even though it should always be held when the function is called.

Remove the taking of that mutex and add a lockdep_assert_held_read() to
make sure the trace_event_sem is held when print_event_fields() is called.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250501224128.0b1f0571@batman.local.home
Fixes: 80a76994b2d88 ("tracing: Add "fields" option to show raw trace event fields")
Reported-by: syzbot+441582c1592938fccf09@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6813ff5e.050a0220.14dd7d.001b.GAE@google.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index fee40ffbd490..b9ab06c99543 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1042,11 +1042,12 @@ enum print_line_t print_event_fields(struct trace_iterator *iter,
 	struct trace_event_call *call;
 	struct list_head *head;
 
+	lockdep_assert_held_read(&trace_event_sem);
+
 	/* ftrace defined events have separate call structures */
 	if (event->type <= __TRACE_LAST_TYPE) {
 		bool found = false;
 
-		down_read(&trace_event_sem);
 		list_for_each_entry(call, &ftrace_events, list) {
 			if (call->event.type == event->type) {
 				found = true;
@@ -1056,7 +1057,6 @@ enum print_line_t print_event_fields(struct trace_iterator *iter,
 			if (call->event.type > __TRACE_LAST_TYPE)
 				break;
 		}
-		up_read(&trace_event_sem);
 		if (!found) {
 			trace_seq_printf(&iter->seq, "UNKNOWN TYPE %d\n", event->type);
 			goto out;
-- 
2.47.2



