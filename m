Return-Path: <stable+bounces-100349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7039B9EABB6
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4421673BC
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB192327B8;
	Tue, 10 Dec 2024 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eujyJ4zw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00E72248B8
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822120; cv=none; b=SOQxP/uGSWpAMUUA1augWFuxgjn7qrJjNSn4rEf50kbgkdcr5wfDSsBxZjzoDMrIzLaDnr/qSq+nlh/SGR/XEGfvS8OM8xx6oka1lhQLyN2tAnnfQM+1o/8n2e19MDpiRHR1toG0pG5XYA9SwDOxkHBfG6jgtRinj2oke2S9Y3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822120; c=relaxed/simple;
	bh=10j/wPnMjJ7VziBIf53M0YRYhZCG66OWcHIU2MLfSQ0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eMsbFFtodByVsD1fNbn3Z2lOMUAujImLZFEHelaDX4e4ZiEPMgb83A8ahlSTDIRyeWsjc0nAZ/7zUCu6rQB/JDFt7Qn/p3R9DYUW77XceBlheKNVszTRDS7ocbhK5SeTpdBUVD7hBClTNHcek2dUHC2FlzJOlwc7c65tq2dBAHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eujyJ4zw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC133C4CED6;
	Tue, 10 Dec 2024 09:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733822119;
	bh=10j/wPnMjJ7VziBIf53M0YRYhZCG66OWcHIU2MLfSQ0=;
	h=Subject:To:Cc:From:Date:From;
	b=eujyJ4zwR74Tz/7OjIlzbtoRf09429ZRcuDeQ0+GZNazdjNMqjue6YimFpVxush33
	 Ft67dR7x+OYwZXvl7ca3iyPl4qsfDeYz7tsWDUwGBdvKD7RI9nCyhnoFNTBTllUpaj
	 HOxC14pISN+d5bjeye6Y7AH2HxoqOKHlg5Udm1ME=
Subject: FAILED: patch "[PATCH] scsi: ufs: core: Add missing post notify for power mode" failed to apply to 5.10-stable tree
To: peter.wang@mediatek.com,bvanassche@acm.org,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:14:40 +0100
Message-ID: <2024121040-prowler-plaything-715c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7f45ed5f0cd5ccbbec79adc6c48a67d6a85fba56
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121040-prowler-plaything-715c@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7f45ed5f0cd5ccbbec79adc6c48a67d6a85fba56 Mon Sep 17 00:00:00 2001
From: Peter Wang <peter.wang@mediatek.com>
Date: Fri, 22 Nov 2024 10:49:43 +0800
Subject: [PATCH] scsi: ufs: core: Add missing post notify for power mode
 change

When the power mode change is successful but the power mode hasn't
actually changed, the post notification was missed.  Similar to the
approach with hibernate/clock scale/hce enable, having pre/post
notifications in the same function will make it easier to maintain.

Additionally, supplement the description of power parameters for the
pwr_change_notify callback.

Fixes: 7eb584db73be ("ufs: refactor configuring power mode")
Cc: stable@vger.kernel.org #6.11.x
Signed-off-by: Peter Wang <peter.wang@mediatek.com>
Link: https://lore.kernel.org/r/20241122024943.30589-1-peter.wang@mediatek.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 25c8b3f57171..b7ec5797d5ba 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4671,9 +4671,6 @@ static int ufshcd_change_power_mode(struct ufs_hba *hba,
 		dev_err(hba->dev,
 			"%s: power mode change failed %d\n", __func__, ret);
 	} else {
-		ufshcd_vops_pwr_change_notify(hba, POST_CHANGE, NULL,
-								pwr_mode);
-
 		memcpy(&hba->pwr_info, pwr_mode,
 			sizeof(struct ufs_pa_layer_attr));
 	}
@@ -4702,6 +4699,10 @@ int ufshcd_config_pwr_mode(struct ufs_hba *hba,
 
 	ret = ufshcd_change_power_mode(hba, &final_params);
 
+	if (!ret)
+		ufshcd_vops_pwr_change_notify(hba, POST_CHANGE, NULL,
+					&final_params);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ufshcd_config_pwr_mode);
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index d7aca9e61684..d650ae6b58d3 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -310,7 +310,9 @@ struct ufs_pwr_mode_info {
  *                       to allow variant specific Uni-Pro initialization.
  * @pwr_change_notify: called before and after a power mode change
  *			is carried out to allow vendor spesific capabilities
- *			to be set.
+ *			to be set. PRE_CHANGE can modify final_params based
+ *			on desired_pwr_mode, but POST_CHANGE must not alter
+ *			the final_params parameter
  * @setup_xfer_req: called before any transfer request is issued
  *                  to set some things
  * @setup_task_mgmt: called before any task management request is issued
@@ -353,9 +355,9 @@ struct ufs_hba_variant_ops {
 	int	(*link_startup_notify)(struct ufs_hba *,
 				       enum ufs_notify_change_status);
 	int	(*pwr_change_notify)(struct ufs_hba *,
-					enum ufs_notify_change_status status,
-					struct ufs_pa_layer_attr *,
-					struct ufs_pa_layer_attr *);
+				enum ufs_notify_change_status status,
+				struct ufs_pa_layer_attr *desired_pwr_mode,
+				struct ufs_pa_layer_attr *final_params);
 	void	(*setup_xfer_req)(struct ufs_hba *hba, int tag,
 				  bool is_scsi_cmd);
 	void	(*setup_task_mgmt)(struct ufs_hba *, int, u8);


