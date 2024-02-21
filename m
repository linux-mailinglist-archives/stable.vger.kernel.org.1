Return-Path: <stable+bounces-23152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8653B85DF81
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9AAC1C23B05
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0845F7BB03;
	Wed, 21 Feb 2024 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K+5wtQ2C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997F79DBF;
	Wed, 21 Feb 2024 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525734; cv=none; b=Sdtb1dg2UZtxJBYo6mCYQd69wi1C48la2an/yCQI0UDszeTvm6Wejuz7IJIzuk5aFbILEZJduBqrrmBbKg+gHX3KCTrNWliOsZXbwIzQIkpJtBiGLuyhr6B5QTk+8J79Y8J43eYvoDhTWw7JqkFl3GZm/bEV6qm/2mZ4PiFWNCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525734; c=relaxed/simple;
	bh=sEAwyiNcuKEdDFhbx5FL0KchqOdoFH5kzbfCKRTOLWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRxKVmpNbhLlysP42LGMaQE5YKDq4yid3QPiee4L1Vng4qaRbYZgUroVu7TGXbIPg7el9vOK0RDP68+1p1JuOCr4S6dzv96ztvHS3E+fdpIGxyHNH0lTHBE5dTxJrnDoWMFn7AmjeqS0Ya3E+Xhopgb1pnw1Gqu3OClG6m61Yfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K+5wtQ2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2660FC433F1;
	Wed, 21 Feb 2024 14:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708525734;
	bh=sEAwyiNcuKEdDFhbx5FL0KchqOdoFH5kzbfCKRTOLWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+5wtQ2CVd3rokWm6AjrrdeGWi2HrnSrVsPEH8Ou2duX69yid8nH3xY46i2PWsLGX
	 X/iqvg2zXe+B37KBhDrW9OQkSZLT+P2fJX2r7cx8mS/VIYoFA1/xW5IeXE0RXsfkac
	 9oEY3pWE3Yty3tgp8gBSjVwPH5dicYTY1EYxDOfQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Kalle Valo <kvalo@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 5.4 247/267] tracing: Inform kmemleak of saved_cmdlines allocation
Date: Wed, 21 Feb 2024 14:09:48 +0100
Message-ID: <20240221125948.007422589@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125940.058369148@linuxfoundation.org>
References: <20240221125940.058369148@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

commit 2394ac4145ea91b92271e675a09af2a9ea6840b7 upstream.

The allocation of the struct saved_cmdlines_buffer structure changed from:

        s = kmalloc(sizeof(*s), GFP_KERNEL);
	s->saved_cmdlines = kmalloc_array(TASK_COMM_LEN, val, GFP_KERNEL);

to:

	orig_size = sizeof(*s) + val * TASK_COMM_LEN;
	order = get_order(orig_size);
	size = 1 << (order + PAGE_SHIFT);
	page = alloc_pages(GFP_KERNEL, order);
	if (!page)
		return NULL;

	s = page_address(page);
	memset(s, 0, sizeof(*s));

	s->saved_cmdlines = kmalloc_array(TASK_COMM_LEN, val, GFP_KERNEL);

Where that s->saved_cmdlines allocation looks to be a dangling allocation
to kmemleak. That's because kmemleak only keeps track of kmalloc()
allocations. For allocations that use page_alloc() directly, the kmemleak
needs to be explicitly informed about it.

Add kmemleak_alloc() and kmemleak_free() around the page allocation so
that it doesn't give the following false positive:

unreferenced object 0xffff8881010c8000 (size 32760):
  comm "swapper", pid 0, jiffies 4294667296
  hex dump (first 32 bytes):
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace (crc ae6ec1b9):
    [<ffffffff86722405>] kmemleak_alloc+0x45/0x80
    [<ffffffff8414028d>] __kmalloc_large_node+0x10d/0x190
    [<ffffffff84146ab1>] __kmalloc+0x3b1/0x4c0
    [<ffffffff83ed7103>] allocate_cmdlines_buffer+0x113/0x230
    [<ffffffff88649c34>] tracer_alloc_buffers.isra.0+0x124/0x460
    [<ffffffff8864a174>] early_trace_init+0x14/0xa0
    [<ffffffff885dd5ae>] start_kernel+0x12e/0x3c0
    [<ffffffff885f5758>] x86_64_start_reservations+0x18/0x30
    [<ffffffff885f582b>] x86_64_start_kernel+0x7b/0x80
    [<ffffffff83a001c3>] secondary_startup_64_no_verify+0x15e/0x16b

Link: https://lore.kernel.org/linux-trace-kernel/87r0hfnr9r.fsf@kernel.org/
Link: https://lore.kernel.org/linux-trace-kernel/20240214112046.09a322d6@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Fixes: 44dc5c41b5b1 ("tracing: Fix wasted memory in saved_cmdlines logic")
Reported-by: Kalle Valo <kvalo@kernel.org>
Tested-by: Kalle Valo <kvalo@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -39,6 +39,7 @@
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #include <linux/init.h>
+#include <linux/kmemleak.h>
 #include <linux/poll.h>
 #include <linux/nmi.h>
 #include <linux/fs.h>
@@ -1996,6 +1997,7 @@ static void free_saved_cmdlines_buffer(s
 	int order = get_order(sizeof(*s) + s->cmdline_num * TASK_COMM_LEN);
 
 	kfree(s->map_cmdline_to_pid);
+	kmemleak_free(s);
 	free_pages((unsigned long)s, order);
 }
 
@@ -2015,6 +2017,7 @@ static struct saved_cmdlines_buffer *all
 		return NULL;
 
 	s = page_address(page);
+	kmemleak_alloc(s, size, 1, GFP_KERNEL);
 	memset(s, 0, sizeof(*s));
 
 	/* Round up to actual allocation */



