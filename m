Return-Path: <stable+bounces-183516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF188BC0E37
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 11:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B9E3BE5A4
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 09:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5E52D8363;
	Tue,  7 Oct 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N83hPwoc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4359B2D663B;
	Tue,  7 Oct 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830295; cv=none; b=uj1x6/xE8uOrqY9gkdVZWS88h9SgYkoJaXtlLOtTb4YSRHaJQgpo5VLB/ieYz59xWrb7bK8Af4imBxrVicIGxm4P0AaFNMTExCxKeguePcEKEmR+EXPl3HXIb4M+WU+OizSx2s9ISyo8umeskTNrxFTAG1afedZKs5Y++/rJWIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830295; c=relaxed/simple;
	bh=vQEMyEQQksR3qwPtj8Vyd1cNOXWpewMJ0uOswSl/Zrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmBqKlNpTtlI4L8+w15FGjBH5qpKNAWLXcmJnCnuToxxRUybyo9Hi4N1Qot0ZNIQf3y+HBRLM9sN7t1O69CWc3HAEuEa5RRpmoZLfhJ+LCTHuPatbqk6M0I5qP7ZicVN75oTZhaLcYffP1qh73wyrHtbVEU+daSEyiEVlVOZSX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N83hPwoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F78C4AF0C;
	Tue,  7 Oct 2025 09:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759830295;
	bh=vQEMyEQQksR3qwPtj8Vyd1cNOXWpewMJ0uOswSl/Zrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N83hPwocVOxh8v8DBYiBp8WamYCYfOeOlrtk+zBoj54sNL8yTlm7O8w6XO2x32YV/
	 ACKkm5Nt4c/6WJC48zBr5UpA6L+fT5DGbCdgDkO94KT6v00aq49AecDl4/DVWI3aiU
	 stzYehi2bDG++qAGGZBcU9rDs7934GZmEtYP9uM78mV77/64nsoUBihJvMZ3ecvial
	 +o5wETJiy8NEfBgG/ve6Lu/o/FtkeaPW8yegfSvGb4z88O+Q4rcdtJHr0PxNyX6nrK
	 kMC4UlGEx39SQZFTzB2SOrQK4mQKQEG+E3FfgCEqnmbq/NXHSPJi81dd31hDFFiYVl
	 KBErdTq1KF5SQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v64FZ-0000000035k-0kGT;
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
	stable@vger.kernel.org
Subject: [PATCH v2 05/14] iommu/mediatek: fix device leak on of_xlate()
Date: Tue,  7 Oct 2025 11:43:18 +0200
Message-ID: <20251007094327.11734-6-johan@kernel.org>
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

Fixes: 0df4fabe208d ("iommu/mediatek: Add mt8173 IOMMU driver")
Cc: stable@vger.kernel.org	# 4.6
Cc: Yong Wu <yong.wu@mediatek.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iommu/mtk_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 0e0285348d2b..8d8e85186188 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -974,6 +974,8 @@ static int mtk_iommu_of_xlate(struct device *dev,
 			return -EINVAL;
 
 		dev_iommu_priv_set(dev, platform_get_drvdata(m4updev));
+
+		put_device(&m4updev->dev);
 	}
 
 	return iommu_fwspec_add_ids(dev, args->args, 1);
-- 
2.49.1


