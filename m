Return-Path: <stable+bounces-119958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D45C0A49D73
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 16:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45DBD174A28
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F2826FDAF;
	Fri, 28 Feb 2025 15:29:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A38225DD1D;
	Fri, 28 Feb 2025 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756573; cv=none; b=WS8nhvAjY6iun8fvJMAIz1EmTZEODKRmtENyJJB7tBiQm1YCM0/HXyY4vUGjefSAmltuEc+Tu/VY1oSw+0x+M4b8xuETaFuWVDxqlUqpQT+/9lkYlgccVByPjqeTgdN4KNrMbABVgGAmj7ovaGiL9RUGcTIbzVdcCGJsVRP8/mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756573; c=relaxed/simple;
	bh=S8IXHnGBnwalsNxpu40Re63/s2nhkYsvGKsG7Oe2IBQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pj+1eCl0mRCaM0ai+j7ttIkmPt0r++vVpWOxEJSZs3pKBeitLBsL0lQDuNdupLkJ2QAuIipdMHNoT4rd4FHzo2EBqY8/dqBcgrGx5fHRow1Bn9hk2hEcRdIzFqg/2+a959tghwugzIJKRPFTWMWwOrufR6QVyaK/dBHCPH2p3d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27F5C4CEEC;
	Fri, 28 Feb 2025 15:29:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1to2Je-0000000ABiB-38qe;
	Fri, 28 Feb 2025 10:30:18 -0500
Message-ID: <20250228153018.601663962@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 28 Feb 2025 10:30:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Wen Yang <wenyang@linux.alibaba.com>,
 Nikolay Kuratov <kniv@yandex-team.ru>
Subject: [for-linus][PATCH 3/3] ftrace: Avoid potential division by zero in function_stat_show()
References: <20250228153003.725613767@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nikolay Kuratov <kniv@yandex-team.ru>

Check whether denominator expression x * (x - 1) * 1000 mod {2^32, 2^64}
produce zero and skip stddev computation in that case.

For now don't care about rec->counter * rec->counter overflow because
rec->time * rec->time overflow will likely happen earlier.

Cc: stable@vger.kernel.org
Cc: Wen Yang <wenyang@linux.alibaba.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250206090156.1561783-1-kniv@yandex-team.ru
Fixes: e31f7939c1c27 ("ftrace: Avoid potential division by zero in function profiler")
Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 6b0c25761ccb..fc88e0688daf 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -540,6 +540,7 @@ static int function_stat_show(struct seq_file *m, void *v)
 	static struct trace_seq s;
 	unsigned long long avg;
 	unsigned long long stddev;
+	unsigned long long stddev_denom;
 #endif
 	guard(mutex)(&ftrace_profile_lock);
 
@@ -559,23 +560,19 @@ static int function_stat_show(struct seq_file *m, void *v)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	seq_puts(m, "    ");
 
-	/* Sample standard deviation (s^2) */
-	if (rec->counter <= 1)
-		stddev = 0;
-	else {
-		/*
-		 * Apply Welford's method:
-		 * s^2 = 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
-		 */
+	/*
+	 * Variance formula:
+	 * s^2 = 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
+	 * Maybe Welford's method is better here?
+	 * Divide only by 1000 for ns^2 -> us^2 conversion.
+	 * trace_print_graph_duration will divide by 1000 again.
+	 */
+	stddev = 0;
+	stddev_denom = rec->counter * (rec->counter - 1) * 1000;
+	if (stddev_denom) {
 		stddev = rec->counter * rec->time_squared -
 			 rec->time * rec->time;
-
-		/*
-		 * Divide only 1000 for ns^2 -> us^2 conversion.
-		 * trace_print_graph_duration will divide 1000 again.
-		 */
-		stddev = div64_ul(stddev,
-				  rec->counter * (rec->counter - 1) * 1000);
+		stddev = div64_ul(stddev, stddev_denom);
 	}
 
 	trace_seq_init(&s);
-- 
2.47.2



