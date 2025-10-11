Return-Path: <stable+bounces-184049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19B4BCEF90
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 05:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0110D3E89C6
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 03:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FD4223707;
	Sat, 11 Oct 2025 03:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zzu/JWyA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2851DE3B5;
	Sat, 11 Oct 2025 03:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760154762; cv=none; b=fXUTvfAEzkxv/XC6+NyCCfmFZKB/IMtzlzSg14jgwgrZ4bBwTgkzJ2aoDa9iajniwQyEIzHP+LB1AmYrIyYPrqLYe+4qSz2MW80HR5evGk9VnLj/VJ+m5dI3Ri/ViptKFsdvmMkeMHJ0SjOT5jIbMseUuxR8s+l+CynJyF7H4Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760154762; c=relaxed/simple;
	bh=hHT7RPonmCmr1VLw5iY2qbeDIXMl8KdPxaKYzMUv+Q8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fT5mSFXUj+7Cdu6vbGNp3KiAwlY+HoT3eLbB8NQj/uEqiloEbu5YivWZUpVUogEe8eodIUHQ1Zwl3IBwZYZkib1aY67Ky7Wlvh6vPet9/wn3lno4ImtNYi+FG9QhyEhvcDqTr7lmsZ053y/qygnNzQbX2SwqSL/2H79D5sfiaFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zzu/JWyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943E4C116C6;
	Sat, 11 Oct 2025 03:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760154759;
	bh=hHT7RPonmCmr1VLw5iY2qbeDIXMl8KdPxaKYzMUv+Q8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Zzu/JWyA0noMJ8yEUgGvsF6TR/UM1cHAb26dLA5+S0bi4tNVBpk6/yoa/QttbF/yK
	 ITtWUfZ7t0zPG76Z9TMyvKRuUFvYFU1kRba3KTAcKHWShYhAaouOReRD/yb+hTFmXi
	 IuLLBqJjtOFg2PmuZMapktCdhxRxksWwUIbd17i5LKCFZZJJ4w/kMr+6yZB9+x6I40
	 2oYV9JPJR8WblvS4pc83rJVlFARM/BDUS4Nf6FOs63Xf1PluvChReArD1IkRA1QstD
	 elXoJDIM/kShlARyFMXMd0rz3t989o1XXn49AIzCE/ByKko25iXFZUI3KsUKEvp1CQ
	 +g6UwvMvP1uMw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v7Qex-00000000jgk-2vtP;
	Fri, 10 Oct 2025 23:52:43 -0400
Message-ID: <20251011035243.552866788@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 10 Oct 2025 23:51:43 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 syzbot+9a2ede1643175f350105@syzkaller.appspotmail.com
Subject: [PATCH 2/2] tracing: Stop fortify-string from warning in tracing_mark_raw_write()
References: <20251011035141.552201166@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The way tracing_mark_raw_write() records its data is that it has the
following structure:

  struct {
	struct trace_entry;
	int id;
	char dynamic_array[];
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

Use a void pointer and get the offset via offsetof() to keep fortify
string from warning about this copy.

Cc: stable@vger.kernel.org
Fixes: 64cf7d058a00 ("tracing: Have trace_marker use per-cpu data to read user space")
Reported-by: syzbot+9a2ede1643175f350105@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68e973f5.050a0220.1186a4.0010.GAE@google.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bbb89206a891..27855fc9e0f2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7440,6 +7440,7 @@ static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
 	struct raw_data_entry *entry;
 	ssize_t written;
 	size_t size;
+	void *ptr;
 
 	size = sizeof(*entry) + cnt;
 
@@ -7455,7 +7456,10 @@ static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
 		return -EBADF;
 
 	entry = ring_buffer_event_data(event);
-	memcpy(&entry->id, buf, cnt);
+	/* Do not let fortify-string warn copying to &entry->id */
+	ptr = (void *)entry;
+	ptr += offsetof(typeof(*entry), id);
+	memcpy(ptr, buf, cnt);
 	written = cnt;
 
 	__buffer_unlock_commit(buffer, event);
-- 
2.51.0



