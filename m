Return-Path: <stable+bounces-86959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8105C9A5354
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 11:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9861C20B5F
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 09:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE573EA64;
	Sun, 20 Oct 2024 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CqbfhYXS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B492942A
	for <stable@vger.kernel.org>; Sun, 20 Oct 2024 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729416739; cv=none; b=lfKJB94cA62zrawFddO14pcWQasJyGVOdJJmWAlUNHxx2LKuOr87l4QJprQ0iOxrOfCfOvB0d+wstEM2ckRrTNjrF2HKhf992IuzUw7hefU6tNXzt7LTiHV3N5fJDDlNfQyWGkBysKOAPnHBwb100niHjyYzF1Vym4BmCu/yB9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729416739; c=relaxed/simple;
	bh=ZWKUDr4qdVXNPNheYqLxC5UO4Vfx8fo2fFxQDTsEgX8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aUjQfCR4kUWmP+8lvoQhdTJwfDm/0Kq+PG12f+lXMtYoUapRE+ZKIq+sAdinnVd4e1wY9MpoGbu3cg0ixIEnhhpmONsjY2+0CoHEbqo5kSYd+gw091atSX6f82ftJWVw9/jeu9IW9wK8NMf+rraijgGwObrisqmxS5Df0FPi1TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CqbfhYXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C633C4CEC6;
	Sun, 20 Oct 2024 09:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729416738;
	bh=ZWKUDr4qdVXNPNheYqLxC5UO4Vfx8fo2fFxQDTsEgX8=;
	h=Subject:To:Cc:From:Date:From;
	b=CqbfhYXSTgtMUHCpzpKlpsF7/Pr4ArrUY8eSYN6U8ytEBCcASLPWWkXDsQOGmYZuj
	 eh3/L9BsubERdTJcM5YpyJtrnhTJEwfQosAp3ILPMDGV7/dZVbv5V+Jz+wYnv/TC2o
	 REvbx6vYgTwrqPJ2DIgqSu70ddYsNG0UyCmY/6OI=
Subject: FAILED: patch "[PATCH] scsi: ufs: core: Requeue aborted request" failed to apply to 6.6-stable tree
To: peter.wang@mediatek.com,bvanassche@acm.org,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Oct 2024 11:32:14 +0200
Message-ID: <2024102014-dorsal-renounce-5242@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8fa075804cb3b00960dd5c06554308175c834530
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102014-dorsal-renounce-5242@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8fa075804cb3b00960dd5c06554308175c834530 Mon Sep 17 00:00:00 2001
From: Peter Wang <peter.wang@mediatek.com>
Date: Tue, 1 Oct 2024 17:19:17 +0800
Subject: [PATCH] scsi: ufs: core: Requeue aborted request

After the SQ cleanup fix, the CQ will receive a response with the
corresponding tag marked as OCS: ABORTED. To align with the behavior of
Legacy SDB mode, the handling of OCS: ABORTED has been changed to match
that of OCS_INVALID_COMMAND_STATUS (SDB), with both returning a SCSI
result of DID_REQUEUE.

Furthermore, the workaround implemented before the SQ cleanup fix can be
removed.

Fixes: ab248643d3d6 ("scsi: ufs: core: Add error handling for MCQ mode")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Wang <peter.wang@mediatek.com>
Link: https://lore.kernel.org/r/20241001091917.6917-3-peter.wang@mediatek.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 6a71ebf953e2..f845166dc0d7 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5416,10 +5416,12 @@ ufshcd_transfer_rsp_status(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
 		}
 		break;
 	case OCS_ABORTED:
-		result |= DID_ABORT << 16;
-		break;
 	case OCS_INVALID_COMMAND_STATUS:
 		result |= DID_REQUEUE << 16;
+		dev_warn(hba->dev,
+				"OCS %s from controller for tag %d\n",
+				(ocs == OCS_ABORTED ? "aborted" : "invalid"),
+				lrbp->task_tag);
 		break;
 	case OCS_INVALID_CMD_TABLE_ATTR:
 	case OCS_INVALID_PRDT_ATTR:
@@ -6465,26 +6467,12 @@ static bool ufshcd_abort_one(struct request *rq, void *priv)
 	struct scsi_device *sdev = cmd->device;
 	struct Scsi_Host *shost = sdev->host;
 	struct ufs_hba *hba = shost_priv(shost);
-	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
-	struct ufs_hw_queue *hwq;
-	unsigned long flags;
 
 	*ret = ufshcd_try_to_abort_task(hba, tag);
 	dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s\n", tag,
 		hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cmnd[0] : -1,
 		*ret ? "failed" : "succeeded");
 
-	/* Release cmd in MCQ mode if abort succeeds */
-	if (hba->mcq_enabled && (*ret == 0)) {
-		hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(lrbp->cmd));
-		if (!hwq)
-			return 0;
-		spin_lock_irqsave(&hwq->cq_lock, flags);
-		if (ufshcd_cmd_inflight(lrbp->cmd))
-			ufshcd_release_scsi_cmd(hba, lrbp);
-		spin_unlock_irqrestore(&hwq->cq_lock, flags);
-	}
-
 	return *ret == 0;
 }
 


