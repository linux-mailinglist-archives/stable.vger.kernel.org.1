Return-Path: <stable+bounces-177052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A155B40303
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E654E6C10
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038D5306498;
	Tue,  2 Sep 2025 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hlwK6jIR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FEB305048;
	Tue,  2 Sep 2025 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819415; cv=none; b=EkW0qqJYCydqjO2pJWFjRElAA585zW04Td13OybqIA0mZFZ6Twjoyb/nNejxGq4aBv6nnQPPrXJND9c9etn5dWs4MIYK7yoASU01ud3u57clsQ45jUpYMKUtxu/61DJ4TkuOcj6Sa6KyoUiXxhzAs9kCm4I6ph1uN+xTNLoTexs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819415; c=relaxed/simple;
	bh=/zwaXZ269znNN+JEfwA/znoNey2P0Lt7Sdkh32cYDUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETfV3LdBMub1J77EtIFoq+lFsskOK0N6j/t5V2Jt7PbZ46q/Rwpr8CGqxmvatNJXEyS7rHL26j0I/nBTqmwT2GNoqhUJTUG1Q7yqJ3vl58rAZeaDhMoxl+VkaUnasQu1thDpKQK51i9sTeuru3W+aXA4MTOC4lSEF97VG+owOpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hlwK6jIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E683CC4CEED;
	Tue,  2 Sep 2025 13:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756819415;
	bh=/zwaXZ269znNN+JEfwA/znoNey2P0Lt7Sdkh32cYDUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hlwK6jIROKukygD8Bdg0ShsKNykjXpWMRHpYuhX+MLGRN6wfvEh9WK3SAAUZFDMpX
	 TtAk8OMomJhTY5JHbFg4p+S+JIn+hQCI23iATIW3HLFiZhlZO7L60I7E338ezx5/cd
	 Tk4y+K+L2bY4TQ8t2mnzwqHZqSPvZ3FXhaLQOE1k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Ye Weihua <yeweihua4@huawei.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 004/142] trace/fgraph: Fix the warning caused by missing unregister notifier
Date: Tue,  2 Sep 2025 15:18:26 +0200
Message-ID: <20250902131948.323493690@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>
References: <20250902131948.154194162@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ye Weihua <yeweihua4@huawei.com>

[ Upstream commit edede7a6dcd7435395cf757d053974aaab6ab1c2 ]

This warning was triggered during testing on v6.16:

notifier callback ftrace_suspend_notifier_call already registered
WARNING: CPU: 2 PID: 86 at kernel/notifier.c:23 notifier_chain_register+0x44/0xb0
...
Call Trace:
 <TASK>
 blocking_notifier_chain_register+0x34/0x60
 register_ftrace_graph+0x330/0x410
 ftrace_profile_write+0x1e9/0x340
 vfs_write+0xf8/0x420
 ? filp_flush+0x8a/0xa0
 ? filp_close+0x1f/0x30
 ? do_dup2+0xaf/0x160
 ksys_write+0x65/0xe0
 do_syscall_64+0xa4/0x260
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

When writing to the function_profile_enabled interface, the notifier was
not unregistered after start_graph_tracing failed, causing a warning the
next time function_profile_enabled was written.

Fixed by adding unregister_pm_notifier in the exception path.

Link: https://lore.kernel.org/20250818073332.3890629-1-yeweihua4@huawei.com
Fixes: 4a2b8dda3f870 ("tracing/function-graph-tracer: fix a regression while suspend to disk")
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Ye Weihua <yeweihua4@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/fgraph.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index c5b207992fb49..dac2d58f39490 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1393,6 +1393,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		ftrace_graph_active--;
 		gops->saved_func = NULL;
 		fgraph_lru_release_index(i);
+		unregister_pm_notifier(&ftrace_suspend_notifier);
 	}
 	return ret;
 }
-- 
2.50.1




