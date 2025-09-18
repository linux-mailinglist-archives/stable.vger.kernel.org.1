Return-Path: <stable+bounces-177090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB62B40353
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F21F67B1487
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F374E30EF64;
	Tue,  2 Sep 2025 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="unCYgKG8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCFA3054E1;
	Tue,  2 Sep 2025 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819544; cv=none; b=XAK+u1gJWNDGJm+3A03L6VnQ5GUOkVZV3yfyd+H36hiu/cnvortRKRj8OY0a5a5wPrHrTa56hFIaosRJvSOWmKGEW8SSLKVmLkphsm2xOk0uLuCN6sdDJlLYsUio/5kfQXP57YgQ+iLEE1Y5dVAZmeSucT+G9y56X2ecy7T56dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819544; c=relaxed/simple;
	bh=uDutAKyfx0VP7UCFPyNQsI8ghP5PBEzbQgA2DR/qOYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4UdwGwjYXdu657P6uEr/6PDd1k7GyNppz94F/6kbTvX8SFfKDvExzUdI1VCuHHHMeDISrv4iCfpbJ+xivCNYrOC76fhZo9RSBR7aT3b83Ad5MakfNhajTPGXC4GqEnx7CRivOq0lbcxDOyfSQx6W3LNEmHNLtAPyBZxVxp7cXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=unCYgKG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FAAC4CEED;
	Tue,  2 Sep 2025 13:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756819544;
	bh=uDutAKyfx0VP7UCFPyNQsI8ghP5PBEzbQgA2DR/qOYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=unCYgKG81sKEwpgDqNWB3NVUc/PbBCW75OTNZerkPszf444PcaodNQGVr4n88mSZD
	 9OLoqagJsk7zPU9Ds84h6TJsD/uwbB+zQ7u/NfR5tJt3/R4o8WDyn3iDbgbEtWm+lF
	 wevEgd1UPrGw5dhRuOx/LYRP2Ss+qkzH07TCRhbQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 034/142] drm/msm/kms: move snapshot init earlier in KMS init
Date: Tue,  2 Sep 2025 15:18:56 +0200
Message-ID: <20250902131949.450795822@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>
References: <20250902131948.154194162@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit 553666f839b86545300773954df7426a45c169c4 ]

Various parts of the display driver can be triggering the display
snapshot (including the IOMMU fault handlers). Move the call to
msm_disp_snapshot_init() before KMS initialization, otherwise it is
possible to ocassionally trigger the kernel fault during init:

  __lock_acquire+0x44/0x2798 (P)
  lock_acquire+0x114/0x25c
  _raw_spin_lock_irqsave+0x6c/0x90
  kthread_queue_work+0x2c/0xac
  msm_disp_snapshot_state+0x2c/0x4c
  msm_kms_fault_handler+0x2c/0x74
  msm_disp_fault_handler+0x30/0x48
  report_iommu_fault+0x54/0x128
  arm_smmu_context_fault+0x74/0x184
  __handle_irq_event_percpu+0xa4/0x24c
  handle_irq_event_percpu+0x20/0x5c
  handle_irq_event+0x48/0x84
  handle_fasteoi_irq+0xcc/0x170
  generic_handle_domain_irq+0x48/0x70
  gic_handle_irq+0x54/0x11c
  call_on_irq_stack+0x3c/0x50
  do_interrupt_handler+0x54/0x78
  el1_interrupt+0x3c/0x5c
  el1h_64_irq_handler+0x20/0x30
  el1h_64_irq+0x6c/0x70
  _raw_spin_unlock_irqrestore+0x44/0x68 (P)
  klist_next+0xc4/0x124
  bus_for_each_drv+0x9c/0xe8
  __device_attach+0xfc/0x190
  device_initial_probe+0x1c/0x2c
  bus_probe_device+0x44/0xa0
  device_add+0x204/0x3e4
  platform_device_add+0x170/0x244
  platform_device_register_full+0x130/0x138
  drm_connector_hdmi_audio_init+0xc0/0x108
  drm_bridge_connector_init+0x318/0x394
  msm_dsi_manager_connector_init+0xac/0xdc
  msm_dsi_modeset_init+0x78/0xc0
  _dpu_kms_drm_obj_init+0x198/0x75c
  dpu_kms_hw_init+0x2f8/0x494
  msm_drm_kms_init+0xb0/0x230
  msm_drm_init+0x218/0x250
  msm_drm_bind+0x3c/0x4c
  try_to_bring_up_aggregate_device+0x208/0x2a4
  __component_add+0xa8/0x188
  component_add+0x1c/0x2c
  dsi_dev_attach+0x24/0x34
  dsi_host_attach+0x68/0xa0
  devm_mipi_dsi_attach+0x40/0xcc
  lt9611_attach_dsi+0x94/0x118
  lt9611_probe+0x368/0x3c8
  i2c_device_probe+0x2d0/0x3d8
  really_probe+0x130/0x354
  __driver_probe_device+0xac/0x110
  driver_probe_device+0x44/0x110
  __device_attach_driver+0xb0/0x138
  bus_for_each_drv+0x90/0xe8
  __device_attach+0xfc/0x190
  device_initial_probe+0x1c/0x2c
  bus_probe_device+0x44/0xa0
  deferred_probe_work_func+0xac/0x110
  process_one_work+0x20c/0x51c
  process_scheduled_works+0x58/0x88
  worker_thread+0x1ec/0x304
  kthread+0x194/0x1d4
  ret_from_fork+0x10/0x20

Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Fixes: 98659487b845 ("drm/msm: add support to take dpu snapshot")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/664149/
Link: https://lore.kernel.org/r/20250715-msm-move-snapshot-init-v1-1-f39c396192ab@oss.qualcomm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_kms.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index 35d5397e73b4c..f2c00716f9d1a 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -258,6 +258,12 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 	if (ret)
 		return ret;
 
+	ret = msm_disp_snapshot_init(ddev);
+	if (ret) {
+		DRM_DEV_ERROR(dev, "msm_disp_snapshot_init failed ret = %d\n", ret);
+		return ret;
+	}
+
 	ret = priv->kms_init(ddev);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to load kms\n");
@@ -310,10 +316,6 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 		goto err_msm_uninit;
 	}
 
-	ret = msm_disp_snapshot_init(ddev);
-	if (ret)
-		DRM_DEV_ERROR(dev, "msm_disp_snapshot_init failed ret = %d\n", ret);
-
 	drm_mode_config_reset(ddev);
 
 	return 0;
-- 
2.50.1




