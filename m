Return-Path: <stable+bounces-140696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B25AAAEBB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED444188D43E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E86A397A69;
	Mon,  5 May 2025 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8tXl4nA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C12376893;
	Mon,  5 May 2025 22:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485990; cv=none; b=WLAwpfWvag3DXyG5gz51RtPSoHUdVjfO5d8PpLfIZELcXiaDRQn7ksaVdhSL5KxRK8CJqTuN3p4gzm4YxOCQVd3k7uV7Mp9NFhrrsgDtZboo/ibEbhdkmaioM7CsuQiEfKCfaTRReg5WKv3uN4kA67W9tjjv5jRojYEPhLJPvOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485990; c=relaxed/simple;
	bh=9onfsYXpFGOuv6V3xZe7zRvcKy8UCVXwkVjWMBo2Olo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LnNx0tHqD1yXjrchOpPCn45+ox7gnCkeumdE3Flq1FOoWw8nabZ6goyOA/eWKZYTM8JfniyJS6sjlj3r7OijE78J34/mD1FMMZ/8NDJcdZdBTRPDZ4L4rlONtqmfsU0XqbRN2M/hePr4QGDYDeUUpu0sycx5l98q+cmsglq+K64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8tXl4nA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A407C4CEE4;
	Mon,  5 May 2025 22:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485989;
	bh=9onfsYXpFGOuv6V3xZe7zRvcKy8UCVXwkVjWMBo2Olo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o8tXl4nAvwkGYr6Ozte1FoiXrHxSiUK0AdVq4vMUYHKDVts/ggJ0MqpGtzyxER5y3
	 630ZNSeS1BVe1NkCMTyvOHjhSy/d8vbFL8CE7+rSczxC0bfumsBa/PoQ2B8C2augd7
	 smw6M60WtZEBFtCgZv24eCJtuqsE9hlXmJii23BSVH7UnIhLQHbCxDomaJIKs14reO
	 8dVtlXP8JnWhCNXVkfpQYMdXSVUJzPHymlYuYo6f+j+rwX/slfg3vuMNdz+RunTT5a
	 d1iuwQxfvX7MwHFKVjgcMdFEnse3XhzakdNels3so0NPA4XjMeltQLeCZO0YvkQJZg
	 3qHt3Bt58PwJQ==
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
Subject: [PATCH AUTOSEL 6.6 099/294] iommu/amd/pgtbl_v2: Improve error handling
Date: Mon,  5 May 2025 18:53:19 -0400
Message-Id: <20250505225634.2688578-99-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index cbf0c46015125..6c0777a3c57b7 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -259,7 +259,7 @@ static int iommu_v2_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 		pte = v2_alloc_pte(pdom->nid, pdom->iop.pgd,
 				   iova, map_size, gfp, &updated);
 		if (!pte) {
-			ret = -EINVAL;
+			ret = -ENOMEM;
 			goto out;
 		}
 
-- 
2.39.5


