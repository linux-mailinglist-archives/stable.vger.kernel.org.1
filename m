Return-Path: <stable+bounces-84367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE98099CFD9
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47991F231F8
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4F749659;
	Mon, 14 Oct 2024 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HP5vQXk3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAFF1B85D6;
	Mon, 14 Oct 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917764; cv=none; b=fgQmmI3pLqP5ZGE45XOPCM6Y7yYGvJuVb7oDTXDLBqiqIPP3htg0ty6BiSc1AxNQQRMHulssZAvyME3kGf31uO/BiZgzs65JhxC6qZNA2ITpMZ4MMiYvgcVesVdUrzySMN0XZonnOrhmMS8vu5MfBbJFiMgZrE8b47MEWLTAMUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917764; c=relaxed/simple;
	bh=sSWypJN4yIssAEdszbTxBwhVMVY33Ui0GZc7fpLYtcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/BW+X+rIgGh5zYNxj787ovMyF858h0Y+0HVl9J6W4fUPUkQF2EfJLIT+Nt6BIuSwxprpCd5mY3LfnJQm8G+8zo6i4ApnIwZarPXG5BSc187KpPH3vPfN77bLhTN7F8RV6+xrQTJ46jZUuaPxSPEOoQeDgmLy2o0ZY4Z328ge70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HP5vQXk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEEEC4CEC3;
	Mon, 14 Oct 2024 14:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917764;
	bh=sSWypJN4yIssAEdszbTxBwhVMVY33Ui0GZc7fpLYtcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HP5vQXk35R83mRcT43RnUcv18TaEmcPO6kXB9GcbtXblEH5+et1tBJ5pdBfaymdld
	 Zq/kgho4qN8F+m41wgTACm2vhWUnkHw0ixJLINLXI4H5tjrHRtJnvewbMjXsck6aKj
	 wnJKTTXojThQtteTMuXglD/KiSxhrYygSNEBAwco=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 096/798] iommu/amd: Do not set the D bit on AMD v2 table entries
Date: Mon, 14 Oct 2024 16:10:50 +0200
Message-ID: <20241014141221.704826722@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 2910a7fa1be090fc7637cef0b2e70bcd15bf5469 ]

The manual says that bit 6 is IGN for all Page-Table Base Address
pointers, don't set it.

Fixes: aaac38f61487 ("iommu/amd: Initial support for AMD IOMMU v2 page table")
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/14-v2-831cdc4d00f3+1a315-amd_iopgtbl_jgg@nvidia.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd/io_pgtable_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index 8638ddf6fb3b2..232d17bd941fd 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -56,7 +56,7 @@ static inline u64 set_pgtable_attr(u64 *page)
 	u64 prot;
 
 	prot = IOMMU_PAGE_PRESENT | IOMMU_PAGE_RW | IOMMU_PAGE_USER;
-	prot |= IOMMU_PAGE_ACCESS | IOMMU_PAGE_DIRTY;
+	prot |= IOMMU_PAGE_ACCESS;
 
 	return (iommu_virt_to_phys(page) | prot);
 }
-- 
2.43.0




