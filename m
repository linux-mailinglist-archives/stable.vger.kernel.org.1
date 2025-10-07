Return-Path: <stable+bounces-183523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEECBC0E5F
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 11:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EBF5189FCAC
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 09:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1752D97A5;
	Tue,  7 Oct 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjUrxmX9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256082D9493;
	Tue,  7 Oct 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830296; cv=none; b=fsx47jKJ6e3AkoYfV6zvod5KFRA5cHSs6HBr8eAT3Souj9eVaUuY9GuOp0/DfHgQRSO00YUPeWkMJmwyYSqFoOAo76ZETvWp8nKS5grB8XRjpD0I/MnlmRJXsxr4JyAv/hKV+UO6SI6rSOzD/zLSSkLgeawlJPJd5UoMIyoLIoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830296; c=relaxed/simple;
	bh=3CYEDmeqpw0NtuUPVCDXZwzN28sdvtl+wEi62S8DILA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPd1Zj/H93K+a6kMw66a2YcnrNuFXe0Y2YXSFt1YPUmIQVzfrtVy2lKZy9ZO3Y8dfXum83nAPx3MpbJblIsUn6rRhYoj1+eifCgSInnnDQU1G3uv72ihrkWjI3axo6xHQiPoyuZXMbVvQ8JkXjQeJM7TPJ+u/BHMoMAvlTVkyz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjUrxmX9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61C1C4AF19;
	Tue,  7 Oct 2025 09:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759830296;
	bh=3CYEDmeqpw0NtuUPVCDXZwzN28sdvtl+wEi62S8DILA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hjUrxmX9BEsptsgn9iQczjrgFxbc8Bv4uZWbEkjQcsAviPpwLd52CLgzQOrKfCVKn
	 MAOit3Foy97gHXz0CPFk8LnLvlM10mGyDaFVnHCVOsEQbnAWGsfXIuzl5/pTzZhSr+
	 pfqE521Ra3KZui+LloInVmdIFJExMF+7WEKaPvmIu5iRKeQ6yrtfAlBJO8tkVRD397
	 m/MKMTUXAQ0Ie76RFCbCt3UhdjVMvn+99yqlCLhc0jsQX9gGvqyvBXmoza1pEFWw1W
	 IsUbudLdors9FZZcaT4cTftE2iSM2d3BgWAou9E38DX43gMyD0krWMY0y5sSD1Qkzc
	 H/3z3VfWTmyHg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v64Fa-0000000036B-049n;
	Tue, 07 Oct 2025 11:44:54 +0200
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
	Thierry Reding <treding@nvidia.com>,
	Miaoqian Lin <linmq006@gmail.com>
Subject: [PATCH v2 14/14] iommu/tegra: fix device leak on probe_device()
Date: Tue,  7 Oct 2025 11:43:27 +0200
Message-ID: <20251007094327.11734-15-johan@kernel.org>
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
looking up its driver data during probe_device().

Note that commit 9826e393e4a8 ("iommu/tegra-smmu: Fix missing
put_device() call in tegra_smmu_find") fixed the leak in an error path,
but the reference is still leaking on success.

Fixes: 891846516317 ("memory: Add NVIDIA Tegra memory controller support")
Cc: stable@vger.kernel.org	# 3.19: 9826e393e4a8
Cc: Thierry Reding <treding@nvidia.com>
Cc: Miaoqian Lin <linmq006@gmail.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iommu/tegra-smmu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 36cdd5fbab07..f6f26a072820 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -830,10 +830,9 @@ static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
 		return NULL;
 
 	mc = platform_get_drvdata(pdev);
-	if (!mc) {
-		put_device(&pdev->dev);
+	put_device(&pdev->dev);
+	if (!mc)
 		return NULL;
-	}
 
 	return mc->smmu;
 }
-- 
2.49.1


