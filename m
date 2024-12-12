Return-Path: <stable+bounces-103014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C57CC9EF5EB
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF0C189C9AB
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B127222D4E;
	Thu, 12 Dec 2024 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CXF135QU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296862F44;
	Thu, 12 Dec 2024 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023281; cv=none; b=uyeIUjFg2nxt/koweBNCp8/5FlFXUkTQHy5Hau8GiWfszFrtt+MicIzgBqsm6S5Q8EsuBQkkvpkRrtEHs8G5qmuWdN77uhOThMwwWnTlLfIpnde80UJQyE+ldsc6uyjDnRbV0Q9jmvjVN/kJtk8pRp5wmvFV7jujR8jnkEuFuwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023281; c=relaxed/simple;
	bh=hvCDhardSfUCWoHbrHOYob16DGxS5La2+3ayfrY2k1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVB3+reo0F7AiGMHzK1PFDKWX14FmQl3XnJ71NeaUbhE7u2HOISX0cvuwSNe0YeoVTEU/1BiZE+UJ79Xv45j1ZIttGmBrKEOMplPJF7m2Qy5AS9VM7id6umGtH4vjf4EJmVZRTwK4NdlD4YG7mrwN3JLIua+9y6SVi982nwRAI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CXF135QU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2ACC4CECE;
	Thu, 12 Dec 2024 17:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023280;
	bh=hvCDhardSfUCWoHbrHOYob16DGxS5La2+3ayfrY2k1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CXF135QUVz0rfqanAuljc2csrcFKJGIqYPzSB45uYASpqnfchiNU+eglV8HgF6jsu
	 bVnosIpRvm7ZiwRYA03S+P9nID55DoHCvj8QP7B4VRtwUAenmv8Dsv9336fTJFPmZd
	 8bm4k6w0dne9IuugLp1hHGb+fo3CDyO3lWikn5Ks=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Quinn Tran <qutran@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.15 453/565] scsi: qla2xxx: Fix abort in bsg timeout
Date: Thu, 12 Dec 2024 16:00:48 +0100
Message-ID: <20241212144329.627993168@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <qutran@marvell.com>

commit c423263082ee8ccfad59ab33e3d5da5dc004c21e upstream.

Current abort of bsg on timeout prematurely clears the
outstanding_cmds[]. Abort does not allow FW to return the IOCB/SRB. In
addition, bsg_job_done() is not called to return the BSG (i.e. leak).

Abort the outstanding bsg/SRB and wait for the completion. The
completion IOCB will wake up the bsg_timeout thread. If abort is not
successful, then driver will forcibly call bsg_job_done() and free the
srb.

Err Inject:

 - qaucli -z
 - assign CT Passthru IOCB's NportHandle with another initiator
   nport handle to trigger timeout.  Remote port will drop CT request.
 - bsg_job_done is properly called as part of cleanup

kernel: qla2xxx [0000:21:00.1]-7012:7: qla2x00_process_ct : 286 : Error Inject.
kernel: qla2xxx [0000:21:00.1]-7016:7: bsg rqst type: FC_BSG_HST_CT else type: 101 - loop-id=1 portid=fffffa.
kernel: qla2xxx [0000:21:00.1]-70bb:7: qla24xx_bsg_timeout CMD timeout. bsg ptr ffff9971a42f0838 msgcode 80000004 vendor cmd fa010000
kernel: qla2xxx [0000:21:00.1]-507c:7: Abort command issued - hdl=4b, type=5
kernel: qla2xxx [0000:21:00.1]-5040:7: ELS-CT pass-through-ct pass-through error hdl=4b comp_status-status=0x5 error subcode 1=0x0 error subcode 2=0xaf882e80.
kernel: qla2xxx [0000:21:00.1]-7009:7: qla2x00_bsg_job_done: sp hdl 4b, result=70000 bsg ptr ffff9971a42f0838
kernel: qla2xxx [0000:21:00.1]-802c:7: Aborting bsg ffff9971a42f0838 sp=ffff99760b87ba80 handle=4b rval=0
kernel: qla2xxx [0000:21:00.1]-708a:7: bsg abort success. bsg ffff9971a42f0838 sp=ffff99760b87ba80 handle=0x4b
kernel: qla2xxx [0000:21:00.1]-7012:7: qla2x00_process_ct : 286 : Error Inject.
kernel: qla2xxx [0000:21:00.1]-7016:7: bsg rqst type: FC_BSG_HST_CT else type: 101 - loop-id=1 portid=fffffa.
kernel: qla2xxx [0000:21:00.1]-70bb:7: qla24xx_bsg_timeout CMD timeout. bsg ptr ffff9971a42f43b8 msgcode 80000004 vendor cmd fa010000
kernel: qla2xxx [0000:21:00.1]-7012:7: qla_bsg_found : 2206 : Error Inject 2.
kernel: qla2xxx [0000:21:00.1]-802c:7: Aborting bsg ffff9971a42f43b8 sp=ffff99762c304440 handle=5e rval=5
kernel: qla2xxx [0000:21:00.1]-704f:7: bsg abort fail.  bsg=ffff9971a42f43b8 sp=ffff99762c304440 rval=5.
kernel: qla2xxx [0000:21:00.1]-7051:7: qla_bsg_found bsg_job_done : bsg ffff9971a42f43b8 result 0xfffffffa sp ffff99762c304440.

Cc: stable@vger.kernel.org
Fixes: c449b4198701 ("scsi: qla2xxx: Use QP lock to search for bsg")
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20241115130313.46826-2-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_bsg.c |  114 +++++++++++++++++++++++++++++++++--------
 1 file changed, 92 insertions(+), 22 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -24,6 +24,7 @@ void qla2x00_bsg_job_done(srb_t *sp, int
 {
 	struct bsg_job *bsg_job = sp->u.bsg_job;
 	struct fc_bsg_reply *bsg_reply = bsg_job->reply;
+	struct completion *comp = sp->comp;
 
 	ql_dbg(ql_dbg_user, sp->vha, 0x7009,
 	    "%s: sp hdl %x, result=%x bsg ptr %p\n",
@@ -35,6 +36,9 @@ void qla2x00_bsg_job_done(srb_t *sp, int
 	bsg_reply->result = res;
 	bsg_job_done(bsg_job, bsg_reply->result,
 		       bsg_reply->reply_payload_rcv_len);
+
+	if (comp)
+		complete(comp);
 }
 
 void qla2x00_bsg_sp_free(srb_t *sp)
@@ -2968,7 +2972,7 @@ skip_chip_chk:
 
 static bool qla_bsg_found(struct qla_qpair *qpair, struct bsg_job *bsg_job)
 {
-	bool found = false;
+	bool found, do_bsg_done;
 	struct fc_bsg_reply *bsg_reply = bsg_job->reply;
 	scsi_qla_host_t *vha = shost_priv(fc_bsg_to_shost(bsg_job));
 	struct qla_hw_data *ha = vha->hw;
@@ -2976,6 +2980,11 @@ static bool qla_bsg_found(struct qla_qpa
 	int cnt;
 	unsigned long flags;
 	struct req_que *req;
+	int rval;
+	DECLARE_COMPLETION_ONSTACK(comp);
+	uint32_t ratov_j;
+
+	found = do_bsg_done = false;
 
 	spin_lock_irqsave(qpair->qp_lock_ptr, flags);
 	req = qpair->req;
@@ -2987,42 +2996,104 @@ static bool qla_bsg_found(struct qla_qpa
 		     sp->type == SRB_ELS_CMD_HST ||
 		     sp->type == SRB_ELS_CMD_HST_NOLOGIN) &&
 		    sp->u.bsg_job == bsg_job) {
-			req->outstanding_cmds[cnt] = NULL;
-			spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
-
-			if (!ha->flags.eeh_busy && ha->isp_ops->abort_command(sp)) {
-				ql_log(ql_log_warn, vha, 0x7089,
-						"mbx abort_command failed.\n");
-				bsg_reply->result = -EIO;
-			} else {
-				ql_dbg(ql_dbg_user, vha, 0x708a,
-						"mbx abort_command success.\n");
-				bsg_reply->result = 0;
-			}
-			/* ref: INIT */
-			kref_put(&sp->cmd_kref, qla2x00_sp_release);
 
 			found = true;
-			goto done;
+			sp->comp = &comp;
+			break;
 		}
 	}
 	spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
 
-done:
-	return found;
+	if (!found)
+		return false;
+
+	if (ha->flags.eeh_busy) {
+		/* skip over abort.  EEH handling will return the bsg. Wait for it */
+		rval = QLA_SUCCESS;
+		ql_dbg(ql_dbg_user, vha, 0x802c,
+			"eeh encounter. bsg %p sp=%p handle=%x \n",
+			bsg_job, sp, sp->handle);
+	} else {
+		rval = ha->isp_ops->abort_command(sp);
+		ql_dbg(ql_dbg_user, vha, 0x802c,
+			"Aborting bsg %p sp=%p handle=%x rval=%x\n",
+			bsg_job, sp, sp->handle, rval);
+	}
+
+	switch (rval) {
+	case QLA_SUCCESS:
+		/* Wait for the command completion. */
+		ratov_j = ha->r_a_tov / 10 * 4 * 1000;
+		ratov_j = msecs_to_jiffies(ratov_j);
+
+		if (!wait_for_completion_timeout(&comp, ratov_j)) {
+			ql_log(ql_log_info, vha, 0x7089,
+				"bsg abort timeout.  bsg=%p sp=%p handle %#x .\n",
+				bsg_job, sp, sp->handle);
+
+			do_bsg_done = true;
+		} else {
+			/* fw had returned the bsg */
+			ql_dbg(ql_dbg_user, vha, 0x708a,
+				"bsg abort success. bsg %p sp=%p handle=%#x\n",
+				bsg_job, sp, sp->handle);
+			do_bsg_done = false;
+		}
+		break;
+	default:
+		ql_log(ql_log_info, vha, 0x704f,
+			"bsg abort fail.  bsg=%p sp=%p rval=%x.\n",
+			bsg_job, sp, rval);
+
+		do_bsg_done = true;
+		break;
+	}
+
+	if (!do_bsg_done)
+		return true;
+
+	spin_lock_irqsave(qpair->qp_lock_ptr, flags);
+	/*
+	 * recheck to make sure it's still the same bsg_job due to
+	 * qp_lock_ptr was released earlier.
+	 */
+	if (req->outstanding_cmds[cnt] &&
+	    req->outstanding_cmds[cnt]->u.bsg_job != bsg_job) {
+		/* fw had returned the bsg */
+		spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
+		return true;
+	}
+	req->outstanding_cmds[cnt] = NULL;
+	spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
+
+	/* ref: INIT */
+	sp->comp = NULL;
+	kref_put(&sp->cmd_kref, qla2x00_sp_release);
+	bsg_reply->result = -ENXIO;
+	bsg_reply->reply_payload_rcv_len = 0;
+
+	ql_dbg(ql_dbg_user, vha, 0x7051,
+	       "%s bsg_job_done : bsg %p result %#x sp %p.\n",
+	       __func__, bsg_job, bsg_reply->result, sp);
+
+	bsg_job_done(bsg_job, bsg_reply->result, bsg_reply->reply_payload_rcv_len);
+
+	return true;
 }
 
 int
 qla24xx_bsg_timeout(struct bsg_job *bsg_job)
 {
-	struct fc_bsg_reply *bsg_reply = bsg_job->reply;
+	struct fc_bsg_request *bsg_request = bsg_job->request;
 	scsi_qla_host_t *vha = shost_priv(fc_bsg_to_shost(bsg_job));
 	struct qla_hw_data *ha = vha->hw;
 	int i;
 	struct qla_qpair *qpair;
 
-	ql_log(ql_log_info, vha, 0x708b, "%s CMD timeout. bsg ptr %p.\n",
-	    __func__, bsg_job);
+	ql_log(ql_log_info, vha, 0x708b,
+	       "%s CMD timeout. bsg ptr %p msgcode %x vendor cmd %x\n",
+	       __func__, bsg_job, bsg_request->msgcode,
+	       bsg_request->rqst_data.h_vendor.vendor_cmd[0]);
 
 	if (qla2x00_isp_reg_stat(ha)) {
 		ql_log(ql_log_info, vha, 0x9007,
@@ -3043,7 +3114,6 @@ qla24xx_bsg_timeout(struct bsg_job *bsg_
 	}
 
 	ql_log(ql_log_info, vha, 0x708b, "SRB not found to abort.\n");
-	bsg_reply->result = -ENXIO;
 
 done:
 	return 0;



