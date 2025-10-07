Return-Path: <stable+bounces-183521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0A1BC0E52
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 11:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBCBF34D362
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 09:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4664E2D94BA;
	Tue,  7 Oct 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGobKLQ8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B962D8799;
	Tue,  7 Oct 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830296; cv=none; b=YP5X3NZWrg5GL2xNweUg/r4PZ/Bk+adyK4YH0Fq2e+RB3hHkUk5uw2XqtVn9Uhfl2ulRENRjQ59mhl+x0+qcc0pz8P6BoCfK8n9swX/2OTe5ArNiXS6gcZDJ+/imRt3/JrYUHUYJM76d61V8ReRYE1uhn+qOco9dOvzIRj0tyqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830296; c=relaxed/simple;
	bh=sHAs1h2nj+F5QylxrrHzaX1LNy9B3/05QnbSzhIUHoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5wTz6M8/bW0+THUfx8jsqdNwzc1X8o2+Wu4wX5I/tIy94xZVnOvx8bBx0xWv1Gw0xtcOzcbauupQC6OTxaQ3pJX4TvmqZRr2eHqE1W6OCC71hQQ+RrDjUQiyKnLMSewi4MYyrB7Q6bKxtf0OmFTANZaznIaIDhuFd6I1ChlhsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGobKLQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F881C4CEF9;
	Tue,  7 Oct 2025 09:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759830295;
	bh=sHAs1h2nj+F5QylxrrHzaX1LNy9B3/05QnbSzhIUHoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hGobKLQ8yajJbGwbnsBI/ukgknoOyJO6eaw4Acko2LP+OFrp9uk67LgL64U+qa0lF
	 gc4URbPn+TYv3ocJqp8Vpha6Zds1a9LPKy0zO4Sv5FM4AUflQt9HM4YeDsMDWD+Q/Q
	 OgPsCr8iEzd6ObFySWekM0kuy6D8LQTyS5Z6iYEgFD43UHVcPjlt/dYZbjW6NyANTM
	 MUTfs64tBKg2vq7V/TG9Z+RAZNS8j32jJ3YCKYRGwbuOBZZ5+0a/j1WZJ/vbGu7iJq
	 s5ADMtrOLJz+nCbu/A/5Kse6nncaVY3ciRbDhgbqQ1d5n41IXlmT9CTkT5yRWjHlBG
	 1zDyZzEX8aW/g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v64FZ-0000000035t-212c;
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
	Honghui Zhang <honghui.zhang@mediatek.com>
Subject: [PATCH v2 08/14] iommu/mediatek-v1: fix device leak on probe_device()
Date: Tue,  7 Oct 2025 11:43:21 +0200
Message-ID: <20251007094327.11734-9-johan@kernel.org>
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

Fixes: b17336c55d89 ("iommu/mediatek: add support for mtk iommu generation one HW")
Cc: stable@vger.kernel.org	# 4.8
Cc: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
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


