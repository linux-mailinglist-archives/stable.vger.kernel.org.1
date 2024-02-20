Return-Path: <stable+bounces-20830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC13385BF1A
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 15:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1681C23161
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 14:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1F66BB38;
	Tue, 20 Feb 2024 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KT5kDyBF"
X-Original-To: stable@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1B74C60
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440546; cv=fail; b=iLBC41ROyelhrSKposqeQUrtZ/yE2USBGERG43oTggxuLKhixY82xNrUmYxyDZTMd7CcvDmTtK2FXvvzUluoLJZpYSaG2FEcmKIdc9CAf8QNsVvFONNxtNBL37Kehq+KIw00KY1H2fjsieJeXICEW8+X3MnfrjpApL/sdBpQo7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440546; c=relaxed/simple;
	bh=8CQ5XwJXKTLQweQax85QKXx9o+ZeyUeu6jdv+QfRkNw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VNlHOdVvy8uzFTQ7DpvXqrAaBO/SWbxv1jjjM1wXVJ22IDjSE1s+NUcbyHV8meRDbom4nWC1X8SWf8EYV2d/Y8FjCfcxzGAg1jpAirdJFiTqZdaz/cD+pMn1JF8V1p5Fb/DxQoJgDWVj34c6CAK11cHd+VWRwG3qQIPy9obR+kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KT5kDyBF; arc=fail smtp.client-ip=40.107.6.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeCI8w3sdhs1EWRDdIiz18yueOui96ptQysmT+LQbs3kckCrikjzzzsIkg7t82BteEguorMxYyrZrDVEnCTgW0xhGvv2yQS62wbjs8RTWHUt4wtmXVoA76AumjEnz/BK29QELU0Q5jBo5ZXUI/J9NHjTZUTgxmjXxY6aHGfMRF+gs1ykfhA+8y0t7Hs1p6fHFcXvZrwKHfY9r4TlItzCU0h5cv7UwAUv84v08K2AnWCGq61oB1QyRHcu4Mk3w9iUmg9vemUKjHclth1zCyHr82dWQNhPpx8mIW6XQrxji6K068yvecDMX9YVDXuBfr3an2SU2QKwpgd5+Yd7+9XiHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CQ5XwJXKTLQweQax85QKXx9o+ZeyUeu6jdv+QfRkNw=;
 b=a/9CLqzT5PR4YScJF7maHiI8wRe1jC6pbCB0hxoGTxYnsTfahepNGYXDoqtgV1d0j3dovTCQ4H0OhTX9iGQF5G/hCGPR3dKx4QOQXLxsbk469NufsZTuxzFrIngYEnDJOgN5+iGdJwDAk4Mbt1rrJOt5rUkkp6E648EHUn1Q9MqcdRzyRPLz71mbFyFvzi6/GF7Zx3U3ogKtSSbj2q7ZYxjKarWWxehhpO+eU2EuLPYydByEOkHLXkeiG30fmHS1wEhE1yGOQWh/kk47WMryfMY8LPiYVuscGBehAOUPX+FCZnF6CFcSUvZK8Q2d9g5tDIQzpVPeZ09DeAXEs5JYUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CQ5XwJXKTLQweQax85QKXx9o+ZeyUeu6jdv+QfRkNw=;
 b=KT5kDyBFArOZL96KiBqowbuh6UG2mXe+Ytra2vlGuSsoDDW9T3RQA6iwlV1fZn7+cWHSt+gvyETHvi/Ezo7dLq9nlHk4jcCYs4r4sUVY1gCIgR0fnNOpILtwrSqOv+4MCxSk3XDV3S6dohG4rvmfRDzF+Q9dwe2KVbd6FqSKd1Lgp+QUr0xHxqkWbGYeAPZYXTfOZ3nvuU5OfNss328JY9zGulKTysjmlnzqYsVqojs0tjtE9cAs3ubzhZ73djY2NKtio/+clUIJaXJzCRP1SozNramcxYScAi17Wjx1pe3M2Nk6p4wL+VlmuAbEsbcAUrKl4X9YH5q3XqvozA38NA==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DU0PR10MB7286.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:446::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Tue, 20 Feb
 2024 14:49:01 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 14:49:01 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "dave@stgolabs.net" <dave@stgolabs.net>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>, "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>, "Ivanov, Petr" <petr.ivanov@siemens.com>
Subject: Re: [PATCH v2][5.10, 5.15, 6.1][1/1] hrtimer: Ignore slack time for
 RT tasks in schedule_hrtimeout_range()
Thread-Topic: [PATCH v2][5.10, 5.15, 6.1][1/1] hrtimer: Ignore slack time for
 RT tasks in schedule_hrtimeout_range()
Thread-Index: AQHaZAmlLW9vfp4W80eK9ACR2FEOurETT8yA
Date: Tue, 20 Feb 2024 14:49:00 +0000
Message-ID: <89eef284bd0fb1f60dbfc62decd2a0438d436c6e.camel@siemens.com>
References: <20240220123403.85403-1-felix.moessbauer@siemens.com>
	 <20240220123403.85403-2-felix.moessbauer@siemens.com>
	 <2024022057-slit-herself-a4d8@gregkh>
In-Reply-To: <2024022057-slit-herself-a4d8@gregkh>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DU0PR10MB7286:EE_
x-ms-office365-filtering-correlation-id: f9044054-7ab9-4bcd-ea7a-08dc3223132d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JxbAqstd1ncad5GmWt1H31LgKDEDD+fYmTqG5KsfGfHG3peNSMXB+xLBFaeckJ1mjYgjFUGSnRwSfaL95JGKKPyihTqFgw20nPF5N2A6Dcg8/seZP/Yll3AgDmi9g/pPxYZvq3ow0sp7OGFcua9HNthL/6lE/w4pEk3pC3Gfjl4C6eVRrNM1S4NioysgvwUtWo1VWzym+32ll27XYuQN6T/n8IDHrV/WmqfKpxHrHimoqgKVykJ7XJZVb1u+vae5a73uG4hAq7pfbi0ZLPPVOkYuLYXg1mu6YH9+/RxwED1Jc46ibS1Toi+jg9cA/nCENFLlObncKqyYnS22LprxQpkM5tSkd5c1ChAYUXqqBsTi07vzrkL4pxVbsiTkYJK96jqB5wbEgwlIqhBLRWO8VQj4/4Cmjnm4LNxXoAT/mAaatSAly9I6flk2zp+baYfKzn8c8j56I8tnitMb3S1B/1CmJqGG3/kEU/iaxcJOf3rgR6axGuyJM69lmJZYLCJ5uS+9S0hBnZaWGJWqjv5D2yGoHAEpDWrqS1fpw/LWRB7OMLwz7gydZ6Y71B8sck7v5OsZMo+wN9Wx4BWANfRv7194XeE1OmDQ75Ckdz0yWeY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?LzVMYWFRVm9pYU1NOTVCZTJWeEVYMStMSjJsODZMVERURXAvVFdzQ25qN1J4?=
 =?utf-8?B?TUI2alplUk83WTZka1JmYkxoMkZLV3BueUFWZXI4R1FGY2dELzA0ZFh4dlp6?=
 =?utf-8?B?Mk9QMGwvUGF6dzF3YkwwMW9SY2lHNWpBUWUrWG9YMDl3eXE0cTZxbDVWbVQv?=
 =?utf-8?B?Z2hNc1gyMTNoUUpkaHRNUGMydGExcHRDdW1ucTN6bFk2Z1didU00ZHVqZUll?=
 =?utf-8?B?YmpsWEdYNHViUmh4VnZ4MTlvbncrait6bEYrTDhGQ05PK0VPVGdHb21Mc1JQ?=
 =?utf-8?B?UFdocTBOb3BNVzJrNDQvTEpid0RRNVJuVFQvSlVBZTVobFhLdERGZzBoTm9B?=
 =?utf-8?B?bnM0VFVsVWFyRHhTdzJjdjQ3THZab0FhKzk5ODE3Qm9jbzRadU1kcWdYb0l0?=
 =?utf-8?B?SlFNSzhlaGFnb2RYZ0d1WU9uZ3JtcmhidTlQa0lWTmU5a05aQnZLdkFQRnJN?=
 =?utf-8?B?UGlGUHBHZnU1UnZCMnU3enNpSExLbTZIQVNGS2RCWDZwY2kzc3VieFpJdmpJ?=
 =?utf-8?B?WWxsSGo5NitvanVwaU8wS2ViQlE3K0ZGQm1namFFaSt1ZjQ4V1pxMlFSazFx?=
 =?utf-8?B?dnUwSTFkeWhYaU9vN1BWbm13RHhKZjBzSVNUeCt0U3lrcU1tNW8wczRUVStW?=
 =?utf-8?B?UnRDcHU3TVd4a2x2SnVGellKWkhNWWxKOFlzejc4dEhFU043d3U5a3BIcDNl?=
 =?utf-8?B?dVFPODVsVmpFNlgzSDdUazJqMWNoS1JzWWJHNmhqQXROK25pVmU5TlA0QWlQ?=
 =?utf-8?B?a21CQUZuS1F1dERDUklzYS9VakVyVnJ3cUJyK2VXQUpmbWVtZUF3aC93MTly?=
 =?utf-8?B?Mkw1RTd2TDFXYXhkNmZOUUlLbU5udDE0Um91SmF2NmYrVTRjWUZ4Y2RiVWZN?=
 =?utf-8?B?VFNNZlNHMlM5a0hQdDlaSGQyVGs4YUtuZnFYWHd3dTIzQXgzNWtOREo0NzNm?=
 =?utf-8?B?UmdHNlVUZGNVWUJya3Rhb0FQRzFqWitkNjE3QnpoVDlVZlAyQjljclQ5TDIz?=
 =?utf-8?B?em1MblNsdFE1aHV5d25HeVVIWXpCRkFKUk5oSk1YRWd2Y1VzR1VrQWFIdVpz?=
 =?utf-8?B?TDhxeFJyR3oxaDA3Z3VRdWJkYzN4S2lZeE9RcGh4d2dKU3FyeGRTWitwMy9F?=
 =?utf-8?B?N0RYb3lndHZONnhId21rMVRDQ0FuKzNXcWdqSDFWeW9mREYyRVA2OU5pNC9x?=
 =?utf-8?B?Tm1nM3hRZGhHajhpY1VhOHZQTElqcXRIdDFEOGZaNzlZV21iWSswc1hlVTFt?=
 =?utf-8?B?UjdqS0JFamFrNUY5N0NQSVNDcmt5NDJRcThpeUpFNXF1SElvVWlIcUo5aVpS?=
 =?utf-8?B?L1B5WktZZ2hLUFp1UjdkeGYvdEZEajVMRlZJOXhGVWxsS043OUJFR0tmR0E4?=
 =?utf-8?B?TURkR1hZU0hMZ1I2SmoyNVFiWEFNNEpKdVdyTG9TOVc4NDU5UHNZWnBEZU5Q?=
 =?utf-8?B?QTlHR2hDU3hWNVo0aGpxQTNleGNlT2NUU1BIYjV5NVAxQjR2L3h4VVQwSi93?=
 =?utf-8?B?cks1TU0xNTg2UFNUM0dKbE9WejVwOWQrVWhIOFdzR3BlbzRqUS9EQnEvbnYv?=
 =?utf-8?B?TkFJSXJ2bnhyNFlYbzJLek5rbWRrZ0xCSVJQTGpXaForS0Via0s2SHNqUksv?=
 =?utf-8?B?dWxuaGlQUFhWTzBpWDNwenhsY1dNaFZPamw1WHVlcXFBU0laUW5jSEoycUNN?=
 =?utf-8?B?ZWZGUVZYQ0RzZlppQWNnODNOKzFWSGdRd2ZPM2lEaVdUbVhMVGMzenQzUDFE?=
 =?utf-8?B?bnMxYkkyQnlScmIvWHNLRFZxYXlPaGpuVUwyZVk0aGNIN0pwcXcyank0S05m?=
 =?utf-8?B?NlEvQkJLSmtJUWJEYVNrYlNqWVBPVVBzcnBkQWFEcU9jaHVnR0RuL0pha0hm?=
 =?utf-8?B?L0F5bFBvSEFtWllCdDI4RjFYSFpRTmV5aDMreEszWjQyb3BnTStqVWlxM1lE?=
 =?utf-8?B?eHdoVlVwaHVkVjArYW5zMGxPUWVvdDg3Y3liQVIvZU9EWXZmcDVBSnRQczRn?=
 =?utf-8?B?c04vdHd0TDZBeHpzVXpsdytWZVJNWG11RUllUkJMTDY3Lzl0NHdhS0pPK3ZG?=
 =?utf-8?B?VVE0K3VSNmRWc3Fhd3RUcGJZSVRHU1EyNzNuaVNJZFltRFZSWm5iakFPQi9B?=
 =?utf-8?B?WkcxZG84WlVxTXZlakVuRmNMZFZyYnlqa2N3a0prT1Q5YnhMMzAwSjRudkxQ?=
 =?utf-8?B?bjhJdlNBMmUrSXpaQVZTRGRPZVJ4d2Q4UFhOUHlJcUszTkl6cDYrV2Z2Z3Zp?=
 =?utf-8?B?K3plZHdNc0NScWxSMU1mbGpnV0RnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3F5B9C58D478F448E44D7F8ACF1C88B@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f9044054-7ab9-4bcd-ea7a-08dc3223132d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 14:49:00.6544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9hSx3FkbIrNo4LG3REJaHhbC+DSJ09BoYVWZL1k5pNcJXNRLw0Sbp5skXTwv01N4G3kKF1qWn7yT/jMULo6VGPi89YAXGdgiFx3M3Pn8xOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7286

T24gVHVlLCAyMDI0LTAyLTIwIGF0IDE1OjMyICswMTAwLCBHcmVnIEtIIHdyb3RlOg0KPiBPbiBU
dWUsIEZlYiAyMCwgMjAyNCBhdCAwMTozNDowM1BNICswMTAwLCBGZWxpeCBNb2Vzc2JhdWVyIHdy
b3RlOg0KPiA+IEZyb206IERhdmlkbG9ociBCdWVzbyA8ZGF2ZUBzdGdvbGFicy5uZXQ+DQo+ID4g
DQo+ID4gY29tbWl0IDBjNTIzMTBmMjYwMDE0ZDk1YzEzMTAzNjQzNzk3NzJjYjc0Y2Y4MmQgdXBz
dHJlYW0uDQo+ID4gDQo+ID4gV2hpbGUgaW4gdGhlb3J5IHRoZSB0aW1lciBjYW4gYmUgdHJpZ2dl
cmVkIGJlZm9yZSBleHBpcmVzICsgZGVsdGEsDQo+ID4gZm9yIHRoZQ0KPiA+IGNhc2VzIG9mIFJU
IHRhc2tzIHRoZXkgcmVhbGx5IGhhdmUgbm8gYnVzaW5lc3MgZ2l2aW5nIGFueSBsZW5pZW5jZQ0K
PiA+IGZvcg0KPiA+IGV4dHJhIHNsYWNrIHRpbWUsIHNvIG92ZXJyaWRlIGFueSBwYXNzZWQgdmFs
dWUgYnkgdGhlIHVzZXIgYW5kDQo+ID4gYWx3YXlzIHVzZQ0KPiA+IHplcm8gZm9yIHNjaGVkdWxl
X2hydGltZW91dF9yYW5nZSgpIGNhbGxzLiBGdXJ0aGVybW9yZSwgdGhpcyBpcw0KPiA+IHNpbWls
YXIgdG8NCj4gPiB3aGF0IHRoZSBuYW5vc2xlZXAoMikgZmFtaWx5IGFscmVhZHkgZG9lcyB3aXRo
IGN1cnJlbnQtDQo+ID4gPnRpbWVyX3NsYWNrX25zLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IERhdmlkbG9ociBCdWVzbyA8ZGF2ZUBzdGdvbGFicy5uZXQ+DQo+ID4gU2lnbmVkLW9mZi1ieTog
VGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+ID4gTGluazoNCj4gPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMwMTIzMTczMjA2LjY3NjQtMy1kYXZlQHN0Z29sYWJz
Lm5ldA0KPiANCj4gWW91IGNhbid0IGZvcndhcmQgb24gYSBwYXRjaCB3aXRob3V0IHNpZ25pbmcg
b2ZmIG9uIGl0IGFzIHdlbGwgOigNCg0KT2ssIHRoYW5rcyBmb3IgdGhlIGluZm8uIEknbGwgYWRk
IHRoZSBzaWdub2ZmIGFuZCBzZW5kIGEgdjMuDQoNCj4gDQo+IEFuZCB0aGlzIGlzIGFscmVhZHkg
aW4gdGhlIDYuMS41MyByZWxlYXNlLCB3aHkgYXBwbHkgaXQgYWdhaW4/DQoNCkkgY2FuJ3QgZmlu
ZCBpdCB0aGVyZSBhbmQgYWxzbyB0aGUgY2hhbmdlIGlzIG5vdCBpbmNsdWRlZCBpbiBsaW51eC0N
CjYuMS55IG9yIDYuMS41My4gVGhlcmUgaXMgYW5vdGhlciBjb21taXQgcmVmZXJlbmNpbmcgdGhp
cyBwYXRjaCAobGludXgtDQo2LjEueSwgZmQ0ZDYxZjg1ZTc2MjVjYjIxYTdlZmY0ZWZhMWRlNDY1
MDNlZDJjMyksIGJ1dCB0aGUgImhydGltZXI6DQpJZ25vcmUgc2xhY2sgdGltZSAuLi4iIHBhdGNo
IGRpZCBub3QgZ2V0IGJhY2twb3J0ZWQgc28gZmFyLg0KSSBhbHNvIGNoZWNrZWQgdGhlIHNvdXJj
ZSBvZiB2Ni4xLnkgYW5kIGNvdWxkIG5vdCBmaW5kIHRoZSByZWxhdGVkDQpjaGFuZ2UuIFdoaWNo
IGNvbW1pdCBleGFjdGx5IGFyZSB5b3UgcmVmZXJyaW5nIHRvPw0KDQpGZWxpeA0KDQo+IA0KPiBj
b25mdXNlZCwNCj4gDQo+IGdyZWcgay1oDQoNCi0tIA0KU2llbWVucyBBRywgVGVjaG5vbG9neQ0K
TGludXggRXhwZXJ0IENlbnRlcg0KDQoNCg==

