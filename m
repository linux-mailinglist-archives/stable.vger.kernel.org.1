Return-Path: <stable+bounces-19083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F5884CEEC
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 17:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A777228D63B
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 16:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14017823BF;
	Wed,  7 Feb 2024 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="POOIkaty"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D8A823B5
	for <stable@vger.kernel.org>; Wed,  7 Feb 2024 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323581; cv=none; b=OcH0AvJXn7Cmzndg6+kFZxzJu0uRfWJIMzwHSUUn38yOWz6sYticx5XixF0HbFEZJddf/Co4M5uVpy+H+8uAT01QLDCR98bgXfS362VpN6uQD6vBUxZcJihCD8HpRay4DvJaNq7PEE3kuNc+B25jY/ifJI6boqMKEvia//ELFzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323581; c=relaxed/simple;
	bh=+E2LSfdN6B+ayhxXVmVMMPlSDxrOMO9Zro28tbr4pQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X7tA4+QxzStI5o9Wre+OZj2S1ds27YGn+dExtC7yYvDRwlpabX5qNvXISKrvpgQbQX4MS4mtdrhheROZWR4Hezpq/+HYI5MRo/2syofbmeoWICPHegQfnbU9TZ9KrI1nSIsPBnx47tLANM+ZrmHdQLU5PBk6FmK4120wo9qWxI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=POOIkaty; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707323580; x=1738859580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+E2LSfdN6B+ayhxXVmVMMPlSDxrOMO9Zro28tbr4pQg=;
  b=POOIkatyT8tJcXtClVUiap4hpIWs+lPkKDEtPP2pV5q5X0NYkAK0SzMf
   g5nJyIdBaeWtTyY71S5BRpXkNVZW4ovvanie/4M0/G9eCNstvkGagi7no
   bepPOjFHpkyBwRGgUWAPxFcX8LDeiFfSFSWtUBx+LOtdW7mHgXAWgKdtv
   Eosj4e/IvBamtEc2dJdDkQ0zzLllnbBMZJbycYiY8T/5q1BAdwW7r9urG
   VDWwHTetaRvkkh2mhzBNlexv183ZRhi6hMZo4rSMYRX3uAA1drW5MdEur
   991RWZA/XBNZ5PsvaFPXwkLHzf5DpOTIIKmY6yQGACspaelDhSz2Y1ru9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1176550"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1176550"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 08:32:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1403860"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.246.113.182])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 08:32:57 -0800
From: Shiraz Saleem <shiraz.saleem@intel.com>
To: stable@vger.kernel.org
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH 6.1.y] RDMA/irdma: Fix support for 64k pages
Date: Wed,  7 Feb 2024 10:32:40 -0600
Message-Id: <20240207163240.433-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240207163240.433-1-shiraz.saleem@intel.com>
References: <20240207163240.433-1-shiraz.saleem@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

[ Upstream commit 03769f72d66edab82484449ed594cb6b00ae0223 ]

Virtual QP and CQ require a 4K HW page size but the driver passes
PAGE_SIZE to ib_umem_find_best_pgsz() instead.

Fix this by using the appropriate 4k value in the bitmap passed to
ib_umem_find_best_pgsz().

Patch reworked to handle the different pre-split context.

Fixes: 693a5386eff0 ("RDMA/irdma: Split mr alloc and free into new functions")
Link: https://lore.kernel.org/r/20231129202143.1434-4-shiraz.saleem@intel.com
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 3c437c8070b6..01faec6ea528 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2825,7 +2825,7 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	iwmr->ibmr.pd = pd;
 	iwmr->ibmr.device = pd->device;
 	iwmr->ibmr.iova = virt;
-	iwmr->page_size = PAGE_SIZE;
+	iwmr->page_size = SZ_4K;
 
 	if (req.reg_type == IRDMA_MEMREG_TYPE_MEM) {
 		iwmr->page_size = ib_umem_find_best_pgsz(region,
-- 
1.8.3.1


