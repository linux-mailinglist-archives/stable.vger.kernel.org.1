Return-Path: <stable+bounces-78587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D41B798C7B4
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 23:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834232858CB
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 21:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545161CDFA8;
	Tue,  1 Oct 2024 21:42:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E5219ABC3;
	Tue,  1 Oct 2024 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727818937; cv=none; b=qLP9MS16OLjqfkoOBKKXZoAdU6AXj41K42LwI3jN7icL0Dp9upyM8htmWqaISKR1keUPoubmpjP49kvuGMIYLPFiZIDWeqW9OGWrmwyARZTId1uXBAd8/iqgdH0+GICkgpqcC6ij/nch0+8m0pUhiHmuqIuwftb2VW30MMmHSJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727818937; c=relaxed/simple;
	bh=NtNIDtWfmMqbA9v2UdDV5yx1WdIZnZBe0SGFt9K5j3c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=C35m2fUegg3BGWO6uFtK30m1dROnz7OpJ+Gw602XwpKCFuRTFoY9O8GcI2x2JG9DYI/DcNsAc1PvK8JRddy13/Z8lM8pYzUuZfYd/Nn3kayO9GyMQFL01hVLfN/mbvKIuJhMWLDg1WjZTyO2ghtpKmkZ3Cp4dzK+4S24XJNehPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AD8C4CECF;
	Tue,  1 Oct 2024 21:42:16 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1svkeB-00000004csc-0LzK;
	Tue, 01 Oct 2024 17:43:07 -0400
Message-ID: <20241001214306.944809736@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 01 Oct 2024 17:42:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-next][PATCH 1/5] tracing: Fix function timing profiler to initialize hashtable
References: <20241001214241.688116616@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Since the new fgraph requires to initialize fgraph_ops.ops.func_hash before
calling register_ftrace_graph(), initialize it with default (tracing all
functions) parameter.

Cc: stable@vger.kernel.org
Fixes: 5fccc7552ccb ("ftrace: Add subops logic to allow one ops to manage many")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4c28dd177ca6..d2dd71d04b8a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -883,6 +883,10 @@ static void profile_graph_return(struct ftrace_graph_ret *trace,
 }
 
 static struct fgraph_ops fprofiler_ops = {
+	.ops = {
+		.flags = FTRACE_OPS_FL_INITIALIZED,
+		INIT_OPS_HASH(fprofiler_ops.ops)
+	},
 	.entryfunc = &profile_graph_entry,
 	.retfunc = &profile_graph_return,
 };
-- 
2.45.2



