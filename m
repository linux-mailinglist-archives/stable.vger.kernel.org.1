Return-Path: <stable+bounces-1239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8BA7F7EB0
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCD21C213DC
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBE034189;
	Fri, 24 Nov 2023 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nCmKMRi7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3231759;
	Fri, 24 Nov 2023 18:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA981C433C8;
	Fri, 24 Nov 2023 18:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850906;
	bh=UdTcHTMYnFBLrZ+KmEABt0W/L7LOyKCGoC4N1wLr3Cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nCmKMRi7e4BA6qkGkgNSrHAuHOXcK5XkRGNGvACa+nAPjn+EirKSJnXiCp36GN6Cs
	 3EakDUrgLwIytBblu/6vkj2yKU+rQIoYkS2a+YTFxMPU80ECbCbR7WGUPUnKcrhT5j
	 M4WFQpwocUC0os1vXxz5j41vZ5w+gop7pNGNmQTY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Can Guo <quic_cang@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.5 235/491] scsi: ufs: qcom: Update PHY settings only when scaling to higher gears
Date: Fri, 24 Nov 2023 17:47:51 +0000
Message-ID: <20231124172031.618085160@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

commit fc88ca19ad0989dc0e4d4b126d5d0ba91f6cb616 upstream.

The "hs_gear" variable is used to program the PHY settings (submode) during
ufs_qcom_power_up_sequence(). Currently, it is being updated every time the
agreed gear changes. Due to this, if the gear got downscaled before suspend
(runtime/system), then while resuming, the PHY settings for the lower gear
will be applied first and later when scaling to max gear with REINIT, the
PHY settings for the max gear will be applied.

This adds a latency while resuming and also really not needed as the PHY
gear settings are backwards compatible i.e., we can continue using the PHY
settings for max gear with lower gear speed.

So let's update the "hs_gear" variable _only_ when the agreed gear is
greater than the current one. This guarantees that the PHY settings will be
changed only during probe time and fatal error condition.

Due to this, UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH can now be skipped
when the PM operation is in progress.

Cc: stable@vger.kernel.org
Fixes: 96a7141da332 ("scsi: ufs: core: Add support for reinitializing the UFS device")
Reported-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20230908145329.154024-1-manivannan.sadhasivam@linaro.org
Reviewed-by: Can Guo <quic_cang@quicinc.com>
Tested-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ufs/core/ufshcd.c   |    3 ++-
 drivers/ufs/host/ufs-qcom.c |    9 +++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8798,7 +8798,8 @@ static int ufshcd_probe_hba(struct ufs_h
 	if (ret)
 		goto out;
 
-	if (hba->quirks & UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH) {
+	if (!hba->pm_op_in_progress &&
+	    (hba->quirks & UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH)) {
 		/* Reset the device and controller before doing reinit */
 		ufshcd_device_reset(hba);
 		ufshcd_hba_stop(hba);
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -820,8 +820,13 @@ static int ufs_qcom_pwr_change_notify(st
 			return ret;
 		}
 
-		/* Use the agreed gear */
-		host->hs_gear = dev_req_params->gear_tx;
+		/*
+		 * Update hs_gear only when the gears are scaled to a higher value. This is because,
+		 * the PHY gear settings are backwards compatible and we only need to change the PHY
+		 * settings while scaling to higher gears.
+		 */
+		if (dev_req_params->gear_tx > host->hs_gear)
+			host->hs_gear = dev_req_params->gear_tx;
 
 		/* enable the device ref clock before changing to HS mode */
 		if (!ufshcd_is_hs_mode(&hba->pwr_info) &&



