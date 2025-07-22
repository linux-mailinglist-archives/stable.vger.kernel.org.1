Return-Path: <stable+bounces-164083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 146BBB0DD2A
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A907016251D
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792512B9A5;
	Tue, 22 Jul 2025 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXhD4Waz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397EE2C9A
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193194; cv=none; b=dDpTxVDeIEm4xMedGKJQ1/qWffyuz++1VUVGAo2jacVDHghWVXncAlXLibLE18m8bbGoW4Ynypsr2JNuZz97KPy8ch9yAG5WDcSkRdPaAFQ7hWIU5A568s8xsc8x8yRi0WHx+3zPpwphgXI+JxH4cBg+sim5LF86njFtCD7WBdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193194; c=relaxed/simple;
	bh=HjoHqCJN/T2s9ChWWGLV/QaXow9+LTIZCEkc1uFYRvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwsWR5n1oij1NT9uPBSnLJ1MQUykcSLl0yPd04YSNL/C0S3dshgkvRiJwN2z4zpxyF+6+jpyeDBZBqAbNQlNctcJaHJ5g6S+epWSd5dhWYi8+YGy+kf1aoHVYdII3UDGTbnMEVtx2mrgDayHwvRBWutFejern2V8F/v6+rf4LPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXhD4Waz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FC7C4CEEB;
	Tue, 22 Jul 2025 14:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753193194;
	bh=HjoHqCJN/T2s9ChWWGLV/QaXow9+LTIZCEkc1uFYRvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lXhD4Wazt4tWnGBQag50/m0daMlsVO6nT1weSQ0JlUCq93PGKr6BQPJKJpLED5lal
	 S3vEr5hooqrqqo/1KTrE0ss9WpY5GxjBvCihcpnBXuLCPsc8WJ/jXgpqkTLMLwkmVk
	 CRtV2nH/VKC17anEzr1ioJDe5c2hIOQ5zrHoHXwSRV7BlvIlWLiBfdx+8iz/234TRb
	 RgBB7L9hpw39oLEfeVbAUI76qC7pXdHeWFebLlNcjSTpaCWko0PROsNsujtARvVmj8
	 k5fYLeasiqGNmuGlMIDUTZE32dUa6245+9lCT522XqewwoHmx0qca8daLTdUFvehhy
	 N7834ucCRw2DQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Fusheng Huang <Fusheng.Huang@luxshare-ict.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tracing: Add down_write(trace_event_sem) when adding trace event
Date: Tue, 22 Jul 2025 10:06:16 -0400
Message-Id: <20250722140616.951726-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072113-nutty-other-f178@gregkh>
References: <2025072113-nutty-other-f178@gregkh>
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
index 92693e2140a94..9cd97b274e6c1 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2324,7 +2324,10 @@ __register_event(struct trace_event_call *call, struct module *mod)
 	if (ret < 0)
 		return ret;
 
+	down_write(&trace_event_sem);
 	list_add(&call->list, &ftrace_events);
+	up_write(&trace_event_sem);
+
 	call->mod = mod;
 
 	return 0;
@@ -2710,6 +2713,8 @@ __trace_add_event_dirs(struct trace_array *tr)
 	struct trace_event_call *call;
 	int ret;
 
+	lockdep_assert_held(&trace_event_sem);
+
 	list_for_each_entry(call, &ftrace_events, list) {
 		ret = __trace_add_new_event(call, tr);
 		if (ret < 0)
-- 
2.39.5


