Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F06576AE60
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjHAJiP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbjHAJhe (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:37:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCCFE7B
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:35:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CCBD61509
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EADC433C7;
        Tue,  1 Aug 2023 09:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882555;
        bh=xflFs7qqtPEPNO6pSUA+eT47r1kdXe173GTxILzAY9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HRww0+6QNJcEU9LUeRoy7plFRrqy4JlYw4mXNXCwP6TpKyz/Q7be7mIOr9s/8xO9F
         OwxboWXeuqDomtO2ZgNgV9zG4gi6LLWfEhjQ8PqfiRetGEaFeyH8fXqXbaVH0URxwM
         wc3yukJg6lO1CJygVuHj8fBiaD9movbqr+W7aJIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shiraz Saleem <shiraz.saleem@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 119/228] RDMA/irdma: Fix data race on CQP completion stats
Date:   Tue,  1 Aug 2023 11:19:37 +0200
Message-ID: <20230801091927.057726744@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shiraz Saleem <shiraz.saleem@intel.com>

[ Upstream commit f2c3037811381f9149243828c7eb9a1631df9f9c ]

CQP completion statistics is read lockesly in irdma_wait_event and
irdma_check_cqp_progress while it can be updated in the completion
thread irdma_sc_ccq_get_cqe_info on another CPU as KCSAN reports.

Make completion statistics an atomic variable to reflect coherent updates
to it. This will also avoid load/store tearing logic bug potentially
possible by compiler optimizations.

[77346.170861] BUG: KCSAN: data-race in irdma_handle_cqp_op [irdma] / irdma_sc_ccq_get_cqe_info [irdma]

[77346.171383] write to 0xffff8a3250b108e0 of 8 bytes by task 9544 on cpu 4:
[77346.171483]  irdma_sc_ccq_get_cqe_info+0x27a/0x370 [irdma]
[77346.171658]  irdma_cqp_ce_handler+0x164/0x270 [irdma]
[77346.171835]  cqp_compl_worker+0x1b/0x20 [irdma]
[77346.172009]  process_one_work+0x4d1/0xa40
[77346.172024]  worker_thread+0x319/0x700
[77346.172037]  kthread+0x180/0x1b0
[77346.172054]  ret_from_fork+0x22/0x30

[77346.172136] read to 0xffff8a3250b108e0 of 8 bytes by task 9838 on cpu 2:
[77346.172234]  irdma_handle_cqp_op+0xf4/0x4b0 [irdma]
[77346.172413]  irdma_cqp_aeq_cmd+0x75/0xa0 [irdma]
[77346.172592]  irdma_create_aeq+0x390/0x45a [irdma]
[77346.172769]  irdma_rt_init_hw.cold+0x212/0x85d [irdma]
[77346.172944]  irdma_probe+0x54f/0x620 [irdma]
[77346.173122]  auxiliary_bus_probe+0x66/0xa0
[77346.173137]  really_probe+0x140/0x540
[77346.173154]  __driver_probe_device+0xc7/0x220
[77346.173173]  driver_probe_device+0x5f/0x140
[77346.173190]  __driver_attach+0xf0/0x2c0
[77346.173208]  bus_for_each_dev+0xa8/0xf0
[77346.173225]  driver_attach+0x29/0x30
[77346.173240]  bus_add_driver+0x29c/0x2f0
[77346.173255]  driver_register+0x10f/0x1a0
[77346.173272]  __auxiliary_driver_register+0xbc/0x140
[77346.173287]  irdma_init_module+0x55/0x1000 [irdma]
[77346.173460]  do_one_initcall+0x7d/0x410
[77346.173475]  do_init_module+0x81/0x2c0
[77346.173491]  load_module+0x1232/0x12c0
[77346.173506]  __do_sys_finit_module+0x101/0x180
[77346.173522]  __x64_sys_finit_module+0x3c/0x50
[77346.173538]  do_syscall_64+0x39/0x90
[77346.173553]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

[77346.173634] value changed: 0x0000000000000094 -> 0x0000000000000095

Fixes: 915cc7ac0f8e ("RDMA/irdma: Add miscellaneous utility definitions")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Link: https://lore.kernel.org/r/20230711175253.1289-3-shiraz.saleem@intel.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/ctrl.c  | 22 +++++++-------
 drivers/infiniband/hw/irdma/defs.h  | 46 ++++++++++++++---------------
 drivers/infiniband/hw/irdma/type.h  |  2 ++
 drivers/infiniband/hw/irdma/utils.c |  2 +-
 4 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index d86d7ca9cee4a..6544c9c60b7db 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -2693,13 +2693,13 @@ static int irdma_sc_cq_modify(struct irdma_sc_cq *cq,
  */
 void irdma_check_cqp_progress(struct irdma_cqp_timeout *timeout, struct irdma_sc_dev *dev)
 {
-	if (timeout->compl_cqp_cmds != dev->cqp_cmd_stats[IRDMA_OP_CMPL_CMDS]) {
-		timeout->compl_cqp_cmds = dev->cqp_cmd_stats[IRDMA_OP_CMPL_CMDS];
+	u64 completed_ops = atomic64_read(&dev->cqp->completed_ops);
+
+	if (timeout->compl_cqp_cmds != completed_ops) {
+		timeout->compl_cqp_cmds = completed_ops;
 		timeout->count = 0;
-	} else {
-		if (dev->cqp_cmd_stats[IRDMA_OP_REQ_CMDS] !=
-		    timeout->compl_cqp_cmds)
-			timeout->count++;
+	} else if (timeout->compl_cqp_cmds != dev->cqp->requested_ops) {
+		timeout->count++;
 	}
 }
 
@@ -2742,7 +2742,7 @@ static int irdma_cqp_poll_registers(struct irdma_sc_cqp *cqp, u32 tail,
 		if (newtail != tail) {
 			/* SUCCESS */
 			IRDMA_RING_MOVE_TAIL(cqp->sq_ring);
-			cqp->dev->cqp_cmd_stats[IRDMA_OP_CMPL_CMDS]++;
+			atomic64_inc(&cqp->completed_ops);
 			return 0;
 		}
 		udelay(cqp->dev->hw_attrs.max_sleep_count);
@@ -3102,8 +3102,8 @@ int irdma_sc_cqp_init(struct irdma_sc_cqp *cqp,
 	info->dev->cqp = cqp;
 
 	IRDMA_RING_INIT(cqp->sq_ring, cqp->sq_size);
-	cqp->dev->cqp_cmd_stats[IRDMA_OP_REQ_CMDS] = 0;
-	cqp->dev->cqp_cmd_stats[IRDMA_OP_CMPL_CMDS] = 0;
+	cqp->requested_ops = 0;
+	atomic64_set(&cqp->completed_ops, 0);
 	/* for the cqp commands backlog. */
 	INIT_LIST_HEAD(&cqp->dev->cqp_cmd_head);
 
@@ -3255,7 +3255,7 @@ __le64 *irdma_sc_cqp_get_next_send_wqe_idx(struct irdma_sc_cqp *cqp, u64 scratch
 	if (ret_code)
 		return NULL;
 
-	cqp->dev->cqp_cmd_stats[IRDMA_OP_REQ_CMDS]++;
+	cqp->requested_ops++;
 	if (!*wqe_idx)
 		cqp->polarity = !cqp->polarity;
 	wqe = cqp->sq_base[*wqe_idx].elem;
@@ -3381,7 +3381,7 @@ int irdma_sc_ccq_get_cqe_info(struct irdma_sc_cq *ccq,
 	dma_wmb(); /* make sure shadow area is updated before moving tail */
 
 	IRDMA_RING_MOVE_TAIL(cqp->sq_ring);
-	ccq->dev->cqp_cmd_stats[IRDMA_OP_CMPL_CMDS]++;
+	atomic64_inc(&cqp->completed_ops);
 
 	return ret_code;
 }
diff --git a/drivers/infiniband/hw/irdma/defs.h b/drivers/infiniband/hw/irdma/defs.h
index c1906cab5c8ad..ad54260cb58c9 100644
--- a/drivers/infiniband/hw/irdma/defs.h
+++ b/drivers/infiniband/hw/irdma/defs.h
@@ -190,32 +190,30 @@ enum irdma_cqp_op_type {
 	IRDMA_OP_MANAGE_VF_PBLE_BP		= 25,
 	IRDMA_OP_QUERY_FPM_VAL			= 26,
 	IRDMA_OP_COMMIT_FPM_VAL			= 27,
-	IRDMA_OP_REQ_CMDS			= 28,
-	IRDMA_OP_CMPL_CMDS			= 29,
-	IRDMA_OP_AH_CREATE			= 30,
-	IRDMA_OP_AH_MODIFY			= 31,
-	IRDMA_OP_AH_DESTROY			= 32,
-	IRDMA_OP_MC_CREATE			= 33,
-	IRDMA_OP_MC_DESTROY			= 34,
-	IRDMA_OP_MC_MODIFY			= 35,
-	IRDMA_OP_STATS_ALLOCATE			= 36,
-	IRDMA_OP_STATS_FREE			= 37,
-	IRDMA_OP_STATS_GATHER			= 38,
-	IRDMA_OP_WS_ADD_NODE			= 39,
-	IRDMA_OP_WS_MODIFY_NODE			= 40,
-	IRDMA_OP_WS_DELETE_NODE			= 41,
-	IRDMA_OP_WS_FAILOVER_START		= 42,
-	IRDMA_OP_WS_FAILOVER_COMPLETE		= 43,
-	IRDMA_OP_SET_UP_MAP			= 44,
-	IRDMA_OP_GEN_AE				= 45,
-	IRDMA_OP_QUERY_RDMA_FEATURES		= 46,
-	IRDMA_OP_ALLOC_LOCAL_MAC_ENTRY		= 47,
-	IRDMA_OP_ADD_LOCAL_MAC_ENTRY		= 48,
-	IRDMA_OP_DELETE_LOCAL_MAC_ENTRY		= 49,
-	IRDMA_OP_CQ_MODIFY			= 50,
+	IRDMA_OP_AH_CREATE			= 28,
+	IRDMA_OP_AH_MODIFY			= 29,
+	IRDMA_OP_AH_DESTROY			= 30,
+	IRDMA_OP_MC_CREATE			= 31,
+	IRDMA_OP_MC_DESTROY			= 32,
+	IRDMA_OP_MC_MODIFY			= 33,
+	IRDMA_OP_STATS_ALLOCATE			= 34,
+	IRDMA_OP_STATS_FREE			= 35,
+	IRDMA_OP_STATS_GATHER			= 36,
+	IRDMA_OP_WS_ADD_NODE			= 37,
+	IRDMA_OP_WS_MODIFY_NODE			= 38,
+	IRDMA_OP_WS_DELETE_NODE			= 39,
+	IRDMA_OP_WS_FAILOVER_START		= 40,
+	IRDMA_OP_WS_FAILOVER_COMPLETE		= 41,
+	IRDMA_OP_SET_UP_MAP			= 42,
+	IRDMA_OP_GEN_AE				= 43,
+	IRDMA_OP_QUERY_RDMA_FEATURES		= 44,
+	IRDMA_OP_ALLOC_LOCAL_MAC_ENTRY		= 45,
+	IRDMA_OP_ADD_LOCAL_MAC_ENTRY		= 46,
+	IRDMA_OP_DELETE_LOCAL_MAC_ENTRY		= 47,
+	IRDMA_OP_CQ_MODIFY			= 48,
 
 	/* Must be last entry*/
-	IRDMA_MAX_CQP_OPS			= 51,
+	IRDMA_MAX_CQP_OPS			= 49,
 };
 
 /* CQP SQ WQES */
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 517d41a1c2894..d6cb94dc744c5 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -410,6 +410,8 @@ struct irdma_sc_cqp {
 	struct irdma_dcqcn_cc_params dcqcn_params;
 	__le64 *host_ctx;
 	u64 *scratch_array;
+	u64 requested_ops;
+	atomic64_t completed_ops;
 	u32 cqp_id;
 	u32 sq_size;
 	u32 hw_sq_size;
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 7887230c867b1..90ca4a1b60c21 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -567,7 +567,7 @@ static int irdma_wait_event(struct irdma_pci_f *rf,
 	bool cqp_error = false;
 	int err_code = 0;
 
-	cqp_timeout.compl_cqp_cmds = rf->sc_dev.cqp_cmd_stats[IRDMA_OP_CMPL_CMDS];
+	cqp_timeout.compl_cqp_cmds = atomic64_read(&rf->sc_dev.cqp->completed_ops);
 	do {
 		irdma_cqp_ce_handler(rf, &rf->ccq.sc_cq);
 		if (wait_event_timeout(cqp_request->waitq,
-- 
2.40.1



