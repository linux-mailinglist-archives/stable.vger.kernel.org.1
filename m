Return-Path: <stable+bounces-197061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E199EC8C7E8
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 02:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C9A3B0B02
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 01:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD81B28852E;
	Thu, 27 Nov 2025 01:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="altWrIVJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774943B1B3;
	Thu, 27 Nov 2025 01:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764205293; cv=none; b=CSXtMlqfJBQEs6HTdvItvNQ3j9GIZDxNZC6dgUjWkB89kTIn0YakC0Cr/J8EtcJCPef1YWV6EKNnaYx89ddnpgmb29ZkczT+hhLIzFKa7HlzLmspGOcS36JL2Khi4ldvNCqx/dkElcuwgKkLXfNkhZ2kObOhI3BYWQ+ccKoAWu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764205293; c=relaxed/simple;
	bh=SKBQ8+lQ33UFwKRoD5O6+nU0QPbxUGW+/Bqz/jbtYAU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fNqEgeYQ7Oqe0nVEsg9fFgzg1g+6Hb14P/Ory3NXCa814nEzgmt3L7KsDQyUp5wzCirTKo7K88SOiotwZD75H6kZl9Gz9ZCUfidPog36S0C77rjPOpSAU9uLzIpoeTD3e8xlxOn8hQRdhZIr1EwSzZnr7peU3hJ9T64FsRE23Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=altWrIVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6E7C116D0;
	Thu, 27 Nov 2025 01:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764205293;
	bh=SKBQ8+lQ33UFwKRoD5O6+nU0QPbxUGW+/Bqz/jbtYAU=;
	h=Date:From:To:Cc:Subject:References:From;
	b=altWrIVJRKDxicVP5Te7l1tshks9S753tQzbBGCHLVGim2TaKBWL2ALjC6Q7y9ueM
	 YkIekZAMbanmOLmdtwjkhwtmuzSZOFSa+3GG2dhLjEmPH/YsA4wPPdvFNqMnHetqlh
	 hx/tODzq4mn+PzvJHgYokYVOcFxlOzefDzcgpm48/D18zKq8/vjpKkdw7VKI+uK1cA
	 Ii2pJN1VoLq7lMz4+4JpP36b3Z3KDmC23hdBv81sO7gl+2b4b9U6LfmAUeWfJPnXyV
	 E7FS2qw/eaJfjslvcG/0doWDT4oF6uZFELu8ZbTMY1Q9dNxUD/L3SfhSbhNSlWd9nY
	 DuyvyzCobVaEA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vOQOq-00000006JX0-1wRq;
	Wed, 26 Nov 2025 20:02:20 -0500
Message-ID: <20251127010220.313531895@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 26 Nov 2025 20:02:05 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
  <wang.yaxin@zte.com.cn>,
  <zhang.run@zte.com.cn>,
  <yang.yang29@zte.com.cn>,
 Shengming Hu <hu.shengming@zte.com.cn>
Subject: [for-linus][PATCH 2/2] fgraph: Check ftrace_pids_enabled on registration for early filtering
References: <20251127010203.011129471@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Shengming Hu <hu.shengming@zte.com.cn>

When registering ftrace_graph, check if ftrace_pids_enabled is active.
If enabled, assign entryfunc to fgraph_pid_func to ensure filtering
is performed before executing the saved original entry function.

Cc: stable@vger.kernel.org
Cc: <wang.yaxin@zte.com.cn>
Cc: <mhiramat@kernel.org>
Cc: <mark.rutland@arm.com>
Cc: <mathieu.desnoyers@efficios.com>
Cc: <zhang.run@zte.com.cn>
Cc: <yang.yang29@zte.com.cn>
Link: https://patch.msgid.link/20251126173331679XGVF98NLhyLJRdtNkVZ6w@zte.com.cn
Fixes: df3ec5da6a1e7 ("function_graph: Add pid tracing back to function graph tracer")
Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index d6222bb99d1d..599f2939cd94 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1377,6 +1377,13 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 
 	ftrace_graph_active++;
 
+	/* Always save the function, and reset at unregistering */
+	gops->saved_func = gops->entryfunc;
+#ifdef CONFIG_DYNAMIC_FTRACE
+	if (ftrace_pids_enabled(&gops->ops))
+		gops->entryfunc = fgraph_pid_func;
+#endif
+
 	if (ftrace_graph_active == 2)
 		ftrace_graph_disable_direct(true);
 
@@ -1396,8 +1403,6 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	} else {
 		init_task_vars(gops->idx);
 	}
-	/* Always save the function, and reset at unregistering */
-	gops->saved_func = gops->entryfunc;
 
 	gops->ops.flags |= FTRACE_OPS_FL_GRAPH;
 
-- 
2.51.0



