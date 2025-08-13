Return-Path: <stable+bounces-169329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E75B2415D
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 08:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3F35839DB
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 06:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8EF2D321F;
	Wed, 13 Aug 2025 06:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="TP3UdkVl"
X-Original-To: stable@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011026.outbound.protection.outlook.com [52.103.67.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955CA2D1F40
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 06:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066103; cv=fail; b=M8QEJqM2MlsjaRHntLZgyWd9CqaNMUqNVAL4DhcgbV7JqZqWozfJqN4LEYQp3fNL6di6Y+IuRvT/TjD340CXAKKI4yXo58h9CNc1DGj6RyC9tyc0eVGDfOCzARS8viKXfCLmxcqDOkGtYjU802maNshhgvxvrt9TT0mSP5254Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066103; c=relaxed/simple;
	bh=lEbkXiKWQGNQaBt4YciTHt5KpNeEEDjQW7x+tEn/fqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FHOe1/x8aS3tkZR+zaKkYpkMY92A0pKRv9OpHQh5ls5JDqVYGQt5eMvB6z6wbqy6G8erx5NKf62BO2PvlFd7QvTYVDDdXOhRWqhbbxHo7tkjD6ss2DPvRm7LC8pvJYixs4CjuNMYTkoZRBw3Br5rbmYDoIORZoZtwP9O3sh6vSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=TP3UdkVl; arc=fail smtp.client-ip=52.103.67.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEXhTsBLoFsoHd7lXDOVsrbImqHu4qaKysHI+BDuiXE6FdupppBbnAHrH4tqWcaONWV2Dr3Tc3jb043+h+6f7IWoaSfarXVNbaYTu8p4A9ZBhW/bEHI4fJu8RdHnymuVKRV2d/PNoZmFJwU8QEoZoiEeJpDTs/mhC8mYMlazMxjlasv6ph1C0HPzNt4hqymjNWC6y0BTTQ9uHhU2PUNUX0M6ZXv/XpPPnS9u3arwE/evP1Kflty+APdr8mMd4RV2AaYZoUeCpz/6VSts2j0y15YYTDEBfd1M9FPq5mPriLnaLrZrgTdSL2IsVDnZy/Z+uPWsY0925GrnUnASPBAwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CaPcSlXeYxXlqL0c4VtZGQ7Fo2uAZ8StLTmK7GJ4EY=;
 b=jyZa6oHtIe3bVgsGaaHYeKbosoggqnY7EQU8drbwV7W/BhH6mEVYRxwwRZNt0PbW2WbDKtSRd65lf7TX9w9aW9QwgRZfrjrwyre5uMhdsCbBN9pgjRjwY8QNl+HVkJit3VcNcPa1TPLaMn6FGc5usg2GfjaHFyBtpPP81prhEHz2OwCShzD9aYK3f6D9DT1PXyQnYrhPE/fEnvWFJF4KQ684mAih5bl0XLHMhxeSstWets9ZYCK7fYxjeY7xjiIQfUYGzc8QhR+KA/LYzKIZdwLKWg4Lv53CrpqCLAwbFg0nQtVEXn1bxd8h07G+IZmAeo5WfcMBatARcvxV4cN/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CaPcSlXeYxXlqL0c4VtZGQ7Fo2uAZ8StLTmK7GJ4EY=;
 b=TP3UdkVlbePmlUaQa4PyvWUpQ1fQe7htbm5EMkbnnhH/yCgVvNGYfaOTy5UZ1GPos8b02rVcB4P2+Y5RUZdKfYsX/7+B8+NnSmEyVwS745+a/r0YQb+RUQm/11dD+qCJh25w/9MdjBq2MKNyBHhvxKFcYCpZHQ7i59+sHmEszDF8CvJ0Sa640WKfcSf7hgdhL2u8NngIIvdDvhmyN4kYY7/o6ZcspV09k9aHxDowSgA8Tj1yAxfJkPAz0m9VpE0zSfCI11SlixjvwBIT890M4AlQ2q55JMyka5wJYFsjShpzGv8nM4FFMxLW7vPNOr4uXrJR69aTbTxVR5CzOFBrZQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB5827.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:7e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 06:21:38 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 06:21:38 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jkosina@suse.com" <jkosina@suse.com>
Subject: [PATCH 6.12.y] HID: magicmouse: avoid setting up battery timer when
 not needed
Thread-Topic: [PATCH 6.12.y] HID: magicmouse: avoid setting up battery timer
 when not needed
Thread-Index: AQHcDBqGSh12vDNjSkyVJr334rGgEg==
Date: Wed, 13 Aug 2025 06:21:37 +0000
Message-ID: <20250813062134.36408-1-gargaditya08@live.com>
References: <2025081244-swimsuit-darkening-ba01@gregkh>
In-Reply-To: <2025081244-swimsuit-darkening-ba01@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB5827:EE_
x-ms-office365-filtering-correlation-id: 2a4a0305-18db-419a-73bc-08ddda31a8ff
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|8062599012|8060799015|19110799012|15080799012|41001999006|31061999003|461199028|3412199025|40105399003|440099028|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Jfw6wSbM0RC3jmgeJBFMjIBUiyWdE70cf19uwzXPPu+kSJdWe5iJjQFf8x?=
 =?iso-8859-1?Q?TYsDiUYUdcoOo+RksRuFI/FXMjfqriJDV5wksiUHN6nQ2Wp6oX2q6/fuF8?=
 =?iso-8859-1?Q?1Lh6z95gQeaEGpr95/tJ1/AUiws9E+R71bOwRIvOZDUygXXxFS6rL3vADt?=
 =?iso-8859-1?Q?xp5+IXwaXGq3x01nsEuzbCed60R6wU7pp2zX63PW0tmrO/QHBkImI5pUoj?=
 =?iso-8859-1?Q?XC7nwSsAS3a3gtLqmd7ru829NG8LDlqoQWn7He0zUPY6wnQi8xjv9Hi52Z?=
 =?iso-8859-1?Q?giPRHvbd3OjuY7E6jVfvO4/YtYL7xyVkZCNZNddQOHyqYMftnT/dD9IMpW?=
 =?iso-8859-1?Q?yY0Ricc8C92/mtkWm8nu6PaJrxfhsg3VzHYVoAac4qIqpUEEGXYqsEiP+t?=
 =?iso-8859-1?Q?5+kJ78EJGzAuQ6Td+GbJzRHSKFCf07C3z4k6efpvcQYxjz2lQyxpiOX6HI?=
 =?iso-8859-1?Q?3lmdsLUCzJDIlFdt/YRz8XxWr6pI/v0R8lGIa5HqTVHwUHe8q/BNT35t71?=
 =?iso-8859-1?Q?6LcQQHLhngvLhH327mYakoFxFAzPrLYX3wnEGahK3SvHlHSdmZ3MEYeOpS?=
 =?iso-8859-1?Q?odJtWk+t4refyoHtquNcyg39VNlGM2m4L+gnfopHTktz2p51vg0eQeag/4?=
 =?iso-8859-1?Q?9W9Plq+f4ozzf7ZXXDc7rPU9Ze4lii7q/nSLHb5DK4yXbDsyyrJP/G8E18?=
 =?iso-8859-1?Q?nkjaalzOHU5fxaLTVFjuj9lND4SZutdUztJUFEaHef7J/LmHVwtLgr4EM0?=
 =?iso-8859-1?Q?3ZwPe6HfmZdnuQrRyFUYKQKVXxUVl8aew0nBGik29swVgrDxFUQFzSdT0E?=
 =?iso-8859-1?Q?vxnFJ3a4BliMw8Pz5R9wU1TNYiusaBuRF39hL6357qB0fbc2Y7y4/Lm56U?=
 =?iso-8859-1?Q?E/F16Piw92crBFnL9HHafMB93IF0/InLMX4lRk8wYuoj8CyXPkbXckx1LD?=
 =?iso-8859-1?Q?IrpB62lzNr59817Oefy+c+Od3m621eanHm8iXYcaHd2CakyUBXPEUDdS0a?=
 =?iso-8859-1?Q?aQ88DJ6cNvx8D+s0JLrFp2zJdjz8puDoLAJHdrQdpeOyTPXbordE59/PFR?=
 =?iso-8859-1?Q?uZwkAjYLZbdU8xALbn0fZaFaKeBbcpw6dQkjM1aBx8LqA4+8hhlKAvuWI2?=
 =?iso-8859-1?Q?58FOS1gZXdL1WHyawtCwXoYmLR3dw2TuXn34LvuHjXECw+b+vfjIeuaL6f?=
 =?iso-8859-1?Q?jpjvdlkOsciaLN03qLv3zr/grD9hBD9SxRN/9a4qGx2YRtHDIlIzeYUKyC?=
 =?iso-8859-1?Q?W1BpIrWJ/JwixFW2CkFA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?R7cha3B+d/sg6oQR/GJMjMPAjJllUULIYuI7S2DvghjYtOQYBCnyeZA/S5?=
 =?iso-8859-1?Q?BrRYwtNVS7bFxASWiNadLbL+wmUOIy0xjwcqVs1Xx2+mJ2+UnevxS/eYXd?=
 =?iso-8859-1?Q?+qD9o0FNUytsR/zP4ACeJ4qV7fCHNky6Fb734WYoD3aBNcIwdi28OcuW6l?=
 =?iso-8859-1?Q?GaxpvF72UvMY0FuHziIqipnoLIvEkWxHKphdovC8Mzdh6Q5LOVyl44VkE9?=
 =?iso-8859-1?Q?ulSv1VQJmQkvhLkfIC6qLPggKGlreXBYffDpeEcX86Lv4oc1imaHRwS7OD?=
 =?iso-8859-1?Q?nmct6vplZRD2KCUbIGWpKzOV3f3l/BcAJhLd/KZbXb/J1DSSyxhNiI2Oxo?=
 =?iso-8859-1?Q?SCTeXR9838bpgrzk+FI3mCedWSVOuM3NZJJkzx9WJ4+MQNOhm6hLT2EzGa?=
 =?iso-8859-1?Q?sV8B/V7fcHBil9C8dBqH1KAGBKnWs73wp6X4IdCSEjYbVR8o4OODUEiGjg?=
 =?iso-8859-1?Q?rsOaSPoyn0hjLw8aR2W7On2YvUaDwvDNtb9LTTBPHCxcvLvbBXSjx5Wjw1?=
 =?iso-8859-1?Q?e3HGz9DjdQXTenEuXl66I0iU7tc+DImn6SXgA95Dzy54Np1Znk0V5dES5X?=
 =?iso-8859-1?Q?TW59MPUMAMm2lUHDhqrzKbj/9mWiissx+npsOsMVyCqnxeZEZKfmg1hvL3?=
 =?iso-8859-1?Q?i/DUFz3F06U2QYTdjQX3gFISqXoN5MQ/NP2VQMgUTGhFexIuyFxspxvXys?=
 =?iso-8859-1?Q?Qck5smCTbvNeOM4MTN7eV1SRBLlHB/7t5MedONbshFdNpO36zeS0uG06lg?=
 =?iso-8859-1?Q?FH/J0ByxCzgz+Ftf3vh3Xqljbm+2iZFP2BkBjn6SCo0y2h/wHqwMF2yz39?=
 =?iso-8859-1?Q?5koicRKh6I4SDryBKXWjJ9RHcqmQWrCh9JouOIbbERk4k+XouRvEverKpu?=
 =?iso-8859-1?Q?SDKdFOd8N3nTKtfZXvXhnGjJ7LWvZ0JkQSAgB4dJ4R9grmmVn+FhLBhVf2?=
 =?iso-8859-1?Q?Pw/QOnWaTJpSI/KWvnGyiC0XEY+EMZSgCHTkc4WK6NLs3jqI8+fZD61s/O?=
 =?iso-8859-1?Q?8M4VplpdudxjZOOtZ//3UaSzOgXFvh3ZfZQeFMdeeKdrw0KMC/MUZRUuL6?=
 =?iso-8859-1?Q?xFJXrLsOzgzQxBMD3QWcTeDzVjrE6bIU0QQkEUoI6QBfrv/spLQoosRW4R?=
 =?iso-8859-1?Q?cl+RxNMOIMWQSyks36qZF5XlbyGRZXL2B9AAQgq3GpYgs2VGdHp7vbsrqg?=
 =?iso-8859-1?Q?40yrsVeYTNAvIDLLWidmxzgfiLh7KqavqYU9fF4OXuVf5IP+cQBeHYhgO/?=
 =?iso-8859-1?Q?y6B8VLqn4DueDjKJf28TLlpBNcPvRIfC3gyACGTgM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4a0305-18db-419a-73bc-08ddda31a8ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 06:21:37.9815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
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
index ec110dea8..542b3e86d 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -775,16 +775,30 @@ static void magicmouse_enable_mt_work(struct work_str=
uct *work)
 		hid_err(msc->hdev, "unable to request touch data (%d)\n", ret);
 }
=20
+static bool is_usb_magicmouse2(__u32 vendor, __u32 product)
+{
+	if (vendor !=3D USB_VENDOR_ID_APPLE)
+		return false;
+	return product =3D=3D USB_DEVICE_ID_APPLE_MAGICMOUSE2;
+}
+
+static bool is_usb_magictrackpad2(__u32 vendor, __u32 product)
+{
+	if (vendor !=3D USB_VENDOR_ID_APPLE)
+		return false;
+	return product =3D=3D USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 ||
+	       product =3D=3D USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC;
+}
+
 static int magicmouse_fetch_battery(struct hid_device *hdev)
 {
 #ifdef CONFIG_HID_BATTERY_STRENGTH
 	struct hid_report_enum *report_enum;
 	struct hid_report *report;
=20
-	if (!hdev->battery || hdev->vendor !=3D USB_VENDOR_ID_APPLE ||
-	    (hdev->product !=3D USB_DEVICE_ID_APPLE_MAGICMOUSE2 &&
-	     hdev->product !=3D USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 &&
-	     hdev->product !=3D USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC))
+	if (!hdev->battery ||
+	    (!is_usb_magicmouse2(hdev->vendor, hdev->product) &&
+	     !is_usb_magictrackpad2(hdev->vendor, hdev->product)))
 		return -1;
=20
 	report_enum =3D &hdev->report_enum[hdev->battery_report_type];
@@ -846,16 +860,17 @@ static int magicmouse_probe(struct hid_device *hdev,
 		return ret;
 	}
=20
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
=20
-	if (id->vendor =3D=3D USB_VENDOR_ID_APPLE &&
-	    (id->product =3D=3D USB_DEVICE_ID_APPLE_MAGICMOUSE2 ||
-	     ((id->product =3D=3D USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 ||
-	       id->product =3D=3D USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC) &&
-	      hdev->type !=3D HID_TYPE_USBMOUSE)))
+	if (is_usb_magicmouse2(id->vendor, id->product) ||
+	    (is_usb_magictrackpad2(id->vendor, id->product) &&
+	     hdev->type !=3D HID_TYPE_USBMOUSE))
 		return 0;
=20
 	if (!msc->input) {
@@ -911,7 +926,10 @@ static int magicmouse_probe(struct hid_device *hdev,
=20
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
@@ -922,7 +940,9 @@ static void magicmouse_remove(struct hid_device *hdev)
=20
 	if (msc) {
 		cancel_delayed_work_sync(&msc->work);
-		del_timer_sync(&msc->battery_timer);
+		if (is_usb_magicmouse2(hdev->vendor, hdev->product) ||
+		    is_usb_magictrackpad2(hdev->vendor, hdev->product))
+			del_timer_sync(&msc->battery_timer);
 	}
=20
 	hid_hw_stop(hdev);
@@ -939,10 +959,8 @@ static const __u8 *magicmouse_report_fixup(struct hid_=
device *hdev, __u8 *rdesc,
 	 *   0x05, 0x01,       // Usage Page (Generic Desktop)        0
 	 *   0x09, 0x02,       // Usage (Mouse)                       2
 	 */
-	if (hdev->vendor =3D=3D USB_VENDOR_ID_APPLE &&
-	    (hdev->product =3D=3D USB_DEVICE_ID_APPLE_MAGICMOUSE2 ||
-	     hdev->product =3D=3D USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 ||
-	     hdev->product =3D=3D USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC) &&
+	if ((is_usb_magicmouse2(hdev->vendor, hdev->product) ||
+	     is_usb_magictrackpad2(hdev->vendor, hdev->product)) &&
 	    *rsize =3D=3D 83 && rdesc[46] =3D=3D 0x84 && rdesc[58] =3D=3D 0x85) {
 		hid_info(hdev,
 			 "fixing up magicmouse battery report descriptor\n");
--=20
2.50.1


