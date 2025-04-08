Return-Path: <stable+bounces-130433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 780A1A80483
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0831B63A7E
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBFB26A0FD;
	Tue,  8 Apr 2025 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JJpW0Drt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF88268C66;
	Tue,  8 Apr 2025 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113701; cv=none; b=Y5foQhlxE5RchKKZ4Qt/MgY15UPjRmKmhu+kYP6eLbL1edHPKMK03+xbtOS7HXS6JJTzqXtUkxp//a5VvnjyDFfQqaP3DuK3zgvPVVHqgUCZ3waBWRhwOO2f9LbmFhzHI9YnV5cclnF6cFqJIv+dMisKtryo9AywIOfS5w86zG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113701; c=relaxed/simple;
	bh=4e5w0xwvr7XWWIWjuUJMkEZ+zIRAx91F/wSy+olfS+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoXJYMIir38sC7LBpXu/2KOf7CyNzmE9dNSvxjC2FQrgoZf+oO276IvxJjXFiU82EhuDG9RLisPXaqdPK8rZZRKiYkEJ/xJzxWm/P14pyam1GtIOUe7CCei+824xMAOBPG0z+d61ET+eR8rXbQK+EaRVTyxT8zKFhNpVgiSAaLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JJpW0Drt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FD4C4CEE5;
	Tue,  8 Apr 2025 12:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744113700;
	bh=4e5w0xwvr7XWWIWjuUJMkEZ+zIRAx91F/wSy+olfS+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JJpW0DrthffxnyzCg+4G+DJEAAhg3Jiv/ayOcnwKM/nthoyi8Egmvgx7wd2f5N/ft
	 un/psZwVZnrLVg3VWXGaX5FPuMEOC74dueGl1f0nihK0tUgq14EJyrM7pxfOvvfg9X
	 X2IGrv3t8PtwkYpiz3NPByryHdfYuiHWH9s49CaM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Douglas Raillard <douglas.raillard@arm.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.6 257/268] tracing: Ensure module defining synth event cannot be unloaded while tracing
Date: Tue,  8 Apr 2025 12:51:08 +0200
Message-ID: <20250408104835.514493997@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104828.499967190@linuxfoundation.org>
References: <20250408104828.499967190@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Raillard <douglas.raillard@arm.com>

commit 21581dd4e7ff6c07d0ab577e3c32b13a74b31522 upstream.

Currently, using synth_event_delete() will fail if the event is being
used (tracing in progress), but that is normally done in the module exit
function. At that stage, failing is problematic as returning a non-zero
status means the module will become locked (impossible to unload or
reload again).

Instead, ensure the module exit function does not get called in the
first place by increasing the module refcnt when the event is enabled.

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 35ca5207c2d11 ("tracing: Add synthetic event command generation functions")
Link: https://lore.kernel.org/20250318180906.226841-1-douglas.raillard@arm.com
Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_events_synth.c |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -859,6 +859,34 @@ static struct trace_event_fields synth_e
 	{}
 };
 
+static int synth_event_reg(struct trace_event_call *call,
+		    enum trace_reg type, void *data)
+{
+	struct synth_event *event = container_of(call, struct synth_event, call);
+
+	switch (type) {
+	case TRACE_REG_REGISTER:
+	case TRACE_REG_PERF_REGISTER:
+		if (!try_module_get(event->mod))
+			return -EBUSY;
+		break;
+	default:
+		break;
+	}
+
+	int ret = trace_event_reg(call, type, data);
+
+	switch (type) {
+	case TRACE_REG_UNREGISTER:
+	case TRACE_REG_PERF_UNREGISTER:
+		module_put(event->mod);
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
 static int register_synth_event(struct synth_event *event)
 {
 	struct trace_event_call *call = &event->call;
@@ -888,7 +916,7 @@ static int register_synth_event(struct s
 		goto out;
 	}
 	call->flags = TRACE_EVENT_FL_TRACEPOINT;
-	call->class->reg = trace_event_reg;
+	call->class->reg = synth_event_reg;
 	call->class->probe = trace_event_raw_event_synth;
 	call->data = event;
 	call->tp = event->tp;



