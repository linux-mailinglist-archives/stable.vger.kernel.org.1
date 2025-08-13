Return-Path: <stable+bounces-169328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FB0B24153
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 08:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774A63B18DD
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 06:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804822D1932;
	Wed, 13 Aug 2025 06:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="bzos/c1I"
X-Original-To: stable@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011035.outbound.protection.outlook.com [52.103.67.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CEF1DE2D7
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066047; cv=fail; b=OiOH4gofoCXPODnuYR8ig52kXZdZA6NGRPO3JIArT2zgGcVcY0XeA6m3wprbVvoWjUrI+OP2Y9znSl89aQGeVL+ysaHizPaznX2WGkea6CyTsGtnLkty1oZDRNSjO3qqNN/ZKZO5rG36n4VCEzvMdJJ8+L3vCc1Wua9iFBcNSX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066047; c=relaxed/simple;
	bh=S+hsrwbVU5uqB7EIp8rh+fh9edV+skawhUU558ekkkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T3qb7hgScMzFm8LyjpRc2zxqZ62TCCyEkZJjJeehqtB4ySZKYEAP8AxLLLmjpKmP4s55gYRis8CNHQGBbOrTiCZEtMkztUrXqZiSGqZ2wbcQ12fJ/XH/RGbekj24pEXABP6sp7k79eH9E+k6M2oFGeomYj7yQwV6lsMWsjl6wCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=bzos/c1I; arc=fail smtp.client-ip=52.103.67.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVbAKA1u6w/DMIw7oKRf6U7yHlHih47VVH7l5uUdGjPWOLXaKhDa2Ohjosd35FBNvTeEcmP/eMCgZinqAgT5X+XL9HgLWv+EbnlM0NTg+3d7p5X0xSrrzN3UQ1hic6Rfg1bXfsqZWRQjVyakTBJCZI10Dqu+xWu6DyGDDdB6lhRn+ONH1WpvgAAg9Va4FdGroM/TgdcccmipCM/7sXYg+YSx/pz9SOGpC3OzejlMbbhM7IsOGRYfeT1Uz2e6ZzP9ON9eaW2eQVx3ZZ6W8n3V/vlk1JEy+MQQfGwGjNOjavOjjxqN3S2rJwtlnJC8JlJBV2tGPRbkkkLM6zIe1nYvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaQwHKZ1S7G1tniubwuD+ZEVkS1IihHBZQ+IWJ4oaTY=;
 b=JRx9O/GnQta/u2OZpXCa29hVUrPoUX7uuQVqzNWu23ArA++34Cqlw3hIVmR+xwoBN+84utw8uFI1TfLxoIkLSO+KxoiGdipK+OcdxzBDZIfJm3siV2WbISfY5iT79iT/c2cFfgRqx5Ujw3Xc8gGgFko+1y7xYJ98R86oZeThSzd5BOm3FWmAea8iSbtMsKjHii/rc5Hv9Iu2TNlG7qArxEMJMwL8j888PXTjtazCvpMPzdVFuwZCxmo7RFAseuq0Bf12sLsydxf8x71KjAnJbFiREB3dFqBB9NYpoa1PdAGYTpe6W/J+Fqn3X/4EmXkohTQDdagrYtqLMQQJV/2GrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaQwHKZ1S7G1tniubwuD+ZEVkS1IihHBZQ+IWJ4oaTY=;
 b=bzos/c1I87ya2hrdDrGlzxAMuw4k+UTDkQ4/pY3GxzYyUzYSZNg8z9HYwyQj09EUEBGFEqk90HGUd3otEHzF3Q8+E+KSFTCnDgnYnDfwe6mJTivlnbYSvjV2DfWmHNJbX0nwjF8idhtFzyLbA2SGmOo89CIuAzERDGTpIH6UuaiMmUIG6MbACqolQoGLsmvM3WsYzr1zGutFM/F7BAwuEKakiNTBl7MLDeLJ7p/YAixc0hq3nfEbmELmdThnISmqf3XvL+33NNXBawYpJcjw7omuw+DYgYbPjHAqbolun9bYb+TAVEiQQTlqxx/4OljB89S3dNJQAgt53A7D5BnMXA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB5827.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:7e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 06:20:40 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 06:20:40 +0000
From: Aditya Garg <gargaditya08@live.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jkosina@suse.com
Subject: [PATCH 6.6.y] HID: magicmouse: avoid setting up battery timer when not needed
Date: Wed, 13 Aug 2025 06:20:32 +0000
Message-ID:
 <PN3PR01MB959770846CED60E284B50A99B82AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081245-fanatic-plenty-c5ac@gregkh>
References: <2025081245-fanatic-plenty-c5ac@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b4::17) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250813062032.35788-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 22765baf-a78f-4c5c-8ab4-08ddda3186b3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799015|19110799012|15080799012|41001999006|461199028|3412199025|40105399003|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CUexm1MopZyLm9fFlW242ZwyykI8KaOqV733oYRM5Pd0M932vdzUWgsedYaH?=
 =?us-ascii?Q?oQLCgH8Z4rhE5ww5fMpCsYTrP1k75mE7e6UUotdsNEQhnzOs21m41isZAwas?=
 =?us-ascii?Q?5Ctl5j200DBfGNuRV9GpxXIs8FdMNi9HUNctYi4h4wY2ablZtmQWn+HuyVoC?=
 =?us-ascii?Q?w8VlkuRAjPBFceLrWDVhODbVdcwPfs0lKxsosy5V52WLGeybol/fz7IXV7/H?=
 =?us-ascii?Q?FKWwTtfFWO0YJFXj47NMlGeptGjDvhL/7nhwQcSKEUNGpBzxudwyIj1OX/51?=
 =?us-ascii?Q?K9fsIzEfEjaqFa8nLl7I7gru3GmKOm6Ni+y7cGGqOBDa4BqIzYTOgpG4RIWT?=
 =?us-ascii?Q?91+TD6kidxS3vTbOCNiQdCKRf1QEwXuXewKJYIB6t0BWds0KFdRG2NEZeiH+?=
 =?us-ascii?Q?WQbJI68Z8vtoOJrNckGfJtQG6pqMzr0mZyW2rMARZ40nAeurH90rTonw1QP3?=
 =?us-ascii?Q?kYzyFF4W6jJLQ0yte8Oi5zYwehpPMBcdMv1/ncMjaqcZgm9qvtEB8ifXMRP8?=
 =?us-ascii?Q?k2ABQmcKtnOPa7la24nXwzYBhBiLoyoahyDAA8wTTKOBGerxdG/hDp84ifOZ?=
 =?us-ascii?Q?hWbpFyA/mGqyQj1ntnCWk1zfcqf5dsP3NUyoHqvJPmom/uEF0BzOf5nk6jfI?=
 =?us-ascii?Q?hMXRb5polsO2CPmrJuNxhEPmMNJR/UI/7JuahnhxOf3vtb6twPWnoHj24Cw2?=
 =?us-ascii?Q?KAIgZGOGzgCiWHoPntlPLOmn67GhXr819d2Meg7SxYL84vjQyH+Ty0EEGIvF?=
 =?us-ascii?Q?z/ictUpCJYycHq9LCkjZp9JBSG4FPKgLE3k2QYgZvQGO8qniIz0wPj/+Zqdl?=
 =?us-ascii?Q?Q23S6msBR1fow4DeuzrjZKAFKigUAbzcV5Y7uaHF9TQZSi8NkyJpaDa+hzI2?=
 =?us-ascii?Q?3Yb4THZDMOgkpSVaqed/wUHlTbFCTWdMziH91rbied6fIpyVGhGZSYjq+Yy+?=
 =?us-ascii?Q?DmNhLz36UpgQ8Sl63jpctoaq3ACsX4GwFWfGEqmMM/esFyw7OgSNjSSW7zCw?=
 =?us-ascii?Q?fRmiebPM4AUN4SLESJzDCh5incaceWNKCFxJHz5PMoCm87m4/PFPdJjOVOyP?=
 =?us-ascii?Q?rmhXDPgQqhTXA+G/M13RkhC5ust7IMxtilZvCbXs2ob2IQA8hpz+K+Oy6f5u?=
 =?us-ascii?Q?0jQ7PGNDPve0Z1zy86oAaMKBKGXqsTNUhA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VRe0uCbEG6IxpUqYlKTCiUWHTUmRy411zb/ytihEDbkiyS3Vz2l2WT2v0Ewh?=
 =?us-ascii?Q?joSxrP+JEopMDFT3aBoHalEZZTZzf32F0zFWYi2WM+wkHQNLJRp7+M0pKyNj?=
 =?us-ascii?Q?Mt7Prk1U3NWThN5uZIPnFpXzyGYz5pC2n19oNywDVXdgrET38Z3lz6E1edwF?=
 =?us-ascii?Q?wCOYor3cXsIOEUsbCGOtMH969v9RBhN/zjkJ6txmYlNtgLPmCxxvytTeXEVL?=
 =?us-ascii?Q?gBQxJuQ5zybdxMJHXfxNfgnaoQgSxu4K1sBRIdhVHTJSRkNUXCvILUYCIP0b?=
 =?us-ascii?Q?xb9WRt3FqsCAp7r04t0lKTuFlALDwg8MjC+TrIqVBs0PW6UW1XspF1okQOYN?=
 =?us-ascii?Q?XWJ8s3kFjia/iVbQzCFuQ+Q4unK+6WHY7QcD/XmTTF9145+Qlv4pVHanmLzO?=
 =?us-ascii?Q?pEqvgjpaDtB8GY0vFuo+c7mZNZ8LH+atj94mNypHwQf5kyrdce2b8Bt/Jsn9?=
 =?us-ascii?Q?lOL0WzQwCsO2yaRjU692hznap/j/V0qtfC0FmCXMgDeQOucdZoRfpM2houyi?=
 =?us-ascii?Q?GcM9gIF5SsDV9S0yIE/Y9YOw7JQvKUmJWIM0S05mZazcgQyfAZj/CZpcZ144?=
 =?us-ascii?Q?X9kx+wAnlqgboTyzt+qBoU4MEdTSr9Q7mtj0TfFShqP8dzBpSA1sM2QfmPjF?=
 =?us-ascii?Q?8qsDV11B5Y0E9zHTObIo7u8e370AQNtj3B3zcVHwa6FWyhNeBjijNaYM1KUR?=
 =?us-ascii?Q?H90H3HO5zGdS2SHI2D8ybpWEenkd7lGZvrmGpEC0KTWo70AFc5huaMfnLfzi?=
 =?us-ascii?Q?V8OwUILmaunuIMueRUHC8EA8DZJV0SBVEAfrZkDhP8201QVgxnTM6O/HQYx+?=
 =?us-ascii?Q?qiYtD9/fdWg3+1rVJrydFZh3Ma89xcMLwUZVaWcjsR0LVBZj3FNWxHa9+MDR?=
 =?us-ascii?Q?pvIP4tS7Ehbyyds8umiaiTmqDDTKUqPdpmZk76AP5C0/do6/n1LuTJ3xDMu0?=
 =?us-ascii?Q?eiBTKP9xxJcp6Nt7qMKGdzzx3sWRcFSft++IVxNO38VAYB3hybzqvm3VwAvf?=
 =?us-ascii?Q?2MKCnwQpNapxoLn/w2frScmSfA/IxNAswelhLBzbtRhSY0MKFRTJjVYDNLsi?=
 =?us-ascii?Q?u50jBhyFNrpS/k2B95YlllJE1BpfXUm0c0iIwAm+6RmyE5/ZhhILCdwhq71P?=
 =?us-ascii?Q?bXnS0jibgy1HZR7y43cSv0YmI0CdYstAoQ+flVu86aaaBCJVIxi2+5VEyb6b?=
 =?us-ascii?Q?lUuJ3T47tJxzdrj5CQN9TNUuzMnE+i+oGtx8k1MSL2OZZ4twYMKbPaqMwvI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 22765baf-a78f-4c5c-8ab4-08ddda3186b3
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 06:20:40.7044
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
index 9bb8daf7f..4fe1e0bc2 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -772,16 +772,30 @@ static void magicmouse_enable_mt_work(struct work_struct *work)
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
@@ -843,16 +857,17 @@ static int magicmouse_probe(struct hid_device *hdev,
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
@@ -908,7 +923,10 @@ static int magicmouse_probe(struct hid_device *hdev,
 
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
@@ -919,7 +937,9 @@ static void magicmouse_remove(struct hid_device *hdev)
 
 	if (msc) {
 		cancel_delayed_work_sync(&msc->work);
-		del_timer_sync(&msc->battery_timer);
+		if (is_usb_magicmouse2(hdev->vendor, hdev->product) ||
+		    is_usb_magictrackpad2(hdev->vendor, hdev->product))
+			del_timer_sync(&msc->battery_timer);
 	}
 
 	hid_hw_stop(hdev);
@@ -936,10 +956,8 @@ static __u8 *magicmouse_report_fixup(struct hid_device *hdev, __u8 *rdesc,
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


