Return-Path: <stable+bounces-127364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4154A7850C
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 00:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3953AFE7C
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 22:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1F721C9E9;
	Tue,  1 Apr 2025 22:57:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6652221B9D8;
	Tue,  1 Apr 2025 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743548261; cv=none; b=RK6niMXEvDmCI/whPjxx9EJIWRAV2xRNLsjo2NCtBHtpNHtcfG6mpodSHa/BPh4qLeDO+aSaxw5DwYhMA0163x3ItrcWu7H0vVw4sJ7X5gwRb7ZzecGXLY0RAjsxfO4zBxpntb+3I8/dwT3bzx0OpEj6PSm7PYN8lOfBTfnZN4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743548261; c=relaxed/simple;
	bh=VVGWqO0rzDMb+s8nP/lH2okTAPFnAxC1NyA5C3vFxbM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dAkL3OMh/lXPlPU9VqxaYh1ZWS0kaPaFygtoasp8/tbg54k0R3xzr9E1wQNZby6MsXHu+F/mnnDxUKaMcpgvfXEzD1ADPRlqVZuhjE6DD9BJwcq/Vp/QY8cy5bkuCZsFo9VOn9D2osV/YoIYkt5uUFoeMjyXnx9Htg66GJKVOCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC197C4CEEF;
	Tue,  1 Apr 2025 22:57:40 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tzkZ8-00000006KaE-3rST;
	Tue, 01 Apr 2025 18:58:42 -0400
Message-ID: <20250401225842.769455187@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 01 Apr 2025 18:58:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>,
 Jann Horn <jannh@google.com>,
 stable@vger.kernel.org
Subject: [PATCH v5 4/4] ring-buffer: Use flush_kernel_vmap_range() over flush_dcache_folio()
References: <20250401225811.008143218@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Some architectures do not have data cache coherency between user and
kernel space. For these architectures, the cache needs to be flushed on
both the kernel and user addresses so that user space can see the updates
the kernel has made.

Instead of using flush_dcache_folio() and playing with virt_to_folio()
within the call to that function, use flush_kernel_vmap_range() which
takes the virtual address and does the work for those architectures that
need it.

This also fixes a bug where the flush of the reader page only flushed one
page. If the sub-buffer order is 1 or more, where the sub-buffer size
would be greater than a page, it would miss the rest of the sub-buffer
content, as the "reader page" is not just a page, but the size of a
sub-buffer.

Link: https://lore.kernel.org/all/CAG48ez3w0my4Rwttbc5tEbNsme6tc0mrSN95thjXUFaJ3aQ6SA@mail.gmail.com/

Cc: stable@vger.kernel.org
Fixes: 117c39200d9d7 ("ring-buffer: Introducing ring-buffer mapping functions");
Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index d8d7b28e2c2f..c0f877d39a24 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6016,7 +6016,7 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 	meta->read = cpu_buffer->read;
 
 	/* Some archs do not have data cache coherency between kernel and user-space */
-	flush_dcache_folio(virt_to_folio(cpu_buffer->meta_page));
+	flush_kernel_vmap_range(cpu_buffer->meta_page, PAGE_SIZE);
 }
 
 static void
@@ -7319,7 +7319,8 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 
 out:
 	/* Some archs do not have data cache coherency between kernel and user-space */
-	flush_dcache_folio(virt_to_folio(cpu_buffer->reader_page->page));
+	flush_kernel_vmap_range(cpu_buffer->reader_page->page,
+				buffer->subbuf_size + BUF_PAGE_HDR_SIZE);
 
 	rb_update_meta_page(cpu_buffer);
 
-- 
2.47.2



