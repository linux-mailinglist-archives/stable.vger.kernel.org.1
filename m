Return-Path: <stable+bounces-95644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2AC9DAB90
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 17:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F4A165204
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 16:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419DB1FF7DB;
	Wed, 27 Nov 2024 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpkmyH+2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01144200B89
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724121; cv=none; b=nO7ln93eix3+fbjCvmQEC7v6zq/A3KwVmbkErcXX7RD8mG8wmZDAO6GUXdPN0E2fIBHlVXwb82sxaN3jHqDdJFYSsLz1eqLkeDJD6KH3+9+9B2iJcAzm4e2X+h9C7Va0vCEyFWAkZ5SaATTv+0IFTcnvWITiRYi7YdarAsl/kNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724121; c=relaxed/simple;
	bh=19XhEJcnBxjTMLPyJsmE73cujDsMmkYLMJnNhHHN/h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXg5rU6UQU5v1x+K7qiR5VAYeaaEQHNfkO4gQNhNaiAAwbasTU9BHVej2u0YsHptGxVR4HTxWNmRgTtvNBtHMVG2DcMXxCO7X6f2jxZaIaxXb3eCKNi0OX6RHhYkVUuvLyjvwj82j0l1l+x0S9tNz7MgaXxO2/wrsA4aIMiumwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpkmyH+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C8FC4CED3;
	Wed, 27 Nov 2024 16:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732724120;
	bh=19XhEJcnBxjTMLPyJsmE73cujDsMmkYLMJnNhHHN/h0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RpkmyH+2RbgYgBx1/r6Jf4anW8udybxXwNbu8a3SE/NXyyz9d4ZrPK1OsC/j+4qcg
	 YhYFldOaLdhO4S/pbNAfG/h8tvT+sWbXOOFCdatCwmlcjux6yIyHrHyCOXYfA/PyhS
	 66YrCAPRw8Uxanx6quwHmuVyGN8ar1DSI+RU8ze0RFBZC8Fi6c8QHgwfdXfTmfohb7
	 W1ITXBiT8joLSdnzd7I8SXLyYB2yCl2yZEB0t08O/48mfg075k3191QtTG2uyiPn4s
	 07rYMKkkYsbv7WGxXOTIXpZ8zSTh2KEQCCCEBVyklrxnBabdGp9+UG4fQPgoet66CL
	 btdrQqWN/SK6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 1/1] scsi: lpfc: Validate hdwq pointers before dereferencing in reset/errata paths
Date: Wed, 27 Nov 2024 11:15:19 -0500
Message-ID: <20241127074906-0aa0d5ee47813adc@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241127100237.1138842-1-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 2be1d4f11944cd6283cb97268b3e17c4424945ca

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Justin Tee <justin.tee@broadcom.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: fd665c8dbdb1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-27 07:44:21.246175065 -0500
+++ /tmp/tmp.PTEqkEQ2h7	2024-11-27 07:44:21.238682123 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 2be1d4f11944cd6283cb97268b3e17c4424945ca ]
+
 When the HBA is undergoing a reset or is handling an errata event, NULL ptr
 dereference crashes may occur in routines such as
 lpfc_sli_flush_io_rings(), lpfc_dev_loss_tmo_callbk(), or
@@ -9,6 +11,9 @@
 Signed-off-by: Justin Tee <justin.tee@broadcom.com>
 Link: https://lore.kernel.org/r/20240726231512.92867-4-justintee8345@gmail.com
 Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+[Xiangyu: BP to fix CVE: CVE-2024-49891, no test_bit() conflict resolution]
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
  drivers/scsi/lpfc/lpfc_hbadisc.c |  3 ++-
  drivers/scsi/lpfc/lpfc_scsi.c    | 13 +++++++++++--
@@ -16,24 +21,24 @@
  3 files changed, 24 insertions(+), 3 deletions(-)
 
 diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
-index 6943f6c6395c4..f21c5993e8d72 100644
+index aaa98a006fdc..d3a5f10b8b83 100644
 --- a/drivers/scsi/lpfc/lpfc_hbadisc.c
 +++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
-@@ -175,7 +175,8 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
- 			 ndlp->nlp_state, ndlp->fc4_xpt_flags);
- 
- 	/* Don't schedule a worker thread event if the vport is going down. */
--	if (test_bit(FC_UNLOADING, &vport->load_flag)) {
-+	if (test_bit(FC_UNLOADING, &vport->load_flag) ||
-+	    !test_bit(HBA_SETUP, &phba->hba_flag)) {
- 		spin_lock_irqsave(&ndlp->lock, iflags);
+@@ -177,7 +177,8 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
+ 	/* Don't schedule a worker thread event if the vport is going down.
+ 	 * The teardown process cleans up the node via lpfc_drop_node.
+ 	 */
+-	if (vport->load_flag & FC_UNLOADING) {
++	if ((vport->load_flag & FC_UNLOADING) ||
++	    !(phba->hba_flag & HBA_SETUP)) {
+ 		((struct lpfc_rport_data *)rport->dd_data)->pnode = NULL;
  		ndlp->rport = NULL;
  
 diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
-index 98ce9d97a2257..60cd60ebff38e 100644
+index 2a81a42de5c1..ed32aa01c711 100644
 --- a/drivers/scsi/lpfc/lpfc_scsi.c
 +++ b/drivers/scsi/lpfc/lpfc_scsi.c
-@@ -5555,11 +5555,20 @@ lpfc_abort_handler(struct scsi_cmnd *cmnd)
+@@ -5554,11 +5554,20 @@ lpfc_abort_handler(struct scsi_cmnd *cmnd)
  
  	iocb = &lpfc_cmd->cur_iocbq;
  	if (phba->sli_rev == LPFC_SLI_REV4) {
@@ -48,7 +53,7 @@
 +					 "HBA_SETUP %d\n", FAILED,
 +					 cmnd->device->id,
 +					 (u64)cmnd->device->lun,
-+					 test_bit(HBA_SETUP, &phba->hba_flag));
++					 (HBA_SETUP & phba->hba_flag));
  			ret = FAILED;
  			goto out_unlock_hba;
  		}
@@ -57,10 +62,10 @@
  	}
  	/* the command is in process of being cancelled */
 diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
-index d240bbded4c8f..332b8d2348e9e 100644
+index 587e3c2f7c48..1e04b6fc127a 100644
 --- a/drivers/scsi/lpfc/lpfc_sli.c
 +++ b/drivers/scsi/lpfc/lpfc_sli.c
-@@ -4687,6 +4687,17 @@ lpfc_sli_flush_io_rings(struct lpfc_hba *phba)
+@@ -4668,6 +4668,17 @@ lpfc_sli_flush_io_rings(struct lpfc_hba *phba)
  	/* Look on all the FCP Rings for the iotag */
  	if (phba->sli_rev >= LPFC_SLI_REV4) {
  		for (i = 0; i < phba->cfg_hdw_queue; i++) {
@@ -69,8 +74,8 @@
 +				lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
 +						"7777 hdwq's deleted %lx "
 +						"%lx %x %x\n",
-+						phba->pport->load_flag,
-+						phba->hba_flag,
++						(unsigned long)phba->pport->load_flag,
++						(unsigned long)phba->hba_flag,
 +						phba->link_state,
 +						phba->sli.sli_flag);
 +				return;
@@ -78,3 +83,6 @@
  			pring = phba->sli4_hba.hdwq[i].io_wq->pring;
  
  			spin_lock_irq(&pring->ring_lock);
+-- 
+2.25.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

