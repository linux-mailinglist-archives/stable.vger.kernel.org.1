Return-Path: <stable+bounces-183519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F39BC0E5B
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 11:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373593A4782
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 09:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378072D949E;
	Tue,  7 Oct 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5TWRQM/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DEF2D8771;
	Tue,  7 Oct 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830295; cv=none; b=cmy/j5aOpXjAA6BFWo+0WJNA3eRZysrlJhV5brZZJNuVhA3Y9D+FfPEWipaQb+SHAuAXx7A28oZMDsLSP1pT09hRJDXw8ZiGsshEU8z2hyB1RqExw/Lo1sV4zP8mu9TssTDt7S8nYFuZUlQK2Z5tOX3kxymyV4OUdrurp+u2hkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830295; c=relaxed/simple;
	bh=9esiiaNsIjLJT9q+6kigJzz3FXDUJEcBF8kGxPcFTEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toRehJk429IA3SzJR9BdUtYhof5zjs+7ZXRCnUH1tknhdRoVvAwIDFf93ElzmH/GOPzsf72j+4HO3vmgqE6jmyz9Kvv0y3/c5xm1fP3K9URtM9Ge9PqqlwaOEiNrN+ktQ0LEg4zEb7sek8DfLyKZv7BcCllOYa9tsBDxmQ1bAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5TWRQM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88176C4AF0B;
	Tue,  7 Oct 2025 09:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759830295;
	bh=9esiiaNsIjLJT9q+6kigJzz3FXDUJEcBF8kGxPcFTEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b5TWRQM/fHVWyhLveNUH9G4xZYVgaU+KEcUXv9cLFEtknQuEiYqcCPDaL2tRVLp6P
	 eEC/TQvK+e1fGy9eUx/21vIZG130lOcDHG5wIUQPg5zs57fCM0lBv6gcY6LdKcLAxP
	 6lSkGSi091k8415SKN0WK/clAhuXw/L9PIGs+bMKnjmHUGHSB6geUTpeyJrolZPD+3
	 RqjCsoYhgmMqhFlrpoY34dbrCPKltuV9YIkdufB4pcQvv5KnqbXQ/wTysPZ5+z4xMC
	 xCg4/FTg2byz7vadt5x8jU2vkU+QTHW/BGwnz+IVYFdSPOiwxGg+Zp7WpQ15uONK9W
	 IM8UUyIHjtP8Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v64FZ-00000000363-3BhL;
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
	Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 11/14] iommu/omap: fix device leaks on probe_device()
Date: Tue,  7 Oct 2025 11:43:24 +0200
Message-ID: <20251007094327.11734-12-johan@kernel.org>
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

Make sure to drop the references taken to the iommu platform devices
when looking up their driver data during probe_device().

Note that the arch data device pointer added by commit 604629bcb505
("iommu/omap: add support for late attachment of iommu devices") has
never been used. Remove it to underline that the references are not
needed.

Fixes: 9d5018deec86 ("iommu/omap: Add support to program multiple iommus")
Fixes: 7d6827748d54 ("iommu/omap: Fix iommu archdata name for DT-based devices")
Cc: stable@vger.kernel.org	# 3.18
Cc: Suman Anna <s-anna@ti.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iommu/omap-iommu.c | 2 +-
 drivers/iommu/omap-iommu.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 6fb93927bdb9..b87ce129fb1f 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1675,6 +1675,7 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
 		}
 
 		oiommu = platform_get_drvdata(pdev);
+		put_device(&pdev->dev);
 		if (!oiommu) {
 			of_node_put(np);
 			kfree(arch_data);
@@ -1682,7 +1683,6 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
 		}
 
 		tmp->iommu_dev = oiommu;
-		tmp->dev = &pdev->dev;
 
 		of_node_put(np);
 	}
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 27697109ec79..50b39be61abc 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -88,7 +88,6 @@ struct omap_iommu {
 /**
  * struct omap_iommu_arch_data - omap iommu private data
  * @iommu_dev: handle of the OMAP iommu device
- * @dev: handle of the iommu device
  *
  * This is an omap iommu private data object, which binds an iommu user
  * to its iommu device. This object should be placed at the iommu user's
@@ -97,7 +96,6 @@ struct omap_iommu {
  */
 struct omap_iommu_arch_data {
 	struct omap_iommu *iommu_dev;
-	struct device *dev;
 };
 
 struct cr_regs {
-- 
2.49.1


