Return-Path: <stable+bounces-44491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FAA8C5320
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30C51F22F6A
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AE513AD32;
	Tue, 14 May 2024 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hsr1Xhnc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48F25B5D3;
	Tue, 14 May 2024 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686316; cv=none; b=UzF7nkUctnKUQXzQkFYm1y+RdiYjQeSyY+6GKed7luxzDKOTRm8SoGJbxs3JjUXbeWNyIQ8nYvj1hPzTFL+tcCMPpluJZ/PV/xnGRHxpf4TYu/8XxOFH68fZhF1hCrKXLonsOhTtS2sKhCgaR3gmX+Z0e6S9XiKnywTArA5uW34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686316; c=relaxed/simple;
	bh=LdciBv+kl6uxNtOO/jXv925l4zLpOg2eWWOGlECN5S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvZDLK2SY0yxSnFUtyxuFZMz8feveZ1/eU8H9Ed9GPYf+sSQ+yUedyRsW2qgyoxDugsN2Kpyt+rZlbN5mWzS1YNLDnncmyCDqXQFbPBHRw5PPMmP/oRmzri6sLLEWECp2bK14KEW5eKHMAUqTuagy+5Cxzpg+8trc8gF7YiJOtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hsr1Xhnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D19C2BD10;
	Tue, 14 May 2024 11:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715686315;
	bh=LdciBv+kl6uxNtOO/jXv925l4zLpOg2eWWOGlECN5S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hsr1Xhnc/7kwmDh3Y8WlV4VdBpUWWsvSEJ6ZMixcImjz988mwSubZxf3rPPGPKxDb
	 7phU6nTMkj1I1pGm9UKz7snQ9T3m7R/k/A9NQBEjc7YVwO+rSrhpf3cNnxbRcoj5ex
	 EG1wRTkmgP2ZP9GBX3afgEeCM+eF5ziOBdpOCY4E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Tee <justin.tee@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 096/236] scsi: lpfc: Release hbalock before calling lpfc_worker_wake_up()
Date: Tue, 14 May 2024 12:17:38 +0200
Message-ID: <20240514101024.016913286@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101020.320785513@linuxfoundation.org>
References: <20240514101020.320785513@linuxfoundation.org>
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

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit ded20192dff31c91cef2a04f7e20e60e9bb887d3 ]

lpfc_worker_wake_up() calls the lpfc_work_done() routine, which takes the
hbalock.  Thus, lpfc_worker_wake_up() should not be called while holding the
hbalock to avoid potential deadlock.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20240305200503.57317-7-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_els.c     | 20 ++++++++++----------
 drivers/scsi/lpfc/lpfc_hbadisc.c |  5 ++---
 drivers/scsi/lpfc/lpfc_sli.c     | 14 +++++++-------
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 6b5ce9869e6b4..05764008f6e70 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -4384,23 +4384,23 @@ lpfc_els_retry_delay(struct timer_list *t)
 	unsigned long flags;
 	struct lpfc_work_evt  *evtp = &ndlp->els_retry_evt;
 
+	/* Hold a node reference for outstanding queued work */
+	if (!lpfc_nlp_get(ndlp))
+		return;
+
 	spin_lock_irqsave(&phba->hbalock, flags);
 	if (!list_empty(&evtp->evt_listp)) {
 		spin_unlock_irqrestore(&phba->hbalock, flags);
+		lpfc_nlp_put(ndlp);
 		return;
 	}
 
-	/* We need to hold the node by incrementing the reference
-	 * count until the queued work is done
-	 */
-	evtp->evt_arg1  = lpfc_nlp_get(ndlp);
-	if (evtp->evt_arg1) {
-		evtp->evt = LPFC_EVT_ELS_RETRY;
-		list_add_tail(&evtp->evt_listp, &phba->work_list);
-		lpfc_worker_wake_up(phba);
-	}
+	evtp->evt_arg1 = ndlp;
+	evtp->evt = LPFC_EVT_ELS_RETRY;
+	list_add_tail(&evtp->evt_listp, &phba->work_list);
 	spin_unlock_irqrestore(&phba->hbalock, flags);
-	return;
+
+	lpfc_worker_wake_up(phba);
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 549fa7d6c0f6f..aaa98a006fdcb 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -241,7 +241,9 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 		if (evtp->evt_arg1) {
 			evtp->evt = LPFC_EVT_DEV_LOSS;
 			list_add_tail(&evtp->evt_listp, &phba->work_list);
+			spin_unlock_irqrestore(&phba->hbalock, iflags);
 			lpfc_worker_wake_up(phba);
+			return;
 		}
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
 	} else {
@@ -259,10 +261,7 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 			lpfc_disc_state_machine(vport, ndlp, NULL,
 						NLP_EVT_DEVICE_RM);
 		}
-
 	}
-
-	return;
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 427a6ac803e50..47b8102a7063a 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -1217,9 +1217,9 @@ lpfc_set_rrq_active(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
 	empty = list_empty(&phba->active_rrq_list);
 	list_add_tail(&rrq->list, &phba->active_rrq_list);
 	phba->hba_flag |= HBA_RRQ_ACTIVE;
+	spin_unlock_irqrestore(&phba->hbalock, iflags);
 	if (empty)
 		lpfc_worker_wake_up(phba);
-	spin_unlock_irqrestore(&phba->hbalock, iflags);
 	return 0;
 out:
 	spin_unlock_irqrestore(&phba->hbalock, iflags);
@@ -11361,18 +11361,18 @@ lpfc_sli_post_recovery_event(struct lpfc_hba *phba,
 	unsigned long iflags;
 	struct lpfc_work_evt  *evtp = &ndlp->recovery_evt;
 
+	/* Hold a node reference for outstanding queued work */
+	if (!lpfc_nlp_get(ndlp))
+		return;
+
 	spin_lock_irqsave(&phba->hbalock, iflags);
 	if (!list_empty(&evtp->evt_listp)) {
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
+		lpfc_nlp_put(ndlp);
 		return;
 	}
 
-	/* Incrementing the reference count until the queued work is done. */
-	evtp->evt_arg1  = lpfc_nlp_get(ndlp);
-	if (!evtp->evt_arg1) {
-		spin_unlock_irqrestore(&phba->hbalock, iflags);
-		return;
-	}
+	evtp->evt_arg1 = ndlp;
 	evtp->evt = LPFC_EVT_RECOVER_PORT;
 	list_add_tail(&evtp->evt_listp, &phba->work_list);
 	spin_unlock_irqrestore(&phba->hbalock, iflags);
-- 
2.43.0




