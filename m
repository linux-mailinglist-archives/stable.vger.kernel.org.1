Return-Path: <stable+bounces-171178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0A3B2A776
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 859257BAD7E
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFFE335BD8;
	Mon, 18 Aug 2025 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mz+VBrHQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAD7335BA3;
	Mon, 18 Aug 2025 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525072; cv=none; b=HyHI8+UQ6LEQwG/xmDdwyxbs0CWW2W3E1A2YtwS++dg+IJllCVyXE+o2rh8Tg776xgZ1gJYVf6GZj8WhCkbsT+/YKVTsdSo05HtzJ0c47oilt8ePzVKETwJd5xrJ6GPh+4UIAtLhK2muZyiufF8TBofT42KTPIJ0MoLGIzP1Nrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525072; c=relaxed/simple;
	bh=4nDcJudqmOC2yzAUSFqaBK171aGD9MDYOEnnbaelPNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAdYhaVWjFA9ws7dsJwnOEUvodZLvvTYtFiHuWxWIwHdcDtQjGKWGPu3I5NXAATSJQmORrX4fSpV4K+CFio11zx7Ui/t/AJOxyDKr3pGc85aFR3T5BbOp1yk/XQMDFoRcxrh5pzFEuyTlPkIBzSZH01pcHy7lSTmFiRQUZA+sLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mz+VBrHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B316C4CEEB;
	Mon, 18 Aug 2025 13:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755525071;
	bh=4nDcJudqmOC2yzAUSFqaBK171aGD9MDYOEnnbaelPNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mz+VBrHQTToPB4c0s7jyytSNu1ac9XPOVXZwtkYiUJY2MVwEqPwyhUOloiVjsiYmW
	 a8wJKKJCWAevL5XoDKiynCQxUFTvhD5HGHiJ4grQM4Hv7jN11s5GkW6TBA9koygPBY
	 7tPVACfvwCA9L9z4rpsBVAyu2QOXEm8hVpQkcPVg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vivek Pernamitta <quic_vpernami@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 132/570] bus: mhi: host: pci_generic: Disable runtime PM for QDU100
Date: Mon, 18 Aug 2025 14:41:59 +0200
Message-ID: <20250818124510.909511919@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
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

From: Vivek Pernamitta <quic_vpernami@quicinc.com>

[ Upstream commit 0494cf9793b7c250f63fdb2cb6b648473e9d4ae6 ]

The QDU100 device does not support the MHI M3 state, necessitating the
disabling of runtime PM for this device. It is essential to disable
runtime PM if the device does not support M3 state.

Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
[mani: Fixed the kdoc comment for no_m3]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Link: https://patch.msgid.link/20250425-vdev_next-20250411_pm_disable-v4-1-d4870a73ebf9@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/mhi/host/pci_generic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 0d9295535bbf..7655a389dc59 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -43,6 +43,7 @@
  * @mru_default: default MRU size for MBIM network packets
  * @sideband_wake: Devices using dedicated sideband GPIO for wakeup instead
  *		   of inband wake support (such as sdx24)
+ * @no_m3: M3 not supported
  */
 struct mhi_pci_dev_info {
 	const struct mhi_controller_config *config;
@@ -54,6 +55,7 @@ struct mhi_pci_dev_info {
 	unsigned int dma_data_width;
 	unsigned int mru_default;
 	bool sideband_wake;
+	bool no_m3;
 };
 
 #define MHI_CHANNEL_CONFIG_UL(ch_num, ch_name, el_count, ev_ring) \
@@ -295,6 +297,7 @@ static const struct mhi_pci_dev_info mhi_qcom_qdu100_info = {
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
 	.dma_data_width = 32,
 	.sideband_wake = false,
+	.no_m3 = true,
 };
 
 static const struct mhi_channel_config mhi_qcom_sa8775p_channels[] = {
@@ -1319,8 +1322,8 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* start health check */
 	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
 
-	/* Only allow runtime-suspend if PME capable (for wakeup) */
-	if (pci_pme_capable(pdev, PCI_D3hot)) {
+	/* Allow runtime suspend only if both PME from D3Hot and M3 are supported */
+	if (pci_pme_capable(pdev, PCI_D3hot) && !(info->no_m3)) {
 		pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
 		pm_runtime_use_autosuspend(&pdev->dev);
 		pm_runtime_mark_last_busy(&pdev->dev);
-- 
2.39.5




