Return-Path: <stable+bounces-100345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C089EABB3
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75CD11889BD7
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E662327A8;
	Tue, 10 Dec 2024 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hohs8y5m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EEB230D2B
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822107; cv=none; b=t+zXkUXiICOFe+vzifGehxcCLQCnJ+3loVbMRY5HH5nFb8/sLTGEu+zKEvOwhuG34rnFYRsFApifGBnufWk5fwK+pAlM/O3eZdNWTUwFmVxmwLpBBmrc/sasdXogveyJ9SQNkZ2EWJEiFFaD+Zux4o3HNr07UiXw/dDCJv0geTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822107; c=relaxed/simple;
	bh=hflM1FkfZBWAvOwhc25Emqtm1jNXpeTGJ7Tj9sEZ+i0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Q7M4ac3ntGlARHL19TsSFk3xi8qrFK5cGgtQJ8G7AaKurhQsfiPeUPslKOvlzKyb7lSuI9OtYhX/jQ5+a+sV0KEKjTbMCssVyqHCvka7brhu2aNh8dDwFAJd841zdtNlUaU03cvoUUxcj7hVgxAlznzRuRjo3cARDgBRpzN4Jso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hohs8y5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A47C4CED6;
	Tue, 10 Dec 2024 09:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733822107;
	bh=hflM1FkfZBWAvOwhc25Emqtm1jNXpeTGJ7Tj9sEZ+i0=;
	h=Subject:To:Cc:From:Date:From;
	b=Hohs8y5m9S/jXVW99GHdN0lpRnE14B9V52eXLnizbqlWwdyieydSj/+rpMG1lx7Nh
	 cnmWg/mRKJolmM2oxy4BzX2KCEh+HUsDIqZSUKOq2Ks1Se90QRA/wvbmwgqyHhpKqm
	 GLIL35APKD4ZVukXk+MFszs68YSoOfJ1fto1r8OM=
Subject: FAILED: patch "[PATCH] scsi: ufs: pltfrm: Disable runtime PM during removal of glue" failed to apply to 5.15-stable tree
To: mani@kernel.org,beanhuo@micron.com,bvanassche@acm.org,manivannan.sadhasivam@linaro.org,martin.petersen@oracle.com,peter.wang@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:14:21 +0100
Message-ID: <2024121021-gilled-kiwi-21ce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d3326e6a3f9bf1e075be2201fb704c2fdf19e2b7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121021-gilled-kiwi-21ce@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d3326e6a3f9bf1e075be2201fb704c2fdf19e2b7 Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Mon, 11 Nov 2024 23:18:32 +0530
Subject: [PATCH] scsi: ufs: pltfrm: Disable runtime PM during removal of glue
 drivers

When the UFSHCD platform glue drivers are removed, runtime PM should be
disabled using pm_runtime_disable() to balance the enablement done in
ufshcd_pltfrm_init(). This is also reported by PM core when the glue driver
is removed and inserted again:

ufshcd-qcom 1d84000.ufshc: Unbalanced pm_runtime_enable!

So disable runtime PM using a new helper API ufshcd_pltfrm_remove(), that
also takes care of removing ufshcd. This helper should be called during the
remove() stage of glue drivers.

Cc: stable@vger.kernel.org # 3.12
Fixes: 62694735ca95 ("[SCSI] ufs: Add runtime PM support for UFS host controller driver")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20241111-ufs_bug_fix-v1-3-45ad8b62f02e@linaro.org
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/ufs/host/cdns-pltfrm.c b/drivers/ufs/host/cdns-pltfrm.c
index 66811d8d1929..b31aa8411151 100644
--- a/drivers/ufs/host/cdns-pltfrm.c
+++ b/drivers/ufs/host/cdns-pltfrm.c
@@ -307,9 +307,7 @@ static int cdns_ufs_pltfrm_probe(struct platform_device *pdev)
  */
 static void cdns_ufs_pltfrm_remove(struct platform_device *pdev)
 {
-	struct ufs_hba *hba =  platform_get_drvdata(pdev);
-
-	ufshcd_remove(hba);
+	ufshcd_pltfrm_remove(pdev);
 }
 
 static const struct dev_pm_ops cdns_ufs_dev_pm_ops = {
diff --git a/drivers/ufs/host/tc-dwc-g210-pltfrm.c b/drivers/ufs/host/tc-dwc-g210-pltfrm.c
index a3877592604d..113e0ef7b2cf 100644
--- a/drivers/ufs/host/tc-dwc-g210-pltfrm.c
+++ b/drivers/ufs/host/tc-dwc-g210-pltfrm.c
@@ -76,10 +76,8 @@ static int tc_dwc_g210_pltfm_probe(struct platform_device *pdev)
  */
 static void tc_dwc_g210_pltfm_remove(struct platform_device *pdev)
 {
-	struct ufs_hba *hba =  platform_get_drvdata(pdev);
-
 	pm_runtime_get_sync(&(pdev)->dev);
-	ufshcd_remove(hba);
+	ufshcd_pltfrm_remove(pdev);
 }
 
 static const struct dev_pm_ops tc_dwc_g210_pltfm_pm_ops = {
diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 91827b3e582b..b20f6526777a 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -1993,7 +1993,7 @@ static void exynos_ufs_remove(struct platform_device *pdev)
 	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
 
 	pm_runtime_get_sync(&(pdev)->dev);
-	ufshcd_remove(hba);
+	ufshcd_pltfrm_remove(pdev);
 
 	phy_power_off(ufs->phy);
 	phy_exit(ufs->phy);
diff --git a/drivers/ufs/host/ufs-hisi.c b/drivers/ufs/host/ufs-hisi.c
index 5ee73ff05251..501609521b26 100644
--- a/drivers/ufs/host/ufs-hisi.c
+++ b/drivers/ufs/host/ufs-hisi.c
@@ -576,9 +576,7 @@ static int ufs_hisi_probe(struct platform_device *pdev)
 
 static void ufs_hisi_remove(struct platform_device *pdev)
 {
-	struct ufs_hba *hba =  platform_get_drvdata(pdev);
-
-	ufshcd_remove(hba);
+	ufshcd_pltfrm_remove(pdev);
 }
 
 static const struct dev_pm_ops ufs_hisi_pm_ops = {
diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 06ab1e5e8b6f..b444146419de 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -1879,10 +1879,8 @@ static int ufs_mtk_probe(struct platform_device *pdev)
  */
 static void ufs_mtk_remove(struct platform_device *pdev)
 {
-	struct ufs_hba *hba =  platform_get_drvdata(pdev);
-
 	pm_runtime_get_sync(&(pdev)->dev);
-	ufshcd_remove(hba);
+	ufshcd_pltfrm_remove(pdev);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 5220ec78021d..3762337d7576 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1864,7 +1864,7 @@ static void ufs_qcom_remove(struct platform_device *pdev)
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 
 	pm_runtime_get_sync(&(pdev)->dev);
-	ufshcd_remove(hba);
+	ufshcd_pltfrm_remove(pdev);
 	if (host->esi_enabled)
 		platform_device_msi_free_irqs_all(hba->dev);
 }
diff --git a/drivers/ufs/host/ufs-renesas.c b/drivers/ufs/host/ufs-renesas.c
index 3ff97112e1f6..21a64b34397d 100644
--- a/drivers/ufs/host/ufs-renesas.c
+++ b/drivers/ufs/host/ufs-renesas.c
@@ -397,9 +397,7 @@ static int ufs_renesas_probe(struct platform_device *pdev)
 
 static void ufs_renesas_remove(struct platform_device *pdev)
 {
-	struct ufs_hba *hba = platform_get_drvdata(pdev);
-
-	ufshcd_remove(hba);
+	ufshcd_pltfrm_remove(pdev);
 }
 
 static struct platform_driver ufs_renesas_platform = {
diff --git a/drivers/ufs/host/ufs-sprd.c b/drivers/ufs/host/ufs-sprd.c
index d8b165908809..e455890cf7d4 100644
--- a/drivers/ufs/host/ufs-sprd.c
+++ b/drivers/ufs/host/ufs-sprd.c
@@ -427,10 +427,8 @@ static int ufs_sprd_probe(struct platform_device *pdev)
 
 static void ufs_sprd_remove(struct platform_device *pdev)
 {
-	struct ufs_hba *hba =  platform_get_drvdata(pdev);
-
 	pm_runtime_get_sync(&(pdev)->dev);
-	ufshcd_remove(hba);
+	ufshcd_pltfrm_remove(pdev);
 }
 
 static const struct dev_pm_ops ufs_sprd_pm_ops = {
diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
index 1f4f30d6cb42..bad5b1303eb6 100644
--- a/drivers/ufs/host/ufshcd-pltfrm.c
+++ b/drivers/ufs/host/ufshcd-pltfrm.c
@@ -524,6 +524,19 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(ufshcd_pltfrm_init);
 
+/**
+ * ufshcd_pltfrm_remove - Remove ufshcd platform
+ * @pdev: pointer to Platform device handle
+ */
+void ufshcd_pltfrm_remove(struct platform_device *pdev)
+{
+	struct ufs_hba *hba =  platform_get_drvdata(pdev);
+
+	ufshcd_remove(hba);
+	pm_runtime_disable(&pdev->dev);
+}
+EXPORT_SYMBOL_GPL(ufshcd_pltfrm_remove);
+
 MODULE_AUTHOR("Santosh Yaragnavi <santosh.sy@samsung.com>");
 MODULE_AUTHOR("Vinayak Holikatti <h.vinayak@samsung.com>");
 MODULE_DESCRIPTION("UFS host controller Platform bus based glue driver");
diff --git a/drivers/ufs/host/ufshcd-pltfrm.h b/drivers/ufs/host/ufshcd-pltfrm.h
index df387be5216b..3017f8e8f93c 100644
--- a/drivers/ufs/host/ufshcd-pltfrm.h
+++ b/drivers/ufs/host/ufshcd-pltfrm.h
@@ -31,6 +31,7 @@ int ufshcd_negotiate_pwr_params(const struct ufs_host_params *host_params,
 void ufshcd_init_host_params(struct ufs_host_params *host_params);
 int ufshcd_pltfrm_init(struct platform_device *pdev,
 		       const struct ufs_hba_variant_ops *vops);
+void ufshcd_pltfrm_remove(struct platform_device *pdev);
 int ufshcd_populate_vreg(struct device *dev, const char *name,
 			 struct ufs_vreg **out_vreg, bool skip_current);
 


