Return-Path: <stable+bounces-83882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A8F99CD01
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273781F234C9
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593411AA7A5;
	Mon, 14 Oct 2024 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RXQ6toc+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DCE1A0BE7;
	Mon, 14 Oct 2024 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916054; cv=none; b=MnzDEyluMtlX60GyJ3PQIYbK+q+2kY96yZLPZPJFia0f5hY8DEvN88UKKK9hLvgqC3Giki0/7ddMsO1bQOwc+xLr2pKEgqTnat1nx+NVKgKeu/rk+4ohvUPkjG5LecBe0zuajYwb97Y6TNrlOKmPiwgRDl2CP1/+AVqGhfvtE54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916054; c=relaxed/simple;
	bh=LXRM0KumaN4pKMWeTKcQntDTUVeLZBOOZMuvZaIBJGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j96rSNUEpezcaEl5RsiW7iS1mcd34XNbemAIf58PN6R0hwtGe4Z+VsDcvleOrsza1AnNGU0kh95icyaH+2s7l2T6zGmG+AQDCVsrnR7IWbqq3uQndTAcp/52fuFYzoVhHu3FSPv1CNDI5XS7wA8CTIkxNXJnAIF8t2I0pqrVdcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RXQ6toc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B349C4CECF;
	Mon, 14 Oct 2024 14:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728916053;
	bh=LXRM0KumaN4pKMWeTKcQntDTUVeLZBOOZMuvZaIBJGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RXQ6toc+L/CFGn/bY4IJMvpnf9bHFybwyWWL0B8HmAIK47hEYkJ9bxpk3waXOKVIN
	 347FbzKZywZO+p2yP8REm7OW34VwxyxFzmF2M50qhQP2Q7x+IqV9/5LadWVFIzokyI
	 7M+2UL780tr1xdL1NLwC4iQ68F0lNYdPcTGVrWKI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Tee <justin.tee@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 073/214] scsi: lpfc: Ensure DA_ID handling completion before deleting an NPIV instance
Date: Mon, 14 Oct 2024 16:18:56 +0200
Message-ID: <20241014141047.836753064@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141044.974962104@linuxfoundation.org>
References: <20241014141044.974962104@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit 0a3c84f71680684c1d41abb92db05f95c09111e8 ]

Deleting an NPIV instance requires all fabric ndlps to be released before
an NPIV's resources can be torn down.  Failure to release fabric ndlps
beforehand opens kref imbalance race conditions.  Fix by forcing the DA_ID
to complete synchronously with usage of wait_queue.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20240912232447.45607-6-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_ct.c    | 12 ++++++++++
 drivers/scsi/lpfc/lpfc_disc.h  |  7 ++++++
 drivers/scsi/lpfc/lpfc_vport.c | 43 ++++++++++++++++++++++++++++------
 3 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index 2dedd1493e5ba..1e5db489a00c5 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -1647,6 +1647,18 @@ lpfc_cmpl_ct(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	}
 
 out:
+	/* If the caller wanted a synchronous DA_ID completion, signal the
+	 * wait obj and clear flag to reset the vport.
+	 */
+	if (ndlp->save_flags & NLP_WAIT_FOR_DA_ID) {
+		if (ndlp->da_id_waitq)
+			wake_up(ndlp->da_id_waitq);
+	}
+
+	spin_lock_irq(&ndlp->lock);
+	ndlp->save_flags &= ~NLP_WAIT_FOR_DA_ID;
+	spin_unlock_irq(&ndlp->lock);
+
 	lpfc_ct_free_iocb(phba, cmdiocb);
 	lpfc_nlp_put(ndlp);
 	return;
diff --git a/drivers/scsi/lpfc/lpfc_disc.h b/drivers/scsi/lpfc/lpfc_disc.h
index f82615d87c4bb..f5ae8cc158205 100644
--- a/drivers/scsi/lpfc/lpfc_disc.h
+++ b/drivers/scsi/lpfc/lpfc_disc.h
@@ -90,6 +90,8 @@ enum lpfc_nlp_save_flags {
 	NLP_IN_RECOV_POST_DEV_LOSS	= 0x1,
 	/* wait for outstanding LOGO to cmpl */
 	NLP_WAIT_FOR_LOGO		= 0x2,
+	/* wait for outstanding DA_ID to finish */
+	NLP_WAIT_FOR_DA_ID              = 0x4
 };
 
 struct lpfc_nodelist {
@@ -159,7 +161,12 @@ struct lpfc_nodelist {
 	uint32_t nvme_fb_size; /* NVME target's supported byte cnt */
 #define NVME_FB_BIT_SHIFT 9    /* PRLI Rsp first burst in 512B units. */
 	uint32_t nlp_defer_did;
+
+	/* These wait objects are NPIV specific.  These IOs must complete
+	 * synchronously.
+	 */
 	wait_queue_head_t *logo_waitq;
+	wait_queue_head_t *da_id_waitq;
 };
 
 struct lpfc_node_rrq {
diff --git a/drivers/scsi/lpfc/lpfc_vport.c b/drivers/scsi/lpfc/lpfc_vport.c
index 4439167a51882..7a4d4d8e2ad55 100644
--- a/drivers/scsi/lpfc/lpfc_vport.c
+++ b/drivers/scsi/lpfc/lpfc_vport.c
@@ -626,6 +626,7 @@ lpfc_vport_delete(struct fc_vport *fc_vport)
 	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
 	struct lpfc_hba  *phba = vport->phba;
 	int rc;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(waitq);
 
 	if (vport->port_type == LPFC_PHYSICAL_PORT) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
@@ -679,21 +680,49 @@ lpfc_vport_delete(struct fc_vport *fc_vport)
 	if (!ndlp)
 		goto skip_logo;
 
+	/* Send the DA_ID and Fabric LOGO to cleanup the NPIV fabric entries. */
 	if (ndlp && ndlp->nlp_state == NLP_STE_UNMAPPED_NODE &&
 	    phba->link_state >= LPFC_LINK_UP &&
 	    phba->fc_topology != LPFC_TOPOLOGY_LOOP) {
 		if (vport->cfg_enable_da_id) {
-			/* Send DA_ID and wait for a completion. */
+			/* Send DA_ID and wait for a completion.  This is best
+			 * effort.  If the DA_ID fails, likely the fabric will
+			 * "leak" NportIDs but at least the driver issued the
+			 * command.
+			 */
+			ndlp = lpfc_findnode_did(vport, NameServer_DID);
+			if (!ndlp)
+				goto issue_logo;
+
+			spin_lock_irq(&ndlp->lock);
+			ndlp->da_id_waitq = &waitq;
+			ndlp->save_flags |= NLP_WAIT_FOR_DA_ID;
+			spin_unlock_irq(&ndlp->lock);
+
 			rc = lpfc_ns_cmd(vport, SLI_CTNS_DA_ID, 0, 0);
-			if (rc) {
-				lpfc_printf_log(vport->phba, KERN_WARNING,
-						LOG_VPORT,
-						"1829 CT command failed to "
-						"delete objects on fabric, "
-						"rc %d\n", rc);
+			if (!rc) {
+				wait_event_timeout(waitq,
+				   !(ndlp->save_flags & NLP_WAIT_FOR_DA_ID),
+				   msecs_to_jiffies(phba->fc_ratov * 2000));
 			}
+
+			lpfc_printf_vlog(vport, KERN_INFO, LOG_VPORT | LOG_ELS,
+					 "1829 DA_ID issue status %d. "
+					 "SFlag x%x NState x%x, NFlag x%x "
+					 "Rpi x%x\n",
+					 rc, ndlp->save_flags, ndlp->nlp_state,
+					 ndlp->nlp_flag, ndlp->nlp_rpi);
+
+			/* Remove the waitq and save_flags.  It no
+			 * longer matters if the wake happened.
+			 */
+			spin_lock_irq(&ndlp->lock);
+			ndlp->da_id_waitq = NULL;
+			ndlp->save_flags &= ~NLP_WAIT_FOR_DA_ID;
+			spin_unlock_irq(&ndlp->lock);
 		}
 
+issue_logo:
 		/*
 		 * If the vpi is not registered, then a valid FDISC doesn't
 		 * exist and there is no need for a ELS LOGO.  Just cleanup
-- 
2.43.0




