Return-Path: <stable+bounces-86804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 667FD9A3A7A
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 11:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAE8283CCA
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 09:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D285201027;
	Fri, 18 Oct 2024 09:51:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8595C200CB7;
	Fri, 18 Oct 2024 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245100; cv=none; b=WywxemffNIgCGQQAq2WDnLYmTRysVHnybjxLapzxtcqhBYKICD9d5x5+LRZ+ONoKhbHF88tJCflX/goEVTxJ3T2NY6VLMALNqt/D0FhiCX6614wkqgbuXFoRQR04O8yEvYt+tzqrROQkB9XeJ8XZ21uKeu0hUQipA0I3jasy9tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245100; c=relaxed/simple;
	bh=PxzUmdXNHgEZJkbEy8BdAR2H6oI/oOlnob544rXFLNA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hf/6m53D06uxCCpaE6IzUxbBDA1dAS7Tg81C/hLkIxcDQwDPNVCD+EJ2/5vJLsIw3tfnEAThl6Pr4H5TRkEAmfNAhJCoU/Vbe0XSHF7Uwmsalnjh4QCgohE+khIWScO4J6MdpagCjFFFYKWewmNz7j68icpvqGtsFFZrf9HtBKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, "open list:AMD IOMMU (AMD-VI)"
	<iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Robin Murphy <robin.murphy@arm.com>, Joerg
 Roedel <jroedel@suse.de>
Subject: [PATCH 5.10 1/1] iommu/amd: Prepare for multiple DMA domain types
Date: Fri, 18 Oct 2024 12:51:22 +0300
Message-ID: <20241018095122.437330-2-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241018095122.437330-1-d.dulov@aladdin.ru>
References: <20241018095122.437330-1-d.dulov@aladdin.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-02.aladdin.ru (192.168.1.102) To
 EXCH-2016-02.aladdin.ru (192.168.1.102)

From: Robin Murphy <robin.murphy@arm.com>

commit 6d596039392bac2a0160fb71300d314943411e2a  upstream.

The DMA ops reset/setup can simply be unconditional, since
iommu-dma already knows only to touch DMA domains.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/6450b4f39a5a086d505297b4a53ff1e4a7a0fe7c.1628682049.git.robin.murphy@arm.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/iommu/amd/iommu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0a061a196b53..16a1c2a44bce 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2257,12 +2257,9 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 
 static void amd_iommu_probe_finalize(struct device *dev)
 {
-	struct iommu_domain *domain;
-
 	/* Domains are initialized for this device - have a look what we ended up with */
-	domain = iommu_get_domain_for_dev(dev);
-	if (domain->type == IOMMU_DOMAIN_DMA)
-		iommu_setup_dma_ops(dev, IOVA_START_PFN << PAGE_SHIFT, 0);
+	set_dma_ops(dev, NULL);
+	iommu_setup_dma_ops(dev, 0, U64_MAX);
 }
 
 static void amd_iommu_release_device(struct device *dev)
-- 
2.25.1


