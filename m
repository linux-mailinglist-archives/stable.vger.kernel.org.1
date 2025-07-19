Return-Path: <stable+bounces-163438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C02F6B0B135
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 19:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E22B189FE1A
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 17:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820C82874E7;
	Sat, 19 Jul 2025 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7A9GgoL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC0F221550;
	Sat, 19 Jul 2025 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752947874; cv=none; b=r6veibJNUxowvlK9ksMuLTLupVmkzDz16LTG4qp310JdSdIEak+ysi7ajmD/bzXnyTDL5He5IbtVImvw9w0b6wWnHoY8Chy/i2S5TNgSDwAaAtTfAFeWvqEawdg7z8vle4CEMQAfTYabmHDVqZzdBiLq2jEWGYYyKCB71IYh4oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752947874; c=relaxed/simple;
	bh=SgO5r3HKnNBU0sLniQLn4+H/1Vma8XHldf0X3/vnXwc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mxDTThmPiEfJ6hHg0zB8rrgnUtO0QTCJKiPQkQMiiPWwV8ncNaOFQooKmQEhnYthYN539c/YlWyKJSB2EyTHBRhi9kxRL0IIbOxAruHDLq1r9jrbss1yhRt7vVUOV7Tdcyjo8Yf4EBXmQxG9avP6ccgBsJ4DlV17GgeV36/egdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7A9GgoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8795C4CEF5;
	Sat, 19 Jul 2025 17:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752947873;
	bh=SgO5r3HKnNBU0sLniQLn4+H/1Vma8XHldf0X3/vnXwc=;
	h=Date:From:To:Cc:Subject:References:From;
	b=U7A9GgoLDs99xBBf3ewA2NCTsfRjYQxUwpS3gO5dd5ps0CBIdfD3YsbwKagrmtm7G
	 YC3JXQtrGxpkStp7XaleCXWMjbj6vKV5hlf235AwWvQwUtLbSp9dHxq79hzOgJODTA
	 8JBYU3jVg4jE7GXN1c8iUSkOrHQsG/VwOkDLEw0JRoBWadmJT6+RWP5jHxR6YvH6lk
	 7ndL+IBC1quvU8LtgVhpzjlpkQz7iCQuB7mONoVAaLPiF+tF0Tj9k5tyZ1NSXiJP2M
	 36JpuT+CMWKDpDyVJ7zTP0PP1olrK/RgYgcWB23EIRFxsQltd4T7lOGCbI8Xm2dKgE
	 WdAMTtMubzHXg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1udBpE-000000085Ht-00DT;
	Sat, 19 Jul 2025 13:58:20 -0400
Message-ID: <20250719175819.850873535@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 19 Jul 2025 13:57:56 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 =?UTF-8?q?Fusheng=20Huang(=E9=BB=84=E5=AF=8C=E7=94=9F)?= <Fusheng.Huang@luxshare-ict.com>
Subject: [for-linus][PATCH 2/2] tracing: Add down_write(trace_event_sem) when adding trace event
References: <20250719175754.996594784@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

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
---
 kernel/trace/trace_events.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 120531268abf..d01e5c910ce1 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3136,7 +3136,10 @@ __register_event(struct trace_event_call *call, struct module *mod)
 	if (ret < 0)
 		return ret;
 
+	down_write(&trace_event_sem);
 	list_add(&call->list, &ftrace_events);
+	up_write(&trace_event_sem);
+
 	if (call->flags & TRACE_EVENT_FL_DYNAMIC)
 		atomic_set(&call->refcnt, 0);
 	else
@@ -3750,6 +3753,8 @@ __trace_add_event_dirs(struct trace_array *tr)
 	struct trace_event_call *call;
 	int ret;
 
+	lockdep_assert_held(&trace_event_sem);
+
 	list_for_each_entry(call, &ftrace_events, list) {
 		ret = __trace_add_new_event(call, tr);
 		if (ret < 0)
-- 
2.47.2



