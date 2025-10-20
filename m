Return-Path: <stable+bounces-187918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE40BEF522
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 06:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9737E3BEF57
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 04:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC022C15A9;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsXsSPqR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766622C026A;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936197; cv=none; b=fmsD5MxySb5dgH/Bg5Rooh5ED209IhvxQRoglBHyoI8kq/MO82JpzVL7sSUduiP/S+OxzBWj0KlrrRGjyNrrNXQrIEAP4QVjR0CS6d13y92g+Wpn1Z0PusarKSecOTXY75eHRMr+HVFh67nHBIdLCjuxyxec0QwRYufh5knpnXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936197; c=relaxed/simple;
	bh=r9qtk/zGzPX4aPYztAqcO0jnG1letB1R7xNmRkHttgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNGYPS+oc5NU5ruPqWGie2AqIM0+fPaytSBCuS/IqaMfb7TdC2nuvp/ZbsKxP8TosJ7lPi0PET5k1cBWJQ27QSLfBaqtKRcwowQY8hNr1kuCrrjShhFsUlUsf1zplbb5TrmmjGeO7pECohU1TLCwx7bQ1D7MHxM0jIOKpapazCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsXsSPqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A47C16AAE;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760936197;
	bh=r9qtk/zGzPX4aPYztAqcO0jnG1letB1R7xNmRkHttgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CsXsSPqR4/uGaj51CAzk6fPYMGPxWJVS+rHIPqDdnu3Is9J2BjUJgsFY3/ileZNu+
	 Bl2lOQnZNTWtA+0rZy20KmAK9p7wz4LffAwBI8JYHlryW3Lbzdh2YhAYLVAkAwefWx
	 cze8yrnZOMrndcepMG8UC2AGSXjI9YxwPJSx1rkUof/YoPttfOI8GG1kCBZhzDN4OX
	 DuIOX6xlQduq2DUe+wABEE8wX9ZGNGqycWC1oKQe1gNNPM/wWpQRdX7JBqoLbz+iEt
	 pYxArjd0ZeELhN3o8saaMeCTpIymnmgQNtCp4CwEjrUlXBPfG0AP91430icrNmFRZ5
	 mrR4if8Zm0egQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vAhwn-00000000835-00sN;
	Mon, 20 Oct 2025 06:56:41 +0200
From: Johan Hovold <johan@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH v3 03/14] iommu/exynos: fix device leak on of_xlate()
Date: Mon, 20 Oct 2025 06:53:07 +0200
Message-ID: <20251020045318.30690-4-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251020045318.30690-1-johan@kernel.org>
References: <20251020045318.30690-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken to the iommu platform device when
looking up its driver data during of_xlate().

Note that commit 1a26044954a6 ("iommu/exynos: add missing put_device()
call in exynos_iommu_of_xlate()") fixed the leak in a couple of error
paths, but the reference is still leaking on success.

Fixes: aa759fd376fb ("iommu/exynos: Add callback for initializing devices from device tree")
Cc: stable@vger.kernel.org	# 4.2: 1a26044954a6
Cc: Yu Kuai <yukuai3@huawei.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iommu/exynos-iommu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index b6edd178fe25..ce9e935cb84c 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1446,17 +1446,14 @@ static int exynos_iommu_of_xlate(struct device *dev,
 		return -ENODEV;
 
 	data = platform_get_drvdata(sysmmu);
-	if (!data) {
-		put_device(&sysmmu->dev);
+	put_device(&sysmmu->dev);
+	if (!data)
 		return -ENODEV;
-	}
 
 	if (!owner) {
 		owner = kzalloc(sizeof(*owner), GFP_KERNEL);
-		if (!owner) {
-			put_device(&sysmmu->dev);
+		if (!owner)
 			return -ENOMEM;
-		}
 
 		INIT_LIST_HEAD(&owner->controllers);
 		mutex_init(&owner->rpm_lock);
-- 
2.49.1


