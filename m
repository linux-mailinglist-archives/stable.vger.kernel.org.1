Return-Path: <stable+bounces-98337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4515F9E4040
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04601283785
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C446320E309;
	Wed,  4 Dec 2024 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Noeq6KZ5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C36620E01C;
	Wed,  4 Dec 2024 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331473; cv=none; b=LU2SnXYOnDEEHj/W5z6MiJTrzcxphWek/4Q6ucJASgoQiab1GrODAIVWtXxIREPTSnpnasOWx+nzcc0iuv6NNA8ca8d9f4CqNsjiQOyBiHc4RltnsnoWgvuXERuiX4JjVh845larz5JbBKtUB3ZDbHbEsR0HfUpol6jQ1yk7VtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331473; c=relaxed/simple;
	bh=2GzttSpa/kaeonSAGg1jQW/Lt5L31GNe3I0m2S2UGNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVT9POlOWonLzoucwouAfqOZmO+6+wBxuZbhIVKCoIWo1xAKpOlN9qd6xt8xmydhvjx6+jOPsdc9hUeRz98A7ew1CehAF66jTbEGDAruAb/zBiuncDMlZNoLAwhCcrtHa5wzF3EFgNPnx2Lbp0mtWmDq07HJgdZ9fKLwLRQcfBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Noeq6KZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DE1C4CEDF;
	Wed,  4 Dec 2024 16:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331473;
	bh=2GzttSpa/kaeonSAGg1jQW/Lt5L31GNe3I0m2S2UGNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Noeq6KZ5uscoS/zF2aoOX4NeTvjAYKhmsiswl8zMi3/iMSMoYVhc/izkQuTQGG1DV
	 xnpzYXsULNwaKeZdmKJHfu4xUmzL8AXRspeFxZpAJIpsZ9FHSfnHQLYqRadasxBf+J
	 Ba47+knI3aq0984oRSxnRzZjucfbNIk334xSSGz5/s1TdtI3UvDwknHrDvXGN1wWOc
	 WR6GvWDSTFda8PIBCnquZQRj94tJa3WzsT0RBf8+pw8q9YLCenvGH6L8oWax7QiKhx
	 yUPWmkxjGjQasD2VpOKC65mTrlU6gzfOXyUR+egOmxotuJOreMZfjKMSleLfOVMtCg
	 Sbu9K/qESKNsw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 04/36] tracing: Use atomic64_inc_return() in trace_clock_counter()
Date: Wed,  4 Dec 2024 10:45:20 -0500
Message-ID: <20241204154626.2211476-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204154626.2211476-1-sashal@kernel.org>
References: <20241204154626.2211476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

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


