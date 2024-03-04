Return-Path: <stable+bounces-26251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266C8870DBE
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D039B1F24439
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E597BAE6;
	Mon,  4 Mar 2024 21:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JZxEDnWR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE5578B69;
	Mon,  4 Mar 2024 21:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588234; cv=none; b=GzThFpH9/xgmR10X4ggYkR2rNgpGuMWqUeX6GxI3Mc38AjbGSl/46/HhQNL5HceIci1OP5fnppBvTCAZgGyilT0ZxyNcVfid4jJU+qsHhns2ZGiOp4CStSjtnHVakQn5DtUOnhyX1G1bftHpotYN9A9CYLZQN9jIABX7aFKlyWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588234; c=relaxed/simple;
	bh=Xic21hfXbazXFigSmDiIH+pF5kwGtKAKR+0T6AxxwKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3N84iNBSXGW/n6WgB6HUVOO5zC1uPUeVk4+KOtDEbfo/VvFjBy2fbe/NxNDtuU47ZIXs30Y01JYAc6d/KtYT2BX5jt/L8mNwSrWlyD+QW6jAnbDDA7Vjn0wVRdwwGrw5h0U7krpt8DyCQYlQJxVoHAwuRm9HFD/UYxJ2dInhpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JZxEDnWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0F7C43390;
	Mon,  4 Mar 2024 21:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588234;
	bh=Xic21hfXbazXFigSmDiIH+pF5kwGtKAKR+0T6AxxwKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZxEDnWRYKa2i2jVdgy0Sx3XRASbsSSVrh5vabBVzPSNLDKMAuFFMxPoi46ytf04S
	 Epto3K3Qls6XDc2V+LJJVPId1w44qvwGGPD3mbU8nbt1uY/Ty5QLq9VsQR77xcF4/2
	 9xcyurn6qvXYwGaKMDJJWb0ceXieisC6A0TQ9fHQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 030/143] Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT
Date: Mon,  4 Mar 2024 21:22:30 +0000
Message-ID: <20240304211550.904280874@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
References: <20240304211549.876981797@linuxfoundation.org>
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

From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>

[ Upstream commit 7dcd3e014aa7faeeaf4047190b22d8a19a0db696 ]

BT adapter going into UNCONFIGURED state during BT turn ON when
devicetree has no local-bd-address node.

Bluetooth will not work out of the box on such devices, to avoid this
problem, added check to set HCI_QUIRK_USE_BDADDR_PROPERTY based on
local-bd-address node entry.

When this quirk is not set, the public Bluetooth address read by host
from controller though HCI Read BD Address command is
considered as valid.

Fixes: e668eb1e1578 ("Bluetooth: hci_core: Don't stop BT if the BD address missing in dts")
Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index ad940027e4b51..f3fe4deee78da 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -7,6 +7,7 @@
  *
  *  Copyright (C) 2007 Texas Instruments, Inc.
  *  Copyright (c) 2010, 2012, 2018 The Linux Foundation. All rights reserved.
+ *  Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  *
  *  Acknowledgements:
  *  This file is based on hci_ll.c, which was...
@@ -1882,7 +1883,17 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+
+		/* Set BDA quirk bit for reading BDA value from fwnode property
+		 * only if that property exist in DT.
+		 */
+		if (fwnode_property_present(dev_fwnode(hdev->dev.parent), "local-bd-address")) {
+			set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+			bt_dev_info(hdev, "setting quirk bit to read BDA from fwnode later");
+		} else {
+			bt_dev_dbg(hdev, "local-bd-address` is not present in the devicetree so not setting quirk bit for BDA");
+		}
+
 		hci_set_aosp_capable(hdev);
 
 		ret = qca_read_soc_version(hdev, &ver, soc_type);
-- 
2.43.0




