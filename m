Return-Path: <stable+bounces-163437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D19F0B0B134
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 19:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E418AA192C
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 17:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D8C221F26;
	Sat, 19 Jul 2025 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5jLqyk0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009501C54A9;
	Sat, 19 Jul 2025 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752947874; cv=none; b=qRkg7E5gC8sgHAabZ0tuNVaUG6cgfC3GJfBYIeoU5lVC85mii7wX0qkHwG2jhgWB1Z0JXSENoI8Pj1A99+Cogv9LpsY5xvky6DsQS3rWftebJ2hRWSJySsh0lZ4sYJrHmy19XiN53j4lGHN3UzutLtPQ7SkmYXtHEhbSNLdkR30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752947874; c=relaxed/simple;
	bh=WSJfvxABQUegGVEsD35iWMJc1eMNZLiGFspF49+SlAM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YAXPz3PY4PqJqw3JpbEKYpPEODLu4IQMxnPIUGhWeOHd7WS0ysu6BpZ2Vph4YrLLDe6o5W9XdUoLgaWUToqcoBnusTiiVs0l/wwrAZVvlNG4Y/tlKOK8WKz8G6eGOpkZ1QwrK7uvSy+nv1dcvmVB1MJ81Cw5pJ693lcS7Yig12Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5jLqyk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924DEC4CEF1;
	Sat, 19 Jul 2025 17:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752947873;
	bh=WSJfvxABQUegGVEsD35iWMJc1eMNZLiGFspF49+SlAM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=d5jLqyk0TRQBeLjVzJU2PFggU7hADK62biPRt2L73GthtBhC1xtANPNnW9rBFxkLD
	 dzs9XfwFjSqXIAkGHBUgWKiIhjtE+maKaNRjgTmHGcfH351bjJLRsieHbz6Bezq58n
	 cpFIpvOwpHTgu87+A1eJKZ/XNWujfZjuc/4SlP5k03JZFKDJSRWy1i7DMY6iFC0QME
	 wd7W0t73jtYcDiIjBU4LEBgGtZZ5AxC3b3tZ1QnQjbOH21UmsCI0EjHcG0svVGmmCE
	 YD8/MyXogmFMd+5wpBP7qxRAx+1oEeULcpedrFvaMgO3V1ZlC32PevcTaSCrDQN+SN
	 vUAaxrOkArrTA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1udBpD-000000085HO-3ULw;
	Sat, 19 Jul 2025 13:58:19 -0400
Message-ID: <20250719175819.682506779@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 19 Jul 2025 13:57:55 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Attila Fazekas <afazekas@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>
Subject: [for-linus][PATCH 1/2] tracing/osnoise: Fix crash in timerlat_dump_stack()
References: <20250719175754.996594784@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

We have observed kernel panics when using timerlat with stack saving,
with the following dmesg output:

memcpy: detected buffer overflow: 88 byte write of buffer size 0
WARNING: CPU: 2 PID: 8153 at lib/string_helpers.c:1032 __fortify_report+0x55/0xa0
CPU: 2 UID: 0 PID: 8153 Comm: timerlatu/2 Kdump: loaded Not tainted 6.15.3-200.fc42.x86_64 #1 PREEMPT(lazy)
Call Trace:
 <TASK>
 ? trace_buffer_lock_reserve+0x2a/0x60
 __fortify_panic+0xd/0xf
 __timerlat_dump_stack.cold+0xd/0xd
 timerlat_dump_stack.part.0+0x47/0x80
 timerlat_fd_read+0x36d/0x390
 vfs_read+0xe2/0x390
 ? syscall_exit_to_user_mode+0x1d5/0x210
 ksys_read+0x73/0xe0
 do_syscall_64+0x7b/0x160
 ? exc_page_fault+0x7e/0x1a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

__timerlat_dump_stack() constructs the ftrace stack entry like this:

struct stack_entry *entry;
...
memcpy(&entry->caller, fstack->calls, size);
entry->size = fstack->nr_entries;

Since commit e7186af7fb26 ("tracing: Add back FORTIFY_SOURCE logic to
kernel_stack event structure"), struct stack_entry marks its caller
field with __counted_by(size). At the time of the memcpy, entry->size
contains garbage from the ringbuffer, which under some circumstances is
zero, triggering a kernel panic by buffer overflow.

Populate the size field before the memcpy so that the out-of-bounds
check knows the correct size. This is analogous to
__ftrace_trace_stack().

Cc: stable@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Attila Fazekas <afazekas@redhat.com>
Link: https://lore.kernel.org/20250716143601.7313-1-tglozar@redhat.com
Fixes: e7186af7fb26 ("tracing: Add back FORTIFY_SOURCE logic to kernel_stack event structure")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 6819b93309ce..fd259da0aa64 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -637,8 +637,8 @@ __timerlat_dump_stack(struct trace_buffer *buffer, struct trace_stack *fstack, u
 
 	entry = ring_buffer_event_data(event);
 
-	memcpy(&entry->caller, fstack->calls, size);
 	entry->size = fstack->nr_entries;
+	memcpy(&entry->caller, fstack->calls, size);
 
 	trace_buffer_unlock_commit_nostack(buffer, event);
 }
-- 
2.47.2



