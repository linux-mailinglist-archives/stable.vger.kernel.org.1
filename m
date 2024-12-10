Return-Path: <stable+bounces-100330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B19909EAB9E
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A009318894F0
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEB9231C82;
	Tue, 10 Dec 2024 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JiLCGk9H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0193322CBE9
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822053; cv=none; b=QlL5Rg+RFOt9NddLBt8alvCYR+fSH25jx6X4esd5Qh/f5E2QReOvxyUzm+3tLeW7UQq09eIkVkBC7+FqrDs+qSFNvhGXRcs/MYVTxpXn62w6CmvN9DVgoMTKC3T9qT6KAkMa07lTFF+w0YJ84OC44RLicqWvzseNnObgg7ijK10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822053; c=relaxed/simple;
	bh=7B8hLzeP8ljztbI+WDBKH4FiX0zOZFH3kK5L8dyhJrk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rMYTWflmLvl1XOAFPG3+E/bIlEViknkbHjxPMfCYfOHk43znt776KaVC1+zncGcpVKiKGZEatshT8bWIRj5bxQuSj/LC0IHnf4yzUhImhwcE9Kdvs9GcG651T77T7I5qJhssK6MrrMegzBJvMlByz1zH9mE6Czt6CHBcpuwPlaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JiLCGk9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F8AC4CEDD;
	Tue, 10 Dec 2024 09:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733822052;
	bh=7B8hLzeP8ljztbI+WDBKH4FiX0zOZFH3kK5L8dyhJrk=;
	h=Subject:To:Cc:From:Date:From;
	b=JiLCGk9HGaHsY97c0hDWqp0ImaMDYzLfTFRxR7bby5YCm94Q73Tn90ldtyK/qaZr+
	 ePUSTq0ynmsH414F+GoNOw+epkdzoUjAIX72ZUKcENZ6euNVLRV4EPqLYP5gplQuCb
	 DyxQ6N9ye1KvozRjmJyXp2Kz/dHPO6mA5tIcvwOI=
Subject: FAILED: patch "[PATCH] scsi: ufs: qcom: Only free platform MSIs when ESI is enabled" failed to apply to 6.6-stable tree
To: mani@kernel.org,beanhuo@micron.com,bvanassche@acm.org,manivannan.sadhasivam@linaro.org,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:13:36 +0100
Message-ID: <2024121036-surround-docile-0043@gregkh>
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
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121036-surround-docile-0043@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 64506b3d23a337e98a74b18dcb10c8619365f2bd Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <mani@kernel.org>
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


