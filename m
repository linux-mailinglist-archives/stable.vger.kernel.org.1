Return-Path: <stable+bounces-108276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45272A0A4B3
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 17:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481973A05C3
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 16:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D46190059;
	Sat, 11 Jan 2025 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VrqxUO2s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BC71474DA
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736612316; cv=none; b=hYgNhyx47pPMz+2QaZ3yqxVc9/V3/dKIUk9CwCBaDxJ84y3BOKdxjU/w+8j1ob9dxcplm2bQl18vSVEnh97+rWTwCrZ6uYiZWPMwRSW4w46lPAvDnlA7YwzKlr5vBHGuJwUf03z9CAkPwGubZNUrOaXD/y3l39xJj6K5SI6PkRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736612316; c=relaxed/simple;
	bh=U/ruJAjnJAsL2YZVv6nABF+1Ml1DtMgAxcRwnZL3KCo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PQ4KudnTpkwK1AvpnF95GmnYCnAbL33E1z4bxOdZw7Sy3j1XqNojf9DxVmQHRt+BybiFVcXIvvtMFFcR5qyPOH3S/CoY5Iq8KAKdSHMNuHD4RQrfsBz8fhW4t4HOKsGj5zM9pnxp9vLnOqtpS2wfmjHRSenAUx801TypiC9LMIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VrqxUO2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05305C4CED2;
	Sat, 11 Jan 2025 16:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736612315;
	bh=U/ruJAjnJAsL2YZVv6nABF+1Ml1DtMgAxcRwnZL3KCo=;
	h=Subject:To:Cc:From:Date:From;
	b=VrqxUO2sG7CuU7M2RvXLztvgEqwSseaPoOonKPihXN/osjMEEdGkLTICdFGOYApy0
	 XuhkTjwseFpce4JcJtOg0aau0e540nZKn1ofNIwLrz2+FwAld4GjhOMC0P3zHIcnC6
	 5q0FkuDQqceNoPI7MTjeXGieMXoK9NGC0nonePzw=
Subject: FAILED: patch "[PATCH] scsi: ufs: qcom: Power down the controller/device during" failed to apply to 6.6-stable tree
To: manivannan.sadhasivam@linaro.org,amit.pundir@linaro.org,bvanassche@acm.org,martin.petersen@oracle.com,neil.armstrong@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 11 Jan 2025 17:18:24 +0100
Message-ID: <2025011124-swoosh-staple-7fae@gregkh>
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
git cherry-pick -x 3b2f56860b05bf0cea86af786fd9b7faa8fe3ef3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011124-swoosh-staple-7fae@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3b2f56860b05bf0cea86af786fd9b7faa8fe3ef3 Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 19 Dec 2024 22:20:44 +0530
Subject: [PATCH] scsi: ufs: qcom: Power down the controller/device during
 system suspend for SM8550/SM8650 SoCs

SM8550 and SM8650 SoCs doesn't support UFS PHY retention. So once these SoCs
reaches the low power state (CX power collapse) during system suspend, all
the PHY hardware state gets lost. This leads to the UFS resume failure:

  ufshcd-qcom 1d84000.ufs: ufshcd_uic_hibern8_exit: hibern8 exit failed. ret = 5
  ufshcd-qcom 1d84000.ufs: __ufshcd_wl_resume: hibern8 exit failed 5
  ufs_device_wlun 0:0:0:49488: ufshcd_wl_resume failed: 5
  ufs_device_wlun 0:0:0:49488: PM: dpm_run_callback(): scsi_bus_resume+0x0/0x84 returns 5
  ufs_device_wlun 0:0:0:49488: PM: failed to resume async: error 5

With the default system suspend level of UFS_PM_LVL_3, the power domain for
UFS PHY needs to be kept always ON to retain the state. But this would
prevent these SoCs from reaching the CX power collapse state, leading to
poor power saving during system suspend.

So to fix this issue without affecting the power saving, set
'ufs_qcom_drvdata::no_phy_retention' to true which sets 'hba->spm_lvl' to
UFS_PM_LVL_5 to allow both the controller and device (in turn the PHY) to be
powered down during system suspend for these SoCs by default.

Cc: stable@vger.kernel.org # 6.3
Fixes: 35cf1aaab169 ("arm64: dts: qcom: sm8550: Add UFS host controller and phy nodes")
Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Amit Pundir <amit.pundir@linaro.org> # on SM8550-HDK
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20241219-ufs-qcom-suspend-fix-v3-4-63c4b95a70b9@linaro.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 7042322d55e9..91e94fe990b4 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1069,6 +1069,7 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	struct device *dev = hba->dev;
 	struct ufs_qcom_host *host;
 	struct ufs_clk_info *clki;
+	const struct ufs_qcom_drvdata *drvdata = of_device_get_match_data(hba->dev);
 
 	host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
 	if (!host)
@@ -1148,6 +1149,9 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 		dev_warn(dev, "%s: failed to configure the testbus %d\n",
 				__func__, err);
 
+	if (drvdata && drvdata->no_phy_retention)
+		hba->spm_lvl = UFS_PM_LVL_5;
+
 	return 0;
 
 out_variant_clear:
@@ -1867,6 +1871,7 @@ static void ufs_qcom_remove(struct platform_device *pdev)
 
 static const struct ufs_qcom_drvdata ufs_qcom_sm8550_drvdata = {
 	.quirks = UFSHCD_QUIRK_BROKEN_LSDBS_CAP,
+	.no_phy_retention = true,
 };
 
 static const struct of_device_id ufs_qcom_of_match[] __maybe_unused = {
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 15f6dad8b27f..919f53682beb 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -219,6 +219,7 @@ struct ufs_qcom_host {
 
 struct ufs_qcom_drvdata {
 	enum ufshcd_quirks quirks;
+	bool no_phy_retention;
 };
 
 static inline u32


