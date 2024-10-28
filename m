Return-Path: <stable+bounces-88439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B4A9B25FD
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148C61F20ECE
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9CA18FC7F;
	Mon, 28 Oct 2024 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gu74W+St"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1BE18E34F;
	Mon, 28 Oct 2024 06:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097335; cv=none; b=Tkwg3E3UMyBqyHp/Cyhd/lMDNhNp2sy2JVfeQS0SdwRP04lRvlGp4dJQfHiQeVIgamG7vx3gEyV5PEvGqBiw7fjA0IJnSUDRgTSoP9gURc/Su4sm86U6qDaiGkr59mAf4SC9dVD7+G4/IBxrS2xavnpDZqLIiPV7RFus0RKCsvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097335; c=relaxed/simple;
	bh=rEcYq3Pn7/iOgxuWQ09jTuhTX2Hfb3mB9CijSqSm3qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sasTYHk3LWRkwbJwYKr3fxTluW6By/wC+NLYIbaGl3jiLWa7pVArFy082dRqSKDbhG6GNlVDydVFB5mYggcUNQgy+CJQiTXVrMORDGtdO7EA+pL+XQdbY9h5BLJbh/dZfjqyyl9T098ALfvzcd3uDDgAXiR9FagEqT2NuQklajo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gu74W+St; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FF3C4CEC3;
	Mon, 28 Oct 2024 06:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097334;
	bh=rEcYq3Pn7/iOgxuWQ09jTuhTX2Hfb3mB9CijSqSm3qA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gu74W+StFocjjFPH9pEeyA2VhjLC563X0H8oYQ27eSXeEdQXOcezmEolgu/E47piS
	 OroRbHOkt4w3OJTaMfA5ljpPtGhiEzYGJhQzkZwWQOAQLbxheegqtAMp71TVisoI4B
	 DVHWesf6CpuHRVepmQBAEgAMMandZIvaeRgtWyu4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leo Yan <leo.yan@arm.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 085/137] tracing: Consider the NULL character when validating the event length
Date: Mon, 28 Oct 2024 07:25:22 +0100
Message-ID: <20241028062301.107577084@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062258.708872330@linuxfoundation.org>
References: <20241028062258.708872330@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leo Yan <leo.yan@arm.com>

[ Upstream commit 0b6e2e22cb23105fcb171ab92f0f7516c69c8471 ]

strlen() returns a string length excluding the null byte. If the string
length equals to the maximum buffer length, the buffer will have no
space for the NULL terminating character.

This commit checks this condition and returns failure for it.

Link: https://lore.kernel.org/all/20241007144724.920954-1-leo.yan@arm.com/

Fixes: dec65d79fd26 ("tracing/probe: Check event name length correctly")
Signed-off-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index eef9806bb9b14..ba48b5e270e1f 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -265,7 +265,7 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 		}
 		trace_probe_log_err(offset, NO_EVENT_NAME);
 		return -EINVAL;
-	} else if (len > MAX_EVENT_NAME_LEN) {
+	} else if (len >= MAX_EVENT_NAME_LEN) {
 		trace_probe_log_err(offset, EVENT_TOO_LONG);
 		return -EINVAL;
 	}
-- 
2.43.0




