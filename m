Return-Path: <stable+bounces-98347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F879E4059
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC0228112F
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544DA2144DB;
	Wed,  4 Dec 2024 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOP6CR9x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9112144D4;
	Wed,  4 Dec 2024 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331504; cv=none; b=CdwMJ2k5kSJyR2OHnU2zMVCDjbMb+v9sdL0j1kKPpw13C+wJvlE+cnDxYGOvulCwsjwHR8Ygp4zjShB7829YK8qYc515A1ozR4tYD0ibgoYVRdrN7Yfae2oc8/3EfFmLS2SYD/9FuAR2X2paUSCy8cwmhSWtB+LZnNl2jjZe8IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331504; c=relaxed/simple;
	bh=+X1/Nu5CoD/sFJfWzapKZW1fSBzONFEp4WsLJt5tBFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpJg6RfdhfBYb501HNDCKgYo+OicZ7CB1yp+I1lGmNz+DWeHepknNida4Q7ZJ6t79q5A5XdBHZtg3LyMvVhCeDtyoGK9j2MCj/+ORdJygXii4RNj579/3RCqvWuHD+Nku2SjN6VgtquqWCDBIoMI5RZ/cOUb9PqQerrKxLVZq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOP6CR9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FBBC4CED1;
	Wed,  4 Dec 2024 16:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331503;
	bh=+X1/Nu5CoD/sFJfWzapKZW1fSBzONFEp4WsLJt5tBFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aOP6CR9x1MSXJrkzdipFL7zDncCk2Thxf059pgA/sW+3ySc/PeajnF2NklWOgKgPR
	 qDUYzE96KmEgvZV+zb7fcYB2Us8Q2XZppAo+uZL0OWWEe4wgw8v6+Em4PQzWUIhefd
	 Ad9sARNwO4mv8wuDT2H8l7LpYo0VXodwiCX3rSyAE2Uv1KQiVRweTpkvbjQN8axGJH
	 YhW86EqE2taRGhinPtKuZzwrjuBNi4Z8dpw5ec2hl09ollhAk9AfhtzVcY1JR3+SKM
	 Ka5z7ZddkayW54a35jTNRpiZ5JJR2EBm0wRJtYSKuTHhT4MnnkLnThWGEjE0/VfyvG
	 /aGN3V4EKMVpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 14/36] iommu/amd: Fix corruption when mapping large pages from 0
Date: Wed,  4 Dec 2024 10:45:30 -0500
Message-ID: <20241204154626.2211476-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204154626.2211476-1-sashal@kernel.org>
References: <20241204154626.2211476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit e3a682eaf2af51a83f5313145ef592ce50fa787f ]

If a page is mapped starting at 0 that is equal to or larger than can fit
in the current mode (number of table levels) it results in corrupting the
mapping as the following logic assumes the mode is correct for the page
size being requested.

There are two issues here, the check if the address fits within the table
uses the start address, it should use the last address to ensure that last
byte of the mapping fits within the current table mode.

The second is if the mapping is exactly the size of the full page table it
has to add another level to instead hold a single IOPTE for the large
size.

Since both corner cases require a 0 IOVA to be hit and doesn't start until
a page size of 2^48 it is unlikely to ever hit in a real system.

Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/0-v1-27ab08d646a1+29-amd_0map_jgg@nvidia.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd/io_pgtable.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 804b788f3f167..f3399087859fd 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -118,6 +118,7 @@ static void free_sub_pt(u64 *root, int mode, struct list_head *freelist)
  */
 static bool increase_address_space(struct amd_io_pgtable *pgtable,
 				   unsigned long address,
+				   unsigned int page_size_level,
 				   gfp_t gfp)
 {
 	struct io_pgtable_cfg *cfg = &pgtable->pgtbl.cfg;
@@ -133,7 +134,8 @@ static bool increase_address_space(struct amd_io_pgtable *pgtable,
 
 	spin_lock_irqsave(&domain->lock, flags);
 
-	if (address <= PM_LEVEL_SIZE(pgtable->mode))
+	if (address <= PM_LEVEL_SIZE(pgtable->mode) &&
+	    pgtable->mode - 1 >= page_size_level)
 		goto out;
 
 	ret = false;
@@ -163,18 +165,21 @@ static u64 *alloc_pte(struct amd_io_pgtable *pgtable,
 		      gfp_t gfp,
 		      bool *updated)
 {
+	unsigned long last_addr = address + (page_size - 1);
 	struct io_pgtable_cfg *cfg = &pgtable->pgtbl.cfg;
 	int level, end_lvl;
 	u64 *pte, *page;
 
 	BUG_ON(!is_power_of_2(page_size));
 
-	while (address > PM_LEVEL_SIZE(pgtable->mode)) {
+	while (last_addr > PM_LEVEL_SIZE(pgtable->mode) ||
+	       pgtable->mode - 1 < PAGE_SIZE_LEVEL(page_size)) {
 		/*
 		 * Return an error if there is no memory to update the
 		 * page-table.
 		 */
-		if (!increase_address_space(pgtable, address, gfp))
+		if (!increase_address_space(pgtable, last_addr,
+					    PAGE_SIZE_LEVEL(page_size), gfp))
 			return NULL;
 	}
 
-- 
2.43.0


