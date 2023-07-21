Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD79175D4E9
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjGUT0X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjGUT0W (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:26:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DA33A8C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:26:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A7DC61D54
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A11FC433C8;
        Fri, 21 Jul 2023 19:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967571;
        bh=qlPA7nfpvlr99e/BI0As2nZAP7elgOKmFNP43REm+DE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mvdo67zWnHpTH+H0uPO0whBAHgRJHu4m8v+xpiOCSm+4ryJgA4+uKbHDsGf2CvhJD
         D6ygMFDE2wzqFuq0Vyy7OYQ+kgknzAmBHvmIdtB50pc3wiqK0HhD0feyBVYnq0m+oN
         /AoBUW5WCeap/IpinQi2i2SfkBgPaAhS/VVCfWAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Quinn Tran <qutran@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 210/223] scsi: qla2xxx: Fix mem access after free
Date:   Fri, 21 Jul 2023 18:07:43 +0200
Message-ID: <20230721160529.826416484@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

commit b843adde8d490934d042fbe9e3e46697cb3a64d2 upstream.

System crash, where driver is accessing scsi layer's
memory (scsi_cmnd->device->host) to search for a well known internal
pointer (vha). The scsi_cmnd was released back to upper layer which
could be freed, but the driver is still accessing it.

7 [ffffa8e8d2c3f8d0] page_fault at ffffffff86c010fe
  [exception RIP: __qla2x00_eh_wait_for_pending_commands+240]
  RIP: ffffffffc0642350  RSP: ffffa8e8d2c3f988  RFLAGS: 00010286
  RAX: 0000000000000165  RBX: 0000000000000002  RCX: 00000000000036d8
  RDX: 0000000000000000  RSI: ffff9c5c56535188  RDI: 0000000000000286
  RBP: ffff9c5bf7aa4a58   R8: ffff9c589aecdb70   R9: 00000000000003d1
  R10: 0000000000000001  R11: 0000000000380000 R12: ffff9c5c5392bc78
  R13: ffff9c57044ff5c0 R14: ffff9c56b5a3aa00  R15: 00000000000006db
  ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
8 [ffffa8e8d2c3f9c8] qla2x00_eh_wait_for_pending_commands at ffffffffc0646dd5 [qla2xxx]
9 [ffffa8e8d2c3fa00] __qla2x00_async_tm_cmd at ffffffffc0658094 [qla2xxx]

Remove access of freed memory. Currently the driver was checking to see if
scsi_done was called by seeing if the sp->type has changed. Instead,
check to see if the command has left the  oustanding_cmds[] array as
sign of scsi_done was called.

Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230428075339.32551-6-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_isr.c |   38 +++++++++--
 drivers/scsi/qla2xxx/qla_os.c  |  130 ++++++++++++++++++++---------------------
 2 files changed, 95 insertions(+), 73 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1862,9 +1862,9 @@ qla2x00_process_completed_request(struct
 	}
 }
 
-srb_t *
-qla2x00_get_sp_from_handle(scsi_qla_host_t *vha, const char *func,
-    struct req_que *req, void *iocb)
+static srb_t *
+qla_get_sp_from_handle(scsi_qla_host_t *vha, const char *func,
+		       struct req_que *req, void *iocb, u16 *ret_index)
 {
 	struct qla_hw_data *ha = vha->hw;
 	sts_entry_t *pkt = iocb;
@@ -1899,12 +1899,25 @@ qla2x00_get_sp_from_handle(scsi_qla_host
 		return NULL;
 	}
 
-	req->outstanding_cmds[index] = NULL;
-
+	*ret_index = index;
 	qla_put_fw_resources(sp->qpair, &sp->iores);
 	return sp;
 }
 
+srb_t *
+qla2x00_get_sp_from_handle(scsi_qla_host_t *vha, const char *func,
+			   struct req_que *req, void *iocb)
+{
+	uint16_t index;
+	srb_t *sp;
+
+	sp = qla_get_sp_from_handle(vha, func, req, iocb, &index);
+	if (sp)
+		req->outstanding_cmds[index] = NULL;
+
+	return sp;
+}
+
 static void
 qla2x00_mbx_iocb_entry(scsi_qla_host_t *vha, struct req_que *req,
     struct mbx_entry *mbx)
@@ -3237,13 +3250,13 @@ qla2x00_status_entry(scsi_qla_host_t *vh
 		return;
 	}
 
-	req->outstanding_cmds[handle] = NULL;
 	cp = GET_CMD_SP(sp);
 	if (cp == NULL) {
 		ql_dbg(ql_dbg_io, vha, 0x3018,
 		    "Command already returned (0x%x/%p).\n",
 		    sts->handle, sp);
 
+		req->outstanding_cmds[handle] = NULL;
 		return;
 	}
 
@@ -3514,6 +3527,9 @@ out:
 
 	if (rsp->status_srb == NULL)
 		sp->done(sp, res);
+
+	/* for io's, clearing of outstanding_cmds[handle] means scsi_done was called */
+	req->outstanding_cmds[handle] = NULL;
 }
 
 /**
@@ -3590,6 +3606,7 @@ qla2x00_error_entry(scsi_qla_host_t *vha
 	uint16_t que = MSW(pkt->handle);
 	struct req_que *req = NULL;
 	int res = DID_ERROR << 16;
+	u16 index;
 
 	ql_dbg(ql_dbg_async, vha, 0x502a,
 	    "iocb type %xh with error status %xh, handle %xh, rspq id %d\n",
@@ -3608,7 +3625,6 @@ qla2x00_error_entry(scsi_qla_host_t *vha
 
 	switch (pkt->entry_type) {
 	case NOTIFY_ACK_TYPE:
-	case STATUS_TYPE:
 	case STATUS_CONT_TYPE:
 	case LOGINOUT_PORT_IOCB_TYPE:
 	case CT_IOCB_TYPE:
@@ -3628,6 +3644,14 @@ qla2x00_error_entry(scsi_qla_host_t *vha
 	case CTIO_TYPE7:
 	case CTIO_CRC2:
 		return 1;
+	case STATUS_TYPE:
+		sp = qla_get_sp_from_handle(vha, func, req, pkt, &index);
+		if (sp) {
+			sp->done(sp, res);
+			req->outstanding_cmds[index] = NULL;
+			return 0;
+		}
+		break;
 	}
 fatal:
 	ql_log(ql_log_warn, vha, 0x5030,
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1069,43 +1069,6 @@ qc24_fail_command:
 }
 
 /*
- * qla2x00_eh_wait_on_command
- *    Waits for the command to be returned by the Firmware for some
- *    max time.
- *
- * Input:
- *    cmd = Scsi Command to wait on.
- *
- * Return:
- *    Completed in time : QLA_SUCCESS
- *    Did not complete in time : QLA_FUNCTION_FAILED
- */
-static int
-qla2x00_eh_wait_on_command(struct scsi_cmnd *cmd)
-{
-#define ABORT_POLLING_PERIOD	1000
-#define ABORT_WAIT_ITER		((2 * 1000) / (ABORT_POLLING_PERIOD))
-	unsigned long wait_iter = ABORT_WAIT_ITER;
-	scsi_qla_host_t *vha = shost_priv(cmd->device->host);
-	struct qla_hw_data *ha = vha->hw;
-	srb_t *sp = scsi_cmd_priv(cmd);
-	int ret = QLA_SUCCESS;
-
-	if (unlikely(pci_channel_offline(ha->pdev)) || ha->flags.eeh_busy) {
-		ql_dbg(ql_dbg_taskm, vha, 0x8005,
-		    "Return:eh_wait.\n");
-		return ret;
-	}
-
-	while (sp->type && wait_iter--)
-		msleep(ABORT_POLLING_PERIOD);
-	if (sp->type)
-		ret = QLA_FUNCTION_FAILED;
-
-	return ret;
-}
-
-/*
  * qla2x00_wait_for_hba_online
  *    Wait till the HBA is online after going through
  *    <= MAX_RETRIES_OF_ISP_ABORT  or
@@ -1355,6 +1318,9 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 	return ret;
 }
 
+#define ABORT_POLLING_PERIOD	1000
+#define ABORT_WAIT_ITER		((2 * 1000) / (ABORT_POLLING_PERIOD))
+
 /*
  * Returns: QLA_SUCCESS or QLA_FUNCTION_FAILED.
  */
@@ -1368,41 +1334,73 @@ __qla2x00_eh_wait_for_pending_commands(s
 	struct req_que *req = qpair->req;
 	srb_t *sp;
 	struct scsi_cmnd *cmd;
+	unsigned long wait_iter = ABORT_WAIT_ITER;
+	bool found;
+	struct qla_hw_data *ha = vha->hw;
 
 	status = QLA_SUCCESS;
 
-	spin_lock_irqsave(qpair->qp_lock_ptr, flags);
-	for (cnt = 1; status == QLA_SUCCESS &&
-		cnt < req->num_outstanding_cmds; cnt++) {
-		sp = req->outstanding_cmds[cnt];
-		if (!sp)
-			continue;
-		if (sp->type != SRB_SCSI_CMD)
-			continue;
-		if (vha->vp_idx != sp->vha->vp_idx)
-			continue;
-		match = 0;
-		cmd = GET_CMD_SP(sp);
-		switch (type) {
-		case WAIT_HOST:
-			match = 1;
-			break;
-		case WAIT_TARGET:
-			match = cmd->device->id == t;
-			break;
-		case WAIT_LUN:
-			match = (cmd->device->id == t &&
-				cmd->device->lun == l);
-			break;
-		}
-		if (!match)
-			continue;
+	while (wait_iter--) {
+		found = false;
 
-		spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
-		status = qla2x00_eh_wait_on_command(cmd);
 		spin_lock_irqsave(qpair->qp_lock_ptr, flags);
+		for (cnt = 1; cnt < req->num_outstanding_cmds; cnt++) {
+			sp = req->outstanding_cmds[cnt];
+			if (!sp)
+				continue;
+			if (sp->type != SRB_SCSI_CMD)
+				continue;
+			if (vha->vp_idx != sp->vha->vp_idx)
+				continue;
+			match = 0;
+			cmd = GET_CMD_SP(sp);
+			switch (type) {
+			case WAIT_HOST:
+				match = 1;
+				break;
+			case WAIT_TARGET:
+				if (sp->fcport)
+					match = sp->fcport->d_id.b24 == t;
+				else
+					match = 0;
+				break;
+			case WAIT_LUN:
+				if (sp->fcport)
+					match = (sp->fcport->d_id.b24 == t &&
+						cmd->device->lun == l);
+				else
+					match = 0;
+				break;
+			}
+			if (!match)
+				continue;
+
+			spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
+
+			if (unlikely(pci_channel_offline(ha->pdev)) ||
+			    ha->flags.eeh_busy) {
+				ql_dbg(ql_dbg_taskm, vha, 0x8005,
+				    "Return:eh_wait.\n");
+				return status;
+			}
+
+			/*
+			 * SRB_SCSI_CMD is still in the outstanding_cmds array.
+			 * it means scsi_done has not called. Wait for it to
+			 * clear from outstanding_cmds.
+			 */
+			msleep(ABORT_POLLING_PERIOD);
+			spin_lock_irqsave(qpair->qp_lock_ptr, flags);
+			found = true;
+		}
+		spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
+
+		if (!found)
+			break;
 	}
-	spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
+
+	if (!wait_iter && found)
+		status = QLA_FUNCTION_FAILED;
 
 	return status;
 }


