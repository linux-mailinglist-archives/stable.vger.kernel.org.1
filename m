Return-Path: <stable+bounces-116815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00551A3A79B
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67DF189061A
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 19:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E4E271267;
	Tue, 18 Feb 2025 19:31:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EBD270EB1;
	Tue, 18 Feb 2025 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907064; cv=none; b=bvHMRf0XRZi2oO+qI7mN5mRAiQ7W4LeDakEpFLiqWOWwJVZD9hXw4qhqo5HKtBvt9bs3+28EJdPf9gf8S/l3rwMZVuYMdSCC7Kuk53v2YVUKSay2rQ+FEWDzGroMguvSSxtvDrbnCfZcmbFI4zmjn8Gl2WzJqNgZMwkYtVyqgUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907064; c=relaxed/simple;
	bh=Nc5G7cjo5t0C+ylkq05UMrUoS1JfeZk/+PH8rHYPIp0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VcFtRt8Sj155ouxP5Gaogh0s1SOMKBDW1ugipPrhBvN0QByWzHUOrtkm2sr9JIr2qaDA9no/Pfye6e0i1pK0SGa69JY/xm3TIxhj4alvp/mfi7cA9LzBTlMKzcYX0xChuMVdosMmIjhgjcUHoAmv0Lunse/YUT9KlY9yXA2yL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10474C4CEE8;
	Tue, 18 Feb 2025 19:31:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tkTJW-000000049zt-2W98;
	Tue, 18 Feb 2025 14:31:26 -0500
Message-ID: <20250218193126.451591597@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 18 Feb 2025 14:30:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Heiko Carstens <hca@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 stable@vger.kernel.org
Subject: [PATCH 2/5] ftrace: Do not add duplicate entries in subops manager ops
References: <20250218193033.338823920@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Check if a function is already in the manager ops of a subops. A manager
ops contains multiple subops, and if two or more subops are tracing the
same function, the manager ops only needs a single entry in its hash.

Cc: stable@vger.kernel.org
Fixes: 4f554e955614f ("ftrace: Add ftrace_set_filter_ips function")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 03b35a05808c..189eb0a12f4b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5717,6 +5717,9 @@ __ftrace_match_addr(struct ftrace_hash *hash, unsigned long ip, int remove)
 			return -ENOENT;
 		free_hash_entry(hash, entry);
 		return 0;
+	} else if (__ftrace_lookup_ip(hash, ip) != NULL) {
+		/* Already exists */
+		return 0;
 	}
 
 	entry = add_hash_entry(hash, ip);
-- 
2.47.2



