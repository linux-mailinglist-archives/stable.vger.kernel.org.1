Return-Path: <stable+bounces-169325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D390B24147
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 08:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C071B6142F
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 06:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807512D12F3;
	Wed, 13 Aug 2025 06:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="h20I1/wV"
X-Original-To: stable@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011033.outbound.protection.outlook.com [52.103.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7632C08D9
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 06:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755065862; cv=fail; b=BkWBDbEEzs1R7kc3rdBIhxUNacV06zM3zj7ifUDpm+BHF0LYFOgTNFDCLbhz0oRFnVOcTS4NJalNKmjrao+Yk+cGlil77iIxg5FuHl1IJP3ylcYLagUhHdAqxm2PuoewBR9ZLZrtBW3Zxs1FaTnnPBg5+fMIWaSjMxhilTFoJko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755065862; c=relaxed/simple;
	bh=GHItLfGKOFwxhJ1UaDEVe/c5p0MzkowzNMkVEtUfbJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O9Lag1aTidyOC3p4vwBj5PFWyDw4pkdjrMoMVMNjugWzAEnFVH/aCSXbN7q2r3r3rlo2PAsqjxh1+8vM5+KHQOE8glytcpEMCr2X1+JaXS7bwpR12vNE135lDvkZJtANk69lXI/AYThv30dG4Fkg6+CH4ugFKEpjZMACMUJB+KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=h20I1/wV; arc=fail smtp.client-ip=52.103.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2tUkWGqE49EKPx7Xuyzg76pRcnAzqjY6zLwxKntDIz/FxRJjtBHt3+ex+X/JO7/pEqrNmwY3hW3gQ2r6dy+1oiEmTEIRVXvqatcI0y5UnTo39ceFtuZ0EbSICw7d5y6zGiQqYW5n37D18cI/fxhwTk6J7UuRjPZ81qedNyhCBFSiUnml8tO6L30gL5VYjiTOw4IxjBTWhv0NIk4ZTsgsrXz8kynHnEyTfqOissJI+9WAp38slI8MpF9lpU3UwJrDGXQIyf7PwzbwhS2z3bQ8cnj9ee3dQpW0cEAr8ToC7tiRoVCMPNo7XHoI7czqgBqY6AsPZYQtmR0nZeZFGQgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bqHIvifVHxWbmOMGBESYazAglg0Sr3RkeapMcg6HOo=;
 b=EeV+sA8KTRaS6sqKkFGN6hX7jjmxpXXIkHSZsLaLlcR75DpsaJC4/A2soAhWSJW2aHofPRHXfpeXeVXpbELrtOwXUKRTrdw1LSmm2PN/asuuVDbl5dfyqxdJ7l4xHq+u6moVgajBP5FXpduNdiniS5Pze6zRylwxSLT4VfsKqgEV1VH1/XosvkGQ8TIQsnjVN4IVa24r33ZxCqlF6v8yOLAM81G6oWEKUE6dGmP0UAqRvxEBs7SE6Y5I0mOMj6yXbFy+bk/XTZumfXL6B5RQ4AJt2amSJz/8XoxtsStLVEn049E9BPrR/7kC+6+sG261rw+wIHYwAXrDuurOH6JaYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bqHIvifVHxWbmOMGBESYazAglg0Sr3RkeapMcg6HOo=;
 b=h20I1/wVZcZ6TqZ+8TUHL7rgJLrlDK5I7wE1+WhJGjcbfDb2jUiPIANw7GJl9jqbYayZQuGdBlefdmcXOSpruzsppsp/454yV2MKoSsKUjp0/g61ahEai53cOajDdWaCOlIgvT02qMDgBL2YHbMtbDo/b/DSdxfaMZvflOBOySVfAI2egmawdG/jqrDvSWyW5XyKqehtQECLt8JbmJIrbE6wkyPUbvmSlkASEVr5rbGtEF9SHEEz6VAPqyN6O5Bqo0XWuO+EkUvD0PuxRvuwXoWHNbmU32A42soVdZJiqiypUYLqfqXXkf2EpX8cI8od6k7s4yBFrUd/4dQYt0wZqA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB8761.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 06:17:35 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 06:17:35 +0000
From: Aditya Garg <gargaditya08@live.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jkosina@suse.com
Subject: [PATCH 5.15.y] HID: magicmouse: avoid setting up battery timer when not needed
Date: Wed, 13 Aug 2025 06:17:24 +0000
Message-ID:
 <PN3PR01MB9597AB14B7C8836A3288721AB82AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081246-taco-trimmer-efd3@gregkh>
References: <2025081246-taco-trimmer-efd3@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0091.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b8::11) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250813061724.33806-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: de317b42-f17b-4649-9642-08ddda311818
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|461199028|5072599009|19110799012|8060799015|41001999006|3412199025|40105399003|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0wKXrOxgOXA+DjWIq80usxXvGbwo3cbDLyPYxINpRMIcxPL+XtdQuzVpRgIS?=
 =?us-ascii?Q?ivDa8EBSGzScuH5WLc62j3iL+YIHZ7V/sscfx/GUl0OyPxNy/auOlz6STa7x?=
 =?us-ascii?Q?C6nmlmPqVh7ysLzri5I7l8lpy3NWsBHk/TbxDMxjukmLRaQEj8P/UA0i/IQl?=
 =?us-ascii?Q?Uezo5bOEyinhT0ZPiUd+fmaVJzEaGJBAoyp0tcThvfHz97yzY+KlZ1ubFEuN?=
 =?us-ascii?Q?WgCS8SjMW1t+22+qyv8Lf/MtgX1ZsluJVVW5h7wdDADyUczPIulEUVU5ju8i?=
 =?us-ascii?Q?18a0zQ5wl36l+aYkJ8Y/3dTqiFwqZDk/QW0PfRCRiA20sGVjtE/kDyugldcV?=
 =?us-ascii?Q?xsVIxr/jI+0SS/2z+Rr3+2bI1zVLxlBL3BDQq9IbwxBmXRZGAedLkaTaMpN2?=
 =?us-ascii?Q?Hr9idPx1i6AbK/uGg16mWwJ8scUn36WvSZvQUkl9TEtjsOTCrcmlLM5i6Dux?=
 =?us-ascii?Q?IGJYYUebHNa1Ab03yY42KNqDprjOnpefhlDWGUx753f2Xtak2IE0zX/IjbV2?=
 =?us-ascii?Q?g5Sd6wO1zRt0vtFW4ZZ3QyCrcVIscJOaPolEOUri1QQDutraO+gWVXFsnaj7?=
 =?us-ascii?Q?gSDuLdt0lAhPLpsoTPlrnlY0boMyTX0Y7+r+CNV9HojVsxMCqPd9TTdP77C4?=
 =?us-ascii?Q?Plxoc8UTTyKs99Ir610JgeYs5INPn4ggklzp9XDzSNA1L2jgkgl8D+o/9nNT?=
 =?us-ascii?Q?ImrNfJiEUH0MG2gDB6/8oOefXdkXnOMDRc7OVuZm0lKyIZzOqzIdmQO47CJ7?=
 =?us-ascii?Q?7Zg4DF7/f1ujkivQoYItNFgShiwmZ7J3Rt4dNc4A1WaDR9kE6nzR94+wOFMF?=
 =?us-ascii?Q?/CARfAXqHBRKzlwaId6GigBG2PkLft/h1DD2080dJeAIwHug18IGDH5yWBeq?=
 =?us-ascii?Q?EqUBv/5AYUGxpBCpCgkwWPbGFmIc8cjs179ZtCBpfLqK/wNLOGkglkqGPDkK?=
 =?us-ascii?Q?rJWDP5u2Lk32OXi8rcmvSFu34pJTKnBsC5Al0FJOzfWs70WmD5Wk8DokQN99?=
 =?us-ascii?Q?c/EJKArIR+wJrLNa1CA7/qe2rqvQIgRZt1qeyk4r/KnPV+goWR1CU9dfiCwQ?=
 =?us-ascii?Q?aPSDLJVPTZve5CRMrwxve+qHrgNYuytsl6WrM38arFjdJND/Y0FWbu7VAMPP?=
 =?us-ascii?Q?52nObSYJ1mxLcpK4w5jgLNw5KM32TlLxdg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7IDLOMzJTOx+Sq3WmwoSB0wwN6fsPoMI2bj5mzhdz9bcLm5ybsiXB+YkRIeD?=
 =?us-ascii?Q?wcBxbmLJHZIdUh6qzSViJV/ljvjpmgZEDwDGPA8VfRRk0rlTpvSswgXwVkP2?=
 =?us-ascii?Q?4cPkPmpZoQ1Eue3WIS5D90lL0gQuIO0v1tcu6FN5CHpvFuvt3LaeAPbE3Jpd?=
 =?us-ascii?Q?51quQaqy+SMBqd9AhIOzbi5SIhY464ezPdkETl1hJi1Iu2gQ3v2NpK6gM4+m?=
 =?us-ascii?Q?1er5nnlw85kj/z/u8rikUkoFYN5Hs505AihZQOPkK4+CstpyBW3T58EZkM3a?=
 =?us-ascii?Q?ykkPUFBtGQq/eXhJxfwPiAa3ohwSX1/2clPcX1OpmUzOFL9j9qaIf2yhM/kA?=
 =?us-ascii?Q?NiBRtyW6CFaUY8KVWgYm+MDvnuPmMHKXELNlrU6Ojn0PS8YcUdsNAXjPlzpO?=
 =?us-ascii?Q?K/GYOTYJNu+3o83QcTkjAAFb7hOXYy2eT1aVEwaRQoWDkW9Q2pLW3dN7yZcE?=
 =?us-ascii?Q?R6lS+JXn5Jai9b3kZjW3+TYceqUoC8kH5YW68UMaBDcak5APY4eIgtcXOXOx?=
 =?us-ascii?Q?Wc2mgj4LOmCXj24W+BoeMrCzFspsG6rFEbw1umbsyx5Ll21EOjcRTPSCJns4?=
 =?us-ascii?Q?owgzXTTiBKwVwF6fTfYWkPvtnmO53kJd5RU2wzUO0KjRn3N5AozqfrEm3U6m?=
 =?us-ascii?Q?Iky/OkkquleSTuS57u6kUYE2fF+gk01M8GY48aoIKWHay/GvUDellz0eKMIg?=
 =?us-ascii?Q?A2EwLs5eWI/lYMJevakrPcz+PgYFp6InnoEuJo5FCNVFahmkl5JP5UCBv5v5?=
 =?us-ascii?Q?TH72qrZV1mv9E8lBRnyFQwZNoLfz81UfsWoyINXNQprgrI0KPZFARu1RlZBX?=
 =?us-ascii?Q?Iw5C9AvzpalJ7NzrBxiXPxvx7b9iUc+1LSbcybSHHC+Ng8U5wn3Tr8Bgsunp?=
 =?us-ascii?Q?5ZL2toIbzZqXKWKflCP8g5u3lYdAO6Oh0cB4+B9pTymMXli10v2R+V+LA+K1?=
 =?us-ascii?Q?adJMIWjGhTMNB+JclXDXkOVL0PJsPxT6pQqSxREusYHj6Ag9ofAReJrkhoYb?=
 =?us-ascii?Q?0JlgeeCU+8ZmdQSonPUigckCAi1YvTB3L18InT7Gf+HEAoABq/Mc76xYl85B?=
 =?us-ascii?Q?accOkBZD7VgvaBYTY01fW0ZfwV2m1ij0ki1xPN4ILA+ow2WtDIe8tvy9kcat?=
 =?us-ascii?Q?sk2CKPpAlHxSgq7pGfauX0lHULPz8/KJRqPrmyW4LfsQ8cZCHz99ZJQoTw2C?=
 =?us-ascii?Q?HMec0GFbd9U8547wBFRH8aFhPUQRjWVrKpCgsT7BGhz5Lv7L93HpPc+EPHY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: de317b42-f17b-4649-9642-08ddda311818
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 06:17:35.2565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8761

commit 9bdc30e35cbc1aa78ccf01040354209f1e11ca22 upstream.

Currently, the battery timer is set up for all devices using
hid-magicmouse, irrespective of whether they actually need it or not.

The current implementation requires the battery timer for Magic Mouse 2
and Magic Trackpad 2 when connected via USB only. Add checks to ensure
that the battery timer is only set up when they are connected via USB.

Fixes: 0b91b4e4dae6 ("HID: magicmouse: Report battery level over USB")
Cc: stable@vger.kernel.org
Signed-off-by: Aditya Garg <gargaditya08@live.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/hid-magicmouse.c | 51 +++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index c6b8da716..f1b92fe4c 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -741,15 +741,29 @@ static void magicmouse_enable_mt_work(struct work_struct *work)
 		hid_err(msc->hdev, "unable to request touch data (%d)\n", ret);
 }
 
+static bool is_usb_magicmouse2(__u32 vendor, __u32 product)
+{
+	if (vendor != USB_VENDOR_ID_APPLE)
+		return false;
+	return product == USB_DEVICE_ID_APPLE_MAGICMOUSE2;
+}
+
+static bool is_usb_magictrackpad2(__u32 vendor, __u32 product)
+{
+	if (vendor != USB_VENDOR_ID_APPLE)
+		return false;
+	return product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2;
+}
+
 static int magicmouse_fetch_battery(struct hid_device *hdev)
 {
 #ifdef CONFIG_HID_BATTERY_STRENGTH
 	struct hid_report_enum *report_enum;
 	struct hid_report *report;
 
-	if (!hdev->battery || hdev->vendor != USB_VENDOR_ID_APPLE ||
-	    (hdev->product != USB_DEVICE_ID_APPLE_MAGICMOUSE2 &&
-	     hdev->product != USB_DEVICE_ID_APPLE_MAGICTRACKPAD2))
+	if (!hdev->battery ||
+	    (!is_usb_magicmouse2(hdev->vendor, hdev->product) &&
+	     !is_usb_magictrackpad2(hdev->vendor, hdev->product)))
 		return -1;
 
 	report_enum = &hdev->report_enum[hdev->battery_report_type];
@@ -811,14 +825,17 @@ static int magicmouse_probe(struct hid_device *hdev,
 		return ret;
 	}
 
-	timer_setup(&msc->battery_timer, magicmouse_battery_timer_tick, 0);
-	mod_timer(&msc->battery_timer,
-		  jiffies + msecs_to_jiffies(USB_BATTERY_TIMEOUT_MS));
-	magicmouse_fetch_battery(hdev);
+	if (is_usb_magicmouse2(id->vendor, id->product) ||
+	    is_usb_magictrackpad2(id->vendor, id->product)) {
+		timer_setup(&msc->battery_timer, magicmouse_battery_timer_tick, 0);
+		mod_timer(&msc->battery_timer,
+			  jiffies + msecs_to_jiffies(USB_BATTERY_TIMEOUT_MS));
+		magicmouse_fetch_battery(hdev);
+	}
 
-	if (id->vendor == USB_VENDOR_ID_APPLE &&
-	    (id->product == USB_DEVICE_ID_APPLE_MAGICMOUSE2 ||
-	     (id->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 && hdev->type != HID_TYPE_USBMOUSE)))
+	if (is_usb_magicmouse2(id->vendor, id->product) ||
+	    (is_usb_magictrackpad2(id->vendor, id->product) &&
+	     hdev->type != HID_TYPE_USBMOUSE))
 		return 0;
 
 	if (!msc->input) {
@@ -873,7 +890,10 @@ static int magicmouse_probe(struct hid_device *hdev,
 
 	return 0;
 err_stop_hw:
-	del_timer_sync(&msc->battery_timer);
+	if (is_usb_magicmouse2(id->vendor, id->product) ||
+	    is_usb_magictrackpad2(id->vendor, id->product))
+		del_timer_sync(&msc->battery_timer);
+
 	hid_hw_stop(hdev);
 	return ret;
 }
@@ -884,7 +904,9 @@ static void magicmouse_remove(struct hid_device *hdev)
 
 	if (msc) {
 		cancel_delayed_work_sync(&msc->work);
-		del_timer_sync(&msc->battery_timer);
+		if (is_usb_magicmouse2(hdev->vendor, hdev->product) ||
+		    is_usb_magictrackpad2(hdev->vendor, hdev->product))
+			del_timer_sync(&msc->battery_timer);
 	}
 
 	hid_hw_stop(hdev);
@@ -901,9 +923,8 @@ static __u8 *magicmouse_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	 *   0x05, 0x01,       // Usage Page (Generic Desktop)        0
 	 *   0x09, 0x02,       // Usage (Mouse)                       2
 	 */
-	if (hdev->vendor == USB_VENDOR_ID_APPLE &&
-	    (hdev->product == USB_DEVICE_ID_APPLE_MAGICMOUSE2 ||
-	     hdev->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2) &&
+	if ((is_usb_magicmouse2(hdev->vendor, hdev->product) ||
+	     is_usb_magictrackpad2(hdev->vendor, hdev->product)) &&
 	    *rsize == 83 && rdesc[46] == 0x84 && rdesc[58] == 0x85) {
 		hid_info(hdev,
 			 "fixing up magicmouse battery report descriptor\n");
-- 
2.50.1


