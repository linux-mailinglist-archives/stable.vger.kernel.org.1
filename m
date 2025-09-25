Return-Path: <stable+bounces-181717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C8CB9F3F2
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 14:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A88C7AB1A1
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 12:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C253054C1;
	Thu, 25 Sep 2025 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvULL4O8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E99304BBD;
	Thu, 25 Sep 2025 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803351; cv=none; b=n0UgEfjcSTonqhMi2qX91T6Oy91i/kqBpYQeFRcI+3QC24E3J9hvP9NsQkMZKcZ7O2UXcXJ+b0BkNc1VR4E+iLWFu+InGFVOaGKrMSY3xgByQCpJzn9VjGrQ+ePMEF32nFaDX4C0Mo+ldATCxQhvj8OBP6iMxeifQYcBJanoiKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803351; c=relaxed/simple;
	bh=QWsxSeipS9iZnS1CRFwV0QyL9gk/vm3bYIKcBcyoh1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ll9aH7qxgEwraQJasSepTHolWD+C7sUFrr7ld39xL4CaasaGcTKtx+sF/PwlVYx21YHh8O2bn57JJuU89ATrnaLU1EqsqMOQbHwTPN9PFdr709WZNuTeimoY1SMD6VtDAyDvXn1xuw4mLWZqMZYW91XD7SOt3eWwGmJTojktJWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvULL4O8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CC7C113D0;
	Thu, 25 Sep 2025 12:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758803351;
	bh=QWsxSeipS9iZnS1CRFwV0QyL9gk/vm3bYIKcBcyoh1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CvULL4O86w/SvmNcK/TIpxkTRhiM8XbGUjUr02JFiyvHyh5FRxXccDgbu45htCx8E
	 nUghPnqFY8favHwl/vfalePttLaNRyIKAoqYeOpl3iK4fLZnCTnmoujCzPCcq8J4HI
	 ABXsFfvFv0T++XjLt3JNf9Q2TLRyp1NZ789UpQWn8osoIirDwtdCr+v+yL3m/6aiqB
	 B0Z/0F4ovKMQAH0NUU6sAKkXXiL+Yt4vU25Ke12Sr+HBwHHKzqj8ZxzvzQTxyCQ9Gx
	 myiqC8VrAmMLRd/sgzHhIg8OcgB+S9m/mmi9lJDRyIeg70f7loKPyqZvnt0zYsc2vo
	 9yvVcldGewJ8g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1l5r-000000002s0-1RE0;
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
	Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 13/14] iommu/sun50i: fix device leak on of_xlate()
Date: Thu, 25 Sep 2025 14:27:55 +0200
Message-ID: <20250925122756.10910-14-johan@kernel.org>
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
looking up its driver data during of_xlate().

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Cc: stable@vger.kernel.org	# 5.8
Cc: Maxime Ripard <mripard@kernel.org>
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


