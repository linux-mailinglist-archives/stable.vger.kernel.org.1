Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32E67A391D
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239957AbjIQTpG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240004AbjIQTos (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:44:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7298E188
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:44:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9207AC433C9;
        Sun, 17 Sep 2023 19:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979881;
        bh=StxbqKyCjYxEH9RAq1oFLfqYH5QV5LqhSJpa8JSOjTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u/Re2Yax5tOGLoHjilzUklNw7wAI4mwlj3DzEirKx9n77ODbn1Sq2Lwkn9/siGNxM
         H2vHJCH0pK6KVucAEIRdrn9pRiEZyI/JwC621ZFplQdCh/obtplfG/BHNWgMoX6obh
         7DceqLyLTrXjUQQ5LD/CBoYVtSmhQ/O57ACTvxAc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Quinn Tran <qutran@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.5 008/285] scsi: qla2xxx: Fix command flush during TMF
Date:   Sun, 17 Sep 2023 21:10:08 +0200
Message-ID: <20230917191051.914126609@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <qutran@marvell.com>

commit da7c21b72aa86e990af5f73bce6590b8d8d148d0 upstream.

For each TMF request, driver iterates through each qpair and flushes
commands associated to the TMF. At the end of the qpair flush, a Marker is
used to complete the flush transaction. This process was repeated for each
qpair. The multiple flush and marker for this TMF request seems to cause
confusion for FW.

Instead, 1 flush is sent to FW. Driver would wait for FW to go through all
the I/Os on each qpair to be read then return. Driver then closes out the
transaction with a Marker.

Cc: stable@vger.kernel.org
Fixes: d90171dd0da5 ("scsi: qla2xxx: Multi-que support for TMF")
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230714070104.40052-5-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_init.c |   74 +++++++++++++++++++++-------------------
 drivers/scsi/qla2xxx/qla_iocb.c |    1 
 drivers/scsi/qla2xxx/qla_os.c   |    9 ++--
 3 files changed, 45 insertions(+), 39 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2002,12 +2002,11 @@ qla2x00_tmf_iocb_timeout(void *data)
 	int rc, h;
 	unsigned long flags;
 
-	if (sp->type == SRB_MARKER) {
-		complete(&tmf->u.tmf.comp);
-		return;
-	}
+	if (sp->type == SRB_MARKER)
+		rc = QLA_FUNCTION_FAILED;
+	else
+		rc = qla24xx_async_abort_cmd(sp, false);
 
-	rc = qla24xx_async_abort_cmd(sp, false);
 	if (rc) {
 		spin_lock_irqsave(sp->qpair->qp_lock_ptr, flags);
 		for (h = 1; h < sp->qpair->req->num_outstanding_cmds; h++) {
@@ -2129,6 +2128,17 @@ static void qla2x00_tmf_sp_done(srb_t *s
 	complete(&tmf->u.tmf.comp);
 }
 
+static int qla_tmf_wait(struct tmf_arg *arg)
+{
+	/* there are only 2 types of error handling that reaches here, lun or target reset */
+	if (arg->flags & (TCF_LUN_RESET | TCF_ABORT_TASK_SET | TCF_CLEAR_TASK_SET))
+		return qla2x00_eh_wait_for_pending_commands(arg->vha,
+		    arg->fcport->d_id.b24, arg->lun, WAIT_LUN);
+	else
+		return qla2x00_eh_wait_for_pending_commands(arg->vha,
+		    arg->fcport->d_id.b24, arg->lun, WAIT_TARGET);
+}
+
 static int
 __qla2x00_async_tm_cmd(struct tmf_arg *arg)
 {
@@ -2136,8 +2146,9 @@ __qla2x00_async_tm_cmd(struct tmf_arg *a
 	struct srb_iocb *tm_iocb;
 	srb_t *sp;
 	int rval = QLA_FUNCTION_FAILED;
-
 	fc_port_t *fcport = arg->fcport;
+	u32 chip_gen, login_gen;
+	u64 jif;
 
 	if (TMF_NOT_READY(arg->fcport)) {
 		ql_dbg(ql_dbg_taskm, vha, 0x8032,
@@ -2182,8 +2193,27 @@ __qla2x00_async_tm_cmd(struct tmf_arg *a
 		    "TM IOCB failed (%x).\n", rval);
 	}
 
-	if (!test_bit(UNLOADING, &vha->dpc_flags) && !IS_QLAFX00(vha->hw))
-		rval = qla26xx_marker(arg);
+	if (!test_bit(UNLOADING, &vha->dpc_flags) && !IS_QLAFX00(vha->hw)) {
+		chip_gen = vha->hw->chip_reset;
+		login_gen = fcport->login_gen;
+
+		jif = jiffies;
+		if (qla_tmf_wait(arg)) {
+			ql_log(ql_log_info, vha, 0x803e,
+			       "Waited %u ms Nexus=%ld:%06x:%llu.\n",
+			       jiffies_to_msecs(jiffies - jif), vha->host_no,
+			       fcport->d_id.b24, arg->lun);
+		}
+
+		if (chip_gen == vha->hw->chip_reset && login_gen == fcport->login_gen) {
+			rval = qla26xx_marker(arg);
+		} else {
+			ql_log(ql_log_info, vha, 0x803e,
+			       "Skip Marker due to disruption. Nexus=%ld:%06x:%llu.\n",
+			       vha->host_no, fcport->d_id.b24, arg->lun);
+			rval = QLA_FUNCTION_FAILED;
+		}
+	}
 
 done_free_sp:
 	/* ref: INIT */
@@ -2261,9 +2291,8 @@ qla2x00_async_tm_cmd(fc_port_t *fcport,
 		     uint32_t tag)
 {
 	struct scsi_qla_host *vha = fcport->vha;
-	struct qla_qpair *qpair;
 	struct tmf_arg a;
-	int i, rval = QLA_SUCCESS;
+	int rval = QLA_SUCCESS;
 
 	if (TMF_NOT_READY(fcport))
 		return QLA_SUSPENDED;
@@ -2283,34 +2312,9 @@ qla2x00_async_tm_cmd(fc_port_t *fcport,
 	if (qla_get_tmf(&a))
 		return QLA_FUNCTION_FAILED;
 
-	if (vha->hw->mqenable) {
-		for (i = 0; i < vha->hw->num_qpairs; i++) {
-			qpair = vha->hw->queue_pair_map[i];
-			if (!qpair)
-				continue;
-
-			if (TMF_NOT_READY(fcport)) {
-				ql_log(ql_log_warn, vha, 0x8026,
-				    "Unable to send TM due to disruption.\n");
-				rval = QLA_SUSPENDED;
-				break;
-			}
-
-			a.qpair = qpair;
-			a.flags = flags|TCF_NOTMCMD_TO_TARGET;
-			rval = __qla2x00_async_tm_cmd(&a);
-			if (rval)
-				break;
-		}
-	}
-
-	if (rval)
-		goto bailout;
-
 	a.qpair = vha->hw->base_qpair;
 	rval = __qla2x00_async_tm_cmd(&a);
 
-bailout:
 	qla_put_tmf(&a);
 	return rval;
 }
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -3882,6 +3882,7 @@ qla_marker_iocb(srb_t *sp, struct mrk_en
 {
 	mrk->entry_type = MARKER_TYPE;
 	mrk->modifier = sp->u.iocb_cmd.u.tmf.modifier;
+	mrk->handle = make_handle(sp->qpair->req->id, sp->handle);
 	if (sp->u.iocb_cmd.u.tmf.modifier != MK_SYNC_ALL) {
 		mrk->nport_handle = cpu_to_le16(sp->u.iocb_cmd.u.tmf.loop_id);
 		int_to_scsilun(sp->u.iocb_cmd.u.tmf.lun, (struct scsi_lun *)&mrk->lun);
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1488,8 +1488,9 @@ qla2xxx_eh_device_reset(struct scsi_cmnd
 		goto eh_reset_failed;
 	}
 	err = 3;
-	if (qla2x00_eh_wait_for_pending_commands(vha, sdev->id,
-	    sdev->lun, WAIT_LUN) != QLA_SUCCESS) {
+	if (qla2x00_eh_wait_for_pending_commands(vha, fcport->d_id.b24,
+						 cmd->device->lun,
+						 WAIT_LUN) != QLA_SUCCESS) {
 		ql_log(ql_log_warn, vha, 0x800d,
 		    "wait for pending cmds failed for cmd=%p.\n", cmd);
 		goto eh_reset_failed;
@@ -1555,8 +1556,8 @@ qla2xxx_eh_target_reset(struct scsi_cmnd
 		goto eh_reset_failed;
 	}
 	err = 3;
-	if (qla2x00_eh_wait_for_pending_commands(vha, sdev->id,
-	    0, WAIT_TARGET) != QLA_SUCCESS) {
+	if (qla2x00_eh_wait_for_pending_commands(vha, fcport->d_id.b24, 0,
+						 WAIT_TARGET) != QLA_SUCCESS) {
 		ql_log(ql_log_warn, vha, 0x800d,
 		    "wait for pending cmds failed for cmd=%p.\n", cmd);
 		goto eh_reset_failed;


