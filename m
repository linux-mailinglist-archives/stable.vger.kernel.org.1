Return-Path: <stable+bounces-187926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED633BEF54C
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 06:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49830188DF94
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 04:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDA92D0C7A;
	Mon, 20 Oct 2025 04:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NE+3MNAL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D252D027F;
	Mon, 20 Oct 2025 04:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936198; cv=none; b=eo/y5Nzbuh/kLPWTjcP63kADXIhi4YGkE0W4AZX4UL4aDH9Z7tjEmQO4iL8kJ5ErXTAMJhk6V6jClyn1/Qb5N4Czdd714MuaBGOpEmWTFUeAF7fJpHYd5E3uJFXaAFPFdUv2BgzHr+htUKj9RtgrWw9RR6PPBpuiEYuLFw1irFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936198; c=relaxed/simple;
	bh=I1WdqYJWLR3PNSOWKpin7GH4bbZsu9qz49UM1zdBbDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYD2ciEpDJLHz8QfNYew0qTTbmCPnVhIhs4jU+0lY1PQIRYV9zHMczaqokbe46yoBUMoWrhZJRgkjltMcYyQG8FHt1MD5oIJ7lIs4gZY/RwvRsV9DLa+QrEwz+w6pM1tKKQmRezuNpsnLepFg0MBWa6xP2x0zi/XQsEQ0AB4PYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NE+3MNAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C44C4CEFE;
	Mon, 20 Oct 2025 04:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760936198;
	bh=I1WdqYJWLR3PNSOWKpin7GH4bbZsu9qz49UM1zdBbDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NE+3MNAL8pCWwQSpY+zdGeHjh9pQQO7YW3PLk/0h1w4tkRIQnZwbujBnxt9upN9Kz
	 QaoSzBCd5rZMXQWMYvepUk8XAJQ/Ov/9YlSFR+sWJHJX8VVE1ePHbV2jP8AffTmw13
	 uFaFwzxy3YO2vLeSM+B8I6gskE/XTbFWylcacZ+osCM4hwmZ7KTXxxsZYUTi8jTJTa
	 QAJ4q6jCkBpY6cxzmJNOY6N0B4NzM3I1REv4nDifgOY0AIpTcBz0Sr5u4zZCEH9gcb
	 q4wWObZDOOnnVSrW5U+CkmWCOgfi/DCHyS+B7YbFgwCj7gb0WxGNBMZeQ8vchE7i/G
	 FYX8FlWmFgOlQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vAhwo-0000000083i-0NeK;
	Mon, 20 Oct 2025 06:56:42 +0200
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
	Miaoqian Lin <linmq006@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH v3 14/14] iommu/tegra: fix device leak on probe_device()
Date: Mon, 20 Oct 2025 06:53:18 +0200
Message-ID: <20251020045318.30690-15-johan@kernel.org>
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
looking up its driver data during probe_device().

Note that commit 9826e393e4a8 ("iommu/tegra-smmu: Fix missing
put_device() call in tegra_smmu_find") fixed the leak in an error path,
but the reference is still leaking on success.

Fixes: 891846516317 ("memory: Add NVIDIA Tegra memory controller support")
Cc: stable@vger.kernel.org	# 3.19: 9826e393e4a8
Cc: Miaoqian Lin <linmq006@gmail.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Thierry Reding <treding@nvidia.com>
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


