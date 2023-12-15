Return-Path: <stable+bounces-6846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3A581502D
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 20:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E691F251FD
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 19:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27393FE55;
	Fri, 15 Dec 2023 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ivyvzy9e"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9F53C486
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702668587; x=1734204587;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kDPpI3fkMDDzAkv/Z2BG2V2007cWdm8q5hoXZVjOrWs=;
  b=Ivyvzy9ekHeCe/VijUjgZt6qKKlUh2k6yHCKVZp+NlRoGhTVslC3Nphv
   e8tWCGcmQp9uoVn6uEjlPrvJvPlGztZshwPq2q7ZkNrXJw2BQH05uWNbJ
   1eNdOdbUyCYiw5YTUQl8Ijl/889YPcQ/J2dIQwU+/12f9Q1Xz4T6teKrY
   y8/gFyL7bHBGvHMrtcKgTSr4rljwVDt65y6qZb6N/dAdqEFvIL3SfD64/
   n0yrPo6ePDepiTXhU/kCP7zwIjKXH541YfkeIJgXW1LxB98pGX2PeK7He
   8LMN82tpWMQNa4YGZuw85wirpJfFQK4fAYq+r6qwwK2HhKvMzfYMB24OC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="399158835"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="399158835"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 11:29:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="948072708"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="948072708"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.92.235.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 11:29:45 -0800
From: Shiraz Saleem <shiraz.saleem@intel.com>
To: stable@vger.kernel.org
Cc: Christopher Bednarz <christopher.n.bednarz@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH 5.15.x] RDMA/irdma: Prevent zero-length STAG registration
Date: Fri, 15 Dec 2023 13:29:39 -0600
Message-Id: <20231215192939.478-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christopher Bednarz <christopher.n.bednarz@intel.com>

[Upstream commit bb6d73d9add68ad270888db327514384dfa44958]

Currently irdma allows zero-length STAGs to be programmed in HW during
the kernel mode fast register flow. Zero-length MR or STAG registration
disable HW memory length checks.

Improve gaps in bounds checking in irdma by preventing zero-length STAG or
MR registrations except if the IB_PD_UNSAFE_GLOBAL_RKEY is set.

This addresses the disclosure CVE-2023-25775.

The kernel version to apply this patch is 5.15.x.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Christopher Bednarz <christopher.n.bednarz@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/ctrl.c  |  6 ++++++
 drivers/infiniband/hw/irdma/type.h  |  2 ++
 drivers/infiniband/hw/irdma/verbs.c | 10 ++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index ad14c2404e94..e6851cffa40a 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -1043,6 +1043,9 @@ void irdma_sc_qp_setctx(struct irdma_sc_qp *qp, __le64 *qp_ctx,
 	u64 hdr;
 	enum irdma_page_size page_size;
 
+	if (!info->total_len && !info->all_memory)
+		return -EINVAL;
+
 	if (info->page_size == 0x40000000)
 		page_size = IRDMA_PAGE_SIZE_1G;
 	else if (info->page_size == 0x200000)
@@ -1109,6 +1112,9 @@ void irdma_sc_qp_setctx(struct irdma_sc_qp *qp, __le64 *qp_ctx,
 	u8 addr_type;
 	enum irdma_page_size page_size;
 
+	if (!info->total_len && !info->all_memory)
+		return -EINVAL;
+
 	if (info->page_size == 0x40000000)
 		page_size = IRDMA_PAGE_SIZE_1G;
 	else if (info->page_size == 0x200000)
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 8b75e2610e5b..021dc9fe1d02 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -1013,6 +1013,7 @@ struct irdma_allocate_stag_info {
 	bool remote_access:1;
 	bool use_hmc_fcn_index:1;
 	bool use_pf_rid:1;
+	bool all_memory:1;
 	u8 hmc_fcn_index;
 };
 
@@ -1040,6 +1041,7 @@ struct irdma_reg_ns_stag_info {
 	bool use_hmc_fcn_index:1;
 	u8 hmc_fcn_index;
 	bool use_pf_rid:1;
+	bool all_memory:1;
 };
 
 struct irdma_fast_reg_stag_info {
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 8ccbe761b860..fa1ccd6a9400 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2514,7 +2514,8 @@ static int irdma_hw_alloc_stag(struct irdma_device *iwdev,
 			       struct irdma_mr *iwmr)
 {
 	struct irdma_allocate_stag_info *info;
-	struct irdma_pd *iwpd = to_iwpd(iwmr->ibmr.pd);
+	struct ib_pd *pd = iwmr->ibmr.pd;
+	struct irdma_pd *iwpd = to_iwpd(pd);
 	enum irdma_status_code status;
 	int err = 0;
 	struct irdma_cqp_request *cqp_request;
@@ -2531,6 +2532,7 @@ static int irdma_hw_alloc_stag(struct irdma_device *iwdev,
 	info->stag_idx = iwmr->stag >> IRDMA_CQPSQ_STAG_IDX_S;
 	info->pd_id = iwpd->sc_pd.pd_id;
 	info->total_len = iwmr->len;
+	info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	info->remote_access = true;
 	cqp_info->cqp_cmd = IRDMA_OP_ALLOC_STAG;
 	cqp_info->post_sq = 1;
@@ -2581,6 +2583,8 @@ static struct ib_mr *irdma_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 	iwmr->type = IRDMA_MEMREG_TYPE_MEM;
 	palloc = &iwpbl->pble_alloc;
 	iwmr->page_cnt = max_num_sg;
+	/* Use system PAGE_SIZE as the sg page sizes are unknown at this point */
+	iwmr->len = max_num_sg * PAGE_SIZE;
 	status = irdma_get_pble(iwdev->rf->pble_rsrc, palloc, iwmr->page_cnt,
 				true);
 	if (status)
@@ -2652,7 +2656,8 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 {
 	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
 	struct irdma_reg_ns_stag_info *stag_info;
-	struct irdma_pd *iwpd = to_iwpd(iwmr->ibmr.pd);
+	struct ib_pd *pd = iwmr->ibmr.pd;
+	struct irdma_pd *iwpd = to_iwpd(pd);
 	struct irdma_pble_alloc *palloc = &iwpbl->pble_alloc;
 	enum irdma_status_code status;
 	int err = 0;
@@ -2672,6 +2677,7 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 	stag_info->total_len = iwmr->len;
 	stag_info->access_rights = irdma_get_mr_access(access);
 	stag_info->pd_id = iwpd->sc_pd.pd_id;
+	stag_info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	if (stag_info->access_rights & IRDMA_ACCESS_FLAGS_ZERO_BASED)
 		stag_info->addr_type = IRDMA_ADDR_TYPE_ZERO_BASED;
 	else
-- 
1.8.3.1


