Return-Path: <stable+bounces-92343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629369C53DC
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60DFFB356E0
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2E820FA90;
	Tue, 12 Nov 2024 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jt3p7IKs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5E20899D;
	Tue, 12 Nov 2024 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407347; cv=none; b=GGdx49eyxhxNAp5zLCVPV4QqDQMGhqTMXfMDK+oTudqgZNG/bxJ/Dqwd1DGcpb35Ktvm4x8GuvYgYEJoWsKByEI69/o0LEASkS8Ezl5NsqJf6JK45tiDYs7vcI7u9MzphZ4lBmv2lA6gx20E1YBN1t+KfrJb6nuF+VCSIyN+otI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407347; c=relaxed/simple;
	bh=aSnem5EBFMzFEPVVl0iW2C5mzkKRql5byfnkdSJhNUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLi/M8aE272nw3hPcEYpfw3WekE7svkhyq2ki2snQNbbYaCMXbe6Z+kIU0036AMzOeNQA+ZVlc5ldPW1LTHWCdJy4lZGXlY2Bs+CMIiNU74HL67a6F7zfi2+nGmaTdxlYrbXEca/FpZfEJVSj0hGUi8kCqZ7YudQHoz7Tp1B0vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jt3p7IKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E773C4CECD;
	Tue, 12 Nov 2024 10:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407347;
	bh=aSnem5EBFMzFEPVVl0iW2C5mzkKRql5byfnkdSJhNUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jt3p7IKsTJjXd1YSPc1+8fLMkIpzfSqc051CNLd/wr7lcA3qJAfmsllVvUZbqrERv
	 v5V5uldlzgRo3puOCdNMjtnUEorK2DXokpRbLjaJeH21bZvUOFByz1piNgxUz9qDoX
	 c+tBkXtaQ8dbnkPygZKf93/AvuSILj9XxuJrPxGE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Emil Dahl Juhl <emdj@bang-olufsen.dk>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 41/98] tools/lib/thermal: Fix sampling handler context ptr
Date: Tue, 12 Nov 2024 11:20:56 +0100
Message-ID: <20241112101845.837759237@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101844.263449965@linuxfoundation.org>
References: <20241112101844.263449965@linuxfoundation.org>
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

From: Emil Dahl Juhl <emdj@bang-olufsen.dk>

[ Upstream commit fcd54cf480c87b96313a97dbf898c644b7bb3a2e ]

The sampling handler, provided by the user alongside a void* context,
was invoked with an internal structure instead of the user context.

Correct the invocation of the sampling handler to pass the user context
pointer instead.

Note that the approach taken is similar to that in events.c, and will
reduce the chances of this mistake happening if additional sampling
callbacks are added.

Fixes: 47c4b0de080a ("tools/lib/thermal: Add a thermal library")
Signed-off-by: Emil Dahl Juhl <emdj@bang-olufsen.dk>
Link: https://lore.kernel.org/r/20241015171826.170154-1-emdj@bang-olufsen.dk
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/thermal/sampling.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/thermal/sampling.c b/tools/lib/thermal/sampling.c
index 70577423a9f0c..f67c1f9ea1d78 100644
--- a/tools/lib/thermal/sampling.c
+++ b/tools/lib/thermal/sampling.c
@@ -16,6 +16,8 @@ static int handle_thermal_sample(struct nl_msg *n, void *arg)
 	struct thermal_handler_param *thp = arg;
 	struct thermal_handler *th = thp->th;
 
+	arg = thp->arg;
+
 	genlmsg_parse(nlh, 0, attrs, THERMAL_GENL_ATTR_MAX, NULL);
 
 	switch (genlhdr->cmd) {
-- 
2.43.0




