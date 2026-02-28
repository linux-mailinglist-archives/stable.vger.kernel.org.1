Return-Path: <stable+bounces-220292-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJDBFU40o2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220292-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:30:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4E81C5E17
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B6BA31DCE9E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49D13884B8;
	Sat, 28 Feb 2026 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icfm2Pxx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8033884AE;
	Sat, 28 Feb 2026 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300196; cv=none; b=vEe4N9guw/WRL96DloUJHwJZCG3rsYjTHvUPcnLRTEGC3FCVXymbcmWNMq2btKoB8sWCKLVDmu49aNs5CriwtV5aehMOgrCE9Y6Q4rmQ/KEOWx3X5s4WBwNy8WhrYwUKljS3F/kSbTjPhSDGR4zubcYR8w3klIxOCbPChiPsUkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300196; c=relaxed/simple;
	bh=+3H8IVt5HZVV5uP2/2MSq726bFeBnOx18rf5R01kdFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXbE30End1welI0Ohqn3UJFh8YfTBXiuJFFUs8dqotXYSYlXnryHjcAnG54U9SnvMIbMEf1S7GIdZHFQ1cSaOLbYA3sC9PYTRqZCKTyNyf34ASPbhZSV8QaazxXf/GbXft7XHUpHBQ6tLyCZ73Qxwga1wjWxkFTvWsrJfkTUVu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icfm2Pxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8CEC19423;
	Sat, 28 Feb 2026 17:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300196;
	bh=+3H8IVt5HZVV5uP2/2MSq726bFeBnOx18rf5R01kdFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=icfm2PxxE9EHdXpT0wm0GSjgySdSIUTAgO3F8z/eY7OWAtt2HQG/kATnZg08/lokQ
	 YoCuQyIXmCodMi15dkL/aaaTRSb1i6SYsHTOfIIiHs7vmjTpG1Qe5mYftr5EQugILN
	 Afbfb1F4gOttop3jnGH7nQl/OpkUBypfBT0Y9htlzkIDfNzPIOgxLp5DvbGQnr2WLk
	 dS3E+F80V7I9Fk1dSIr1QGZtbgPE590EGtQq1t10hxirWX6IyFU3t+SLo9MD5LKra1
	 +U6QaDvXcc2Ha2ImoxAm38O0tXhUaxMuLhdIsple32/fB4Cy8lTACtO+FAjntXlGPo
	 t9uPa6efeZQ3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Phillips <david@profile.sh>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 214/844] HID: elecom: Add support for ELECOM HUGE Plus M-HT1MRBK
Date: Sat, 28 Feb 2026 12:22:07 -0500
Message-ID: <20260228173244.1509663-215-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220292-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9B4E81C5E17
X-Rspamd-Action: no action

From: David Phillips <david@profile.sh>

[ Upstream commit b8e5fdf0bd022cd5493a5987ef66f5a24f8352d8 ]

New model in the ELECOM HUGE trackball line that has 8 buttons but the
report descriptor specifies only 5. The HUGE Plus supports connecting via
Bluetooth, 2.4GHz wireless USB dongle, and directly via a USB-C cable.
Each connection type reports a different device id, 01AA for cable,
01AB for USB dongle, and 01AC for Bluetooth.

This patch adds these device IDs and applies the fixups similar to the
other ELECOM devices to get all 8 buttons working for all 3 connection
types.

For reference, the usbhid-dump output:
001:013:001:DESCRIPTOR         1769085639.598405
 05 01 09 02 A1 01 85 01 09 01 A1 00 05 09 19 01
 29 05 15 00 25 01 75 01 95 05 81 02 75 03 95 01
 81 01 05 01 09 30 09 31 16 01 80 26 FF 7F 75 10
 95 02 81 06 09 38 15 81 25 7F 75 08 95 01 81 06
 05 0C 0A 38 02 15 81 25 7F 75 08 95 01 81 06 C0
 C0 05 0C 09 01 A1 01 85 02 15 01 26 8C 02 19 01
 2A 8C 02 75 10 95 01 81 00 C0 05 01 09 80 A1 01
 85 03 09 82 09 81 09 83 15 00 25 01 19 01 29 03
 75 01 95 03 81 02 95 05 81 01 C0 06 01 FF 09 00
 A1 01 85 08 09 00 15 00 26 FF 00 75 08 95 07 81
 02 C0 06 02 FF 09 02 A1 01 85 06 09 02 15 00 26
 FF 00 75 08 95 07 B1 02 C0

Signed-off-by: David Phillips <david@profile.sh>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/Kconfig      |  1 +
 drivers/hid/hid-elecom.c | 16 ++++++++++++++++
 drivers/hid/hid-ids.h    |  3 +++
 drivers/hid/hid-quirks.c |  3 +++
 4 files changed, 23 insertions(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 920a64b66b25b..6ff4a3ad34cbf 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -369,6 +369,7 @@ config HID_ELECOM
 	  - EX-G Trackballs (M-XT3DRBK, M-XT3URBK)
 	  - DEFT Trackballs (M-DT1DRBK, M-DT1URBK, M-DT2DRBK, M-DT2URBK)
 	  - HUGE Trackballs (M-HT1DRBK, M-HT1URBK)
+	  - HUGE Plus Trackball (M-HT1MRBK)
 
 config HID_ELO
 	tristate "ELO USB 4000/4500 touchscreen"
diff --git a/drivers/hid/hid-elecom.c b/drivers/hid/hid-elecom.c
index 2003d2dcda7cc..37d88ce57f671 100644
--- a/drivers/hid/hid-elecom.c
+++ b/drivers/hid/hid-elecom.c
@@ -5,6 +5,7 @@
  *  - EX-G Trackballs (M-XT3DRBK, M-XT3URBK, M-XT4DRBK)
  *  - DEFT Trackballs (M-DT1DRBK, M-DT1URBK, M-DT2DRBK, M-DT2URBK)
  *  - HUGE Trackballs (M-HT1DRBK, M-HT1URBK)
+ *  - HUGE Plus Trackball (M-HT1MRBK)
  *
  *  Copyright (c) 2010 Richard Nauber <Richard.Nauber@gmail.com>
  *  Copyright (c) 2016 Yuxuan Shui <yshuiv7@gmail.com>
@@ -123,12 +124,25 @@ static const __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		 */
 		mouse_button_fixup(hdev, rdesc, *rsize, 22, 30, 24, 16, 8);
 		break;
+	case USB_DEVICE_ID_ELECOM_M_HT1MRBK:
+	case USB_DEVICE_ID_ELECOM_M_HT1MRBK_01AB:
+	case USB_DEVICE_ID_ELECOM_M_HT1MRBK_01AC:
+		/*
+		 * Report descriptor format:
+		 * 24: button bit count
+		 * 28: padding bit count
+		 * 22: button report size
+		 * 16: button usage maximum
+		 */
+		mouse_button_fixup(hdev, rdesc, *rsize, 24, 28, 22, 16, 8);
+		break;
 	}
 	return rdesc;
 }
 
 static const struct hid_device_id elecom_devices[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1MRBK_01AC) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XGL20DLBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3URBK_00FB) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3URBK_018F) },
@@ -142,6 +156,8 @@ static const struct hid_device_id elecom_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1URBK_019B) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1DRBK_010D) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1DRBK_011C) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1MRBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1MRBK_01AB) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, elecom_devices);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 6d8b64872cefe..85ab1ac511096 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -466,6 +466,9 @@
 #define USB_DEVICE_ID_ELECOM_M_HT1URBK_019B	0x019b
 #define USB_DEVICE_ID_ELECOM_M_HT1DRBK_010D	0x010d
 #define USB_DEVICE_ID_ELECOM_M_HT1DRBK_011C	0x011c
+#define USB_DEVICE_ID_ELECOM_M_HT1MRBK	0x01aa
+#define USB_DEVICE_ID_ELECOM_M_HT1MRBK_01AB	0x01ab
+#define USB_DEVICE_ID_ELECOM_M_HT1MRBK_01AC	0x01ac
 
 #define USB_VENDOR_ID_DREAM_CHEEKY	0x1d34
 #define USB_DEVICE_ID_DREAM_CHEEKY_WN	0x0004
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 11438039cdb7f..3217e436c052c 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -420,6 +420,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 #if IS_ENABLED(CONFIG_HID_ELECOM)
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XGL20DLBK) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1MRBK_01AC) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3URBK_00FB) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3URBK_018F) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3DRBK_00FC) },
@@ -432,6 +433,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1URBK_019B) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1DRBK_010D) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1DRBK_011C) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1MRBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1MRBK_01AB) },
 #endif
 #if IS_ENABLED(CONFIG_HID_ELO)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELO, 0x0009) },
-- 
2.51.0


