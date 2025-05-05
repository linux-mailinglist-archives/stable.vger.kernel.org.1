Return-Path: <stable+bounces-140840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A76AAAF4B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1AB16CDCF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD7E37EA66;
	Mon,  5 May 2025 23:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2/uRPpo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F33037DBF8;
	Mon,  5 May 2025 23:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486532; cv=none; b=FbQXopCocEvLhLVc42svtaIjz1a+28rBJP9gdpPKYNF4eTcsLkbKwFxYfFtXYsJEona58JzXg4nlsdAYSW0bVPHb/wcujv5NaU6wAIyGtohMLlr6JF1qM8JrC74MbZAgIXZXtRraCqkB+7Ndnon7VMYL4+MHXqLNiBS+YE5Z2Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486532; c=relaxed/simple;
	bh=iXYj0sU75zh65tWYGio97xZxFDMz3T0bt+GuGJYQU+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W3xZB2zHU7VTgal4Fevg6S5h2NtX6taS8NGH943EXvD4AuaMFKpsTLP0G0o2L1cuL+zDRA3G5Bbe/gFU5h5iym7KyETdidNQbS37AnYdHsdeZyfkLv870xXWJyiDs03UtICO9+KsXtvo9FjKD0IJdtQdoWxRV0Y5pigViaHLtmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2/uRPpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1524CC4CEE4;
	Mon,  5 May 2025 23:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486531;
	bh=iXYj0sU75zh65tWYGio97xZxFDMz3T0bt+GuGJYQU+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W2/uRPpo0zcWSPBkGvkCen/jkeTMoWGvE2B+TOTyEvc5lGe5N0wJ0p2IiZDsdyG2C
	 FhR5cDd5U75u0CjOHC9e07l56IMS5fBCd4jY4RYkBoIpnYWfVAkwyl6QCJoSU2A2X5
	 v5EqwH8dqvaYc6r3JRkn8tX28zPwqlnG0yNSe57fOT3bnYX5GuJLnnYE/wlxoFjEom
	 93FPgGTEVgVi+p5KImPQqNArqICeuRg8nmZ5PZkENXaRxUNnfWazplQ1pPf+C0iM0i
	 g2lqryUe3Qxz31kcPXz9g2OburO0A7ceQxBTl8zJFLg+/gYfTjqnds0/numY4djgnd
	 7gedRiLHn+3DA==
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
Subject: [PATCH AUTOSEL 6.1 077/212] iommu/amd/pgtbl_v2: Improve error handling
Date: Mon,  5 May 2025 19:04:09 -0400
Message-Id: <20250505230624.2692522-77-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 232d17bd941fd..c86cbbc21e882 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -264,7 +264,7 @@ static int iommu_v2_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 		map_size = get_alloc_page_size(pgsize);
 		pte = v2_alloc_pte(pdom->iop.pgd, iova, map_size, &updated);
 		if (!pte) {
-			ret = -EINVAL;
+			ret = -ENOMEM;
 			goto out;
 		}
 
-- 
2.39.5


