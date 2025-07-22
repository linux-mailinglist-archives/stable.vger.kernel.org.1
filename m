Return-Path: <stable+bounces-164210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6366B0DE45
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA03567806
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3713621D3CD;
	Tue, 22 Jul 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0CPtQua"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC80176AC5
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193611; cv=none; b=gTK+21BLXvHrxwBpU4X4IAisI0G7uyTyKmGKBpbVCoIxOT6iT8Bh9GgfPj/bOLX73BHjClHiuaxnBpAaVnwetUONn7fkRAGStmug7bQKu/OlUp7fgP92tRCjS7UfRK70hG6mpkpRosVssUMFRXu4miknBjvNkaR2LHF1RH+YJGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193611; c=relaxed/simple;
	bh=E+8Y2GiglV56jT5VQQizP+SUADs7eEQTzCk2wXKs5lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwLr9ArfdVZSYETCiUXQ972mifcVGhEnuw8gbChjk40dw8v43jMSVD4srn0sjKaemn17CCRDcJqSKxNy19YeXS7KvjVKrvPIkAPkFFlfAlYg2Nj9nQY9F9XPgN/2fmf10mUndhWdYL5SZPNyy9M13eAz60BRWSK9t0OTEWr8Km8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0CPtQua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C683C4CEEB;
	Tue, 22 Jul 2025 14:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753193610;
	bh=E+8Y2GiglV56jT5VQQizP+SUADs7eEQTzCk2wXKs5lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K0CPtQual3uwHtoN6CmDLcgadLh/f8f1UGgROtVJHPt4IRCpwPUCyzD/7t87Penyq
	 KkGCD5A/LR+KJVPtd5ePvgzfr2FgwTiQPlme5fYtb/7L46b6ZRDfFGRJB7CI5Ze6on
	 A9nE8d7gKl+SiqBH17XRqqgROyxU43CRw9qa9rXpNTPB4f3DvwDfx5Bs3PQPMTkS5F
	 T35ZZrM+O4ZDBTzGrq/mpUWCIz6rqT+s8j0anncgSj96K4vRB5HR0gKBtiIEMqvbpi
	 D9uAtHs0AT3GSZY/fOcob7XWA2bg6AdvD0aI9fzWX+0XZTxmAuQWgzd521l4//07Hb
	 JhR64YnmqRINA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Fusheng Huang <Fusheng.Huang@luxshare-ict.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] tracing: Add down_write(trace_event_sem) when adding trace event
Date: Tue, 22 Jul 2025 10:13:20 -0400
Message-Id: <20250722141320.952515-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072113-perjury-dynamite-23ba@gregkh>
References: <2025072113-perjury-dynamite-23ba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit b5e8acc14dcb314a9b61ff19dcd9fdd0d88f70df ]

When a module is loaded, it adds trace events defined by the module. It
may also need to modify the modules trace printk formats to replace enum
names with their values.

If two modules are loaded at the same time, the adding of the event to the
ftrace_events list can corrupt the walking of the list in the code that is
modifying the printk format strings and crash the kernel.

The addition of the event should take the trace_event_sem for write while
it adds the new event.

Also add a lockdep_assert_held() on that semaphore in
__trace_add_event_dirs() as it iterates the list.

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/20250718223158.799bfc0c@batman.local.home
Reported-by: Fusheng Huang(黄富生)  <Fusheng.Huang@luxshare-ict.com>
Closes: https://lore.kernel.org/all/20250717105007.46ccd18f@batman.local.home/
Fixes: 110bf2b764eb6 ("tracing: add protection around module events unload")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 77df1e28fa329..eae997f277b6f 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2109,7 +2109,10 @@ __register_event(struct trace_event_call *call, struct module *mod)
 	if (ret < 0)
 		return ret;
 
+	down_write(&trace_event_sem);
 	list_add(&call->list, &ftrace_events);
+	up_write(&trace_event_sem);
+
 	call->mod = mod;
 
 	return 0;
@@ -2489,6 +2492,8 @@ __trace_add_event_dirs(struct trace_array *tr)
 	struct trace_event_call *call;
 	int ret;
 
+	lockdep_assert_held(&trace_event_sem);
+
 	list_for_each_entry(call, &ftrace_events, list) {
 		ret = __trace_add_new_event(call, tr);
 		if (ret < 0)
-- 
2.39.5


