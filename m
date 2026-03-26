Return-Path: <stable+bounces-230477-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICsBJ21LxWkU8wQAu9opvQ
	(envelope-from <stable+bounces-230477-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:06:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 097B833742B
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAE9830FD8D9
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 14:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C363FE36F;
	Thu, 26 Mar 2026 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="rOP9J8Pu"
X-Original-To: stable@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011025.outbound.protection.outlook.com [52.103.68.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E173FADEF
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536712; cv=fail; b=aZxUzMBZ4iIPZmLaBYc1x4I+NFwPBcQhUV3t1+jOK1Jf4bA2/O8szmVZr33Ff7YlfgbaeKRCy3ZeLJkWu2VxkeCTUZinwButNZA9s1kTB6JSPvG46AR+5/S59WSPQ1gu6ZL+BTXoRVYIwbDi8pusCr1PYfXr9T08e8B77Q8H+zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536712; c=relaxed/simple;
	bh=imp0YjiV9TnY8KH91Wdx7qJveyfMjdQDuvkpHzgzNvg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tQTyfaNEFek7rS6emk+bXw7F70Vr3qVGPrJ10R75cFZmDW0P6nXI9sq21lvobqDFZe79bRprlRgiLpBKcr10HB+XlNEQMeJ8/pP9H4dp8hxcm5sd97oLQtB2P88YF0MDt+ZqDNhpv3I4D6sTPBTQ/8X5BE+lDhJfHqeU6pMUmHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=rOP9J8Pu; arc=fail smtp.client-ip=52.103.68.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owp45QCOfOlFOeEPSYDg3GMsaXIvfXN41hP1TzrovRpvavpeT3z8aLULXbLtnPdmSrtl1gjV2BW5p+S9C78UfMlojbx/Y7/aD9024VDwFl4iP4EY7NUJx7BO6cdexPK3paqTjna758SstCz04CD/jYwLfPLYQW6IndIZUTlcQSY1OmAXeg9A41hiQzNb+oSUGv4IdcpcW7+4g6P7bQ75sXyTgz9p0/d3SBZWxDer1fboRRC6OBqtBnqoOZ9bcXjfupA2hkRdeoWFGWU8s6B1x5Bvg52/Z9a8CRT9xIbMzl6DsR6fGXR6VTKY9eYiKGRR9gaslI56gp/QXnhSNfOzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzfv0sLQYHEOZ2Nm4GVe9OBsOZc49X1UREX7vz9C58E=;
 b=f42bsE6AkL3n3DZ37+zBRXr7fLdPAmBOPSYyl6GEVhnFdk/feoT9Gr2rCqZdop0jNstWVnqEU964p+6spHRxhU9s+HIG2ASQaQi2+A2F/KKng7bL6pC4fbqR/pX6ebZ/C4QBYJZRON8cQu08YzV05nKZvvnltJxhdgbncycqw7XWxn/hZNMuNia+wbyhBX8BczklmZiw9r/El9uT8ZjSbnabu7UzXuEO0KhQpWFIwCO8e4ycO3xqSkF8fxQJetqBa8hm6bSkP8jldsgmNbR4z6AR4utz43rpJVUv1mNNN4r/uuqPIaaUO+UziNOxfD1LUQU8eTuU6K6Jrvskrrydow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzfv0sLQYHEOZ2Nm4GVe9OBsOZc49X1UREX7vz9C58E=;
 b=rOP9J8Pu63eNySfGcSWvMJ4hMQ0L54gooRpLHQhMTdpAtpbctRV1nfQL4XeZq2XSc5ZCSwqPaYeZHseLgOeGxJ4RLLe4qgqabde+uppD+8UcrQXmdGuKdUOK2Q43iPkWdBSyBpHgbV7ineOY5UBAar5VRSffiuhm/DvmCEsxrB+Bwh9waVJEFWkNxII6lLVk0zOFgOv1ZLH4QTAgiO05UruzeI2fLBEsjg1vx/o259hw0/Y9C/c8LtI8UrRFWy3d2vy5riuZgG6tBKyWYs7VqBiWvCpPhQh3MyxXSFkmdv2r9nQHDFQLltpTABZwu3Kwje2X9Dd4kdA73qrvw2Q/Vw==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by PN0PR01MB6462.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:73::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 14:51:47 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 14:51:47 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg KH
	<gregkh@linuxfoundation.org>
CC: Jiri Kosina <jkosina@suse.com>
Subject: [PATCH] HID: appletb-kbd: add .resume method in PM
Thread-Topic: [PATCH] HID: appletb-kbd: add .resume method in PM
Thread-Index: AQHcvTARaIW+BCtVfUOoDarvSyrwnA==
Date: Thu, 26 Mar 2026 14:51:47 +0000
Message-ID: <20260326145134.1371-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAUPR01MB11546:EE_|PN0PR01MB6462:EE_
x-ms-office365-filtering-correlation-id: f3cc7da8-2366-4216-5739-08de8b473473
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8062599012|15080799012|41001999006|8060799015|31061999003|51005399006|25031999004|461199028|38102599003|5062599005|102099032|40105399003|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?BKbQcKa3ByJpQ1XEssj8UHO7sWtZF+2YX97KKOIlQUZe3JXS+z+fhdpTKF?=
 =?iso-8859-1?Q?v83Q8d/Dz/VauE7fjhBlCXgnptzzEwHAoYpcYoFGSnCgXUDV81qZ5DBsrZ?=
 =?iso-8859-1?Q?JXUgfWEpyy32hczbdpii+8TNm+Yam0++hD0o9TY2G//6+6fJOO8zzgTQ+3?=
 =?iso-8859-1?Q?IBRhil+sQZsgeKIaJGpZ5NrCdy9PdpiDCNDvZO7SrYf/h5Tb1htVxDmWl5?=
 =?iso-8859-1?Q?nP8qruVSRrUEYkI09g5MmFSq5Y9HIkmrY/OmjGML9XAzBA2kJ2SdjK6ppv?=
 =?iso-8859-1?Q?OQXOlRRTzugVg6KoJlmQzEYFBIZ498teuhHUVbmyDg3oAbc33930+e9zWY?=
 =?iso-8859-1?Q?S/nfwoIBaHATtwZYdhAsy55XpwuBZYLkkpKHkWxhe3Dy6XRpD6M72TSbuw?=
 =?iso-8859-1?Q?r9YUmw4SBHorcxwRStN2jK2RMBDWT+eBojPbmkbY2Lj7AjBdQp+mmSNz9E?=
 =?iso-8859-1?Q?Q18iiGojXR1hY8S75RIUpaziM9RbzJIssik1ZdytA+79/n9NJ0RwVSZThx?=
 =?iso-8859-1?Q?pW5oSEWlokA1VZeeq/ZpFlef+Kee2nm0bIeSuzbK5AW4hCx2DcbplO0pj0?=
 =?iso-8859-1?Q?Um+LapUarhvDeno1+zsc6/AFEpe/pBZ5mlbp/pH/S6AsnEeA39rmQC4qww?=
 =?iso-8859-1?Q?Z02x/zXwrfbgBGiJcq2mFLpEaYUxg/kHzemHSAh+AiU5MhLdB/lUUf1kdq?=
 =?iso-8859-1?Q?C44MyeoVt60oabyLj9CGEwayj3RxE2q9oTk+jRNZs/DeQF7bNbgtWpJgUR?=
 =?iso-8859-1?Q?epVfMxdnHlPbslXx0bWLcRMo1s87QJhlGN+AmLLkapniAiWedqqKDtC64G?=
 =?iso-8859-1?Q?G2iiqEJgMdSy/idDkAm1m8gtgsWuPl5ns7tAFglZcDigIa29KGPXbI6R3P?=
 =?iso-8859-1?Q?MCmahHpoy0xbLSkVYEu7Jd/GKqHSvxUEM6Bcl2Cp/xXNu6JhGkQGYqjgm/?=
 =?iso-8859-1?Q?TP0lhfbq+e+DX1uxR4UwHFFv4oMMtCsbN7p4zoJPYND3+yC4urCmU3v63z?=
 =?iso-8859-1?Q?1ESLJZFhPikaQ140DXQOY45jgOENo/4MfZg0kYGJJmaIIXN6ah8xWH/zzm?=
 =?iso-8859-1?Q?C3HI6a2Ubgnmg5uHPuOtjQc=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rMlZGFUrhhCn0Ll+hHDeEOpEhlP+CKlEmzLVrgVIiSnepqVaiv7ENiai3s?=
 =?iso-8859-1?Q?Bj0pn1KETNN35t826v5I660W7YhuCpl8DJMCxzj+dGJD7Tx7simOO4ZhlE?=
 =?iso-8859-1?Q?C7c12IeFeJqeE1SEYSvRLX/IOw8gFp0PH6ZULtVj5cwae7Q/zNJCTI9tys?=
 =?iso-8859-1?Q?YHwQKqI69IacD+01CCl2T7075ZCsl0RDnbIQTLL0zPRu+YVN2YHk9e1RoA?=
 =?iso-8859-1?Q?R7DYQu9uvJoZ97g4HPOQ1XNEVGj/fB2ACpeUd1qrt/0DMcKy9VH27e1I+V?=
 =?iso-8859-1?Q?YA67JvqkmbD4X3kZfKpVmXnPt1gdkft7B0XFW5uPn66Dw7V3j7sGkTBUBp?=
 =?iso-8859-1?Q?X5zOswrFGxCF+wtbApdeDxzSATNvuD+yxM1os2dRNaBpGbo+80aLHtMSGF?=
 =?iso-8859-1?Q?fRepR5ITjYsNO6UlGOvl7Nf+bqXP4t9DcUbG3ky59JuZ4AySKD9SHoO5Ly?=
 =?iso-8859-1?Q?43fD7KKZxcod9LkF9KRQUn4G/OsmjW9Imz37IbLuCYUxZ0bpAMCYQwgL1W?=
 =?iso-8859-1?Q?uYy/weImLr98Ig3EFknk0eEX929IGmSgyXlfEv2IonE6v7iuAC2TyR3Z4r?=
 =?iso-8859-1?Q?pQ2jW2G38LXCtRIV+K4BqrZ8hDIRoV9pbuDoN8let1eXqqprnE1UAz/4dS?=
 =?iso-8859-1?Q?xvpf93xHtkmyFaNyxNgvF6cS8txu1fiKrjXQ5a8rGtyLI1e7SOFypqv7WH?=
 =?iso-8859-1?Q?ltuDadmgScf9R/XWjePGzCYDiMC1xggrzOuh0X7Mj4Pp01218zFQXIub85?=
 =?iso-8859-1?Q?+2C4FQgRWCcqHm4dVYu+lgdLfd30jxSdwM+bR74kurOEbz2TZs+2xfv5jV?=
 =?iso-8859-1?Q?QIJk63BynoiaqRjFSRssvamE+Vt45JvgDGaDs7GbD/TsXQXVEyDsD9gyuN?=
 =?iso-8859-1?Q?DVMCas5TC9QHz5wUEh0gOvK9bID/MtdZr1TS6Y72mdhyXNIMEH3XwuJr4U?=
 =?iso-8859-1?Q?VmVCs28fm5+m7NyixbuS+Q6WXFkawnBQ3qcdo+1e4EO6JDrQZf9yQ254A2?=
 =?iso-8859-1?Q?OC1CsBcVGvzFEbtt+TW+6neKWmNmshZxP4ep7VfhQKnHiwsCnBgJKg0eYq?=
 =?iso-8859-1?Q?qQjwNc/I99NX6kyxX1QX0eERuWRxxf522ffz7snXBQzWRCk1ifLTcgIenL?=
 =?iso-8859-1?Q?rR75x/4yRSV6J0TCIyZoOYHMm3FlqxfbVCEhBIU6FlcNhRc9+yl4bitcbb?=
 =?iso-8859-1?Q?42mHXu6h9gz8PcIzIHgRE58uBvSypPhl3MzitTTOJJdLg3gkKpnNnrriOz?=
 =?iso-8859-1?Q?pQMvBmStiUyktRkusK2dtlxJ0J1NqaPpu8PwMSAhUCcJ3LEilUMoDyIYN3?=
 =?iso-8859-1?Q?TqUYJI24LqqKwKg/n8XCBbrp+adDlVC3fHaJCxf0avw1jYbq4xnZx4QcXW?=
 =?iso-8859-1?Q?NEs2yIb1JqBXSJvBaVSkO5DatqU8cC8lO0iEEhX1GdnKWddBHVUHBxQ5V3?=
 =?iso-8859-1?Q?E2YbA+vTrTf/Gz9e?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-63b91.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cc7da8-2366-4216-5739-08de8b473473
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 14:51:47.1801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6462
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[live.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[live.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230477-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[live.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya08@live.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[live.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 097B833742B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 1965445e13c09b79932ca8154977b4408cb9610c upstream.=0A=
=0A=
Upon resuming from suspend, the Touch Bar driver was missing a resume=0A=
method in order to restore the original mode the Touch Bar was on before=0A=
suspending. It is the same as the reset_resume method.=0A=
=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Aditya Garg <gargaditya08@live.com>=0A=
Signed-off-by: Jiri Kosina <jkosina@suse.com>=0A=
---=0A=
 drivers/hid/hid-appletb-kbd.c | 5 +++--=0A=
 1 file changed, 3 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c=
=0A=
index b00687e67..0b10cff46 100644=0A=
--- a/drivers/hid/hid-appletb-kbd.c=0A=
+++ b/drivers/hid/hid-appletb-kbd.c=0A=
@@ -477,7 +477,7 @@ static int appletb_kbd_suspend(struct hid_device *hdev,=
 pm_message_t msg)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-static int appletb_kbd_reset_resume(struct hid_device *hdev)=0A=
+static int appletb_kbd_resume(struct hid_device *hdev)=0A=
 {=0A=
 	struct appletb_kbd *kbd =3D hid_get_drvdata(hdev);=0A=
 =0A=
@@ -503,7 +503,8 @@ static struct hid_driver appletb_kbd_hid_driver =3D {=
=0A=
 	.input_configured =3D appletb_kbd_input_configured,=0A=
 #ifdef CONFIG_PM=0A=
 	.suspend =3D appletb_kbd_suspend,=0A=
-	.reset_resume =3D appletb_kbd_reset_resume,=0A=
+	.resume =3D appletb_kbd_resume,=0A=
+	.reset_resume =3D appletb_kbd_resume,=0A=
 #endif=0A=
 	.driver.dev_groups =3D appletb_kbd_groups,=0A=
 };=0A=
-- =0A=
2.52.0=0A=
=0A=

