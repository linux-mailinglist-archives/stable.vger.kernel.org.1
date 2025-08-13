Return-Path: <stable+bounces-169330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82292B2415E
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 08:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3346584612
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 06:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2C42D1F61;
	Wed, 13 Aug 2025 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Ph2oCr1s"
X-Original-To: stable@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011039.outbound.protection.outlook.com [52.103.68.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38FB26FA60
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 06:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066140; cv=fail; b=bjnI4kVf5+EG1xk2opkPOrNjOnEIcQE4eh0Xc4x+8vJIV7Eef0ma7yeQ2Hy4qxFzpUEWg+ZUJqXNISHoAWP1oG36UUh21k863lVlXVLKhWnnFYKJ5eGhHkjniAVOp1YtSK5LEUfcm9Ik/XMhHlE7H7pYiQ7RARtbWSR5ROGpeME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066140; c=relaxed/simple;
	bh=/mlunuCod/iG68WE6PBq9orAWmzSeH852mv6N57qAA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rTj+BPxP3GO4iSpGn1ekvf5Hi7o4rWI/RXYgjZRSUVz+BLloYDSM+lNIpTxxovbt33/R8tc8/qW80320jaiqHW+y3npuSUaUkEhb8C1LMLr/R6gi5xn1+t0KoKMLRHWFL2yoYhUWz4YFBC8IyV1qOD03foWWcdeyCOjnoZ+M1Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Ph2oCr1s; arc=fail smtp.client-ip=52.103.68.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujrn9roXzYNAkSGO2HaZi0x6HH8tjbsG4miTCi28TVUHdsg76+BSblTWdIp0qAZfKzIgnAvtlt9ZY8YPFvSPcqW5V6qCPZP4wpIEFjI7EX+C6PkEQy6kcLK6m9/tkHQ0di8fW5cXSboPXCZznI6RQanknfYTlwz/al8jP073n81kqVkcYS6EofU+KEQqvTvI82k8cJbhzcwcmlCmfGvMvyVljLT6419Byb4dIGaEna0K4nXumSRkURwkAx51sAdIPepotDqimE414nJGn7icv5Lf3R5K/FoPGlOt9QckoIJpCOM6Vqve8YyPiwhC8QdOYwSsLfQAo8soLh91BzHwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvKtAb3mEJjGRv3BY/wjYan8rj+6ziR7jfgqkYB28n8=;
 b=ISESDwc7wwkePSsIxi5pOmBmKgEW6uQCXHPTWJXRQtT04PK7ON8YrYiK0MVslcCQgXAEx9fLZ64G3BLsOlwJFNZChcKXqGcA4jMjI9TNSAH5+TMzj66zmjMUj/LX9ggCaREnG7EiK/GKsWOLEtdh6CfCO7kk1GC9++x7dVXTyADAeX4/FiCiFSL1Ip9ILuJHPgQpTWLT/JC12aUc9AQd+CUpoG9n4idsevVbMUspeUB6H6jg38g+Jpi9rD6n1qL6TZBq0uGpuA7iENbreQAXO2u2GEpY6vK/rqckUZyl6KEhlIFiDbLmWgWPyO8FsX+TyWH6X3l8e1/rdVH+iAVFzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvKtAb3mEJjGRv3BY/wjYan8rj+6ziR7jfgqkYB28n8=;
 b=Ph2oCr1sCjzGwdO7QKbzhyTCfmyi3LjhzcBgHu1wkUuVW2UiX21ViQPGoqW88KsrvVur3Q+kPrMCqpMI5kz4lQNhW2zSt4ty6lkBAoL5Xos2HXxnrXbhA+nlHdvs64MsmKMNtNchEBmeEIZQuP/J/zz+1c4i+8USeJHi12ghl03KW9jhH1XWBE0JyqlGrvpiXMAaMv3rJEYcvPzjnAXcf7HuLGf1ZPZROim+Ncuj0pab+rfhJH728+d1YKAr0d88SjuD/1SrdY8uYcXBQ+iiaN9gAo9sJk53QPT1+V0fE1PB3qUcAhzM4L/3F3OyMBS8AL/v41Yb2bl+ud4KePJMkg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB5827.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:7e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 06:22:14 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 06:22:14 +0000
From: Aditya Garg <gargaditya08@live.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jkosina@suse.com
Subject: [PATCH 6.15.y] HID: magicmouse: avoid setting up battery timer when not needed
Date: Wed, 13 Aug 2025 06:22:06 +0000
Message-ID:
 <PN3PR01MB9597AFADCA3CC17912916A15B82AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081244-result-from-825c@gregkh>
References: <2025081244-result-from-825c@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0115.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b3::6) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250813062206.36802-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a329d2a-7031-48de-0421-08ddda31be45
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799015|19110799012|15080799012|41001999006|461199028|3412199025|40105399003|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dbXlkNfZxxgY96qiKgrHBqlIsYOIwewWjV7v4a4vNxwde5lazRXWscRSnyqs?=
 =?us-ascii?Q?adlIeaRHYKVfnUhAXhR+y/xQa4IGS/Th7VpsyBackGRwDUXq0fkkuYOusE5c?=
 =?us-ascii?Q?U1HBvuXN/W2EqvdVAl5zn2Ypmmp9RoWOW+HLIfsxswr3UHI5UIoynKY7n1Gq?=
 =?us-ascii?Q?+yCAjBSKw8Wo23Aq9qxh+jb4nwC8tUK9uGHQXWjAuxHegMCnr/OSkAIIqovO?=
 =?us-ascii?Q?/B/VgLRetTuxc4L3Xyv2Y0vgyWR68824KFd44F4laDUcLEl40JiIqH8XUDxX?=
 =?us-ascii?Q?HY0EzMxuyuLXvj3CahPr6ls3jYbfOZiWY2ku3mjJitEtu72saUErBPH8TA9X?=
 =?us-ascii?Q?5nmcdWFJEHuzEdkqGM0BiUE4xdKacac86d+vLGayoJHABrrLc/dIf0nQMFX0?=
 =?us-ascii?Q?rJAOAep9vPSUZu6xbqNvziGZ2vw57rnHSFU7PtUvZOFeNOb2Q5RfWvbotUP6?=
 =?us-ascii?Q?U8WPJbqv5A20hkTVzuTXGpwUHWW5KrKX0JXYbz0TMXni9cOXyW8PIOq2S3jB?=
 =?us-ascii?Q?I/Wl127bFwQSOtZNYmflFDjxFjHN/oZIGBmrHZVaAsu7O3JKBEDlImLwVxky?=
 =?us-ascii?Q?ZfIfSO+UWPcNxnyxxYmGd9dLXi/UxkEoAuD5L0/uGPAsS2t5+tNrjTp4SQGM?=
 =?us-ascii?Q?4Li6GNVhzjfMojtRUGg7kHFZhMDfrisOYWOpo4Uzj3E6JrfQ6ZESDuxavURv?=
 =?us-ascii?Q?CcFxJO97rMpSF167a33Go6oL28jWjR8JKrraSxMu9zOOvLBufSaPvhj9OH9v?=
 =?us-ascii?Q?CGwliQINoT2dMyzhOi4xRtza/OMasLhY5289NtbpkJne9GGc5/PCtUWwKrar?=
 =?us-ascii?Q?J/WCR+DEocQ1hdb6dBPNwJB81WQ5xwZ2cL2OleGo+XWlwVQC3RYC+BXzsu+B?=
 =?us-ascii?Q?KhIe6MFyfPjy7dITeudhzgkHnLVNbb7TCOS7ukREcskYDA+T1kH94s7EYvE5?=
 =?us-ascii?Q?RQ0zEptcxDEkD/Wgoh1PpJhYe88K9310oVY1aVl/EyEjRAYJoTxciH/NYU3U?=
 =?us-ascii?Q?Q8kkscOJHQ8yLY99HQTWOE05187scaLijPSF5X0oSLj4cOCtibpleUJZZwS3?=
 =?us-ascii?Q?aFd4355a+7uQDDg93ng7Xj3Qz6xH+T8745yc42KzQfk1U3jsC1c24AgZeQPg?=
 =?us-ascii?Q?V7lelREgk4T8A/XKFSlayqBsTjWWsvZLLw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C6a7Xve/lAo9ruvFQ0DNJz0hXjcqEiIvwEukc9h3sFD9Z8IT+XfeFE+ERqdI?=
 =?us-ascii?Q?2+NtCcl4yfssWrzzqixKOoqPyb8W/a+te1HZwlWjahFUWsS/vJ3MzMWKZxaB?=
 =?us-ascii?Q?1TjbgHeSlJ2OX9pmEzP2fyjAWOaup/SglvtrD0jo65Xr0NQOZcVNklcxUNTD?=
 =?us-ascii?Q?tl5wWGfYwFeegpqPF+2Xz1ywmoli75LnPzjv98Ney460sbr5OKHU6av7um/U?=
 =?us-ascii?Q?TKK3dMy8XzqvGhVR6cuFmU1tpD0oCm7D5jOYUWToC6nnnfi01OH9G3nDZ8YS?=
 =?us-ascii?Q?yeWd7t35Hu4k+BCp3QU0SYGDQGX8p/obu/UGNPs9Lu4EKCLhN34y93tK1LnP?=
 =?us-ascii?Q?a8O0mA0skE7o/YteGwSNl6BM/XXxAdRXobndt16bGX8L9+dRzqYVVMmW+uHX?=
 =?us-ascii?Q?9fMVaVJ2L7GkbIGFUFJyatmxOorDrirGoRQrlkOttaSjwAIRF90HTIjv3xGX?=
 =?us-ascii?Q?Lro5KNjCB2nUX1pEYchnI73fCBonuAhNQ/AqMDLpNL0bP4FSprd0AE0J/mnj?=
 =?us-ascii?Q?tfgd+IIONy6uMKpwW0k1/vWFSnZ2wZHC5mcMMTgvPedhSNfW/7JKukvos1Fn?=
 =?us-ascii?Q?GGodqoHoqK0lfQ18ZwfgC/Ef06RfmzXaUjDjhbAzkj+gHhkeDinkTIUVTlT7?=
 =?us-ascii?Q?JwZo/fceAVT0eiGKky6eBqIPba0DyC3q55EmnrCcveVrNYuBaEbxT8FNg88S?=
 =?us-ascii?Q?VwRrXmRD8z4s6Oc9Q/c2H6MSk8LBKbwlYDrDS4qzIGnZe42extuK9bXVqyTY?=
 =?us-ascii?Q?I2/s7w/izxragE0/sXyNhyrVPJMPILehYBFIfGOcgLhMpptnwxxe5pYgmqtD?=
 =?us-ascii?Q?xMyybf0iJMqxM/OM8Cyh/U07ieKSK14VjI8Zw04fgGbAEsAU7vWdTnbY+Ji6?=
 =?us-ascii?Q?ChWadHvSyFqlC1erRyr8JXe4tQ3gBwgzvy0YsxlphFJawo8b2y2FTMe3NANV?=
 =?us-ascii?Q?4/JcGAV88mBv82n/j72q/vrX7I3qvflyH1+L9HSECv940iVarJhnwAisR9lB?=
 =?us-ascii?Q?U7Q0TB+BGvDis6ZjqAIPtmQvmdfQzDhb9JwapO0i/ZSPgy7Oo7rcZcE/2aPg?=
 =?us-ascii?Q?zexoZueGcr1zSzsXdYQhw1EKw4JXHq+p9mCjQwVEMFm5zPePSWy+7b31MU53?=
 =?us-ascii?Q?isfafxv4kXjxViPSUgN3lGTVcOb1Dqci1Qm9wxixLSQFokpc4MPFd+Kxn2Cc?=
 =?us-ascii?Q?nOO7ewD3qz4beAuWt4W/YYoukiwW4aJ6cdGIAUwbTP/dcpGu6nTRR99cZJo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a329d2a-7031-48de-0421-08ddda31be45
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 06:22:13.9469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB5827

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
 drivers/hid/hid-magicmouse.c | 56 ++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index adfa329e9..6d916c6c7 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -779,16 +779,30 @@ static void magicmouse_enable_mt_work(struct work_struct *work)
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
+	return product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 ||
+	       product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC;
+}
+
 static int magicmouse_fetch_battery(struct hid_device *hdev)
 {
 #ifdef CONFIG_HID_BATTERY_STRENGTH
 	struct hid_report_enum *report_enum;
 	struct hid_report *report;
 
-	if (!hdev->battery || hdev->vendor != USB_VENDOR_ID_APPLE ||
-	    (hdev->product != USB_DEVICE_ID_APPLE_MAGICMOUSE2 &&
-	     hdev->product != USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 &&
-	     hdev->product != USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC))
+	if (!hdev->battery ||
+	    (!is_usb_magicmouse2(hdev->vendor, hdev->product) &&
+	     !is_usb_magictrackpad2(hdev->vendor, hdev->product)))
 		return -1;
 
 	report_enum = &hdev->report_enum[hdev->battery_report_type];
@@ -850,16 +864,17 @@ static int magicmouse_probe(struct hid_device *hdev,
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
-	     ((id->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 ||
-	       id->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC) &&
-	      hdev->type != HID_TYPE_USBMOUSE)))
+	if (is_usb_magicmouse2(id->vendor, id->product) ||
+	    (is_usb_magictrackpad2(id->vendor, id->product) &&
+	     hdev->type != HID_TYPE_USBMOUSE))
 		return 0;
 
 	if (!msc->input) {
@@ -915,7 +930,10 @@ static int magicmouse_probe(struct hid_device *hdev,
 
 	return 0;
 err_stop_hw:
-	timer_delete_sync(&msc->battery_timer);
+	if (is_usb_magicmouse2(id->vendor, id->product) ||
+	    is_usb_magictrackpad2(id->vendor, id->product))
+		timer_delete_sync(&msc->battery_timer);
+
 	hid_hw_stop(hdev);
 	return ret;
 }
@@ -926,7 +944,9 @@ static void magicmouse_remove(struct hid_device *hdev)
 
 	if (msc) {
 		cancel_delayed_work_sync(&msc->work);
-		timer_delete_sync(&msc->battery_timer);
+		if (is_usb_magicmouse2(hdev->vendor, hdev->product) ||
+		    is_usb_magictrackpad2(hdev->vendor, hdev->product))
+			timer_delete_sync(&msc->battery_timer);
 	}
 
 	hid_hw_stop(hdev);
@@ -943,10 +963,8 @@ static const __u8 *magicmouse_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	 *   0x05, 0x01,       // Usage Page (Generic Desktop)        0
 	 *   0x09, 0x02,       // Usage (Mouse)                       2
 	 */
-	if (hdev->vendor == USB_VENDOR_ID_APPLE &&
-	    (hdev->product == USB_DEVICE_ID_APPLE_MAGICMOUSE2 ||
-	     hdev->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 ||
-	     hdev->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC) &&
+	if ((is_usb_magicmouse2(hdev->vendor, hdev->product) ||
+	     is_usb_magictrackpad2(hdev->vendor, hdev->product)) &&
 	    *rsize == 83 && rdesc[46] == 0x84 && rdesc[58] == 0x85) {
 		hid_info(hdev,
 			 "fixing up magicmouse battery report descriptor\n");
-- 
2.50.1


