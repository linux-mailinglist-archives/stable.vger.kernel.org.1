Return-Path: <stable+bounces-127752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E4DA7AA64
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 240807A6E10
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FACF25B686;
	Thu,  3 Apr 2025 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRXJwmpl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4F5253B4B;
	Thu,  3 Apr 2025 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707018; cv=none; b=RimDD5bLaEbaHKoBHHqwrLm9J55hlbAIi42lgrSbUoOBGuexisbDvjysmu8DLplZEHBsGtdc28irwZQzOmnZ9zas6A6/9fdtVcam2spS3ahiR8UIfb2QPXcoUKE+UFoqU5L/CRWE9cDkS4ij1jjzS5OaynvY+A8/xEzdQTuxDmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707018; c=relaxed/simple;
	bh=RzUQhRXe/+OGT7kgCPvHqBz2OlKqXhNnYBz8/RhX7ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c5vpZYk4D/knGT+on0NVlyMJwnqINEP+wm8WGHfYx1m4h65vb6BhqTjAw0ppHHU/C2U4tqmDEs+aLgG6X7fiUeyjFtyTwjtcIHpHbKFnM20yXFFht4NuB6Y/rovp4P7dqz0RDcjnuRPDuedh69aKZRqVWk+iHGb5UHUQh7sfCas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRXJwmpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0651AC4CEEA;
	Thu,  3 Apr 2025 19:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707017;
	bh=RzUQhRXe/+OGT7kgCPvHqBz2OlKqXhNnYBz8/RhX7ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KRXJwmpl60vfacNrXq+RUV48oBHphkt9ZUTFQ+n+FA8Dh5cRgEXAp8hY5lzz2VArh
	 vSIAODL5t5G7Fa4l1ytmZO4baqpyk2pnrq1NezjAxYoLpXkr2f19/ZBKJAI4jqB1S3
	 FOgJ+HIIpUEwO/qByTMwGsRlnV9cMtHlNtP/kJl8VLpzX8E5c8sKNSFLhZGFH4GTYO
	 zeC8m16udAoNtjeHtMtFgcGaZqdrGtJ/YQTS8PiY8HyyqW59zmvhGEAvpxz2TvazvN
	 V/bQotucTCRvlrOHV2ww0mbwtOFaR/F6f3pv8F4rT+4PdcLhodtTUygfnEcd0Iz+Bo
	 MvOwEIiFk0dxg==
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
	sd@queasysnail.net,
	olek2@wp.pl,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 37/54] cdc_ether|r8152: ThinkPad Hybrid USB-C/A Dock quirk
Date: Thu,  3 Apr 2025 15:01:52 -0400
Message-Id: <20250403190209.2675485-37-sashal@kernel.org>
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
index a6469235d904e..a032c1ded4063 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -783,6 +783,13 @@ static const struct usb_device_id	products[] = {
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
index 468c739740463..96fa3857d8e25 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -785,6 +785,7 @@ enum rtl8152_flags {
 #define DEVICE_ID_THINKPAD_USB_C_DONGLE			0x720c
 #define DEVICE_ID_THINKPAD_USB_C_DOCK_GEN2		0xa387
 #define DEVICE_ID_THINKPAD_USB_C_DOCK_GEN3		0x3062
+#define DEVICE_ID_THINKPAD_HYBRID_USB_C_DOCK		0xa359
 
 struct tally_counter {
 	__le64	tx_packets;
@@ -9787,6 +9788,7 @@ static bool rtl8152_supports_lenovo_macpassthru(struct usb_device *udev)
 		case DEVICE_ID_THINKPAD_USB_C_DOCK_GEN2:
 		case DEVICE_ID_THINKPAD_USB_C_DOCK_GEN3:
 		case DEVICE_ID_THINKPAD_USB_C_DONGLE:
+		case DEVICE_ID_THINKPAD_HYBRID_USB_C_DOCK:
 			return 1;
 		}
 	} else if (vendor_id == VENDOR_ID_REALTEK && parent_vendor_id == VENDOR_ID_LENOVO) {
@@ -10064,6 +10066,8 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0927) },
 	{ USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0c5e) },
 	{ USB_DEVICE(VENDOR_ID_SAMSUNG, 0xa101) },
+
+	/* Lenovo */
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x304f) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3054) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3062) },
@@ -10074,7 +10078,9 @@ static const struct usb_device_id rtl8152_table[] = {
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


