Return-Path: <stable+bounces-63809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADAA941ABF
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCB41C22AD2
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A2718990F;
	Tue, 30 Jul 2024 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bTPcuzs+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88349183CD5;
	Tue, 30 Jul 2024 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358022; cv=none; b=A5GpaiUCg/5Dd1ZVUppVWdGSKHqREUdhhonA4Ag09Tt+2QaRtCtQOFyQRglM2UaiDJDHVCWdJzYNceDTPjXn52GQUnp2PAThF1fDliPfljbmjOp+vQohD6vYkZWvYay/TBRb6R5cRajdeUvTY5BvaNlG1IBsTOuWavQmPfF6V4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358022; c=relaxed/simple;
	bh=yZJnf8et525kgGftER6eYFQc1J8vI96EDviips4mmZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4fA23i+evnaX1v05ZXNFk7WsSqaX9iajHJKP2CQjc5lEkiCg7qUfqvGeaR34NHDvR8sEEdUMomxDewcuGrpfeVVfjD+B5iv2oDQy3arriBVEBXtF2/PmUw6/FLvIY5jLO375+w+RZL8OPAhFIshbkwJrkqahCRGFgLvH6yhXlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bTPcuzs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7F3C32782;
	Tue, 30 Jul 2024 16:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722358022;
	bh=yZJnf8et525kgGftER6eYFQc1J8vI96EDviips4mmZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bTPcuzs+99yBhx8dx7Xr+uQYUr/vwVQY9JlOvq68VLd2DvQ2nAjuKUN4SL9chpIEg
	 YwV9j9WvjtC1Fa06+aqD09/yQbg/pT+6heyPei+aXqUtCqb+o3Cx03noGAVV9XL2eh
	 onn/SulTTRwx5qw8P7/OfSUMAmyb65UWH8Gevjh4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Quinn Tran <qutran@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 349/440] scsi: qla2xxx: Use QP lock to search for bsg
Date: Tue, 30 Jul 2024 17:49:42 +0200
Message-ID: <20240730151629.442148043@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <qutran@marvell.com>

commit c449b4198701d828e40d60a2abd30970b74a1d75 upstream.

On bsg timeout, hardware_lock is used as part of search for the srb.
Instead, qpair lock should be used to iterate through different qpair.

Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20240710171057.35066-11-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_bsg.c |   96 ++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 39 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -3059,17 +3059,61 @@ skip_chip_chk:
 	return ret;
 }
 
-int
-qla24xx_bsg_timeout(struct bsg_job *bsg_job)
+static bool qla_bsg_found(struct qla_qpair *qpair, struct bsg_job *bsg_job)
 {
+	bool found = false;
 	struct fc_bsg_reply *bsg_reply = bsg_job->reply;
 	scsi_qla_host_t *vha = shost_priv(fc_bsg_to_shost(bsg_job));
 	struct qla_hw_data *ha = vha->hw;
-	srb_t *sp;
-	int cnt, que;
+	srb_t *sp = NULL;
+	int cnt;
 	unsigned long flags;
 	struct req_que *req;
 
+	spin_lock_irqsave(qpair->qp_lock_ptr, flags);
+	req = qpair->req;
+
+	for (cnt = 1; cnt < req->num_outstanding_cmds; cnt++) {
+		sp = req->outstanding_cmds[cnt];
+		if (sp &&
+		    (sp->type == SRB_CT_CMD ||
+		     sp->type == SRB_ELS_CMD_HST ||
+		     sp->type == SRB_ELS_CMD_HST_NOLOGIN) &&
+		    sp->u.bsg_job == bsg_job) {
+			req->outstanding_cmds[cnt] = NULL;
+			spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
+
+			if (!ha->flags.eeh_busy && ha->isp_ops->abort_command(sp)) {
+				ql_log(ql_log_warn, vha, 0x7089,
+						"mbx abort_command failed.\n");
+				bsg_reply->result = -EIO;
+			} else {
+				ql_dbg(ql_dbg_user, vha, 0x708a,
+						"mbx abort_command success.\n");
+				bsg_reply->result = 0;
+			}
+			/* ref: INIT */
+			kref_put(&sp->cmd_kref, qla2x00_sp_release);
+
+			found = true;
+			goto done;
+		}
+	}
+	spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
+
+done:
+	return found;
+}
+
+int
+qla24xx_bsg_timeout(struct bsg_job *bsg_job)
+{
+	struct fc_bsg_reply *bsg_reply = bsg_job->reply;
+	scsi_qla_host_t *vha = shost_priv(fc_bsg_to_shost(bsg_job));
+	struct qla_hw_data *ha = vha->hw;
+	int i;
+	struct qla_qpair *qpair;
+
 	ql_log(ql_log_info, vha, 0x708b, "%s CMD timeout. bsg ptr %p.\n",
 	    __func__, bsg_job);
 
@@ -3079,48 +3123,22 @@ qla24xx_bsg_timeout(struct bsg_job *bsg_
 		qla_pci_set_eeh_busy(vha);
 	}
 
+	if (qla_bsg_found(ha->base_qpair, bsg_job))
+		goto done;
+
 	/* find the bsg job from the active list of commands */
-	spin_lock_irqsave(&ha->hardware_lock, flags);
-	for (que = 0; que < ha->max_req_queues; que++) {
-		req = ha->req_q_map[que];
-		if (!req)
+	for (i = 0; i < ha->max_qpairs; i++) {
+		qpair = vha->hw->queue_pair_map[i];
+		if (!qpair)
 			continue;
-
-		for (cnt = 1; cnt < req->num_outstanding_cmds; cnt++) {
-			sp = req->outstanding_cmds[cnt];
-			if (sp &&
-			    (sp->type == SRB_CT_CMD ||
-			     sp->type == SRB_ELS_CMD_HST ||
-			     sp->type == SRB_ELS_CMD_HST_NOLOGIN ||
-			     sp->type == SRB_FXIOCB_BCMD) &&
-			    sp->u.bsg_job == bsg_job) {
-				req->outstanding_cmds[cnt] = NULL;
-				spin_unlock_irqrestore(&ha->hardware_lock, flags);
-
-				if (!ha->flags.eeh_busy && ha->isp_ops->abort_command(sp)) {
-					ql_log(ql_log_warn, vha, 0x7089,
-					    "mbx abort_command failed.\n");
-					bsg_reply->result = -EIO;
-				} else {
-					ql_dbg(ql_dbg_user, vha, 0x708a,
-					    "mbx abort_command success.\n");
-					bsg_reply->result = 0;
-				}
-				spin_lock_irqsave(&ha->hardware_lock, flags);
-				goto done;
-
-			}
-		}
+		if (qla_bsg_found(qpair, bsg_job))
+			goto done;
 	}
-	spin_unlock_irqrestore(&ha->hardware_lock, flags);
+
 	ql_log(ql_log_info, vha, 0x708b, "SRB not found to abort.\n");
 	bsg_reply->result = -ENXIO;
-	return 0;
 
 done:
-	spin_unlock_irqrestore(&ha->hardware_lock, flags);
-	/* ref: INIT */
-	kref_put(&sp->cmd_kref, qla2x00_sp_release);
 	return 0;
 }
 



