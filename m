Return-Path: <stable+bounces-184185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 383DFBD21B9
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 10:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567C71882849
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 08:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0429E2F99AE;
	Mon, 13 Oct 2025 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l4+2xBcU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41062FB994
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760344538; cv=none; b=BQ9Lb5EQ5vnpvz4ltBVAKv4Fap98wzzQ4epD3kk6aKfoT6+zWNtonlndfXSkQva3G5by7K0koKhM/7wY8roiEDeUqfsIHTGLeZOPvBUVB6S65ZnkYnBhyGM/hfxz0be8i7gxM1Mhqok68qUXLVRp0H4mN4zJP1yOaD5Oi7ME7Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760344538; c=relaxed/simple;
	bh=LugaoLWuhKnEz9W5LHHihA/MrBV90hbaRZZV154lpVU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Gap042k6FUQdUiPA8OZVOWdOlIqIXJ+n7wxrMCZ1JOasF5NQxKolmJAT92iJqKUD/sLWJGxG/UdgH+9ofnDOQTeWp3OvX9s7qzvhYS8y4cqfO/HSu3AIIYOxG7OKuWHAEoqdjI6UV/qYToSA5N9XZ8DN2S2zavBkg0OaJgcSgkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l4+2xBcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38FCC4CEFE;
	Mon, 13 Oct 2025 08:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760344538;
	bh=LugaoLWuhKnEz9W5LHHihA/MrBV90hbaRZZV154lpVU=;
	h=Subject:To:Cc:From:Date:From;
	b=l4+2xBcU0M01qrl6eZfaoNYWvjvGlDWiRUtvFPRQBBa0P6SmpkE/cREuYOwvvVErx
	 BrsCvSg+GtV0BHpX+UHzhFaGbdTqZJrZrkMk8d4NRq3p3DLpNAhtRZ3pztcGFiXgW0
	 xTAWpQEeOGELOBEDCHTYXVWg283dzZOGNfnhVAVk=
Subject: FAILED: patch "[PATCH] tracing: Stop fortify-string from warning in" failed to apply to 6.1-stable tree
To: rostedt@goodmis.org,akpm@linux-foundation.org,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 10:35:29 +0200
Message-ID: <2025101329-uncorrupt-ruse-3d0e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 54b91e54b113d4f15ab023a44f508251db6e22e7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101329-uncorrupt-ruse-3d0e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 54b91e54b113d4f15ab023a44f508251db6e22e7 Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Sat, 11 Oct 2025 11:20:32 -0400
Subject: [PATCH] tracing: Stop fortify-string from warning in
 tracing_mark_raw_write()

The way tracing_mark_raw_write() records its data is that it has the
following structure:

  struct {
	struct trace_entry;
	int id;
	char buf[];
  };

But memcpy(&entry->id, buf, size) triggers the following warning when the
size is greater than the id:

 ------------[ cut here ]------------
 memcpy: detected field-spanning write (size 6) of single field "&entry->id" at kernel/trace/trace.c:7458 (size 4)
 WARNING: CPU: 7 PID: 995 at kernel/trace/trace.c:7458 write_raw_marker_to_buffer.isra.0+0x1f9/0x2e0
 Modules linked in:
 CPU: 7 UID: 0 PID: 995 Comm: bash Not tainted 6.17.0-test-00007-g60b82183e78a-dirty #211 PREEMPT(voluntary)
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
 RIP: 0010:write_raw_marker_to_buffer.isra.0+0x1f9/0x2e0
 Code: 04 00 75 a7 b9 04 00 00 00 48 89 de 48 89 04 24 48 c7 c2 e0 b1 d1 b2 48 c7 c7 40 b2 d1 b2 c6 05 2d 88 6a 04 01 e8 f7 e8 bd ff <0f> 0b 48 8b 04 24 e9 76 ff ff ff 49 8d 7c 24 04 49 8d 5c 24 08 48
 RSP: 0018:ffff888104c3fc78 EFLAGS: 00010292
 RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 1ffffffff6b363b4 RDI: 0000000000000001
 RBP: ffff888100058a00 R08: ffffffffb041d459 R09: ffffed1020987f40
 R10: 0000000000000007 R11: 0000000000000001 R12: ffff888100bb9010
 R13: 0000000000000000 R14: 00000000000003e3 R15: ffff888134800000
 FS:  00007fa61d286740(0000) GS:ffff888286cad000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000560d28d509f1 CR3: 00000001047a4006 CR4: 0000000000172ef0
 Call Trace:
  <TASK>
  tracing_mark_raw_write+0x1fe/0x290
  ? __pfx_tracing_mark_raw_write+0x10/0x10
  ? security_file_permission+0x50/0xf0
  ? rw_verify_area+0x6f/0x4b0
  vfs_write+0x1d8/0xdd0
  ? __pfx_vfs_write+0x10/0x10
  ? __pfx_css_rstat_updated+0x10/0x10
  ? count_memcg_events+0xd9/0x410
  ? fdget_pos+0x53/0x5e0
  ksys_write+0x182/0x200
  ? __pfx_ksys_write+0x10/0x10
  ? do_user_addr_fault+0x4af/0xa30
  do_syscall_64+0x63/0x350
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7fa61d318687
 Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
 RSP: 002b:00007ffd87fe0120 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 00007fa61d286740 RCX: 00007fa61d318687
 RDX: 0000000000000006 RSI: 0000560d28d509f0 RDI: 0000000000000001
 RBP: 0000560d28d509f0 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000006
 R13: 00007fa61d4715c0 R14: 00007fa61d46ee80 R15: 0000000000000000
  </TASK>
 ---[ end trace 0000000000000000 ]---

This is because fortify string sees that the size of entry->id is only 4
bytes, but it is writing more than that. But this is OK as the
dynamic_array is allocated to handle that copy.

The size allocated on the ring buffer was actually a bit too big:

  size = sizeof(*entry) + cnt;

But cnt includes the 'id' and the buffer data, so adding cnt to the size
of *entry actually allocates too much on the ring buffer.

Change the allocation to:

  size = struct_size(entry, buf, cnt - sizeof(entry->id));

and the memcpy() to unsafe_memcpy() with an added justification.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/20251011112032.77be18e4@gandalf.local.home
Fixes: 64cf7d058a00 ("tracing: Have trace_marker use per-cpu data to read user space")
Reported-by: syzbot+9a2ede1643175f350105@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68e973f5.050a0220.1186a4.0010.GAE@google.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bbb89206a891..eb256378e65b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7441,7 +7441,8 @@ static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
 	ssize_t written;
 	size_t size;
 
-	size = sizeof(*entry) + cnt;
+	/* cnt includes both the entry->id and the data behind it. */
+	size = struct_size(entry, buf, cnt - sizeof(entry->id));
 
 	buffer = tr->array_buffer.buffer;
 
@@ -7455,7 +7456,10 @@ static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
 		return -EBADF;
 
 	entry = ring_buffer_event_data(event);
-	memcpy(&entry->id, buf, cnt);
+	unsafe_memcpy(&entry->id, buf, cnt,
+		      "id and content already reserved on ring buffer"
+		      "'buf' includes the 'id' and the data."
+		      "'entry' was allocated with cnt from 'id'.");
 	written = cnt;
 
 	__buffer_unlock_commit(buffer, event);


