Return-Path: <stable+bounces-105252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE0E9F71B1
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 02:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE1B168DD7
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 01:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72378339A1;
	Thu, 19 Dec 2024 01:23:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C5E1853;
	Thu, 19 Dec 2024 01:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734571387; cv=none; b=P41cpwcvkVoCMixGEHrbIPIJ47U6htyPkutka8qPYPh+kZVh/zLtm+tOqSLOxpWNl20qAXFLwVJV/avic+QzBmJUTkvkID2g73SHHFim3u5oVhglMNy4RlXGgxqb3AlgYUwRGq1v4wfRQhz13rnNfb6UwQCKygXuzQYXweMPKN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734571387; c=relaxed/simple;
	bh=6Khi+jzISIzfUW9GXWIi5pRc7MyRXAUtE5X+lmCD4Lk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bZFwRNSDSWf6VruXLms+eTsDF7iv2G/JwboYDiQAUaCKeaq7DtLgnAwxT2ONPsieZF5eynplqY4CzAwWcEjnr7wvQWkp60qjNYsq5DFAhRUEnmj9t062NQUZzii4N3lmy9VP2nv1isl+Q+kE1ocH0aNICLxppPemhTJlLyTcTaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1484AC4AF09;
	Thu, 19 Dec 2024 01:23:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tO5GU-00000009mOc-31zH;
	Wed, 18 Dec 2024 20:23:46 -0500
Message-ID: <20241219012346.575822656@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 18 Dec 2024 20:23:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [for-linus][PATCH 2/2] trace/ring-buffer: Do not use TP_printk() formatting for boot mapped
 buffers
References: <20241219012311.649442084@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The TP_printk() of a TRACE_EVENT() is a generic printf format that any
developer can create for their event. It may include pointers to strings
and such. A boot mapped buffer may contain data from a previous kernel
where the strings addresses are different.

One solution is to copy the event content and update the pointers by the
recorded delta, but a simpler solution (for now) is to just use the
print_fields() function to print these events. The print_fields() function
just iterates the fields and prints them according to what type they are,
and ignores the TP_printk() format from the event itself.

To understand the difference, when printing via TP_printk() the output
looks like this:

  4582.696626: kmem_cache_alloc: call_site=getname_flags+0x47/0x1f0 ptr=00000000e70e10e0 bytes_req=4096 bytes_alloc=4096 gfp_flags=GFP_KERNEL node=-1 accounted=false
  4582.696629: kmem_cache_alloc: call_site=alloc_empty_file+0x6b/0x110 ptr=0000000095808002 bytes_req=360 bytes_alloc=384 gfp_flags=GFP_KERNEL node=-1 accounted=false
  4582.696630: kmem_cache_alloc: call_site=security_file_alloc+0x24/0x100 ptr=00000000576339c3 bytes_req=16 bytes_alloc=16 gfp_flags=GFP_KERNEL|__GFP_ZERO node=-1 accounted=false
  4582.696653: kmem_cache_free: call_site=do_sys_openat2+0xa7/0xd0 ptr=00000000e70e10e0 name=names_cache

But when printing via print_fields() (echo 1 > /sys/kernel/tracing/options/fields)
the same event output looks like this:

  4582.696626: kmem_cache_alloc: call_site=0xffffffff92d10d97 (-1831793257) ptr=0xffff9e0e8571e000 (-107689771147264) bytes_req=0x1000 (4096) bytes_alloc=0x1000 (4096) gfp_flags=0xcc0 (3264) node=0xffffffff (-1) accounted=(0)
  4582.696629: kmem_cache_alloc: call_site=0xffffffff92d0250b (-1831852789) ptr=0xffff9e0e8577f800 (-107689770747904) bytes_req=0x168 (360) bytes_alloc=0x180 (384) gfp_flags=0xcc0 (3264) node=0xffffffff (-1) accounted=(0)
  4582.696630: kmem_cache_alloc: call_site=0xffffffff92efca74 (-1829778828) ptr=0xffff9e0e8d35d3b0 (-107689640864848) bytes_req=0x10 (16) bytes_alloc=0x10 (16) gfp_flags=0xdc0 (3520) node=0xffffffff (-1) accounted=(0)
  4582.696653: kmem_cache_free: call_site=0xffffffff92cfbea7 (-1831879001) ptr=0xffff9e0e8571e000 (-107689771147264) name=names_cache

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/20241218141507.28389a1d@gandalf.local.home
Fixes: 07714b4bb3f98 ("tracing: Handle old buffer mappings for event strings and functions")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index be62f0ea1814..6581cb2bc67f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4353,6 +4353,15 @@ static enum print_line_t print_trace_fmt(struct trace_iterator *iter)
 	if (event) {
 		if (tr->trace_flags & TRACE_ITER_FIELDS)
 			return print_event_fields(iter, event);
+		/*
+		 * For TRACE_EVENT() events, the print_fmt is not
+		 * safe to use if the array has delta offsets
+		 * Force printing via the fields.
+		 */
+		if ((tr->text_delta || tr->data_delta) &&
+		    event->type > __TRACE_LAST_TYPE)
+			return print_event_fields(iter, event);
+
 		return event->funcs->trace(iter, sym_flags, event);
 	}
 
-- 
2.45.2



