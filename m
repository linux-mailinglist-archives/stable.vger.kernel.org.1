Return-Path: <stable+bounces-105020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 075459F54A7
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1241884C0C
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC4E1FA15C;
	Tue, 17 Dec 2024 17:34:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF361FA149;
	Tue, 17 Dec 2024 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456884; cv=none; b=Xwp3/gLA1jqXEQtjXTNPbgI7VexkouGcdJhkXGsz+xmi8w4xGSjba8ncduRjZLfkICFAiE6GB+YuHFOO8nYnXw7ndVW/OA2lJrl6wivIizlYZlP45W1YtLuz/ZqTdQsyEOzbcN5zDS6TQwqaIhpW2AKA3YcvJjEfyBBduevHyDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456884; c=relaxed/simple;
	bh=45aJ2iSzw6x0/ikwu8QXwZFc0u2PeAyud5FPEpmpQvI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gfQEdI290+hAivcjMDCfF5JAOPfiK5+EIMi4z9aIy1EW6ACuy/zSg7giudHK61RTsV8Pks+eeSdGC8F/AIvOPgeph3TOG1wACMjmXAOhBa/GZIt9cf+v7r8Qy3rATTHX3wvVw/bLQfeEmFDZ2yIDv8t98T1DpeFvMKgCQRNmztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58730C4CEDE;
	Tue, 17 Dec 2024 17:34:44 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tNbTc-00000008cul-2exr;
	Tue, 17 Dec 2024 12:35:20 -0500
Message-ID: <20241217173520.483964366@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 17 Dec 2024 12:32:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [PATCH 2/3] trace/ring-buffer: Do not create module or dynamic events in boot
 mapped buffers
References: <20241217173237.836878448@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When a ring buffer is mapped across boots, an delta is saved between the
addresses of the previous kernel and the current kernel. But this does not
handle module events nor dynamic events.

Simply do not create module or dynamic events to a boot mapped instance.
This will keep them from ever being enabled and therefore not part of the
previous kernel trace.

Cc: stable@vger.kernel.org
Fixes: e645535a954ad ("tracing: Add option to use memmapped memory for trace boot instance")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 77e68efbd43e..d6359318d5c1 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2984,6 +2984,12 @@ trace_create_new_event(struct trace_event_call *call,
 	if (!event_in_systems(call, tr->system_names))
 		return NULL;
 
+	/* Boot mapped instances cannot use modules or dynamic events */
+	if (tr->flags & TRACE_ARRAY_FL_BOOT) {
+		if ((call->flags & TRACE_EVENT_FL_DYNAMIC) || call->module)
+			return NULL;
+	}
+
 	file = kmem_cache_alloc(file_cachep, GFP_TRACE);
 	if (!file)
 		return ERR_PTR(-ENOMEM);
-- 
2.45.2



