Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476F576ACFF
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjHAJZV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjHAJZB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:25:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD50C2D44
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:23:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCBD9614FE
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6131C433C8;
        Tue,  1 Aug 2023 09:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881827;
        bh=Oz+ApuPLdBUzlT5GVIBC2x3SbFhRxGhpohRDGJEQNO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s7RqlhAwStVHikljS60u02I11mZuiU7Tt4F5ATx77vBeqbbE7RPbBfeAyJ+D6AuoW
         1IcbRPf51MvQUbFilRhn4kNaKd8pVJUSxaqUgbzpPPWxfP4hi/MobhysheRGJkyY22
         kn8UFPSUKdYzCu94QzavH1MTLfU22hYLI1bXZiis=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Quinn Tran <qutran@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 043/155] scsi: qla2xxx: Fix hang in task management
Date:   Tue,  1 Aug 2023 11:19:15 +0200
Message-ID: <20230801091911.717237959@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
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

From: Quinn Tran <qutran@marvell.com>

[ Upstream commit 9ae615c5bfd37bd091772969b1153de5335ea986 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_def.h  |  4 +++
 drivers/scsi/qla2xxx/qla_init.c | 60 +++++++++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 2a2bca2fb57ee..83228ce822af3 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -5481,4 +5481,8 @@ struct ql_vnd_tgt_stats_resp {
 	_fp->disc_state, _fp->scan_state, _fp->loop_id, _fp->deleted, \
 	_fp->flags
 
+#define TMF_NOT_READY(_fcport) \
+	(!_fcport || IS_SESSION_DELETED(_fcport) || atomic_read(&_fcport->state) != FCS_ONLINE || \
+	!_fcport->vha->hw->flags.fw_started)
+
 #endif
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 2c42ecb2a64a5..a97872b6350ca 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1998,6 +1998,11 @@ qla2x00_tmf_iocb_timeout(void *data)
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
@@ -2025,6 +2030,7 @@ static void qla_marker_sp_done(srb_t *sp, int res)
 		    sp->handle, sp->fcport->d_id.b24, sp->u.iocb_cmd.u.tmf.flags,
 		    sp->u.iocb_cmd.u.tmf.lun, sp->qpair->id);
 
+	sp->u.iocb_cmd.u.tmf.data = res;
 	complete(&tmf->u.tmf.comp);
 }
 
@@ -2041,6 +2047,11 @@ static void qla_marker_sp_done(srb_t *sp, int res)
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
@@ -2050,6 +2061,14 @@ qla26xx_marker(struct tmf_arg *arg)
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
@@ -2076,11 +2095,19 @@ qla26xx_marker(struct tmf_arg *arg)
 
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
@@ -2093,6 +2120,8 @@ static void qla2x00_tmf_sp_done(srb_t *sp, int res)
 {
 	struct srb_iocb *tmf = &sp->u.iocb_cmd;
 
+	if (res)
+		tmf->u.tmf.data = res;
 	complete(&tmf->u.tmf.comp);
 }
 
@@ -2106,6 +2135,14 @@ __qla2x00_async_tm_cmd(struct tmf_arg *arg)
 
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
@@ -2180,7 +2217,9 @@ int qla_get_tmf(fc_port_t *fcport)
 		msleep(1);
 
 		spin_lock_irqsave(&ha->tgt.sess_lock, flags);
-		if (fcport->deleted) {
+		if (TMF_NOT_READY(fcport)) {
+			ql_log(ql_log_warn, vha, 0x802c,
+			    "Unable to acquire TM resource due to disruption.\n");
 			rc = EIO;
 			break;
 		}
@@ -2206,7 +2245,10 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint64_t lun,
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
@@ -2225,6 +2267,14 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint64_t lun,
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
@@ -2233,10 +2283,14 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint64_t lun,
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
 
-- 
2.39.2



