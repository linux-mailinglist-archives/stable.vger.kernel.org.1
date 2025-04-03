Return-Path: <stable+bounces-127885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE32A7ACB3
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E18C7A2E88
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153C42836B4;
	Thu,  3 Apr 2025 19:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGVhSG2z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBDA259C82;
	Thu,  3 Apr 2025 19:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707312; cv=none; b=NAJoyjrKXaP/cNIeSin5DsYvnqgYXezEsncEUzj5YKc9HzpM9epe6ziN54ut41QJ9lSsCGab+DydImgXVDFPsqhTxiqkMOfyNn/62ZtxekDG43EO9xLPPM0sq61zITpDMk9dpOKQMdWJ5dP2GzxE4L0gpzGyJg2pDeA9yudqkKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707312; c=relaxed/simple;
	bh=j4J4BeUGJ2aw/+jH4WtM/iU9xUymAcPJ4xF5NewUOTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qDdOeaFrxy+djDvJcjnkmS/cn6Wf4d2CbCELFiej8SdTk1T4rFTo38MrvXQL5+6/8yZNx9g3XFqV36ng4xsUKdxDGYt6O+BJ6OfP9Ws4myCQ5BMqqywBdHEyyHAelEvYCXC80yW82XsNKgFUUZd9X1cpOv69/KHK54kKbJY8dNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGVhSG2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF41C4CEE3;
	Thu,  3 Apr 2025 19:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707312;
	bh=j4J4BeUGJ2aw/+jH4WtM/iU9xUymAcPJ4xF5NewUOTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cGVhSG2z9nbJRMmozfmWaL/1Bjmk4tIxtP2/pBJHRUTZSklZZ+fRy/7Dqt0LPvH2E
	 wAMrcKjU/RC81iu4E0pFH0QrYTWsdcFf53RtH8cDYC8ROxFSkoxiT2tYX7Yry937cI
	 t4iho7oDyglFXri+Vv1X8s5gay9AbAZS3Nwr1W2A6Dm7FySDOVQdCiUyEyzsDIEShh
	 TuM8f0mb6a9Yhjv8X9tLYNvO+xMU+VZU3/XfsDZsCSy+Gi3eI3ZbzWAhk4GAuOuCo1
	 SluxqcN+PrLT3DT809d/yHXV+b5bg0loiwvY2cwlpqxENEcsmd+Q6ds3j1D0jhEwIR
	 wD8nopnqOcgHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philipp Hahn <phahn-oss@avm.de>,
	Leon Schuermann <leon@is.currently.online>,
	Jakub Kicinski <kuba@kernel.org>,
	Oliver Neukum <oliver@neukum.org>,
	netdev@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	hayeswang@realtek.com,
	dianders@chromium.org,
	horms@kernel.org,
	ste3ls@gmail.com,
	olek2@wp.pl,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 20/26] cdc_ether|r8152: ThinkPad Hybrid USB-C/A Dock quirk
Date: Thu,  3 Apr 2025 15:07:39 -0400
Message-Id: <20250403190745.2677620-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190745.2677620-1-sashal@kernel.org>
References: <20250403190745.2677620-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
Content-Transfer-Encoding: 8bit

From: Philipp Hahn <phahn-oss@avm.de>

[ Upstream commit a07f23ad9baf716cbf7746e452c92960536ceae6 ]

Lenovo ThinkPad Hybrid USB-C with USB-A Dock (17ef:a359) is affected by
the same problem as the Lenovo Powered USB-C Travel Hub (17ef:721e):
Both are based on the Realtek RTL8153B chip used to use the cdc_ether
driver. However, using this driver, with the system suspended the device
constantly sends pause-frames as soon as the receive buffer fills up.
This causes issues with other devices, where some Ethernet switches stop
forwarding packets altogether.

Using the Realtek driver (r8152) fixes this issue. Pause frames are no
longer sent while the host system is suspended.

Cc: Leon Schuermann <leon@is.currently.online>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Oliver Neukum <oliver@neukum.org> (maintainer:USB CDC ETHERNET DRIVER)
Cc: netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
Link: https://git.kernel.org/netdev/net/c/cb82a54904a9
Link: https://git.kernel.org/netdev/net/c/2284bbd0cf39
Link: https://www.lenovo.com/de/de/p/accessories-and-software/docking/docking-usb-docks/40af0135eu
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Link: https://patch.msgid.link/484336aad52d14ccf061b535bc19ef6396ef5120.1741601523.git.p.hahn@avm.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/cdc_ether.c | 7 +++++++
 drivers/net/usb/r8152.c     | 6 ++++++
 drivers/net/usb/r8153_ecm.c | 6 ++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index 6d61052353f07..a04f758b3ba07 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -782,6 +782,13 @@ static const struct usb_device_id	products[] = {
 	.driver_info = 0,
 },
 
+/* Lenovo ThinkPad Hybrid USB-C with USB-A Dock (40af0135eu, based on Realtek RTL8153) */
+{
+	USB_DEVICE_AND_INTERFACE_INFO(LENOVO_VENDOR_ID, 0xa359, USB_CLASS_COMM,
+			USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE),
+	.driver_info = 0,
+},
+
 /* Aquantia AQtion USB to 5GbE Controller (based on AQC111U) */
 {
 	USB_DEVICE_AND_INTERFACE_INFO(AQUANTIA_VENDOR_ID, 0xc101,
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 3e5998555f981..bbcefcc7ef8f0 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -784,6 +784,7 @@ enum rtl8152_flags {
 #define DEVICE_ID_THINKPAD_USB_C_DONGLE			0x720c
 #define DEVICE_ID_THINKPAD_USB_C_DOCK_GEN2		0xa387
 #define DEVICE_ID_THINKPAD_USB_C_DOCK_GEN3		0x3062
+#define DEVICE_ID_THINKPAD_HYBRID_USB_C_DOCK		0xa359
 
 struct tally_counter {
 	__le64	tx_packets;
@@ -9734,6 +9735,7 @@ static bool rtl8152_supports_lenovo_macpassthru(struct usb_device *udev)
 		case DEVICE_ID_THINKPAD_USB_C_DOCK_GEN2:
 		case DEVICE_ID_THINKPAD_USB_C_DOCK_GEN3:
 		case DEVICE_ID_THINKPAD_USB_C_DONGLE:
+		case DEVICE_ID_THINKPAD_HYBRID_USB_C_DOCK:
 			return 1;
 		}
 	} else if (vendor_id == VENDOR_ID_REALTEK && parent_vendor_id == VENDOR_ID_LENOVO) {
@@ -10011,6 +10013,8 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0927) },
 	{ USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0c5e) },
 	{ USB_DEVICE(VENDOR_ID_SAMSUNG, 0xa101) },
+
+	/* Lenovo */
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x304f) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3054) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3062) },
@@ -10021,7 +10025,9 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x720c) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x7214) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x721e) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0xa359) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0xa387) },
+
 	{ USB_DEVICE(VENDOR_ID_LINKSYS, 0x0041) },
 	{ USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff) },
 	{ USB_DEVICE(VENDOR_ID_TPLINK,  0x0601) },
diff --git a/drivers/net/usb/r8153_ecm.c b/drivers/net/usb/r8153_ecm.c
index 20b2df8d74ae1..8d860dacdf49b 100644
--- a/drivers/net/usb/r8153_ecm.c
+++ b/drivers/net/usb/r8153_ecm.c
@@ -135,6 +135,12 @@ static const struct usb_device_id products[] = {
 				      USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE),
 	.driver_info = (unsigned long)&r8153_info,
 },
+/* Lenovo ThinkPad Hybrid USB-C with USB-A Dock (40af0135eu, based on Realtek RTL8153) */
+{
+	USB_DEVICE_AND_INTERFACE_INFO(VENDOR_ID_LENOVO, 0xa359, USB_CLASS_COMM,
+				      USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE),
+	.driver_info = (unsigned long)&r8153_info,
+},
 
 	{ },		/* END */
 };
-- 
2.39.5


