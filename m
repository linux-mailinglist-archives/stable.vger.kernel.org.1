Return-Path: <stable+bounces-149145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A671ACB165
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD1B1943D03
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F55242D64;
	Mon,  2 Jun 2025 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L22DSkju"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7291A22E01E;
	Mon,  2 Jun 2025 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873039; cv=none; b=Oj62pApWXCLtC3Qr6TbFkvSKNoZfGisA7edO8BlbaXro4LK1GBgUvqnK1W/H93te1uYjhvWzFb+zrEXHT7ZKJbjgtdcKSIoXVRxeVKy0P5Jt6hpn0xMrIEmqYSzr6pFQffa7GpGjeXeDkTP7IImXvqSspxBWikXiy7uOw7px+4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873039; c=relaxed/simple;
	bh=fup5kxHKp0bGzlY6eQgE9C0BW1Vxl13h6DzMyYm8Ai8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9szjhBezTIN2hSNGpQs2jCmRnH1cuqy4uAAWTmFEvTUdjO1aNI78ujlj2ZhKJJ0Xxs56ELuT/FlmgGs/3dO35X3Eh9Ly2qpCUyga4WgZyZAVMpgnwZ1e3wKNA8TY3g8LNJ+2x9kzDNwKNQSJ2qz+lpOmIUq54ouZJOPhQbRlts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L22DSkju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4071C4CEF2;
	Mon,  2 Jun 2025 14:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748873039;
	bh=fup5kxHKp0bGzlY6eQgE9C0BW1Vxl13h6DzMyYm8Ai8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L22DSkjuxDJMkUSez2KinXIjzgLi5gRl1qBGILlODAlaAq6Mj51RZuznWqN/sIPXM
	 vrwsjg5Z7xY+GQhqWaBP6+5XT1E8/p656cWLi1u1h/OFdyRFW0C5i7fCh9U9eQPCjl
	 dmY3Z4z3rBYI7cHDlhW99lYPpvKkkMQyZ+MslQnM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manish Pandey <quic_mapa@quicinc.com>,
	Bean Huo <beanhuo@micron.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 019/444] scsi: ufs: Introduce quirk to extend PA_HIBERN8TIME for UFS devices
Date: Mon,  2 Jun 2025 15:41:23 +0200
Message-ID: <20250602134341.694640273@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index cb5611cbf4547..2346a1fc72b56 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -257,6 +257,7 @@ static const struct ufs_dev_quirk ufs_fixups[] = {
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
 	if (ufshcd_is_unipro_pa_params_tuning_req(hba)) {
@@ -8474,6 +8500,9 @@ static void ufshcd_tune_unipro_params(struct ufs_hba *hba)
 
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




