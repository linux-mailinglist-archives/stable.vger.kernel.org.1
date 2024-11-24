Return-Path: <stable+bounces-95238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5279D7479
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C31B285C55
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70021E47A8;
	Sun, 24 Nov 2024 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dj+A4/jg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826A01E47A3;
	Sun, 24 Nov 2024 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456456; cv=none; b=IASb9el5KZTqYk0WkKdfSTzLCP1YERMBxapKt/fGYFBEzYC7LTlD0r2Z0SdnSCqHsc/3lYOfaUeD8zC57n9Bf+dW6Xy0e8FqEIEKYnv9kuAhLDHiXAwL2zMldaVqRmy17/S99+nqyLQZr7NZgyROLsVzxTgBNE4tK7Nokxxcl/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456456; c=relaxed/simple;
	bh=SO1FmtxOWINuP4gOf5871a9ULM4WWvTKV4ulON3Fvyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXFQ4zdsTz6K4SsWGg+k6ppYxE12JV0guT1yecGrQjC9qzJfepVIU7dQQbz6GEMyNsG2Le+7p1WeJzwSWxMk458bEwmzVRMFXfJUmewL3lQ4Yea8XoLlLQnQTUk3JcChc2zki+UuTMTDamMZs8LrcblvrZy1mFkKXZk56eH1qq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dj+A4/jg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177A6C4CED1;
	Sun, 24 Nov 2024 13:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456456;
	bh=SO1FmtxOWINuP4gOf5871a9ULM4WWvTKV4ulON3Fvyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dj+A4/jgj7J77AOcYOVoWye6GFkmIZ+3y1N8L3sUxTjWci5Hrz0PERj7yUP2/WLbz
	 7zgH4fD1Q+HlxiRPrR/ugD+XyMiiXYq2yLRfA9mC0wNs7mHhSwZh8c9aJzkNcnu+lD
	 ZMtmUQxfGNEuavNWu5mz6cG5TJf4rmGPZDzfc4D2ICCs66IlJy5PN3HYGAj/bnSo8H
	 izzfUUbQKwdDXV7ealJTZmY0Hhf2UmqLtu3Q8VxXBCtN+EVzLkbNz6zTuqv1uF9qVh
	 8O4KeLe2rFjuKrp+L6GWyz/D7tjOnW0ELpRyMegnpvArYOaDCgRcr+I2EaWM++Bj61
	 JxGMyiNOK/2eA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 03/33] drm/mcde: Enable module autoloading
Date: Sun, 24 Nov 2024 08:53:15 -0500
Message-ID: <20241124135410.3349976-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135410.3349976-1-sashal@kernel.org>
References: <20241124135410.3349976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
Content-Transfer-Encoding: 8bit

From: Liao Chen <liaochen4@huawei.com>

[ Upstream commit 8a16b5cdae26207ff4c22834559384ad3d7bc970 ]

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240902113320.903147-4-liaochen4@huawei.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mcde/mcde_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index 210f5e1630081..eb1c87fe65e6c 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -453,6 +453,7 @@ static const struct of_device_id mcde_of_match[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, mcde_of_match);
 
 static struct platform_driver mcde_driver = {
 	.driver = {
-- 
2.43.0


