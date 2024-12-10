Return-Path: <stable+bounces-100336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 063AB9EABA4
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282D81889317
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DC6231CA2;
	Tue, 10 Dec 2024 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ms2bFqQJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D14231C9F
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822082; cv=none; b=WEp5G3bS6eHCZPOduIQ9NX3SWvK8buQp0UVvZckv52LxkvEHXzDFks9wN71oUjVsM2r4iaB6+SYiiy/HzF67XOuj3kQTN5xhfLBBytZrO/rD5OjHjkJKVOb1cfIM5SM8B973nKb18CSa2rM36WAtx+9YKi7684a1tOcY48CdcBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822082; c=relaxed/simple;
	bh=uMJlzcgZplLHrhSZ9QYsR04FzWigvFbFax+647gwUEA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B/SDhUQbs2wM5TbwP7AkM0kAuvhSpniYvLmDFf/o2FbiuYwBfj4K/+efXPWW2yI9ARoQf7YpozhLl4ENwbMEUk6hepcAh7iKRkMeWgc45AFnAMYdhoIs2jmO1mmtq9/5Z++SjQDYlZ2ygp2YUUDHtm82jSLftmGUC4vQh4nDGGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ms2bFqQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45521C4CED6;
	Tue, 10 Dec 2024 09:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733822082;
	bh=uMJlzcgZplLHrhSZ9QYsR04FzWigvFbFax+647gwUEA=;
	h=Subject:To:Cc:From:Date:From;
	b=Ms2bFqQJZXaldHvx4XdnlHpUa+wm/ZAvludL9oau0aMeB8x6ErZp6zKk2oxJwnbFS
	 OEPJGM/sRwLYZSzZ7RSN+efOLk/x8BeobkMt1w/njWzYflyqJadM/54AT/W57as3zM
	 01MOES9CwGmXb0AA3d0rAhzFlM1BYO8PNmDKaLHo=
Subject: FAILED: patch "[PATCH] scsi: ufs: pltfrm: Drop PM runtime reference count after" failed to apply to 5.4-stable tree
To: mani@kernel.org,beanhuo@micron.com,bvanassche@acm.org,manivannan.sadhasivam@linaro.org,martin.petersen@oracle.com,peter.wang@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:13:57 +0100
Message-ID: <2024121057-demotion-vitalize-3417@gregkh>
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
git cherry-pick -x 1745dcdb7227102e16248a324c600b9121c8f6df
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121057-demotion-vitalize-3417@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1745dcdb7227102e16248a324c600b9121c8f6df Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Mon, 11 Nov 2024 23:18:33 +0530
Subject: [PATCH] scsi: ufs: pltfrm: Drop PM runtime reference count after
 ufshcd_remove()

During the remove stage of glue drivers, some of them are incrementing the
reference count using pm_runtime_get_sync(), before removing the ufshcd
using ufshcd_remove(). But they are not dropping that reference count after
ufshcd_remove() to balance the refcount.

So drop the reference count by calling pm_runtime_put_noidle() after
ufshcd_remove(). Since the behavior is applicable to all glue drivers, move
the PM handling to ufshcd_pltfrm_remove().

Cc: stable@vger.kernel.org # 3.12
Fixes: 62694735ca95 ("[SCSI] ufs: Add runtime PM support for UFS host controller driver")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20241111-ufs_bug_fix-v1-4-45ad8b62f02e@linaro.org
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/ufs/host/tc-dwc-g210-pltfrm.c b/drivers/ufs/host/tc-dwc-g210-pltfrm.c
index 113e0ef7b2cf..c6f8565ede21 100644
--- a/drivers/ufs/host/tc-dwc-g210-pltfrm.c
+++ b/drivers/ufs/host/tc-dwc-g210-pltfrm.c
@@ -76,7 +76,6 @@ static int tc_dwc_g210_pltfm_probe(struct platform_device *pdev)
  */
 static void tc_dwc_g210_pltfm_remove(struct platform_device *pdev)
 {
-	pm_runtime_get_sync(&(pdev)->dev);
 	ufshcd_pltfrm_remove(pdev);
 }
 
diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index b20f6526777a..9d4db13e142d 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -1992,7 +1992,6 @@ static void exynos_ufs_remove(struct platform_device *pdev)
 	struct ufs_hba *hba =  platform_get_drvdata(pdev);
 	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
 
-	pm_runtime_get_sync(&(pdev)->dev);
 	ufshcd_pltfrm_remove(pdev);
 
 	phy_power_off(ufs->phy);
diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index b444146419de..ffe4d03a0f38 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -1879,7 +1879,6 @@ static int ufs_mtk_probe(struct platform_device *pdev)
  */
 static void ufs_mtk_remove(struct platform_device *pdev)
 {
-	pm_runtime_get_sync(&(pdev)->dev);
 	ufshcd_pltfrm_remove(pdev);
 }
 
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 3762337d7576..73b4fec8221a 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1863,7 +1863,6 @@ static void ufs_qcom_remove(struct platform_device *pdev)
 	struct ufs_hba *hba =  platform_get_drvdata(pdev);
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 
-	pm_runtime_get_sync(&(pdev)->dev);
 	ufshcd_pltfrm_remove(pdev);
 	if (host->esi_enabled)
 		platform_device_msi_free_irqs_all(hba->dev);
diff --git a/drivers/ufs/host/ufs-sprd.c b/drivers/ufs/host/ufs-sprd.c
index e455890cf7d4..d220978c2d8c 100644
--- a/drivers/ufs/host/ufs-sprd.c
+++ b/drivers/ufs/host/ufs-sprd.c
@@ -427,7 +427,6 @@ static int ufs_sprd_probe(struct platform_device *pdev)
 
 static void ufs_sprd_remove(struct platform_device *pdev)
 {
-	pm_runtime_get_sync(&(pdev)->dev);
 	ufshcd_pltfrm_remove(pdev);
 }
 
diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
index bad5b1303eb6..b8dadd0a2f4c 100644
--- a/drivers/ufs/host/ufshcd-pltfrm.c
+++ b/drivers/ufs/host/ufshcd-pltfrm.c
@@ -532,8 +532,10 @@ void ufshcd_pltfrm_remove(struct platform_device *pdev)
 {
 	struct ufs_hba *hba =  platform_get_drvdata(pdev);
 
+	pm_runtime_get_sync(&pdev->dev);
 	ufshcd_remove(hba);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 }
 EXPORT_SYMBOL_GPL(ufshcd_pltfrm_remove);
 


