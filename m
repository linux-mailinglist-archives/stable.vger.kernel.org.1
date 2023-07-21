Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95AE75CA59
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjGUOnE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjGUOmc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:42:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664782D7B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:42:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF66761CB8
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC61C433C8;
        Fri, 21 Jul 2023 14:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689950550;
        bh=h0NCSq3y8LV2l3lQ0a2evImZ6DzR9Ws4D1m0r1h63II=;
        h=Subject:To:Cc:From:Date:From;
        b=o/5srGJbAaz3GaSfAa3rCv8jdXlU+toWDT/U1po0utDzH78iqSPXKoKqspD+91z51
         aCO2QrIZiV7MIRBMfwVH2WEIedZ3GHd3Ul/DV3Cj1EI7Uyq69KdWkWhBVbEQzQxX0A
         b+Hy8DtzPCjYk7kM4CE5Ly9YTUSzRqk+dAcTAMxU=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Fix mem access after free" failed to apply to 5.4-stable tree
To:     qutran@marvell.com, himanshu.madhani@oracle.com,
        martin.petersen@oracle.com, njavali@marvell.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:42:26 +0200
Message-ID: <2023072125-educator-unroll-251d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x b843adde8d490934d042fbe9e3e46697cb3a64d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072125-educator-unroll-251d@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

b843adde8d49 ("scsi: qla2xxx: Fix mem access after free")
d3affdeb400f ("scsi: qla2xxx: Synchronize the IOCB count to be in order")
c39587bc0aba ("scsi: qla2xxx: Fix crash due to stale SRB access around I/O timeouts")
5597616333ea ("scsi: qla2xxx: Stop using the SCSI pointer")
79e30b884a01 ("scsi: qla2xxx: Call scsi_done() directly")
e56b2234ab64 ("scsi: qla2xxx: Open-code qla2xxx_eh_target_reset()")
622299f16f33 ("scsi: qla2xxx: Simplify return value logic in qla2x00_get_sp_from_handle()")
f45bca8c5052 ("scsi: qla2xxx: Fix double scsi_done for abort path")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b843adde8d490934d042fbe9e3e46697cb3a64d2 Mon Sep 17 00:00:00 2001
From: Quinn Tran <qutran@marvell.com>
Date: Fri, 28 Apr 2023 00:53:37 -0700
Subject: [PATCH] scsi: qla2xxx: Fix mem access after free

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

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index f3107508cf12..a07c010b0843 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1862,9 +1862,9 @@ qla2x00_process_completed_request(struct scsi_qla_host *vha,
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
@@ -1899,12 +1899,25 @@ qla2x00_get_sp_from_handle(scsi_qla_host_t *vha, const char *func,
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
@@ -3237,13 +3250,13 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
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
 
@@ -3514,6 +3527,9 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
 
 	if (rsp->status_srb == NULL)
 		sp->done(sp, res);
+
+	/* for io's, clearing of outstanding_cmds[handle] means scsi_done was called */
+	req->outstanding_cmds[handle] = NULL;
 }
 
 /**
@@ -3590,6 +3606,7 @@ qla2x00_error_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, sts_entry_t *pkt)
 	uint16_t que = MSW(pkt->handle);
 	struct req_que *req = NULL;
 	int res = DID_ERROR << 16;
+	u16 index;
 
 	ql_dbg(ql_dbg_async, vha, 0x502a,
 	    "iocb type %xh with error status %xh, handle %xh, rspq id %d\n",
@@ -3608,7 +3625,6 @@ qla2x00_error_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, sts_entry_t *pkt)
 
 	switch (pkt->entry_type) {
 	case NOTIFY_ACK_TYPE:
-	case STATUS_TYPE:
 	case STATUS_CONT_TYPE:
 	case LOGINOUT_PORT_IOCB_TYPE:
 	case CT_IOCB_TYPE:
@@ -3628,6 +3644,14 @@ qla2x00_error_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, sts_entry_t *pkt)
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
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 2fa695bf38b7..bc89d3da8fd0 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1078,43 +1078,6 @@ qla2xxx_mqueuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd,
 	return 0;
 }
 
-/*
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
 /*
  * qla2x00_wait_for_hba_online
  *    Wait till the HBA is online after going through
@@ -1365,6 +1328,9 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 	return ret;
 }
 
+#define ABORT_POLLING_PERIOD	1000
+#define ABORT_WAIT_ITER		((2 * 1000) / (ABORT_POLLING_PERIOD))
+
 /*
  * Returns: QLA_SUCCESS or QLA_FUNCTION_FAILED.
  */
@@ -1378,41 +1344,73 @@ __qla2x00_eh_wait_for_pending_commands(struct qla_qpair *qpair, unsigned int t,
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

