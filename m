Return-Path: <stable+bounces-15926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7EB83E349
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 21:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1139A1C2434F
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 20:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6046422EFC;
	Fri, 26 Jan 2024 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HcG3fhkt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0CD224D7
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 20:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300571; cv=none; b=R91PdgbRZWFL+xmUzoXSu5zvXZisrhkBF9edZVzqwa4IuSsk7PzSQFNaFNRH0NbvYGrtqt3aNhA7+gaZn/VbcYqOq65ugdOiMHpPy1/t4zZ4FBlGmQ41CPLe5BxgBAzAGeLV7+xX8c8yefLVb6Uk55gYyOw9JbpUhhiyBNLbaPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300571; c=relaxed/simple;
	bh=qdVW4tw2vjCka0+3SuX15SScpD9Hufj5aUzi6RRvAiI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=clYUI8wex2ncDr60HFzEQ7fuGT9scMqL/bR1mGtagUjb0hoRBeKv23o1Xrn6xvex7nLud77oqQIpzAUnFwpbbnhut1/jjv1e7blUNvWAoG5jJqIgGG07g5OYgEkk1K3QHJXsEcqfnuji74Z/3nYL/g46caZg6biEzFOaB1vESfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HcG3fhkt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706300570; x=1737836570;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qdVW4tw2vjCka0+3SuX15SScpD9Hufj5aUzi6RRvAiI=;
  b=HcG3fhkt4G2uw4q2+Oge6YKKaGOZOpN1W12b0U4fKj0Nyit025oumxyJ
   91PzfIdyGTky3HfXGCr0017Hc9IFTiBtQ1p/uCBf0mFVE2eGf7Ms2qkiz
   TAXOP2q22e1pZ/PK0AJNiCHwc+dxvGzkxI4Oaca4U1UjCnDMI5QCj9fHn
   rfoKt8kuskY7U918YmpIb2gHWNw+p5Lt0dEbeA0G6Q30jDVof87uuO6WJ
   giR80qnl5XHvtl9RBJkjxRMfHdoUt0CxrmJVs4YuoiBFxVQsKoGjBEUOT
   heKYLmtK631mj8iBcspfnZ+g8PLRKNteRQRfQML4RWQ6BV7JnYRoWSpIh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2436756"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2436756"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 12:22:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="960310338"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="960310338"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.246.113.182])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 12:22:48 -0800
From: Shiraz Saleem <shiraz.saleem@intel.com>
To: stable@vger.kernel.org
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH 6.1.x] RDMA/irdma: Ensure iWarp QP queue memory is OS paged aligned
Date: Fri, 26 Jan 2024 14:22:33 -0600
Message-Id: <20240126202234.357-1-shiraz.saleem@intel.com>
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
 drivers/infiniband/hw/irdma/verbs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 745712e1d7de..e02f541430ad 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2783,6 +2783,11 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 
 	switch (req.reg_type) {
 	case IRDMA_MEMREG_TYPE_QP:
+		/* iWarp: Catch page not starting on OS page boundary */
+		if (!rdma_protocol_roce(&iwdev->ibdev, 1) &&
+		    ib_umem_offset(iwmr->region))
+			return -EINVAL;
+
 		total = req.sq_pages + req.rq_pages + shadow_pgcnt;
 		if (total > iwmr->page_cnt) {
 			err = -EINVAL;
-- 
1.8.3.1


