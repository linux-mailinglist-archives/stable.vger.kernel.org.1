Return-Path: <stable+bounces-216250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOyFIcdGj2kiPAEAu9opvQ
	(envelope-from <stable+bounces-216250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:44:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 149CE137A67
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0988F302BBBC
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6263590C3;
	Fri, 13 Feb 2026 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sjo6+zRQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5166D187346
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770997416; cv=none; b=ckqM/sCcqA06psVW6OZ/7w6yNSXVaE8qCZhDLy2i9kPk6h4qqAO7Qm4PUUwL+Vv5ycayRXDaD+UMNT/xX1a7IE5LzYP1HgRkUM6uP0el50UyZAwcZV9k9X4sV5t/v5lWzXLGG+8GXXd85UEUHIo5KC0AaRS6vsByKjOgGrWj/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770997416; c=relaxed/simple;
	bh=YUsK0ZpSJ6hHJP/MRSKaUm9B1iVhona6K0Y47lR58lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oogkLP9u5VyyrJH4TTIc2uN6dLBe6oTMh35uLZYQvw+yrfBNt52giSASZBQVRr2gf3gDSocGjH/n5H4/MJDUQryN1vW/d8RxWzmI1wL3r5OavX6RZVr4+ffTF/+HMaYXIMCysrCdJBUCv4SzFHnCYloNYV9keWdx/xp4jrv3O94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sjo6+zRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D69C16AAE;
	Fri, 13 Feb 2026 15:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770997416;
	bh=YUsK0ZpSJ6hHJP/MRSKaUm9B1iVhona6K0Y47lR58lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sjo6+zRQPHiNOyzNciqtCvP14xAawc686uYKQd3KMGwYRFId3LXWJiK/ciK0iWhHx
	 JzI1AFzCDqxb5WbQHhUj8kUrgXCyc1Ezj/1duos7BqcQ7qgzK7Ys97Z10xs9RSqF07
	 aakLiM1O5eGaWvDuN8xZ0plRDu5pdvD3ZS52Lcyv/e4tjZ+hKt9pSO/Myqy5Nk+pHV
	 byWdpyZKghuXa/xEOKfIGD33St5l8XrBY5KT2Rtw6bVacNrfk9AxjrhSZVpPK+IK2o
	 rs+9p7cYx7YfuoylaRaCT/9llgLmBX03vnIvnI/JHQZo/31yJfikDd2lWRj7JKhOzY
	 K587KGVjMNDAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Quinn Tran <qutran@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] scsi: qla2xxx: Reduce fabric scan duplicate code
Date: Fri, 13 Feb 2026 10:43:31 -0500
Message-ID: <20260213154332.3544750-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213154332.3544750-1-sashal@kernel.org>
References: <2026021304-avid-upside-f50a@gregkh>
 <20260213154332.3544750-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216250-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,oracle.com:email]
X-Rspamd-Queue-Id: 149CE137A67
X-Rspamd-Action: no action

From: Quinn Tran <qutran@marvell.com>

[ Upstream commit beafd692461443e0fb1d61aa56886bf85ef6f5e4 ]

For fabric scan, current code uses switch scan opcode and flags as the
method to iterate through different commands to carry out the process.
This makes it hard to read. This patch convert those opcode and flags into
steps. In addition, this help reduce some duplicate code.

Consolidate routines that handle GPNFT & GNNFT.

Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20240710171057.35066-10-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 7adbd2b78090 ("scsi: qla2xxx: Free sp in error path to fix system crash")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_def.h  |  14 +-
 drivers/scsi/qla2xxx/qla_gbl.h  |   6 +-
 drivers/scsi/qla2xxx/qla_gs.c   | 430 +++++++++++++-------------------
 drivers/scsi/qla2xxx/qla_init.c |   5 +-
 drivers/scsi/qla2xxx/qla_os.c   |  12 +-
 5 files changed, 199 insertions(+), 268 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index edaa0ba81b256..e68f843be0867 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -3273,11 +3273,20 @@ struct fab_scan_rp {
 	u8 node_name[8];
 };
 
+enum scan_step {
+	FAB_SCAN_START,
+	FAB_SCAN_GPNFT_FCP,
+	FAB_SCAN_GNNFT_FCP,
+	FAB_SCAN_GPNFT_NVME,
+	FAB_SCAN_GNNFT_NVME,
+};
+
 struct fab_scan {
 	struct fab_scan_rp *l;
 	u32 size;
 	u32 rscn_gen_start;
 	u32 rscn_gen_end;
+	enum scan_step step;
 	u16 scan_retry;
 #define MAX_SCAN_RETRIES 5
 	enum scan_flags_t scan_flags;
@@ -3503,9 +3512,8 @@ enum qla_work_type {
 	QLA_EVT_RELOGIN,
 	QLA_EVT_ASYNC_PRLO,
 	QLA_EVT_ASYNC_PRLO_DONE,
-	QLA_EVT_GPNFT,
-	QLA_EVT_GPNFT_DONE,
-	QLA_EVT_GNNFT_DONE,
+	QLA_EVT_SCAN_CMD,
+	QLA_EVT_SCAN_FINISH,
 	QLA_EVT_GFPNID,
 	QLA_EVT_SP_RETRY,
 	QLA_EVT_IIDMA,
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index a30a47f034522..64cce557cbeb3 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -736,9 +736,9 @@ void qla24xx_handle_gpsc_event(scsi_qla_host_t *, struct event_arg *);
 int qla2x00_mgmt_svr_login(scsi_qla_host_t *);
 void qla24xx_handle_gffid_event(scsi_qla_host_t *vha, struct event_arg *ea);
 int qla24xx_async_gffid(scsi_qla_host_t *vha, fc_port_t *fcport, bool);
-int qla24xx_async_gpnft(scsi_qla_host_t *, u8, srb_t *);
-void qla24xx_async_gpnft_done(scsi_qla_host_t *, srb_t *);
-void qla24xx_async_gnnft_done(scsi_qla_host_t *, srb_t *);
+int qla_fab_async_scan(scsi_qla_host_t *, srb_t *);
+void qla_fab_scan_start(struct scsi_qla_host *);
+void qla_fab_scan_finish(scsi_qla_host_t *, srb_t *);
 int qla24xx_post_gfpnid_work(struct scsi_qla_host *, fc_port_t *);
 int qla24xx_async_gfpnid(scsi_qla_host_t *, fc_port_t *);
 void qla24xx_handle_gfpnid_event(scsi_qla_host_t *, struct event_arg *);
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index ece7b064ff968..e5dc65b13ccc2 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3488,7 +3488,7 @@ static bool qla_ok_to_clear_rscn(scsi_qla_host_t *vha, fc_port_t *fcport)
 	return true;
 }
 
-void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
+void qla_fab_scan_finish(scsi_qla_host_t *vha, srb_t *sp)
 {
 	fc_port_t *fcport;
 	u32 i, rc;
@@ -3703,14 +3703,11 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 	}
 }
 
-static int qla2x00_post_gnnft_gpnft_done_work(struct scsi_qla_host *vha,
+static int qla2x00_post_next_scan_work(struct scsi_qla_host *vha,
     srb_t *sp, int cmd)
 {
 	struct qla_work_evt *e;
 
-	if (cmd != QLA_EVT_GPNFT_DONE && cmd != QLA_EVT_GNNFT_DONE)
-		return QLA_PARAMETER_ERROR;
-
 	e = qla2x00_alloc_work(vha, cmd);
 	if (!e)
 		return QLA_FUNCTION_FAILED;
@@ -3720,37 +3717,15 @@ static int qla2x00_post_gnnft_gpnft_done_work(struct scsi_qla_host *vha,
 	return qla2x00_post_work(vha, e);
 }
 
-static int qla2x00_post_nvme_gpnft_work(struct scsi_qla_host *vha,
-    srb_t *sp, int cmd)
-{
-	struct qla_work_evt *e;
-
-	if (cmd != QLA_EVT_GPNFT)
-		return QLA_PARAMETER_ERROR;
-
-	e = qla2x00_alloc_work(vha, cmd);
-	if (!e)
-		return QLA_FUNCTION_FAILED;
-
-	e->u.gpnft.fc4_type = FC4_TYPE_NVME;
-	e->u.gpnft.sp = sp;
-
-	return qla2x00_post_work(vha, e);
-}
-
 static void qla2x00_find_free_fcp_nvme_slot(struct scsi_qla_host *vha,
 	struct srb *sp)
 {
 	struct qla_hw_data *ha = vha->hw;
 	int num_fibre_dev = ha->max_fibre_devices;
-	struct ct_sns_req *ct_req =
-		(struct ct_sns_req *)sp->u.iocb_cmd.u.ctarg.req;
 	struct ct_sns_gpnft_rsp *ct_rsp =
 		(struct ct_sns_gpnft_rsp *)sp->u.iocb_cmd.u.ctarg.rsp;
 	struct ct_sns_gpn_ft_data *d;
 	struct fab_scan_rp *rp;
-	u16 cmd = be16_to_cpu(ct_req->command);
-	u8 fc4_type = sp->gen2;
 	int i, j, k;
 	port_id_t id;
 	u8 found;
@@ -3769,85 +3744,83 @@ static void qla2x00_find_free_fcp_nvme_slot(struct scsi_qla_host *vha,
 		if (id.b24 == 0 || wwn == 0)
 			continue;
 
-		if (fc4_type == FC4_TYPE_FCP_SCSI) {
-			if (cmd == GPN_FT_CMD) {
-				rp = &vha->scan.l[j];
-				rp->id = id;
-				memcpy(rp->port_name, d->port_name, 8);
-				j++;
-				rp->fc4type = FS_FC4TYPE_FCP;
-			} else {
-				for (k = 0; k < num_fibre_dev; k++) {
-					rp = &vha->scan.l[k];
-					if (id.b24 == rp->id.b24) {
-						memcpy(rp->node_name,
-						    d->port_name, 8);
-						break;
-					}
+		ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0x2025,
+		       "%s %06x %8ph \n",
+		       __func__, id.b24, d->port_name);
+
+		switch (vha->scan.step) {
+		case FAB_SCAN_GPNFT_FCP:
+			rp = &vha->scan.l[j];
+			rp->id = id;
+			memcpy(rp->port_name, d->port_name, 8);
+			j++;
+			rp->fc4type = FS_FC4TYPE_FCP;
+			break;
+		case FAB_SCAN_GNNFT_FCP:
+			for (k = 0; k < num_fibre_dev; k++) {
+				rp = &vha->scan.l[k];
+				if (id.b24 == rp->id.b24) {
+					memcpy(rp->node_name,
+					    d->port_name, 8);
+					break;
 				}
 			}
-		} else {
-			/* Search if the fibre device supports FC4_TYPE_NVME */
-			if (cmd == GPN_FT_CMD) {
-				found = 0;
+			break;
+		case FAB_SCAN_GPNFT_NVME:
+			found = 0;
 
-				for (k = 0; k < num_fibre_dev; k++) {
-					rp = &vha->scan.l[k];
-					if (!memcmp(rp->port_name,
-					    d->port_name, 8)) {
-						/*
-						 * Supports FC-NVMe & FCP
-						 */
-						rp->fc4type |= FS_FC4TYPE_NVME;
-						found = 1;
-						break;
-					}
+			for (k = 0; k < num_fibre_dev; k++) {
+				rp = &vha->scan.l[k];
+				if (!memcmp(rp->port_name, d->port_name, 8)) {
+					/*
+					 * Supports FC-NVMe & FCP
+					 */
+					rp->fc4type |= FS_FC4TYPE_NVME;
+					found = 1;
+					break;
 				}
+			}
 
-				/* We found new FC-NVMe only port */
-				if (!found) {
-					for (k = 0; k < num_fibre_dev; k++) {
-						rp = &vha->scan.l[k];
-						if (wwn_to_u64(rp->port_name)) {
-							continue;
-						} else {
-							rp->id = id;
-							memcpy(rp->port_name,
-							    d->port_name, 8);
-							rp->fc4type =
-							    FS_FC4TYPE_NVME;
-							break;
-						}
-					}
-				}
-			} else {
+			/* We found new FC-NVMe only port */
+			if (!found) {
 				for (k = 0; k < num_fibre_dev; k++) {
 					rp = &vha->scan.l[k];
-					if (id.b24 == rp->id.b24) {
-						memcpy(rp->node_name,
-						    d->port_name, 8);
+					if (wwn_to_u64(rp->port_name)) {
+						continue;
+					} else {
+						rp->id = id;
+						memcpy(rp->port_name, d->port_name, 8);
+						rp->fc4type = FS_FC4TYPE_NVME;
 						break;
 					}
 				}
 			}
+			break;
+		case FAB_SCAN_GNNFT_NVME:
+			for (k = 0; k < num_fibre_dev; k++) {
+				rp = &vha->scan.l[k];
+				if (id.b24 == rp->id.b24) {
+					memcpy(rp->node_name, d->port_name, 8);
+					break;
+				}
+			}
+			break;
+		default:
+			break;
 		}
 	}
 }
 
-static void qla2x00_async_gpnft_gnnft_sp_done(srb_t *sp, int res)
+static void qla_async_scan_sp_done(srb_t *sp, int res)
 {
 	struct scsi_qla_host *vha = sp->vha;
-	struct ct_sns_req *ct_req =
-		(struct ct_sns_req *)sp->u.iocb_cmd.u.ctarg.req;
-	u16 cmd = be16_to_cpu(ct_req->command);
-	u8 fc4_type = sp->gen2;
 	unsigned long flags;
 	int rc;
 
 	/* gen2 field is holding the fc4type */
-	ql_dbg(ql_dbg_disc, vha, 0xffff,
-	    "Async done-%s res %x FC4Type %x\n",
-	    sp->name, res, sp->gen2);
+	ql_dbg(ql_dbg_disc, vha, 0x2026,
+	    "Async done-%s res %x step %x\n",
+	    sp->name, res, vha->scan.step);
 
 	sp->rc = res;
 	if (res) {
@@ -3871,8 +3844,7 @@ static void qla2x00_async_gpnft_gnnft_sp_done(srb_t *sp, int res)
 		 * sp for GNNFT_DONE work. This will allow all
 		 * the resource to get freed up.
 		 */
-		rc = qla2x00_post_gnnft_gpnft_done_work(vha, sp,
-		    QLA_EVT_GNNFT_DONE);
+		rc = qla2x00_post_next_scan_work(vha, sp, QLA_EVT_SCAN_FINISH);
 		if (rc) {
 			/* Cleanup here to prevent memory leak */
 			qla24xx_sp_unmap(vha, sp);
@@ -3897,28 +3869,30 @@ static void qla2x00_async_gpnft_gnnft_sp_done(srb_t *sp, int res)
 
 	qla2x00_find_free_fcp_nvme_slot(vha, sp);
 
-	if ((fc4_type == FC4_TYPE_FCP_SCSI) && vha->flags.nvme_enabled &&
-	    cmd == GNN_FT_CMD) {
-		spin_lock_irqsave(&vha->work_lock, flags);
-		vha->scan.scan_flags &= ~SF_SCANNING;
-		spin_unlock_irqrestore(&vha->work_lock, flags);
+	spin_lock_irqsave(&vha->work_lock, flags);
+	vha->scan.scan_flags &= ~SF_SCANNING;
+	spin_unlock_irqrestore(&vha->work_lock, flags);
 
-		sp->rc = res;
-		rc = qla2x00_post_nvme_gpnft_work(vha, sp, QLA_EVT_GPNFT);
-		if (rc) {
-			qla24xx_sp_unmap(vha, sp);
-			set_bit(LOCAL_LOOP_UPDATE, &vha->dpc_flags);
-			set_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags);
-		}
-		return;
-	}
+	switch (vha->scan.step) {
+	case FAB_SCAN_GPNFT_FCP:
+	case FAB_SCAN_GPNFT_NVME:
+		rc = qla2x00_post_next_scan_work(vha, sp, QLA_EVT_SCAN_CMD);
+		break;
+	case  FAB_SCAN_GNNFT_FCP:
+		if (vha->flags.nvme_enabled)
+			rc = qla2x00_post_next_scan_work(vha, sp, QLA_EVT_SCAN_CMD);
+		else
+			rc = qla2x00_post_next_scan_work(vha, sp, QLA_EVT_SCAN_FINISH);
 
-	if (cmd == GPN_FT_CMD) {
-		rc = qla2x00_post_gnnft_gpnft_done_work(vha, sp,
-		    QLA_EVT_GPNFT_DONE);
-	} else {
-		rc = qla2x00_post_gnnft_gpnft_done_work(vha, sp,
-		    QLA_EVT_GNNFT_DONE);
+		break;
+	case  FAB_SCAN_GNNFT_NVME:
+		rc = qla2x00_post_next_scan_work(vha, sp, QLA_EVT_SCAN_FINISH);
+		break;
+	default:
+		/* should not be here */
+		WARN_ON(1);
+		rc = QLA_FUNCTION_FAILED;
+		break;
 	}
 
 	if (rc) {
@@ -3929,127 +3903,16 @@ static void qla2x00_async_gpnft_gnnft_sp_done(srb_t *sp, int res)
 	}
 }
 
-/*
- * Get WWNN list for fc4_type
- *
- * It is assumed the same SRB is re-used from GPNFT to avoid
- * mem free & re-alloc
- */
-static int qla24xx_async_gnnft(scsi_qla_host_t *vha, struct srb *sp,
-    u8 fc4_type)
-{
-	int rval = QLA_FUNCTION_FAILED;
-	struct ct_sns_req *ct_req;
-	struct ct_sns_pkt *ct_sns;
-	unsigned long flags;
-
-	if (!vha->flags.online) {
-		spin_lock_irqsave(&vha->work_lock, flags);
-		vha->scan.scan_flags &= ~SF_SCANNING;
-		spin_unlock_irqrestore(&vha->work_lock, flags);
-		goto done_free_sp;
-	}
-
-	if (!sp->u.iocb_cmd.u.ctarg.req || !sp->u.iocb_cmd.u.ctarg.rsp) {
-		ql_log(ql_log_warn, vha, 0xffff,
-		    "%s: req %p rsp %p are not setup\n",
-		    __func__, sp->u.iocb_cmd.u.ctarg.req,
-		    sp->u.iocb_cmd.u.ctarg.rsp);
-		spin_lock_irqsave(&vha->work_lock, flags);
-		vha->scan.scan_flags &= ~SF_SCANNING;
-		spin_unlock_irqrestore(&vha->work_lock, flags);
-		WARN_ON(1);
-		set_bit(LOCAL_LOOP_UPDATE, &vha->dpc_flags);
-		set_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags);
-		goto done_free_sp;
-	}
-
-	ql_dbg(ql_dbg_disc, vha, 0xfffff,
-	    "%s: FC4Type %x, CT-PASSTHRU %s command ctarg rsp size %d, ctarg req size %d\n",
-	    __func__, fc4_type, sp->name, sp->u.iocb_cmd.u.ctarg.rsp_size,
-	     sp->u.iocb_cmd.u.ctarg.req_size);
-
-	sp->type = SRB_CT_PTHRU_CMD;
-	sp->name = "gnnft";
-	sp->gen1 = vha->hw->base_qpair->chip_reset;
-	sp->gen2 = fc4_type;
-	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
-			      qla2x00_async_gpnft_gnnft_sp_done);
-
-	memset(sp->u.iocb_cmd.u.ctarg.rsp, 0, sp->u.iocb_cmd.u.ctarg.rsp_size);
-	memset(sp->u.iocb_cmd.u.ctarg.req, 0, sp->u.iocb_cmd.u.ctarg.req_size);
-
-	ct_sns = (struct ct_sns_pkt *)sp->u.iocb_cmd.u.ctarg.req;
-	/* CT_IU preamble  */
-	ct_req = qla2x00_prep_ct_req(ct_sns, GNN_FT_CMD,
-	    sp->u.iocb_cmd.u.ctarg.rsp_size);
-
-	/* GPN_FT req */
-	ct_req->req.gpn_ft.port_type = fc4_type;
-
-	sp->u.iocb_cmd.u.ctarg.req_size = GNN_FT_REQ_SIZE;
-	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
-
-	ql_dbg(ql_dbg_disc, vha, 0xffff,
-	    "Async-%s hdl=%x FC4Type %x.\n", sp->name,
-	    sp->handle, ct_req->req.gpn_ft.port_type);
-
-	rval = qla2x00_start_sp(sp);
-	if (rval != QLA_SUCCESS) {
-		goto done_free_sp;
-	}
-
-	return rval;
-
-done_free_sp:
-	if (sp->u.iocb_cmd.u.ctarg.req) {
-		dma_free_coherent(&vha->hw->pdev->dev,
-		    sp->u.iocb_cmd.u.ctarg.req_allocated_size,
-		    sp->u.iocb_cmd.u.ctarg.req,
-		    sp->u.iocb_cmd.u.ctarg.req_dma);
-		sp->u.iocb_cmd.u.ctarg.req = NULL;
-	}
-	if (sp->u.iocb_cmd.u.ctarg.rsp) {
-		dma_free_coherent(&vha->hw->pdev->dev,
-		    sp->u.iocb_cmd.u.ctarg.rsp_allocated_size,
-		    sp->u.iocb_cmd.u.ctarg.rsp,
-		    sp->u.iocb_cmd.u.ctarg.rsp_dma);
-		sp->u.iocb_cmd.u.ctarg.rsp = NULL;
-	}
-	/* ref: INIT */
-	kref_put(&sp->cmd_kref, qla2x00_sp_release);
-
-	spin_lock_irqsave(&vha->work_lock, flags);
-	vha->scan.scan_flags &= ~SF_SCANNING;
-	if (vha->scan.scan_flags == 0) {
-		ql_dbg(ql_dbg_disc, vha, 0xffff,
-		    "%s: schedule\n", __func__);
-		vha->scan.scan_flags |= SF_QUEUED;
-		schedule_delayed_work(&vha->scan.scan_work, 5);
-	}
-	spin_unlock_irqrestore(&vha->work_lock, flags);
-
-
-	return rval;
-} /* GNNFT */
-
-void qla24xx_async_gpnft_done(scsi_qla_host_t *vha, srb_t *sp)
-{
-	ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0xffff,
-	    "%s enter\n", __func__);
-	qla24xx_async_gnnft(vha, sp, sp->gen2);
-}
-
 /* Get WWPN list for certain fc4_type */
-int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
+int qla_fab_async_scan(scsi_qla_host_t *vha, srb_t *sp)
 {
 	int rval = QLA_FUNCTION_FAILED;
 	struct ct_sns_req       *ct_req;
 	struct ct_sns_pkt *ct_sns;
-	u32 rspsz;
+	u32 rspsz = 0;
 	unsigned long flags;
 
-	ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0xffff,
+	ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0x200c,
 	    "%s enter\n", __func__);
 
 	if (!vha->flags.online)
@@ -4058,22 +3921,21 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 	spin_lock_irqsave(&vha->work_lock, flags);
 	if (vha->scan.scan_flags & SF_SCANNING) {
 		spin_unlock_irqrestore(&vha->work_lock, flags);
-		ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0xffff,
+		ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0x2012,
 		    "%s: scan active\n", __func__);
 		return rval;
 	}
 	vha->scan.scan_flags |= SF_SCANNING;
+	if (!sp)
+		vha->scan.step = FAB_SCAN_START;
+
 	spin_unlock_irqrestore(&vha->work_lock, flags);
 
-	if (fc4_type == FC4_TYPE_FCP_SCSI) {
-		ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0xffff,
+	switch (vha->scan.step) {
+	case FAB_SCAN_START:
+		ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0x2018,
 		    "%s: Performing FCP Scan\n", __func__);
 
-		if (sp) {
-			/* ref: INIT */
-			kref_put(&sp->cmd_kref, qla2x00_sp_release);
-		}
-
 		/* ref: INIT */
 		sp = qla2x00_get_sp(vha, NULL, GFP_KERNEL);
 		if (!sp) {
@@ -4089,7 +3951,7 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 								GFP_KERNEL);
 		sp->u.iocb_cmd.u.ctarg.req_allocated_size = sizeof(struct ct_sns_pkt);
 		if (!sp->u.iocb_cmd.u.ctarg.req) {
-			ql_log(ql_log_warn, vha, 0xffff,
+			ql_log(ql_log_warn, vha, 0x201a,
 			    "Failed to allocate ct_sns request.\n");
 			spin_lock_irqsave(&vha->work_lock, flags);
 			vha->scan.scan_flags &= ~SF_SCANNING;
@@ -4097,7 +3959,6 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 			qla2x00_rel_sp(sp);
 			return rval;
 		}
-		sp->u.iocb_cmd.u.ctarg.req_size = GPN_FT_REQ_SIZE;
 
 		rspsz = sizeof(struct ct_sns_gpnft_rsp) +
 			((vha->hw->max_fibre_devices - 1) *
@@ -4109,7 +3970,7 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 								GFP_KERNEL);
 		sp->u.iocb_cmd.u.ctarg.rsp_allocated_size = rspsz;
 		if (!sp->u.iocb_cmd.u.ctarg.rsp) {
-			ql_log(ql_log_warn, vha, 0xffff,
+			ql_log(ql_log_warn, vha, 0x201b,
 			    "Failed to allocate ct_sns request.\n");
 			spin_lock_irqsave(&vha->work_lock, flags);
 			vha->scan.scan_flags &= ~SF_SCANNING;
@@ -4129,35 +3990,95 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 		    "%s scan list size %d\n", __func__, vha->scan.size);
 
 		memset(vha->scan.l, 0, vha->scan.size);
-	} else if (!sp) {
-		ql_dbg(ql_dbg_disc, vha, 0xffff,
-		    "NVME scan did not provide SP\n");
+
+		vha->scan.step = FAB_SCAN_GPNFT_FCP;
+		break;
+	case FAB_SCAN_GPNFT_FCP:
+		vha->scan.step = FAB_SCAN_GNNFT_FCP;
+		break;
+	case FAB_SCAN_GNNFT_FCP:
+		vha->scan.step = FAB_SCAN_GPNFT_NVME;
+		break;
+	case FAB_SCAN_GPNFT_NVME:
+		vha->scan.step = FAB_SCAN_GNNFT_NVME;
+		break;
+	case FAB_SCAN_GNNFT_NVME:
+	default:
+		/* should not be here */
+		WARN_ON(1);
+		goto done_free_sp;
+	}
+
+	if (!sp) {
+		ql_dbg(ql_dbg_disc, vha, 0x201c,
+		    "scan did not provide SP\n");
 		return rval;
 	}
+	if (!sp->u.iocb_cmd.u.ctarg.req || !sp->u.iocb_cmd.u.ctarg.rsp) {
+		ql_log(ql_log_warn, vha, 0x201d,
+		    "%s: req %p rsp %p are not setup\n",
+		    __func__, sp->u.iocb_cmd.u.ctarg.req,
+		    sp->u.iocb_cmd.u.ctarg.rsp);
+		spin_lock_irqsave(&vha->work_lock, flags);
+		vha->scan.scan_flags &= ~SF_SCANNING;
+		spin_unlock_irqrestore(&vha->work_lock, flags);
+		WARN_ON(1);
+		set_bit(LOCAL_LOOP_UPDATE, &vha->dpc_flags);
+		set_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags);
+		goto done_free_sp;
+	}
+
+	rspsz = sp->u.iocb_cmd.u.ctarg.rsp_size;
+	memset(sp->u.iocb_cmd.u.ctarg.req, 0, sp->u.iocb_cmd.u.ctarg.req_size);
+	memset(sp->u.iocb_cmd.u.ctarg.rsp, 0, sp->u.iocb_cmd.u.ctarg.rsp_size);
+
 
 	sp->type = SRB_CT_PTHRU_CMD;
-	sp->name = "gpnft";
 	sp->gen1 = vha->hw->base_qpair->chip_reset;
-	sp->gen2 = fc4_type;
 	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
-			      qla2x00_async_gpnft_gnnft_sp_done);
-
-	rspsz = sp->u.iocb_cmd.u.ctarg.rsp_size;
-	memset(sp->u.iocb_cmd.u.ctarg.rsp, 0, sp->u.iocb_cmd.u.ctarg.rsp_size);
-	memset(sp->u.iocb_cmd.u.ctarg.req, 0, sp->u.iocb_cmd.u.ctarg.req_size);
+			      qla_async_scan_sp_done);
 
 	ct_sns = (struct ct_sns_pkt *)sp->u.iocb_cmd.u.ctarg.req;
-	/* CT_IU preamble  */
-	ct_req = qla2x00_prep_ct_req(ct_sns, GPN_FT_CMD, rspsz);
 
-	/* GPN_FT req */
-	ct_req->req.gpn_ft.port_type = fc4_type;
+	/* CT_IU preamble  */
+	switch (vha->scan.step) {
+	case FAB_SCAN_GPNFT_FCP:
+		sp->name = "gpnft";
+		ct_req = qla2x00_prep_ct_req(ct_sns, GPN_FT_CMD, rspsz);
+		ct_req->req.gpn_ft.port_type = FC4_TYPE_FCP_SCSI;
+		sp->u.iocb_cmd.u.ctarg.req_size = GPN_FT_REQ_SIZE;
+		break;
+	case FAB_SCAN_GNNFT_FCP:
+		sp->name = "gnnft";
+		ct_req = qla2x00_prep_ct_req(ct_sns, GNN_FT_CMD, rspsz);
+		ct_req->req.gpn_ft.port_type = FC4_TYPE_FCP_SCSI;
+		sp->u.iocb_cmd.u.ctarg.req_size = GNN_FT_REQ_SIZE;
+		break;
+	case FAB_SCAN_GPNFT_NVME:
+		sp->name = "gpnft";
+		ct_req = qla2x00_prep_ct_req(ct_sns, GPN_FT_CMD, rspsz);
+		ct_req->req.gpn_ft.port_type = FC4_TYPE_NVME;
+		sp->u.iocb_cmd.u.ctarg.req_size = GPN_FT_REQ_SIZE;
+		break;
+	case FAB_SCAN_GNNFT_NVME:
+		sp->name = "gnnft";
+		ct_req = qla2x00_prep_ct_req(ct_sns, GNN_FT_CMD, rspsz);
+		ct_req->req.gpn_ft.port_type = FC4_TYPE_NVME;
+		sp->u.iocb_cmd.u.ctarg.req_size = GNN_FT_REQ_SIZE;
+		break;
+	default:
+		/* should not be here */
+		WARN_ON(1);
+		goto done_free_sp;
+	}
 
 	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
 
-	ql_dbg(ql_dbg_disc, vha, 0xffff,
-	    "Async-%s hdl=%x FC4Type %x.\n", sp->name,
-	    sp->handle, ct_req->req.gpn_ft.port_type);
+	ql_dbg(ql_dbg_disc, vha, 0x2003,
+	       "%s: step %d, rsp size %d, req size %d hdl %x %s FC4TYPE %x \n",
+	       __func__, vha->scan.step, sp->u.iocb_cmd.u.ctarg.rsp_size,
+	       sp->u.iocb_cmd.u.ctarg.req_size, sp->handle, sp->name,
+	       ct_req->req.gpn_ft.port_type);
 
 	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS) {
@@ -4188,7 +4109,7 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 	spin_lock_irqsave(&vha->work_lock, flags);
 	vha->scan.scan_flags &= ~SF_SCANNING;
 	if (vha->scan.scan_flags == 0) {
-		ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0xffff,
+		ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0x2007,
 		    "%s: Scan scheduled.\n", __func__);
 		vha->scan.scan_flags |= SF_QUEUED;
 		schedule_delayed_work(&vha->scan.scan_work, 5);
@@ -4199,6 +4120,15 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 	return rval;
 }
 
+void qla_fab_scan_start(struct scsi_qla_host *vha)
+{
+	int rval;
+
+	rval = qla_fab_async_scan(vha, NULL);
+	if (rval)
+		set_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags);
+}
+
 void qla_scan_work_fn(struct work_struct *work)
 {
 	struct fab_scan *s = container_of(to_delayed_work(work),
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index a62c663543b81..e2c80dd43bb02 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -6438,10 +6438,7 @@ qla2x00_configure_fabric(scsi_qla_host_t *vha)
 		if (USE_ASYNC_SCAN(ha)) {
 			/* start of scan begins here */
 			vha->scan.rscn_gen_end = atomic_read(&vha->rscn_gen);
-			rval = qla24xx_async_gpnft(vha, FC4_TYPE_FCP_SCSI,
-			    NULL);
-			if (rval)
-				set_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags);
+			qla_fab_scan_start(vha);
 		} else  {
 			list_for_each_entry(fcport, &vha->vp_fcports, list)
 				fcport->scan_state = QLA_FCPORT_SCAN;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index c27e64cb4d7e1..20b48eee57f25 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -5521,15 +5521,11 @@ qla2x00_do_work(struct scsi_qla_host *vha)
 			qla2x00_async_prlo_done(vha, e->u.logio.fcport,
 			    e->u.logio.data);
 			break;
-		case QLA_EVT_GPNFT:
-			qla24xx_async_gpnft(vha, e->u.gpnft.fc4_type,
-			    e->u.gpnft.sp);
+		case QLA_EVT_SCAN_CMD:
+			qla_fab_async_scan(vha, e->u.iosb.sp);
 			break;
-		case QLA_EVT_GPNFT_DONE:
-			qla24xx_async_gpnft_done(vha, e->u.iosb.sp);
-			break;
-		case QLA_EVT_GNNFT_DONE:
-			qla24xx_async_gnnft_done(vha, e->u.iosb.sp);
+		case QLA_EVT_SCAN_FINISH:
+			qla_fab_scan_finish(vha, e->u.iosb.sp);
 			break;
 		case QLA_EVT_GFPNID:
 			qla24xx_async_gfpnid(vha, e->u.fcport.fcport);
-- 
2.51.0


