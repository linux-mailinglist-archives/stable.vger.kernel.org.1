Return-Path: <stable+bounces-65170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DE0943F5E
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0371F28031
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0881C237C;
	Thu,  1 Aug 2024 00:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A49GAaRl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7982E1C2376;
	Thu,  1 Aug 2024 00:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472721; cv=none; b=NreHiEnPTjuF33kV3AEFwNrupVyvlmTZFsvlZWBkrWesGwGocuz12YIBytyPm8hjXA13Nv6ToQbUCCwCw5yqnYQkzaYi6Ap5zJn8Wt0WPVgfvKCQEgKMAEx6ouU+fnN7wg1kTuTOG9d3TzK5O89c6QbIEVJLsAYCktNtGjdwbnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472721; c=relaxed/simple;
	bh=C4Q9Pbkk4LypsD8WJQAO6nK2yAd1c+pnB+369LkTbvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1KnyAgrPqXhoVn2LzGfyg/AGGVvqD2MMDf0JGnnDCdqcj9kX6YPdNOC5Rd69S2U94JroYDcx81uZA4v93CjQLg5V84gh5+bFhvrqxHayRccss8jEmw4417ZYvaozpXpfg+koc5htIhB+CbpLuVCqJr671OJ6H3Zg4QmiXc0hk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A49GAaRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A079C32786;
	Thu,  1 Aug 2024 00:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472721;
	bh=C4Q9Pbkk4LypsD8WJQAO6nK2yAd1c+pnB+369LkTbvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A49GAaRlRPwivn3wfP/S7dlFqxVHJifw+dASdEendG1ZS1PuhbZrFXTGPj8VZReNH
	 m04qbNnW13TzVh+z4cDRQZjryut6WoVXdjFXEcElYrg335hsPtc6oOb4EvY84VI9Jq
	 qnNyZCf8zaBQxg3IyxO95s/kg131d95acUcGzj6v06nboDpzZXOUfiTOM7p4wIk26x
	 9TzBOOCxGyM50+T8DARiW/8+/WRsrDoOE+N8F/XMEKgZAJWIo+GYIIkmcuZu1XgFWy
	 hlxn/P2bSazgNsS7nT7E3OK4PK2I9e27zBuBBEfY0pCxYAPl1ZMRLyRXktHXsGuBbL
	 BYzwzVHaXqHxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 33/38] devres: Initialize an uninitialized struct member
Date: Wed, 31 Jul 2024 20:35:39 -0400
Message-ID: <20240801003643.3938534-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: Zijun Hu <quic_zijuhu@quicinc.com>

[ Upstream commit 56a20ad349b5c51909cf8810f7c79b288864ad33 ]

Initialize an uninitialized struct member for driver API
devres_open_group().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/1719931914-19035-4-git-send-email-quic_zijuhu@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/devres.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 586e9a75c840a..fc5dfbade5529 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -577,6 +577,7 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
 	grp->id = grp;
 	if (id)
 		grp->id = id;
+	grp->color = 0;
 
 	spin_lock_irqsave(&dev->devres_lock, flags);
 	add_dr(dev, &grp->node[0]);
-- 
2.43.0


