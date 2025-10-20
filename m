Return-Path: <stable+bounces-187924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9655BEF546
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 06:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABE93E2EF3
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 04:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713692D061F;
	Mon, 20 Oct 2025 04:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+YgynLQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295512C326C;
	Mon, 20 Oct 2025 04:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936198; cv=none; b=QRLMSqwA2bCYqpFtGv7LjZJPWnH61xBNw5sVcCQouKGvqcGsl6mOvf+ZxPJq95T1BXq3VkmzOyJYX54E1mMX+FAUJZ4VSXdHd8MnZkZl5uVtPN7UoQdUoaIsxSo+yCZjbTP1QS+6Hzd1N8SEgfuOetnWbKSXpOpYI6z8E+974bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936198; c=relaxed/simple;
	bh=MYEOUbyF4ZGD5XYEwadELPgQLrWxXxJkfb5idHjpHFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gy4ogA0USotvwu5+UhlnxroX3RSfJIrOv11q6z+0vHjJCofY2DmAM7PBnjZ3Of6fYOrTcqqW1F594W5DhxXW5nmxNAeNuFHj95FgOA/Y8WZFhEyH0CBf0PsBfPDitVOMvDXc5IiPVcmmyo3WSPgS7SvKd9IFwV10ntZFocBPfaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+YgynLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FBAC4AF15;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760936198;
	bh=MYEOUbyF4ZGD5XYEwadELPgQLrWxXxJkfb5idHjpHFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j+YgynLQSCK3/n+whncI0z58x+0lE8g3mkuDkUeI8TeNfp6yvZNRgtc+a9yrrK7Yy
	 Bz0CEZ4EsgTC6g0p7tJ3J8urs/E+8TfTkhGLvv0VU37H9BFLK0sAP3NsVIYXwNvBI5
	 qe9+bsH+fOjdjj6YkCIygOg+h1VY5hCUMp6cedqJLwg1Qh1TtuVgw2Zsyt3p0mkee5
	 31W417IVWmrYdS/HgHyB7xu/mv76LzMcElFppmXoXwRZ6YdxKfO4Rv4FkfIK2ZiA+M
	 RIR3USN4lRsHlJiee7fklKTz9G3bqtJg1wV2LDT8Qi4KmMR/kiL8n8muqTynmSoAMt
	 nAL0LAiHKiZiA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vAhwn-0000000083T-3ILe;
	Mon, 20 Oct 2025 06:56:41 +0200
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
Subject: [PATCH v3 11/14] iommu/omap: fix device leaks on probe_device()
Date: Mon, 20 Oct 2025 06:53:15 +0200
Message-ID: <20251020045318.30690-12-johan@kernel.org>
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
index 5c6f5943f44b..c0315c86cd18 100644
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


