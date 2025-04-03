Return-Path: <stable+bounces-127907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C31A7AD16
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60AE188EEAB
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C512980C5;
	Thu,  3 Apr 2025 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuGye9HB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793002980BC;
	Thu,  3 Apr 2025 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707361; cv=none; b=ZJJ3W0MVnk5zR4JWY7CVyrm5scrdUEPAG/STQcWKk5hIMVW1nei1nkH/9f6ZgCHBqZLM2KYxDLTbNUpzLL/LsC+Ow8C30/HOC7aYE3sZwihfzsT1gRtrvD2PEJF+2zgIZVjncQsRjsDuq4GzcBwIvFlXaX9Ufb6o0+VDnVN6kJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707361; c=relaxed/simple;
	bh=bAA8X/FnO9sTlpclWCg7+bJUVcDdqI0Ptz4ll63zxQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k1ZjqMQuhd3UEYaMDnx3XUEv2qXTAAJIDoVm8Cg8H8a3L9oFbbHSvHPEDw4gSRLMr76KURjL7/XcbPtd7QcqXSi9W0lezHmbrkbDfcqL3FqQRQfeyGW1MdaQqpEN7C8yNjS1f4eTOCgaLgy+25jevbt1gyBJHqHN51TFuR94408=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuGye9HB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE66C4CEEA;
	Thu,  3 Apr 2025 19:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707361;
	bh=bAA8X/FnO9sTlpclWCg7+bJUVcDdqI0Ptz4ll63zxQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RuGye9HBHUSsG3/vSNm4gdMn65vIIwFR3trh2rhE1yZcXduL8CHg8bsgYhbGK7fyU
	 95EyPxazMU3ydtPGcih2zEVdt9bLXOUFirT0hIgSJjiD0JdcfC7WzWsYUQdeEyrFlE
	 hrI4XRJ0tYsIqbFnnGOrUSsTbYsu6mTnNfS9IFXThamNKv4jqhLjprOEJlHWTaqm/n
	 /9zh7/atmR77SKSKNDGSGG8Qe1vZSMWLzZN4/lQl504BtT2/gkCgXQ8aLFcGI6D+BI
	 CmQL24yl+GD+28PwPGhvPGYwd/nvafOnsT1o/mbFFakDWaUFx+LbBKHKzWz0ZoZ6ks
	 LAaozkq5HVa1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabriele Paoloni <gpaoloni@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 16/18] tracing: fix return value in __ftrace_event_enable_disable for TRACE_REG_UNREGISTER
Date: Thu,  3 Apr 2025 15:08:42 -0400
Message-Id: <20250403190845.2678025-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190845.2678025-1-sashal@kernel.org>
References: <20250403190845.2678025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
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
index 94bb5f9251b13..ed0d0c8a2b4bb 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -776,7 +776,9 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
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


