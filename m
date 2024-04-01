Return-Path: <stable+bounces-34326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3929B893EDE
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AFC41C2132D
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAE94778B;
	Mon,  1 Apr 2024 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="avohNboN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD171CA8F;
	Mon,  1 Apr 2024 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987743; cv=none; b=Ko1+feR/3NUY4kl2FFlVcYWeehjYWFNqEHDUzDBKaMb62xw1gSMjaW+itA3+FCyFouv2rdRLFc5cgC2HiXCHWglKQZAhU9WwyxlL8UuUAYaWaFq9uXoijPT2sHhka4Gn0ZhY/hba8CGctcPGAj80zqgIJEycD1RTZ6qZPX+jsIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987743; c=relaxed/simple;
	bh=e+PrrC1b1XO2fsXltKld7NzJ+gdOWTSgTBYrhAocciE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vt3rNr+p3+Yvfd2ysZk7yf4K92i0l0x02IBslh47g5Lj3j+9zpMlDqROzx4hmMVVCdaMg0Wma3BpACz1cYnavIjbcGyMZd6cwuOuTUjj+/8H1ojxecPTnu9kk+zh/TuOjZd+rP33MSXxMcTDr2qFgjtzTh6ApMt+LR70XLrsYuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=avohNboN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE823C433F1;
	Mon,  1 Apr 2024 16:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987743;
	bh=e+PrrC1b1XO2fsXltKld7NzJ+gdOWTSgTBYrhAocciE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=avohNboNnfYGVen4dBSMXj9RX0my0qY+ylrUnoEYcPJyPvAruw3W+vcdOff8FXdJX
	 lgCFo4AUcHXnHTfEd1XzmMBCdx504bLyAhN44E+fp30Njr2zWEtHIoeM4I66heJ3S5
	 N1algYMq8FQuyTCXH2OJ1dCf4RhdZYF4oFT1lEYI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Quinn Tran <qutran@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.8 378/399] scsi: qla2xxx: Fix N2N stuck connection
Date: Mon,  1 Apr 2024 17:45:44 +0200
Message-ID: <20240401152600.463123747@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <qutran@marvell.com>

commit 881eb861ca3877300570db10abbf11494e48548d upstream.

Disk failed to rediscover after chip reset error injection. The chip reset
happens at the time when a PLOGI is being sent. This causes a flag to be
left on which blocks the retry. Clear the blocking flag.

Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20240227164127.36465-3-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_gbl.h  |    2 +-
 drivers/scsi/qla2xxx/qla_iocb.c |   32 +++++++++++---------------------
 drivers/scsi/qla2xxx/qla_os.c   |    2 +-
 3 files changed, 13 insertions(+), 23 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -44,7 +44,7 @@ extern int qla2x00_fabric_login(scsi_qla
 extern int qla2x00_local_device_login(scsi_qla_host_t *, fc_port_t *);
 
 extern int qla24xx_els_dcmd_iocb(scsi_qla_host_t *, int, port_id_t);
-extern int qla24xx_els_dcmd2_iocb(scsi_qla_host_t *, int, fc_port_t *, bool);
+extern int qla24xx_els_dcmd2_iocb(scsi_qla_host_t *, int, fc_port_t *);
 extern void qla2x00_els_dcmd2_free(scsi_qla_host_t *vha,
 				   struct els_plogi *els_plogi);
 
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -3041,7 +3041,7 @@ static void qla2x00_els_dcmd2_sp_done(sr
 
 int
 qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
-    fc_port_t *fcport, bool wait)
+			fc_port_t *fcport)
 {
 	srb_t *sp;
 	struct srb_iocb *elsio = NULL;
@@ -3056,8 +3056,7 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *
 	if (!sp) {
 		ql_log(ql_log_info, vha, 0x70e6,
 		 "SRB allocation failed\n");
-		fcport->flags &= ~FCF_ASYNC_ACTIVE;
-		return -ENOMEM;
+		goto done;
 	}
 
 	fcport->flags |= FCF_ASYNC_SENT;
@@ -3066,9 +3065,6 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *
 	ql_dbg(ql_dbg_io, vha, 0x3073,
 	       "%s Enter: PLOGI portid=%06x\n", __func__, fcport->d_id.b24);
 
-	if (wait)
-		sp->flags = SRB_WAKEUP_ON_COMP;
-
 	sp->type = SRB_ELS_DCMD;
 	sp->name = "ELS_DCMD";
 	sp->fcport = fcport;
@@ -3084,7 +3080,7 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *
 
 	if (!elsio->u.els_plogi.els_plogi_pyld) {
 		rval = QLA_FUNCTION_FAILED;
-		goto out;
+		goto done_free_sp;
 	}
 
 	resp_ptr = elsio->u.els_plogi.els_resp_pyld =
@@ -3093,7 +3089,7 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *
 
 	if (!elsio->u.els_plogi.els_resp_pyld) {
 		rval = QLA_FUNCTION_FAILED;
-		goto out;
+		goto done_free_sp;
 	}
 
 	ql_dbg(ql_dbg_io, vha, 0x3073, "PLOGI %p %p\n", ptr, resp_ptr);
@@ -3109,7 +3105,6 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *
 
 	if (els_opcode == ELS_DCMD_PLOGI && DBELL_ACTIVE(vha)) {
 		struct fc_els_flogi *p = ptr;
-
 		p->fl_csp.sp_features |= cpu_to_be16(FC_SP_FT_SEC);
 	}
 
@@ -3118,10 +3113,11 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *
 	    (uint8_t *)elsio->u.els_plogi.els_plogi_pyld,
 	    sizeof(*elsio->u.els_plogi.els_plogi_pyld));
 
-	init_completion(&elsio->u.els_plogi.comp);
 	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS) {
-		rval = QLA_FUNCTION_FAILED;
+		fcport->flags |= FCF_LOGIN_NEEDED;
+		set_bit(RELOGIN_NEEDED, &vha->dpc_flags);
+		goto done_free_sp;
 	} else {
 		ql_dbg(ql_dbg_disc, vha, 0x3074,
 		    "%s PLOGI sent, hdl=%x, loopid=%x, to port_id %06x from port_id %06x\n",
@@ -3129,21 +3125,15 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *
 		    fcport->d_id.b24, vha->d_id.b24);
 	}
 
-	if (wait) {
-		wait_for_completion(&elsio->u.els_plogi.comp);
-
-		if (elsio->u.els_plogi.comp_status != CS_COMPLETE)
-			rval = QLA_FUNCTION_FAILED;
-	} else {
-		goto done;
-	}
+	return rval;
 
-out:
-	fcport->flags &= ~(FCF_ASYNC_SENT | FCF_ASYNC_ACTIVE);
+done_free_sp:
 	qla2x00_els_dcmd2_free(vha, &elsio->u.els_plogi);
 	/* ref: INIT */
 	kref_put(&sp->cmd_kref, qla2x00_sp_release);
 done:
+	fcport->flags &= ~(FCF_ASYNC_SENT | FCF_ASYNC_ACTIVE);
+	qla2x00_set_fcport_disc_state(fcport, DSC_DELETED);
 	return rval;
 }
 
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -5583,7 +5583,7 @@ qla2x00_do_work(struct scsi_qla_host *vh
 			break;
 		case QLA_EVT_ELS_PLOGI:
 			qla24xx_els_dcmd2_iocb(vha, ELS_DCMD_PLOGI,
-			    e->u.fcport.fcport, false);
+			    e->u.fcport.fcport);
 			break;
 		case QLA_EVT_SA_REPLACE:
 			rc = qla24xx_issue_sa_replace_iocb(vha, e);



