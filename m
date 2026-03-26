Return-Path: <stable+bounces-230482-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBXkOQpLxWkU8wQAu9opvQ
	(envelope-from <stable+bounces-230482-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:04:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1873373E7
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 814B5309D091
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 14:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CD23FE34A;
	Thu, 26 Mar 2026 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="QEAv2JwJ"
X-Original-To: stable@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010001.outbound.protection.outlook.com [52.103.67.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D615372B37
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537115; cv=fail; b=hOrDImbgv0TMFpwvkSTedO0r4xqnkAxr1r4TLfJhmXTvCErEH+tFydQInPJz82gkgLDVa1UuqgbpxKYBcRDWz+E6PK7de2P+NqgPhgkfY4GlzypaorqLxGOsFZIQL/WmVwUz3IlQ++C4q8KPIhxHshgzRdfFHV5ZFFea9qG3mqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537115; c=relaxed/simple;
	bh=Uves+0RPnrWuExLWb/n3/DXzXAs/Jtec/xm2yokQ66Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qy/Q85mM/+mXR9fRh3wCzhxd+ar0XpgW/iel08+P3Y/e1FPGsZW73ndNgWF/JIrI4Kdll0RF6j7rqZdJor7gV31CW/4AxZ5VIusVVNhOECRW4rQhmGKcHlpxlbSXdQAyJ0QSqF6xN3Lrj7eqOQ+0VSLoAe4sSIgYBJqvVh/4nWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=QEAv2JwJ; arc=fail smtp.client-ip=52.103.67.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=auyfXtX7nBZlfOVj3BNrm7jAQHh3Mb4TJEmnf4iD23etQsplG7zJUpxhE/AFdtd6VlkS0yFpIVXwZWZw/66jNyuMwJFjO4AMSzvd4NUQqUrwWkSzWN/rdBbS3I3JdFEyAO9EUHM6/nrK8+4ztSOeCoJm+8PKUbXqtHyWONrgoKV0Atkm/y7NhTV+QKs/wdY2XPU8C+X6EgKe/qyqj1wIcKDgRI1bw9vJMnUvySCNqFDbtBSgmedeJgOwwv6FjhHikZIMFVXVD/QlkqVHj8GxViomTAKhrPQoLx7KNIl5OBi8z0tFVPZtJ2iC5hxNtkUUXytrHdP+bdkk0Vq+bDq7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uves+0RPnrWuExLWb/n3/DXzXAs/Jtec/xm2yokQ66Q=;
 b=ldqZHQy4q709XiQgr32SyRRapH2kueM2tq5GwB9U7g/+DrRzmCqbMrqiilTubiIs+i/1s16yTAj6XLxZuBQaDSei4V4p9SpBET9su+frjPaFg9MW8vL1DVZKyuJ8Ysm5jRBihdfVJ3zOtaQXOZqguPo/VrnqTzi36GX0DlB6VkqehvYUXtn3nkf2EcqivyFsEltJHOYK4bdJLlp/6SuWj9M63eE4H/3U+7yXDbFZsrHJr0ZH1Azd5n9zi82ziNn6n/iguAL2BwRS2KmN3TCISNubUY2X1phu2b1yjq3+9igDbFYmoFxJq+H9byFAzJtv60PVFPdUo1cdX6R/tIQo6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uves+0RPnrWuExLWb/n3/DXzXAs/Jtec/xm2yokQ66Q=;
 b=QEAv2JwJ8wdP0VMFh9Jhr8D5T0Job7nVI6gucyl+ccWomJ0wOkQ9llh4HPZJMW2JsDQs5VTKjKWEG2XO/gArJZIleSiA+o58Av9Iach6LZC/rNYdpYWdANaBWCPR1f727i6fUNJEfVUbYncQ5jUm2mtslQluDrPD1QH0NqGSm/a/omOZ5H8ZQY3i0EH0+OaZkMmdVhvy9Xis36sNpgXhyVWalCJo41WpdTyT7Ai0fULPBVxdinwBPGRUklaElkJiBS38UmrZkLbs87R550F2/HzYmQ2DMH1fBHIGjHHtwDR0cZgfaathwqq+iq9Z8L9rC/qj0yn2XfyARmgEuTYujA==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by MA1PPF11B50E721.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a04::307) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 14:58:27 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 14:58:27 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "jkosina@suse.com" <jkosina@suse.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] HID: appletb-kbd: add .resume method in
 PM" failed to apply to 6.12-stable tree
Thread-Topic: FAILED: patch "[PATCH] HID: appletb-kbd: add .resume method in
 PM" failed to apply to 6.12-stable tree
Thread-Index: AQHcuEZFMnHMxcnPH0iDBnLXjcuWYw==
Date: Thu, 26 Mar 2026 14:58:27 +0000
Message-ID: <ED30566E-5A5C-4212-821D-E38F00E3A24A@live.com>
References: <2026032053-reviver-stock-9da2@gregkh>
 <MAUPR01MB1154696DABA7DD9EE0D6E99D3B84CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
 <2026032039-rosy-playmate-f405@gregkh>
 <MAUPR01MB11546A98F8C38646ECEC2FD77B84CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
 <2026032013-eggbeater-glamour-d06b@gregkh>
 <MAUPR01MB11546D3BF5B8AE4715111B467B84CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
 <2026032008-sulk-glaucoma-d5c1@gregkh>
In-Reply-To: <2026032008-sulk-glaucoma-d5c1@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAUPR01MB11546:EE_|MA1PPF11B50E721:EE_
x-ms-office365-filtering-correlation-id: 6a624633-70e0-4f31-68f5-08de8b482306
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|25031999004|8062599012|15080799012|8060799015|19110799012|8022599003|6072599003|31061999003|10035399007|440099028|4302099013|3412199025|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?utf-8?B?MExMOGVIdmdSdDNHSnZQeGZ4SzBZUktZd054QUJtWVZ0bEtlZGxkbmp4azJp?=
 =?utf-8?B?RXE0U1ZyMzNyQjFOZlB2cStmMlRMWHhHaU4wNGYzcjBNZW1ZZ1NLcUg3cmM0?=
 =?utf-8?B?NThZSkRUanNLb1gvamV1aDYxZ1Zkamp2RUYyOE5YQnFLTzNId0Ywdno5U0xL?=
 =?utf-8?B?VGR0ME5KdTFxaUN5MlBGOFE4MllLNjc4RlhJZnliYjdjTndlQTBJRWM0QjJT?=
 =?utf-8?B?NTlNNi9SbkxSVTY1VUZSM0xyQjN4MVZYWU1YL3pQTWVvY3FFZnZ4OE5vUmx5?=
 =?utf-8?B?L3FSZ0g1K3BFKzhzTW5UZlFrY3F2VTBDN2pWaUVyTUFNVCtqUldnOERtSGY5?=
 =?utf-8?B?NWpZbm1aWUZFamxKTjRSUFNpVUdaaFV6TzlDMklOVDhNdXdDWnQvd0tmT0lZ?=
 =?utf-8?B?bUV5SVh0V3piTEpaQTdhVk1QWEhqSHhmS1ZwdGZQL3FCZmVFcnUvV3hCeTVU?=
 =?utf-8?B?SVcyQnlpV3UyYTJEdzlBakhLSjlHOUhQbHpaOGF1VnZBOUp1YXRyYjZQaG02?=
 =?utf-8?B?VG5Rc2RjYzM1eWpGeDhZckxzTHJ0a0xvOEVJN3ZlS3dWUVpVNU14NGpzUGpl?=
 =?utf-8?B?RXRVc011TU1aWFd5MDFGSUpIbjFkQ2Q4TGRnNW9qUkVidlpHa2dCcTNmMXlN?=
 =?utf-8?B?blZKSjQ2QVNCUm5uU1MrUHNyR1Y5a1NkM3AyWVJLWXFjK0paU2ZUbWZuWGF6?=
 =?utf-8?B?dnVWeHhMUURORnVCQWZmc0xPZ1dvWHVkL1ZHQzJLTTQ1T3hLdkRwMXlONTc0?=
 =?utf-8?B?SXhmSVdlTGo3NTI0aVcreTdveEJXcnkrbWNaQlNRQWd0WFF1Uy9tYzhWSzRN?=
 =?utf-8?B?NFoyWWxiTUxaQWl3VHJCVDBySGoxbW01a2FIcHhyN0NxZUlEcGZjRkFmVG1u?=
 =?utf-8?B?VHRxc1JIVUJrOVdwUjBKK2Uxamc1amNIN2RTSGp5N0Fyc1MrSytqSG1GS0hG?=
 =?utf-8?B?MEdLUHJwSzNCMEg3bkFGc0ZpWlF0aTJCSW9zNW1HNm1pUCtURnlZckN1R2Jr?=
 =?utf-8?B?TzFIM0prSDdaaDZUbzFPNWZUellvT1p4cEgyOEp5SDhXT0d2Qk96cElwK3Ri?=
 =?utf-8?B?ZHVaRFE4Wmw2SWl6bjRaV3RDc1U4bVFyWUI1M0Z6cTYrSTdRaFM1Yy80QWx1?=
 =?utf-8?B?cXUzak11aFlxQS9FKzFPb3c3RkhCS0dpRTl5SjFlWXNOWW5iTVB6c1UybTJF?=
 =?utf-8?B?aCtVQTBoeGZsNWdjaFhZbDZZeldYZU5sYzNSYnF6TFZiMVJKeUVNbHVOcTZy?=
 =?utf-8?B?NnN6SVdqU2twZHc5QVFydzhrZGVWQVlYQmUxb1BwNWRjS1Y1Y21BSXpiUndU?=
 =?utf-8?B?VGo4M3V0ZkExZk9OdTMyRUNGSWpMVHJRSFNqdWh3d25oS0FxdmdCZnRkZ1hE?=
 =?utf-8?B?b1NvdHlXTUtXdHBGWHJyYUFJUFNWRXU1cVliQjZhVHlYYVJNUExnYzdyNkdz?=
 =?utf-8?Q?ZFZOdfvR?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmg5KzdrVjBDTzVMcEZ2QUV2dFo0NEZUWmdGa1BzNG5BSkM2UkFNeXZycmh4?=
 =?utf-8?B?cUxXQnljY3pQRStha0NxZkxrVHhCSUJiOUozWGtrdDM3N0N3ZWxia2cxTEQ2?=
 =?utf-8?B?V3dnYmhVUWZ0UGJ5OXN2Wmhnc2c2Z0FXY2xRTXFlem1MWUw1eXhVZ0FNcURM?=
 =?utf-8?B?WjNxWHRKYXY3ZGxDdjVIVURiNTNxcHNSRlRmbGU5c3lVR1EzYlVFNEIxOUho?=
 =?utf-8?B?K01POXl4amRlTElFWlRlUGM3R2tZQVNLcFp5a0hTaVo0eEhVSHQxYzU0VTF3?=
 =?utf-8?B?bi9tMkUzZjlUY1NVQTdPY2QyckFPQm1RSW96VzczSjBxRVhESCttbCtVQ2hM?=
 =?utf-8?B?RVpMNzZXU0dMMzNyN1FIY0RCdkRKMlh6WXpaVXQ0MUxQZElzajRGMitTYWJm?=
 =?utf-8?B?MEZ1TXo4OCtHQnZKdERwY3MxeFVNaGpYOEM4dHRMcWNQaU9KNzFEM00zb20z?=
 =?utf-8?B?d05WMFB4SGdKSlU0TEhhU25JdFBjUTlpTFlKNVBrQ1V0WkF3bms0Qjl3bnMx?=
 =?utf-8?B?VjQ0d0FDaDhUT3RXamx1S0pwV3poRDZKK1lFM1NOUzVQV1BwMWkyOVJ6ZzZv?=
 =?utf-8?B?US90UnFXV205ekQvK0dOQTIvcWxHcU5pRXg1U1lnY0UrZ25QaWVWQjlsa25P?=
 =?utf-8?B?dFh5MFYrWmgwR0pTNlRBekw5MEtCbVJWaitkalpVd1BtbWZ2Tkh5dTVRSzY0?=
 =?utf-8?B?a0ZabTdIZHFOL0ZQTTQ3NXlpWks0a01OdXNhMnlFdXRZdjZJK21LY2R6U0dv?=
 =?utf-8?B?VEtaQUNJUWFVWXBUNnF5ZU9TRzYrd0hXOG01a0lxYXBqLy9HRTMxb1hRL2RG?=
 =?utf-8?B?M2haWko3c0pCanhuWkc4RDd0ZGZjSWJZYlJyU2RqY2xIWjNIK1F2cTVvakxC?=
 =?utf-8?B?MTlVdVlzeVNVTVVJSlJpYXh0Z3lsbXBkUGE4aGxFNUpOM2t0RlZhc25kUHlh?=
 =?utf-8?B?aCtmZDJTaWlYak5pMHlGeTV0NGU2QUk1S3FqeTl1MjZyL2UxWEM4RDdGMlln?=
 =?utf-8?B?YUR2NlZtS0c3OFRIc0dwR0JycTFPempITVVhYXdwdkJHQUdTb3owNmhsdjc3?=
 =?utf-8?B?U0kvTVpESjBHNmJMREpXb0VxM3hJbjdLODZ6QmJVTjhrTTVPVWViWEFwMFVz?=
 =?utf-8?B?TVgvN2ljcmZXUjFwL3ZFZS85REFLdGhMQTM1TSt3N2xxY2VEUGozYU5DK3dn?=
 =?utf-8?B?SHQ2bzdsWlovUDdLR3Bpa2ZScmlzc0dpQ1B5eVlxSkM0MlFhZ1krdW1GM2Nq?=
 =?utf-8?B?Um9zK0ZBVHY5a0hMV0dteWdtanY0Z0c5R3NTM1NhbUd3M2VMY25IamsyR2VY?=
 =?utf-8?B?aC9FSmJodjJKM0JUZmFXZ3pBOGViZHRGNi9tNzcrRHdzQ3JNTnpXNm5FVmht?=
 =?utf-8?B?RHBUUjBlUmlBMjArejNnMHkyeC9Cb083MW5ucmVUWXJheFN0SzFPa0JLTmh5?=
 =?utf-8?B?SzBvd0ZwS0wrbHFnSjlHbWpFb2ZEZmxIWS8wVHdvajJrZlJ2ZVZUR3BRM2Mr?=
 =?utf-8?B?UkJMM0RJZXVleUg5bkRMTnJMZ29yTXZUKythM1NVZmRWWDk1YVJ3d3M3WE9v?=
 =?utf-8?B?UzRjTWhBMlNrbk1UQnBmTkFaTDBoOURhVW9mancydUg0ZGxpd3ZaMkpmQy9X?=
 =?utf-8?B?cWVBbjZSQ2hHTmNlaUJmOWJMUk9kdjB6ZDVRbGovdklyWFd4S3kvQWpVWUtj?=
 =?utf-8?B?Y3Fya3ppNC9EQnk2dE9Lbm1BVFpvditZMUVOeWZYZVlhcldORlM4cEFWZmFV?=
 =?utf-8?B?RjR0Z2JybWZwaTRvczNJaDRFZEM2YzdPMjQ2Y2xkQW1jKzIwUWhBSFdkTXpm?=
 =?utf-8?B?TnRUaE1lRlM1QXRJSi9WMDkvRFhyN2paSHk1U2VOUFBwMEJhb25CUko1U3ZV?=
 =?utf-8?B?SC94QlJ1V3hyamZocStZSFBoVDR6VW1DVkI1RmFSNnBCZEtLdG94UGpuU2Y5?=
 =?utf-8?Q?9whpE/OYj4tABwFj/dumDcbLHCwR0Kgb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F037F7ED97A5B47B47A8B054245DE3E@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a624633-70e0-4f31-68f5-08de8b482306
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 14:58:27.4341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PPF11B50E721
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[live.com,none];
	R_DKIM_ALLOW(-0.20)[live.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230482-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[live.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya08@live.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[live.com]
X-Rspamd-Queue-Id: 8C1873373E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gT24gMjAgTWFyIDIwMjYsIGF0IDEwOjU34oCvUE0sIGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnIHdyb3RlOg0KPiANCj4gT24gRnJpLCBNYXIgMjAsIDIwMjYgYXQgMDU6MTc6MDBQTSAr
MDAwMCwgQWRpdHlhIEdhcmcgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIDIwIE1hciAyMDI2LCBh
dCAxMDo0M+KAr1BNLCBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZyB3cm90ZToNCj4+PiANCj4+
PiDvu79PbiBGcmksIE1hciAyMCwgMjAyNiBhdCAwOToxNzo1MkFNICswMDAwLCBBZGl0eWEgR2Fy
ZyB3cm90ZToNCj4+Pj4gDQo+Pj4+IA0KPj4+Pj4+IE9uIDIwIE1hciAyMDI2LCBhdCAyOjQ14oCv
UE0sIGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnIHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiDvu79P
biBGcmksIE1hciAyMCwgMjAyNiBhdCAwOTowMToyN0FNICswMDAwLCBBZGl0eWEgR2FyZyB3cm90
ZToNCj4+Pj4+PiBUaGUgZHJpdmVyIGRvZXNuJ3QgZXhpc3QgZm9yIGtlcm5lbHMgYmVmb3JlIDYu
MTUgc28gaXQncyBub3QgbmVlZGVkIHRoZXJlLg0KPj4+Pj4gDQo+Pj4+PiBUaGFua3MgZm9yIGxl
dHRpbmcgdXMga25vdywgYnV0IGJhY2twb3J0cyBmb3IgbmV3ZXIga2VybmVscyB3b3VsZCBiZQ0K
Pj4+Pj4gYXBwcmVjaWF0ZWQgOikNCj4+Pj4gDQo+Pj4+IEkgaGF2ZSBhbHJlYWR5IHNlbnQgdGhl
bSB0byB0aGUgbWFpbGluZyBsaXN0IHVzaW5nIHRoZSBnaXQgc2VuZC1lbWFpbCBjb21tYW5kIG1l
bnRpb25lZCBpbiB0aGUgZW1haWwgaXRzZWxmIDopDQo+Pj4gDQo+Pj4gSSB0aGluayB5b3UgZm9y
Z290IGEgc3RlcCB0aGF0IGFkZGVkIHRoZSBnaXQgaWQgdG8gdGhlIGNoYW5nZWxvZyBhcmVhIDoo
DQo+PiANCj4+IFNob3VsZCBJIHJlc2VuZCB0aGUgcGF0Y2ggd2l0aCB0aGUgZ2l0IGlkPw0KPiAN
Cj4gUGxlYXNlIGRvLCB0aGFua3MhDQoNClNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseS4gRm9yIHNv
bWUgcmVhc29uIE91dGxvb2sgaXMgYmxvY2tpbmcgYWxsIGVtYWlscyBzZW50IGZyb20geW91IHRv
IG15IEluYm94ICh0aGV5IGFyZSBub3QgZXZlbiBpbiBKdW5rKS4gSSBzdHVtYmxlZCB1cG9uIHRo
aXMgb24gdGhlIG1haWxpbmcgbGlzdCBpdHNlbGYuIEFueXdheXMsIEkganVzdCByZXN1Ym1pdHRl
ZCB0aGUgcGF0Y2ggdXNpbmcgdGhlIHJ1bGVzIG1lbnRpb25lZCBpbiBPcHRpb24gMyBoZXJlIGh0
dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdGFibGUta2Vy
bmVsLXJ1bGVzLnJzdA0KDQpBbmQgdGhlIHBhdGNoIHNob3VsZCBiZSBoZXJlOiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9zdGFibGUvMjAyNjAzMjYxNDUxMzQuMTM3MS0xLWdhcmdhZGl0eWEwOEBs
aXZlLmNvbS8NCg0KVGhhbmtzDQpBZGl0eWE=

