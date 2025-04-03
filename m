Return-Path: <stable+bounces-127953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE7CA7AD94
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13403AD5E3
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8CF28D82B;
	Thu,  3 Apr 2025 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A70YS/hp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD1B28D820;
	Thu,  3 Apr 2025 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707467; cv=none; b=LBjZy4mxlIpLjg+AS+ttz9ycyARJoKzp4TZ+zbBE0nJCijLM37xLlTWNcHfoymHEzShHm02tbc2Fb1imSlMUyAAPGqeieGlvpTFuAzJkNDjl6BpL9rl91pV6m0sqsYiWtdEx5kwGNDWnJHa5coPDjVcTd8h60QK+AXkgP4cqO+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707467; c=relaxed/simple;
	bh=l5MUbTrOGiGw2HyOanR1u4xw+ejijXw9Uu8b9vJx5tQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NZN3iIc+MzNn9mLEPpXgH0G8LsuR3rj9rst1xjgvHFwleZZ7VbsHYwfCk8d2Rf7H4tJfx/gknpaTqoSaEM18r2QyUskQHq96Dbd28aN7UQdpvZmKdiXtCSAcaTpj/Z0gAjauPhzD1Psf0GXIZXdfH2X1eM2Ik04Rb+Ae6RTwick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A70YS/hp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6F2C4CEE3;
	Thu,  3 Apr 2025 19:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707467;
	bh=l5MUbTrOGiGw2HyOanR1u4xw+ejijXw9Uu8b9vJx5tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A70YS/hpmlLzRlVe7JhoRn+LtybAzFHX3OfTxGDv0/HUvaG9Ny01o40npq9HSsLU1
	 oV9Qh9Sfj6Z4ybkdT4guM0lmVtUViJVhNFclTxpyN31OctcH6q/By4sHg+4huEnSe8
	 MMdMJP1gERj5LcokOp4IWrpt2msFBK+NanMTcdYVZJFnN6QU6PdkkJHWKsb9yTHyhe
	 +Uf9lo6yp6Gma9pWJrLT1C09Rs0/wBYviEsJ3wI90331kDZsW5rh5u9q3IODzA3jfP
	 fyFgKC2PDt+Dqd+r0PPBokHpw2hMyNkiMUMYmaZZlDBD8V82I2oFhFW1iLDn110i/N
	 03dxiE5/zTlFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabriele Paoloni <gpaoloni@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 13/14] tracing: fix return value in __ftrace_event_enable_disable for TRACE_REG_UNREGISTER
Date: Thu,  3 Apr 2025 15:10:35 -0400
Message-Id: <20250403191036.2678799-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191036.2678799-1-sashal@kernel.org>
References: <20250403191036.2678799-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
Content-Transfer-Encoding: 8bit

From: Gabriele Paoloni <gpaoloni@redhat.com>

[ Upstream commit 0c588ac0ca6c22b774d9ad4a6594681fdfa57d9d ]

When __ftrace_event_enable_disable invokes the class callback to
unregister the event, the return value is not reported up to the
caller, hence leading to event unregister failures being silently
ignored.

This patch assigns the ret variable to the invocation of the
event unregister callback, so that its return value is stored
and reported to the caller, and it raises a warning in case
of error.

Link: https://lore.kernel.org/20250321170821.101403-1-gpaoloni@redhat.com
Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 958789fe4cef7..77df1e28fa329 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -405,7 +405,9 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 				clear_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, &file->flags);
 			}
 
-			call->class->reg(call, TRACE_REG_UNREGISTER, file);
+			ret = call->class->reg(call, TRACE_REG_UNREGISTER, file);
+
+			WARN_ON_ONCE(ret);
 		}
 		/* If in SOFT_MODE, just set the SOFT_DISABLE_BIT, else clear it */
 		if (file->flags & EVENT_FILE_FL_SOFT_MODE)
-- 
2.39.5


