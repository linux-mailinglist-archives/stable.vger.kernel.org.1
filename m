Return-Path: <stable+bounces-64200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2794A941CCC
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5060F1C23A0E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5232218E02D;
	Tue, 30 Jul 2024 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jKi2DVqU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E50E189522;
	Tue, 30 Jul 2024 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359326; cv=none; b=FQA8knGpGBosVWyOnF/Cze/qWbRbJJ9jxdeH42YxwbeC/IQGqkVvZRNNeCLLtHqb1OgFqV9BXx/lEa2mzKwe+Wir0lPkaYrrEi2f1WyGOKCB/OJDm2yvTQxZwzEvIlM/6eht9ug3vNC9vWy8Krua6cfZ5zWnf5yldzu7saMr8SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359326; c=relaxed/simple;
	bh=RyVZbSd7CF820TGyFFbVoc+e0IPNncA4ExtnBQwvfYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CX/GdwtA4X6GaNrGoVrXY/BhkMTtp1PVnh+jKNowWC85Demg+thPcjBD0H5OlRqjemPLo7dQ0VwzSXHh4w77qQIFrTQZQmvL5Cjant+nFh0fq1CLqJ4Z2DQl+GrJeve/1dFW5oPN5q1Gej7EgxHhrnOqZtgymaT6zqsYsmKoctU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jKi2DVqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7E3C32782;
	Tue, 30 Jul 2024 17:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722359325;
	bh=RyVZbSd7CF820TGyFFbVoc+e0IPNncA4ExtnBQwvfYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKi2DVqUIxcECwv/EnO1jDJ4Pp3ioSTZva9bM69X3nsJZd7hiv3tyZcaUzKls4/6f
	 STz/uftWfWfVrzubjQFyT25O/rvzzPU/43Bk0tgDokv0ujvZhUK0/mQBOfMqDJRYW7
	 wOARB8nnhyt8EksHE1pNiXelzEVINCJgSWr8v4/8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jon Pan-Doh <pandoh@google.com>,
	Sudheer Dantuluri <dantuluris@google.com>,
	Gary Zibrat <gzibrat@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 468/809] iommu/vt-d: Fix identity map bounds in si_domain_init()
Date: Tue, 30 Jul 2024 17:45:44 +0200
Message-ID: <20240730151743.220085645@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jon Pan-Doh <pandoh@google.com>

[ Upstream commit 31000732d56b43765d51e08cccb68818fbc0032c ]

Intel IOMMU operates on inclusive bounds (both generally aas well as
iommu_domain_identity_map()). Meanwhile, for_each_mem_pfn_range() uses
exclusive bounds for end_pfn. This creates an off-by-one error when
switching between the two.

Fixes: c5395d5c4a82 ("intel-iommu: Clean up iommu_domain_identity_map()")
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Tested-by: Sudheer Dantuluri <dantuluris@google.com>
Suggested-by: Gary Zibrat <gzibrat@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240709234913.2749386-1-pandoh@google.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index fd11a080380c8..f55ec1fd7942a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2071,7 +2071,7 @@ static int __init si_domain_init(int hw)
 		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
 			ret = iommu_domain_identity_map(si_domain,
 					mm_to_dma_pfn_start(start_pfn),
-					mm_to_dma_pfn_end(end_pfn));
+					mm_to_dma_pfn_end(end_pfn-1));
 			if (ret)
 				return ret;
 		}
-- 
2.43.0




