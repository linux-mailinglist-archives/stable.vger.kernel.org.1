Return-Path: <stable+bounces-86725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABAB9A3248
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 03:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B097FB23E43
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 01:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7198130A54;
	Fri, 18 Oct 2024 01:53:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2127.outbound.protection.partner.outlook.cn [139.219.17.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B965A126C10;
	Fri, 18 Oct 2024 01:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729216405; cv=fail; b=NG3RkeO/oMcEWxy8x/1t0Jm5aBsUuxKMjnR2awaeDd2gKVrN6b/2UQwEMT7k8JBrT7rkwWN01MTOMuCUjI1B63oZBX+/JK5IU+cp3WaLmbG4Q4jC2g61upBhw8jYOWECT2UG16VJIK0CkHXh/FnT/B109MN6AKKTDu/V0CWHA5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729216405; c=relaxed/simple;
	bh=aWW3gx/jEm9F7tfpr1wzKaf886RGuz2cczNTmC7wRAU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BPiaxckk+rQvg/BeKXveemIJqRKWPaqZc1swz2npNm+ttYhCr3z+OXjrdHRIsKR8QDSn6wLKX2MCobVdx6EfkEQcYqkgn2DwlL59DKZGz+aDFBCFySQc2v3fzrOot3LrQSDVUl+WRXLN5LmbPN9kFwRda5+bDU1GzMdJ8jPe5WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IN2bGQ2MDvwEs2+uWHlSTgTGOeLPMmEytL3mndfv4QI5sCGieyJIDFdmeQMstN4LtbyJCOYQKtgLUbziRrZV8gmVZP5RhkHlhLwwghilAXHMGA1/CmXKBsXim71PT9udPJjv/dPkAgEWroPrYiKpLbQhELLpPIUI+qJMnsNW7iVOzLTHvRlLA3ifhWPzNAFY76/mucloWdKbiLDhd4PpaAjow5dCoRmAaEVg5tuA2JPSaSQ12GJG0mMU91KDPtqkimmj+M3fDaTB8OmaspUWrAHDFp8MSGSsMlfgSCMhb0PKeieOCfU3pQeHs7dqOmZWE08UZEZrBB7lfMhyuH6zBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWW3gx/jEm9F7tfpr1wzKaf886RGuz2cczNTmC7wRAU=;
 b=kfkmg1dbD5Yar+HEjF0tCr6xj9P+73T6yFPXvRUY443OcuBDKH3M8UKUKZriQV+kC9yPEKn8+4Lg85ec9tba+tOZPOtb/ZjwvvVL4qiudg+jUfqPcXdKm+LLAHVpGF66EAn07rBmBfvt1jJvxiwGN6xfEAwdhrYlNWSYBa+KIFQhUB2gvMTdxZwVhuVw/OuIQ8JPCypSxrMhBqTd5VL5s3kt7ZlVwk9mTJlqUPDarvIVheUqSYwOUxaHuTg8G7GGuHNlQQNwrWyjghfMI7+8v/P7fvtEBVo8HQFe4cNj0WGnE3KBEY+A3lQuwjSTy2w+U5Duom06EbTiyW6PHALtxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 01:21:11 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::64c5:50d8:4f2c:59aa]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::64c5:50d8:4f2c:59aa%5])
 with mapi id 15.20.8069.019; Fri, 18 Oct 2024 01:21:10 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Conor
 Dooley <conor.dooley@microchip.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, Emil Renner
 Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogu9i4tDogW1BBVENIIHYxXSByaXNjdjogZHRzOiBzdGFyZml2ZTog?=
 =?gb2312?Q?disable_unused_csi/camss_nodes?=
Thread-Index: AQHbIAerDCyRJ1WJg0mmvQeCtV44grKKI3cggABMoZCAAMplAIAAfRRA
Date: Fri, 18 Oct 2024 01:21:10 +0000
Message-ID:
 <ZQ0PR01MB1302DAA51F7171B19ACDF7A7F2402@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1302:EE_
x-ms-office365-filtering-correlation-id: 7841194d-ce72-4945-71c3-08dcef132675
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|41320700013|38070700018;
x-microsoft-antispam-message-info:
 CDZ+qj+RLo86GURjDalYGoZOd3xOv9uQAltE/6MYI67/yZZaTiWsFMCeQP7pycn69+EwqQnxAD5JOiWy8cD66Jer2fDkQYsn5XFF5XbQh+MGcpgp0wU74RDRgtscNWFCDsynQFpg2LCelnPNJL1dqEpwdQ/W8eGDQrlleJP6d8BnLpUToJtwoJ4P0QLojfVgVl04aRWcuXPrm5SUqIunwjNYu3V8qRKvx490p4Co+hgLnOmnF5nMd8pJ8nIAak9dOTlSTb/okREpKp3OmeYuLV1BPCheoHbEUWUTIVI+i2pB+/Z7X3Dcw3LWIBPiW2WV+hJAllRpiGJzbNvi1NPO+V9yvp4M9yv2ZyjXGD+l4jVTDUzL90h3zxtw5fhcywTlml/6dEy0YIoORlWcX5SThKdZeVMgwuWvqTDjnmBb4qPgR089SkveYbw7pgjODCoKu+pio5136R3pNG3BlALKBhuF5PMBp6NwYLamfzlHifZAg1twdIqQoLAq/Q3X4gfs0thbbFqPJXQHN82qhDcSGCnatgFBbFm2kdBu8jwzoQ940dXX2PRyoqK18zRA5EgFczfGCJTkompxhYOe2HJWtSgEpKZrpUNmn84ZNc9+wzBmo0JO80ns9tVTZlM1/Z4O
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(41320700013)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?aWpOKzQ1R0lJRWFld3RteFNBeDVNTkRoME9oR205SGdCdWJNK0wxRU9SaUIr?=
 =?gb2312?B?N2FndDhnVHZ1NGJRR0YwKzM2dFpYNno0TkR2U2FmK09LRXVPVzJsdEl5TzlK?=
 =?gb2312?B?R0FJd2xTc3VibkU5c0xIaExIYlVob3FjaTdsRGtxSGswUkFaVlFmR1oxcjh1?=
 =?gb2312?B?WS9TWnllUEVhNzNUeVNJZlJpcWliZUFlb1AyR1FRVVg3alpMZ0JWUlRXZjNp?=
 =?gb2312?B?WTRSTU5XL2tMVEZ2c1F2NzZOM1pZY1NHTldUc2J3aUEyOVJUcDliUld1R0pV?=
 =?gb2312?B?djhHK3M0akhTUVpzMkE0OGwzdXkydUFiQlVBaXVBZG1XN3ZZTjZGV1ptdjRh?=
 =?gb2312?B?RS95M2EwVkFmM2lMK2dZa3h4ci8vQUoxd3JheWdwTCtoM3dkWCtzT3ZIbW4z?=
 =?gb2312?B?OFN1NUppdHNIN3BpRHZxMlVFQlNwdHpyUkxPY3dQMVRJcEpNalhYV2pXZllJ?=
 =?gb2312?B?R2xFMVZQRlJqai9HcEdRM2Ivb3UyWEt6RlhpS3RMRGlXUlQxWS9keHlyU1Nu?=
 =?gb2312?B?aDJ4VXJGUnJZM0pLTW51TThxUmQ2Zng3TDViMUxKa3U3Nk9YeFd4L1R3aDd2?=
 =?gb2312?B?dmtYOEpvZlFlQUF6M0lidjk3YjlJK1RlZGRxR2ZKbGUveXNVU2VaTUtyZ3c5?=
 =?gb2312?B?RTNMYU9oL1ZUVzQxRkxWb2xuVWV3ZUdvQ2NzNHpvbUNuaWtPd3IwUDYyRWp1?=
 =?gb2312?B?OFBSODNsY2hpRG92NzFBYkhKck1sa0M4M3VYTHFrYVk1WFhkRjNrNFFXWEx1?=
 =?gb2312?B?bUtsZWJTN2Y0VnZnZG9iNVRrYjlGSEtDMkFHQzlnTXFVV0NzZ1ZRZmloREtH?=
 =?gb2312?B?aGloYmdmTWhFQmVYaEJwNkhPakNpakJOdlMxYUdYYkFaSEsyM05xcTJXTmo1?=
 =?gb2312?B?Q2dzNkFuSnJndXVzWCtsdzlqNHJWaFdNR3ZudmM2aEdMVmZ4VG1JbmNYQVFS?=
 =?gb2312?B?UEVaSmN2UFpNdGxtS0ozSlRsWWFhekZ6YzFlMUtEbVY3bGdUZnEwTitFUU9P?=
 =?gb2312?B?VTlaZzJhVWhlQlBIUjAzeDNtZzNUNFVmNXRBR28yMHZiRjJNcll1TGVxNUd4?=
 =?gb2312?B?LzFicC82U2MyNmVpUDY2TUhIZEJRUTlkRnpFWFFpQ1hPSGdISStQclFTRk9I?=
 =?gb2312?B?WThPYkM0V3F1TDg4UWZWZnlvR0p0ZXp0b1Zxa05LdnBRc2lFdTZKeVlLaTBD?=
 =?gb2312?B?QWtxWVQ2M2JmNldWQUJsTmRzaFpaVWFST28zV2NpeHFKL0lHczdVak1lNEZZ?=
 =?gb2312?B?N0wrbDNCaW43WCtpaWlMb2poLzF2TGNDVmxqckVaSCtVNnJtZk9YRjRaWk1O?=
 =?gb2312?B?TU9GeitrV2JsM2syTFVIeWxkUjlHVzQ0Y3pjS0FpdU5BdmVkdVE2UW0yQklS?=
 =?gb2312?B?UUdTTFFzZDhscjllTTZWdjZsQ2xlSGFpNngvVER2bzVHd2dydGVBU1pDQnF5?=
 =?gb2312?B?VDlER3BnVGIxcTVFYUpJRmdlYnlvZWZEcXhVc0Rid1F3Z0srT0ZTdm5pS1c3?=
 =?gb2312?B?RzVJdklUMUJEUUlwMUQ5WGNmV1craGhnNCsvVWdlMC9xM1crOHpscDBZWDNO?=
 =?gb2312?B?Wjk4RlB5MjRnMW5RUEJpTHc3YkQva3ZJV29MUnZnUDVCanBaaFkwNDNKbm1y?=
 =?gb2312?B?Z3JtMEpxYjh3K3JLV1VkaEgwOU5GL3lpa0h1Vkk5K1V3VkMrLzJUdE1PVlVu?=
 =?gb2312?B?aGF2VWNzNVZOUkpraTJENHFDVmEzMnR2WjViVy9LSjkwalUxN3F2eVMwV2dT?=
 =?gb2312?B?UHlrZ2FxRU1pWjU4YWh2aXdnTVhoZjgwbEs1QjZ0UENyczhQTmxBUUtHbitx?=
 =?gb2312?B?YkRoQ3BiZWsyUTN6NkZjY25oZ0IrbzhLbXh4Mjc4a0lFQlVUYjJFNDRienNn?=
 =?gb2312?B?VEV5NmtGOEtQSFIxUy9zNm9yWHdubnRPMnBJeXpmejVFNXRVdmw3U2pMRy9Z?=
 =?gb2312?B?d0t1aDA1dytZSjZ5U2lYMFVrRUJNZnBOeEZ4RSs2RkFFbzJ0U1didFU2Wm5C?=
 =?gb2312?B?UHptdDZZbDR6NlFjRUhzNHMvSEVRNDR0Qnp6WGFIckVCd3hBQzB0K2NhM0dF?=
 =?gb2312?B?YVlWZU1TMHc1Z2p6QkRkcmlJZ1orTUtQNDV6bHZLM1ZrK3FQSk1CMmhXcVEx?=
 =?gb2312?B?T2NwMCs1L3RvVWJIeGZVVnkyUDhuTDRoRWlva0VuYjVoU0dSV015Ymp0RUpF?=
 =?gb2312?B?TGc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 7841194d-ce72-4945-71c3-08dcef132675
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 01:21:10.7923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: goJ6cMgPaVgqI7IaEJzPQA2eOQ/auYvJUpyJA8rce+Ya/fWGB8jrbjH5JH4FxFbR0ZOIMCyGZnyT8m78+gBfNu6KnTo13aH9q8EFM4cwxcgYFJNGz6E8oZ8QAjr22XrP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1302

SGksIENvbm9yDQoNCj4gT24gVGh1LCBPY3QgMTcsIDIwMjQgYXQgMDU6NDk6NTZBTSArMDAwMCwg
Q2hhbmdodWFuZyBMaWFuZyB3cm90ZToNCj4gPiBIaSwgQ29ub3IsDQo+ID4NCj4gPiA+IEhpLCBD
b25vcg0KPiA+ID4NCj4gPiA+IFRoYW5rcyBmb3IgeW91ciBwYXRjaC4NCj4gPiA+DQo+ID4gPiA+
IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+ID4gPiA+
DQo+ID4gPiA+IEF1cmVsaWVuIHJlcG9ydGVkIHByb2JlIGZhaWx1cmVzIGR1ZSB0byB0aGUgY3Np
IG5vZGUgYmVpbmcgZW5hYmxlZA0KPiA+ID4gPiB3aXRob3V0IGhhdmluZyBhIGNhbWVyYSBhdHRh
Y2hlZCB0byBpdC4gQSBjYW1lcmEgd2FzIGluIHRoZQ0KPiA+ID4gPiBpbml0aWFsIHN1Ym1pc3Np
b25zLCBidXQgd2FzIHJlbW92ZWQgZnJvbSB0aGUgZHRzLCBhcyBpdCBoYWQgbm90DQo+ID4gPiA+
IGFjdHVhbGx5IGJlZW4gcHJlc2VudCBvbiB0aGUgYm9hcmQsIGJ1dCB3YXMgZnJvbSBhbiBhZGRv
biBib2FyZA0KPiA+ID4gPiB1c2VkIGJ5IHRoZSBkZXZlbG9wZXINCj4gPiA+IG9mIHRoZSByZWxl
dmFudCBkcml2ZXJzLg0KPiA+ID4gPiBUaGUgbm9uLWNhbWVyYSBwaXBlbGluZSBub2RlcyB3ZXJl
IG5vdCBkaXNhYmxlZCB3aGVuIHRoaXMgaGFwcGVuZWQNCj4gPiA+ID4gYW5kIHRoZSBwcm9iZSBm
YWlsdXJlcyBhcmUgcHJvYmxlbWF0aWMgZm9yIERlYmlhbi4gRGlzYWJsZSB0aGVtLg0KPiA+ID4g
Pg0KPiA+ID4gPiBDQzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiBGaXhlczogMjhl
Y2FhYTVhZjE5MiAoInJpc2N2OiBkdHM6IHN0YXJmaXZlOiBqaDcxMTA6IEFkZCBjYW1lcmENCj4g
PiA+ID4gc3Vic3lzdGVtDQo+ID4gPiA+IG5vZGVzIikNCj4gPiA+DQo+ID4gPiBIZXJlIHlvdSB3
cml0ZSBpdCBpbiAxMyBjaGFyYWN0ZXJzLCBzaG91bGQgYmUgIkZpeGVzOiAyOGVjYWFhNWFmMTkg
Li4uIg0KPiA+ID4NCj4gPg0KPiA+IEFmdGVyIGZpeGluZyB0aGlzOg0KPiA+IFJldmlld2VkLWJ5
OiBDaGFuZ2h1YW5nIExpYW5nIDxjaGFuZ2h1YW5nLmxpYW5nQHN0YXJmaXZldGVjaC5jb20+DQo+
IA0KPiBZZSwgSSBrbm93IGl0IHdhcyAxMyBub3QgMTIuIEkgZG9uJ3QgdGhpbmsgdGhhdCdzIGEg
cHJvYmxlbSB0aG91Z2guDQoNCk9rYXksIHRoYXQncyBmaW5lLg0KDQpCZXN0IFJlZ2FyZHMsDQpD
aGFuZ2h1YW5nDQo=

