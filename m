Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F787A3A3B
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbjIQUAd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240333AbjIQUAI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:00:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C3A137
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:59:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E94C433C9;
        Sun, 17 Sep 2023 19:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980798;
        bh=LHNhq0kQXkqoZiGllh9IGmB4AvbAEg8PgHM6MDLzwNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LGL3VLU1TGoP66m549hZ3Tx17aHi4Jzhy3lukbVLQv+gBUQM6ljpnvVZTWBTa9c0S
         piL05NNzPw/ZdPcq7lcHGuU1E2fR5WPyY2q99xgXEaYgMQhYGZsKfCwYpG8YTS1bR/
         ZDwV5c1qXAA6+Ul7Z+3Ce8bU3W5jHx9s/+U1XiCE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Quinn Tran <qutran@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 011/219] scsi: qla2xxx: Adjust IOCB resource on qpair create
Date:   Sun, 17 Sep 2023 21:12:18 +0200
Message-ID: <20230917191041.390007910@linuxfoundation.org>
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

commit efa74a62aaa2429c04fe6cb277b3bf6739747d86 upstream.

During NVMe queue creation, a new qpair is created. FW resource limit needs
to be re-adjusted to take into account the new qpair. Otherwise, NVMe
command can not go through.  This issue was discovered while
testing/forcing FW execution to fail at load time.

Add call to readjust IOCB and exchange limit.

In addition, get FW state command and require FW to be running. Otherwise,
error is generated.

Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230714070104.40052-3-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_gbl.h  |    1 
 drivers/scsi/qla2xxx/qla_init.c |   52 +++++++++++++++++++++++++---------------
 drivers/scsi/qla2xxx/qla_mbx.c  |    3 ++
 drivers/scsi/qla2xxx/qla_nvme.c |    1 
 4 files changed, 38 insertions(+), 19 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -143,6 +143,7 @@ void qla_edif_sess_down(struct scsi_qla_
 void qla_edif_clear_appdata(struct scsi_qla_host *vha,
 			    struct fc_port *fcport);
 const char *sc_to_str(uint16_t cmd);
+void qla_adjust_iocb_limit(scsi_qla_host_t *vha);
 
 /*
  * Global Data in qla_os.c source file.
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4148,41 +4148,55 @@ out:
 	return ha->flags.lr_detected;
 }
 
-void qla_init_iocb_limit(scsi_qla_host_t *vha)
+static void __qla_adjust_iocb_limit(struct qla_qpair *qpair)
 {
-	u16 i, num_qps;
-	u32 limit;
-	struct qla_hw_data *ha = vha->hw;
+	u8 num_qps;
+	u16 limit;
+	struct qla_hw_data *ha = qpair->vha->hw;
 
 	num_qps = ha->num_qpairs + 1;
 	limit = (ha->orig_fw_iocb_count * QLA_IOCB_PCT_LIMIT) / 100;
 
-	ha->base_qpair->fwres.iocbs_total = ha->orig_fw_iocb_count;
-	ha->base_qpair->fwres.iocbs_limit = limit;
-	ha->base_qpair->fwres.iocbs_qp_limit = limit / num_qps;
-	ha->base_qpair->fwres.iocbs_used = 0;
+	qpair->fwres.iocbs_total = ha->orig_fw_iocb_count;
+	qpair->fwres.iocbs_limit = limit;
+	qpair->fwres.iocbs_qp_limit = limit / num_qps;
+
+	qpair->fwres.exch_total = ha->orig_fw_xcb_count;
+	qpair->fwres.exch_limit = (ha->orig_fw_xcb_count *
+				   QLA_IOCB_PCT_LIMIT) / 100;
+}
 
-	ha->base_qpair->fwres.exch_total = ha->orig_fw_xcb_count;
-	ha->base_qpair->fwres.exch_limit = (ha->orig_fw_xcb_count *
-					    QLA_IOCB_PCT_LIMIT) / 100;
+void qla_init_iocb_limit(scsi_qla_host_t *vha)
+{
+	u8 i;
+	struct qla_hw_data *ha = vha->hw;
+
+	 __qla_adjust_iocb_limit(ha->base_qpair);
+	ha->base_qpair->fwres.iocbs_used = 0;
 	ha->base_qpair->fwres.exch_used  = 0;
 
 	for (i = 0; i < ha->max_qpairs; i++) {
 		if (ha->queue_pair_map[i])  {
-			ha->queue_pair_map[i]->fwres.iocbs_total =
-				ha->orig_fw_iocb_count;
-			ha->queue_pair_map[i]->fwres.iocbs_limit = limit;
-			ha->queue_pair_map[i]->fwres.iocbs_qp_limit =
-				limit / num_qps;
+			__qla_adjust_iocb_limit(ha->queue_pair_map[i]);
 			ha->queue_pair_map[i]->fwres.iocbs_used = 0;
-			ha->queue_pair_map[i]->fwres.exch_total = ha->orig_fw_xcb_count;
-			ha->queue_pair_map[i]->fwres.exch_limit =
-				(ha->orig_fw_xcb_count * QLA_IOCB_PCT_LIMIT) / 100;
 			ha->queue_pair_map[i]->fwres.exch_used = 0;
 		}
 	}
 }
 
+void qla_adjust_iocb_limit(scsi_qla_host_t *vha)
+{
+	u8 i;
+	struct qla_hw_data *ha = vha->hw;
+
+	__qla_adjust_iocb_limit(ha->base_qpair);
+
+	for (i = 0; i < ha->max_qpairs; i++) {
+		if (ha->queue_pair_map[i])
+			__qla_adjust_iocb_limit(ha->queue_pair_map[i]);
+	}
+}
+
 /**
  * qla2x00_setup_chip() - Load and start RISC firmware.
  * @vha: HA context
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -2213,6 +2213,9 @@ qla2x00_get_firmware_state(scsi_qla_host
 	ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x1054,
 	    "Entered %s.\n", __func__);
 
+	if (!ha->flags.fw_started)
+		return QLA_FUNCTION_FAILED;
+
 	mcp->mb[0] = MBC_GET_FIRMWARE_STATE;
 	mcp->out_mb = MBX_0;
 	if (IS_FWI2_CAPABLE(vha->hw))
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -132,6 +132,7 @@ static int qla_nvme_alloc_queue(struct n
 			       "Failed to allocate qpair\n");
 			return -EINVAL;
 		}
+		qla_adjust_iocb_limit(vha);
 	}
 	*handle = qpair;
 


