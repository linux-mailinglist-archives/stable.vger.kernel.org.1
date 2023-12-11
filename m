Return-Path: <stable+bounces-5397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BB680CBB9
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F5D1C20F3D
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE594779E;
	Mon, 11 Dec 2023 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P68CWjSk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D75947790;
	Mon, 11 Dec 2023 13:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFF0C433C9;
	Mon, 11 Dec 2023 13:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302834;
	bh=eVk+IjDADeV7mI2sCFJC+yD2gIPM9hrqukVoxYm3I/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P68CWjSkr5i8jUc2DuP+DIBaxlwQ7+HbE+qHu8ZQJ+CjPTP9Gw2BX/+KCNHPeMsL3
	 U+9khxkGtDbVAQVKvt5eBdkUL0bheZpPQMPoR5QZDnLkYxlya/uk4/BIcRe5eZIg33
	 Vyfx0BfZFzrdE8nRB/lhwUGn0NY+7+EYK5zP6HXxqGn5BDfQAzuxmWJu6+0FqPHarw
	 Gigfp8Vr0BThyzinr9UXtWYD6nr13qiFGIo5+3ssDNjYS3Nc4hrC8ERbh2T23CB5S9
	 abxXOTW1IGoXYrGTBVr65QLP6V6DXBLOr+0aXQXUDpJnd/egC79Kt5C+vWL+F81c59
	 qjHRuVyE7P8lQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Inki Dae <inki.dae@samsung.com>,
	Sasha Levin <sashal@kernel.org>,
	sw0312.kim@samsung.com,
	kyungmin.park@samsung.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	krzysztof.kozlowski@linaro.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 42/47] drm/exynos: fix a wrong error checking
Date: Mon, 11 Dec 2023 08:50:43 -0500
Message-ID: <20231211135147.380223-42-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit

From: Inki Dae <inki.dae@samsung.com>

[ Upstream commit 8d1b7809684c688005706125b804e1f9792d2b1b ]

Fix a wrong error checking in exynos_drm_dma.c module.

In the exynos_drm_register_dma function, both arm_iommu_create_mapping()
and iommu_get_domain_for_dev() functions are expected to return NULL as
an error.

However, the error checking is performed using the statement
if(IS_ERR(mapping)), which doesn't provide a suitable error value.
So check if 'mapping' is NULL, and if it is, return -ENODEV.

This issue[1] was reported by Dan.

Changelog v1:
- fix build warning.

[1] https://lore.kernel.org/all/33e52277-1349-472b-a55b-ab5c3462bfcf@moroto.mountain/

Reported-by : Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_drm_dma.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dma.c b/drivers/gpu/drm/exynos/exynos_drm_dma.c
index a971590b81323..e2c7373f20c6b 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dma.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dma.c
@@ -107,18 +107,16 @@ int exynos_drm_register_dma(struct drm_device *drm, struct device *dev,
 		return 0;
 
 	if (!priv->mapping) {
-		void *mapping;
+		void *mapping = NULL;
 
 		if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU))
 			mapping = arm_iommu_create_mapping(&platform_bus_type,
 				EXYNOS_DEV_ADDR_START, EXYNOS_DEV_ADDR_SIZE);
 		else if (IS_ENABLED(CONFIG_IOMMU_DMA))
 			mapping = iommu_get_domain_for_dev(priv->dma_dev);
-		else
-			mapping = ERR_PTR(-ENODEV);
 
-		if (IS_ERR(mapping))
-			return PTR_ERR(mapping);
+		if (!mapping)
+			return -ENODEV;
 		priv->mapping = mapping;
 	}
 
-- 
2.42.0


