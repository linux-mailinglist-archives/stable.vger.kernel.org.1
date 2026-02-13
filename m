Return-Path: <stable+bounces-216249-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACoaOcNGj2kiPAEAu9opvQ
	(envelope-from <stable+bounces-216249-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:44:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C643137A60
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE774302A2C9
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E0335F8AA;
	Fri, 13 Feb 2026 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uz37pYDX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CBE187346
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770997415; cv=none; b=oZC2tHgzko4SN0hwO9RtRK4SVetG8h3rrpxWa3YFFhvfR4mgSjmRNhBJITxIbWJkqu1ETnlvrOGftnjODcM5S5sP6FLJgcF4sl3EIpU9MVWxIOkWZitHfprgGXJ69v/QvZFTkMnVIOqcaXwTW3YZiD18yWmbZg2AikwXW3T9zIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770997415; c=relaxed/simple;
	bh=l9Cve7tgoBJ5bznLABsgSWnUUWKacJSJHI5Y/gc4aj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hI46eEya8F9UFPQcDzsrPgouTImrR/6cyIUO5MbaSmNx3rrcOZRrJJJomjAxrufo4gQ3ZpSy9joRZETUEosXyIrXW6IM9utj9PWR2TszfezyoGbi/MQg2VDCjmrMbSx4DABtm/vJvIUnN/dMlw/LzPCsmDPRysEAWmNwnYtJrJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uz37pYDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9C5C116C6;
	Fri, 13 Feb 2026 15:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770997415;
	bh=l9Cve7tgoBJ5bznLABsgSWnUUWKacJSJHI5Y/gc4aj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uz37pYDXnnIlBHLM3/XVC4N1XaZcq8rzQitOlNE/i9BmwF24VV3Q2YbQX43r+N1Nb
	 83OdwhEROTzIGNBIDe0oReOynI9bs2bvuw+OR2mAs3M/7LzKhJEr9bxCblGjy9ql84
	 QAiW2cQZ615OGKw9LJl0Emx7t1XvavitwxQ1wUocJrcxjtswR8FtwPLaR6kq3w0YoT
	 DqPwh9QU6bUQatFiQJyg5ACUahz+hKvFDXyJqQhLdNEzkllawlsMR6gRARP4U+MBtR
	 OmMBQu+Y36TRh8j95S/WK1rOaez8BjpDs4feZn8aLgS1GkMrnpjh0JGX1PSdF2GvCq
	 fzgKQ6JOq26og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Quinn Tran <qutran@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] scsi: qla2xxx: Remove dead code (GNN ID)
Date: Fri, 13 Feb 2026 10:43:30 -0500
Message-ID: <20260213154332.3544750-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026021304-avid-upside-f50a@gregkh>
References: <2026021304-avid-upside-f50a@gregkh>
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
	TAGGED_FROM(0.00)[bounces-216249-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 3C643137A60
X-Rspamd-Action: no action

From: Quinn Tran <qutran@marvell.com>

[ Upstream commit 87f6dafd50fb6d7214c32596a11b983138b09123 ]

Remove stale/unused code (GNN ID).

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 7adbd2b78090 ("scsi: qla2xxx: Free sp in error path to fix system crash")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_def.h  |   3 -
 drivers/scsi/qla2xxx/qla_gbl.h  |   3 -
 drivers/scsi/qla2xxx/qla_gs.c   | 110 --------------------------------
 drivers/scsi/qla2xxx/qla_init.c |   7 +-
 drivers/scsi/qla2xxx/qla_os.c   |   3 -
 5 files changed, 1 insertion(+), 125 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index c0d8714d6f766..edaa0ba81b256 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -2499,7 +2499,6 @@ struct ct_sns_desc {
 
 enum discovery_state {
 	DSC_DELETED,
-	DSC_GNN_ID,
 	DSC_GNL,
 	DSC_LOGIN_PEND,
 	DSC_LOGIN_FAILED,
@@ -2712,7 +2711,6 @@ extern const char *const port_state_str[5];
 
 static const char *const port_dstate_str[] = {
 	[DSC_DELETED]		= "DELETED",
-	[DSC_GNN_ID]		= "GNN_ID",
 	[DSC_GNL]		= "GNL",
 	[DSC_LOGIN_PEND]	= "LOGIN_PEND",
 	[DSC_LOGIN_FAILED]	= "LOGIN_FAILED",
@@ -3508,7 +3506,6 @@ enum qla_work_type {
 	QLA_EVT_GPNFT,
 	QLA_EVT_GPNFT_DONE,
 	QLA_EVT_GNNFT_DONE,
-	QLA_EVT_GNNID,
 	QLA_EVT_GFPNID,
 	QLA_EVT_SP_RETRY,
 	QLA_EVT_IIDMA,
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index f654877ed083e..a30a47f034522 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -739,9 +739,6 @@ int qla24xx_async_gffid(scsi_qla_host_t *vha, fc_port_t *fcport, bool);
 int qla24xx_async_gpnft(scsi_qla_host_t *, u8, srb_t *);
 void qla24xx_async_gpnft_done(scsi_qla_host_t *, srb_t *);
 void qla24xx_async_gnnft_done(scsi_qla_host_t *, srb_t *);
-int qla24xx_async_gnnid(scsi_qla_host_t *, fc_port_t *);
-void qla24xx_handle_gnnid_event(scsi_qla_host_t *, struct event_arg *);
-int qla24xx_post_gnnid_work(struct scsi_qla_host *, fc_port_t *);
 int qla24xx_post_gfpnid_work(struct scsi_qla_host *, fc_port_t *);
 int qla24xx_async_gfpnid(scsi_qla_host_t *, fc_port_t *);
 void qla24xx_handle_gfpnid_event(scsi_qla_host_t *, struct event_arg *);
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 9c707d677f648..ece7b064ff968 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -4217,116 +4217,6 @@ void qla_scan_work_fn(struct work_struct *work)
 	spin_unlock_irqrestore(&vha->work_lock, flags);
 }
 
-/* GNN_ID */
-void qla24xx_handle_gnnid_event(scsi_qla_host_t *vha, struct event_arg *ea)
-{
-	qla24xx_post_gnl_work(vha, ea->fcport);
-}
-
-static void qla2x00_async_gnnid_sp_done(srb_t *sp, int res)
-{
-	struct scsi_qla_host *vha = sp->vha;
-	fc_port_t *fcport = sp->fcport;
-	u8 *node_name = fcport->ct_desc.ct_sns->p.rsp.rsp.gnn_id.node_name;
-	struct event_arg ea;
-	u64 wwnn;
-
-	fcport->flags &= ~FCF_ASYNC_SENT;
-	wwnn = wwn_to_u64(node_name);
-	if (wwnn)
-		memcpy(fcport->node_name, node_name, WWN_SIZE);
-
-	memset(&ea, 0, sizeof(ea));
-	ea.fcport = fcport;
-	ea.sp = sp;
-	ea.rc = res;
-
-	ql_dbg(ql_dbg_disc, vha, 0x204f,
-	    "Async done-%s res %x, WWPN %8phC %8phC\n",
-	    sp->name, res, fcport->port_name, fcport->node_name);
-
-	qla24xx_handle_gnnid_event(vha, &ea);
-
-	/* ref: INIT */
-	kref_put(&sp->cmd_kref, qla2x00_sp_release);
-}
-
-int qla24xx_async_gnnid(scsi_qla_host_t *vha, fc_port_t *fcport)
-{
-	int rval = QLA_FUNCTION_FAILED;
-	struct ct_sns_req       *ct_req;
-	srb_t *sp;
-
-	if (!vha->flags.online || (fcport->flags & FCF_ASYNC_SENT))
-		return rval;
-
-	qla2x00_set_fcport_disc_state(fcport, DSC_GNN_ID);
-	/* ref: INIT */
-	sp = qla2x00_get_sp(vha, fcport, GFP_ATOMIC);
-	if (!sp)
-		goto done;
-
-	fcport->flags |= FCF_ASYNC_SENT;
-	sp->type = SRB_CT_PTHRU_CMD;
-	sp->name = "gnnid";
-	sp->gen1 = fcport->rscn_gen;
-	sp->gen2 = fcport->login_gen;
-	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha) + 2,
-			      qla2x00_async_gnnid_sp_done);
-
-	/* CT_IU preamble  */
-	ct_req = qla2x00_prep_ct_req(fcport->ct_desc.ct_sns, GNN_ID_CMD,
-	    GNN_ID_RSP_SIZE);
-
-	/* GNN_ID req */
-	ct_req->req.port_id.port_id = port_id_to_be_id(fcport->d_id);
-
-
-	/* req & rsp use the same buffer */
-	sp->u.iocb_cmd.u.ctarg.req = fcport->ct_desc.ct_sns;
-	sp->u.iocb_cmd.u.ctarg.req_dma = fcport->ct_desc.ct_sns_dma;
-	sp->u.iocb_cmd.u.ctarg.rsp = fcport->ct_desc.ct_sns;
-	sp->u.iocb_cmd.u.ctarg.rsp_dma = fcport->ct_desc.ct_sns_dma;
-	sp->u.iocb_cmd.u.ctarg.req_size = GNN_ID_REQ_SIZE;
-	sp->u.iocb_cmd.u.ctarg.rsp_size = GNN_ID_RSP_SIZE;
-	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
-
-	ql_dbg(ql_dbg_disc, vha, 0xffff,
-	    "Async-%s - %8phC hdl=%x loopid=%x portid %06x.\n",
-	    sp->name, fcport->port_name,
-	    sp->handle, fcport->loop_id, fcport->d_id.b24);
-
-	rval = qla2x00_start_sp(sp);
-	if (rval != QLA_SUCCESS)
-		goto done_free_sp;
-	return rval;
-
-done_free_sp:
-	/* ref: INIT */
-	kref_put(&sp->cmd_kref, qla2x00_sp_release);
-	fcport->flags &= ~FCF_ASYNC_SENT;
-done:
-	return rval;
-}
-
-int qla24xx_post_gnnid_work(struct scsi_qla_host *vha, fc_port_t *fcport)
-{
-	struct qla_work_evt *e;
-	int ls;
-
-	ls = atomic_read(&vha->loop_state);
-	if (((ls != LOOP_READY) && (ls != LOOP_UP)) ||
-		test_bit(UNLOADING, &vha->dpc_flags))
-		return 0;
-
-	e = qla2x00_alloc_work(vha, QLA_EVT_GNNID);
-	if (!e)
-		return QLA_FUNCTION_FAILED;
-
-	e->u.fcport.fcport = fcport;
-	return qla2x00_post_work(vha, e);
-}
-
 /* GPFN_ID */
 void qla24xx_handle_gfpnid_event(scsi_qla_host_t *vha, struct event_arg *ea)
 {
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index d2243f809616d..a62c663543b81 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1723,12 +1723,7 @@ int qla24xx_fcport_handle_login(struct scsi_qla_host *vha, fc_port_t *fcport)
 			}
 			break;
 		default:
-			if (wwn == 0)    {
-				ql_dbg(ql_dbg_disc, vha, 0xffff,
-				    "%s %d %8phC post GNNID\n",
-				    __func__, __LINE__, fcport->port_name);
-				qla24xx_post_gnnid_work(vha, fcport);
-			} else if (fcport->loop_id == FC_NO_LOOP_ID) {
+			if (fcport->loop_id == FC_NO_LOOP_ID) {
 				ql_dbg(ql_dbg_disc, vha, 0x20bd,
 				    "%s %d %8phC post gnl\n",
 				    __func__, __LINE__, fcport->port_name);
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 6f39964099682..c27e64cb4d7e1 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -5531,9 +5531,6 @@ qla2x00_do_work(struct scsi_qla_host *vha)
 		case QLA_EVT_GNNFT_DONE:
 			qla24xx_async_gnnft_done(vha, e->u.iosb.sp);
 			break;
-		case QLA_EVT_GNNID:
-			qla24xx_async_gnnid(vha, e->u.fcport.fcport);
-			break;
 		case QLA_EVT_GFPNID:
 			qla24xx_async_gfpnid(vha, e->u.fcport.fcport);
 			break;
-- 
2.51.0


