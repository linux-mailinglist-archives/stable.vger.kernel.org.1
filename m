Return-Path: <stable+bounces-187925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1978BEF549
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 06:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41353E307A
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 04:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAA32D063D;
	Mon, 20 Oct 2025 04:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bx+k0I0X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6A92C3271;
	Mon, 20 Oct 2025 04:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936198; cv=none; b=dh6Ig1f0MJyii80TvzcMjQAGWwtror52GJxOqZuAkyoCI6QoldDACMXubiZBGU2YQdWGokpgo3/iM0CUPZspMbo5ppRqVi6mVNa0IMGVVirUbuQuwxLY02XI2UHjM5LPTFG6RRIPuBMuyyYKvkWf+JOuVb+HLZFwFP3klD3Sg4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936198; c=relaxed/simple;
	bh=XGze0MX6pPcBSBg10ExvQZidlcuv2+y5+RAOY6fdhVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hs2n47kFf/rq9SNbXpFCHQYa/nYcDXpSXz6Sf3aq2SVquJV8QAoTjFLDZ6OYiNGZqnlpY70oBD0RVR8K8CxZIvK/NCllFfM0PHaN2qiB7Np7Z1e1/cS3ZiOTvIzWktzp9MYtjvINUCiZj8LpHRK6v0kbWkzKsCRDzRpxeeWzEQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bx+k0I0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0292BC4CEFB;
	Mon, 20 Oct 2025 04:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760936198;
	bh=XGze0MX6pPcBSBg10ExvQZidlcuv2+y5+RAOY6fdhVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bx+k0I0XUtKJO27R4DdFmQPbslCm5/pwQwgx8hY4tv5t5vccMmIQhW7VS2Vwzn1d2
	 60JRs6xZi+OTehxr8ORlKczqVvIg+LeHHIWn50ZZH1U1vOJ89NApUHO6y29sURPNa3
	 Yk+n9q3mqOpe52h37kAhvFiKOUszsUG2vmDGJY3DYxs6N9VM+V3Q0MpZVgKgDbcrvQ
	 j2K1Qh9U1jvgLk4usT0xblZSIEkKRjlUNy6l01dgTlQmcbBjyMS/sOTRpnStW/SagY
	 2/Emvy5veqzS5SX2yDqKVOKhypgh+xLCAgbqvIxAzWtGNlXGqcfyc0fAjou3lKgxQ1
	 pYD8zWkEaiR0g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vAhwn-0000000083Y-48lT;
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
	Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v3 13/14] iommu/sun50i: fix device leak on of_xlate()
Date: Mon, 20 Oct 2025 06:53:17 +0200
Message-ID: <20251020045318.30690-14-johan@kernel.org>
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


