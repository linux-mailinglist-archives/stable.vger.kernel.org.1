Return-Path: <stable+bounces-163535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9986B0C053
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEF467A2CE1
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 09:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6B628CF6A;
	Mon, 21 Jul 2025 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L6mhoHS9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC2728BAB1
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753090165; cv=none; b=U4I8d+GK6Ivk9BJ9PuhDZQilBE0xpIATlL7THGa3/ZP5P9G8oSs58NPQbSsy4b/8vMZdH13KVSE/gv8FN2kRiCeCsl96L0DO0Ab40Y/4VPcNPFK7G9OaMTQ8zUfrvACkN06jMBRfbu0umt92NT0Ci82vQs6ba5msmIBS/rK/Oug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753090165; c=relaxed/simple;
	bh=jS/4N1xKuwAIw0Eo/6EscGu6StR7Fq/C9pNJmdS6oTg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YopyPj0B7MJKlAfrU59JbcMAXHfNLtPAg8GvBy0vEK5BzS+CpyAzChMe0Vo6E4fghhRQMllq6h9k1+T446Wt/HbH4r33SQ7GgxX0iOVGU5Oh/hN8iyQU99arXQensZIXCEThFbw+TLIhQgbqdUoAW0/9312HvoOL8/O+RN9DPGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L6mhoHS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947D9C4CEED;
	Mon, 21 Jul 2025 09:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753090165;
	bh=jS/4N1xKuwAIw0Eo/6EscGu6StR7Fq/C9pNJmdS6oTg=;
	h=Subject:To:Cc:From:Date:From;
	b=L6mhoHS9LTrwsAniHjZNWrx0aNa5CalTyogvz984JcbUFQg/hZPUm7swUYx2Emy9b
	 vbeTC/IxHCREXzvxRXF4L8Qst2b9a9ivmZJceb0poY11L98+U5eItDqwWfT7hFNhM6
	 VV0KUkk39eE1vL4ZGot7lK5Ii3jem/8sNm62fuTE=
Subject: FAILED: patch "[PATCH] tracing: Add down_write(trace_event_sem) when adding trace" failed to apply to 5.4-stable tree
To: rostedt@goodmis.org,Fusheng.Huang@luxshare-ict.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 11:29:13 +0200
Message-ID: <2025072113-perjury-dynamite-23ba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x b5e8acc14dcb314a9b61ff19dcd9fdd0d88f70df
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072113-perjury-dynamite-23ba@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b5e8acc14dcb314a9b61ff19dcd9fdd0d88f70df Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Fri, 18 Jul 2025 22:31:58 -0400
Subject: [PATCH] tracing: Add down_write(trace_event_sem) when adding trace
 event
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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


