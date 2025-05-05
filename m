Return-Path: <stable+bounces-139955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B96A9AAA2E1
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0AB41883962
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EB9239E81;
	Mon,  5 May 2025 22:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0Tmdtgh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7BC239E75;
	Mon,  5 May 2025 22:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483768; cv=none; b=kFTm8lbv2Giw/y4gnK1FpMmRJlgANEkFM8oZEdSIVrAm0PvumsmrAMOHtBOfAAXHnhQaOUImn+rp+0BLzWE1+VYCNs++iatDxgdvkruXsUUmGibhrmaA3c9ZiVWCmm2di8Ra+UCHc4hv0Xf9KiyH4Dh7E4AoSa/MoJhiMEYlpBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483768; c=relaxed/simple;
	bh=LolfELq7zw61kXjAJpYuRDxg3qaUFAexhigAbHnRMr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bfir7r77x48nCaHWOYSW46+YjLRdknx53qTRiG2RIK2FUCYe8Q4ZUYIwkNAXQ2OKR9S6X4cng5BhW4/NDo2RZmIk+rU/12rwkvByE9f2i1nwkCq4Og/Jo11Etb09956OwKePAwsNDRMd4yvE2GCv/mt468VTc2XsPLEu4jWENmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0Tmdtgh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE4AC4CEEF;
	Mon,  5 May 2025 22:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483767;
	bh=LolfELq7zw61kXjAJpYuRDxg3qaUFAexhigAbHnRMr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z0TmdtghIIKN8nONDzj5wsD7dFioIl4rNovpa5DNvc4CXmGCx65l55D1FEB5EXRu4
	 O6frZ70/ZNRPX5DRPYDXwuwHpWwF1w8AmaYN70HymSJWKwaUc9hotE+rUYRjdi76fE
	 JxroTQfLp0BlK2OOuXCt/jVsWGJr60gH+E80BaffOIwhyPhBn9m4PBGmiJmOgsAyWK
	 o80fdvRybe0yDKcXtLNsYCeL/HMOS/FALjC/tcMrx5awmQ3F9MtglDHnVHxPFMJtBn
	 tBw54TWr6m/PnCg/tupAPgoxK/Ykch+V5vbFUNzsfPOdXgrf6AcpBJG4rfimP0S0sy
	 BHD/1Wh6PD/ww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 208/642] iommu/amd/pgtbl_v2: Improve error handling
Date: Mon,  5 May 2025 18:07:04 -0400
Message-Id: <20250505221419.2672473-208-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Vasant Hegde <vasant.hegde@amd.com>

[ Upstream commit 36a1cfd497435ba5e37572fe9463bb62a7b1b984 ]

Return -ENOMEM if v2_alloc_pte() fails to allocate memory.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20250227162320.5805-4-vasant.hegde@amd.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd/io_pgtable_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index c616de2c5926e..a56a273963059 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -254,7 +254,7 @@ static int iommu_v2_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 		pte = v2_alloc_pte(cfg->amd.nid, pgtable->pgd,
 				   iova, map_size, gfp, &updated);
 		if (!pte) {
-			ret = -EINVAL;
+			ret = -ENOMEM;
 			goto out;
 		}
 
-- 
2.39.5


