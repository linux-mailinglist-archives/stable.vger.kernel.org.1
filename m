Return-Path: <stable+bounces-116727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD54A39AED
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBC23A4727
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4DA23C392;
	Tue, 18 Feb 2025 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ge+SOtJz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE1B22DFAF
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878224; cv=none; b=n7ajWncMwK+4fqUFcpRrVaFUqK0GnxYTuxGPFPeoIFGWWdHdew6PSjAfdrUJO2MfwC0rD8PpSBENtMtZG1jV+NqutHYhTBELOzn8WTm8zUJwS6XetbIa9RtzJUlvRA6E5mURhvUJJY6nWC79Z0r0BPJy3EhJL7+z7rqxe44zrUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878224; c=relaxed/simple;
	bh=pyufOsEu4MFn3yNdb2r/qqIIYNiB7nnU695WrCQhjRc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GmsWp9gKwDCiVP5Zj2lS6YgtO9wRmJLLNxoZqsjoFNmz83kZkM/OFJqEkHD2wv2CE+ppO1wEnQAT2OtjXkx7uoDMVSKTCxUQxA67dRNX2tS2OeGcA9hPlmfj8pZ2X6JPPDaJA7wSXubIxhWPHjYTpMKhU4OH5TX5woP84hMU554=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ge+SOtJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09707C4CEE6;
	Tue, 18 Feb 2025 11:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739878223;
	bh=pyufOsEu4MFn3yNdb2r/qqIIYNiB7nnU695WrCQhjRc=;
	h=Subject:To:Cc:From:Date:From;
	b=ge+SOtJzHYPi5tfLUY43xUdrLPHqgmchmx0Ii3lBOZkKxnXdW3K43fONzg9Hw4F5L
	 MJobZ0P12guSOi961g/PkT91HkC/IspAzKPDPGv9hNjlkJ78W38tgMOSex4tijlTM8
	 dE/zpfMdkcx3RCYlXvbdsMATXV+QxiCOSgp1TR/s=
Subject: FAILED: patch "[PATCH] tracing: Have the error of __tracing_resize_ring_buffer()" failed to apply to 6.13-stable tree
To: rostedt@goodmis.org,mathieu.desnoyers@efficios.com,mhiramat@kernel.org,vdonnefort@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Feb 2025 12:30:20 +0100
Message-ID: <2025021820-swinger-shopping-6edb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.13-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
git checkout FETCH_HEAD
git cherry-pick -x 60b8f711143de7cd9c0f55be0fe7eb94b19eb5c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021820-swinger-shopping-6edb@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 60b8f711143de7cd9c0f55be0fe7eb94b19eb5c7 Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 13 Feb 2025 13:41:32 -0500
Subject: [PATCH] tracing: Have the error of __tracing_resize_ring_buffer()
 passed to user

Currently if __tracing_resize_ring_buffer() returns an error, the
tracing_resize_ringbuffer() returns -ENOMEM. But it may not be a memory
issue that caused the function to fail. If the ring buffer is memory
mapped, then the resizing of the ring buffer will be disabled. But if the
user tries to resize the buffer, it will get an -ENOMEM returned, which is
confusing because there is plenty of memory. The actual error returned was
-EBUSY, which would make much more sense to the user.

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Link: https://lore.kernel.org/20250213134132.7e4505d7@gandalf.local.home
Fixes: 117c39200d9d7 ("ring-buffer: Introducing ring-buffer mapping functions")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1496a5ac33ae..25ff37aab00f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5977,8 +5977,6 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 				  unsigned long size, int cpu_id)
 {
-	int ret;
-
 	guard(mutex)(&trace_types_lock);
 
 	if (cpu_id != RING_BUFFER_ALL_CPUS) {
@@ -5987,11 +5985,7 @@ ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 			return -EINVAL;
 	}
 
-	ret = __tracing_resize_ring_buffer(tr, size, cpu_id);
-	if (ret < 0)
-		ret = -ENOMEM;
-
-	return ret;
+	return __tracing_resize_ring_buffer(tr, size, cpu_id);
 }
 
 static void update_last_data(struct trace_array *tr)


