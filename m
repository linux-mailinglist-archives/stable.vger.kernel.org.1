Return-Path: <stable+bounces-77299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9720E985B8E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B981F1C24449
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93A01C175B;
	Wed, 25 Sep 2024 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrlZ/LkE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBBC1C174F;
	Wed, 25 Sep 2024 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265032; cv=none; b=llCHoVoX5uJ8ORFd/M/9i9rZeAk9raDuIxOUIG9SWfvh22r8dTmQuobzPzvn5gAlhgktPSgXzPlKoKBKLx1zzPofK29VZ7eWA5rMrEUZfqr2hTzCaD2mF9doidEUDsX1zfd/w2nBdLDH9WU12X05ZPgzsr3KKepsBIpMl9oCLoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265032; c=relaxed/simple;
	bh=LbM851jqsM4UITezS3ckq6w0KqE1dia4asWnahhzV3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLZbhvXziPlujnv6ROFAYvERMbxIOsyHVzz9Fh8fbgDG3RLxuxtEoDvGxWbt9Q5SVWSySvIXxHJwu8QY45dTlrxfFSgft2LQ37m8b6t13+NgV04hOpfqB30WVXTMkra7fLbQKnxN5r2jCgwoJev0YLhS3QA/1RvQwm4CrtOl5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrlZ/LkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493BBC4CEC7;
	Wed, 25 Sep 2024 11:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265030;
	bh=LbM851jqsM4UITezS3ckq6w0KqE1dia4asWnahhzV3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mrlZ/LkEPhsZMKGxzbaBu6s84O8kxslEdk1DmwIPhdxxqSb/rha3ETlMm7eQ3DfUR
	 q+ViEm6o5dGf9xFkMyLMzvPaCoLImKggfp1Uz7fd1oVBdLbubIYK3KbrVYevqDQf3O
	 JJXWI0QtNBP9E75PtXnI3bvebbdJHmo6cHB9RDW/PDbQcKzQap4YJSTrFdmyJD7zE9
	 vHNgxVNqJMD2XT6HnQUpIYmlUI5Nahx8kOxnRb3H4xsU/q4MWhvojdE7mdlZ2HNGT9
	 1nMvhkJzFylz8TZEx6X1D++X60K+i+4DgSd7D0TctCqNMLRz74kP0BMB+4Qf1DE1Zb
	 3MVbD24SJF3ng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Justin Tee <justin.tee@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	James.Bottomley@HansenPartnership.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 200/244] scsi: lpfc: Fix unsolicited FLOGI kref imbalance when in direct attached topology
Date: Wed, 25 Sep 2024 07:27:01 -0400
Message-ID: <20240925113641.1297102-200-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit b5c18c9dd138733c16893613345af44deadcf05e ]

In direct attached topology, certain target vendors that are quick to issue
FLOGI followed by a cable pull for more than dev_loss_tmo may result in a
kref imbalance for the remote port ndlp object.

Add an nlp_get when the defer_flogi_acc flag is set.  This is expected to
balance the nlp_put in the defer_flogi_acc clause in the
lpfc_issue_els_flogi() routine.  Because we need to retain the ndlp ptr,
reorganize all of the defer_flogi_acc information into one
lpfc_defer_flogi_acc struct.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20240726231512.92867-6-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc.h         | 12 ++++++---
 drivers/scsi/lpfc/lpfc_els.c     | 46 +++++++++++++++++++-------------
 drivers/scsi/lpfc/lpfc_hbadisc.c | 11 ++++++--
 3 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 7c147d6ea8a8f..e5a9c5a323f8b 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -306,6 +306,14 @@ struct lpfc_stats {
 
 struct lpfc_hba;
 
+/* Data structure to keep withheld FLOGI_ACC information */
+struct lpfc_defer_flogi_acc {
+	bool flag;
+	u16 rx_id;
+	u16 ox_id;
+	struct lpfc_nodelist *ndlp;
+
+};
 
 #define LPFC_VMID_TIMER   300	/* timer interval in seconds */
 
@@ -1430,9 +1438,7 @@ struct lpfc_hba {
 	uint16_t vlan_id;
 	struct list_head fcf_conn_rec_list;
 
-	bool defer_flogi_acc_flag;
-	uint16_t defer_flogi_acc_rx_id;
-	uint16_t defer_flogi_acc_ox_id;
+	struct lpfc_defer_flogi_acc defer_flogi_acc;
 
 	spinlock_t ct_ev_lock; /* synchronize access to ct_ev_waiters */
 	struct list_head ct_ev_waiters;
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 929cbfc95163b..8c0926ffee1bf 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -1390,7 +1390,7 @@ lpfc_issue_els_flogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	phba->link_flag &= ~LS_EXTERNAL_LOOPBACK;
 
 	/* Check for a deferred FLOGI ACC condition */
-	if (phba->defer_flogi_acc_flag) {
+	if (phba->defer_flogi_acc.flag) {
 		/* lookup ndlp for received FLOGI */
 		ndlp = lpfc_findnode_did(vport, 0);
 		if (!ndlp)
@@ -1404,34 +1404,38 @@ lpfc_issue_els_flogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		if (phba->sli_rev == LPFC_SLI_REV4) {
 			bf_set(wqe_ctxt_tag,
 			       &defer_flogi_acc.wqe.xmit_els_rsp.wqe_com,
-			       phba->defer_flogi_acc_rx_id);
+			       phba->defer_flogi_acc.rx_id);
 			bf_set(wqe_rcvoxid,
 			       &defer_flogi_acc.wqe.xmit_els_rsp.wqe_com,
-			       phba->defer_flogi_acc_ox_id);
+			       phba->defer_flogi_acc.ox_id);
 		} else {
 			icmd = &defer_flogi_acc.iocb;
-			icmd->ulpContext = phba->defer_flogi_acc_rx_id;
+			icmd->ulpContext = phba->defer_flogi_acc.rx_id;
 			icmd->unsli3.rcvsli3.ox_id =
-				phba->defer_flogi_acc_ox_id;
+				phba->defer_flogi_acc.ox_id;
 		}
 
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 				 "3354 Xmit deferred FLOGI ACC: rx_id: x%x,"
 				 " ox_id: x%x, hba_flag x%lx\n",
-				 phba->defer_flogi_acc_rx_id,
-				 phba->defer_flogi_acc_ox_id, phba->hba_flag);
+				 phba->defer_flogi_acc.rx_id,
+				 phba->defer_flogi_acc.ox_id, phba->hba_flag);
 
 		/* Send deferred FLOGI ACC */
 		lpfc_els_rsp_acc(vport, ELS_CMD_FLOGI, &defer_flogi_acc,
 				 ndlp, NULL);
 
-		phba->defer_flogi_acc_flag = false;
-		vport->fc_myDID = did;
+		phba->defer_flogi_acc.flag = false;
 
-		/* Decrement ndlp reference count to indicate the node can be
-		 * released when other references are removed.
+		/* Decrement the held ndlp that was incremented when the
+		 * deferred flogi acc flag was set.
 		 */
-		lpfc_nlp_put(ndlp);
+		if (phba->defer_flogi_acc.ndlp) {
+			lpfc_nlp_put(phba->defer_flogi_acc.ndlp);
+			phba->defer_flogi_acc.ndlp = NULL;
+		}
+
+		vport->fc_myDID = did;
 	}
 
 	return 0;
@@ -8454,9 +8458,9 @@ lpfc_els_rcv_flogi(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 
 	/* Defer ACC response until AFTER we issue a FLOGI */
 	if (!test_bit(HBA_FLOGI_ISSUED, &phba->hba_flag)) {
-		phba->defer_flogi_acc_rx_id = bf_get(wqe_ctxt_tag,
+		phba->defer_flogi_acc.rx_id = bf_get(wqe_ctxt_tag,
 						     &wqe->xmit_els_rsp.wqe_com);
-		phba->defer_flogi_acc_ox_id = bf_get(wqe_rcvoxid,
+		phba->defer_flogi_acc.ox_id = bf_get(wqe_rcvoxid,
 						     &wqe->xmit_els_rsp.wqe_com);
 
 		vport->fc_myDID = did;
@@ -8464,11 +8468,17 @@ lpfc_els_rcv_flogi(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 				 "3344 Deferring FLOGI ACC: rx_id: x%x,"
 				 " ox_id: x%x, hba_flag x%lx\n",
-				 phba->defer_flogi_acc_rx_id,
-				 phba->defer_flogi_acc_ox_id, phba->hba_flag);
+				 phba->defer_flogi_acc.rx_id,
+				 phba->defer_flogi_acc.ox_id, phba->hba_flag);
 
-		phba->defer_flogi_acc_flag = true;
+		phba->defer_flogi_acc.flag = true;
 
+		/* This nlp_get is paired with nlp_puts that reset the
+		 * defer_flogi_acc.flag back to false.  We need to retain
+		 * a kref on the ndlp until the deferred FLOGI ACC is
+		 * processed or cancelled.
+		 */
+		phba->defer_flogi_acc.ndlp = lpfc_nlp_get(ndlp);
 		return 0;
 	}
 
@@ -10504,7 +10514,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 
 		lpfc_els_rcv_flogi(vport, elsiocb, ndlp);
 		/* retain node if our response is deferred */
-		if (phba->defer_flogi_acc_flag)
+		if (phba->defer_flogi_acc.flag)
 			break;
 		if (newnode)
 			lpfc_disc_state_machine(vport, ndlp, NULL,
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index f21c5993e8d72..35c9181c6608a 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -1255,7 +1255,14 @@ lpfc_linkdown(struct lpfc_hba *phba)
 	lpfc_scsi_dev_block(phba);
 	offline = pci_channel_offline(phba->pcidev);
 
-	phba->defer_flogi_acc_flag = false;
+	/* Decrement the held ndlp if there is a deferred flogi acc */
+	if (phba->defer_flogi_acc.flag) {
+		if (phba->defer_flogi_acc.ndlp) {
+			lpfc_nlp_put(phba->defer_flogi_acc.ndlp);
+			phba->defer_flogi_acc.ndlp = NULL;
+		}
+	}
+	phba->defer_flogi_acc.flag = false;
 
 	/* Clear external loopback plug detected flag */
 	phba->link_flag &= ~LS_EXTERNAL_LOOPBACK;
@@ -1377,7 +1384,7 @@ lpfc_linkup_port(struct lpfc_vport *vport)
 		(vport != phba->pport))
 		return;
 
-	if (phba->defer_flogi_acc_flag) {
+	if (phba->defer_flogi_acc.flag) {
 		clear_bit(FC_ABORT_DISCOVERY, &vport->fc_flag);
 		clear_bit(FC_RSCN_MODE, &vport->fc_flag);
 		clear_bit(FC_NLP_MORE, &vport->fc_flag);
-- 
2.43.0


