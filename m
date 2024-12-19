Return-Path: <stable+bounces-105253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C149F71B3
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 02:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D1F169522
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 01:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94BA70808;
	Thu, 19 Dec 2024 01:23:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CD641C72;
	Thu, 19 Dec 2024 01:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734571387; cv=none; b=KWpaYBy3iLVISIhLnI513j2zhsO4xthWk4nXPmwBjRSVDdqFKkPJwbDY336imS6AXxKVfOlkd0bdjrwN4ugQzTVajSxEY56N+ZkIzcqoK8C9fTu9Px4Y1+/VaYbaCNbKC0GCe/x6WEZhHQWSkMXx9ar29mSWbaRJkDv/Sch8m/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734571387; c=relaxed/simple;
	bh=KtKWg+kyrvySj1SXUXmmVG0S88tVlPAeJs4RX52M4Wc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=aK06bDr7KY0xHaFzkpCVI2G8Y6z7Fn2Wlyu/eG7lLLgH5/r8YWHJTZiZfAMoFoG/m0+1QZ+Nqjt+fu1nhdeSIhPq9H4pJWWpTB4aKUjXDuOaRKVLDiWIwhUsZe287Ye5WuPqTsnh7QGYaYZAZ/YZd/hx4QYwC+xpW9wi2vU+Eok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A19C4CED7;
	Thu, 19 Dec 2024 01:23:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tO5GU-00000009mO6-2KG8;
	Wed, 18 Dec 2024 20:23:46 -0500
Message-ID: <20241219012346.411908681@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 18 Dec 2024 20:23:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 syzbot+345e4443a21200874b18@syzkaller.appspotmail.com,
 Edward Adam Davis <eadavis@qq.com>
Subject: [for-linus][PATCH 1/2] ring-buffer: Fix overflow in __rb_map_vma
References: <20241219012311.649442084@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Edward Adam Davis <eadavis@qq.com>

An overflow occurred when performing the following calculation:

   nr_pages = ((nr_subbufs + 1) << subbuf_order) - pgoff;

Add a check before the calculation to avoid this problem.

syzbot reported this as a slab-out-of-bounds in __rb_map_vma:

BUG: KASAN: slab-out-of-bounds in __rb_map_vma+0x9ab/0xae0 kernel/trace/ring_buffer.c:7058
Read of size 8 at addr ffff8880767dd2b8 by task syz-executor187/5836

CPU: 0 UID: 0 PID: 5836 Comm: syz-executor187 Not tainted 6.13.0-rc2-syzkaller-00159-gf932fb9b4074 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 __rb_map_vma+0x9ab/0xae0 kernel/trace/ring_buffer.c:7058
 ring_buffer_map+0x56e/0x9b0 kernel/trace/ring_buffer.c:7138
 tracing_buffers_mmap+0xa6/0x120 kernel/trace/trace.c:8482
 call_mmap include/linux/fs.h:2183 [inline]
 mmap_file mm/internal.h:124 [inline]
 __mmap_new_file_vma mm/vma.c:2291 [inline]
 __mmap_new_vma mm/vma.c:2355 [inline]
 __mmap_region+0x1786/0x2670 mm/vma.c:2456
 mmap_region+0x127/0x320 mm/mmap.c:1348
 do_mmap+0xc00/0xfc0 mm/mmap.c:496
 vm_mmap_pgoff+0x1ba/0x360 mm/util.c:580
 ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:542
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The reproducer for this bug is:

------------------------8<-------------------------
 #include <fcntl.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <asm/types.h>
 #include <sys/mman.h>

 int main(int argc, char **argv)
 {
	int page_size = getpagesize();
	int fd;
	void *meta;

	system("echo 1 > /sys/kernel/tracing/buffer_size_kb");
	fd = open("/sys/kernel/tracing/per_cpu/cpu0/trace_pipe_raw", O_RDONLY);

	meta = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, page_size * 5);
 }
------------------------>8-------------------------

Cc: stable@vger.kernel.org
Fixes: 117c39200d9d7 ("ring-buffer: Introducing ring-buffer mapping functions")
Link: https://lore.kernel.org/tencent_06924B6674ED771167C23CC336C097223609@qq.com
Reported-by: syzbot+345e4443a21200874b18@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=345e4443a21200874b18
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7e257e855dd1..60210fb5b211 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7019,7 +7019,11 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 	lockdep_assert_held(&cpu_buffer->mapping_lock);
 
 	nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
-	nr_pages = ((nr_subbufs + 1) << subbuf_order) - pgoff; /* + meta-page */
+	nr_pages = ((nr_subbufs + 1) << subbuf_order); /* + meta-page */
+	if (nr_pages <= pgoff)
+		return -EINVAL;
+
+	nr_pages -= pgoff;
 
 	nr_vma_pages = vma_pages(vma);
 	if (!nr_vma_pages || nr_vma_pages > nr_pages)
-- 
2.45.2



