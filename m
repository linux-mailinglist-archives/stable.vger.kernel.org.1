Return-Path: <stable+bounces-127858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15FBA7AC9A
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA43117673B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4875927BF6F;
	Thu,  3 Apr 2025 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQaztOah"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE2827BF65;
	Thu,  3 Apr 2025 19:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707254; cv=none; b=j50R44+v6XAsKCqWbvFp7GCZJgscef2OkOkK/ib6qdT4QRuhJRSGoBcavzsc4G1WK2mpqa73bpR6nD8gIJKICUwgYsCYV1e8QckI0jFLUx8KqbfuHJzmCyFJhl/nsYh9DCa5RRF8gmqKyQAtB5Pd61CNQPtqt4Ggokz7tw6HE44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707254; c=relaxed/simple;
	bh=MOAatBjKf1l8cScpVe+1T3EnqqjS5+CGbw9UoFrtGNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DVwZz3nFSTerGkr4hfWvpiC9tmeZ2hJSwEZ3dFYR5E+tTzlq573MoCUXDJA8ysfyhaGrAXmqjp1AhUR2vnnf79EyqL3IOfsGngBIrr0SXMYkD25O8TGE5pexrlG4S1SZEaLcJfLElUb29XTrT1/VNtk7AIiG4hZxGs4O7U39O0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQaztOah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D350C4CEE3;
	Thu,  3 Apr 2025 19:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707253;
	bh=MOAatBjKf1l8cScpVe+1T3EnqqjS5+CGbw9UoFrtGNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQaztOahQ4nkxB1EXlsczPYbkfOYa2Ai5sJt3qX0GBQxLEAoSxIHhG+iMRGftcnGg
	 MA0AjaNjiDShX37UDAHbmem3oal4Bdb+ldhFuOTLeO7noOqNHMuJGPdyBCUc5AQaWN
	 HjycxfrCCFZC+NRzgrwUPlqMPsAyjANlHs53240U5fhhPsu1iwzLHObtArqzk91LXg
	 JIV+y2XQVURGV4zyD6d56Hf+LjWqYXiwoRRlhmNzJV3AKBTmaAAmL45/s6rwofhaYG
	 jMVtX/XQpmDI8+0xvs22xDk6CV9PB8V9d1NiOKCQGojRmyY/+xViIQfTtDPKFPxZmv
	 uK+QlrGxL3AKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabriele Paoloni <gpaoloni@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 40/47] tracing: fix return value in __ftrace_event_enable_disable for TRACE_REG_UNREGISTER
Date: Thu,  3 Apr 2025 15:05:48 -0400
Message-Id: <20250403190555.2677001-40-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
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
index ea9b44847ce6b..e3e46830a8917 100644
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


