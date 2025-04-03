Return-Path: <stable+bounces-127861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F42EA7AC9F
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CAC1771DA
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0BB27C16E;
	Thu,  3 Apr 2025 19:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVW8vL7e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768692580F5;
	Thu,  3 Apr 2025 19:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707258; cv=none; b=owkksgImQRCohumVtZVwQO9q+2ypW+A+yu4ldPEv7rIv0+2ReWsdDiVUvp+cNLaZH6Ze86EpFrJiGh8nJyNZWBUBZrXyI/TiOhCwx2pLdDxRmXBEumWAkyXgvLHcB65HWx/TtH1inpe9FHEQdQJ5XQRKJNpj//9k9ykj3qTcjsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707258; c=relaxed/simple;
	bh=TsMNKRZtD/Lt/aSoZyhCzfbpGiFdx00T4FRyJB57hNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iy1IwcJSmbmDmhApYTArYtbkNbW8oKF/s+igPF82GP4gFyFOVOPUAv+sdANzZrfpGBUgsWIs4EQVaRD0NhPthzZdwIJ5k4MxxQrXI7WsNtsPANKJefX6J9G1EuyUlGnbkAWXsqylZRWCfWyfKgPHCU4SSC9Q4bXxGPHdGNcgdtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVW8vL7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B3FC4CEE3;
	Thu,  3 Apr 2025 19:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707258;
	bh=TsMNKRZtD/Lt/aSoZyhCzfbpGiFdx00T4FRyJB57hNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hVW8vL7e1xnObUq227NMjJMkJOUaftRNq5dX0NOSUO8m6XaCQTmHjfsUjW55v9Hkl
	 QrlY213UHrrhqyAG2bX2f4q8YPaBU7bFZiO/DuKeCWezUSCs38x6e8KaBfeHtEOBHB
	 W7wEGdnqiTDI7McNBG9PwMTh1VxzX//AM5VaVF4rqpSoENdmmyDkPJpU90o8NxGyxB
	 jBlPDlbClZcbnTXnlSVykwOXk/gRQpHS5TGyFNQaYtlP3cuUqd6l/v0ZI4xvGmgAGt
	 LS5p9wvM82qg03ohJQPGVMp3nacsu4dlttfShyKQJn1EfyzXsjNMVVHfz+jxejxHZa
	 PX9OJ5mEyk6rA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiande Lu <jiande.lu@mediatek.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-bluetooth@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 43/47] Bluetooth: btusb: Add 2 HWIDs for MT7922
Date: Thu,  3 Apr 2025 15:05:51 -0400
Message-Id: <20250403190555.2677001-43-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Jiande Lu <jiande.lu@mediatek.com>

[ Upstream commit a88643b7e48506777e175e80c902c727ddd90851 ]

Add below HWIDs for MediaTek MT7922 USB Bluetooth chip.
VID 0x0489, PID 0xe152
VID 0x0489, PID 0xe153

Patch has been tested successfully and controller is recognized
device pair successfully.

MT7922 module bring up message as below.
Bluetooth: Core ver 2.22
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20241106163512
Bluetooth: hci0: Device setup in 2284925 usecs
Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
Bluetooth: hci0: AOSP extensions version v1.00
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bluetooth: BNEP socket layer initialized
Bluetooth: MGMT ver 1.22
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM ver 1.11

Signed-off-by: Jiande Lu <jiande.lu@mediatek.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3a0b9dc98707f..151054a718522 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -626,6 +626,10 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe102), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe152), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe153), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04ca, 0x3804), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04ca, 0x38e4), .driver_info = BTUSB_MEDIATEK |
-- 
2.39.5


