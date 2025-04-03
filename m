Return-Path: <stable+bounces-127764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 638E9A7AB25
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11333AD401
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5637025DB17;
	Thu,  3 Apr 2025 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKEiTQ/a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119AC25DB11;
	Thu,  3 Apr 2025 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707039; cv=none; b=LItCN0k96UgcPHnVgWVsN/bBfomFshxaNZx0e6GlSCay4cBAxi0b5EE56afGGogyQXcAQtZVXdHByb+n04+/zpr+uZFAc8IRyEYgs7QJLAw8ybAtE8GGV5iRW3L+rqzkYlHIeZ51rintI6gjm16j3NEjwicsQ/jPkfXqQ1f+voA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707039; c=relaxed/simple;
	bh=hJRTGhledZwajml62iIPZi4kRkaNysKEWAC3ocQfQ04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pyt/GiGGrTxan2+sIsXMBR6yeaSPOIvbVGTEHbPlIjmqdk6p3D15A10TL1+UrIuUVh193y85/xReA7uHp6d/Kxm4Zz+Db/R3zdFMyRJ7UBKKrdpKN07tEP6Ks04Rztb57OupXkVzsp1k+SG16EjHld8zYAZ5+ms1GfddJKTX7mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKEiTQ/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC62C4CEE3;
	Thu,  3 Apr 2025 19:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707038;
	bh=hJRTGhledZwajml62iIPZi4kRkaNysKEWAC3ocQfQ04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aKEiTQ/aNVEJfjkJ2G+NGUPs2heDeC2n4bvJRdk8EFClqcO3d6sCkJOyhK815UPdd
	 ns67vUHmgNA8DNPXZLJl1TVSOnvvtVu4qiU67tZKy437EiVC7AHQLoupbHLRK29lvu
	 LyHZuaKNs+mDft5arrK5V8kiJ+g0sljGJs9YsP7o0Tk1WwaX1N+8NkJsg8ue67C3ZG
	 yTMZVvDFiSyb9c4eZqv8dB9fNyOfJ922vlHEB9eDSCSWomxld51z/3W/tUTLotWNOZ
	 La3F4MA1sgE1l06QVL3h/mwYDSGN4CXZnkmAGdbfg1VOgRKuZwfDR3cyuGmxw+x1bE
	 5tkTlqyCN6rvQ==
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
Subject: [PATCH AUTOSEL 6.14 49/54] Bluetooth: btusb: Add 2 HWIDs for MT7922
Date: Thu,  3 Apr 2025 15:02:04 -0400
Message-Id: <20250403190209.2675485-49-sashal@kernel.org>
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
index 3f151779ad355..6ad74ce4b979e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -668,6 +668,10 @@ static const struct usb_device_id quirks_table[] = {
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


