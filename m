Return-Path: <stable+bounces-163534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65CBB0C050
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3812A3BE92A
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 09:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106DE28A407;
	Mon, 21 Jul 2025 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QyhYZun9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41B728C000
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753090158; cv=none; b=PwV34TNXW+IQUZIrjeoh/l77/mb7HGeofMTSvADYiMAjtEkAl22G1SCMEZGPy49L6zbf5W32KqAjJzHdWnnR7OA/hZe34n/OBdkQ/qGsIXam/I5/ibtSGzHRuvRvw325EiR90AE0Odf4InXDUcjPKZKmKC1qvMBII73R8PVSvDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753090158; c=relaxed/simple;
	bh=frRfqZbdubJAVhi3W1PKYxhfrxAWP+SjytuZnY2ENmk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QsXq818bVsdsNErQYw9J8a8NxiJr0cceBa73DeGI2sYeeoQbZs3DjW0o299K+jXHebxmjj3YrDgjA/QUFfRxv7a1L9Dh+8JmA0hqkUBbWFVoI4sM5DeZEI2mvZxNxNQy/9YSkKUuPcJ8qe3bzVitGfoUaBMRwbMhYZHnRDfvqo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QyhYZun9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0106EC4CEF1;
	Mon, 21 Jul 2025 09:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753090156;
	bh=frRfqZbdubJAVhi3W1PKYxhfrxAWP+SjytuZnY2ENmk=;
	h=Subject:To:Cc:From:Date:From;
	b=QyhYZun9fHD19VzRqxMuRRsZJWDR6IC9P97sAP4IYB5i+8FMLpgYQ2T/9miMYukHu
	 DRKkdX+kadmkRit/cd/y5YAN1Xm/Kuk1f1qW0e5Gw0x1W2mH0FpEW5H87DxVoECDGB
	 Qg5OLpw5y32Skguca5x8vrCjt/3YqO82WFA7i3VU=
Subject: FAILED: patch "[PATCH] tracing: Add down_write(trace_event_sem) when adding trace" failed to apply to 5.10-stable tree
To: rostedt@goodmis.org,Fusheng.Huang@luxshare-ict.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 11:29:13 +0200
Message-ID: <2025072113-nutty-other-f178@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b5e8acc14dcb314a9b61ff19dcd9fdd0d88f70df
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072113-nutty-other-f178@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


