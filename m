Return-Path: <stable+bounces-44826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D02888C5494
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715441F234D0
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC1C12CD8A;
	Tue, 14 May 2024 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uJdyuizu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5C612C54A;
	Tue, 14 May 2024 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687288; cv=none; b=hD4tvYKiVNL7auNXyC+InMjAiIGRRBBM8e8XU0X2DeqUarqxq3xtxveET7rZ6YC+CJGpHZRmxJipmvud/ZO+P6wZmpTwOy7ajJO0jkfZUANhEFJkHpwsRBorRBG4ZUYyVnvIvTL/6q7PDxhN58bXTDnYTe9C020CEvKH3O80uyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687288; c=relaxed/simple;
	bh=wkh7XVJ+4wxZeLas6Gp+tPAt9z1bjFl1Oe8u9IsGE2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+99zOdDBadXJphjFlTrY34XSPZlfnIXxo4ZE12G+MN3Q533vwBStfTDvgehrO7yD4C4K8WXncG1ooAJpjTi8bMN7CJLEI2xPtxa5sp+Kjt40yi1WXqH571pc9Eii9N3gKcKh3dpWuyIHtM/IpxN3JZXZoQ3D8uO7fe8apbgTwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uJdyuizu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C3FC2BD10;
	Tue, 14 May 2024 11:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687288;
	bh=wkh7XVJ+4wxZeLas6Gp+tPAt9z1bjFl1Oe8u9IsGE2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uJdyuizuiFsfE+NBUEo8eX+zeOK0FxUZId0/ZWalOvZsz4NEZtASCA7/cVFELR5jW
	 wA2ioSpqN7g/g6WXAe2uxOAszqPALLJg+s2kRLrALlI83Hh9hQxSSdRNVoelUh2RaT
	 yIslgsrxNmULh71xYMsCn7yw8FQ9kl1w1TtbvjAg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Tee <justin.tee@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 044/111] scsi: lpfc: Update lpfc_ramp_down_queue_handler() logic
Date: Tue, 14 May 2024 12:19:42 +0200
Message-ID: <20240514100958.809000740@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100957.114746054@linuxfoundation.org>
References: <20240514100957.114746054@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit bb011631435c705cdeddca68d5c85fd40a4320f9 ]

Typically when an out of resource CQE status is detected, the
lpfc_ramp_down_queue_handler() logic is called to help reduce I/O load by
reducing an sdev's queue_depth.

However, the current lpfc_rampdown_queue_depth() logic does not help reduce
queue_depth.  num_cmd_success is never updated and is always zero, which
means new_queue_depth will always be set to sdev->queue_depth.  So,
new_queue_depth = sdev->queue_depth - new_queue_depth always sets
new_queue_depth to zero.  And, scsi_change_queue_depth(sdev, 0) is
essentially a no-op.

Change the lpfc_ramp_down_queue_handler() logic to set new_queue_depth
equal to sdev->queue_depth subtracted from number of times num_rsrc_err was
incremented.  If num_rsrc_err is >= sdev->queue_depth, then set
new_queue_depth equal to 1.  Eventually, the frequency of Good_Status
frames will signal SCSI upper layer to auto increase the queue_depth back
to the driver default of 64 via scsi_handle_queue_ramp_up().

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20240305200503.57317-5-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc.h      |  1 -
 drivers/scsi/lpfc/lpfc_scsi.c | 13 ++++---------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index cf69f831a7253..8f1b5b0ee8cd8 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -1065,7 +1065,6 @@ struct lpfc_hba {
 	unsigned long bit_flags;
 #define	FABRIC_COMANDS_BLOCKED	0
 	atomic_t num_rsrc_err;
-	atomic_t num_cmd_success;
 	unsigned long last_rsrc_error_time;
 	unsigned long last_ramp_down_time;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index b4b87e5d8b291..2121534838747 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -246,11 +246,10 @@ lpfc_ramp_down_queue_handler(struct lpfc_hba *phba)
 	struct Scsi_Host  *shost;
 	struct scsi_device *sdev;
 	unsigned long new_queue_depth;
-	unsigned long num_rsrc_err, num_cmd_success;
+	unsigned long num_rsrc_err;
 	int i;
 
 	num_rsrc_err = atomic_read(&phba->num_rsrc_err);
-	num_cmd_success = atomic_read(&phba->num_cmd_success);
 
 	/*
 	 * The error and success command counters are global per
@@ -265,20 +264,16 @@ lpfc_ramp_down_queue_handler(struct lpfc_hba *phba)
 		for (i = 0; i <= phba->max_vports && vports[i] != NULL; i++) {
 			shost = lpfc_shost_from_vport(vports[i]);
 			shost_for_each_device(sdev, shost) {
-				new_queue_depth =
-					sdev->queue_depth * num_rsrc_err /
-					(num_rsrc_err + num_cmd_success);
-				if (!new_queue_depth)
-					new_queue_depth = sdev->queue_depth - 1;
+				if (num_rsrc_err >= sdev->queue_depth)
+					new_queue_depth = 1;
 				else
 					new_queue_depth = sdev->queue_depth -
-								new_queue_depth;
+						num_rsrc_err;
 				scsi_change_queue_depth(sdev, new_queue_depth);
 			}
 		}
 	lpfc_destroy_vport_work_array(phba, vports);
 	atomic_set(&phba->num_rsrc_err, 0);
-	atomic_set(&phba->num_cmd_success, 0);
 }
 
 /**
-- 
2.43.0




