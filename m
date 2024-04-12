Return-Path: <stable+bounces-39256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A808A2676
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 08:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FF51C21311
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 06:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5EA22EE3;
	Fri, 12 Apr 2024 06:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fZI4dfBy"
X-Original-To: stable@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2071.outbound.protection.outlook.com [40.107.8.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DB52D600
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 06:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903096; cv=fail; b=BSpCT1WHesX48hF8UNtBMqKSCZb508MkTrqS4uznetFljMEp1XTwfMsFkIb4BL8wy+244oY2oSXE0LioE1IMOGL4cu6GLz+H8u4cCCaIWOjGydwSCxb0QyC1GfFUjyrAlFmNsjsfpaPBm3Ur4U2q3OuPDvyvfXiZchoziY9LjQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903096; c=relaxed/simple;
	bh=WBV7Xghqvo0Y9mYrDAyshcJ9cSOk96WFt2po5NrEKr0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n2VsRqpSaPlHe/hyNG7K0gxr1lzvWcE5CGHMOe2zNKfmpO0Yp4vGOp0o5oYfqWhsmrj2d0aKl2RJk2XvkTUIfUDt9PCAhtObL2F6d5LNUVDw+7WYUSq9hY5kPFVLUqyfcT0Ud1hckFPL+ePNPWYmqcd2Xi9hcx5j6+RAkepPf14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fZI4dfBy; arc=fail smtp.client-ip=40.107.8.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhmqMVOM+aUPSAz+nGhE9nTEZ5ljmhxoeEk+D04JHOukjQCHqy9AkVga+1OXLKd9U0XGlywiSnc9VaJLV+tYjpG0/oo63A7iR7YQdEBz/4hSeos9/28w2NxpK0vKYXCG4gd+VSuWxNsG98mQiaum7fn/wpaTJNlYWvG39EAsQBgwi7iTpDkJKFOTijf6cOB0ldvmFlFcicFqcj4muQqZ7MIgE/dEpvlzRaTtmL9XQrOs8Sk0Mn5If3tQ7HfCd9RtlNJ+grMZq0oCAaUaCPVFiCkg28pKVxRewRWbmnFGuG0i2dHDAeMdou3uuF5QfnbAJj+EW9GUidCbPfKHWu9rXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBV7Xghqvo0Y9mYrDAyshcJ9cSOk96WFt2po5NrEKr0=;
 b=fzXiJE/v6V86GeSE/PZltV6AeLqesI0MPOtU2O0KfiazP3Tehbpdzaikqocc+UCakSikwUU35/wXNb64/6OK4k2DeJt8CIVpRtXpo0M2qhLqyTA6aot5XXXmdUk2WMvXcGj9S+jc0+3RTIl7KgoOCsj7PBbRYV8c+FAukW0rxY9FphEyz5sK6oyqELN+kebdQhmUJn96QXsswhcBRy/juk7KpdhLMJcLu4sKL3QMMb81PEN0IIHWVhY3cdujEvOD5+esmHWOAZmnlRO/vWvH19EWJg0KWeGC7mJ6TAC/3cUL+iZyBMkv5/fx70uW6tX2q8OKYkW1Xpu70bnhdYrRUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBV7Xghqvo0Y9mYrDAyshcJ9cSOk96WFt2po5NrEKr0=;
 b=fZI4dfByhQrzBficrFA7d9hMh2YkLs9m+oSQLZmxaJOR7VWYmcarIbAAVjrRLG2WyjyRn9BFpvOeKZhywo93zvUEhrXNq1TQ8tMbATwVg77deCceAUEvP5pQJ+vwUs5f4CgUPUFJWlLBFoudOZbMXb3rIdEiKLvkxpj8UIUzZJo=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8325.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 06:24:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 12 Apr 2024
 06:24:51 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Dominique MARTINET <dominique.martinet@atmark-techno.com>,
	=?utf-8?B?5aSn6LyUIOa6nea4lQ==?= <mizo@atmark-techno.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jacky Bai <ping.bai@nxp.com>
Subject: RE: [PATCH v2 5.10.y 1/1] mailbox: imx: fix suspend failure
Thread-Topic: [PATCH v2 5.10.y 1/1] mailbox: imx: fix suspend failure
Thread-Index: AQHajKBqfkufSOy0B0+j4qU7pVWOgrFkKtiw
Date: Fri, 12 Apr 2024 06:24:51 +0000
Message-ID:
 <DU0PR04MB94179F7BE8F69637C4FE21A388042@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240412055648.1807780-1-mizo@atmark-techno.com>
 <ZhjQwnFdm8RCkn9b@atmark-techno.com>
In-Reply-To: <ZhjQwnFdm8RCkn9b@atmark-techno.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8325:EE_
x-ms-office365-filtering-correlation-id: 80384f4d-5a9a-4b7b-991a-08dc5ab942a6
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zXu1MMkMsy/28M/LIfogzcpO7DKTHBwsAc3drVUBRfeiUfdSaDxIKyZYkBBWgJ/dESxuucwF9XCbz2fnLUP8GEnWVrNa/VrSqaR0al/fP+cYhTpjZIICV1zTEMbV/zsRICJJHvP4gYuW6qE8Y1oMTsmfEB+6zkiV+uS2GDks3jwjLcCARPg6HS+1hTqvfAumVkj8HHqbXu5vIjXt5qIXcX2Ctw6Fp8G76KpFVyjAja0umJwu6m7cK7ro0+PJRGOVKcgfqf9MnkBfZB3OyyBrzA3Te8eTcF+g5u/zlLvifJ3djJkXC7mgnMZ79QK3tf18cC81SQchcuAnOYfInB5PQROZaXtxyC1GQAlqU6ePD1MwuhKGJ6ZYHkmm3KDWMBwS5sV+x4lCPRBPPHOnyrAXBL1uqp0yzqHVqPWsYbfc22vx/V+eJIOebUY/Mc/mx2ULO7dP9+lb7kntEtKiZJiJ/Q46/H8i3pcQb/ypZ2UI61E15dRG1ofjwssXIqTlFGwafzSwe9HkViPjMxWB5thrQVzk/75cLICkzdDVpvjxEZH065p38/mAVbxJc0YIjz+wDAVBMbClD87zrNfj4T2MnQSptZHde03d9Os3tA8aCt5aJm+3F6bdADu56EA1a9AsrVOuU6yfFkZG4M3g++fABpBrWlUYyV4PcMKPe6KrB9qFzu0P+CjcN2viPMP+11RNDuhYeapIdriea0sQE2UXcBqbjFnBBrX7Z2qpfaIV2J4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2x5WENiTVd0andUK3BXaHZXOEE4YS9KZzFtTXpDUER4L1Z3RTlzR2ovSXpE?=
 =?utf-8?B?RXRtRGpJdTRCNWhrZ2JoOFVjYWltT0tKc09oTmhXbWNqb0ZZeS9ST3duK1d1?=
 =?utf-8?B?bGJlTGJqWSsyNDVwT2pYVkdJYVpobTMwQjFEWEx3eG1lS1NrQU5QR0hvNVIx?=
 =?utf-8?B?UmNPdFVVa2VRcFkyTkRycFNFODhza2U4Y0psNTBSN2dGcnI0RHcrOTlHc0RW?=
 =?utf-8?B?YkFJY0d6bWtQS0ZQeWQxZDRWUklTeXcxVlFCOGNNczhRNys5aENUdkkzUEZs?=
 =?utf-8?B?T215SXcwbklpa2QwZlhvcDFEejdHa3BPVytUMWZoNHZuMTlHTDZ3MzcwS2ZL?=
 =?utf-8?B?Z2hpMWJPZVhCdHJFTk9pUlpMQlN6VUtxcm4yU09HQVRpdXJSU3NFeU5iUXda?=
 =?utf-8?B?aHlUOWdXZGx3aUxLQWJsalhEWG9odG56cjBSQk1TTjR1RGhtQUdPcVJVaTVX?=
 =?utf-8?B?SWNFVWl6M0VJdHRvL0M2OWw4VU0yMG1pNXJZMm1qMThrelBnbWM2eXNldHlJ?=
 =?utf-8?B?cDl3R0daZjlXSTJBZ0NoSzNlK2ptT29la2s1a0ZUZnkxeW1vS244NTdmaUU3?=
 =?utf-8?B?RmRRa0gyanBpTi8xYWJ5NUFmc1hHUzIwajBZb1ZYUWhkZjZ5MGxKNzRCT1kx?=
 =?utf-8?B?L3pHU0xzcWw3a2xqTlJwdlRjS2xMRUJJeHFUTTZSSHNhT3RtK29XcVpncFRx?=
 =?utf-8?B?VEFzM1ZvbmdDWDBLdlkyMitLRUdicVFRZGsrVEk3WUJaTnYyMDBMTnY1NzBJ?=
 =?utf-8?B?cTlFNlp2L09mZC9XTUpHTVQ4UENZQUdHVXFEZUZHZmo2a2M3ckpyb1FGbTdl?=
 =?utf-8?B?Q2NNeFhrT1RFRm9OUERrTjBIMWh1MDZPSncrSmpZTmQrRGhVVHdVd3dUbis3?=
 =?utf-8?B?b1Q5YXFMV1RidVlSZXhkNHpobVU4SjVoUmw3OTJZMC9zbVQ0QkxoQW1RTWNP?=
 =?utf-8?B?UU02dHR2Z1VwdEhNMFVDL1lFVDhkZ1IxMGFsZ2o5NWprdWd4SXpmZmRwYVlk?=
 =?utf-8?B?SUxsVE1TWXlOOUFWYnhiRTZhcGt1RFM2RFF4SXJ0eXl0UU1VMVh2RytuSFMz?=
 =?utf-8?B?emJuMHlhOEJyNmtDMzFXems1dVFCbVdJekZYaEFTY3Nvb2VTZ3pRYW9rOG9i?=
 =?utf-8?B?Mkd3SWxWOWtyTUJkUUkza09kb0JFNjZYL3BqN1ZEMVEwMFQ1b2d6YWthQXE2?=
 =?utf-8?B?bkRwYmpiK3Nmd0VaZVlHTkpuNTJMQ3JkOFFONmpuWFB4TlJvcDZ5YzVKK2M2?=
 =?utf-8?B?bW54SGJlb3o5NTdOYTNhOFoxTE1iVUt4WWFzZ3V5TW13ZXJ0ZFJIVkhPYjZo?=
 =?utf-8?B?NVdhWkFhaW84L3FrdFFZQVBWY2p2MVNXSmcrWmd3S3Q0cUM0VzhtOXVDam5w?=
 =?utf-8?B?UEtDMWRtMjVtWDdRZVhiZFdPb2hEbC91V3dCNit3UGMzRHNpZlpXNUswM0dB?=
 =?utf-8?B?NjZFT1A5ZUVIU25LUlNTN3FhWDRGTmJlUnJadVZjVThieHp5ZVpua3RsNUdP?=
 =?utf-8?B?MUtCcnIrelZIamFCTHVJVmtlaVBJN3FXVEdqV2s2N1Z1N0ZTbmJBcU5TWk80?=
 =?utf-8?B?QVRBRU0wdTlZSHoxUndjQWs4Z3YweDlLVktPT3g4Wnk3RFRDbFRiL2FnOGxz?=
 =?utf-8?B?d2hEeGxSUDN4MjFTZ2E3ZDgxVWtCMlEvZTNzbGd5b2paR0xZaGpSdVBMTkRO?=
 =?utf-8?B?NUtnTGpUWFBqQUFYdHRNVVFrY1FKeWJrVk1Bc0l4dldIQnNkQllOUjUrMFJX?=
 =?utf-8?B?R1lCSk5aUjBYUFY0ZEE0eGE3ajJlUFNTMTRGcTZxWlV5b1RwYThSSjVKUTlZ?=
 =?utf-8?B?aHV2M3JjbVBYQ1BidjVHR3NybW4xZUs1T2xMbytrWklUc0l1bzRJZEkzNDg5?=
 =?utf-8?B?Z3VBUWpzaXVOSGRVbW4waFpJdjBBTEJCUVFjUlNabFVGWmxtZzIvSXFrZDNC?=
 =?utf-8?B?bTRwYnh1MzVmczhseWtuK2NLV1JWcWd4OGFwNW9lbWpxdUhmUjFrcVlScEMy?=
 =?utf-8?B?MEx4Wm1Yc3pKRzZEbGlLalRyU0g3bUQ1NzFUWkkwTUhMVVc2Y1VmZXRrUjlp?=
 =?utf-8?B?SFNFTWJ3ZnhnU2JKY2NLRytOVlZsdG52UENDcTZnR21BbE4zM0tkMFAwdU5X?=
 =?utf-8?Q?qIPQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80384f4d-5a9a-4b7b-991a-08dc5ab942a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 06:24:51.3030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDcXIi+YwIf8y9ISwgIDg6uNSmZLBe6w8tn8IuB4evCjhSvFjQtLIFxpMqgH2BDAGexRlYQEq7/nolwCekpgGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8325

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDUuMTAueSAxLzFdIG1haWxib3g6IGlteDogZml4IHN1
c3BlbmQgZmFpbHVyZQ0KPiANCj4gKEFkZGVkIENjcyBhZ2FpbiAtIFJvYmluIEdvbmcgYW5kIEph
c3NpIEJyYXIgYm90aCBib3VuY2VkIGxhc3QgdGltZSBzbyBkaWRuJ3QNCj4gYWRkIHRoZW0gYmFj
aykNCj4gDQo+IERhaXN1a2UgTWl6b2J1Y2hpIHdyb3RlIG9uIEZyaSwgQXByIDEyLCAyMDI0IGF0
IDAyOjU2OjQ4UE0gKzA5MDA6DQo+ID4gaW14X211X2lzcigpIGFsd2F5cyBjYWxscyBwbV9zeXN0
ZW1fd2FrZXVwKCkgZXZlbiB3aGVuIGl0IHNob3VsZCBub3QsDQo+ID4gbWFraW5nIHRoZSBzeXN0
ZW0gdW5hYmxlIHRvIGVudGVyIHNsZWVwLg0KPiA+DQo+ID4gU3VzcGVuZCBmYWlscyBhcyBmb2xs
b3dzOg0KPiA+ICBhcm1hZGlsbG86fiMgZWNobyBtZW0gPiAvc3lzL3Bvd2VyL3N0YXRlICBbIDI2
MTQuNjAyNDMyXSBQTTogc3VzcGVuZA0KPiA+IGVudHJ5IChkZWVwKSAgWyAyNjE0LjYxMDY0MF0g
RmlsZXN5c3RlbXMgc3luYzogMC4wMDQgc2Vjb25kcyAgWw0KPiA+IDI2MTQuNjE4MDE2XSBGcmVl
emluZyB1c2VyIHNwYWNlIHByb2Nlc3NlcyAuLi4gKGVsYXBzZWQgMC4wMDEgc2Vjb25kcykNCj4g
ZG9uZS4NCj4gPiAgWyAyNjE0LjYyNjU1NV0gT09NIGtpbGxlciBkaXNhYmxlZC4NCj4gPiAgWyAy
NjE0LjYyOTc5Ml0gRnJlZXppbmcgcmVtYWluaW5nIGZyZWV6YWJsZSB0YXNrcyAuLi4gKGVsYXBz
ZWQgMC4wMDENCj4gc2Vjb25kcykgZG9uZS4NCj4gPiAgWyAyNjE0LjYzODQ1Nl0gcHJpbnRrOiBT
dXNwZW5kaW5nIGNvbnNvbGUocykgKHVzZSBub19jb25zb2xlX3N1c3BlbmQNCj4gPiB0byBkZWJ1
ZykgIFsgMjYxNC42NDk1MDRdIFBNOiBTb21lIGRldmljZXMgZmFpbGVkIHRvIHN1c3BlbmQsIG9y
IGVhcmx5DQo+ID4gd2FrZSBldmVudCBkZXRlY3RlZCAgWyAyNjE0LjczMDEwM10gUE06IHJlc3Vt
ZSBkZXZpY2VzIHRvb2sgMC4wODANCj4gPiBzZWNvbmRzICBbIDI2MTQuNzQxOTI0XSBPT00ga2ls
bGVyIGVuYWJsZWQuDQo+ID4gIFsgMjYxNC43NDUwNzNdIFJlc3RhcnRpbmcgdGFza3MgLi4uIGRv
bmUuDQo+ID4gIFsgMjYxNC43NTQ1MzJdIFBNOiBzdXNwZW5kIGV4aXQNCj4gPiAgYXNoOiB3cml0
ZSBlcnJvcjogUmVzb3VyY2UgYnVzeQ0KPiA+ICBhcm1hZGlsbG86fiMNCj4gPg0KPiA+IFVwc3Ry
ZWFtIGNvbW1pdCA4OTJjYjUyNGFlOGEgaXMgY29ycmVjdCwgc28gdGhpcyBzZWVtcyB0byBiZSBh
IG1pc3Rha2UNCj4gPiBkdXJpbmcgY2hlcnJ5LXBpY2suDQo+ID4NCj4gPiBDYzogPHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmc+DQo+ID4gRml4ZXM6IGExNmY1YWU4YWRlMSAoIm1haWxib3g6IGlteDog
Zml4IHdha2V1cCBmYWlsdXJlIGZyb20gZnJlZXplDQo+ID4gbW9kZSIpDQo+ID4gU2lnbmVkLW9m
Zi1ieTogRGFpc3VrZSBNaXpvYnVjaGkgPG1pem9AYXRtYXJrLXRlY2huby5jb20+DQo+ID4gUmV2
aWV3ZWQtYnk6IERvbWluaXF1ZSBNYXJ0aW5ldCA8ZG9taW5pcXVlLm1hcnRpbmV0QGF0bWFyay0N
Cj4gdGVjaG5vLmNvbT4NCj4gDQo+IE9rLg0KPiANCj4gVGhhbmtzLA0KPiBEb21pbmlxdWUNCj4g
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5jIHwgOCArKysrLS0t
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5jDQo+ID4g
Yi9kcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYyBpbmRleCBjNTY2MzM5OGM2YjcuLjI4ZjU0
NTBlNDEzMA0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJv
eC5jDQo+ID4gKysrIGIvZHJpdmVycy9tYWlsYm94L2lteC1tYWlsYm94LmMNCj4gPiBAQCAtMzMx
LDggKzMzMSw2IEBAIHN0YXRpYyBpbnQgaW14X211X3N0YXJ0dXAoc3RydWN0IG1ib3hfY2hhbiAq
Y2hhbikNCj4gPiAgCQlicmVhazsNCj4gPiAgCX0NCj4gPg0KPiA+IC0JcHJpdi0+c3VzcGVuZCA9
IHRydWU7DQo+ID4gLQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+IEBAIC01NTAs
OCArNTQ4LDYgQEAgc3RhdGljIGludCBpbXhfbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZQ0KPiA+ICpwZGV2KQ0KPiA+DQo+ID4gIAljbGtfZGlzYWJsZV91bnByZXBhcmUocHJpdi0+Y2xr
KTsNCj4gPg0KPiA+IC0JcHJpdi0+c3VzcGVuZCA9IGZhbHNlOw0KPiA+IC0NCj4gPiAgCXJldHVy
biAwOw0KPiA+DQo+ID4gIGRpc2FibGVfcnVudGltZV9wbToNCj4gPiBAQCAtNjE0LDYgKzYxMCw4
IEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQNCj4gaW14X211X3N1c3BlbmRfbm9pcnEoc3Ry
dWN0IGRldmljZSAqZGV2KQ0KPiA+ICAJaWYgKCFwcml2LT5jbGspDQo+ID4gIAkJcHJpdi0+eGNy
ID0gaW14X211X3JlYWQocHJpdiwgcHJpdi0+ZGNmZy0+eENSKTsNCj4gPg0KPiA+ICsJcHJpdi0+
c3VzcGVuZCA9IHRydWU7DQo+ID4gKw0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+
IEBAIC02MzIsNiArNjMwLDggQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZA0KPiBpbXhfbXVf
cmVzdW1lX25vaXJxKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgCWlmICghaW14X211X3JlYWQo
cHJpdiwgcHJpdi0+ZGNmZy0+eENSKSAmJiAhcHJpdi0+Y2xrKQ0KPiA+ICAJCWlteF9tdV93cml0
ZShwcml2LCBwcml2LT54Y3IsIHByaXYtPmRjZmctPnhDUik7DQo+ID4NCj4gPiArCXByaXYtPnN1
c3BlbmQgPSBmYWxzZTsNCj4gPiArDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+IA0K
DQpMR1RNOiAgUmV2aWV3ZWQtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0K

