Return-Path: <stable+bounces-146057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F239AC088B
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 11:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9C81B687B7
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 09:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDAC268C55;
	Thu, 22 May 2025 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="MeFKXjiC";
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="H7NRlwt2"
X-Original-To: stable@vger.kernel.org
Received: from mailhub9-fb.kaspersky-labs.com (mailhub9-fb.kaspersky-labs.com [195.122.169.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24A92638BC;
	Thu, 22 May 2025 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.122.169.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747905759; cv=none; b=aYlP/7IkhihbEAJkB4SGHXYkpklNEXsHC4aQSwwM2vBgxKkrN8lSmyezEgpkJYZ/TYf//42f3wehnzCzInQFnlSWX46kBI+UIjJPUHuoTVB//WZPZvxqMCN34KEJ8oy6jMtk+ykph1nbGvov9VZE5+cHkSNDwQanOxfK3A40s3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747905759; c=relaxed/simple;
	bh=qigQEnNqaQWtRiBqtpmRRtl7HMDzo/ebfQTJy3XHors=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oihKjGcBYy5fpGeAgLkch98jeyeXCKaSAeP+vLqx5IYaZSwu1XwS++jwH2fU6+73IY3/Y+0YKEyzqfWo5BCR9X9kDqYny5iLOSnO9Irjha2zPRDMDW2SwSdq5+Eiapmd9CzGpOjw6lqdDOgcnX5lRDs1BCjIb90BZn6uurYu+Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=MeFKXjiC; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=H7NRlwt2; arc=none smtp.client-ip=195.122.169.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202502; t=1747905381;
	bh=xqG5r0/5jevHvz5MUnt00ucOWx3cyvf6DBRXeCPlpz4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=MeFKXjiCaegQfGQuT+JuetKoPMd7t5lP3fd8+bvODAjJY1MzscvaKJzN9VTz/0yjK
	 k6jeIBv2yIsiY4PRuZ9ADgIRZNWztV3cUzAi+ukvuN1rbO80Fu4zxmyLlSjIknOBBF
	 R1Zv8BlHn6IiiI6TiGiaoc2xHVetBgJ0H3a3LL/NAm61mUANqA1XKokpS7UQBiSz3i
	 QJaB3tBSp0tX3LU8LmvkwM5SGQjgnDHikd57yYtnTxabg1ayIGVvWteaC7x4cfMIvE
	 GYfKdw1GJckfAuY44ikl5biA8L6E+yWLDorBHE+Lppuyc/ForHpZ85efyVqOUz/83I
	 ed+b56NZKawPQ==
Received: from mailhub9-fb.kaspersky-labs.com (localhost [127.0.0.1])
	by mailhub9-fb.kaspersky-labs.com (Postfix) with ESMTP id 28D40906584;
	Thu, 22 May 2025 12:16:21 +0300 (MSK)
Received: from mx13.kaspersky-labs.com (mx13.kaspersky-labs.com [91.103.66.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "mx13.kaspersky-labs.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub9-fb.kaspersky-labs.com (Postfix) with ESMTPS id EB21E902838;
	Thu, 22 May 2025 12:16:20 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202502; t=1747905373;
	bh=xqG5r0/5jevHvz5MUnt00ucOWx3cyvf6DBRXeCPlpz4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=H7NRlwt2NbcaSDpNOOrPSUWVritlgUKCeDn0dIsswbR4kC5E/NaaOqdeeVW8Rz/7g
	 cZHdx0zXrTPClkbydACTtgzyTgiL5ugujmEYfbKl/QkZ/TaUYBH1N6vXuIyjbQI0aM
	 6XOnrpiYqzPxGzuHyOk1MdcEC1gstqBXNIMscJVak6P7AkV61y283CvzDxDG9nv6wj
	 PFhEnXuS8yZyTbY36MpefkbIXqHiKifWSDKKpLRiuVhNvA2x1+cYj3Uufh7ZFGNrYL
	 0PHkATdK8p2pc/xRkfEoJldgIyNmJVF7RoFuWN3UgEmlMGpSYTFI2OZ/KtDGc7/vHk
	 gyRhjMBKjMc3A==
Received: from relay13.kaspersky-labs.com (localhost [127.0.0.1])
	by relay13.kaspersky-labs.com (Postfix) with ESMTP id 40E233E1CA6;
	Thu, 22 May 2025 12:16:13 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub13.kaspersky-labs.com (Postfix) with ESMTPS id 95CFB3E1BEF;
	Thu, 22 May 2025 12:16:12 +0300 (MSK)
Received: from moskovkin-pc.avp.ru (10.16.49.191) by HQMAILSRV1.avp.ru
 (10.64.57.51) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 22 May
 2025 12:15:47 +0300
From: Vladimir Moskovkin <Vladimir.Moskovkin@kaspersky.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
CC: Vladimir Moskovkin <Vladimir.Moskovkin@kaspersky.com>, Chanwoo Choi
	<cw00.choi@samsung.com>, =?UTF-8?q?Pawe=C5=82=20Chmiel?=
	<pawel.mikolaj.chmiel@gmail.com>, Jonathan Bakker <xc-racer2@live.ca>, Tomasz
 Figa <tomasz.figa@gmail.com>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <stable@vger.kernel.org>
Subject: [PATCH] extcon: fsa9480: Avoid buffer overflow in fsa9480_handle_change()
Date: Thu, 22 May 2025 12:14:56 +0300
Message-ID: <20250522091456.2402795-1-Vladimir.Moskovkin@kaspersky.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV2.avp.ru (10.64.57.52) To HQMAILSRV1.avp.ru
 (10.64.57.51)
X-KSE-ServerInfo: HQMAILSRV1.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 05/22/2025 08:39:06
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 193520 [May 22 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Vladimir.Moskovkin@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 59 0.3.59
 65f85e645735101144875e459092aa877af15aaa
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;moskovkin-pc.avp.ru:7.1.1,5.0.1;kaspersky.com:7.1.1,5.0.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/22/2025 08:42:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 5/22/2025 8:29:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/05/22 05:45:00 #27780458
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

Bit 7 of the 'Device Type 2' (0Bh) register is reserved in the FSA9480
device, but is used by the FSA880 and TSU6111 devices.

From FSA9480 datasheet, Table 18. Device Type 2:

Reset Value: x0000000
===========================================================================
 Bit # |     Name     | Size (Bits) |             Description
---------------------------------------------------------------------------
   7   |   Reserved   |      1      | NA

From FSA880 datasheet, Table 13. Device Type 2:

Reset Value: 0xxx0000
===========================================================================
 Bit # |     Name     | Size (Bits) |             Description
---------------------------------------------------------------------------
   7   | Unknown      |      1      | 1: Any accessory detected as unknown
       | Accessory    |             |    or an accessory that cannot be
       |              |             |    detected as being valid even
       |              |             |    though ID_CON is not floating
       |              |             | 0: Unknown accessory not detected

From TSU6111 datasheet, Device Type 2:

Reset Value:x0000000
===========================================================================
 Bit # |     Name     | Size (Bits) |             Description
---------------------------------------------------------------------------
   7   | Audio Type 3 |      1      | Audio device type 3

So the value obtained from the FSA9480_REG_DEV_T2 register in the
fsa9480_detect_dev() function may have the 7th bit set.
In this case, the 'dev' parameter in the fsa9480_handle_change() function
will be 15. And this will cause the 'cable_types' array to overflow when
accessed at this index.

Extend the 'cable_types' array with a new value 'DEV_RESERVED' as
specified in the FSA9480 datasheet. Do not use it as it serves for
various purposes in the listed devices.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: bad5b5e707a5 ("extcon: Add fsa9480 extcon driver")
Cc: stable@vger.kernel.org
Signed-off-by: Vladimir Moskovkin <Vladimir.Moskovkin@kaspersky.com>
---
 drivers/extcon/extcon-fsa9480.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-fsa9480.c b/drivers/extcon/extcon-fsa9480.c
index b11b43171063..30972a7214f7 100644
--- a/drivers/extcon/extcon-fsa9480.c
+++ b/drivers/extcon/extcon-fsa9480.c
@@ -68,6 +68,7 @@
 #define DEV_T1_CHARGER_MASK     (DEV_DEDICATED_CHG | DEV_USB_CHG)
 
 /* Device Type 2 */
+#define DEV_RESERVED            15
 #define DEV_AV                  14
 #define DEV_TTY                 13
 #define DEV_PPD                 12
@@ -133,6 +134,7 @@ static const u64 cable_types[] = {
 	[DEV_USB] = BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_CHG_USB_SDP),
 	[DEV_AUDIO_2] = BIT_ULL(EXTCON_JACK_LINE_OUT),
 	[DEV_AUDIO_1] = BIT_ULL(EXTCON_JACK_LINE_OUT),
+	[DEV_RESERVED] = 0,
 	[DEV_AV] = BIT_ULL(EXTCON_JACK_LINE_OUT)
 		   | BIT_ULL(EXTCON_JACK_VIDEO_OUT),
 	[DEV_TTY] = BIT_ULL(EXTCON_JIG),
@@ -228,7 +230,7 @@ static void fsa9480_detect_dev(struct fsa9480_usbsw *usbsw)
 		dev_err(usbsw->dev, "%s: failed to read registers", __func__);
 		return;
 	}
-	val = val2 << 8 | val1;
+	val = val2 << 8 | (val1 & 0xFF);
 
 	dev_info(usbsw->dev, "dev1: 0x%x, dev2: 0x%x\n", val1, val2);
 
-- 
2.25.1


