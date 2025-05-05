Return-Path: <stable+bounces-139791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAFBAA9FA3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E0E3BAA8D
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E86C2882A9;
	Mon,  5 May 2025 22:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJxdmRYv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4860E2857FB;
	Mon,  5 May 2025 22:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483343; cv=none; b=iTtWuQei04LNj/5AXGj3LPECLsl3jvayGIykqGz/MlVRqW3UERTKfwEHVNX+u6ccqDNpptVvOCtp3FTXOexhZzi10f0/cS8BtHWPXamjDYCB7zYluOSfcFrtwx+4GCupgcpWzy8X981Fv7Xa5fC7+J1XkCGbEVoqePFLVFK7d3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483343; c=relaxed/simple;
	bh=8Cl/GBsCTdLlv+kKPgDPHaXk+owKpFJLtSRPbqZ7ywI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XJtCShORgTS3WW+juO10EAf9dKpa34FodrxAU6Zfx9EDb9tEuH2jJAtFhFdEpH9sdqcov41gavVHM8xO9sdk1VUx5gwaHRJ3qsIwqMMEV+1kjfbs5lvh0Sx6keMTwxVR6pevGtID7indfyMtUVCACBqt9+hSBA9+QhN83bE4tYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJxdmRYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45ECC4CEEF;
	Mon,  5 May 2025 22:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483343;
	bh=8Cl/GBsCTdLlv+kKPgDPHaXk+owKpFJLtSRPbqZ7ywI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XJxdmRYvSaIFAX+wBRFjJih907Z/b0VONKPjcUyNp54+H4L+7lWv2MLsv/qrRwW4g
	 s06RMwBbv6ZV+RT3MNGz3HORFufjnZ5BDbpl0Y/WobCN5OHXaO99rBgHpPThvUZAiH
	 rrzRBHzxUstUskzxRB+agZU/pYUI7N/D+LAUsjLoUhnuk5Op+vb+2DgTM+D8Oqfv3v
	 LAlWvKPCnApKts6CpVPMpkbqOzOznWOFc1P3OlgqrokBmMGFEAb3Xw5x3soaTkZeLX
	 L9HiCvdUcXEaJjc9nYCytGgtuPZZA/atBH9XKPjcOu/1VYWxHlbAUdpTesjArKSKuE
	 nNQ7cnnfmwBuA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hao Qin <hao.qin@mediatek.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-bluetooth@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 044/642] Bluetooth: btmtk: Remove the resetting step before downloading the fw
Date: Mon,  5 May 2025 18:04:20 -0400
Message-Id: <20250505221419.2672473-44-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Hao Qin <hao.qin@mediatek.com>

[ Upstream commit 33634e2ab7c6369391e0ca4b9b97dc861e33d20e ]

Remove the resetting step before downloading the fw, as it may cause
other usb devices to fail to initialise when connected during boot
on kernels 6.11 and newer.

Signed-off-by: Hao Qin <hao.qin@mediatek.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btmtk.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 68846c5bd4f79..4390fd571dbd1 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1330,13 +1330,6 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 		break;
 	case 0x7922:
 	case 0x7925:
-		/* Reset the device to ensure it's in the initial state before
-		 * downloading the firmware to ensure.
-		 */
-
-		if (!test_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags))
-			btmtk_usb_subsys_reset(hdev, dev_id);
-		fallthrough;
 	case 0x7961:
 		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
 				      fw_version, fw_flavor);
@@ -1345,12 +1338,9 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 						btmtk_usb_hci_wmt_sync);
 		if (err < 0) {
 			bt_dev_err(hdev, "Failed to set up firmware (%d)", err);
-			clear_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags);
 			return err;
 		}
 
-		set_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags);
-
 		/* It's Device EndPoint Reset Option Register */
 		err = btmtk_usb_uhw_reg_write(hdev, MTK_EP_RST_OPT,
 					      MTK_EP_RST_IN_OUT_OPT);
-- 
2.39.5


