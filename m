Return-Path: <stable+bounces-127759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D107A7AA68
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768671899C56
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B967F25D52D;
	Thu,  3 Apr 2025 19:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fjon6qlp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7497F25D521;
	Thu,  3 Apr 2025 19:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707031; cv=none; b=Rfa+O2U+oZDXgeV63wgnl5ey8E6uFn10J1BLaeHnLuiO5gp1Df3GEfNRMBcRrxYehhOKj77XeKYKD8/1fCdDryqBMfFUyReFNXv2UkmMN8BxiFI7cwpWLoB/UPDTCe+on3L02ZL5J7n2UTH+/HIMYlJ1Wfb2028HA1q9OJtdieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707031; c=relaxed/simple;
	bh=oNErjt6QpkEEUFYlqbqMaFt25VzZVBP+9XAaSG5J1MU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gofq72EoeTc4vSaqOQ4bxDYHt8c0apmx/eBaetmHSlYFFn7A95zONxy/LnWob6LGIrI8A0RqQ7LIyNz/a8vV7Aelp5a8ZxHKLU2n4Mvt+h0n3xNLy2vB/A4BC90bp7zz+uFTPha7kb799r/qxaRMDYrGmOLZLfx1oDIToRK9e9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fjon6qlp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D58C4CEEA;
	Thu,  3 Apr 2025 19:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707031;
	bh=oNErjt6QpkEEUFYlqbqMaFt25VzZVBP+9XAaSG5J1MU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fjon6qlpqke7whhtX1+1vTegRcq2aH/ORnw62LYD+fHu1u/73F5pdf0CWikGhLugy
	 FN1A+5znS0ZJWV7KI8RaOEnCtQvnPGuqUqfWXjt7ydOBDFHEUHByeHjCTlFauJPkoS
	 KzhOSjqhPxMegPIa7ZLUxjix1hrwR53cpm1Z92S7EIpNf7zIBqIsRYYHnwwpEzDFOL
	 Le61tXz2aFN4rovrPVFRINe1iU1mqqOWxOIL/4B7g8yjRI+YI5aFeK73dov86lMEXr
	 yw5PSOoH69c35U00I9dBjBGa/nW2qQlC1Jee28vG5/BgLMGFsUKiyDgMcizXisYw+V
	 Ht6PRiw8+wIqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabriele Paoloni <gpaoloni@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 44/54] tracing: fix return value in __ftrace_event_enable_disable for TRACE_REG_UNREGISTER
Date: Thu,  3 Apr 2025 15:01:59 -0400
Message-Id: <20250403190209.2675485-44-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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
index 513de9ceb80ef..8e7603acca210 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -790,7 +790,9 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
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


