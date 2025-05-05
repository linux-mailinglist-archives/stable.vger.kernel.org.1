Return-Path: <stable+bounces-140544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF17AAA9DD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55AA05A3872
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC47F361946;
	Mon,  5 May 2025 22:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9nJ/yvL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A84029C32F;
	Mon,  5 May 2025 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485110; cv=none; b=S1d4k1N4Z5lkhm6kVzYSv3ZM6v0FgyjoV2e8omI5qeAktReTeUx/z/WKgfcjZ93Mm6m5S3lCXgCYNVuOxOExosKJ02Kq+rOgNwZfQeQZX6ZwKEW/K/Po5zwAeXYl+tyrsGRHpZIrGbpJne8EdiCFzZOGrwTgDC+5HCOBKJxzpfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485110; c=relaxed/simple;
	bh=LolfELq7zw61kXjAJpYuRDxg3qaUFAexhigAbHnRMr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KyEjMtRgPgeQNniz3RxS1gfMWlUp5psSGZw4WHo3TKo0t7y0GtvFROQT7pjoXrs1rtfUELe1Blw756Q9nnKH0/6p4r+UZVOw9ZMrfXBrmFtY8e8yR/dgtitCTiBqTXdRYSsiCpHd5VXO4BWwUX67Pedbkhyfm1fFb+/kvu+w7LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9nJ/yvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EDCC4CEE4;
	Mon,  5 May 2025 22:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485109;
	bh=LolfELq7zw61kXjAJpYuRDxg3qaUFAexhigAbHnRMr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X9nJ/yvLKadu+z8NWHVgrYTaN3SMWbgAyFL0suAPIDvjnRDy0BPJ2nrarNJsVwiEV
	 vMFfb48vxw3n0nqBj3P5hlJuxO5MXMWjD8VLorRiGmO2sO1u5/QMC2QNeec4CWuSDZ
	 mDrkeGKRk11fCxcerXvSF7LqQE7pbO5MoBwyaNC+WS/Kiq0FsiITJUlJdd25/zazIl
	 q31AfmfAkSiY6cafCJxQVlUuUx7cDKIIn21x2CadwEog7PbGKe2m0ayjvdGm9wizbp
	 bJCbQGmoSZmlK9S9RJPPcCbtEY0IGQ4tAAf+z3n1c21Xf9+THM5kYeacoFHWIHEI7L
	 kQVaojfP+r73Q==
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
Subject: [PATCH AUTOSEL 6.12 166/486] iommu/amd/pgtbl_v2: Improve error handling
Date: Mon,  5 May 2025 18:34:02 -0400
Message-Id: <20250505223922.2682012-166-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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


