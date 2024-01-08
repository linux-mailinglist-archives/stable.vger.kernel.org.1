Return-Path: <stable+bounces-9971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506248268D4
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 08:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643031C21A6B
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 07:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245CB8BEB;
	Mon,  8 Jan 2024 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jH+31zsh"
X-Original-To: stable@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2040.outbound.protection.outlook.com [40.107.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E738F54
	for <stable@vger.kernel.org>; Mon,  8 Jan 2024 07:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RN0cHzC5e+SYTvXnr+ZeUQUx2euAZozb6EJWHMDdyNncS9v1cxRREJCPQRGa/kv8wJAESDojnuvy/+F+lmaWU0dk3RCwZ/CGsHPTZtT171xQqB6tNuRWwV42+uhc7SBHuUN7m6PiVK6af4G5gtXY/XZ9cHh7Zx0LnW2Y/bNyAd/uMufn05aPWYvfHQ8wVGJyRMuYhwpJuCpBU0IsZo+nc7tWHeUm5THga8yrMKAKE2WZRicvEwpiOyabj8JACjdedEt3mKTworyN+q016sCEm1hwd0bIGBys5+6zZkTTsS78u2EAxUUT1K2xc3YfAZxksgBzWdUw/Pb5vjNPjwTLjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KmgCDatBeK9YFFEYY1KmX8QH+LjIUjLPeL9bV17ZLk=;
 b=OSXXHPFZVNq2BX71lW2WmR1fsz+yK7rfd5HVUtJns5j7qHwdqBho162V7dBsFqAfO1JQucslNNXpcVYLTAiPpKjcdxG2+7Npu7D91n7571iTA4q0jKUoW+i3yF7KUWosjCmIC8uYxiA7lpQHyZlvdjroUzZIyop3zEugMvTFiMtlVYvzRhFJnqCXILj4nPt1vvV0o4dr/Y0UsiHemnTCleH/vDwdB2pHjamCXfaolsmL+VxlcGR9cbpmnhMZZNYdPgXHZGySrojFq8wLJMZI2fPiRefZrQGkZEq6KU5ZUYD7U3YmZYCKD7kvZNURNElbuXMkV4JxUAz6w3XX9U3lGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KmgCDatBeK9YFFEYY1KmX8QH+LjIUjLPeL9bV17ZLk=;
 b=jH+31zshPWUCZvySroslGtvOSnKvSZu9jHV4/lsDjkb6gNt4EguFlhmTe//p63FbztmEtAghgJ6pww0hn4NRS1kCR/RB09ygm9U9/ihw+k3n56gux5jGJxklFS5Kxw0muwX8Ft1l0dZK9gLCECSwPMacWlhJpGQ/EhV+EkyvQu87LHbtKNyUtfIT/MHAIx7txLnmB4B2DsrSRul2M0LmJ/agBuR73hXGuZ9o6ItwoT5FbR625xeKGZZ/TMZJXA0ZZYEqM2s9H2QEaeJmbIZ03WSBDt2sMzDU5t3KZWZbSTKuu5anUbWATpOkesIIOcXIN8RybGBlo/+Fke/9P7hq8g==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS4PR10MB5175.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4c3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 07:44:43 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f4e3:6357:166f:b46b]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f4e3:6357:166f:b46b%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 07:44:43 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "murray.mcallister@gmail.com" <murray.mcallister@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/vmwgfx: Keep a gem reference to user bos in surfaces
Thread-Topic: [PATCH] drm/vmwgfx: Keep a gem reference to user bos in surfaces
Thread-Index: AQHaM/tKkd8VIUwQ1k6Kbnjv8zrezrCzkCuAgAKAtoCAGCHIgIABcnSA
Date: Mon, 8 Jan 2024 07:44:43 +0000
Message-ID: <52dcc8ba45912a30d4fd7bd781e43aac4929fd78.camel@siemens.com>
References: <20230928041355.737635-1-zack@kde.org>
	 <db8ba4d9d99c946b4649ba64abaf20fed16a0bc6.camel@siemens.com>
	 <CABQX2QP60W6HqZxUjCkRfM=nD+YvoKqMBh-YkCEVjFCtf-cSdA@mail.gmail.com>
	 <CAHHj=uKqapiFZUd2iJRy9bYK0EBa5UvJ8rMEhKXyyBxPsbFPZA@mail.gmail.com>
In-Reply-To:
 <CAHHj=uKqapiFZUd2iJRy9bYK0EBa5UvJ8rMEhKXyyBxPsbFPZA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS4PR10MB5175:EE_
x-ms-office365-filtering-correlation-id: 05464468-9152-4e5e-1a77-08dc101dad8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zf6M2PbC/d93sQgwuwkajoUC/0DLyBEcbIvaGdwpo7uE+V8yx7Rd9O0VDYEma0N+4gDiTdn6IzOYJ/BoiZ2MPkUPojGileEWNY3B9vHk6ctVH6zfTGPj3fCts2AbqBoo3QZdTb3db7j7NEno+LVsNjn1yOenM5S0mzkB4nM874QYMDapbN/2l8pcOy8zK1Bl0EPlHJh6aoYkdoUNbwU5qHNQH8jymLEOAR6m9D1V9cJGvK/RP35dUqCXSUGg1Y+RyKETR8CKXDWSg1nRG9SmCtgvm9Z6oaAgQ27IcY0qoeYObhBFpFiTT2bL8fYdnRCCIMBHHRZuZiWTP5Rtk3+NI3baFhcjMTyzZf8tdUSlAXM7JnzzLdpqLIkEeiXjv39vzu1UMjv3lNjDAo4KlvDKvM1FNoDkMHv6SGMlEqDuWEnOMBkENboYEdI6m1zUWFwQCRX6eaD4Z7giQlkXT0+KhRbO8xf9EZeZ0WiMLfwvdayvCdCWjedLDL6NdNqqAgM0EGJ97f6HdkkI+PdvBhg0eAjqJ0TbZObxliQvnf1XezsrmXsJ24Q42eavPZHkkHDRduLS//NhSxu8A2dfs306swiVhRWJfvKOrKvpCHOXHRKPBD1dFnT/tzUQsXbQnzvAs/fYIR8t0esjZUFFqge627mjPOLydvtUVDIByOvYEnkSszaiOU2fE7KduzAUweRd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230173577357003)(230273577357003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(26005)(2616005)(71200400001)(478600001)(966005)(6486002)(6506007)(6512007)(83380400001)(5660300002)(2906002)(41300700001)(64756008)(66446008)(66476007)(66556008)(76116006)(316002)(91956017)(8676002)(110136005)(8936002)(38070700009)(66946007)(38100700002)(122000001)(36756003)(86362001)(15974865002)(82960400001)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cWdQbk5UZnNGWTIvdnA4Q0M4bHdtZmRieFlwN0dKOGpDckIxTGVLVVgvdWF2?=
 =?utf-8?B?VDFKYloreWtjdzB5aUdEK1JRVGVIRkp3aDlOTzFmOEs5amYzU3JOQzc1MHVF?=
 =?utf-8?B?TEg4Vzdxd1NIWVRWNktBQmNxSFlramEwajZCQjFGT0NJdUVlbUttKzFyUU5v?=
 =?utf-8?B?a1lsVDNxZ0IxSzEyd1dpNFRtWFdsZHdSSUZ2RWtWYStZaFQvSFFHZ3lWc3d6?=
 =?utf-8?B?by9FYTRQWGtHenlWL2ZzcENKZ0dNYnU3Z1FvV1dtTDVmZDhseDc2U2hSSitY?=
 =?utf-8?B?bGtRbXpleEE3SUxRNXR6bFFadHNHcHRZOEtkZzZ4MFU5WXpNY3AzUVJZc0FM?=
 =?utf-8?B?VzNBRVNJcXJnc0NTMlNZdGliSDBiWEFuOEdUbkZPRG1leklURlNDUUVaeC9n?=
 =?utf-8?B?Zm5CVmtCSEIvUXVab3lpbHJUcGhlRUIySXFGTGxCY2d4VmlNd1hHYitjMW52?=
 =?utf-8?B?MnZSSzZCYVgwV2lWMHJ6dzZWTTF5YzNiZWVUVmJKaUdTUkcrc3RuUDA4aGxJ?=
 =?utf-8?B?ZjEwWUdIWGFVdHVkaEcyUExPeEhPNXBqVXpNWS9hUCtPUVIyanV6amtDWmFV?=
 =?utf-8?B?T0QzMTBFb3VMSCsvVUxDVUhWc25iZU9jM20vS1VpakNsb25nSUtKUU9BRE9P?=
 =?utf-8?B?SU54QjlOUUc2R3pEZ1NOR0kxMGlUb0JvdXoyQ2Vtd2lxVVNFM3VDVElNNXp3?=
 =?utf-8?B?MVVqR1dadk1GNzZJeEVjUlFqbFdSZE1mSlIzQ0xDTnFPT256cWRIL0UxdjBY?=
 =?utf-8?B?VkhyLzVoVjdXMGduWDJZTDRtU3V6dk9LRHlPWEVjYWhjanlSMzRNQXlSWms3?=
 =?utf-8?B?eU5yaDQxUXV6a1F5OXV0T0RuV1dwcG02Y0hPWC9mT2J2cHlOSGpXRlhjMWhR?=
 =?utf-8?B?MFZld2UrS2MrbUFzRVhYRzNpcU8vVXVhTWprMG9DbUJSZWY3WE1NWFpwZHlp?=
 =?utf-8?B?RTFlQURtT3JxZDBTaHVId0I2NHozcEsvbEsxaDFEV1c1YUF0ZmtnaFpTMUp3?=
 =?utf-8?B?OUd5Qy9KZVljUGJISVA3TEJNVFYwZDZXVGRVZ3ZHZzBHdS9wMFU2QXpXcXls?=
 =?utf-8?B?akJzUDlvZ2loSjlHaGNrQ2dYK1o3SUw1cWl4TWJaMTJ6REdMMzczTHNLcldQ?=
 =?utf-8?B?a29yUlYyVi9jZkJPcjJrbWJ4VlU0RDVnMkJqcGZrUWxtM2QzbCt2cjIrYnBp?=
 =?utf-8?B?dytwS0l2U1NNSmtSTzhpeCthVmZmbUQ2NFJGai90UEZEdHpOakRmLzZkTi9U?=
 =?utf-8?B?bjArMXRqNTIrcEVWdm5IRzkvWGIzU2tEQzNoUEdOVWp0bllpdzBYU0oyZ0Jv?=
 =?utf-8?B?L1N1MGRqS3B5WGFSekJvVG00eWxhTFR0NE9ZU3hZRmd2QXVGYUxheXRJNVhV?=
 =?utf-8?B?eFA0NTJZMUpaL2wxSHBZVWpJbXllQysrV0RBT29sMm1DaFlUVHFWOEtaN0tZ?=
 =?utf-8?B?N1g2SE1SRXNjalN1TlFmd0FuVmZ6dVFiVThwdjlmNVRlZ3BlR0J6UW4zc1p0?=
 =?utf-8?B?cG5Jbit0aWczMnUzdFU2NGFYc3UrUG5MZ2FXL2thcThPamdBWkNCR24xUVNO?=
 =?utf-8?B?VGliZ2FDRkdXRmRCSEVqeVdPWmNVTGlPQ1pGb3BjcHV2endoMHBCcExXeHQx?=
 =?utf-8?B?NUErNFEzSFF5TGhQUjlSYWljVGxlajhsUnorSUlaNitXN1JoUXRQSjlOUHNZ?=
 =?utf-8?B?NnQ1eUhkSGhIOWtVQytqcm1xcEJwYThuNFNyUnVXcis3bFNMRitsYm41a3J2?=
 =?utf-8?B?czdaWmtYWE1Ed3hIZmZQeGJ4VWtjVnRISjVjUjdWQXJrMThVYlBMVk1mNndO?=
 =?utf-8?B?OXEzTndlMTRxTGpBN2Q1WmtlQ2JIL2ZaWjBTdVA1L1NldzZhVTM1MHp5RzJG?=
 =?utf-8?B?RkFQK3lxWURoUFBqMUUyd0RlVmZiMldibTVCaENlTHcrUFNrZHhsUUgwRXpF?=
 =?utf-8?B?OC9nQlN6bzFWVitHcm1ibVdseFdrSzlMVEI1VWNHVGVwbWx5Nlg2NW5KV3Z2?=
 =?utf-8?B?MDNGa1NxaHlHMUx3ZXJXUk9jYUFUdFZXYXRTaW14QVliTFJnNlh0Ukl5eGNI?=
 =?utf-8?B?aXhlKzBJNlBGOVJhUzRoQUdnd0NraVg4eG5XQmZQYzc5cHFXNFpDcTFQc2V4?=
 =?utf-8?B?NSt6Rnk5MnRIaFpCVFJDQVpGZ2ZVYi9DdEV6QmtWVG56anZPNUFDREoyNWNi?=
 =?utf-8?Q?KUkYeXAjii1QkFvCVhpC7i4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F84ECA73E3D2C44C912985DD69453BEB@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 05464468-9152-4e5e-1a77-08dc101dad8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 07:44:43.1125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eAaV9/8uKpijXs5c7Vuhjilre2NK7sZ6mUrecgEatGdaGgX49UAMIFW4+rVmMWXtYYj1L25hFcZvy6z6LPyC8ZuXBLN3+JX2JRLQlNvoJjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5175

SGVsbG8gTXVycmF5LA0KDQp0aGFua3MgZm9yIGxvb2tpbmcgaW50byB0aGlzIQ0KDQo+ID4gPiBP
biBUaHUsIDIwMjMtMDktMjggYXQgMDA6MTMgLTA0MDAsIFphY2sgUnVzaW4gd3JvdGU6DQo+ID4g
PiA+IEZyb206IFphY2sgUnVzaW4gPHphY2tyQHZtd2FyZS5jb20+DQo+ID4gPiA+IA0KPiA+ID4g
PiBTdXJmYWNlcyBjYW4gYmUgYmFja2VkIChpLmUuIHN0b3JlZCBpbikgbWVtb3J5IG9iamVjdHMg
KG1vYidzKSB3aGljaA0KPiA+ID4gPiBhcmUgY3JlYXRlZCBhbmQgbWFuYWdlZCBieSB0aGUgdXNl
cnNwYWNlIGFzIEdFTSBidWZmZXJzLiBTdXJmYWNlcw0KPiA+ID4gPiBncmFiIG9ubHkgYSB0dG0g
cmVmZXJlbmNlIHdoaWNoIG1lYW5zIHRoYXQgdGhlIGdlbSBvYmplY3QgY2FuDQo+ID4gPiA+IGJl
IGRlbGV0ZWQgdW5kZXJuZWF0aCB1cywgZXNwZWNpYWxseSBpbiBjYXNlcyB3aGVyZSBwcmltZSBi
dWZmZXINCj4gPiA+ID4gZXhwb3J0IGlzIHVzZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBNYWtlIHN1
cmUgdGhhdCBhbGwgdXNlcnNwYWNlIHN1cmZhY2VzIHdoaWNoIGFyZSBiYWNrZWQgYnkgZ2VtIG9i
amVjdHMNCj4gPiA+ID4gaG9sZCBhIGdlbSByZWZlcmVuY2UgdG8gbWFrZSBzdXJlIHRoZXkncmUg
bm90IGRlbGV0ZWQgYmVmb3JlIHZtdw0KPiA+ID4gPiBzdXJmYWNlcyBhcmUgZG9uZSB3aXRoIHRo
ZW0sIHdoaWNoIGZpeGVzOg0KPiA+ID4gPiAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0t
LS0tLS0NCj4gPiA+ID4gcmVmY291bnRfdDogdW5kZXJmbG93OyB1c2UtYWZ0ZXItZnJlZS4NCj4g
PiA+ID4gV0FSTklORzogQ1BVOiAyIFBJRDogMjYzMiBhdCBsaWIvcmVmY291bnQuYzoyOCByZWZj
b3VudF93YXJuX3NhdHVyYXRlKzB4ZmIvMHgxNTANCg0KW10NCg0KPiA+ID4gPiAtLS1bIGVuZCB0
cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0NCj4gPiA+ID4gDQo+ID4gPiA+IEEgbG90IG9mIHRo
ZSBhbmFseWlzIG9uIHRoZSBidWcgd2FzIGRvbmUgYnkgTXVycmF5IE1jQWxsaXN0ZXIgYW5kDQo+
ID4gPiA+IElhbiBGb3JiZXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBSZXBvcnRlZC1ieTogTXVycmF5
IE1jQWxsaXN0ZXIgPG11cnJheS5tY2FsbGlzdGVyQGdtYWlsLmNvbT4NCj4gPiA+ID4gQ2M6IElh
biBGb3JiZXMgPGlmb3JiZXNAdm13YXJlLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWmFj
ayBSdXNpbiA8emFja3JAdm13YXJlLmNvbT4NCj4gPiA+ID4gRml4ZXM6IGE5NTBiOTg5ZWEyOSAo
ImRybS92bXdnZng6IERvIG5vdCBkcm9wIHRoZSByZWZlcmVuY2UgdG8gdGhlIGhhbmRsZSB0b28g
c29vbiIpDQo+ID4gPiA+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyB2Ni4yKw0KPiA+
ID4gDQo+ID4gPiBEbyB5b3UgcmVtZW1iZXIgdGhlIHBhcnRpY3VsYXIgcmVhc29uIHRoaXMgd2Fz
IG1hcmtlZCA2LjIrPw0KPiA+IA0KPiA+IFRoYXQncyBiZWNhdXNlIHRoYXQncyB0aGUga2VybmVs
IHJlbGVhc2Ugd2hlcmUgdGhlIGNvbW1pdCB0aGlzIG9uZSBpcw0KPiA+IGZpeGluZyBmaXJzdCBs
YW5kZWQuDQo+ID4gDQo+ID4gPiBXZSBzZWUgdGhpcyBvbiBEZWJpYW4gNi4xLjY3ICh3aGljaCBh
dCBsZWFzdCBoYXMgdGhlIG1lbnRpb25lZA0KPiA+ID4gImRybS92bXdnZng6IERvIG5vdCBkcm9w
IHRoZSByZWZlcmVuY2UgdG8gdGhlIGhhbmRsZSB0b28gc29vbiIpOg0KPiA+IA0KPiA+IFRoZSBv
cmlnaW5hbCBoYWQgdG8gYmUgYmFja3BvcnRlZCB0aGVyZS4gSSdsbCBhc2sgc29tZW9uZSBvbiBt
eSB0ZWFtDQo+ID4gdG8gY2hlY2sgdGhlIGJyYW5jaGVzIHRoZSBvcmlnaW5hbCB3YXMgYmFja3Bv
cnRlZCB0byBzZWUgaWYgdGhpcw0KPiA+IGNoYW5nZSBldmVuIGFwcGxpZXMgb24gdGhvc2UgYW5k
IHRoZW4gd2UnbGwgc2VlIHdoYXQgd2UgY2FuIGRvLiBJbiB0aGUNCj4gPiBtZWFudGltZSBpZiB5
b3Uga25vdyBhbnlvbmUgb24gdGhlIERlYmlhbiBrZXJuZWwgdGVhbSBzdWdnZXN0aW5nIHRoaXMN
Cj4gPiBhcyBhIGNoZXJyeS1waWNrIG1pZ2h0IGFsc28gYmUgYSBnb29kIGlkZWEuDQo+ID4gDQo+
ID4geg0KPiANCj4gSGkgQWxleGFuZGVyLA0KPiANCj4gSSB0aGluayB0aGUgYmFja3BvcnQgbWln
aHQgYWxyZWFkeSBiZSBvbiBEZWJpYW4ncyByYWRhciBmb3IgeW91ciB2ZXJzaW9uOg0KPiANCj4g
aHR0cHM6Ly9zZWN1cml0eS10cmFja2VyLmRlYmlhbi5vcmcvdHJhY2tlci9DVkUtMjAyMy01NjMz
DQoNClNvcnJ5LCBteSByZWZlcmVuY2UgdG8gRGViaWFuIHdhcyBpcnJlbGV2YW50LCB0aGUgcGF0
Y2gtdG8tYmUtZml4ZWQNCmlzIGFjdHVhbGx5IGluIHRoZSB1cHN0cmVhbSBrZXJuZWw6DQoNCiQg
Z2l0IGxvZyAtLWdyZXAgImRybS92bXdnZng6IERvIG5vdCBkcm9wIHRoZSByZWZlcmVuY2UgdG8g
dGhlIGhhbmRsZSB0b28gc29vbiIgdjYuMS42Nw0KY29tbWl0IDBhMTI3YWM5NzI0MDQ2MDBjOTll
YjE0MWM4ZDViNTM0OGU1M2VlNGYNCkF1dGhvcjogWmFjayBSdXNpbiA8emFja3JAdm13YXJlLmNv
bT4NCkRhdGU6ICAgU2F0IEZlYiAxMSAwMDowNToxNCAyMDIzIC0wNTAwDQoNCiAgICBkcm0vdm13
Z2Z4OiBEbyBub3QgZHJvcCB0aGUgcmVmZXJlbmNlIHRvIHRoZSBoYW5kbGUgdG9vIHNvb24NCiAg
ICANCiAgICBjb21taXQgYTk1MGI5ODllYTI5YWIzYjM4ZWE3ZjZlM2QyNTQwNzAwYTNjNTRlOCB1
cHN0cmVhbS4NCg0KU28gaXQgd2FzIG1lcmVseSBhIGhpbnQgZm9yIFN0YWJsZSBUZWFtIHRvIHBp
Y2sgdGhlIFN1YmplY3QgcGF0aCBpbnRvIHY2LjEueC4gDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJk
bGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

