Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECD379B53B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353972AbjIKVvt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239240AbjIKOPW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:15:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F7FDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:15:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B765C433C7;
        Mon, 11 Sep 2023 14:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441717;
        bh=3V/pne496Nm+X+a1QQPitUX2L2nlm+hSYWU/jkd2X+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xT3zmfUZaIPe+gJSjuRpcAnW3fAhXeZvZeg74dNdSKI1l7H+MAcKVeEvzFgAIFWxc
         wUrq6bp6JjRY+dyniVJyn8AN8LgdiXVrr0ns3QrOsmL+A3kc8854/rtR/iYjd4XWuZ
         uDMOuz+2MAEtUfrJtP/N502Xv4+glDEJdakgtcTs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chandramohan Akula <chandramohan.akula@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 511/739] RDMA/bnxt_re: Initialize Doorbell pacing feature
Date:   Mon, 11 Sep 2023 15:45:10 +0200
Message-ID: <20230911134705.398984868@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

[ Upstream commit 586e613d37ec35572a332839973b9c3bccd0c545 ]

Checks for pacing feature capability and get the doorbell pacing
configuration using FW commands. Allocate a page and initialize
the pacing parameters for the applications. Cleanup the page and
de-initialize the pacing during device removal.

Link: https://lore.kernel.org/r/1689742977-9128-4-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Stable-dep-of: f19fba1f79dc ("RDMA/bnxt_re: Fix max_qp count for virtual functions")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h   | 22 ++++++
 drivers/infiniband/hw/bnxt_re/main.c      | 96 +++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_res.h | 19 +++++
 3 files changed, 137 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index ea81b2497511a..1543f80a1b5c4 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -112,6 +112,27 @@ struct bnxt_re_gsi_context {
 #define BNXT_RE_NQ_IDX			1
 #define BNXT_RE_GEN_P5_MAX_VF		64
 
+struct bnxt_re_pacing {
+	u64 dbr_db_fifo_reg_off;
+	void *dbr_page;
+	u64 dbr_bar_addr;
+	u32 pacing_algo_th;
+	u32 do_pacing_save;
+	u32 dbq_pacing_time; /* ms */
+	u32 dbr_def_do_pacing;
+	bool dbr_pacing;
+};
+
+#define BNXT_RE_DBR_PACING_TIME 5 /* ms */
+#define BNXT_RE_PACING_ALGO_THRESHOLD 250 /* Entries in DB FIFO */
+#define BNXT_RE_PACING_ALARM_TH_MULTIPLE 2 /* Multiple of pacing algo threshold */
+/* Default do_pacing value when there is no congestion */
+#define BNXT_RE_DBR_DO_PACING_NO_CONGESTION 0x7F /* 1 in 512 probability */
+#define BNXT_RE_DB_FIFO_ROOM_MASK 0x1FFF8000
+#define BNXT_RE_MAX_FIFO_DEPTH 0x2c00
+#define BNXT_RE_DB_FIFO_ROOM_SHIFT 15
+#define BNXT_RE_GRC_FIFO_REG_BASE 0x2000
+
 struct bnxt_re_dev {
 	struct ib_device		ibdev;
 	struct list_head		list;
@@ -171,6 +192,7 @@ struct bnxt_re_dev {
 	atomic_t nq_alloc_cnt;
 	u32 is_virtfn;
 	u32 num_vfs;
+	struct bnxt_re_pacing pacing;
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 63e98e2d35962..4bf2752e7b466 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -432,9 +432,92 @@ int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev)
 		return rc;
 	cctx->modes.db_push = le32_to_cpu(resp.flags) & FUNC_QCAPS_RESP_FLAGS_WCB_PUSH_MODE;
 
+	cctx->modes.dbr_pacing =
+		le32_to_cpu(resp.flags_ext2) & FUNC_QCAPS_RESP_FLAGS_EXT2_DBR_PACING_EXT_SUPPORTED ?
+		true : false;
 	return 0;
 }
 
+static int bnxt_re_hwrm_dbr_pacing_qcfg(struct bnxt_re_dev *rdev)
+{
+	struct hwrm_func_dbr_pacing_qcfg_output resp = {};
+	struct hwrm_func_dbr_pacing_qcfg_input req = {};
+	struct bnxt_en_dev *en_dev = rdev->en_dev;
+	struct bnxt_qplib_chip_ctx *cctx;
+	struct bnxt_fw_msg fw_msg = {};
+	int rc;
+
+	cctx = rdev->chip_ctx;
+	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_FUNC_DBR_PACING_QCFG);
+	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
+			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+	rc = bnxt_send_msg(en_dev, &fw_msg);
+	if (rc)
+		return rc;
+
+	if ((le32_to_cpu(resp.dbr_stat_db_fifo_reg) &
+	    FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_MASK) ==
+		FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_GRC)
+		cctx->dbr_stat_db_fifo =
+			le32_to_cpu(resp.dbr_stat_db_fifo_reg) &
+			~FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_MASK;
+	return 0;
+}
+
+/* Update the pacing tunable parameters to the default values */
+static void bnxt_re_set_default_pacing_data(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_qplib_db_pacing_data *pacing_data = rdev->qplib_res.pacing_data;
+
+	pacing_data->do_pacing = rdev->pacing.dbr_def_do_pacing;
+	pacing_data->pacing_th = rdev->pacing.pacing_algo_th;
+	pacing_data->alarm_th =
+		pacing_data->pacing_th * BNXT_RE_PACING_ALARM_TH_MULTIPLE;
+}
+
+static int bnxt_re_initialize_dbr_pacing(struct bnxt_re_dev *rdev)
+{
+	if (bnxt_re_hwrm_dbr_pacing_qcfg(rdev))
+		return -EIO;
+
+	/* Allocate a page for app use */
+	rdev->pacing.dbr_page = (void *)__get_free_page(GFP_KERNEL);
+	if (!rdev->pacing.dbr_page)
+		return -ENOMEM;
+
+	memset((u8 *)rdev->pacing.dbr_page, 0, PAGE_SIZE);
+	rdev->qplib_res.pacing_data = (struct bnxt_qplib_db_pacing_data *)rdev->pacing.dbr_page;
+
+	/* MAP HW window 2 for reading db fifo depth */
+	writel(rdev->chip_ctx->dbr_stat_db_fifo & BNXT_GRC_BASE_MASK,
+	       rdev->en_dev->bar0 + BNXT_GRCPF_REG_WINDOW_BASE_OUT + 4);
+	rdev->pacing.dbr_db_fifo_reg_off =
+		(rdev->chip_ctx->dbr_stat_db_fifo & BNXT_GRC_OFFSET_MASK) +
+		 BNXT_RE_GRC_FIFO_REG_BASE;
+	rdev->pacing.dbr_bar_addr =
+		pci_resource_start(rdev->qplib_res.pdev, 0) + rdev->pacing.dbr_db_fifo_reg_off;
+
+	rdev->pacing.pacing_algo_th = BNXT_RE_PACING_ALGO_THRESHOLD;
+	rdev->pacing.dbq_pacing_time = BNXT_RE_DBR_PACING_TIME;
+	rdev->pacing.dbr_def_do_pacing = BNXT_RE_DBR_DO_PACING_NO_CONGESTION;
+	rdev->pacing.do_pacing_save = rdev->pacing.dbr_def_do_pacing;
+	rdev->qplib_res.pacing_data->fifo_max_depth = BNXT_RE_MAX_FIFO_DEPTH;
+	rdev->qplib_res.pacing_data->fifo_room_mask = BNXT_RE_DB_FIFO_ROOM_MASK;
+	rdev->qplib_res.pacing_data->fifo_room_shift = BNXT_RE_DB_FIFO_ROOM_SHIFT;
+	rdev->qplib_res.pacing_data->grc_reg_offset = rdev->pacing.dbr_db_fifo_reg_off;
+	bnxt_re_set_default_pacing_data(rdev);
+	return 0;
+}
+
+static void bnxt_re_deinitialize_dbr_pacing(struct bnxt_re_dev *rdev)
+{
+	if (rdev->pacing.dbr_page)
+		free_page((u64)rdev->pacing.dbr_page);
+
+	rdev->pacing.dbr_page = NULL;
+	rdev->pacing.dbr_pacing = false;
+}
+
 static int bnxt_re_net_ring_free(struct bnxt_re_dev *rdev,
 				 u16 fw_ring_id, int type)
 {
@@ -1217,6 +1300,9 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev)
 	if (test_and_clear_bit(BNXT_RE_FLAG_GOT_MSIX, &rdev->flags))
 		rdev->num_msix = 0;
 
+	if (rdev->pacing.dbr_pacing)
+		bnxt_re_deinitialize_dbr_pacing(rdev);
+
 	bnxt_re_destroy_chip_ctx(rdev);
 	if (test_and_clear_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags))
 		bnxt_unregister_dev(rdev->en_dev);
@@ -1311,6 +1397,16 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 wqe_mode)
 		goto free_ring;
 	}
 
+	if (bnxt_qplib_dbr_pacing_en(rdev->chip_ctx)) {
+		rc = bnxt_re_initialize_dbr_pacing(rdev);
+		if (!rc) {
+			rdev->pacing.dbr_pacing = true;
+		} else {
+			ibdev_err(&rdev->ibdev,
+				  "DBR pacing disabled with error : %d\n", rc);
+			rdev->pacing.dbr_pacing = false;
+		}
+	}
 	rc = bnxt_qplib_get_dev_attr(&rdev->rcfw, &rdev->dev_attr,
 				     rdev->is_virtfn);
 	if (rc)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index d850a553821e3..57161d303c257 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -48,6 +48,7 @@ extern const struct bnxt_qplib_gid bnxt_qplib_gid_zero;
 struct bnxt_qplib_drv_modes {
 	u8	wqe_mode;
 	bool db_push;
+	bool dbr_pacing;
 };
 
 struct bnxt_qplib_chip_ctx {
@@ -58,6 +59,17 @@ struct bnxt_qplib_chip_ctx {
 	u16	hwrm_cmd_max_timeout;
 	struct bnxt_qplib_drv_modes modes;
 	u64	hwrm_intf_ver;
+	u32     dbr_stat_db_fifo;
+};
+
+struct bnxt_qplib_db_pacing_data {
+	u32 do_pacing;
+	u32 pacing_th;
+	u32 alarm_th;
+	u32 fifo_max_depth;
+	u32 fifo_room_mask;
+	u32 fifo_room_shift;
+	u32 grc_reg_offset;
 };
 
 #define BNXT_QPLIB_DBR_PF_DB_OFFSET     0x10000
@@ -271,6 +283,7 @@ struct bnxt_qplib_res {
 	struct mutex                    dpi_tbl_lock;
 	bool				prio;
 	bool                            is_vf;
+	struct bnxt_qplib_db_pacing_data *pacing_data;
 };
 
 static inline bool bnxt_qplib_is_chip_gen_p5(struct bnxt_qplib_chip_ctx *cctx)
@@ -467,4 +480,10 @@ static inline bool _is_ext_stats_supported(u16 dev_cap_flags)
 	return dev_cap_flags &
 		CREQ_QUERY_FUNC_RESP_SB_EXT_STATS;
 }
+
+static inline u8 bnxt_qplib_dbr_pacing_en(struct bnxt_qplib_chip_ctx *cctx)
+{
+	return cctx->modes.dbr_pacing;
+}
+
 #endif /* __BNXT_QPLIB_RES_H__ */
-- 
2.40.1



