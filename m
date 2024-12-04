Return-Path: <stable+bounces-98373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319EB9E409E
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8CA280DE8
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408B320FA85;
	Wed,  4 Dec 2024 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghFfU2aQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F047420E33A;
	Wed,  4 Dec 2024 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331586; cv=none; b=kodb8t+d62rObQkwHktPjNk0hJtkhuD3lq7KOZSrpRsCGnMe5gFXAvnTZ38b4b21GlzkfYMq0xKgYMR0tgQg1cGYwDmq1e6AjrCll6JGrxbSygrEkZYQgKpsnBLFluM0zzim+Ith8FIRK/cY8VT4DlcGeCEnZDSTaEU3Rk0QH58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331586; c=relaxed/simple;
	bh=2GzttSpa/kaeonSAGg1jQW/Lt5L31GNe3I0m2S2UGNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibGog0YC40ol2ea2YPhy4BPPuMDE6R/1kyqVvLZOxRADPH8+RVL17igLTbNzNbYAZZWIW9wEwmPrAQ3q32e8yHnI9P8fpNk1dpJOCa8ioAjrsH7Joeqp8ySJ9tpLWI23aaNlDAXz983pfbUIdgWzIjTZhpidi2H4kJJ5u4oLhHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghFfU2aQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F72C4CECD;
	Wed,  4 Dec 2024 16:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331585;
	bh=2GzttSpa/kaeonSAGg1jQW/Lt5L31GNe3I0m2S2UGNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ghFfU2aQWktgIaQmwYt8mtc8HWigGdJF5j6lGA3Sqynnbc25xLWoCBcbnLV5OB5v4
	 Eedm9BgZc34ubYKYPQOypqGkLZ/B4I59bVenh4E6mM5aIzHhovebsHQqoeeG+iu/dD
	 IqVD6/BEPB0kJj6yz0jP60cuG8A2AnhjDy0CXQ2wYS/0rDMPyBbbtZqA5tt0GEL19V
	 Or7BIaKclgUTIN0hMTlkmJKm+scezDtv9yQgMgmdnahr0WZIKc1RWWWVv1qlqr0dH2
	 Ub9GwszTiH2zaZOLXwMZEtWUxkkxV+9Kzlbg7vi0Ted9Un0CGKwBo3zLQrsRQ+Gx4l
	 k7oDti1+djdaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 04/33] tracing: Use atomic64_inc_return() in trace_clock_counter()
Date: Wed,  4 Dec 2024 10:47:17 -0500
Message-ID: <20241204154817.2212455-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204154817.2212455-1-sashal@kernel.org>
References: <20241204154817.2212455-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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


