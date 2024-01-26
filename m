Return-Path: <stable+bounces-15924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB92D83E347
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 21:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68EA280E6A
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 20:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6D722EF4;
	Fri, 26 Jan 2024 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NW+Q3bmZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361922230C
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 20:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300518; cv=none; b=QWML/LEEsla7iMwewXuv+v/FhabH6gnPQlsg0swSAjGq8J8EpG0SjDsLKBjCNnjlwNNSPOfd5LxD6BJHFQFzej1/hDHKYPXIzdfZeELTppa54j7T70KjW6B7ahVWUDuOi+vMioEml5tH9Au9wbcQm0OLii6zv8L5RSQxz9cHC0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300518; c=relaxed/simple;
	bh=qdVW4tw2vjCka0+3SuX15SScpD9Hufj5aUzi6RRvAiI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bb7xQRxwXTusOYvngAZ2Q3eG6Jfj45Qtcr92uq4CMm8hpnbCrjJCZDqEKXrucxkFQjYR8rJtWo2AvGNCNZPcONPahCnJBF/6zARO1Mq3iPzbhRt605fUFObNQMEUNvkWGkhyMmpSaI2Yq8c8PpS02OauttWIh0N+vN87+QbjP0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NW+Q3bmZ; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706300516; x=1737836516;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qdVW4tw2vjCka0+3SuX15SScpD9Hufj5aUzi6RRvAiI=;
  b=NW+Q3bmZGftIECPfhjNVthDlH+SQxlAxyotTawrbNxKr6/qvoirBtDqw
   8H31jiaQQzEoodsl70WYhxeornYEAhK5GzDhkyrAhY+cBDMNqyRnXuZOd
   HotiLNwIEAxeF73K+3Rr/ZW5yMmPXe6DhVPwRxM9B78QTLTb0N/B/v/CX
   DpSdrcLaYb/sNQ8Iu+vZ2ltD2SCESkhYwEyf7e5DGxtNOrObvyiQlQNCG
   PP/KOh/lniZiFA5xbSHcsYqh0if0GptGoeBQo0A6NdL+McAVoj+hqdOu/
   ws++qcovTPHn3JjkLos6cHN4cPR7lqRxtlCo2Uzz/+sK4h/BO6pXEdTyU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="466841968"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="466841968"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 12:21:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="821243875"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="821243875"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.246.113.182])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 12:21:55 -0800
From: Shiraz Saleem <shiraz.saleem@intel.com>
To: stable@vger.kernel.org
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH 5.15.x] RDMA/irdma: Ensure iWarp QP queue memory is OS paged aligned
Date: Fri, 26 Jan 2024 14:21:43 -0600
Message-Id: <20240126202144.323-1-shiraz.saleem@intel.com>
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


