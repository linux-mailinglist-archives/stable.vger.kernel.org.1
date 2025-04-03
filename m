Return-Path: <stable+bounces-127924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33134A7AD52
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFADA175B76
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46392BE7BC;
	Thu,  3 Apr 2025 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIv3oanP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E92E254878;
	Thu,  3 Apr 2025 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707400; cv=none; b=nA4sTeYf6c52332Sur79ZWr9Yt0ZQPSlV0nJLfZyfob2VWvjYGT9hyUYjhoXXMY+I9RGvVagJVsOXJt0pY3KRWc0PSV16t+9mvR+xxf6erM8ehPMcVdyRJzGXXZie3Cf+MVDWN7SC6tJ7ZtqE1pymL/9A4EKOlDWELLBQ8Nj+oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707400; c=relaxed/simple;
	bh=yKADCHG/BodpDRRtO1UUADr8x6OGGCIZTv/a/lmPXPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YuzDLkv4mUnQFdgia/hNrRooCbdwrxsdBCzEHsK+Ed9LlWfAo5p1Kbt0lMzeY9vDZRi4VsUXxJ0LBjLI8OSdOdwQeriJWr5KglmEeLXoFUHqYWYSjfCAFSVwL+piu2iL/X4Fs59qMUxkl8H/r3vrpFpUftmEB46aerXALEhsa04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIv3oanP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443E8C4CEE9;
	Thu,  3 Apr 2025 19:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707400;
	bh=yKADCHG/BodpDRRtO1UUADr8x6OGGCIZTv/a/lmPXPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HIv3oanPXckcMUgrJGUDlfMxV2Vb15G8/tJaOoGCIopxIHv+qBQ7N6y9oPKJWUh8e
	 ntva+jSn/X/ytURIwaodcbjd9ng/6TqxotrpT3oncZ+x7gjideVxmuXvq1sL69cqaS
	 O6Kpcpy3PSS/oHbbGwZ4NPNGFy1lZZ1EdknImVmgAtLeHPQ9Uk602wx6qvyxcXS15j
	 4cqeXD+Sv8DOfLnSdRl1Xqk8ZAtYNs67e+Ssmw67IdXIyLxuO0a+LnTvOeD4ViwLCQ
	 2y61RxOqr8QQCWBHS0DRl6rahbyW+3M+SR0hcZsVI7nL+UR3SdoC6nCn8GFPmpsKv9
	 arz7saQ90ekiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabriele Paoloni <gpaoloni@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 15/16] tracing: fix return value in __ftrace_event_enable_disable for TRACE_REG_UNREGISTER
Date: Thu,  3 Apr 2025 15:09:23 -0400
Message-Id: <20250403190924.2678291-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190924.2678291-1-sashal@kernel.org>
References: <20250403190924.2678291-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
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
index 54a035b079d38..e9d40f9fb09ba 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -763,7 +763,9 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
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


