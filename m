Return-Path: <stable+bounces-144380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91089AB6CF2
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 15:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659BA19E83B9
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 13:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B1E27E1C3;
	Wed, 14 May 2025 13:39:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4A327B4E5;
	Wed, 14 May 2025 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229953; cv=none; b=Ywkwaarvh3FJ9JbLg9rLSwqWgqBzXx4vnf1Sj/R/DyiVIm8hzTLvjJ1exc8/MZbwZtFwxkJJ2cGrTtpq1ttJRu35//62+arUAEnV45N8v+Z+Lo8PxmeTMw+MBn45NjkhnYyFN5xPNZ1dSiWLMdfZT9gjuVWODRppIXvMrnSg0KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229953; c=relaxed/simple;
	bh=gGOrCyi8ITMcqduWweSJPI6d6U7NRQA/OcOVTwNnYe8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OJb3eU5WYs4kOHjLuHmYxecpNVzKDWoPV2+AeaqWpTLSyU8qIlRqHFJC/a79x1x41FFxsIpxmL96F6QNpeBv+ass95tuQBMUa32N4vmNr6WYOKkv7g4m6cBZGAtpdeejHbnk0SlW3n+5uQx+6FJrTI9OzQlOqQM3LXVDX9WvUso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D7AC4CEEF;
	Wed, 14 May 2025 13:39:13 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uFCKi-00000005IGR-3Tnt;
	Wed, 14 May 2025 09:39:40 -0400
Message-ID: <20250514133940.677423482@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 14 May 2025 09:38:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Tasos Sahanidis <tasos@tasossah.com>
Subject: [for-linus][PATCH 4/4] ring-buffer: Fix persistent buffer when commit page is the reader
 page
References: <20250514133831.110736154@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The ring buffer is made up of sub buffers (sometimes called pages as they
are by default PAGE_SIZE). It has the following "pages":

  "tail page" - this is the page that the next write will write to
  "head page" - this is the page that the reader will swap the reader page with.
  "reader page" - This belongs to the reader, where it will swap the head
                  page from the ring buffer so that the reader does not
                  race with the writer.

The writer may end up on the "reader page" if the ring buffer hasn't
written more than one page, where the "tail page" and the "head page" are
the same.

The persistent ring buffer has meta data that points to where these pages
exist so on reboot it can re-create the pointers to the cpu_buffer
descriptor. But when the commit page is on the reader page, the logic is
incorrect.

The check to see if the commit page is on the reader page checked if the
head page was the reader page, which would never happen, as the head page
is always in the ring buffer. The correct check would be to test if the
commit page is on the reader page. If that's the case, then it can exit
out early as the commit page is only on the reader page when there's only
one page of data in the buffer. There's no reason to iterate the ring
buffer pages to find the "commit page" as it is already found.

To trigger this bug:

  # echo 1 > /sys/kernel/tracing/instances/boot_mapped/events/syscalls/sys_enter_fchownat/enable
  # touch /tmp/x
  # chown sshd /tmp/x
  # reboot

On boot up, the dmesg will have:
 Ring buffer meta [0] is from previous boot!
 Ring buffer meta [1] is from previous boot!
 Ring buffer meta [2] is from previous boot!
 Ring buffer meta [3] is from previous boot!
 Ring buffer meta [4] commit page not found
 Ring buffer meta [5] is from previous boot!
 Ring buffer meta [6] is from previous boot!
 Ring buffer meta [7] is from previous boot!

Where the buffer on CPU 4 had a "commit page not found" error and that
buffer is cleared and reset causing the output to be empty and the data lost.

When it works correctly, it has:

  # cat /sys/kernel/tracing/instances/boot_mapped/trace_pipe
        <...>-1137    [004] .....   998.205323: sys_enter_fchownat: __syscall_nr=0x104 (260) dfd=0xffffff9c (4294967196) filename=(0xffffc90000a0002c) user=0x3e8 (1000) group=0xffffffff (4294967295) flag=0x0 (0

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250513115032.3e0b97f7@gandalf.local.home
Fixes: 5f3b6e839f3ce ("ring-buffer: Validate boot range memory events")
Reported-by: Tasos Sahanidis <tasos@tasossah.com>
Tested-by: Tasos Sahanidis <tasos@tasossah.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c0f877d39a24..3f9bf562beea 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1887,10 +1887,12 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 
 	head_page = cpu_buffer->head_page;
 
-	/* If both the head and commit are on the reader_page then we are done. */
-	if (head_page == cpu_buffer->reader_page &&
-	    head_page == cpu_buffer->commit_page)
+	/* If the commit_buffer is the reader page, update the commit page */
+	if (meta->commit_buffer == (unsigned long)cpu_buffer->reader_page->page) {
+		cpu_buffer->commit_page = cpu_buffer->reader_page;
+		/* Nothing more to do, the only page is the reader page */
 		goto done;
+	}
 
 	/* Iterate until finding the commit page */
 	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_inc_page(&head_page)) {
-- 
2.47.2



