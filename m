Return-Path: <stable+bounces-73117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D257296CAF2
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 01:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5347CB21953
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 23:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C252187FEA;
	Wed,  4 Sep 2024 23:43:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FE0186608;
	Wed,  4 Sep 2024 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493407; cv=none; b=jYP7zVjzFIIf0Z0o7oZmjrbpf4SILSpcVOmrzbM+FYbFbkHii0xZ4VbP5QqRkUy4VaNDINhr9kqPbQhjETSIx4zuFdHeUOJ5xTuufIwOyxT83YUrxQWKSrWaPXHKm90J4o2bdRZL8benY54YkjBQAJvDFMG2OiZi1xOJYasxbII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493407; c=relaxed/simple;
	bh=znbtzMLOJQ9Au5yW8iyqOnvVzKUgjfxf+yVoLIyt3rs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=llKo+letmCaGILXiaT7cCOQN6vt6tg2/fex/PAYWJ9YNLLlK6yorb67C8Xl9X7BspZO5lghV62EHMKXq09AwGdF4T2seojl65vPGrLBcjptkcrNv3Ak8wMr/gRVUxPcK9Y3/2grpDJSSgXyPT+Kt1G73fuVvmVcVFZ/0y9Glw4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A122BC4CED5;
	Wed,  4 Sep 2024 23:43:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1slzfo-00000005BpP-1c3u;
	Wed, 04 Sep 2024 19:44:28 -0400
Message-ID: <20240904234428.246209582@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 04 Sep 2024 19:44:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Zheng Yejian <zhengyejian@huaweicloud.com>
Subject: [for-linus][PATCH 5/6] tracing: Avoid possible softlockup in tracing_iter_reset()
References: <20240904234411.443593140@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Zheng Yejian <zhengyejian@huaweicloud.com>

In __tracing_open(), when max latency tracers took place on the cpu,
the time start of its buffer would be updated, then event entries with
timestamps being earlier than start of the buffer would be skipped
(see tracing_iter_reset()).

Softlockup will occur if the kernel is non-preemptible and too many
entries were skipped in the loop that reset every cpu buffer, so add
cond_resched() to avoid it.

Cc: stable@vger.kernel.org
Fixes: 2f26ebd549b9a ("tracing: use timestamp to determine start of latency traces")
Link: https://lore.kernel.org/20240827124654.3817443-1-zhengyejian@huaweicloud.com
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ebe7ce2f5f4a..edf6bc817aa1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3958,6 +3958,8 @@ void tracing_iter_reset(struct trace_iterator *iter, int cpu)
 			break;
 		entries++;
 		ring_buffer_iter_advance(buf_iter);
+		/* This could be a big loop */
+		cond_resched();
 	}
 
 	per_cpu_ptr(iter->array_buffer->data, cpu)->skipped_entries = entries;
-- 
2.43.0



