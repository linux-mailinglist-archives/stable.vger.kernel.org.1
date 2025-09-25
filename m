Return-Path: <stable+bounces-181718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE11B9F3EF
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 14:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FF074E352D
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 12:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87F43054CE;
	Thu, 25 Sep 2025 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtZZu4nz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DBD304BB5;
	Thu, 25 Sep 2025 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803351; cv=none; b=iBxpE6dwlvylBcfr7kI+JlpLbjnCh/bv1FvevX08IvPoo1EsKar5dAaIi4ia1mfgsNL9U5MXZvErcdGfxTe2f6pLCqiWfRKcMjODm8M4yboj7hw8olRN3LAtYJJpjumJPmivEojaskjVsR1N8KU9KDQ1RIaazbA7ooVA/EfV4S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803351; c=relaxed/simple;
	bh=L5PM1JGtNBoMwBhCEkKEi183OrEgxCfculTTkWkh4Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSfIfvmxDYIXvTn0hw/ShX5g2xpbZ2QxvSwt/t1GvRBAqREd6UcNKlsVVItLDQoGAiopA7nhOUHAhdkguu9oiKeFAYkG2YcT84XSRC7F+89+7vA1UMcTDQL8BbHMJ/thJdD7nW5K1RCFz5x0VLCveoaqhMJTtijYGDGEiDTQYGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtZZu4nz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07077C116D0;
	Thu, 25 Sep 2025 12:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758803351;
	bh=L5PM1JGtNBoMwBhCEkKEi183OrEgxCfculTTkWkh4Wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mtZZu4nzTmBz+00n+ie+LSNro7doTRLyp0zDgEUZlyv5VQO2l+MLGOPOMSmt9gB8q
	 VjZ7M9lN2VtCJdpGzDNchHvP7VijCXVu+Yf8QZUZvdmnsdpMmj7SYpG0uU1lh6QxVG
	 lkWAj2x/nnVg5yrTIMc39ppu+exzgL8ORruOIT2Q0CLVt7JuJtymPRcnr1eUDv17pg
	 RjaVqN0d/yQppUNd2fNNcyqe9Zsb8TT4P/eMBUNxf69nRWH19mSR8bw/mbhJNtffl3
	 SzlJ5mBT53PdA6gjI90snc1VwEaFlEmt6hwqNw/PvUaI0uC2/3XbzSGHdim2pmqgFt
	 Jez/9qb1Hkltg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1l5r-000000002s4-1r7Y;
	Thu, 25 Sep 2025 14:29:03 +0200
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
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH 14/14] iommu/tegra: fix device leak on probe_device()
Date: Thu, 25 Sep 2025 14:27:56 +0200
Message-ID: <20250925122756.10910-15-johan@kernel.org>
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

Fixes: 891846516317 ("memory: Add NVIDIA Tegra memory controller support")
Cc: stable@vger.kernel.org	# 3.19
Cc: Thierry Reding <treding@nvidia.com>
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


