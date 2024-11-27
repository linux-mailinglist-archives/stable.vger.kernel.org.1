Return-Path: <stable+bounces-95636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE949DAB88
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 17:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD0A1650A8
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 16:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E08288D1;
	Wed, 27 Nov 2024 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecbBfkhD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22455200B8E
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724107; cv=none; b=l0jqGg72HviE7CXJGqacdxhCkeXToldEelZ93VibQIbbgfIsSw99iZaQ5bzJRdMeamwp4uVtDShYtLoT6Z61uw3U++lOjWps+K2ushqGRIRY25yJEN1X3MejHz2WXZFKhOzt2VH2HwriHssm2h/6iyQ9dqfVK55TvL7+sDry32k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724107; c=relaxed/simple;
	bh=zq51z8q1D9+djyAagLu/lgx479PDAUQkgFiV6D/bSfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYFowY0Q5O9FFUKt/hCGTbU6SJ7TrUv7AQNunM4adb7PrpbIQbkbshGKd6TBWoxIwnz4PbPrUaTd2jJ6Q8A1c3tLUlzMfuEY6g3mR4VrHlb33tcxk5Wav3NbUZ3ULlO2iuvnTHl102KYQH6f5PQADc9NPgcun9dXagDNS1VnO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecbBfkhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5086FC4CECC;
	Wed, 27 Nov 2024 16:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732724106;
	bh=zq51z8q1D9+djyAagLu/lgx479PDAUQkgFiV6D/bSfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ecbBfkhD4jrSmR0BM5KIZHm/47api0DVhta2zWHUHFEHsSusdNOfq23+48kKd6KtN
	 fZtXKOF4TrMHCZD8Sna+gaZK2It/MGR7+Xl40ep1wizQk02BT07/a61K8FZwA5gELj
	 A+HEbvY4wrFVWMfa9b1Chv/RNERp2V1HM+CVAxrRrIceZqCSTl3nMhwaI8V7vhtxHt
	 jgLq4WiePEXhfjmHx4VcBqxsvuePf6NMSXCM0YrVdw6DZSrBSZIJdY9+2EUWWYcJqh
	 uPgBe6cZpHsUwuL+YQjT241DIGczp/TTK5+bfVqdKIg7t1/8i0U5x8V8vGaE87gIdj
	 /onQRRYOKyzGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] scsi: lpfc: Validate hdwq pointers before dereferencing in reset/errata paths
Date: Wed, 27 Nov 2024 11:15:05 -0500
Message-ID: <20241127081238-28bfd69573da6299@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241127100237.1138842-2-xiangyu.chen@eng.windriver.com>
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

Note: The patch differs from the upstream commit:
---
--- -	2024-11-27 08:04:07.591042523 -0500
+++ /tmp/tmp.ruHMJiW1bw	2024-11-27 08:04:07.586423956 -0500
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
+index 0a01575ab06d..0ad8a10002ce 100644
 --- a/drivers/scsi/lpfc/lpfc_hbadisc.c
 +++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
 @@ -175,7 +175,8 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
  			 ndlp->nlp_state, ndlp->fc4_xpt_flags);
  
  	/* Don't schedule a worker thread event if the vport is going down. */
--	if (test_bit(FC_UNLOADING, &vport->load_flag)) {
-+	if (test_bit(FC_UNLOADING, &vport->load_flag) ||
-+	    !test_bit(HBA_SETUP, &phba->hba_flag)) {
+-	if (vport->load_flag & FC_UNLOADING) {
++	if ((vport->load_flag & FC_UNLOADING) ||
++	    !(phba->hba_flag & HBA_SETUP)) {
  		spin_lock_irqsave(&ndlp->lock, iflags);
  		ndlp->rport = NULL;
  
 diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
-index 98ce9d97a2257..60cd60ebff38e 100644
+index cf506556f3b0..070654cc9292 100644
 --- a/drivers/scsi/lpfc/lpfc_scsi.c
 +++ b/drivers/scsi/lpfc/lpfc_scsi.c
-@@ -5555,11 +5555,20 @@ lpfc_abort_handler(struct scsi_cmnd *cmnd)
+@@ -5546,11 +5546,20 @@ lpfc_abort_handler(struct scsi_cmnd *cmnd)
  
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
+index 9cd22588c8eb..9b1ffa84a062 100644
 --- a/drivers/scsi/lpfc/lpfc_sli.c
 +++ b/drivers/scsi/lpfc/lpfc_sli.c
-@@ -4687,6 +4687,17 @@ lpfc_sli_flush_io_rings(struct lpfc_hba *phba)
+@@ -4684,6 +4684,17 @@ lpfc_sli_flush_io_rings(struct lpfc_hba *phba)
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
| stable/linux-6.6.y        |  Success    |  Success   |

