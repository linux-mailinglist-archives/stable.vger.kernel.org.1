Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFBD7A3A3C
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbjIQUAd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240339AbjIQUAM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:00:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C5B189
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:00:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B34AC433C7;
        Sun, 17 Sep 2023 20:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980801;
        bh=9h9qE0TW181oOS/FPkxaWsy2AvZw/SE6GMybpmmccKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ic2qgCOF6L/0TnG683+8NhGe/MzWDHPF+0Jds1Ku/MvEBbfK620movll6g2M4xtaI
         aPAKsezuhxOHLm4aetAZfqdjUmWYeCOa80YJWehvuI7sFhZS11AvweuDLzJ1LI4Gf3
         Y5CWYT0IzBLzBAo+uS49SBDPpsHPb9AofHY9/zHI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Quinn Tran <qutran@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 012/219] scsi: qla2xxx: Limit TMF to 8 per function
Date:   Sun, 17 Sep 2023 21:12:19 +0200
Message-ID: <20230917191041.424933178@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <qutran@marvell.com>

commit a8ec192427e0516436e61f9ca9eb49c54eadfe0a upstream.

Per FW recommendation, 8 TMF's can be outstanding for each
function. Previously, it allowed 8 per target.

Limit TMF to 8 per function.

Cc: stable@vger.kernel.org
Fixes: 6a87679626b5 ("scsi: qla2xxx: Fix task management cmd fail due to unavailable resource")
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230714070104.40052-4-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_def.h  |    9 +++---
 drivers/scsi/qla2xxx/qla_init.c |   55 ++++++++++++++++++++++++----------------
 drivers/scsi/qla2xxx/qla_os.c   |    2 +
 3 files changed, 41 insertions(+), 25 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -458,6 +458,7 @@ static inline be_id_t port_id_to_be_id(p
 }
 
 struct tmf_arg {
+	struct list_head tmf_elem;
 	struct qla_qpair *qpair;
 	struct fc_port *fcport;
 	struct scsi_qla_host *vha;
@@ -2534,7 +2535,6 @@ enum rscn_addr_format {
 typedef struct fc_port {
 	struct list_head list;
 	struct scsi_qla_host *vha;
-	struct list_head tmf_pending;
 
 	unsigned int conf_compl_supported:1;
 	unsigned int deleted:2;
@@ -2555,9 +2555,6 @@ typedef struct fc_port {
 	unsigned int do_prli_nvme:1;
 
 	uint8_t nvme_flag;
-	uint8_t active_tmf;
-#define MAX_ACTIVE_TMF 8
-
 	uint8_t node_name[WWN_SIZE];
 	uint8_t port_name[WWN_SIZE];
 	port_id_t d_id;
@@ -4640,6 +4637,8 @@ struct qla_hw_data {
 		uint32_t	flt_region_aux_img_status_sec;
 	};
 	uint8_t         active_image;
+	uint8_t active_tmf;
+#define MAX_ACTIVE_TMF 8
 
 	/* Needed for BEACON */
 	uint16_t        beacon_blink_led;
@@ -4654,6 +4653,8 @@ struct qla_hw_data {
 
 	struct qla_msix_entry *msix_entries;
 
+	struct list_head tmf_pending;
+	struct list_head tmf_active;
 	struct list_head        vp_list;        /* list of VP */
 	unsigned long   vp_idx_map[(MAX_MULTI_ID_FABRIC / 8) /
 			sizeof(unsigned long)];
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2187,30 +2187,42 @@ done:
 	return rval;
 }
 
-static void qla_put_tmf(fc_port_t *fcport)
+static void qla_put_tmf(struct tmf_arg *arg)
 {
-	struct scsi_qla_host *vha = fcport->vha;
+	struct scsi_qla_host *vha = arg->vha;
 	struct qla_hw_data *ha = vha->hw;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
-	fcport->active_tmf--;
+	ha->active_tmf--;
+	list_del(&arg->tmf_elem);
 	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
 }
 
 static
-int qla_get_tmf(fc_port_t *fcport)
+int qla_get_tmf(struct tmf_arg *arg)
 {
-	struct scsi_qla_host *vha = fcport->vha;
+	struct scsi_qla_host *vha = arg->vha;
 	struct qla_hw_data *ha = vha->hw;
 	unsigned long flags;
+	fc_port_t *fcport = arg->fcport;
 	int rc = 0;
-	LIST_HEAD(tmf_elem);
+	struct tmf_arg *t;
 
 	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
-	list_add_tail(&tmf_elem, &fcport->tmf_pending);
+	list_for_each_entry(t, &ha->tmf_active, tmf_elem) {
+		if (t->fcport == arg->fcport && t->lun == arg->lun) {
+			/* reject duplicate TMF */
+			ql_log(ql_log_warn, vha, 0x802c,
+			       "found duplicate TMF.  Nexus=%ld:%06x:%llu.\n",
+			       vha->host_no, fcport->d_id.b24, arg->lun);
+			spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
+			return -EINVAL;
+		}
+	}
 
-	while (fcport->active_tmf >= MAX_ACTIVE_TMF) {
+	list_add_tail(&arg->tmf_elem, &ha->tmf_pending);
+	while (ha->active_tmf >= MAX_ACTIVE_TMF) {
 		spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
 
 		msleep(1);
@@ -2222,15 +2234,17 @@ int qla_get_tmf(fc_port_t *fcport)
 			rc = EIO;
 			break;
 		}
-		if (fcport->active_tmf < MAX_ACTIVE_TMF &&
-		    list_is_first(&tmf_elem, &fcport->tmf_pending))
+		if (ha->active_tmf < MAX_ACTIVE_TMF &&
+		    list_is_first(&arg->tmf_elem, &ha->tmf_pending))
 			break;
 	}
 
-	list_del(&tmf_elem);
+	list_del(&arg->tmf_elem);
 
-	if (!rc)
-		fcport->active_tmf++;
+	if (!rc) {
+		ha->active_tmf++;
+		list_add_tail(&arg->tmf_elem, &ha->tmf_active);
+	}
 
 	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
 
@@ -2252,15 +2266,18 @@ qla2x00_async_tm_cmd(fc_port_t *fcport,
 	a.vha = fcport->vha;
 	a.fcport = fcport;
 	a.lun = lun;
+	a.flags = flags;
+	INIT_LIST_HEAD(&a.tmf_elem);
+
 	if (flags & (TCF_LUN_RESET|TCF_ABORT_TASK_SET|TCF_CLEAR_TASK_SET|TCF_CLEAR_ACA)) {
 		a.modifier = MK_SYNC_ID_LUN;
-
-		if (qla_get_tmf(fcport))
-			return QLA_FUNCTION_FAILED;
 	} else {
 		a.modifier = MK_SYNC_ID;
 	}
 
+	if (qla_get_tmf(&a))
+		return QLA_FUNCTION_FAILED;
+
 	if (vha->hw->mqenable) {
 		for (i = 0; i < vha->hw->num_qpairs; i++) {
 			qpair = vha->hw->queue_pair_map[i];
@@ -2286,13 +2303,10 @@ qla2x00_async_tm_cmd(fc_port_t *fcport,
 		goto bailout;
 
 	a.qpair = vha->hw->base_qpair;
-	a.flags = flags;
 	rval = __qla2x00_async_tm_cmd(&a);
 
 bailout:
-	if (a.modifier == MK_SYNC_ID_LUN)
-		qla_put_tmf(fcport);
-
+	qla_put_tmf(&a);
 	return rval;
 }
 
@@ -5542,7 +5556,6 @@ qla2x00_alloc_fcport(scsi_qla_host_t *vh
 	INIT_WORK(&fcport->reg_work, qla_register_fcport_fn);
 	INIT_LIST_HEAD(&fcport->gnl_entry);
 	INIT_LIST_HEAD(&fcport->list);
-	INIT_LIST_HEAD(&fcport->tmf_pending);
 
 	INIT_LIST_HEAD(&fcport->sess_cmd_list);
 	spin_lock_init(&fcport->sess_cmd_lock);
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3002,6 +3002,8 @@ qla2x00_probe_one(struct pci_dev *pdev,
 	atomic_set(&ha->num_pend_mbx_stage3, 0);
 	atomic_set(&ha->zio_threshold, DEFAULT_ZIO_THRESHOLD);
 	ha->last_zio_threshold = DEFAULT_ZIO_THRESHOLD;
+	INIT_LIST_HEAD(&ha->tmf_pending);
+	INIT_LIST_HEAD(&ha->tmf_active);
 
 	/* Assign ISP specific operations. */
 	if (IS_QLA2100(ha)) {


