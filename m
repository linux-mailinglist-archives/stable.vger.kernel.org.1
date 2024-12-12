Return-Path: <stable+bounces-100926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0139EE8F3
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C14168C76
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 14:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133A86F2FE;
	Thu, 12 Dec 2024 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cbUo4n+z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58C88837
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014024; cv=none; b=sGLbKNKz0Su4yObBb1Gv7wOaUZ+gnE7vMkdTlKFLnFB3TRdKBHYIsdwM0K56fJUTKsYUPCKMrzcEd6sHonlRYTvxn99M8BMqP+p1MDRTlLQ8/3/+vq61ptShCxi+79DOYan8+l9PFjnlWUXi1UYAWL8fsnGr0ad+7qQ7Yhk4UgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014024; c=relaxed/simple;
	bh=OonBx5cEcDn531kcLAG+lY53mTC165Y3yzWtCl67nEM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sMTYG2gU28fN5OT3YlFbac/iiiu/dbaMIRe11Kt8Sobho6VPY3O97v+9mDMvbJRPA8xrDVvH0eRcgBT2G1iOS5DZ5bNkn1I/bdRvBCk6UDaRdE4uc1Fy7pXuxsqeDJIJefmqygDDEvllzVREkB1yXnhytGLrjR9RmP4UpwSKseU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cbUo4n+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA909C4CECE;
	Thu, 12 Dec 2024 14:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734014024;
	bh=OonBx5cEcDn531kcLAG+lY53mTC165Y3yzWtCl67nEM=;
	h=Subject:To:Cc:From:Date:From;
	b=cbUo4n+zKy0js2Kw4Tw9apcx+NJpyBFC0eBxXtruKGkDnbn3QpYdRtpWBWs8A+8MC
	 Jo31f7rsucGf5/j3SOzPJ2LkdhfTPEXUXhhIGa3yqZy9aalLu844+d1WmwVj6vAeLD
	 T/pEz0IrUxcDZ+VyFD584xnUvYlTAJR0YBi+1H9s=
Subject: FAILED: patch "[PATCH] scsi: ufs: qcom: Only free platform MSIs when ESI is enabled" failed to apply to 6.6-stable tree
To: manivannan.sadhasivam@linaro.org,beanhuo@micron.com,bvanassche@acm.org,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 12 Dec 2024 15:33:40 +0100
Message-ID: <2024121240-props-brittle-f872@gregkh>
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
git cherry-pick -x 64506b3d23a337e98a74b18dcb10c8619365f2bd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121240-props-brittle-f872@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 64506b3d23a337e98a74b18dcb10c8619365f2bd Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 11 Nov 2024 23:18:31 +0530
Subject: [PATCH] scsi: ufs: qcom: Only free platform MSIs when ESI is enabled

Otherwise, it will result in a NULL pointer dereference as below:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
Call trace:
 mutex_lock+0xc/0x54
 platform_device_msi_free_irqs_all+0x14/0x20
 ufs_qcom_remove+0x34/0x48 [ufs_qcom]
 platform_remove+0x28/0x44
 device_remove+0x4c/0x80
 device_release_driver_internal+0xd8/0x178
 driver_detach+0x50/0x9c
 bus_remove_driver+0x6c/0xbc
 driver_unregister+0x30/0x60
 platform_driver_unregister+0x14/0x20
 ufs_qcom_pltform_exit+0x18/0xb94 [ufs_qcom]
 __arm64_sys_delete_module+0x180/0x260
 invoke_syscall+0x44/0x100
 el0_svc_common.constprop.0+0xc0/0xe0
 do_el0_svc+0x1c/0x28
 el0_svc+0x34/0xdc
 el0t_64_sync_handler+0xc0/0xc4
 el0t_64_sync+0x190/0x194

Cc: stable@vger.kernel.org # 6.3
Fixes: 519b6274a777 ("scsi: ufs: qcom: Add MCQ ESI config vendor specific ops")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20241111-ufs_bug_fix-v1-2-45ad8b62f02e@linaro.org
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 3b592492e152..5220ec78021d 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1861,10 +1861,12 @@ static int ufs_qcom_probe(struct platform_device *pdev)
 static void ufs_qcom_remove(struct platform_device *pdev)
 {
 	struct ufs_hba *hba =  platform_get_drvdata(pdev);
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 
 	pm_runtime_get_sync(&(pdev)->dev);
 	ufshcd_remove(hba);
-	platform_device_msi_free_irqs_all(hba->dev);
+	if (host->esi_enabled)
+		platform_device_msi_free_irqs_all(hba->dev);
 }
 
 static const struct of_device_id ufs_qcom_of_match[] __maybe_unused = {


