Return-Path: <stable+bounces-181714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C950B9F3D4
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 14:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8603AEACD
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 12:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C2C303C9D;
	Thu, 25 Sep 2025 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTHItUNy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8750A2FFFAD;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803350; cv=none; b=QuA+LopqWrDwwfCViaeUR6zB4Jy6dhAtFbVRLYk4/f2XwXh3FunTjwuzliYugtP88FVBUi2R7WNs2g9Tf8FfATybfxlOpnKINqewYnveGFojw7lu6QclJ2Sy9Zv0nFZc/lWV024j7NT+wzlghZXmmByiGxBVat6u9Kou7wcUXoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803350; c=relaxed/simple;
	bh=IQqKWSwpV19mfvxErDNJTjiXykWZqudwjNBUkZ5Ps0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6bfXbh5bClpk2Wa5uBdT8a9aegBT+WUfiXBGR7tTK8hGSVxdIOUj4PoGr19Zg2XtBoc69KGVSpvDPB91tjhEZioBBr/IJoPh8edbSXWJ2n9LvhetuhQKEwIILPSxTENuFJQDnlLvLsNom6gTpkGVfiuJGdxDDON5jQ+3ksVF44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTHItUNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43864C19424;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758803350;
	bh=IQqKWSwpV19mfvxErDNJTjiXykWZqudwjNBUkZ5Ps0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NTHItUNyrlmnlxGedYx1ADAJEdH+dRXb+Edphf5s/r7B/WC1qkyMdg+3RAIiej61l
	 Q4wtgxD4p1K2Nhu6qzb9QBvmJxM9mLs5tVOU2D4UXwCXeJ1QSXQN3t/lcjVHvK4qSx
	 UQMqCpa/yQvwWX0U12UrrH3mVe6ZrX9QraflpcpY1DxLR6cqGsjcIxdjdA64iOcjcl
	 W9iu16gykCRCFX9aFbxuyMun5xA/FV5u8ToKz2mPpvAIPP/8K6bV6Uz7bXwJpvSVZ9
	 Kh1UlkjFPlzUSg0sY+bDRhPgZQK7GMzHerLx2l0LJNB5Qv/kd55vD2McQeN0vULd0Y
	 SmM3A9w972Zrg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1l5q-000000002rk-3f4d;
	Thu, 25 Sep 2025 14:29:02 +0200
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
	Honghui Zhang <honghui.zhang@mediatek.com>
Subject: [PATCH 08/14] iommu/mediatek-v1: fix device leak on probe_device()
Date: Thu, 25 Sep 2025 14:27:50 +0200
Message-ID: <20250925122756.10910-9-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250925122756.10910-1-johan@kernel.org>
References: <20250925122756.10910-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken to the iommu platform device when
looking up its driver data during probe_device().

Fixes: b17336c55d89 ("iommu/mediatek: add support for mtk iommu generation one HW")
Cc: stable@vger.kernel.org	# 4.8
Cc: Honghui Zhang <honghui.zhang@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iommu/mtk_iommu_v1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 10cc0b1197e8..de9153c0a82f 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -435,6 +435,8 @@ static int mtk_iommu_v1_create_mapping(struct device *dev,
 			return -EINVAL;
 
 		dev_iommu_priv_set(dev, platform_get_drvdata(m4updev));
+
+		put_device(&m4updev->dev);
 	}
 
 	ret = iommu_fwspec_add_ids(dev, args->args, 1);
-- 
2.49.1


