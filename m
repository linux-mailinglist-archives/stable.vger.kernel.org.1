Return-Path: <stable+bounces-3187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337D37FE36E
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 23:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64CE91C20B4D
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 22:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E981D6AB;
	Wed, 29 Nov 2023 22:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNzpfj1y"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A386C1
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 14:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701297800; x=1732833800;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1h/HjoLrtrMdvvcY+n4x7j5YGyJKZ5h0LpCRSXH0frg=;
  b=NNzpfj1yH6FuN42Pn/upHxcNuvDlJuywiC+ow6b5ureSbddOAGFr58vN
   wznJC10qD9aDwnTLCqITKMckwNbEnypA+rnQbq3WK42HWiVDj5++iMeT1
   ZaSVRoRDe8Q2qQPIV94C01iA4kN3QV5jDw48MKFkPpTSNH08JQBdHT7j/
   KeTKOrAxVLKeoVL0ga0BzPd+CNQK+04zHRlmNmj95TeTOulC6sB4VBDyb
   GXl2ZcMg+CpUkzSb8XLWJ6WZpsA2T9gXmH3E9ujmkVdESg6UNcS3ROu5i
   B4Sj8Qr+wCnPtnlwP4WcZvAbHravP0dLT2K1+KGHH81rmm1aEaQ2uuoKT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="373420950"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="373420950"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 14:43:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="718893805"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="718893805"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.124.161.227])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 14:43:19 -0800
From: Shiraz Saleem <shiraz.saleem@intel.com>
To: stable@vger.kernel.org
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH] RDMA/i40iw: Prevent zero-length STAG registration
Date: Wed, 29 Nov 2023 16:42:53 -0600
Message-Id: <20231129224253.1447-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit  bb6d73d9add68ad270888db327514384dfa44958 ]

Currently i40iw allows zero-length STAGs to be programmed in HW during
the kernel mode fast register flow. Zero-length MR or STAG registration
disable HW memory length checks.

Improve gaps in bounds checking in irdma by preventing zero-length STAG or
MR registrations except if the IB_PD_UNSAFE_GLOBAL_RKEY is set.

This addresses the disclosure CVE-2023-25775.

i40iw is replaced by irdma upstream starting 5.14, resulting in adjustments
to upstream commit to support the older APIs.

The kernel versions to apply this patch are 5.10.x 5.4.x 4.19.x 4.14.x.

Fixes: d37498417947 ("i40iw: add files for iwarp interface")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c  |  6 ++++++
 drivers/infiniband/hw/i40iw/i40iw_type.h  |  2 ++
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 10 ++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
index 86d3f8aff329..2b18bb36e4e3 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
@@ -3033,6 +3033,9 @@ static enum i40iw_status_code i40iw_sc_alloc_stag(
 	u64 header;
 	enum i40iw_page_size page_size;
 
+	if (!info->total_len && !info->all_memory)
+		return -EINVAL;
+
 	page_size = (info->page_size == 0x200000) ? I40IW_PAGE_SIZE_2M : I40IW_PAGE_SIZE_4K;
 	cqp = dev->cqp;
 	wqe = i40iw_sc_cqp_get_next_send_wqe(cqp, scratch);
@@ -3091,6 +3094,9 @@ static enum i40iw_status_code i40iw_sc_mr_reg_non_shared(
 	u8 addr_type;
 	enum i40iw_page_size page_size;
 
+	if (!info->total_len && !info->all_memory)
+		return -EINVAL;
+
 	page_size = (info->page_size == 0x200000) ? I40IW_PAGE_SIZE_2M : I40IW_PAGE_SIZE_4K;
 	if (info->access_rights & (I40IW_ACCESS_FLAGS_REMOTEREAD_ONLY |
 				   I40IW_ACCESS_FLAGS_REMOTEWRITE_ONLY))
diff --git a/drivers/infiniband/hw/i40iw/i40iw_type.h b/drivers/infiniband/hw/i40iw/i40iw_type.h
index c3babf3cbb8e..341aa6b1b6c1 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_type.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_type.h
@@ -786,6 +786,7 @@ struct i40iw_allocate_stag_info {
 	bool use_hmc_fcn_index;
 	u8 hmc_fcn_index;
 	bool use_pf_rid;
+	bool all_memory;
 };
 
 struct i40iw_reg_ns_stag_info {
@@ -804,6 +805,7 @@ struct i40iw_reg_ns_stag_info {
 	bool use_hmc_fcn_index;
 	u8 hmc_fcn_index;
 	bool use_pf_rid;
+	bool all_memory;
 };
 
 struct i40iw_fast_reg_stag_info {
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 533f3caecb7a..89654dc91d81 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1494,7 +1494,8 @@ static int i40iw_handle_q_mem(struct i40iw_device *iwdev,
 static int i40iw_hw_alloc_stag(struct i40iw_device *iwdev, struct i40iw_mr *iwmr)
 {
 	struct i40iw_allocate_stag_info *info;
-	struct i40iw_pd *iwpd = to_iwpd(iwmr->ibmr.pd);
+	struct ib_pd *pd = iwmr->ibmr.pd;
+	struct i40iw_pd *iwpd = to_iwpd(pd);
 	enum i40iw_status_code status;
 	int err = 0;
 	struct i40iw_cqp_request *cqp_request;
@@ -1511,6 +1512,7 @@ static int i40iw_hw_alloc_stag(struct i40iw_device *iwdev, struct i40iw_mr *iwmr
 	info->stag_idx = iwmr->stag >> I40IW_CQPSQ_STAG_IDX_SHIFT;
 	info->pd_id = iwpd->sc_pd.pd_id;
 	info->total_len = iwmr->length;
+	info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	info->remote_access = true;
 	cqp_info->cqp_cmd = OP_ALLOC_STAG;
 	cqp_info->post_sq = 1;
@@ -1563,6 +1565,8 @@ static struct ib_mr *i40iw_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 	iwmr->type = IW_MEMREG_TYPE_MEM;
 	palloc = &iwpbl->pble_alloc;
 	iwmr->page_cnt = max_num_sg;
+	/* Use system PAGE_SIZE as the sg page sizes are unknown at this point */
+	iwmr->length = max_num_sg * PAGE_SIZE;
 	mutex_lock(&iwdev->pbl_mutex);
 	status = i40iw_get_pble(&iwdev->sc_dev, iwdev->pble_rsrc, palloc, iwmr->page_cnt);
 	mutex_unlock(&iwdev->pbl_mutex);
@@ -1659,7 +1663,8 @@ static int i40iw_hwreg_mr(struct i40iw_device *iwdev,
 {
 	struct i40iw_pbl *iwpbl = &iwmr->iwpbl;
 	struct i40iw_reg_ns_stag_info *stag_info;
-	struct i40iw_pd *iwpd = to_iwpd(iwmr->ibmr.pd);
+	struct ib_pd *pd = iwmr->ibmr.pd;
+	struct i40iw_pd *iwpd = to_iwpd(pd);
 	struct i40iw_pble_alloc *palloc = &iwpbl->pble_alloc;
 	enum i40iw_status_code status;
 	int err = 0;
@@ -1679,6 +1684,7 @@ static int i40iw_hwreg_mr(struct i40iw_device *iwdev,
 	stag_info->total_len = iwmr->length;
 	stag_info->access_rights = access;
 	stag_info->pd_id = iwpd->sc_pd.pd_id;
+	stag_info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	stag_info->addr_type = I40IW_ADDR_TYPE_VA_BASED;
 	stag_info->page_size = iwmr->page_size;
 
-- 
1.8.3.1


