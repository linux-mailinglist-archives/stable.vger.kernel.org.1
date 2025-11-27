Return-Path: <stable+bounces-197060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FE4C8C7E5
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 02:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BCFD4E107C
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 01:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B9F2853F3;
	Thu, 27 Nov 2025 01:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atPnHhff"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CC52AE8E;
	Thu, 27 Nov 2025 01:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764205293; cv=none; b=ga8SWXqBnngOOu/YJ2uVCzrkEcvOX2kqS9FaLvh43gqFEm80dr27TQYQd/1D+4z+CwPjaakDORLj5pTz155O+w1Sfc4zgl6ZfehBHf0WHmUYJYN6v0kfXN4GvF1FnRG6Yrqugc0pfGjqWKI24Cnpg39ScYXxVfS2w/2Tc8UB2Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764205293; c=relaxed/simple;
	bh=Lp4ysHYbDJ0zR+BaF4K1aoa2XmaRx89NRtSCINjjCWE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rerQokUq9jMcOygVqj7dirx1OC9AdevlDTAG9u88hn2LeVaBEhSsFq+et6HtpoO+xliGG5edvvJ/qNdMI2Jspck0q9p9hhiKKcx2S74NuT7vsZpzK44RYFTCG1mfSSrhG/iMUl5hhxj5vRzDzSXiOWKhAtQ6U+Whgjmnxi9UijM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atPnHhff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D50C116C6;
	Thu, 27 Nov 2025 01:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764205293;
	bh=Lp4ysHYbDJ0zR+BaF4K1aoa2XmaRx89NRtSCINjjCWE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=atPnHhffKtgiNGBfbRXTO+GkGpGfFRZgPAsC2U35A/fhANs71dePQYyB9Lf25MPV5
	 oNqqipoInDE4FvYtm+7YcYIJqII6DdzzAG/HorPWN1ENV2sHEgBaREf7Qfdxvdi7Uw
	 9CApKtoilg0GY1VwCWpnxT4Zmn++qcrPusL1suDGVyeJuY8oX3Q0LbOi8DlbHMzqLv
	 Fc8O8pgNrbnIe53RLrISsHlL7zVf94kF3GBQNrfRhThrsErY5+54m/c7kq5vCgu7F8
	 VrVr/fq++hHmyzdw/Rqbhy7VJNjRok7jLu9v4rd9UdbDQNK1SU8l2vBK6Fiu3Ue80/
	 /4upMR/YKbhgg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vOQOq-00000006JWW-1EO2;
	Wed, 26 Nov 2025 20:02:20 -0500
Message-ID: <20251127010220.147209669@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 26 Nov 2025 20:02:04 -0500
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
Subject: [for-linus][PATCH 1/2] fgraph: Initialize ftrace_ops->private for function graph ops
References: <20251127010203.011129471@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Shengming Hu <hu.shengming@zte.com.cn>

The ftrace_pids_enabled(op) check relies on op->private being properly
initialized, but fgraph_ops's underlying ftrace_ops->private was left
uninitialized. This caused ftrace_pids_enabled() to always return false,
effectively disabling PID filtering for function graph tracing.

Fix this by copying src_ops->private to dst_ops->private in
fgraph_init_ops(), ensuring PID filter state is correctly propagated.

Cc: stable@vger.kernel.org
Cc: <wang.yaxin@zte.com.cn>
Cc: <mhiramat@kernel.org>
Cc: <mark.rutland@arm.com>
Cc: <mathieu.desnoyers@efficios.com>
Cc: <zhang.run@zte.com.cn>
Cc: <yang.yang29@zte.com.cn>
Fixes: c132be2c4fcc1 ("function_graph: Have the instances use their own ftrace_ops for filtering")
Link: https://patch.msgid.link/20251126172926004y3hC8QyU4WFOjBkU_UxLC@zte.com.cn
Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 484ad7a18463..d6222bb99d1d 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1019,6 +1019,7 @@ void fgraph_init_ops(struct ftrace_ops *dst_ops,
 		mutex_init(&dst_ops->local_hash.regex_lock);
 		INIT_LIST_HEAD(&dst_ops->subop_list);
 		dst_ops->flags |= FTRACE_OPS_FL_INITIALIZED;
+		dst_ops->private = src_ops->private;
 	}
 #endif
 }
-- 
2.51.0



