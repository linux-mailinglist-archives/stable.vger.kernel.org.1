Return-Path: <stable+bounces-216016-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFAKL8uUjmmhDAEAu9opvQ
	(envelope-from <stable+bounces-216016-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 04:04:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2F5132892
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 04:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E4083096874
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 03:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27B6221265;
	Fri, 13 Feb 2026 03:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="aKkUk6RR"
X-Original-To: stable@vger.kernel.org
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFB72A1AA
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 03:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770951792; cv=none; b=SUMSRSdhYwDZitMC4jnXZuC+beHxTZN1KjaPc18mJgT0TE/bv5ftD1/Uxr4nXcJyRoAds6uprGLIdp0cHqU7TpZMSeDCnJopRxX59jM0R0Jpc+u9On/kEBgBfABSuTq4hj64EI5Aaci0QS5ALlcPLzdCw2g46RMYjJfaRbgzf6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770951792; c=relaxed/simple;
	bh=JIHzno+5uzgY87v4mv+r6XR37I3fpEIKRGIj8SlkufM=;
	h=From:To:Subject:Date:Message-Id; b=oIAFmlvbat6GD7mmoyEY2c3VFfnShvJCKxx369qTXCOqVPCbTQPIAOX4z3lpONLfoQ1TP//9ZV7Bu4Mk7Jar6U3ZcGVHlfkoUMUEUCMiWNXt+I601FFuyv27ei10siLv2ZAaEtd9i8ndPTDPKh8tqylIs+JaERqIi6H5PocAPzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=aKkUk6RR; arc=none smtp.client-ip=120.232.169.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=aKkUk6RRJdjlv/LblBTLxe9MOEb5aRERVF/W17AoJGxZEeUpFt/vb4MLrphVkhO8UrHT6ggpqYGDq
	 gqK6dmllfB/LRoaTfaTFP7z319j505+kVYt5wU2UqzSf5rrl/owpkftIuftzsMsPPtYlkNm+IBIhqp
	 6BvzgnAy3L+5TmpA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[117.129.7.232])
	by rmsmtp-lg-appmail-27-12032 (RichMail) with SMTP id 2f00698e9467d4f-ad560;
	Fri, 13 Feb 2026 11:03:04 +0800 (CST)
X-RM-TRANSID:2f00698e9467d4f-ad560
From: Rajani Kantha <681739313@139.com>
To: bvanassche@acm.org,
	adrian.hunter@intel.com,
	martin.petersen@oracle.com,
	stable@vger.kernel.org
Subject: [PATCH 6.1] scsi: ufs: core: Fix handling of lrbp->cmd
Date: Fri, 13 Feb 2026 11:02:57 +0800
Message-Id: <20260213030257.1688-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216016-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[139.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[139.com];
	FROM_NEQ_ENVFROM(0.00)[681739313@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,intel.com:email]
X-Rspamd-Queue-Id: 7F2F5132892
X-Rspamd-Action: no action

From: Bart Van Assche <bvanassche@acm.org>

ufshcd_queuecommand() may be called two times in a row for a SCSI command
before it is completed. Hence make the following changes:

 - In the functions that submit a command, do not check the old value of
   lrbp->cmd nor clear lrbp->cmd in error paths.

 - In ufshcd_release_scsi_cmd(), do not clear lrbp->cmd.

See also scsi_send_eh_cmnd().

This commit prevents that the following appears if a command times out:

WARNING: at drivers/ufs/core/ufshcd.c:2965 ufshcd_queuecommand+0x6f8/0x9a8
Call trace:
 ufshcd_queuecommand+0x6f8/0x9a8
 scsi_send_eh_cmnd+0x2c0/0x960
 scsi_eh_test_devices+0x100/0x314
 scsi_eh_ready_devs+0xd90/0x114c
 scsi_error_handler+0x2b4/0xb70
 kthread+0x16c/0x1e0

Fixes: 5a0b0cb9bee7 ("[SCSI] ufs: Add support for sending NOP OUT UPIU")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20230524203659.1394307-3-bvanassche@acm.org
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[ Removed the change in ufshcd_advanced_rpmb_req_handler() due to missing
commit:6ff265fc5ef6("scsi: ufs: core: bsg: Add advanced RPMB support in ufs_bsg") ]
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 drivers/ufs/core/ufshcd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index d553169b4d9a..a8091fc74d98 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2824,7 +2824,6 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 		(hba->clk_gating.state != CLKS_ON));
 
 	lrbp = &hba->lrb[tag];
-	WARN_ON(lrbp->cmd);
 	lrbp->cmd = cmd;
 	lrbp->task_tag = tag;
 	lrbp->lun = ufshcd_scsi_to_upiu_lun(cmd->device->lun);
@@ -2840,7 +2839,6 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 
 	err = ufshcd_map_sg(hba, lrbp);
 	if (err) {
-		lrbp->cmd = NULL;
 		ufshcd_release(hba);
 		goto out;
 	}
@@ -3050,7 +3048,7 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 	down_read(&hba->clk_scaling_lock);
 
 	lrbp = &hba->lrb[tag];
-	WARN_ON(lrbp->cmd);
+	lrbp->cmd = NULL;
 	err = ufshcd_compose_dev_cmd(hba, lrbp, cmd_type, tag);
 	if (unlikely(err))
 		goto out;
@@ -5368,7 +5366,6 @@ static void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
 	struct scsi_cmnd *cmd = lrbp->cmd;
 
 	scsi_dma_unmap(cmd);
-	lrbp->cmd = NULL;	/* Mark the command as completed. */
 	ufshcd_release(hba);
 	ufshcd_clk_scaling_update_busy(hba);
 }
@@ -6947,7 +6944,6 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 	down_read(&hba->clk_scaling_lock);
 
 	lrbp = &hba->lrb[tag];
-	WARN_ON(lrbp->cmd);
 	lrbp->cmd = NULL;
 	lrbp->task_tag = tag;
 	lrbp->lun = 0;
-- 
2.17.1



