Return-Path: <stable+bounces-141714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61968AAB5CA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440301B63407
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD02929B8E8;
	Tue,  6 May 2025 00:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5yBPCwf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BAC28B7EC;
	Mon,  5 May 2025 23:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487328; cv=none; b=ZLDuYlZGrgfYGnXSIVvzo58Wfh2QmO/OZl3YOi6oSctSQ9ATarTquUj8xnJI66srwwAR6hshYpv2DQ4dm9DfX7HlLeC4WD/s+3WM1nFWincZj/HYiCgdc7aAUwkkPZ/2H06CWpCQStMqTMtXXyHBMHxKSIZCiGBvv0KKB3exsQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487328; c=relaxed/simple;
	bh=9J/hAcUA8PxogD6w8rN8nr7ZfzjH2zUPbNoujqwzwHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FI8Tdm8tTIUZQgtE57CEaTy0RWF7MSO3424hgl32lqhXYOuy+njk8Jy1NO3K1poftcDh+ZQjwJB6OwhLaRgkNlc4p2NluHwPSzIHiiB4xMjBcJE3/5hx+I7Dpj7NNk89VyyCdgZ6ih1UDDyMgwHkUR+C8CW5tSF5ejUX4dii4ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5yBPCwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C541C4CEEE;
	Mon,  5 May 2025 23:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487327;
	bh=9J/hAcUA8PxogD6w8rN8nr7ZfzjH2zUPbNoujqwzwHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5yBPCwf1nLTqdII3kaXTuECClKeb9Lq5TRe2zmVFeZiRzjr4JFgsjHCFC9xeSfg7
	 7sWPqR4ISpXPxT4E/nQYTVChzIAcHzhQQfrKhk2et+yXBdlDDp3S+A+JVFO72o0cQx
	 tOWwHK6s45KSW9nMZZ55YVyGOoxomYuazbbSbHx6PwkVokxX5eXmiZPg3bUpnGLJH9
	 1RfM8vw/oHNIE4YGyT4WoFk4BDcnflOJanyBHlmQ3VzEC05imx2ptFmWegfAi52wOl
	 DE8+yi+2K+A1jDEjUvEEFHTrJI2gQzldwNZEyvvCpDfKOgvW3QbaW57DJxbdYtAjK0
	 0K/ANC7RAK3rw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jing Su <jingsusu@didiglobal.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 08/79] dql: Fix dql->limit value when reset.
Date: Mon,  5 May 2025 19:20:40 -0400
Message-Id: <20250505232151.2698893-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit

From: Jing Su <jingsusu@didiglobal.com>

[ Upstream commit 3a17f23f7c36bac3a3584aaf97d3e3e0b2790396 ]

Executing dql_reset after setting a non-zero value for limit_min can
lead to an unreasonable situation where dql->limit is less than
dql->limit_min.

For instance, after setting
/sys/class/net/eth*/queues/tx-0/byte_queue_limits/limit_min,
an ifconfig down/up operation might cause the ethernet driver to call
netdev_tx_reset_queue, which in turn invokes dql_reset.

In this case, dql->limit is reset to 0 while dql->limit_min remains
non-zero value, which is unexpected. The limit should always be
greater than or equal to limit_min.

Signed-off-by: Jing Su <jingsusu@didiglobal.com>
Link: https://patch.msgid.link/Z9qHD1s/NEuQBdgH@pilot-ThinkCentre-M930t-N000
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/dynamic_queue_limits.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
index e659a027036ec..f6807062b32a3 100644
--- a/lib/dynamic_queue_limits.c
+++ b/lib/dynamic_queue_limits.c
@@ -116,7 +116,7 @@ EXPORT_SYMBOL(dql_completed);
 void dql_reset(struct dql *dql)
 {
 	/* Reset all dynamic values */
-	dql->limit = 0;
+	dql->limit = dql->min_limit;
 	dql->num_queued = 0;
 	dql->num_completed = 0;
 	dql->last_obj_cnt = 0;
-- 
2.39.5


