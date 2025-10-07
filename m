Return-Path: <stable+bounces-183522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4586CBC0E58
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 11:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E094189FF4E
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 09:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D20F2D94BD;
	Tue,  7 Oct 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHupJOz9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED3C2D8789;
	Tue,  7 Oct 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830296; cv=none; b=AZ1sVpWnHQO4KjZdgaSNvsGzTB7odRy03h8+UQomo21CUHYzUTg54Vn3jfPurAFT9BRuM0U1DbcckQxDYmfAGw5R5uBR+yfG8HiF1JJJveuwlYHJBJtIUeLkS5FrqizkkdC1r5UdgLED3ZShp5xe4acdAetW9/lgc6/GxM8/PDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830296; c=relaxed/simple;
	bh=XGze0MX6pPcBSBg10ExvQZidlcuv2+y5+RAOY6fdhVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYzEKArDLW+B6nY1VZ9eK2V+GPuMllAkThjyik+aOSDgQLB8sC+dIu9kF8C1D6m+hUr8ka5wMbIzpiVUfq9aupeVVIAvtdUw4auaSni9Z9Z3xXMzUtpOdall9F5w4+2K/zmUOyTBzPUaUkYdV+6rQafNuiuqjZr1qymrEH0BjJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHupJOz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBB5C4AF0D;
	Tue,  7 Oct 2025 09:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759830295;
	bh=XGze0MX6pPcBSBg10ExvQZidlcuv2+y5+RAOY6fdhVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vHupJOz9DB60p6nlsJmul5k+PmHQF2uqT7w8MOSPUSAvTPbOTnu+ME+eh8CHWcjMT
	 wm5fsCTGtJs9qUJAs5Mwp02ru4hw3mZS98SDpepcRH0rcsO1OdAJ4axx7HpECWQbd2
	 jdiQULvwXTBy/bv1D9z8wDSWhF2ju7rikZAcnBDqUR1KTZIX4WHeDADmvtioVCr55L
	 1sKcmkjsm68XDFv/Mw9FQXP6cwNvZKsUfTFH/Evo77t0iXpvdfWU/hrnsKPzlVJcwN
	 REM9+7VszFjm2WfuM0dCaxhEL1mooWess2tlBo4lJwhkexAGPP/HsdF6/Zmgo/n+Kk
	 imB0viAR4lxiA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v64FZ-00000000368-3q0p;
	Tue, 07 Oct 2025 11:44:53 +0200
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
	Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v2 13/14] iommu/sun50i: fix device leak on of_xlate()
Date: Tue,  7 Oct 2025 11:43:26 +0200
Message-ID: <20251007094327.11734-14-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251007094327.11734-1-johan@kernel.org>
References: <20251007094327.11734-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken to the iommu platform device when
looking up its driver data during of_xlate().

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Cc: stable@vger.kernel.org	# 5.8
Cc: Maxime Ripard <mripard@kernel.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iommu/sun50i-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index de10b569d9a9..6306570d57db 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -839,6 +839,8 @@ static int sun50i_iommu_of_xlate(struct device *dev,
 
 	dev_iommu_priv_set(dev, platform_get_drvdata(iommu_pdev));
 
+	put_device(&iommu_pdev->dev);
+
 	return iommu_fwspec_add_ids(dev, &id, 1);
 }
 
-- 
2.49.1


