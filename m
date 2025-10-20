Return-Path: <stable+bounces-188237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C8CBF34A3
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 21:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CA5486957
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 19:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA26325394B;
	Mon, 20 Oct 2025 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqzSfBXo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779E9258EF0
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990032; cv=none; b=nSMK7ahWhIPtnU+3LgNuY0SAbueDPEvCDfoa68PhWNBwKyLXPwGFl4Ls9kdAOLZJ0PAJmB+jmTAoxH2eSs1uhHw+vgs5FEb7qTe0vpdgLtiNJBKXL9/hkDXy0EcitgpfxUcVdhgHnzTM6kTIJr9CP3TeIxZoPnIOapfyD119Pfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990032; c=relaxed/simple;
	bh=4nwG4YxSU7kChevmNwb/Hx90Jav2SdAS18wGTDNyvks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0BHS69oDlmZ83XlmKmfN3yh0NkULW/BXKI9PBiuFwYDxA72O+7fiEdKwrFLs5+BedZL6rs2SnRMkHqGEsjpb+vzh3wUC/tnyoW96xHFI8/AcB9OfUv9heQvFHnHBoqBwH9NiPew0IGrY1FD7uF6h+0dSbWgjAdkdgLR2wdOkXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqzSfBXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469B4C116C6;
	Mon, 20 Oct 2025 19:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760990032;
	bh=4nwG4YxSU7kChevmNwb/Hx90Jav2SdAS18wGTDNyvks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lqzSfBXoQVu/GePsxaW5QymW+1WCcblry3+F1O6RRMtuikuu270XWnA8C6FXe3ZzT
	 MUHIfiX7+1dbPyBdmCjFj15frZP0usWrzqnsdzwD04tYGZp4IwMVeT9vlEkx53qT+s
	 dd+yrqFaqGS2VfHS5uWgocRwEJc+PV529e33+qD8RR/wql/BQ5BrtRero/PxbtbpQ7
	 NtBwiYVc3/BcnzXx+vu6VhVLhf/CHYKyF3XrNbuXn9iP0teYGj/MKQw9dWsye2srS/
	 VATsaZnQk2uVKOGk3c4Kv0xwZoAtZUQAX0iPCNMICUiP9huteuDi5s47KAHRRN4vSN
	 zavBndrkTtpiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] ixgbevf: Add support for Intel(R) E610 device
Date: Mon, 20 Oct 2025 15:53:46 -0400
Message-ID: <20251020195348.1882212-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020195348.1882212-1-sashal@kernel.org>
References: <2025102053-upheld-recess-9b2f@gregkh>
 <20251020195348.1882212-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

[ Upstream commit 4c44b450c69b676955c2790dcf467c1f969d80f1 ]

Add support for Intel(R) E610 Series of network devices. The E610
is based on X550 but adds firmware managed link, enhanced security
capabilities and support for updated server manageability

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Stable-dep-of: a7075f501bd3 ("ixgbevf: fix mailbox API compatibility by negotiating supported features")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbevf/defines.h      |  5 ++++-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  6 +++++-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 12 ++++++++++--
 drivers/net/ethernet/intel/ixgbevf/vf.c           | 12 +++++++++++-
 drivers/net/ethernet/intel/ixgbevf/vf.h           |  4 +++-
 5 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/defines.h b/drivers/net/ethernet/intel/ixgbevf/defines.h
index 5f08779c0e4e3..a9bc96f6399dc 100644
--- a/drivers/net/ethernet/intel/ixgbevf/defines.h
+++ b/drivers/net/ethernet/intel/ixgbevf/defines.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 #ifndef _IXGBEVF_DEFINES_H_
 #define _IXGBEVF_DEFINES_H_
@@ -16,6 +16,9 @@
 #define IXGBE_DEV_ID_X550_VF_HV		0x1564
 #define IXGBE_DEV_ID_X550EM_X_VF_HV	0x15A9
 
+#define IXGBE_DEV_ID_E610_VF		0x57AD
+#define IXGBE_SUBDEV_ID_E610_VF_HV	0x00FF
+
 #define IXGBE_VF_IRQ_CLEAR_MASK		7
 #define IXGBE_VF_MAX_TX_QUEUES		8
 #define IXGBE_VF_MAX_RX_QUEUES		8
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 149c733fcc2b3..ca2d61c43b5e9 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 #ifndef _IXGBEVF_H_
 #define _IXGBEVF_H_
@@ -418,6 +418,8 @@ enum ixgbevf_boards {
 	board_X550EM_x_vf,
 	board_X550EM_x_vf_hv,
 	board_x550em_a_vf,
+	board_e610_vf,
+	board_e610_vf_hv,
 };
 
 enum ixgbevf_xcast_modes {
@@ -434,11 +436,13 @@ extern const struct ixgbevf_info ixgbevf_X550EM_x_vf_info;
 extern const struct ixgbe_mbx_operations ixgbevf_mbx_ops;
 extern const struct ixgbe_mbx_operations ixgbevf_mbx_ops_legacy;
 extern const struct ixgbevf_info ixgbevf_x550em_a_vf_info;
+extern const struct ixgbevf_info ixgbevf_e610_vf_info;
 
 extern const struct ixgbevf_info ixgbevf_82599_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X540_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X550_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X550EM_x_vf_hv_info;
+extern const struct ixgbevf_info ixgbevf_e610_vf_hv_info;
 extern const struct ixgbe_mbx_operations ixgbevf_hv_mbx_ops;
 
 /* needed by ethtool.c */
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index e338fa5727933..7d514b872cc60 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 /******************************************************************************
  Copyright (c)2006 - 2007 Myricom, Inc. for some LRO specific code
@@ -39,7 +39,7 @@ static const char ixgbevf_driver_string[] =
 	"Intel(R) 10 Gigabit PCI Express Virtual Function Network Driver";
 
 static char ixgbevf_copyright[] =
-	"Copyright (c) 2009 - 2018 Intel Corporation.";
+	"Copyright (c) 2009 - 2024 Intel Corporation.";
 
 static const struct ixgbevf_info *ixgbevf_info_tbl[] = {
 	[board_82599_vf]	= &ixgbevf_82599_vf_info,
@@ -51,6 +51,8 @@ static const struct ixgbevf_info *ixgbevf_info_tbl[] = {
 	[board_X550EM_x_vf]	= &ixgbevf_X550EM_x_vf_info,
 	[board_X550EM_x_vf_hv]	= &ixgbevf_X550EM_x_vf_hv_info,
 	[board_x550em_a_vf]	= &ixgbevf_x550em_a_vf_info,
+	[board_e610_vf]         = &ixgbevf_e610_vf_info,
+	[board_e610_vf_hv]      = &ixgbevf_e610_vf_hv_info,
 };
 
 /* ixgbevf_pci_tbl - PCI Device ID Table
@@ -71,6 +73,9 @@ static const struct pci_device_id ixgbevf_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_VF), board_X550EM_x_vf },
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_VF_HV), board_X550EM_x_vf_hv},
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_VF), board_x550em_a_vf },
+	{PCI_VDEVICE_SUB(INTEL, IXGBE_DEV_ID_E610_VF, PCI_ANY_ID,
+			 IXGBE_SUBDEV_ID_E610_VF_HV), board_e610_vf_hv},
+	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_E610_VF), board_e610_vf},
 	/* required last entry */
 	{0, }
 };
@@ -4686,6 +4691,9 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	case ixgbe_mac_X540_vf:
 		dev_info(&pdev->dev, "Intel(R) X540 Virtual Function\n");
 		break;
+	case ixgbe_mac_e610_vf:
+		dev_info(&pdev->dev, "Intel(R) E610 Virtual Function\n");
+		break;
 	case ixgbe_mac_82599_vf:
 	default:
 		dev_info(&pdev->dev, "Intel(R) 82599 Virtual Function\n");
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index 1641d00d8ed35..da7a72ecce7a2 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 #include "vf.h"
 #include "ixgbevf.h"
@@ -1076,3 +1076,13 @@ const struct ixgbevf_info ixgbevf_x550em_a_vf_info = {
 	.mac = ixgbe_mac_x550em_a_vf,
 	.mac_ops = &ixgbevf_mac_ops,
 };
+
+const struct ixgbevf_info ixgbevf_e610_vf_info = {
+	.mac                    = ixgbe_mac_e610_vf,
+	.mac_ops                = &ixgbevf_mac_ops,
+};
+
+const struct ixgbevf_info ixgbevf_e610_vf_hv_info = {
+	.mac            = ixgbe_mac_e610_vf,
+	.mac_ops        = &ixgbevf_hv_mac_ops,
+};
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.h b/drivers/net/ethernet/intel/ixgbevf/vf.h
index b4eef5b6c172b..2d791bc26ae4e 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 #ifndef __IXGBE_VF_H__
 #define __IXGBE_VF_H__
@@ -54,6 +54,8 @@ enum ixgbe_mac_type {
 	ixgbe_mac_X550_vf,
 	ixgbe_mac_X550EM_x_vf,
 	ixgbe_mac_x550em_a_vf,
+	ixgbe_mac_e610,
+	ixgbe_mac_e610_vf,
 	ixgbe_num_macs
 };
 
-- 
2.51.0


