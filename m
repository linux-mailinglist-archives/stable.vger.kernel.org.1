Return-Path: <stable+bounces-141250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEF2AAB1CD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7401BC5157
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4430341B794;
	Tue,  6 May 2025 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0cLZOhN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA50B2D3FA5;
	Mon,  5 May 2025 22:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485612; cv=none; b=cmtOc6MSIbUSO8FZPBgTdc+nXpZ3o11AAfF0edFxEhfvRS2QKwkunfF5avfz+PjpTOceHhNDo2K2cCuLwaZbstt7OrSY1X3QtEHN3QGNQ670jyNRg7p6kttsg+FtMlxkKxYTc2ov5lcUDD4vV9w3kdIWV709j6XiL/giXWFtnL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485612; c=relaxed/simple;
	bh=aa86rpjTT/uoEWnxipn/ZsY0n6ZfIhYZnLnwkmQFKNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YE5MrCFLZenC9s4/DZNwzOTzGFWWGCjnA+ZFjn8mh6Ub6pV6cB4xMb10nYYNQZCEHgivhVQAmAkA6K1j/A00xrRJB7P/JdkUr+XwV+TontCNevCYRj6qrfVwWFOiRK6xZ16IFp3D4EuKHvGLvoHFDs3I7aH8dPNX222FB5BkgvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0cLZOhN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45F2C4CEF2;
	Mon,  5 May 2025 22:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485610;
	bh=aa86rpjTT/uoEWnxipn/ZsY0n6ZfIhYZnLnwkmQFKNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0cLZOhN7LyRmY/eElFGKDds2Wmqhmby2I/CpaBCswcctZiZLzs0P+GsGEHnDEYU0
	 cSruRhzhChiVn0h1PYmhnPtIZckyVAa6rPMlWHHzq6E7Tsli98P/6KuV33iEApHvii
	 TjxEoEnkrKzabx1Nl2XJPOd26Bq1d2GlsPypUz0CJtLlXeO+QQpsfmq44eCqILzCls
	 FY/U2BUlAREhJn2RZfb9x+6x61ZzQH+p+wyvO/qqjoxFhNY7Pu5jgObhX3iDUY4Zbv
	 lP3vb3wveJ2zXR0JCd8ZUzkNPY512ebvwpguOzLByVq1jl5lYy3qutO+GG1CzBU7Qs
	 14Aqce40fKy5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 385/486] xfrm: prevent high SEQ input in non-ESN mode
Date: Mon,  5 May 2025 18:37:41 -0400
Message-Id: <20250505223922.2682012-385-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit e3aa43a50a6455831e3c32dabc7ece38d9cd9d05 ]

In non-ESN mode, the SEQ numbers are limited to 32 bits and seq_hi/oseq_hi
are not used. So make sure that user gets proper error message, in case
such assignment occurred.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_user.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 87013623773a2..da2a1c00ca8a6 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -178,6 +178,12 @@ static inline int verify_replay(struct xfrm_usersa_info *p,
 				       "Replay seq and seq_hi should be 0 for output SA");
 			return -EINVAL;
 		}
+		if (rs->oseq_hi && !(p->flags & XFRM_STATE_ESN)) {
+			NL_SET_ERR_MSG(
+				extack,
+				"Replay oseq_hi should be 0 in non-ESN mode for output SA");
+			return -EINVAL;
+		}
 		if (rs->bmp_len) {
 			NL_SET_ERR_MSG(extack, "Replay bmp_len should 0 for output SA");
 			return -EINVAL;
@@ -190,6 +196,12 @@ static inline int verify_replay(struct xfrm_usersa_info *p,
 				       "Replay oseq and oseq_hi should be 0 for input SA");
 			return -EINVAL;
 		}
+		if (rs->seq_hi && !(p->flags & XFRM_STATE_ESN)) {
+			NL_SET_ERR_MSG(
+				extack,
+				"Replay seq_hi should be 0 in non-ESN mode for input SA");
+			return -EINVAL;
+		}
 	}
 
 	return 0;
-- 
2.39.5


