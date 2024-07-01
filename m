Return-Path: <stable+bounces-56239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD2891E23D
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 16:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFE3288460
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181AB167D8C;
	Mon,  1 Jul 2024 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="OLkjk0bs"
X-Original-To: stable@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2078.outbound.protection.outlook.com [40.92.102.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D45A167D9E
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843541; cv=fail; b=GJpzvqVU9OdCh1mmuzxRi6NJrH3LYvmpYeLLzbT7q4A1jzWImSObPqMSuvfAIPvyMtBh7s4CdFElDsoCi+4Jdinw0G4cawlEL1DKeJ0l5uTZSXIX5lZcCQzA4sDv/Hc6mAm+zValcH2Zcq+i1njluQuFWqadaR9o4Qk0ig65S7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843541; c=relaxed/simple;
	bh=/VAEy8fuc08AFiNVIu4Vvy/5LfIjMJ6nlSfY+8UTMU4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=d0cDYOciHEgqrHDl68//CEN9jOWS3uhpyZUqG9PKXFJvGGarzv0m2fgGkrzi1alxFpYj/sfxYDRk75W9oN48JIBX3ff+v/v5ElXlXeJdCV8ObCivYDmkYoR3kdYiqnpH9seCIur+w6SfBx3z30ozpNOyjMra6ibKX3H8R4L8gLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=OLkjk0bs; arc=fail smtp.client-ip=40.92.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwGSL+90OFM84OlYjZoWfkadhAI/tXaUgBP7ltHDK5i9oPK/nFzw5MPdr7GMEXSJV0dqB7ioKcv4Oh0jd5s39mAZ6wCDxfb5jmbQpf+eV2vcj9CCN/cZWxKCVtwRMRFDk71S4GtsnH12Em6wdfMtjxkh0BA42lk8vwNPV2UJIGaTM2QbcBpJrPMtURc2FDvuVr7ZpWOP25XlN3ktSwHeJoiEoDDmpcaveVB7mfmyL8u9pt3WlSqTd/SXddMXqyd+Y0XSLuehKV8JyT8B1phHceEbgwErfbGYEYEWRuNNgTf8j1fHQhv84VSszeCmZmCmauFlx+lMO07Rr2sMW+qR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VAEy8fuc08AFiNVIu4Vvy/5LfIjMJ6nlSfY+8UTMU4=;
 b=MswPmltaUOs9B3GaMAXs+YzchLDK3v/M4SkewhgAep/X4e51YlN6unLV61ZMJ/0kH6zfDAwcb3MFs5gKVHmk7BtplFUcAPe8rsoXQYpJuh/Dt5mx/kRFig9dicZuxLskKUMXc3s6s2c5unqmpMMFu0mn7CqK42a+OmQK0i/UDrh3cjYiIkrFlwns634cjP7TnXE06a73cEfbQG4gxvPK9N2tVZP99cxw2PQpuxEqKG15Dxn2gFO7g0ee42MixT6O1JKwVTbHuBGGRWbGRwikXCvFm1GOoi7RypcjqqK98QHXcEGF1g85fB64p+JdAX8n5H1diYJxt29duyDYk6kF2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VAEy8fuc08AFiNVIu4Vvy/5LfIjMJ6nlSfY+8UTMU4=;
 b=OLkjk0bsH/eBNTJjPnoJLIrV0zyChbzVE2dIS+HjcLFckg+pZl3N1Gs1YbYchFyrJkVIRP9BSwlQQZN5/c48aqGyPIn4VCGjrUgzAaxzWDlmyxZddbuenyz8yyDijrS+R5XXJpS53wE8Mp8TEvsEAClc0IuM3h3+FcsmxZoAZl8PdlJeoEEOFTh2HgX658fJcsAas2y3/SGuhUSSpKNTRDOtm5lJOY16o09YPSxdqwh2Taw63UgxOlrfQy85JP5wD8Kxl26sXSPUezwRHDyVXnYv1KUUJRfnglrKgBsMEFqFxWw42NbP1rOuY+PoGDI16JqumMk7R+6XdLjEbOWN0g==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN2P287MB2080.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1c7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.28; Mon, 1 Jul 2024 14:18:55 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%7]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 14:18:55 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: Jiri Slaby <jirislaby@kernel.org>
Subject: [BACKPORT]  HID: apple: remove unused members from struct
 apple_sc_backlight
Thread-Topic: [BACKPORT]  HID: apple: remove unused members from struct
 apple_sc_backlight
Thread-Index: AQHay8GbtMr4tUd3c0WD+mRYnXKC/Q==
Date: Mon, 1 Jul 2024 14:18:55 +0000
Message-ID: <6919952F-1AF6-4D16-BE61-686C5D8F5A87@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [h+ZWppBhvSzw0bUkkrF0/E9aGod7kU4knZ/FMD4OZlRRb0H/4fNHhthmlcBN3GPc]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN2P287MB2080:EE_
x-ms-office365-filtering-correlation-id: 5d87eb81-6d41-4577-c4bf-08dc99d8bdd0
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 7T573YhUev4DYsGdAOOihIEVbffMLyrrt6tntiGNfuh9xyWro4M46Gyd4vA+jqYEeCghepvJ0CqLAQvS/qgfRvQl4Hw4NIouxvR7kMmQl78DnnX34lybdkEc2pJUTQZTuSv/uPkqpg4O98nIVJPtAn295mGzmj2A9ISdqCyzD5/+J/MXagnGdL+T3kifyD5/bWwH4p52XLJDCeLCKUn+Tzd3aI9Eor0nj8dsPGzhNeijVvKuPG6akV4Ln2Py7MMumPcuqSOBgJdZaKWajWtq48xSxv9a0+N9zuyAO1/VxviTnjQsJuIatMC7LVCqEvcHAXigOJJ3stFGtUcq7qyObZN/2ECk++0KqL9AZwoDYSbmKzl23LrONePPQfF9ohSlR3Dz9V6cNEvbK17XrBxzND7q3PXQ/DzcsDdfUV800EsCC6HJJvpr/SwV+9oTV/oQDaoP2LCktyX7WNMrO6FdIHsKsPechiu08IiXmUdJA/P/SOSAgRw/Md0HJKhQT1cYSEE+G7XTG8v/WPmD0IIF+Ae9GrcEz0hKCT4hGz6tST65qCDyWDKS/oLfaunhxWUo8cj5tjqlkjzV9c9+yvWgN/3X5FK8AzU3yz4SXycjQMDffFirAP6Nx9bDIZocLr73
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUxrd3pNOXE5eGY1Ky9kZ3JRVDg3S0FlMFA0UkYvS3plVjNJR3ZUMzFHT2h6?=
 =?utf-8?B?cFJEa3VlOEt5dWl5SjFlMHlLNFZiZGNObTRvaGpxSFhUb1FUcCtncEF1SGpJ?=
 =?utf-8?B?WjdxWEJSUUpsNVpwL29RYjh4UVpLZlBvN2Vjd0dtaUsvUCs3MkNZTTVoWVZG?=
 =?utf-8?B?eHNKS3U1OG1IbGZtdDNNVk5HYy9xWUczSktTNnJhcVpTZnVheXhZRUUyTk00?=
 =?utf-8?B?QWdPaDhNWlpiN0Y5RVZ3MTlGVk1sc0lwcGNDdXlJQWxIbmJMcTFVb1JQbms1?=
 =?utf-8?B?c0x5bDFBVTgyemVOTzVUSGswNkYzVjJIclJpSWo2SW13TERyUE9yRkxOYTI4?=
 =?utf-8?B?MGhYd04yNzNNWGxDcXpSb1dabXBSWWIrZnArSXNzN2RIMllUbUVqVTJDcWYv?=
 =?utf-8?B?R1FJQytvSW5ZdzBBZHpTVnlnc3lmVnhjY2F1RnZLOGVuanNFc01vNC9rM1kz?=
 =?utf-8?B?U0pOY210VnRDUk8zNUx0N29uc2x1eHlnUlZKVkJMQTZlRUpUbTAvQzE1VTJP?=
 =?utf-8?B?bFhsa2xBQkM2SEllY3BYbWtvL1U4bmFqTWVMRFU0bnlrYW80eEJiM0hhL0ly?=
 =?utf-8?B?V0EwcjZFNFZzZXIxUWUxN2JGQWU0eVhhZmNpa2NtREMzM25UeXMzYUVNKzRL?=
 =?utf-8?B?SnlIRU1TNEpyQVNlSmp4QnhiVkhwVml3SkxBWGxrMlE4R0M4aUFpNGVVS2Fv?=
 =?utf-8?B?TVJiaUxoL0s0OVdNanY4d05VbHRzZks4YStKQXVJbDVKMW44OGRiUmxOYTJQ?=
 =?utf-8?B?VEIxc05UQjQ5TFc3bWgrM2ZaZTRJVUJzS0l4ekY3RWJITE9QaWg5QjBJMGxa?=
 =?utf-8?B?Z0wvSnBBaFF1bXFEaWx0d0N5eGYzajQ0MW9jSXgweDZ4OVNKOWJnL3NzZlFF?=
 =?utf-8?B?MEpGVmxuaWVOSDFHOUQwblY3Nno3Z0Erb2U5WXNpd2NaOEttWHZZSEFxbFRT?=
 =?utf-8?B?YzBPTzZ5V1luRlNmbnM2V3hiUmFCb0FNSnBESFBZeVJGWnBvcjhrV3Fwajg0?=
 =?utf-8?B?bmM4K09hK040ckdmMmRhTlJYR0ZPeG0zRGUvanN1STErR2VSdnBXVmxGelJJ?=
 =?utf-8?B?NDFwRVNnUWhUaHg2eUFBbTg0NHJ6ZXJ2OVlkVFZldlhnREZ2djNQc0kxdVMy?=
 =?utf-8?B?MEh1bXdUZXYrQ1M2RHJqNTlWVEJxNjlFa3NHMXdnYUQyV00vZGM5Q3pQWlo1?=
 =?utf-8?B?MHhLWVNxYVkyS0tXYk9KNzlGcE00SzF3all6b0pHUnUyaDZzSW5qRlJ6dng1?=
 =?utf-8?B?Rm9EUzBzdVVxTXFEVXp2dUF6YldnZFhHNzlNaUZLbGhKODVhZEtXTWVuTWRh?=
 =?utf-8?B?ZDhpd29QVDhBbUVHd0djY21SYU1DUVhHcCs0bnh3cFh0eGJEbHhVNVBPblVK?=
 =?utf-8?B?WDRaaG5XTTNaekNPNDU5QVhTdThTU2p0NkZHQlB2Q09OcUdWc3htUEkrT0c1?=
 =?utf-8?B?dWJrZXFxRHpHcnB5NVlKZE5JYUpVV3RXSTU2ODFEQ2RncGNVZXpKZXd5QjB6?=
 =?utf-8?B?bGhPS29OVEYreFFzd0s1cU8vS0tON2pNSnVFclF1Y2pzdDZIVTJYZGR6YTlB?=
 =?utf-8?B?Z2ttREVxaFZERWs4bXdPOW9sRXJFMkJwSUQwSnh4R3p1UVVRancxSWVrSm04?=
 =?utf-8?B?RWN0OVc0QnhmRS9ZOVh0ZktpVG1DUjVRRnV4OE1TWFQxaDM4TkwzdkZ4RWZV?=
 =?utf-8?B?NTdLMHFpeHZBeWJ4QWQ3a3pPcnNpTEV4SENLdndIVkw2OXphbGNzOVpHUW5O?=
 =?utf-8?Q?ooDyoO9todSQhOlyLCtt3BrJukHF6qjYQUQTkrx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3721B8B11310DA428A09600BC5F8B589@INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d87eb81-6d41-4577-c4bf-08dc99d8bdd0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 14:18:55.5876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB2080

Q29tbWl0IGY3NDAxMDZhZWRkMyAoSElEOiBhcHBsZTogcmVtb3ZlIHVudXNlZCBtZW1iZXJzIGZy
b20gc3RydWN0IGFwcGxlX3NjX2JhY2tsaWdodCkgaW4gTGludXPigJkgdHJlZSBpbW8gc2hvdWxk
IGJlIGJhY2sgcG9ydGVkIHRvOg0KDQoxLiBMaW51eCA2LjYNCjIuIExpbnV4IDYuMQ0KDQpzaW5j
ZSB0aGVyZSBoYXNuJ3QgYmVlbiBhbnkgY2hhbmdlIHRvIHRoZSBiYWNrbGlnaHQgY29kZSBpbiB0
aGUgZHJpdmVyIGV2ZXIgc2luY2UgaXQgaGFzIGJlZW4gdXBzdHJlYW1lZC4gU28gaXQgc2hvdWxk
IGJlIHNhZmUgdG8gcmVtb3ZlIHRoZSB1bnVzZWQgbWVtYmVycyBmcm9tIHN0cnVjdCBhcHBsZV9z
Y19iYWNrbGlnaHQ=

