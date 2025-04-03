Return-Path: <stable+bounces-127939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B509A7AD70
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95C1179B77
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05C62550AA;
	Thu,  3 Apr 2025 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sf/IYZ2e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895E42550A1;
	Thu,  3 Apr 2025 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707434; cv=none; b=vE3y2869n3fvcxxXaMRibaAnlVSj7cE5p3HH9kgX0fd0R3Thr04ppv5z8ppn6wgHPdlVWShZe7tcIQZofdgGfUMvjOopT2BwfmU+hO1MyQkB/dH+v09e7Lva0ORYz9EIUcv4gdN46GqPDWyH7GpzJ2TQXy+805ni6vDKoOgjC3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707434; c=relaxed/simple;
	bh=M/wi6FmdA2Th9ljBZgm7EqqQkpGRVjiB0NHic6xMy84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rVev2aEJ1YsltThWrTkgs0ZeP0/egWTtDcDdxpCQU0ND7lR5GN2ZnquIx9h8sAaenuSjIZmOc7GrSM5yVpFZFDjgFX+fU+VA97tSB9IhF1vsP/7RBKt/Noy0AN6a3KyJMS0y82vjstfmktVhKx33v41RWdQYVGuHRpf9zQ4BT9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sf/IYZ2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B347C4CEE3;
	Thu,  3 Apr 2025 19:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707434;
	bh=M/wi6FmdA2Th9ljBZgm7EqqQkpGRVjiB0NHic6xMy84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sf/IYZ2eXAf2mifTRvRRcAsWxtFS9dBNmEy9kXp2Qbyv7D6dnv6ugObGRu+oJGYcV
	 sVbzbTNMV0g5jJ/zTi3FMWuEnFx2ZWmH9Ol0alhLCEv3uR+l9gRZ0iaTlBSV5ubm0K
	 Cbs0l8XNkFUzRVRPm8uP2F4HK3f0IYmZI4j+tWm8NNAwFcPLmklLtYn+D0cnJtCdqi
	 wYdD7Ub92KnkDFSJ12U2yu44LRSrE1N0bIj1HUXcSiZqGAaRT9XoMEn4laMcchmiHG
	 fB6NlWfMdsO3Q+g1GYzFhDFFLbtX4p5DjXJkqLInsTeT0pF37CZpitGp842U4DN23G
	 6hI5rixJLKUiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabriele Paoloni <gpaoloni@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 14/15] tracing: fix return value in __ftrace_event_enable_disable for TRACE_REG_UNREGISTER
Date: Thu,  3 Apr 2025 15:10:01 -0400
Message-Id: <20250403191002.2678588-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191002.2678588-1-sashal@kernel.org>
References: <20250403191002.2678588-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
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
index 4b5a8d7275be7..92693e2140a94 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -411,7 +411,9 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
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


