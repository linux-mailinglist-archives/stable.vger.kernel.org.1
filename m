Return-Path: <stable+bounces-102459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6779EF300
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA608189FA2F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B4C226863;
	Thu, 12 Dec 2024 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e9V0FfER"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B53226555;
	Thu, 12 Dec 2024 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021305; cv=none; b=AoAa5arYBdOaSOOvAGfQj+bNrZj2P+tRSvRD1jTSlPXDvAtgm/mt5y09l5E8RRxBi8aUBGnJLeDYyqmg4Cw8bPIGfN5vSqomzqI/cQQf8aRqWzDbkZ6nqbLneiHVBG5SOxry4d6Lf2KfUliBXfXPc+UJE7Oeymm4KT0UWNp2z+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021305; c=relaxed/simple;
	bh=QNdCFGP3mI5DPTi1VNtGZ0R6hynkqgoEFuvJ06pnrAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BB0RV1mEfEfuaGPAdnvlTxyDndN2Y+UNsNGOEZf91L+W6G2mHKu+MutgmVI7j8ntNQ7nOOpIWDMMN+bV//7oruVn7wrp6dovouHvBABmLv8zH5xA9/imCSQV+CSUYcxuOsF6kcUEy2StLWZQokNmFJQ33WjVQiYx81EcBE6EhWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e9V0FfER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD7DC4CED0;
	Thu, 12 Dec 2024 16:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734021305;
	bh=QNdCFGP3mI5DPTi1VNtGZ0R6hynkqgoEFuvJ06pnrAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e9V0FfER6tj/DKotl8Lcm3pw30oZ3zDSDkcLZUQNtAV44/uBM1LDOoWiZP32uk9Vl
	 iBR21Cnw5rBLaf1xGtUcqhdOjAm5lmbVQIBdj8qufCa0IPmaWnkr1F2UyPCYsu53LG
	 ofS+E3MebXkLXK15RQfMYge7wqBgaQ6kK8afJcVY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 701/772] tracing: Use atomic64_inc_return() in trace_clock_counter()
Date: Thu, 12 Dec 2024 16:00:46 +0100
Message-ID: <20241212144418.864666799@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uros Bizjak <ubizjak@gmail.com>

[ Upstream commit eb887c4567d1b0e7684c026fe7df44afa96589e6 ]

Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
to use optimized implementation and ease register pressure around
the primitive for targets that implement optimized variant.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20241007085651.48544-1-ubizjak@gmail.com
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_clock.c b/kernel/trace/trace_clock.c
index 4702efb00ff21..4cb2ebc439be6 100644
--- a/kernel/trace/trace_clock.c
+++ b/kernel/trace/trace_clock.c
@@ -154,5 +154,5 @@ static atomic64_t trace_counter;
  */
 u64 notrace trace_clock_counter(void)
 {
-	return atomic64_add_return(1, &trace_counter);
+	return atomic64_inc_return(&trace_counter);
 }
-- 
2.43.0




