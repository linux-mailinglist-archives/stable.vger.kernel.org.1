Return-Path: <stable+bounces-139606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4C0AA8D44
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 09:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C461B3B4DA7
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 07:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C271DB365;
	Mon,  5 May 2025 07:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NmFl1eex"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F921DDA00
	for <stable@vger.kernel.org>; Mon,  5 May 2025 07:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746431036; cv=none; b=R9snOh3IjScHsw/oI2LkxjbkD2i/MMY7QHq2tBLDvseAg/l3daGzRSR7LW7gCKwGL6e5Fm9lC/DiJyxm3Mm6MrPiwbilkT0klFEOEIGEcNT/PTyThVI88Ri1bzWi6NJdzb/s+Hfc777/kf3uF4BiDdrubK0+w/K9Bz0LpawX/hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746431036; c=relaxed/simple;
	bh=X/csFW6y2+Uz0+p/mW4qUMFdJunQNPImqbS/UdRDQuc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JPhFqCjx40WUa4BTO5EAmdssoipZXd0Nr92brHIM0hGd3LuNZTf9SPzCzxrnMpVojLJje2cEiivIdmPt40Jg7nCavGhvBvonTxyPgng6ufcsLpyDdc0CeqRUKHxI/K1G95R6ORbbAlzO7lj512+c0idWFi/MVKfLorwGcos/9bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NmFl1eex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D2DC4CEE4;
	Mon,  5 May 2025 07:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746431036;
	bh=X/csFW6y2+Uz0+p/mW4qUMFdJunQNPImqbS/UdRDQuc=;
	h=Subject:To:Cc:From:Date:From;
	b=NmFl1eexCgeqPdCcEOv+Px+PbdL/GJRlEOwfJxwKIaHgDkIyn7jMXTp6tHsaTDLkM
	 1ruh+srC7B3fvFG/0ppN4WKRXmwGkJ3BoXShyx6got4lLQJslzu5GF3luSiUggzRV9
	 gXwJAFTKuqeA6kjeHfJ0PGPL5uJlOidGHqH6hYtc=
Subject: FAILED: patch "[PATCH] iommu/arm-smmu-v3: Fix pgsize_bit for sva domains" failed to apply to 5.15-stable tree
To: balbirs@nvidia.com,jean-philippe@linaro.org,jgg@nvidia.com,jgg@ziepe.ca,joro@8bytes.org,robin.murphy@arm.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 May 2025 09:43:45 +0200
Message-ID: <2025050545-next-pesticide-ba2f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 12f78021973ae422564b234136c702a305932d73
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050545-next-pesticide-ba2f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 12f78021973ae422564b234136c702a305932d73 Mon Sep 17 00:00:00 2001
From: Balbir Singh <balbirs@nvidia.com>
Date: Sat, 12 Apr 2025 10:23:54 +1000
Subject: [PATCH] iommu/arm-smmu-v3: Fix pgsize_bit for sva domains

UBSan caught a bug with IOMMU SVA domains, where the reported exponent
value in __arm_smmu_tlb_inv_range() was >= 64.
__arm_smmu_tlb_inv_range() uses the domain's pgsize_bitmap to compute
the number of pages to invalidate and the invalidation range. Currently
arm_smmu_sva_domain_alloc() does not setup the iommu domain's
pgsize_bitmap. This leads to __ffs() on the value returning 64 and that
leads to undefined behaviour w.r.t. shift operations

Fix this by initializing the iommu_domain's pgsize_bitmap to PAGE_SIZE.
Effectively the code needs to use the smallest page size for
invalidation

Cc: stable@vger.kernel.org
Fixes: eb6c97647be2 ("iommu/arm-smmu-v3: Avoid constructing invalid range commands")
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Balbir Singh <balbirs@nvidia.com>

Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20250412002354.3071449-1-balbirs@nvidia.com
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 9ba596430e7c..980cc6b33c43 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -411,6 +411,12 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 		return ERR_CAST(smmu_domain);
 	smmu_domain->domain.type = IOMMU_DOMAIN_SVA;
 	smmu_domain->domain.ops = &arm_smmu_sva_domain_ops;
+
+	/*
+	 * Choose page_size as the leaf page size for invalidation when
+	 * ARM_SMMU_FEAT_RANGE_INV is present
+	 */
+	smmu_domain->domain.pgsize_bitmap = PAGE_SIZE;
 	smmu_domain->smmu = smmu;
 
 	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,


