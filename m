Return-Path: <stable+bounces-98443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052779E4170
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B139B2886FB
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E3A20E000;
	Wed,  4 Dec 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUqHvUVL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB46225797;
	Wed,  4 Dec 2024 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331783; cv=none; b=EQ4o2Jba3s/bazXCWfx0VN60TM9zsE20ksl49gK8p6ssa9fY86QxlIt1EmCe8yxvdOS9c2lV2jEWibc7C8+noVCQrtYdLmjDAUIRfbjtiqgDAeZIpeG+7A8xAE743XYxvrp39puY+zIh+4tVgHdLE8iF6nNHVEgeeHF7FJ+9g6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331783; c=relaxed/simple;
	bh=2GzttSpa/kaeonSAGg1jQW/Lt5L31GNe3I0m2S2UGNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLPWtAebYQY3tasUm3p8/5FA6H+vaE9mSJbmv39o9e59Ros/lTFObyuKCFQLg5XQBI/btqKuJ+Mpz/2s6EoZ6DS7jjnexDhnIsLLKN8XePfP6aHd64wPYu6b5k6+P91SK0QrSN3BhzvmY8nxlwtx6u3HvVKznkbH8FYDsDFwRCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUqHvUVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D289DC4CED1;
	Wed,  4 Dec 2024 17:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331782;
	bh=2GzttSpa/kaeonSAGg1jQW/Lt5L31GNe3I0m2S2UGNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CUqHvUVLMpma1eJ03ZUePldeMCaWthlNjzubGIjE2HvQP+GGPGtHCELLQYOigsoT8
	 +9f21UnhCbRyv/3VtKD6e9+0jpsHPULPCVXruYMAFQpPQsQ0ixvgtd5hJj718YVH8G
	 GzKNCG/tR+VopOLnqFe5FSD9dAk86aStoTzRKAZo8VwWqkXuyudenwQ9kQ5+65SkIB
	 FhCgXcwy04h39Op6LtKFX8n+nCMJAFijyt7CU3bUwFIf1CzcIDGrA+zHi0/B3kwqrL
	 3ZHrbAiRB+cxiIKgK0FpneageOszrazK80HeOfiCIzgGLopHEpPfaA7WHAkvrKST3C
	 PcxZurxBoB8bg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 2/9] tracing: Use atomic64_inc_return() in trace_clock_counter()
Date: Wed,  4 Dec 2024 10:51:32 -0500
Message-ID: <20241204155141.2214748-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204155141.2214748-1-sashal@kernel.org>
References: <20241204155141.2214748-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
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


