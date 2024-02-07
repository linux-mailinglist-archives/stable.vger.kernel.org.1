Return-Path: <stable+bounces-19082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC9684CEEB
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 17:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B50628D73F
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 16:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD2D80612;
	Wed,  7 Feb 2024 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rxl1dpLy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C010A35280
	for <stable@vger.kernel.org>; Wed,  7 Feb 2024 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323579; cv=none; b=PATg3gobUBc4M1/vvU1ReSxyyFbAEooYuR8wPfV5WqjURYEHBZDT3wOt3up9uGN9T2V0ByoENy1qcrDW0A0os8HT7J4zExj+mSv/yJkLch6awWT2wEmXG67S9pMqf89ZwWPrRdwYnLVqoys5iqNTGMbmBqewo+FtsNgPJx5i8X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323579; c=relaxed/simple;
	bh=7IgE4I98BnPfajfynHxPoOaK8OzhuQ09DsyqOGf/eZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JFF806aZiQa8QQpOOrMjEJsFZq6RuUFEqzvoPj9EBO2OkXhcbV2wHegoZy4WfdaVCBmSq3n9bTatKuIlTVT7P18jX3e4NDotwkYhPxFvoDQ6HuGW4laPCMhFkoQCudrp73lCoRYeGO51vIFPihkWuUhJMwk3r/jHFLH+OXKB5mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rxl1dpLy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707323578; x=1738859578;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7IgE4I98BnPfajfynHxPoOaK8OzhuQ09DsyqOGf/eZQ=;
  b=Rxl1dpLyfMyCcyIWHcc0IBb0PA3nKA0Y3VaNjdT3QJl2+KCeFBXZUM2S
   JPgsrnUmzqKSf14Pe/4sL6LoZxL7IgNRZI4mh0yrH+9pE9H2SXrANwv56
   TgbO2d/nAlwBX3FYUFBJRGlSmf4vuflgeVLDH1S833eWdBS26pEfMFxaq
   uDq/NyVfSJEngNib+BC9r9yr4hv0eDlqie0P3R4MaEmSUNgxKyffFKVkX
   AYFSxJMHmB77xmCxcDxl09bkApUK2Cus1po5zmVpqC4BPhfCSK9kIYoHG
   /773b85pMZ3M7zIBGnw8alAVn5ZgXvgglwLm6HDRan71NppePxsTKzsWh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1176549"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1176549"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 08:32:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1403856"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.246.113.182])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 08:32:57 -0800
From: Shiraz Saleem <shiraz.saleem@intel.com>
To: stable@vger.kernel.org
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH 6.1.y] RDMA/irdma: Ensure iWarp QP queue memory is OS paged aligned
Date: Wed,  7 Feb 2024 10:32:39 -0600
Message-Id: <20240207163240.433-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

[ Upstream commit 0a5ec366de7e94192669ba08de6ed336607fd282 ]

The SQ is shared for between kernel and used by storing the kernel page
pointer and passing that to a kmap_atomic().

This then requires that the alignment is PAGE_SIZE aligned.

Fix by adding an iWarp specific alignment check.

The patch needed to be reworked because the separate routines
present upstream are not there in older irdma drivers.

Fixes: e965ef0e7b2c ("RDMA/irdma: Split QP handler into irdma_reg_user_mr_type_qp")
Link: https://lore.kernel.org/r/20231129202143.1434-3-shiraz.saleem@intel.com
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 447e1bcc82a3..3c437c8070b6 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2845,6 +2845,13 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 
 	switch (req.reg_type) {
 	case IRDMA_MEMREG_TYPE_QP:
+		/* iWarp: Catch page not starting on OS page boundary */
+		if (!rdma_protocol_roce(&iwdev->ibdev, 1) &&
+		    ib_umem_offset(iwmr->region)) {
+			err = -EINVAL;
+			goto error;
+		}
+
 		total = req.sq_pages + req.rq_pages + shadow_pgcnt;
 		if (total > iwmr->page_cnt) {
 			err = -EINVAL;
-- 
1.8.3.1


