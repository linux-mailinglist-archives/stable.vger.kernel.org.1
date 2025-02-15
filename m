Return-Path: <stable+bounces-116476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B200A36BD3
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 04:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534A11729F1
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 03:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2098E170A1B;
	Sat, 15 Feb 2025 03:52:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77141624F0;
	Sat, 15 Feb 2025 03:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739591569; cv=none; b=JJyP2ix1qwBZbu75XWHyoJa9ouAEgU4GpYAyiSZd5Ey5Su7rDJiDqhXCcacbdkP5jiRCByrp38JIt0Fd6MBMqAZ6HJQK0jIWWWtWQWP6DeSmJht1PRto4j6cj5GvfVyImcdr8emGOILzxKlxwPvK38e4RAf+yTGkadV6FNDsOwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739591569; c=relaxed/simple;
	bh=LYVwNsgFca20o8iJ9fMn0a36Xx0jM6SIdNj3AIwERK4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ReRIAUIqIE/vnT7neSz1h0jHvsl4EPeA6Dx5A03BwfPSNqG1REKxbTuyBGMFVbQ2eNhwHN0v8YRSsYkSRfmgsNhEjwBONBG/vf8C8m1jmi5B0uuYrbf9+E3yfDZbea4+Ge4M7E24w0HKPEVJJwr15mG3vS3hItot7iy0DIOqA0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8464CC4CEE9;
	Sat, 15 Feb 2025 03:52:48 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tj9Ek-00000002hEX-28oQ;
	Fri, 14 Feb 2025 22:53:02 -0500
Message-ID: <20250215035302.360105504@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 14 Feb 2025 22:52:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-linus][PATCH 2/5] tracing: Have the error of __tracing_resize_ring_buffer() passed to
 user
References: <20250215035231.786853904@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

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
---
 kernel/trace/trace.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

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
-- 
2.47.2



