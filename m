Return-Path: <stable+bounces-127718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E3EA7A9CE
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC7317669E
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D3D253B65;
	Thu,  3 Apr 2025 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQnsXx0r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28AF253B51;
	Thu,  3 Apr 2025 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706939; cv=none; b=RZ//ms+hnaZPgRZvGkdVcNn7YKrvoKCm1ndB98Ol+qXrlRE8vdcz5aUG62DE3I0WYccKFakps5XHoJwxVnWKil+S0px705q7vTH62PjadFkjmab15NdZVBj6pvw/kD61sSlxkUNBPbkelvooWpyj0V841Xprf5R/4L8TxEjdbUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706939; c=relaxed/simple;
	bh=EZMuhSshL8pIrS8Y4e3bN/RLqQj4uKA4K5ZJfOpenUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qVmTvdg8HSbaUQrcoVJbdobEd7cahSVeNEvPnoucBm9QccLhIac/Duqm0hx/hp0ua61lMAyPhMX0ATHwLh8P6vTIOYIcXOF4a34xPWxMohRG9PtLr7WsOXWWNBf+UqX3nolHFV3N3RFR3i7rW5WbJFVjlxdrjfNUBZbYCZaOgRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQnsXx0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AD0C4CEE8;
	Thu,  3 Apr 2025 19:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743706938;
	bh=EZMuhSshL8pIrS8Y4e3bN/RLqQj4uKA4K5ZJfOpenUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UQnsXx0rD305YW6p/vjJ+2fiLc5DUq4KUOwgbX36KJCqZuW1u98fGttj6AG0qtwun
	 Hi7tBdUqMlQ/tKIBjbI2zspNq/48AqoTOrTmBtZrZ5DApZoGHdoBTQMU4rYetNq4Xt
	 nK/2X/Io+4cGUGL/FeNONgmHc5uEltUA/w9lD1xDFFP1a8c5ms02HRMsIM5DUCDgHC
	 cutuEnGv/jhFWpFu1nVSWUEH+pGxfW+Z/apUSHJllWqsZ97dVXFHycz+tI2lSVGHVn
	 239zr7jwUGeS9Wdx9q29f1K6C0oDOKLQ7mAzrj8JcgFYKfYAiUbpp6hKDnsb/TL6gr
	 iXxNDdVQP9rbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	ath11k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 03/54] wifi: ath11k: fix memory leak in ath11k_xxx_remove()
Date: Thu,  3 Apr 2025 15:01:18 -0400
Message-Id: <20250403190209.2675485-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Miaoqing Pan <quic_miaoqing@quicinc.com>

[ Upstream commit efb24b1f0d29537714dd3cc46fb335ac27855251 ]

The firmware memory was allocated in ath11k_pci_probe() or
ath11k_ahb_probe(), but not freed in ath11k_xxx_remove() in case
ATH11K_FLAG_QMI_FAIL bit is set. So call ath11k_fw_destroy() to
free the memory.

Found while fixing the same problem in ath12k:
https://lore.kernel.org/linux-wireless/20240314012746.2729101-1-quic_miaoqing@quicinc.com

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Link: https://patch.msgid.link/20250123084948.1124357-1-quic_miaoqing@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c  | 4 +++-
 drivers/net/wireless/ath/ath11k/core.c | 3 +--
 drivers/net/wireless/ath/ath11k/fw.c   | 3 ++-
 drivers/net/wireless/ath/ath11k/pci.c  | 3 ++-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index f2fc04596d481..eedba3766ba24 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -1290,6 +1290,7 @@ static void ath11k_ahb_remove(struct platform_device *pdev)
 	ath11k_core_deinit(ab);
 
 qmi_fail:
+	ath11k_fw_destroy(ab);
 	ath11k_ahb_free_resources(ab);
 }
 
@@ -1309,6 +1310,7 @@ static void ath11k_ahb_shutdown(struct platform_device *pdev)
 	ath11k_core_deinit(ab);
 
 free_resources:
+	ath11k_fw_destroy(ab);
 	ath11k_ahb_free_resources(ab);
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index c576bbba52bf1..85077247b0251 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -2346,7 +2346,6 @@ void ath11k_core_deinit(struct ath11k_base *ab)
 	ath11k_hif_power_down(ab);
 	ath11k_mac_destroy(ab);
 	ath11k_core_soc_destroy(ab);
-	ath11k_fw_destroy(ab);
 }
 EXPORT_SYMBOL(ath11k_core_deinit);
 
diff --git a/drivers/net/wireless/ath/ath11k/fw.c b/drivers/net/wireless/ath/ath11k/fw.c
index 4e36292a79db8..cbbd8e57119f2 100644
--- a/drivers/net/wireless/ath/ath11k/fw.c
+++ b/drivers/net/wireless/ath/ath11k/fw.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
- * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "core.h"
@@ -166,3 +166,4 @@ void ath11k_fw_destroy(struct ath11k_base *ab)
 {
 	release_firmware(ab->fw.fw);
 }
+EXPORT_SYMBOL(ath11k_fw_destroy);
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index b93f04973ad79..f1121e3317194 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -984,6 +984,7 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 	ath11k_core_deinit(ab);
 
 qmi_fail:
+	ath11k_fw_destroy(ab);
 	ath11k_mhi_unregister(ab_pci);
 
 	ath11k_pcic_free_irq(ab);
-- 
2.39.5


