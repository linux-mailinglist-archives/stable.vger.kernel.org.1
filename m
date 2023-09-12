Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745DA79BFB4
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244989AbjIKVIg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242151AbjIKPXh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:23:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA23D8
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:23:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF21EC433C9;
        Mon, 11 Sep 2023 15:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445813;
        bh=slzoSb9fPkYnAco/kQxdrgs6wiowB8KW2u2Mp+iYXnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=teXJRnhOkirObiBeRLFVV9laZwYqouAYUY2W4JH1VNLSQrFn+EuTSCUmwIOi7iHug
         Lcs+EUJHPIU+XzVKYAhf+ziROAQ6cuzdwCqHWy8pXOGc8G/aeAzWb65fPRjiKmGvET
         j682RpmyIPEFKwv08LoBCNgoSPvVnezjt/PmeqTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christopher Bednarz <christopher.n.bednarz@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 480/600] RDMA/irdma: Prevent zero-length STAG registration
Date:   Mon, 11 Sep 2023 15:48:33 +0200
Message-ID: <20230911134647.809580680@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christopher Bednarz <christopher.n.bednarz@intel.com>

[ Upstream commit bb6d73d9add68ad270888db327514384dfa44958 ]

Currently irdma allows zero-length STAGs to be programmed in HW during
the kernel mode fast register flow. Zero-length MR or STAG registration
disable HW memory length checks.

Improve gaps in bounds checking in irdma by preventing zero-length STAG or
MR registrations except if the IB_PD_UNSAFE_GLOBAL_RKEY is set.

This addresses the disclosure CVE-2023-25775.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Christopher Bednarz <christopher.n.bednarz@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Link: https://lore.kernel.org/r/20230818144838.1758-1-shiraz.saleem@intel.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/ctrl.c  |  6 ++++++
 drivers/infiniband/hw/irdma/type.h  |  2 ++
 drivers/infiniband/hw/irdma/verbs.c | 10 ++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 6544c9c60b7db..d98bfb83c3b4b 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -1061,6 +1061,9 @@ static int irdma_sc_alloc_stag(struct irdma_sc_dev *dev,
 	u64 hdr;
 	enum irdma_page_size page_size;
 
+	if (!info->total_len && !info->all_memory)
+		return -EINVAL;
+
 	if (info->page_size == 0x40000000)
 		page_size = IRDMA_PAGE_SIZE_1G;
 	else if (info->page_size == 0x200000)
@@ -1126,6 +1129,9 @@ static int irdma_sc_mr_reg_non_shared(struct irdma_sc_dev *dev,
 	u8 addr_type;
 	enum irdma_page_size page_size;
 
+	if (!info->total_len && !info->all_memory)
+		return -EINVAL;
+
 	if (info->page_size == 0x40000000)
 		page_size = IRDMA_PAGE_SIZE_1G;
 	else if (info->page_size == 0x200000)
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index d6cb94dc744c5..1c7cbf7c67bed 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -1015,6 +1015,7 @@ struct irdma_allocate_stag_info {
 	bool remote_access:1;
 	bool use_hmc_fcn_index:1;
 	bool use_pf_rid:1;
+	bool all_memory:1;
 	u8 hmc_fcn_index;
 };
 
@@ -1042,6 +1043,7 @@ struct irdma_reg_ns_stag_info {
 	bool use_hmc_fcn_index:1;
 	u8 hmc_fcn_index;
 	bool use_pf_rid:1;
+	bool all_memory:1;
 };
 
 struct irdma_fast_reg_stag_info {
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 5962261f1b156..3b8b2341981ea 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2557,7 +2557,8 @@ static int irdma_hw_alloc_stag(struct irdma_device *iwdev,
 			       struct irdma_mr *iwmr)
 {
 	struct irdma_allocate_stag_info *info;
-	struct irdma_pd *iwpd = to_iwpd(iwmr->ibmr.pd);
+	struct ib_pd *pd = iwmr->ibmr.pd;
+	struct irdma_pd *iwpd = to_iwpd(pd);
 	int status;
 	struct irdma_cqp_request *cqp_request;
 	struct cqp_cmds_info *cqp_info;
@@ -2573,6 +2574,7 @@ static int irdma_hw_alloc_stag(struct irdma_device *iwdev,
 	info->stag_idx = iwmr->stag >> IRDMA_CQPSQ_STAG_IDX_S;
 	info->pd_id = iwpd->sc_pd.pd_id;
 	info->total_len = iwmr->len;
+	info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	info->remote_access = true;
 	cqp_info->cqp_cmd = IRDMA_OP_ALLOC_STAG;
 	cqp_info->post_sq = 1;
@@ -2620,6 +2622,8 @@ static struct ib_mr *irdma_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 	iwmr->type = IRDMA_MEMREG_TYPE_MEM;
 	palloc = &iwpbl->pble_alloc;
 	iwmr->page_cnt = max_num_sg;
+	/* Use system PAGE_SIZE as the sg page sizes are unknown at this point */
+	iwmr->len = max_num_sg * PAGE_SIZE;
 	err_code = irdma_get_pble(iwdev->rf->pble_rsrc, palloc, iwmr->page_cnt,
 				  false);
 	if (err_code)
@@ -2699,7 +2703,8 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 {
 	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
 	struct irdma_reg_ns_stag_info *stag_info;
-	struct irdma_pd *iwpd = to_iwpd(iwmr->ibmr.pd);
+	struct ib_pd *pd = iwmr->ibmr.pd;
+	struct irdma_pd *iwpd = to_iwpd(pd);
 	struct irdma_pble_alloc *palloc = &iwpbl->pble_alloc;
 	struct irdma_cqp_request *cqp_request;
 	struct cqp_cmds_info *cqp_info;
@@ -2718,6 +2723,7 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 	stag_info->total_len = iwmr->len;
 	stag_info->access_rights = irdma_get_mr_access(access);
 	stag_info->pd_id = iwpd->sc_pd.pd_id;
+	stag_info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	if (stag_info->access_rights & IRDMA_ACCESS_FLAGS_ZERO_BASED)
 		stag_info->addr_type = IRDMA_ADDR_TYPE_ZERO_BASED;
 	else
-- 
2.40.1



