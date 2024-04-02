Return-Path: <stable+bounces-35597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B7C8951F6
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 13:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C271C22B24
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 11:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964FD65BB7;
	Tue,  2 Apr 2024 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="WW25X4yk"
X-Original-To: stable@vger.kernel.org
Received: from MRZP264CU002.outbound.protection.outlook.com (mail-francesouthazon11020002.outbound.protection.outlook.com [52.101.165.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB57945A;
	Tue,  2 Apr 2024 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.165.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057763; cv=fail; b=OqwOtfhrv9j/lq6QewRtR91jp6L4DWOztCIdBCXDVX2IJFBOkN7PITj9OQD1wPF4XYEL7oMVRiL4JPwCP6CdsGx/kUbxlIUvk2OfvBxw2cY21hyf2nVHpeuBTSQz2RqNkzgMOlzZr2T+EpKaj9trRksM780vyNjFu9GvbS2Iu68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057763; c=relaxed/simple;
	bh=cWGZFx5ApkwTbMuwY0eZ9BaNtl8Ib2FORkEqWRzJMkA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=czkHpc7YNdZFE6WCv34adaH7UnT/wLPBiqPsR6eUK6cbKDeL8tUtbQVuT6bS7Gk7r7gF6TT/qwWNDtw/zetSOeChtLOqxSvnsHg5buR0aIvSJW/q2o3Nv1Z2EAoa9hR7o+3VOr9dzIBcpX6a5gGVfSr+z4QVIO/o1afEMuUBdQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=WW25X4yk; arc=fail smtp.client-ip=52.101.165.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k28wxgIM+PKvyeewIJgxZGDP/Y9HU6D9zz9fB/B8WREAdkphAAQhQ4jLu+Nf/9eWtXt/3GfCGEiT8drvDzYbEfmwwnCLGr77Fv0QFIBHH1y2Z07zm2NBC3zWjTjQe6+4apaqWSHh4WgBmawli1HCP3cUztfVvuNw7NEEHLEMPPHLUczXMy87IQbpEbDdHcaHpGT2kE2Gs4NPq1zDOI993TOs983x+qp5OxF7oGjtn1ERKXbeDgoS9vaK6TL0EaDU2mtWAAYmn50DQE1fBmaF8cj5jsVWd1SvUUONU18ax/FRw6UHYp5H2v7UKxglhHD2zYQq18Ul8KVdNrpDBYKHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWGZFx5ApkwTbMuwY0eZ9BaNtl8Ib2FORkEqWRzJMkA=;
 b=hblgo3wcq5uyYgI8yuscJHJW1RJ9rMMVMNaQiVNDrk9E/3s5LoBhVa/jvMcKqw/FrOmqOzBxALCz9Ept2jbdXpZ56YH3Ov6Hu3QtrQHqqXKooCEjuaMc62zSXBqMKeRZHA76gIO/gSy9lVH8Cd8ZeF/lo2UZcJ2tBL+wkS7MOWVWYqpmlQech0gLJFCK+UXBcpgib086kgJkV/z6Sx80Yl3Ff3vWH0YnuFVurAdybO5X1k+UMkijT7KSFh11YSONzbXYI5Y7d2OdP8yCqXvVGnamuw+Nmy1mfy8Z6xxwU9XWMMys9mP3q6ZN9ID/fonKZnxO/EAVlzYI91gxrIb+lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWGZFx5ApkwTbMuwY0eZ9BaNtl8Ib2FORkEqWRzJMkA=;
 b=WW25X4ykwbdmjV2SVI2P4IsCzf/IBwjPZ2SsHxif3/FPT2AASZpym/2r6fWTHt8s+bgci0/sdEu2aIRGVpIlVepE/ZLJX5zq0kK3rgPNIul+UWFI1havpS3wXHY0PROItZj4LdlhVEZBOznxd3Akn2Jc9oQpKY6OOlI65BcvCTLTI57x5DBe2uq0ed7SwgRrskG6NBURx1x5EkHsqfOTTCBEcXkf2GarEXhlWJfDc6nBZCCvs2YSTPVvmeZyCqvBoAtcYU2Q0z1wDyww+HBBJ1LYibvIyHdYgm21uRZkc3QBQqGH1JKcFFrnKaz4etCK21aMDz59261zsbRiBxRK1w==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2417.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:32::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 11:35:58 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 11:35:58 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Hari Bathini <hbathini@linux.ibm.com>, linuxppc-dev
	<linuxppc-dev@lists.ozlabs.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, "Naveen N.
 Rao" <naveen.n.rao@linux.ibm.com>, Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH v3 1/2] powerpc64/bpf: fix tail calls for PCREL addressing
Thread-Topic: [PATCH v3 1/2] powerpc64/bpf: fix tail calls for PCREL
 addressing
Thread-Index: AQHahOzmconlwquZIkyyFqqaUbyPbbFU2gGA
Date: Tue, 2 Apr 2024 11:35:58 +0000
Message-ID: <a5fb9d59-a2e5-4880-8865-ed897d389bb8@csgroup.eu>
References: <20240402105806.352037-1-hbathini@linux.ibm.com>
In-Reply-To: <20240402105806.352037-1-hbathini@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB2417:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MpJW5YNgOlVP7oNzXodHoPCiu42QUEhE5uaWyv0ObzMopMMfCvHRqK/b0bu0XeQtnmhq2TI54VqlAzHWrakPTlLmCSpqFnuuu0JAamIwsfQhi56di4t3M/OBf/A7tp4F5BomKgAYx7CJsz3jKKNaxUlMwlqtnxPK445GvUS0LsGpP2kqeBMJtWF3dh4WGe9PT3hd5e8cJC84MQCN1nQDNPQocoqPiFyBA5cF1dKPpRjsSbeAsUErDQchjr7GDiMtlf9e7t30DAK6BRQHIU24mDGm0A48a/HK4U1aro6EacCKiZ7+ZPAgGVEUkzpiQDixLP40wL+N5OlNe5CqqjKjm5UjW7hqyouxEYEujgobAp7e5BRUL6e6O+cnwZocrTwKlww3WV4mmHJk0IpkbnaBw6LuppkV4RaKrMiF5RlEApwC96oyxiLI4rHtgU55vEW6StRms426p5BB5ppdxXDGzO15KdFBHsabnWLKGlpWpu2Z2BKcumfq/0IYipcqaej32xAQVjE/DwA67oPl72bkridm9+VYqYuY/kpY6sqFFI/Jo/z/alisfdzvddZpJReHYs36+N9HW483uFOtmIXzRWn2CKFX/7qzZ0BKJ98w0eKNdJl2POU2KvdxNLKoeDKcG08f0JEH2O1jdfqZ1bebiM+A3IpPiuTwVkb+L2kJ+hg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3haNStHVGhVeHEwNmZmYjRmUFduVWkwL2I2Z3kzdHZGNG14bEp0UEJMTngw?=
 =?utf-8?B?K01MS0NqbFU0MVRiVGNOTGdwczdBY3JFZnV6b2QwTEdEWkhZN1E1aGo5NEtE?=
 =?utf-8?B?MnFxZWlCUXgrUDFYaUNaRWJLdzdqL2Z2eG5Eb3Q5SERhbUo3OVVMV2hEMGRB?=
 =?utf-8?B?aktiQ1VFS1lsWmVOdzU0SXB0dmhKc3pkRUxSWTRjbkNNeEU4dlVycDdvV1VX?=
 =?utf-8?B?QXZOVDliSjBhTWJYUnhkSHR3ckxKZ0hoVWttVjVvZFJCckpGWXpvcjFIR3Jv?=
 =?utf-8?B?OWFuTjM2aWR2Y2lkTyt4eEpURmpGd25VNGFrUTc1cjczdUtFOTA0Rm9sTldI?=
 =?utf-8?B?eEp2TUtieHU0NEFhNHIxbFJFN21KbDV5K2ErelRyNWRBSlJmZytnaEowWWF3?=
 =?utf-8?B?SDdlOE9uRTJiZ2RoN0pLYmQ1c2Vsbk5xcytyUmF5VzBhdEpaYlNjY2E1eHV6?=
 =?utf-8?B?aStKMERWQXpPSCtBendSU2VWcVRsemdDWmdRd2kweEZPUkFHTnJCRDJyUi9S?=
 =?utf-8?B?c1hUdVlsMDlZcFlVcVc0NnZ5dXl6bFRhU0gyNHJXU2RGYUNIcnZrM1dkVEpi?=
 =?utf-8?B?Ni9WWThiWlBwYWhOeDQ3NDdzb09uY0dYN3QvSjZxUXBmT0E5YjFyQU5BOWQy?=
 =?utf-8?B?dzdLWlJPZ0ZjSFZOWlJ1VzZ4ZDdrWkQ5dHFsSkpmMEtGNkJoRFJKdEsya3pW?=
 =?utf-8?B?TzdFUytxNk9Sb2hQaXJjY0dPOUZVNnhlNG9Tem95bk5oaGxTNnhHR0puRVMx?=
 =?utf-8?B?bFZ1TVJRMWtNUHdNdUJhUDY3UWlKNTdpSHRpckQ0WGQ3alF6ZzFVL1FRdVcy?=
 =?utf-8?B?Y0Y4bzArTE9vL2hMeWZaQ1hWUmdQU3NvTytNZnZaa3c2MXYvU3lkQis3VWVo?=
 =?utf-8?B?a1I1ZkRGQXlBZkgrZFpUS3Jaamx6T1RRZ1lCN3B4aU5wamZpeGZaL0JlSHUw?=
 =?utf-8?B?ZkpvcWZFcUkwRkduc3V5M0hEUnZYVUcxQVc2bnhQa0N4NkJ0MUFNZ1MyNmhn?=
 =?utf-8?B?QTRXMHEzd0xrRyt3ZTNTaklEbk5Ra1FkdEE1RnhrVEs0aVVtaUFIa1M1dE1U?=
 =?utf-8?B?dUp3SnZ5dEV4MERPa1lydkpET3NRZWZOMnJYR2tTS0VHa0tQV1BvU2tkbGo2?=
 =?utf-8?B?R3B0bmxXczZMdUtLcXJGMEJmN3BjZzRuVTJXeWhSL3FzRk0zYnJTdlMxVlRQ?=
 =?utf-8?B?YXR0MGY1dDRpM0VPOGhjanNJVlQvRmlNTzB1TnN3SE8zM3d5NnhTRUFQNFBL?=
 =?utf-8?B?YnF2eUJheUxvVCtYdkRwb0F3c2M1RHYrNVlOMlN3a1BOazRweEE2bUxPT1lT?=
 =?utf-8?B?N2syb2llY2pvbGVUcDRNM2prVzlsRlhwSFg1MHo0dkZjNjV3Zmd5S1plbmxC?=
 =?utf-8?B?RERpeFFJbFpkRTRvUU5uYnRpOVdNd3E0Z3pZRnNGYkI5TXVFbzF2em5WVkxw?=
 =?utf-8?B?NHAyMFY1dHhpanRtRThzVUJFbWwyU3ZWTWJITWkxVFJjbGRkM0tJMWViR3ox?=
 =?utf-8?B?VFVOTjVhTDVjRHR3MjcwUWpMYVVremtkbkNSVENGWGJwaERXc0p3TUJnbi9I?=
 =?utf-8?B?UnhBaEJhK3A5WkNGeHZVV3pDUzVJSE4wM081dUJYV3RrYjJHMWRFNzVkWTBG?=
 =?utf-8?B?NDhTSGhuYkVNOXF5bEFXMkJ3ODVod0xtNGZ4RjlCeUNOTTZ4ZnpDcUZHeWhV?=
 =?utf-8?B?eDd0TjZ6V1RTM1VHcitoOWl2ZlVRaU1TYnhRRno5NEFlbmhWZmFHVko4OUdK?=
 =?utf-8?B?aXNPbWFqWjVOWlVpTmRGV0hKYzdvNzJHaXNDQVFGWW1SNXp3NTlaeTNxakJx?=
 =?utf-8?B?d3k2YTloNEY1U0d4M0hPR1k5RldzLzZxeUdSaUh1OGxaWmN0YWdSSE1iNUZz?=
 =?utf-8?B?QldYZUo4ZHlXL0FHdVRnTEU2VWJBTEV4ck9UWmxmdjdHSFJJOGVCNEFDMFF3?=
 =?utf-8?B?clNaUUN1TXVQSjJKcmo1MHlIbWpQZEkrcnpKNm5pcGNyUzhvd1lOTU8xU0xZ?=
 =?utf-8?B?V1l5L1RMT3p0UHNWMWE2cHVNbWd2UkpGWGN1eGg0azNUMS9kckxuK0N0MFBh?=
 =?utf-8?B?eTREN0xQc0s5bWgrai90QXNmdTNSOHpNOHNhTzBKRnhKWmRsa1RKSWFYOEc5?=
 =?utf-8?B?amJyWitqaWtPamxiZUtuOVM0UTF4QWliMWpscEdiek4zck5pS2VmQytaeGll?=
 =?utf-8?Q?BJPShnVnT/gzr8wop9omp/ByFZ5cQ0t7Cfeb0vAmJ8Iv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29048D371DECFF4CBCAA187479F2EA84@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fe77e9-3b52-4350-f289-08dc530910e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 11:35:58.2737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WPQy14Knr2EEmYoCjbZeCcKwh72aho+KQIx5eLyQYgKo9DLCDeqoF6zK0QaNwwaKcwyLY5BzOdWslBWh2WbUMpxA2OJpIJfJlr5VdgieVHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2417

DQoNCkxlIDAyLzA0LzIwMjQgw6AgMTI6NTgsIEhhcmkgQmF0aGluaSBhIMOpY3JpdMKgOg0KPiBX
aXRoIFBDUkVMIGFkZHJlc3NpbmcsIHRoZXJlIGlzIG5vIGtlcm5lbCBUT0MuIFNvLCBpdCBpcyBu
b3Qgc2V0dXAgaW4NCj4gcHJvbG9ndWUgd2hlbiBQQ1JFTCBhZGRyZXNzaW5nIGlzIHVzZWQuIEJ1
dCB0aGUgbnVtYmVyIG9mIGluc3RydWN0aW9ucw0KPiB0byBza2lwIG9uIGEgdGFpbCBjYWxsIHdh
cyBub3QgYWRqdXN0ZWQgYWNjb3JkaW5nbHkuIFRoYXQgcmVzdWx0ZWQgaW4NCj4gbm90IHNvIG9i
dmlvdXMgZmFpbHVyZXMgd2hpbGUgdXNpbmcgdGFpbGNhbGxzLiAndGFpbGNhbGxzJyBzZWxmdGVz
dA0KPiBjcmFzaGVkIHRoZSBzeXN0ZW0gd2l0aCB0aGUgYmVsb3cgY2FsbCB0cmFjZToNCj4gDQo+
ICAgIGJwZl90ZXN0X3J1bisweGU4LzB4M2NjICh1bnJlbGlhYmxlKQ0KPiAgICBicGZfcHJvZ190
ZXN0X3J1bl9za2IrMHgzNDgvMHg3NzgNCj4gICAgX19zeXNfYnBmKzB4YjA0LzB4MmIwMA0KPiAg
ICBzeXNfYnBmKzB4MjgvMHgzOA0KPiAgICBzeXN0ZW1fY2FsbF9leGNlcHRpb24rMHgxNjgvMHgz
NDANCj4gICAgc3lzdGVtX2NhbGxfdmVjdG9yZWRfY29tbW9uKzB4MTVjLzB4MmVjDQo+IA0KPiBG
aXhlczogN2UzYTY4YmU0MmUxICgicG93ZXJwYy82NDogdm1saW51eCBzdXBwb3J0IGJ1aWxkaW5n
IHdpdGggUENSRUwgYWRkcmVzaW5nIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4g
U2lnbmVkLW9mZi1ieTogSGFyaSBCYXRoaW5pIDxoYmF0aGluaUBsaW51eC5pYm0uY29tPg0KPiAt
LS0NCj4gDQo+ICogQ2hhbmdlcyBpbiB2MzoNCj4gICAgLSBOZXcgcGF0Y2ggdG8gZml4IHRhaWxj
YWxsIGlzc3VlcyB3aXRoIFBDUkVMIGFkZHJlc3NpbmcuDQo+IA0KPiANCj4gICBhcmNoL3Bvd2Vy
cGMvbmV0L2JwZl9qaXRfY29tcDY0LmMgfCAyICsrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9uZXQvYnBmX2ppdF9j
b21wNjQuYyBiL2FyY2gvcG93ZXJwYy9uZXQvYnBmX2ppdF9jb21wNjQuYw0KPiBpbmRleCA3OWYy
Mzk3NGEzMjAuLjdmNjJhYzRiNGU2NSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9wb3dlcnBjL25ldC9i
cGZfaml0X2NvbXA2NC5jDQo+ICsrKyBiL2FyY2gvcG93ZXJwYy9uZXQvYnBmX2ppdF9jb21wNjQu
Yw0KPiBAQCAtMjg1LDggKzI4NSwxMCBAQCBzdGF0aWMgaW50IGJwZl9qaXRfZW1pdF90YWlsX2Nh
bGwodTMyICppbWFnZSwgc3RydWN0IGNvZGVnZW5fY29udGV4dCAqY3R4LCB1MzIgbw0KPiAgIAlp
bnQgYjJwX2luZGV4ID0gYnBmX3RvX3BwYyhCUEZfUkVHXzMpOw0KPiAgIAlpbnQgYnBmX3RhaWxj
YWxsX3Byb2xvZ3VlX3NpemUgPSA4Ow0KPiAgIA0KPiArI2lmbmRlZiBDT05GSUdfUFBDX0tFUk5F
TF9QQ1JFTA0KDQpBbnkgcmVhc29uIGZvciBub3QgdXNpbmcgSVNfRU5BQkxFRChDT05GSUdfUFBD
X0tFUk5FTF9QQ1JFTCkgPw0KDQo+ICAgCWlmIChJU19FTkFCTEVEKENPTkZJR19QUEM2NF9FTEZf
QUJJX1YyKSkNCj4gICAJCWJwZl90YWlsY2FsbF9wcm9sb2d1ZV9zaXplICs9IDQ7IC8qIHNraXAg
cGFzdCB0aGUgdG9jIGxvYWQgKi8NCj4gKyNlbmRpZg0KPiAgIA0KPiAgIAkvKg0KPiAgIAkgKiBp
ZiAoaW5kZXggPj0gYXJyYXktPm1hcC5tYXhfZW50cmllcykNCg==

