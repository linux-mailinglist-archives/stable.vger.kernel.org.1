Return-Path: <stable+bounces-127371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45949A78661
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 04:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0267816DBBA
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 02:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C2541C69;
	Wed,  2 Apr 2025 02:22:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA0130AC8;
	Wed,  2 Apr 2025 02:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743560553; cv=none; b=iLTl6XzLbkYQN4J8hg+27IzA5eUIHr46zyKThcj3CH4JtWS/EwrkAwbY5P6bljw3QngJa7RJ3jd4cX97bLcLGLBwWVZdCSZLRavMWe/niATDxofZ1fGAMr8I6edfiPF81iikVQhmXQqbBJIf/tt+6Ae35DqE0zMISJg+VbJSmR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743560553; c=relaxed/simple;
	bh=15RPTBSgkhteI6iwl9RvCu+jgBMqWKn7/VmkChot5b4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Kh9a3Ura+ITJhbL1fIWmMk3OBPXz+xpmJAwzA89iK9NrmFwqQW4wub7D9YxJmCt8Lk/55viJ1+Xcu5T3m4D8fPVz6SPYEV2AAlsQ79qWNXMdX+2TtBZSE5QgAhYcmx2R4k1XbFHohoUQUT1fQbAFR0+pDrUCGLhIDounVuBOQio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C08C4CEEF;
	Wed,  2 Apr 2025 02:22:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tznlP-00000006MOK-0jvp;
	Tue, 01 Apr 2025 22:23:35 -0400
Message-ID: <20250402022335.029884348@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 01 Apr 2025 22:23:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 zhoumin <teczm@foxmail.com>
Subject: [for-linus][PATCH 3/4] ftrace: Add cond_resched() to ftrace_graph_set_hash()
References: <20250402022308.372786127@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: zhoumin <teczm@foxmail.com>

When the kernel contains a large number of functions that can be traced,
the loop in ftrace_graph_set_hash() may take a lot of time to execute.
This may trigger the softlockup watchdog.

Add cond_resched() within the loop to allow the kernel to remain
responsive even when processing a large number of functions.

This matches the cond_resched() that is used in other locations of the
code that iterates over all functions that can be traced.

Cc: stable@vger.kernel.org
Fixes: b9b0c831bed26 ("ftrace: Convert graph filter to use hash tables")
Link: https://lore.kernel.org/tencent_3E06CE338692017B5809534B9C5C03DA7705@qq.com
Signed-off-by: zhoumin <teczm@foxmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 92015de6203d..1a48aedb5255 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6855,6 +6855,7 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 				}
 			}
 		}
+		cond_resched();
 	} while_for_each_ftrace_rec();
 
 	return fail ? -EINVAL : 0;
-- 
2.47.2



