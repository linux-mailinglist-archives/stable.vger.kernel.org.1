Return-Path: <stable+bounces-23798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA4E86873F
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 03:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E919C28FEED
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 02:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2B9FBEA;
	Tue, 27 Feb 2024 02:34:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from v242.mxout.mta1.net (v242.mxout.mta1.net [192.152.126.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E4A171A4
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.152.126.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709001284; cv=none; b=kQn7ZHbobP2UG8XUpdjZt9polw4ZNaEwF/B/yFhkhfxqS8Wwm20dkEvjP3NuVuVlsAPzyFs3XOLCnq3Oq2a5fvsW/OmZqqixE8NW1tZNB0g53QhARQxQvCYk+FWl+hF5FfFDZSg7f3F0Ajz8ta3tclYNwMWu4+Ffc2LhqzkjB/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709001284; c=relaxed/simple;
	bh=ytNlgFG2+Tvr9/Jf5SOctqghWiHa0OoHWSHDV55DReI=;
	h=From:Date:Subject:Message-Id:To:Cc:MIME-Version:Content-Type; b=IgTS2lRTgeYckmL7L8XEd0rNyEQp13sYBZK6/ZVhtPrtmOtBeKzm66G/pUsBtqGscTh0hzFOLBwwoxheFwYEPMX5Ithrl7VNwq1NpwP3WhlVgiCDNmOoiR5cJf67/7T3ZhO75/ughkbAfQVy1xDgb/M6KrZnjaz8s1uophDyq8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=bounces.elasticemail.net; arc=none smtp.client-ip=192.152.126.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounces.elasticemail.net
From: Larry Finger <Larry.Finger@gmail.com>
Date: Tue, 27 Feb 2024 02:34:40 +0000
Subject: [PATCHi V2] wifi: rtw88: Add missing VID/PIDs doe 8811CU and 8821CU
Message-Id: <4ume7mjw63u7.-Rq4VAiqzDkzmpzGkBG2bQ2@1EHFQ.trk.elasticemail.com>
Reply-To: Larry Finger <Larry.Finger@gmail.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
 Nick Morrow <morrownr@gmail.com>, Larry Finger <Larry.Finger@lwfinger.net>,
 Ping-Ke Shih <pkshih@realtek.com>, stable@vger.kernel.org
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-Msg-EID: -Rq4VAiqzDkzmpzGkBG2bQ2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

From: Nick Morrow <morrownr@gmail.com>

Purpose: Add VID/PIDs that are known to be missing for this driver.
- removed  /* 8811CU */ and /* 8821CU */ as they are redundant
since the file is specific to those chips.
- removed /* TOTOLINK A650UA v3 */ as the manufacturer. It has a REALTEK
VID so it may not be specific to this adapter.

Source is https://1EHFQ.trk.elasticemail.com/tracking/click?d=I82H0YR_W_h175Lb3Nkb0D8i6IqvuhESe0WLnY6P7IVwR1UKvB0SPxd1Olp3PNJEjbu3ukccJyYhqnywwqmrXSSm-AHreCC4v4ZEtC_aKuc2U4UnTLkNbVr7X1au67GMmT_sK1WAK_SdXAIcPk6sAYtMDu99C1yMFe01fBEclyLZ0
Verified and tested.

Signed-off-by: Nick Morrow <morrownr@gmail.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Cc: stable@vger.kernel.org
---
 .../net/wireless/realtek/rtw88/rtw8821cu.c    | 40 ++++++++++++-------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
index 7a5cbdc31ef7..e2c7d9f87683 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
@@ -9,24 +9,36 @@
 #include "usb.h"
 
 static const struct usb_device_id rtw_8821cu_id_table[] = {
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xb82b, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x2006, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x8731, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x8811, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xb820, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc821, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xb82b, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc80c, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc811, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc820, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc821, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc82a, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc82b, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc811, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8811CU */
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x8811, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8811CU */
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x2006, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* TOTOLINK A650UA v3 */
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc82c, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x331d, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* D-Link */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xc811, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Edimax */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xd811, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Edimax */
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8821cu_id_table);
-- 
2.43.2


https://1EHFQ.trk.elasticemail.com/tracking/unsubscribe?d=enVLNtTvRHoJzm7zggnK9jTezqe3M_rague2ZYiPq4VmJ22FTzwQbEIe9fX_Hpd5I6N4EXeMlw6Co2pAlC6z4-JwRgLpKvqrLPU3C0r4sJXb0

