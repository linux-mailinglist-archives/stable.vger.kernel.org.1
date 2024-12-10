Return-Path: <stable+bounces-100350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E96D9EABB7
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9376188A0EA
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F72D232783;
	Tue, 10 Dec 2024 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eI/dLkO4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCE61A0716
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822122; cv=none; b=VXVa3IHoQ+L+pn1HjO8zLNkBW4cFzLeCuvqPh9zuGX04gT25LUVxUDzJM7nSnyvGPyxm1aTe2fLYB7XYM2HG8i708ytNLew80eojYZozKHdaPVudvTDwDRDglGXuySUvhURtCyWLLSPnFrqhqn0BxShGsZuvyLI5iV0/wDEaGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822122; c=relaxed/simple;
	bh=5xoFqVNN2UwLkK7uBUoUDCrnf2SSmn/26zhX4ce9gFQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZZy562ITwFO98Cbl4KUxCFCWi21yGPMFnoff8LrXYcl+LxtGygiUAv4vbb+OLwfR3AXJKYv0eWweyWzaBfHSXKwDlqa0qQNi6EBn3+FJ4cnTajwaVjNHHkTxsrPGhhMhlQpMw+Yj9fNSA9nWJfb0obveGvnTz9oTt8Qs/92WeAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eI/dLkO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D91C4CEE0;
	Tue, 10 Dec 2024 09:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733822121;
	bh=5xoFqVNN2UwLkK7uBUoUDCrnf2SSmn/26zhX4ce9gFQ=;
	h=Subject:To:Cc:From:Date:From;
	b=eI/dLkO4UBUiJcNKLBE3zCEefPSqFnN7XJ7UWma8wkeciCJP0Alw5n0/gFxEq7T7g
	 GBR68Kj4kJCF+IZ8Ixcb5uFSTWtFngR9M0cAJGHke5wKmeuP3lXQsVBZKW0AwQhV65
	 wLKyRxqDIPHtGB9ENu9FpAkIWAVWOVTVDu+qjmhc=
Subject: FAILED: patch "[PATCH] scsi: ufs: core: Add missing post notify for power mode" failed to apply to 5.4-stable tree
To: peter.wang@mediatek.com,bvanassche@acm.org,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:14:41 +0100
Message-ID: <2024121041-ample-genetics-3d21@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 7f45ed5f0cd5ccbbec79adc6c48a67d6a85fba56
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121041-ample-genetics-3d21@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


