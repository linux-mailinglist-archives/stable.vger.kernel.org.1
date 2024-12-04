Return-Path: <stable+bounces-98429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073CD9E414D
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B701C285B58
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E84B222562;
	Wed,  4 Dec 2024 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1BTuVmN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08341217674;
	Wed,  4 Dec 2024 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331750; cv=none; b=YPnJPsUHwvdoYUOJ6daiW4pG/AojDfTSC07vFqBkfF6HSt9LPNAOKX6ZCKlJ8GPGV7ZNJrIvsKo3J0wm5KT6rAeNZmaG+Pkyg8uktYlVQBYe3wFZ9sW0mg4XuPTKKUbzl+JeeyrgdFgICHxRgBsvhE+hPPFg29rcdgT/RpY6jkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331750; c=relaxed/simple;
	bh=2GzttSpa/kaeonSAGg1jQW/Lt5L31GNe3I0m2S2UGNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrAXwsSdJFECz1jBQKna6KI6x58GIgWbJM8VoHTWSiOe8TGfDi1X+tRLsRtLbTgGHL+p5RSzp/fnB9alXJeabvJwu5IcI+vbS/TdEui6/nhiXKbOhAwRBQijdRAH5GOtZNloeIVyp1K2e1FCBUkPY1Qb0d6x4/ROCu8A+ncbruY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1BTuVmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EF9C4CEDF;
	Wed,  4 Dec 2024 17:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331749;
	bh=2GzttSpa/kaeonSAGg1jQW/Lt5L31GNe3I0m2S2UGNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1BTuVmNz5WQAaNizsjnF2fuT6e8ufaYffxmGjgOCSPNfyvFAijN+4ZViMpNTfajG
	 xwoDL+DJ7901VqBWVMFN+te7VGg3oOWDbY/CGKxy4cmzRDIcwK44mSwE5oxEzAFJgK
	 KHAxp2yDC+86tFq64w8OV+MCxS0B3lW3QR7BONgchN9kHuOC2QZtUW9mnf3TQzFy4S
	 7GFANpeY6H3QJ5MUe2/tmbyjVwLNgqO9NponQlLDbbbmESDcjia/o3ZF7/i22YzNOA
	 eSIaOaCiGbqqU6emlTXyNBRQuZ3qAn8kFH6oN8qwy2NNbtq1nruiOt4BVwI0UUCI5v
	 8wAxxnIK9JYQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/15] tracing: Use atomic64_inc_return() in trace_clock_counter()
Date: Wed,  4 Dec 2024 10:50:42 -0500
Message-ID: <20241204155105.2214350-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204155105.2214350-1-sashal@kernel.org>
References: <20241204155105.2214350-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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


