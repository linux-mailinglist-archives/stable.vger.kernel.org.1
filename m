Return-Path: <stable+bounces-139005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 440EEAA3D99
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 02:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82761889F6D
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 00:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD992922CB;
	Tue, 29 Apr 2025 23:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbqOvxeH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CA32922C4;
	Tue, 29 Apr 2025 23:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970704; cv=none; b=N0RvZUQODoXbawYb+3vZiILpD44h5AdUHzYsxmUzRpMubSEKMan1NOpK3nywakT21EVYNM9RYrdsnzVmOkN82Nn6OnNFKrCKAQD+Tb83Xfxan3R7Z1wIQXITgAXnX2LkY/n7rzY99EcKTN8aEVarpGSIN+IDnCenskK0j9MhjEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970704; c=relaxed/simple;
	bh=OuPv82rWcLem94oBrXnB1UlTGA80HpJ8wilm7gvnBMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JlyWinYtLGTNOy1A5GwaWDv0Vx2liBVMqv4EBNgglYLnKG/7b4UnFUCaJm6p2+zakLF25Zxp52yHAwK2ItAJIS93vid+DY3J9ZJ2VstUyo07oeMGq1/5Ixv8khdI3ngHrj6loU0xGrib24AecFCnsv2tsje+v9bUSE56iI/sY2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbqOvxeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0609EC4CEE3;
	Tue, 29 Apr 2025 23:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970704;
	bh=OuPv82rWcLem94oBrXnB1UlTGA80HpJ8wilm7gvnBMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IbqOvxeHT/bqSCUvGRBknbO9VAxGYS8kFBiGifxqPHJJhy62W7NiXn4J7Bg+VCA+a
	 F9NVX920it/yOgSRy/Us8yqz2eAKgS3Nbi5ZPWT6AqWuOJhDwmJ7OOTPAgyOlVGjrH
	 puUEuZkhKeX2aN9BS/M9xZ8TwHLeuyBeWKuslfcrEnuIeY851CWHry+JmCG6N47pJ0
	 ZbtGMa1ax8n6Pa51djMFIAwL68MhZY+VI762sWxjvkMMFolTNq5PbEALxeDb4tMjqX
	 2Xqa1lYXEhtCaFSFxOCHE3Hnmq6QgTP5vCOY6MmnVoIj+rB8liLjbtFi/RGZBv7Zr4
	 ckjr9hWdCkg9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manish Pandey <quic_mapa@quicinc.com>,
	Bean Huo <beanhuo@micron.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	James.Bottomley@HansenPartnership.com,
	bvanassche@acm.org,
	peter.wang@mediatek.com,
	avri.altman@wdc.com,
	quic_nguyenb@quicinc.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 10/37] scsi: ufs: Introduce quirk to extend PA_HIBERN8TIME for UFS devices
Date: Tue, 29 Apr 2025 19:50:55 -0400
Message-Id: <20250429235122.537321-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235122.537321-1-sashal@kernel.org>
References: <20250429235122.537321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.25
Content-Transfer-Encoding: 8bit

From: Manish Pandey <quic_mapa@quicinc.com>

[ Upstream commit 569330a34a31a52c904239439984a59972c11d28 ]

Samsung UFS devices require additional time in hibern8 mode before
exiting, beyond the negotiated handshaking phase between the host and
device.  Introduce a quirk to increase the PA_HIBERN8TIME parameter by
100 µs, a value derived from experiments, to ensure a proper hibernation
process.

Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
Link: https://lore.kernel.org/r/20250411121630.21330-3-quic_mapa@quicinc.com
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 29 +++++++++++++++++++++++++++++
 include/ufs/ufs_quirks.h  |  6 ++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 89fc0b5662919..856afd0e6a4b5 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -278,6 +278,7 @@ static const struct ufs_dev_quirk ufs_fixups[] = {
 	  .model = UFS_ANY_MODEL,
 	  .quirk = UFS_DEVICE_QUIRK_DELAY_BEFORE_LPM |
 		   UFS_DEVICE_QUIRK_HOST_PA_TACTIVATE |
+		   UFS_DEVICE_QUIRK_PA_HIBER8TIME |
 		   UFS_DEVICE_QUIRK_RECOVERY_FROM_DL_NAC_ERRORS },
 	{ .wmanufacturerid = UFS_VENDOR_SKHYNIX,
 	  .model = UFS_ANY_MODEL,
@@ -8459,6 +8460,31 @@ static int ufshcd_quirk_tune_host_pa_tactivate(struct ufs_hba *hba)
 	return ret;
 }
 
+/**
+ * ufshcd_quirk_override_pa_h8time - Ensures proper adjustment of PA_HIBERN8TIME.
+ * @hba: per-adapter instance
+ *
+ * Some UFS devices require specific adjustments to the PA_HIBERN8TIME parameter
+ * to ensure proper hibernation timing. This function retrieves the current
+ * PA_HIBERN8TIME value and increments it by 100us.
+ */
+static void ufshcd_quirk_override_pa_h8time(struct ufs_hba *hba)
+{
+	u32 pa_h8time;
+	int ret;
+
+	ret = ufshcd_dme_get(hba, UIC_ARG_MIB(PA_HIBERN8TIME), &pa_h8time);
+	if (ret) {
+		dev_err(hba->dev, "Failed to get PA_HIBERN8TIME: %d\n", ret);
+		return;
+	}
+
+	/* Increment by 1 to increase hibernation time by 100 µs */
+	ret = ufshcd_dme_set(hba, UIC_ARG_MIB(PA_HIBERN8TIME), pa_h8time + 1);
+	if (ret)
+		dev_err(hba->dev, "Failed updating PA_HIBERN8TIME: %d\n", ret);
+}
+
 static void ufshcd_tune_unipro_params(struct ufs_hba *hba)
 {
 	ufshcd_vops_apply_dev_quirks(hba);
@@ -8469,6 +8495,9 @@ static void ufshcd_tune_unipro_params(struct ufs_hba *hba)
 
 	if (hba->dev_quirks & UFS_DEVICE_QUIRK_HOST_PA_TACTIVATE)
 		ufshcd_quirk_tune_host_pa_tactivate(hba);
+
+	if (hba->dev_quirks & UFS_DEVICE_QUIRK_PA_HIBER8TIME)
+		ufshcd_quirk_override_pa_h8time(hba);
 }
 
 static void ufshcd_clear_dbg_ufs_stats(struct ufs_hba *hba)
diff --git a/include/ufs/ufs_quirks.h b/include/ufs/ufs_quirks.h
index 41ff44dfa1db3..f52de5ed1b3b6 100644
--- a/include/ufs/ufs_quirks.h
+++ b/include/ufs/ufs_quirks.h
@@ -107,4 +107,10 @@ struct ufs_dev_quirk {
  */
 #define UFS_DEVICE_QUIRK_DELAY_AFTER_LPM        (1 << 11)
 
+/*
+ * Some ufs devices may need more time to be in hibern8 before exiting.
+ * Enable this quirk to give it an additional 100us.
+ */
+#define UFS_DEVICE_QUIRK_PA_HIBER8TIME          (1 << 12)
+
 #endif /* UFS_QUIRKS_H_ */
-- 
2.39.5


