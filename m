Return-Path: <stable+bounces-169327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B9DB24151
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 08:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B0F16CC3C
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 06:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3B82D12E2;
	Wed, 13 Aug 2025 06:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="YZMwYUzU"
X-Original-To: stable@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD18B2D0615
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 06:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755065983; cv=fail; b=JJH5lCgnGISZQOiU4qz3hVHsu2BTk3tRf/YA9nA1gI6QuTCaJewMLajhQ8PqZE13uJs9rg03gqSyuZZoCKc9HgkmjrzfmZpQLHS818GoiPziB36rYHnSbhBb4iP45wsboB9RTIQGFED+0E0XEE7BZ664qiIjnhgYYp3L7xv73yU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755065983; c=relaxed/simple;
	bh=FnkZFddiVLkxoWuUCARydM5/wipwG8wv0uXcBniV2Os=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZNPvSQWwL7n3arCtmFYJu+C4MCCrrfYdn1J0lnj+J2VudQLMpp9LcmXXoNEqD/m5rfqB9JhaHiKi5VieZPu7nN5prH/nkD6w3FGeybiZWtvCJ5V7VdhTQ5KLrv6Fbd/IhWe8YTQEP5PIvvD0jWPZvLzg2EURtkw+9I8S/s/D1A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=YZMwYUzU; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1YWztZaLy8i5kQUpvrxy2Hcpczqjev0WUfiUc9scmbaT9ein1AKm9vYaIvNCcXqqClT03IAVLCrlwOu0iCeNo+fTmRkEtcHdtQpWz5YmHjroKDofySN8OrFgXt5yI50ElrwEMVUTT7viJZAb0f3UcnhIt6Z0210vp9GnVMvw1k/FcBaQpETYvEC1E2n2JIiA0d+xnLY0mBmCe56MeNG9cbcL8/bgugjMw25Yki5zRsLgtEF0ceFza95yhDdu8HVphka54MytlFcnF8+cvi/P8lAOtOEK2JRun76XD8HZWql4tgx3RmK9tBpjzJOU8Pij+cC31viRjaRIc3Uivtkww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvMbfbXNa/TFkgfopHNGPmE+zF4xlTKtgwQFs7d9z/0=;
 b=w1DzhzcXs3PKiWUksQ6ma4CF1jxOdW99c3IAwIKhyAkuy9PkKhidQwnoA0bUKqmqVXNu3aUWy6wNupA1GHq+crfFEMeiwhXgdXUG4KNeyHFd9LDnZFti5wEIE2INHDTdII7qpTGKRZo+3/Rkitq5YXoXrgWib+CbPDB04tFkUB3A5/dUiRAhZPSOpzIWqZveAD6ik38HmMORAzCb2pVquaj9F8+i+CISLkingosIFhKwCF4zW7wLYXvVOaKvsS9cZx3cMR4UOqdFOq7OhGrYUA+nvqTsThNfsqsszIcSEwgYn3Kklmx3KeXZaZUsPoJVAZFCVlKgHMpraxIvhlQM+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvMbfbXNa/TFkgfopHNGPmE+zF4xlTKtgwQFs7d9z/0=;
 b=YZMwYUzUlLIqTGU1CntIzKewS5QS71++IzTJRIT6UxR/gQK9mRSmq0KN6jncO21K7PHdKG96m6tDTJwvKpkXFu07eOs3oYh82wcby35oxFBJ0LPHsHRgQLeRlJFL4MRiFhmS4SSPr0dXF52fFM/UInttpkF3qy8pCgJp+J3o5R553K00YVwmko9XnIeEyNu3lydbQcLA1OS/BW8/ZO6ckEIoFuYDkyEPJ9m1uEFdTefL3dl5GCYTTC4eiihLvjBz6hOpu2afe8W2d9ZkI/eifs9kBUNIf8d5jIufGbY45pEPbecrvBGUWx8TyIgaLS4bzmOP+RLNRrL5zEAJ7UGKIA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB8761.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 06:19:37 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 06:19:37 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jkosina@suse.com" <jkosina@suse.com>
Subject: [PATCH 6.1.y] HID: magicmouse: avoid setting up battery timer when
 not needed
Thread-Topic: [PATCH 6.1.y] HID: magicmouse: avoid setting up battery timer
 when not needed
Thread-Index: AQHcDBo+6DncyQCbbUGbp8plC1nI1g==
Date: Wed, 13 Aug 2025 06:19:37 +0000
Message-ID: <20250813061932.35094-1-gargaditya08@live.com>
References: <2025081245-chest-headband-a995@gregkh>
In-Reply-To: <2025081245-chest-headband-a995@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MAZPR01MB8761:EE_
x-ms-office365-filtering-correlation-id: b05bde50-6bf5-408c-9953-08ddda316159
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|31061999003|8022599003|15080799012|461199028|19110799012|8060799015|8062599012|41001999006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?yfs+g/5zRbsBEmzozUe1g0sJRgPdDi/Ap0NPNnqBbcXmD3dkuCW65AcilC?=
 =?iso-8859-1?Q?rNSjlZgvkPCIP09i7FKpPtPK6fJAjM089dCrs2CziOzL0rdow/91K2VJnP?=
 =?iso-8859-1?Q?2c4NL5kiODYT7dpQfPqj4a6FKqyVkhOdw3XjApcr8bb1deRX94WOacm4Vl?=
 =?iso-8859-1?Q?HGutkvwj/WeEDKu8Zadsh9uP8cae1AkfzfSA8afGUYO+V5GD1bMYwIzV+W?=
 =?iso-8859-1?Q?2di4IhYWsq1glkgAfZl/cJgrsq7LVno9P0geScVmX4BsGq58ZQ+ek9bMtc?=
 =?iso-8859-1?Q?Ik8SQEYnlFJ/dSum+xK86QzOkSFTEtJcqxhm2NNg75BhW8oDnP/4MOmSDB?=
 =?iso-8859-1?Q?f64FbhE1CgXMe7T3peYRtUaj0G7S0Yar95BxT9FDrU8o4nhf1RzRh5CsYH?=
 =?iso-8859-1?Q?HtwP3Ow3qOkCy1xXW69kputf0HEFDn/r3QPGCHWjCdrpYhSbuV9Fz6NkOH?=
 =?iso-8859-1?Q?/PECEmBmJLFuRp9r2cPC+6K/xfzp0hI5WhSHO1xjgU39Dg82PCiKj4Fnyi?=
 =?iso-8859-1?Q?h7cbWKLyrx5qJcLAHwJWp8zAkHgeo0RrvfRCc1n05952VEnKPj0qgR+Sy6?=
 =?iso-8859-1?Q?UFA3dBYacQ/lQP8Bh4te9JQmOZoGC7DGdXSFc8YdCFazevwmHslxFjuVfK?=
 =?iso-8859-1?Q?o5/8PekD62y7o7wPBUpBS9ZK31by1qYp4D13SVs05FNzKXJdjQDEB1MBr9?=
 =?iso-8859-1?Q?lMVvv6YpggYqbjHRPbzMvUtmDZCFrOXiW71dPlnmDL8Lk452SXFTOMJF+4?=
 =?iso-8859-1?Q?OtJpsoy0D9STpPpdKhmrZU6aCYmpU4gX4gj+CzQ0F8O5pb4u7j1677VTyv?=
 =?iso-8859-1?Q?g7q8+3MSXnaQtXTdCTOIh6h9/sZWncHz0s61nUyRdC5MX4WShtJBpAtxKL?=
 =?iso-8859-1?Q?nqd02rjU0sYVvmBOAuHPGflUGmAth3AyJtulKP3ZyO6Un2eGvIC0Qnaf1P?=
 =?iso-8859-1?Q?I6t0y1O7raW2FNBpSEcDTNDFfWUdRxn+SsmWr3dSHgxZHRvzdndEnY3Kbw?=
 =?iso-8859-1?Q?5CmV5LzMUliouSFgYrKoBXSZXezvA26jOkJTG2iJyUWFEZgMWFBzpdeiG2?=
 =?iso-8859-1?Q?FV1tXyeWs/TyJmnp3qlLef/zzRYf7SOlYJ8BtMsfQ1DY1L3F6bB8ZAQT0E?=
 =?iso-8859-1?Q?/EW3Z4V7FXOgFvZRKSBE519NoRWIhZitv9eHdUouNZ1umLdh/My1latL2b?=
 =?iso-8859-1?Q?8P1FiZGaaBCnFR2FCiMYQd57StaLP+sl/9gkWkW2GZqO+Ndt347nML7Ada?=
 =?iso-8859-1?Q?TzwLfHk6/d2ipR/SP9MQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NSaqrhoimjLw/o3cwXoBkqgmtkQ6BxjwpRtxjf6tHMJjPdz3fCY6VXnVvB?=
 =?iso-8859-1?Q?88NSqkKD7GIh61wkaVawEwsOr678X2dh+Ds8RqPgYEhekDNUqYiI+8+PKc?=
 =?iso-8859-1?Q?5CGBPEIgaXoBh3Z3jeJi6f9SQHkj7YZsAvHtyU5Pcj76n2LG58twBWLuvl?=
 =?iso-8859-1?Q?qaSqPKX3tLeJ5iTXjkqcReGxM8Ej+afy8gLr8KQd55oeiCbx8HY3854c20?=
 =?iso-8859-1?Q?3EbPfxWiRUWSLaU6uMsudexQKcLLEn3rxKtFEDeouohDxjL70goLbheua2?=
 =?iso-8859-1?Q?tQuFCiQLPBfErFxWIGAQMi86uLtYqKDQAL7DYvyJPK2lSuTuy99gay+VRk?=
 =?iso-8859-1?Q?OB7o1MznbVKW5VHWKh0o+b5oZkTbfRw8cnZBRJBbNX5DlN+V0WcBLXWa4W?=
 =?iso-8859-1?Q?6D5HMX1q4A49bLban1DgRfAQGxKozu8wus4hGuJO0hxZzywFK2l114dth1?=
 =?iso-8859-1?Q?fIhUfGg25k+5b+tBkIbizxOG+S6ZmuxNTmXyIGo1IVbjGZCjS3tg9pl0Jw?=
 =?iso-8859-1?Q?/t5OPy0quyDn32OXFCYw8LMaOr93gBKRmDIRsBCMCEtvEZuOY3HVp1JGuo?=
 =?iso-8859-1?Q?cCZaPW4n9UJDTogRISHb6wc3bVNBGmVqgPzAqe7t9XvdKH+G8nDEtUMV99?=
 =?iso-8859-1?Q?EMlYKkcC74Snzm1uPb/LsQ1D0gwmaKSqb+NQJ8ecpX5waBHe6fOY6Xuhv6?=
 =?iso-8859-1?Q?f7Enk3oEyQK2M1JpB+CwDaoeLIj5ARdikG6VEKx5ylfq0yoeQDoSSwpVDC?=
 =?iso-8859-1?Q?IQYq57C4WX+bHWsCjqHTDW/ZCBCF3RTFdLshlGNwBPjtYw+gufPFBByZ1F?=
 =?iso-8859-1?Q?AeTD67ULGhrjlgnpqjGeQX9Vlu5fBQM6ldKR4P0PD9Vv37HXXt0WXGdDnQ?=
 =?iso-8859-1?Q?mczMARvo7gXM4MiJ6Xyh1wfGZLmuIJ0mEWGd2BGhOHWLzMRUvVzA/+v4jt?=
 =?iso-8859-1?Q?dCdYfuEqp6eU+rFF1tzKoUBhcMdzpvVu6Sgu4hTO1+UlNw0Q5/dZfj4njp?=
 =?iso-8859-1?Q?mBrPdL2fJn7nFIElsZPnQMi7NT0KvDIXqizxhr5Ye41Gs/7kGPeytIixsU?=
 =?iso-8859-1?Q?k+0XejN1h/Jb05epxgvrYgxK77/yeR2sXNg66wxawyYAN2ABtzthQ8NN+Q?=
 =?iso-8859-1?Q?Q4/Ri8NvvI44MrO0/Iu2eDgGLqNLvsL9BeFg50z+YWV+DJbaKG8Kt4VkIX?=
 =?iso-8859-1?Q?YdLap09PxypAwySjSdaX5UeDpzX2Vk/Wh/3szDQAy4iFdkQ0Da2Y/4cwvL?=
 =?iso-8859-1?Q?/1KMFI2g6iHgM/vJkmIvPsNMHcyl3oIQEq7yOywAE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b05bde50-6bf5-408c-9953-08ddda316159
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 06:19:37.7451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
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
 drivers/hid/hid-magicmouse.c | 56 ++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 9bb8daf7f..4fe1e0bc2 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -772,16 +772,30 @@ static void magicmouse_enable_mt_work(struct work_str=
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
@@ -843,16 +857,17 @@ static int magicmouse_probe(struct hid_device *hdev,
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
@@ -908,7 +923,10 @@ static int magicmouse_probe(struct hid_device *hdev,
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
@@ -919,7 +937,9 @@ static void magicmouse_remove(struct hid_device *hdev)
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
@@ -936,10 +956,8 @@ static __u8 *magicmouse_report_fixup(struct hid_device=
 *hdev, __u8 *rdesc,
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


