Return-Path: <stable+bounces-65064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FF4943DFC
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E06D1C223EF
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3911D1F74;
	Thu,  1 Aug 2024 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2AJvXXi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FC01D1F6C;
	Thu,  1 Aug 2024 00:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472225; cv=none; b=NIQxG3WPIhxJzW2fstQ4NbQUGqmG1KDUxrLzC7a9zDp6kB02ZgRYDbNFalekfGLZFI3BfBNcJZsoqnWw4vnUh+u1jiPTBuJbqtPiPA0Sm5ZWJLK4AfV/cm+d8Sw+3MXo/eTVcL+xteeI/tmUeyCYLeE8pKN5qzN7Nu8rktyeW+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472225; c=relaxed/simple;
	bh=4chBwmMyJL7Qdbgbo8S62+JLT0K73J4i/DP2CuMYtqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOir+mbBJZBd5XqQULVE9MAIDOkANWnK7D3xkoEj6beDR1lz6NXAwpJT9Yay8i7Ice1Ra8Z/8uZJQXpMeiN8p8vMCSKIT61K4wsNitaho7pYwnRKTeaC+9Hd/5eQdOTDuhSpDG2fyZX8pWmPx5lUWZzd5Hb42uzR6KZXOUaf+Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2AJvXXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261C7C4AF0E;
	Thu,  1 Aug 2024 00:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472223;
	bh=4chBwmMyJL7Qdbgbo8S62+JLT0K73J4i/DP2CuMYtqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2AJvXXiXd4VbP5NY4XvznF6lJI5XNtkL/J2RrV9kSmQ5aE/R4Cq6vP11AfYUA6Kt
	 UB/QT7kHfKOR6oQHUJXFWRyJaAr2tYlLWcjBI04rhGx3WgEEYi2pht/PuCvXfl2m+X
	 NxhWmqFNlaq4gHcFxQjaWi/XaPYoSIQDrOk/+SUOEmrv5h44nPFP+xyPEWBBvhrqdu
	 YfrTcXQWRsgvnzolB/oAb6TdclM9NS+Oz4yP9RayRmiB8mhDEbel8aB8Ss1yoxxNNZ
	 uYfL3hlkmx8oa/35svY8jDcAeHGs7zVo258j30G/pXgHDSyqcs3J1Tc+LnItf5saof
	 Qz8xzwoFKpeyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 35/61] drm/bridge: tc358767: Check if fully initialized before signalling HPD event via IRQ
Date: Wed, 31 Jul 2024 20:25:53 -0400
Message-ID: <20240801002803.3935985-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Marek Vasut <marex@denx.de>

[ Upstream commit 162e48cb1d84c2c966b649b8ac5c9d4f75f6d44f ]

Make sure the connector is fully initialized before signalling any
HPD events via drm_kms_helper_hotplug_event(), otherwise this may
lead to NULL pointer dereference.

Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240531203333.277476-1-marex@denx.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 926ab5c3c31ab..0af2bd8706e44 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1841,7 +1841,7 @@ static irqreturn_t tc_irq_handler(int irq, void *arg)
 		dev_err(tc->dev, "syserr %x\n", stat);
 	}
 
-	if (tc->hpd_pin >= 0 && tc->bridge.dev) {
+	if (tc->hpd_pin >= 0 && tc->bridge.dev && tc->aux.drm_dev) {
 		/*
 		 * H is triggered when the GPIO goes high.
 		 *
-- 
2.43.0


