Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2269D75CA51
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjGUOme (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjGUOmG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:42:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2E430C7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:42:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D654461CB8
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C6FC433C8;
        Fri, 21 Jul 2023 14:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689950524;
        bh=fY2zNBqYtzXEIMhYwvzEqiHtae5I3uzjhFaWpjQENhk=;
        h=Subject:To:Cc:From:Date:From;
        b=w4PDYZ5tEXH5cEtJ5fjTeeIxSExGToHGiuwEA3KNEBwoaW+Gb+laAUpKXFFenlp4L
         jyZnMPUT1lQ3Ze2ELajuPhsdBL4p9T+veYe2HOg/BJzbcAo9mZoqmN3tNBKfBJfZHi
         cSH+2/BuylHtOH3NPQrnaPJP4ihgEakXSSSsdUZM=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Fix hang in task management" failed to apply to 4.19-stable tree
To:     qutran@marvell.com, himanshu.madhani@oracle.com,
        martin.petersen@oracle.com, njavali@marvell.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:41:51 +0200
Message-ID: <2023072151-obituary-jimmy-5eb3@gregkh>
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


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 9ae615c5bfd37bd091772969b1153de5335ea986
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072151-obituary-jimmy-5eb3@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

9ae615c5bfd3 ("scsi: qla2xxx: Fix hang in task management")
6a87679626b5 ("scsi: qla2xxx: Fix task management cmd fail due to unavailable resource")
9803fb5d2759 ("scsi: qla2xxx: Fix task management cmd failure")
d90171dd0da5 ("scsi: qla2xxx: Multi-que support for TMF")
5f63a163ed2f ("scsi: qla2xxx: Fix exchange oversubscription for management commands")
41e5afe51f75 ("scsi: qla2xxx: Fix exchange oversubscription")
68ad83188d78 ("scsi: qla2xxx: Fix crash when I/O abort times out")
1b80addaae09 ("scsi: qla2xxx: Remove unused declarations for qla2xxx")
f12d2d130efc ("scsi: qla2xxx: Add debug prints in the device remove path")
118b0c863c8f ("scsi: qla2xxx: Fix losing target when it reappears during delete")
63ab6cb582fa ("scsi: qla2xxx: edif: Fix I/O timeout due to over-subscription")
c02aada06d19 ("scsi: qla2xxx: Fix hang due to session stuck")
31e6cdbe0eae ("scsi: qla2xxx: Implement ref count for SRB")
d4523bd6fd5d ("scsi: qla2xxx: Refactor asynchronous command initialization")
91f6f5fbe87b ("scsi: qla2xxx: edif: Reduce connection thrash")
bb2ca6b3f09a ("scsi: qla2xxx: Relogin during fabric disturbance")
7a8ff7d9854a ("scsi: qla2xxx: Fix NVMe session down detection")
2cabf10dbbe3 ("scsi: qla2xxx: Fix hang on NVMe command timeouts")
225479296c4f ("scsi: qla2xxx: edif: Reject AUTH ELS on session down")
44c57f205876 ("scsi: qla2xxx: Changes to support FCP2 Target")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9ae615c5bfd37bd091772969b1153de5335ea986 Mon Sep 17 00:00:00 2001
From: Quinn Tran <qutran@marvell.com>
Date: Fri, 28 Apr 2023 00:53:36 -0700
Subject: [PATCH] scsi: qla2xxx: Fix hang in task management

Task management command hangs where a side
band chip reset failed to nudge the TMF
from it's current send path.

Add additional error check to block TMF
from entering during chip reset and along
the TMF path to cause it to bail out, skip
over abort of marker.

Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230428075339.32551-5-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index e345ccbff807..dfee3b41bdf1 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -5515,4 +5515,8 @@ struct ql_vnd_tgt_stats_resp {
 	_fp->disc_state, _fp->scan_state, _fp->loop_id, _fp->deleted, \
 	_fp->flags
 
+#define TMF_NOT_READY(_fcport) \
+	(!_fcport || IS_SESSION_DELETED(_fcport) || atomic_read(&_fcport->state) != FCS_ONLINE || \
+	!_fcport->vha->hw->flags.fw_started)
+
 #endif
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 84841edcd1b5..0df6eae7324e 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1996,6 +1996,11 @@ qla2x00_tmf_iocb_timeout(void *data)
 	int rc, h;
 	unsigned long flags;
 
+	if (sp->type == SRB_MARKER) {
+		complete(&tmf->u.tmf.comp);
+		return;
+	}
+
 	rc = qla24xx_async_abort_cmd(sp, false);
 	if (rc) {
 		spin_lock_irqsave(sp->qpair->qp_lock_ptr, flags);
@@ -2023,6 +2028,7 @@ static void qla_marker_sp_done(srb_t *sp, int res)
 		    sp->handle, sp->fcport->d_id.b24, sp->u.iocb_cmd.u.tmf.flags,
 		    sp->u.iocb_cmd.u.tmf.lun, sp->qpair->id);
 
+	sp->u.iocb_cmd.u.tmf.data = res;
 	complete(&tmf->u.tmf.comp);
 }
 
@@ -2039,6 +2045,11 @@ static void qla_marker_sp_done(srb_t *sp, int res)
 	} while (cnt); \
 }
 
+/**
+ * qla26xx_marker: send marker IOCB and wait for the completion of it.
+ * @arg: pointer to argument list.
+ *    It is assume caller will provide an fcport pointer and modifier
+ */
 static int
 qla26xx_marker(struct tmf_arg *arg)
 {
@@ -2048,6 +2059,14 @@ qla26xx_marker(struct tmf_arg *arg)
 	int rval = QLA_FUNCTION_FAILED;
 	fc_port_t *fcport = arg->fcport;
 
+	if (TMF_NOT_READY(arg->fcport)) {
+		ql_dbg(ql_dbg_taskm, vha, 0x8039,
+		    "FC port not ready for marker loop-id=%x portid=%06x modifier=%x lun=%lld qp=%d.\n",
+		    fcport->loop_id, fcport->d_id.b24,
+		    arg->modifier, arg->lun, arg->qpair->id);
+		return QLA_SUSPENDED;
+	}
+
 	/* ref: INIT */
 	sp = qla2xxx_get_qpair_sp(vha, arg->qpair, fcport, GFP_KERNEL);
 	if (!sp)
@@ -2074,11 +2093,19 @@ qla26xx_marker(struct tmf_arg *arg)
 
 	if (rval != QLA_SUCCESS) {
 		ql_log(ql_log_warn, vha, 0x8031,
-		    "Marker IOCB failed (%x).\n", rval);
+		    "Marker IOCB send failure (%x).\n", rval);
 		goto done_free_sp;
 	}
 
 	wait_for_completion(&tm_iocb->u.tmf.comp);
+	rval = tm_iocb->u.tmf.data;
+
+	if (rval != QLA_SUCCESS) {
+		ql_log(ql_log_warn, vha, 0x8019,
+		    "Marker failed hdl=%x loop-id=%x portid=%06x modifier=%x lun=%lld qp=%d rval %d.\n",
+		    sp->handle, fcport->loop_id, fcport->d_id.b24,
+		    arg->modifier, arg->lun, sp->qpair->id, rval);
+	}
 
 done_free_sp:
 	/* ref: INIT */
@@ -2091,6 +2118,8 @@ static void qla2x00_tmf_sp_done(srb_t *sp, int res)
 {
 	struct srb_iocb *tmf = &sp->u.iocb_cmd;
 
+	if (res)
+		tmf->u.tmf.data = res;
 	complete(&tmf->u.tmf.comp);
 }
 
@@ -2104,6 +2133,14 @@ __qla2x00_async_tm_cmd(struct tmf_arg *arg)
 
 	fc_port_t *fcport = arg->fcport;
 
+	if (TMF_NOT_READY(arg->fcport)) {
+		ql_dbg(ql_dbg_taskm, vha, 0x8032,
+		    "FC port not ready for TM command loop-id=%x portid=%06x modifier=%x lun=%lld qp=%d.\n",
+		    fcport->loop_id, fcport->d_id.b24,
+		    arg->modifier, arg->lun, arg->qpair->id);
+		return QLA_SUSPENDED;
+	}
+
 	/* ref: INIT */
 	sp = qla2xxx_get_qpair_sp(vha, arg->qpair, fcport, GFP_KERNEL);
 	if (!sp)
@@ -2178,7 +2215,9 @@ int qla_get_tmf(fc_port_t *fcport)
 		msleep(1);
 
 		spin_lock_irqsave(&ha->tgt.sess_lock, flags);
-		if (fcport->deleted) {
+		if (TMF_NOT_READY(fcport)) {
+			ql_log(ql_log_warn, vha, 0x802c,
+			    "Unable to acquire TM resource due to disruption.\n");
 			rc = EIO;
 			break;
 		}
@@ -2204,7 +2243,10 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint64_t lun,
 	struct scsi_qla_host *vha = fcport->vha;
 	struct qla_qpair *qpair;
 	struct tmf_arg a;
-	int i, rval;
+	int i, rval = QLA_SUCCESS;
+
+	if (TMF_NOT_READY(fcport))
+		return QLA_SUSPENDED;
 
 	a.vha = fcport->vha;
 	a.fcport = fcport;
@@ -2223,6 +2265,14 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint64_t lun,
 			qpair = vha->hw->queue_pair_map[i];
 			if (!qpair)
 				continue;
+
+			if (TMF_NOT_READY(fcport)) {
+				ql_log(ql_log_warn, vha, 0x8026,
+				    "Unable to send TM due to disruption.\n");
+				rval = QLA_SUSPENDED;
+				break;
+			}
+
 			a.qpair = qpair;
 			a.flags = flags|TCF_NOTMCMD_TO_TARGET;
 			rval = __qla2x00_async_tm_cmd(&a);
@@ -2231,10 +2281,14 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint64_t lun,
 		}
 	}
 
+	if (rval)
+		goto bailout;
+
 	a.qpair = vha->hw->base_qpair;
 	a.flags = flags;
 	rval = __qla2x00_async_tm_cmd(&a);
 
+bailout:
 	if (a.modifier == MK_SYNC_ID_LUN)
 		qla_put_tmf(fcport);
 

