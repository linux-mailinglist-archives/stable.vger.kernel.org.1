Return-Path: <stable+bounces-178020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05232B478C4
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 05:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAC024E05A8
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 03:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EE41AF4D5;
	Sun,  7 Sep 2025 03:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKEi3wtm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B3E35950
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 03:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757215128; cv=none; b=pvi1Xjzi1yoIVEiswCjlXCKaQrq3mx20gaO4Yjfc2hzymzoViftxHUScvTLbD513N9BF/BLCqs6oy3bR51GdBUjPywvvv4qNd8mr6z6NSSFLEShPOgfLGnrevKQSbFdQGp0kVEAubeGfQC7IvTlfEDXw5NogxUJPRv1Bmv8dDec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757215128; c=relaxed/simple;
	bh=EpizMBGt1bnJpPnI2wCzxFiy2BVfKl+1r9CoiQRaAVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYoSnG8uPkK3Ds4VQW6dTYoqH+pf/NUWO3At5falyFafcJubvUDXJ4TzwK7/cYCBSJUa7m80pazj+NlmYZUUd3TfrmICI0TsuzrexB2hIZ0zxPu7jx9QoMHjCk//lXFnRHwsHHpHGh00PEm/fKcqwDqq+RxJmPA8gNYDbx0sz3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKEi3wtm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD2DC4CEF4;
	Sun,  7 Sep 2025 03:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757215128;
	bh=EpizMBGt1bnJpPnI2wCzxFiy2BVfKl+1r9CoiQRaAVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FKEi3wtmKbDT4OBK/Hr4qcm/vhwBreFgNVq2Mg8cD2XGmUKdCFtM/0U+KrPUnnIcg
	 T1aX2t4NVsWPX+86B/cS9mCBh+mGaYz2W+F6jbWfOxz2vM3Ptmw0kLKUaANlcFlkfq
	 swRQ0akW8Acp1D6UggCtjOGqGW4ahdooRTBvt7CN5wX3feLLNLB3OhrqledU3kvKIW
	 JyqfYzgTGdBKdI83fQDtow0YitVQ5q4OQ1X3lIDYWgjZ6V8Om/7EwxW/l8fk2t1qDm
	 haTlHSFWJkBKoUrgRrVuXezpxl5b0G8VjAJ0c6Fz+YHQ4/7c8u9Gq8oUXx0l/6Ex7B
	 /2TqH3CLRdGsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: John Evans <evans1210144@gmail.com>,
	Justin Tee <justin.tee@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] scsi: lpfc: Fix buffer free/clear order in deferred receive path
Date: Sat,  6 Sep 2025 23:18:45 -0400
Message-ID: <20250907031845.445653-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090623-retiring-only-9b80@gregkh>
References: <2025090623-retiring-only-9b80@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Evans <evans1210144@gmail.com>

[ Upstream commit 9dba9a45c348e8460da97c450cddf70b2056deb3 ]

Fix a use-after-free window by correcting the buffer release sequence in
the deferred receive path. The code freed the RQ buffer first and only
then cleared the context pointer under the lock. Concurrent paths (e.g.,
ABTS and the repost path) also inspect and release the same pointer under
the lock, so the old order could lead to double-free/UAF.

Note that the repost path already uses the correct pattern: detach the
pointer under the lock, then free it after dropping the lock. The
deferred path should do the same.

Fixes: 472e146d1cf3 ("scsi: lpfc: Correct upcalling nvmet_fc transport during io done downcall")
Cc: stable@vger.kernel.org
Signed-off-by: John Evans <evans1210144@gmail.com>
Link: https://lore.kernel.org/r/20250828044008.743-1-evans1210144@gmail.com
Reviewed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 979a6d11b1b71..728ec3f47e023 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1172,7 +1172,7 @@ lpfc_nvmet_defer_rcv(struct nvmet_fc_target_port *tgtport,
 	struct lpfc_nvmet_tgtport *tgtp;
 	struct lpfc_nvmet_rcv_ctx *ctxp =
 		container_of(rsp, struct lpfc_nvmet_rcv_ctx, ctx.fcp_req);
-	struct rqb_dmabuf *nvmebuf = ctxp->rqb_buffer;
+	struct rqb_dmabuf *nvmebuf;
 	struct lpfc_hba *phba = ctxp->phba;
 	unsigned long iflag;
 
@@ -1180,13 +1180,18 @@ lpfc_nvmet_defer_rcv(struct nvmet_fc_target_port *tgtport,
 	lpfc_nvmeio_data(phba, "NVMET DEFERRCV: xri x%x sz %d CPU %02x\n",
 			 ctxp->oxid, ctxp->size, raw_smp_processor_id());
 
+	spin_lock_irqsave(&ctxp->ctxlock, iflag);
+	nvmebuf = ctxp->rqb_buffer;
 	if (!nvmebuf) {
+		spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
 		lpfc_printf_log(phba, KERN_INFO, LOG_NVME_IOERR,
 				"6425 Defer rcv: no buffer oxid x%x: "
 				"flg %x ste %x\n",
 				ctxp->oxid, ctxp->flag, ctxp->state);
 		return;
 	}
+	ctxp->rqb_buffer = NULL;
+	spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
 
 	tgtp = phba->targetport->private;
 	if (tgtp)
@@ -1194,9 +1199,6 @@ lpfc_nvmet_defer_rcv(struct nvmet_fc_target_port *tgtport,
 
 	/* Free the nvmebuf since a new buffer already replaced it */
 	nvmebuf->hrq->rqbp->rqb_free_buffer(phba, nvmebuf);
-	spin_lock_irqsave(&ctxp->ctxlock, iflag);
-	ctxp->rqb_buffer = NULL;
-	spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
 }
 
 static void
-- 
2.51.0


