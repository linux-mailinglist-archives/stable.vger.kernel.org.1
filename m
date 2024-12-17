Return-Path: <stable+bounces-105019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B38F9F54B0
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E112171EFA
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6BE1FA14B;
	Tue, 17 Dec 2024 17:34:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7121F9F77;
	Tue, 17 Dec 2024 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456884; cv=none; b=CXxgeJ3zVEW9Fvn0CkZqC3d3caoRYDqV3fbfkgT3jtre9kGlxoZYxphS0duIFzEGZ0BpTvNFuNXDa9S/b9ePiviBLB3Ky1xfKxVE7sW8PIefWehga95sQUbHvUUD5Iyqg4zNuM4OfPzTAbEQGeCZRKNfowvrCoLcFyPfQTeeyTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456884; c=relaxed/simple;
	bh=uyKcL51FMKCU+8NLO6bsbfavxaLmObUo8GS/mhDFluw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZmWrNrO/WuDB2PBkFSd8RzlxJ7jQwn3IuFKTVpEvJ56ynnuDsoS1m+ZbLcyHXSwVrscPXSgVkdDesXCZuWI9KbJ16Lr6f3f9obUHcGdTdkDAXrHTRE3puiaWTlKxsmRaPh4v8X64IzPtJU2Uhc57ldtxNlRQv+e+ZoKYnMYSRhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262CDC4CED7;
	Tue, 17 Dec 2024 17:34:44 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tNbTc-00000008cuG-1wdH;
	Tue, 17 Dec 2024 12:35:20 -0500
Message-ID: <20241217173520.314190793@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 17 Dec 2024 12:32:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [PATCH 1/3] ring-buffer: Add uname to match criteria for persistent ring buffer
References: <20241217173237.836878448@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The persistent ring buffer can live across boots. It is expected that the
content in the buffer can be translated to the current kernel with delta
offsets even with KASLR enabled. But it can only guarantee this if the
content of the ring buffer came from the same kernel as the one that is
currently running.

Add uname into the meta data and if the uname in the meta data from the
previous boot does not match the uname of the current boot, then clear the
buffer and re-initialize it.

This only handles the case of kernel versions. It does not clear the
buffer for development. There's several mechanisms to keep bad data from
crashing the kernel. The worse that can happen is some corrupt data may be
displayed.

Cc: stable@vger.kernel.org
Fixes: 8f3e6659656e6 ("ring-buffer: Save text and data locations in mapped meta data")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7e257e855dd1..3c94c59d000c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -17,6 +17,7 @@
 #include <linux/uaccess.h>
 #include <linux/hardirq.h>
 #include <linux/kthread.h>	/* for self test */
+#include <linux/utsname.h>
 #include <linux/module.h>
 #include <linux/percpu.h>
 #include <linux/mutex.h>
@@ -45,10 +46,13 @@
 static void update_pages_handler(struct work_struct *work);
 
 #define RING_BUFFER_META_MAGIC	0xBADFEED
+#define UNAME_SZ 64
 
 struct ring_buffer_meta {
 	int		magic;
 	int		struct_size;
+	char		uname[UNAME_SZ];
+
 	unsigned long	text_addr;
 	unsigned long	data_addr;
 	unsigned long	first_buffer;
@@ -1687,6 +1691,11 @@ static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
 		return false;
 	}
 
+	if (strncmp(init_utsname()->release, meta->uname, UNAME_SZ - 1)) {
+		pr_info("Ring buffer boot meta[%d] mismatch of uname\n", cpu);
+		return false;
+	}
+
 	/* The subbuffer's size and number of subbuffers must match */
 	if (meta->subbuf_size != subbuf_size ||
 	    meta->nr_subbufs != nr_pages + 1) {
@@ -1920,6 +1929,7 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 
 		meta->magic = RING_BUFFER_META_MAGIC;
 		meta->struct_size = sizeof(*meta);
+		strscpy(meta->uname, init_utsname()->release, UNAME_SZ);
 
 		meta->nr_subbufs = nr_pages + 1;
 		meta->subbuf_size = PAGE_SIZE;
-- 
2.45.2



