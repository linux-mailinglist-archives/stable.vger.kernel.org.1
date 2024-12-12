Return-Path: <stable+bounces-101569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584349EED3B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6984B188D417
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142022210DB;
	Thu, 12 Dec 2024 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JV61ADrq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34882210D5;
	Thu, 12 Dec 2024 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018022; cv=none; b=OnsVV07HxxVmWS9TTRfEDf+0F87f7+0ls6qpQz9Iei1dchFvofeKNfh2NABmDlUVUXtp/GGrvG74vlOHAM5Wyr0e4MEs7CUCoa2YVGxeVkROlTaRiVHO6UtCcXDKnMtGdYRiUNScae0B5g/OoK7VIWBtVG7d4E4qzwCqQSC1uLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018022; c=relaxed/simple;
	bh=s37SaVY3oxUUzf/tQhgwTbCNJoxqsFRNM8wqNf3e2bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5PL/CNiRsisisEGSTD1yuv/ons209DlbbV6grdwATjfrfz7ZQaL8t7kUoFFetojYjPvK9VfkeS4Y7tMWs/0hwDKY/QRWFobMKEVilXIWo0UzfnVqGImtvvNQAHlSywhWtfhe/R0FwOaIWmcWS//s3qhoCJ1b1AhxAmj7EDAyC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JV61ADrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4F8C4CECE;
	Thu, 12 Dec 2024 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734018022;
	bh=s37SaVY3oxUUzf/tQhgwTbCNJoxqsFRNM8wqNf3e2bY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JV61ADrqw0xQjRATnjiFio+7FihB3BlOIbnKhpzXP4x49a6zDljtedORS9FhJvDYP
	 6340Vdow0kvJ3n7yJk4yZ5uOoZh4wxZoY1cA+/7Njddeqol1CaiGagVKP5Y6v8NRKw
	 O4N6V1358gNpzKrQ5j4MKYvsvHgLpjjtt4so1n6Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Wang <peter.wang@mediatek.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.6 158/356] scsi: ufs: core: Add missing post notify for power mode change
Date: Thu, 12 Dec 2024 15:57:57 +0100
Message-ID: <20241212144250.880129098@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Wang <peter.wang@mediatek.com>

commit 7f45ed5f0cd5ccbbec79adc6c48a67d6a85fba56 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ufs/core/ufshcd.c |    7 ++++---
 include/ufs/ufshcd.h      |   10 ++++++----
 2 files changed, 10 insertions(+), 7 deletions(-)

--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4555,9 +4555,6 @@ static int ufshcd_change_power_mode(stru
 		dev_err(hba->dev,
 			"%s: power mode change failed %d\n", __func__, ret);
 	} else {
-		ufshcd_vops_pwr_change_notify(hba, POST_CHANGE, NULL,
-								pwr_mode);
-
 		memcpy(&hba->pwr_info, pwr_mode,
 			sizeof(struct ufs_pa_layer_attr));
 	}
@@ -4586,6 +4583,10 @@ int ufshcd_config_pwr_mode(struct ufs_hb
 
 	ret = ufshcd_change_power_mode(hba, &final_params);
 
+	if (!ret)
+		ufshcd_vops_pwr_change_notify(hba, POST_CHANGE, NULL,
+					&final_params);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ufshcd_config_pwr_mode);
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -304,7 +304,9 @@ struct ufs_pwr_mode_info {
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
@@ -341,9 +343,9 @@ struct ufs_hba_variant_ops {
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



