Return-Path: <stable+bounces-244138-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJNINkHo+WmsFAMAu9opvQ
	(envelope-from <stable+bounces-244138-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:53:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C99A4CDFB0
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56BB23024AAA
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 12:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0CC426EC9;
	Tue,  5 May 2026 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="Rny3PeaR"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012058.outbound.protection.outlook.com [52.101.66.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F6237CD54;
	Tue,  5 May 2026 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985561; cv=fail; b=DJFbX7vxKmvZ6UjScMr3vb//m1i2JCKm3xP7tuAFe9pGEl0Ra3/jxvUL8d/lidNkKROVtdH4Ur9SAXRMYP+SxKw4NXT5q5TBIs69IrlNOZXDAePdukSnyv1cYu/9DavbrrEob6zElZ3mtbgS7g8yFbf7yVGKGYx6I/jLvIw5e8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985561; c=relaxed/simple;
	bh=Nv9bhtcBiD6FTmv3dZZstWApI6nvV9KYnSlNdF5aFkE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=otwfUttZKo65ABOptcNdNDQpXnNly9msnSPEQdnEMCtURCeirQZj3/P4hS5cq6T5iw5YnVq+RXsN1vfRirB0J5C3uB6ICgUe55Vak/CIQJVZn4RpXrgeJiuXwJ7EuoSUlkFYVZO056AmVK+Tt2OvshCmLUtjl8DlEQKyLO7+AP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=Rny3PeaR; arc=fail smtp.client-ip=52.101.66.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/Nzqesg8weAgwtZjw73GtBANldCW7CIquBLt3Sn26i+JfrPnoGOAqEuH+0LxIJLj8GP3oLv+lvqUKNEYQ3WmCxBNvmDTUQoXQFa+9Ka/SJtIbFW2pVduz1qatbljx70MfwWslz6iWzPu1zXAEZWsVPSFvAhM7qbOXrqkwoJLEIRhSvPynrVX3gfDws/H9MEbY7PYrJMNu1gyxIH2vsCcNLhQW0VtRL/6r5RJgcGynqufIKSY3EgILpTUhuXEOtaow7/kIbpNudMLAatqJBXvhJ2QmfHZxKLTzRzUor670hmZTQaXDIZXoBgr1zWF0+dQ5y5uN0B2VkDcif/hmf7WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nv9bhtcBiD6FTmv3dZZstWApI6nvV9KYnSlNdF5aFkE=;
 b=i9T5oYs9vC7Fs5EY2EXWmz/30zNg0ht7eRuhaJqi9/jEpTFy/MUcXZfYEg/YVWedu241EqxqxNiLc9NmaBG4DkVsuYX/Gra8MvDcrSEP4rKV6dp0HWFmjy9NeOggULQ87Kxk/V6ZbFGRq7NXopUFSsIAobltVwO2BN+cp2QdEI8t/YDWXaLLpj06mtc1qU5u1bdqXSEHRo0JVu/hte+xBmORhxQKlkeDHiNdSDl4raVxX/eNvS5kcpMKwtiRvf/E2fOyC0d/VYITMWJ/9PA5uyLHg+G1hX80FfAPQf9wa2TlGbhkoMqYNA0y5ZWum+Qu4ZWkTeksyjLkO0kHXtv1aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nv9bhtcBiD6FTmv3dZZstWApI6nvV9KYnSlNdF5aFkE=;
 b=Rny3PeaRo/ktN9Gk7WQ4yo7hmFjaglWRtfqISXUpye5XQEc6k/4fYRiOKYAu5aJIeThmyW9YnhVNFHGZ76lsliGAfg6/tID40SLrw7/iqe+jbJgjQmOwfCNhDV/5Cv5ErXSz6m+IIlmMyqJ2Wu6D+czd8HhVM5Hqd4QsQx/kxholdMt9xKvu2ZfvLA/PHCeEfXncQ4Mz6LurLmRuEO6uUKrhk9e7efb46TRBcua2vRpE7n2oifM7Qja0jqqWYWMH6aUXy6Ekbej0HuEblfZrLHjqh+tHJA2gmIA1jlmXhEsB6wQhA7AQZwN0wo2ecXIAsNUV2k+s3QvfNqsEmhQrDg==
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:39b::19)
 by PA2P189MB2670.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:40b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 12:52:34 +0000
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4]) by AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4%7]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 12:52:34 +0000
From: Yunseong Kim <yunseong.kim@est.tech>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "sashal@kernel.org"
	<sashal@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Chen Zhen
	<chenzhen126@huawei.com>, Jussi Maki <joamaki@gmail.com>, Daniel Borkmann
	<daniel@iogearbox.net>, Paolo Abeni <pabeni@redhat.com>, Malin Jonsson
	<malin.jonsson@est.tech>, =?utf-8?B?RGF2aWQgTnlzdHLDtm0=?=
	<david.nystrom@est.tech>, =?utf-8?B?Um9sYW5kIEtvdsOhY3M=?=
	<roland.kovacs@est.tech>, "ysk@kzalloc.com" <ysk@kzalloc.com>,
	"42.4.sejin@gmail.com" <42.4.sejin@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.12.y] bonding: fix use-after-free due to enslave fail
 after slave array update
Thread-Topic: [PATCH 6.12.y] bonding: fix use-after-free due to enslave fail
 after slave array update
Thread-Index: AQHc1bj77gFL/C3sNkacAb6ql69PQbX90UuAgAGZQwCAAAFVAIAABL+A
Date: Tue, 5 May 2026 12:52:34 +0000
Message-ID: <898a7348-f15f-4c4a-a5ca-d4900a0db606@est.tech>
References: <20260426201205.465809-1-yunseong.kim@est.tech>
 <2026050435-glider-undrafted-71d7@gregkh>
 <59f615b6-eea4-4186-8e63-d60a57ed7822@est.tech>
 <2026050517-parking-pyromania-70a1@gregkh>
In-Reply-To: <2026050517-parking-pyromania-70a1@gregkh>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8P189MB1752:EE_|PA2P189MB2670:EE_
x-ms-office365-filtering-correlation-id: 795f4193-12f4-4bd2-1a68-08deaaa52d5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 bXlC7IBVBJSTcuE/mZb2ag98a7uLaTdkfwKRKNcLWBCQISUGfEY6xBGZICrIrZZMjhB1WNDjqVnkjkUxanaAVEj9Vsz0yMyLbtwxoZqOorANAkcZwfjEeS7x0liAUbOpgnaKT/X9T1EXOwi74j+gWaFu/pQsm1eXNyYPBXi6UjauywxlPgWuy+eJVg43fFWwptgGeobY1bwip+OlwLqFlOnXcrm524vc3eIp9HNogTN6ylJt5BG8zqfwXY2dlMG/0sw9ogIo2g1eTcqosiBDUmoKwFUzYTVXDWE/vEUR1dyL4ip9A/vO4avWXk89qykLZP2Ja9ogRcO6VCE2AWD+G4Wj84SedmwnuGAnuvKhu+W5yLdqF+hZ8+EMUOwYyIybH4kzUpTOpjGm/PZYqkOU5bwbNcz/+4S+WLah6/b/o40+BjoRvQG97k96h3CSOKpD2n2/WNSXK4bAvjCieqXGyA+oh7lZgbNSStoH/REfIvHMSocC/P9JInrYYzylqr7ltKv2bRJsz9WCWiiC2f8CkBvaMcpa6Ld/sI90hKLu45qe6poKnCjQEjA0p/DxdtVbx6bSaUrYcDzihyIAi85bRPYTDMbryChWTmMDDGyJ7dkjDpmO1b3w1yGQeLNSgj0qEX5hckyU99Vt0LxG5f7adXZvkwyFi5FpZPKL1BTgMhjRU6ORNKwcBYAeDCqeTwBRA6RUrSzxQW8420UXOevwJCtDBlAe810Zgl5kPFCRFa4V55uzAdVRYQaCdut1Pdgp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P189MB1752.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTRYZnY2YmhBZHhIQmV4TUlURDg4UVNIald5VHFmZmEwbFhjUEpDTTZHMUhC?=
 =?utf-8?B?ampzZTBvYXZ6THB4Q2lIcy9LMUxFT3UxWjd1aDgwV1hVblhHRTZQWG56VHVN?=
 =?utf-8?B?VkFHaENuSWhhVFoyZWt6NzlGdVh4R3VaUlF1eE5VR21zRGxvRTJxMUNWKzlp?=
 =?utf-8?B?cTY0VTM1US92Y1kyQzRVZldKMzVCRGlHYUdlWElXYktLYWNRMmVTYWVoWElz?=
 =?utf-8?B?NE5pQ1ZJN0pzMGpHdlpRaC9FSzdyTVVQcmRNTXJsOW04dXU4bkV6YlByUE9J?=
 =?utf-8?B?UTlaWVU5Y3c0Q2FLSVV0d3VLMkNqejJ5YjNDbUd2clFPM2U2UEQ1cjN1OGYw?=
 =?utf-8?B?TGRkQlpIYlpoT0JDU09HbzZ1NS9yaG01QnVZQWNubnVOT1VQZ3lSOWNQRG9u?=
 =?utf-8?B?VmZZU2pWa3hOS2FIRktnYWUyZHhQYS9qcUs3THZrbVZ3UGF5T3c3V1pla3Nk?=
 =?utf-8?B?ZzEwRTh5Z3JIdFZYaHdsenNvZnlVSCs1b0lNclpjREo0UXZqUEF4QllpQkNY?=
 =?utf-8?B?cHJkcjFyVGx2VDdackhhSXFMbjZJTm1PT21WdzFCaDByUDN6dHNWeldYTXUx?=
 =?utf-8?B?ZDgvTndPazNJcjVnUEVMdHhIcUU4K1REbk83RjVSQVFsVmxnNllEU2RJdEQw?=
 =?utf-8?B?MnV5QzBkc3o2cWxjOFpLWng2WmxYSmhwdEFRWVlDcllIbmhMU2VJV2hnazhM?=
 =?utf-8?B?SFAwN21BOGNYWENlb2IyZGVhSmdvaHFNQmY0MTJxdGNVZ011eUE0WEJuOTZ3?=
 =?utf-8?B?TksvRmFTc01sQzd2aUFROUxFdXJhTjhYN09xNmg3a3BWU2VoSGY0WFRsbXRO?=
 =?utf-8?B?R3FxbktlVW5ldlc3Ly9XK2o4dndjREhiV2F4QUE4UDhtRjNlOW53Vlljdll4?=
 =?utf-8?B?MENvWEI4akhqTktib2dUbFRnZ2NLNm00OENyL0NwRDdBblcxRE1kNWVXYWk1?=
 =?utf-8?B?bmxKajlBMEg1TlBSbTNHRjlSdjlNbUdWMHhYRlF2NDlJeTlyRDI1c3Rjc3R1?=
 =?utf-8?B?RC9lV1VURmx3ajRoaGNSN3UremtudUh4a2R0VDB1aFVtY0RmVCtxankwQ29j?=
 =?utf-8?B?djZubGhGcG12eWwzbnVlbEJ0UzRxeHJpNDdlamlOMFNTNkNhcGIwUnVZNEdI?=
 =?utf-8?B?Wm5MSzM1WnIyTUF4bjdmdm02bGovSlZOODZTbXVqRWVLV2dqeHpLYnNjTE04?=
 =?utf-8?B?aUhkbHZidlVrMEtMNmtYZU1BWmpKTjdSMm03MThobnJSK2IrS2JFdVMxSEwz?=
 =?utf-8?B?U01ZSU5nRFgraHlQOGdHcHdNVGhvSHU3V0VLOUNZRitMRGUwUU9uNVBSQTlC?=
 =?utf-8?B?UVhMTXdiUWphbUkzQlgrODI3UVR3cStZZDU0MW5TYjBQUXVudzhybEtPNldS?=
 =?utf-8?B?M2hTcC91a1ZvZnBNNkNXTENtek1qdWJ6SmRFTk5kL1dPdm1tSnZydUFFUENs?=
 =?utf-8?B?Kzgxc25sM1BicVhqUTZMOVFkM2hJVjJFV1lzODFEN1dpU0REWUdQU3dRNkxW?=
 =?utf-8?B?Q2duS084Z1RPUmV6TE45SVpjQWIySnl2RmY1TDdPU0gvRnJ5RlluTzBTcStH?=
 =?utf-8?B?d1lodWFraEh0d0prV0hDL1dlcHpIMlZMdUJYTkp5WWNxN0ZNcW1VYVdWNkt0?=
 =?utf-8?B?SHh3elhJaVNLZXVwdEgxeGJqRWxNemhyaUFMMkFqbTgyOGZFWmNvR0dlZ21y?=
 =?utf-8?B?MTV1SHZITzlKd3hTYTF0WGNqcHY1SXFNQ1NNVU51RUg1VXdhSFpncS9Qdk1X?=
 =?utf-8?B?bXR3MXNrQzhPRUdKd3ZNS2tRVEpJR0owTEdLK3NpZG1qMFdEMjJiR3NHL2xm?=
 =?utf-8?B?T3pJTWQwYzRhY2YxV2FQSXFSRVl5TlBwWUp2N01RdmxTRjFnY0lQK2Vyb0l6?=
 =?utf-8?B?UW5VQW5lQmlhWUxpc2VxMGFZekdGbXlDU2s0bGRsbm9yVHpTcitoODVTVlJp?=
 =?utf-8?B?Uk9vTFJwZWxvalZvS3ZEeHN6U2NFWFU1ZHpJZDlSMWRsbWlSRFpyUElrUUFY?=
 =?utf-8?B?SnBKMExiSGZDWjVjVHFFK2hoZDZWeGo0RTNkRFduaEZXeWxTUmxKc1pxTzFs?=
 =?utf-8?B?aDdhUGRmM1dXbDVFN3VTT2RhTWZrRDhCMmFDOUZENUt3cng5bnhPWGkvMVIw?=
 =?utf-8?B?cWRvTE5Xenk4YWowS3FzMVVUcDVDTHdXSi9PUkhPSk0xTlhMTG1CdzI0UDdz?=
 =?utf-8?B?ZndVbmtNaURraFNOazlHWHNFZmw1RXA1MmQ0em1ZYWp5WkhMQ1QyWmRJem91?=
 =?utf-8?B?bXQ5aDEwRXNqTVlaSVVLcjRzeXoycTdqdm1sa245Z0QySzdLRGQ5SHh0Sjgv?=
 =?utf-8?Q?nLSGA0dsmtrnPc+1hu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F13167D4DA101B40A26803A3FE564E14@EURP189.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 795f4193-12f4-4bd2-1a68-08deaaa52d5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 12:52:34.0250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwEmyvz8ywsp7vlWVT+8uBFCR7Wh7eliWDRbZHeoFYzcQqyq1eSPptq/FGQ34tCXUAwFuj+EBpNq7WgbohI0ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P189MB2670
X-Rspamd-Queue-Id: 8C99A4CDFB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244138-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[est.tech];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,blackwall.org,huawei.com,gmail.com,iogearbox.net,redhat.com,est.tech,kzalloc.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[yunseong.kim@est.tech,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,est.tech:dkim,est.tech:mid,linuxfoundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

SGkgR3JlZywNCg0KT24gNS81LzI2IDE0OjM1LCBHcmVnIEtIIHdyb3RlOg0KPiBPbiBUdWUsIE1h
eSAwNSwgMjAyNiBhdCAxMjozMDo0OFBNICswMDAwLCBZdW5zZW9uZyBLaW0gd3JvdGU6DQo+PiBI
aSBHcmVnLA0KPj4NCj4+IE9uIDUvNC8yNiAxNDowNSwgR3JlZyBLSCB3cm90ZToNCj4+PiBPbiBT
dW4sIEFwciAyNiwgMjAyNiBhdCAxMDoxMjowNVBNICswMjAwLCBZdW5zZW9uZyBLaW0gd3JvdGU6
DQo+Pj4+IEZyb206IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+DQo+Pj4NCj4+PiBJIGRpZCBOT1Qgd3JpdGUgdGhpcyBjb21taXQuDQo+Pj4NCj4+Pj4gWyBV
cHN0cmVhbSBjb21taXQgZTlhY2RhNSBdDQo+Pj4NCj4+PiBQbGVhc2UgdXNlIHRoZSBmdWxsIGNv
bW1pdCBpZC4gIEFuZCBnZXQgdGhlIGF1dGhvcnNoaXAgcmlnaHQgOikNCj4+Pg0KPj4+IHRoYW5r
cywNCj4+Pg0KPj4+IGdyZWcgay1oDQo+Pg0KPj4NCj4+IFRoYW5rIHlvdSBmb3IgdGhlIGNvZGUg
cmV2aWV3LiBJ4oCZbGwgZml4IGl0IGFuZCBzZW5kIGEgdjIuDQo+Pg0KPj4gQWRkaXRpb25hbGx5
LCBsYXN0IHdlZWsgSSBzdWJtaXR0ZWQgYSBmZXcgcGF0Y2hlcyB0byB0aGUgY2hlY2twYXRjaC5w
bA0KPj4gc2NyaXB04oCUY3VycmVudGx5LCBhbGwgYmFja3BvcnQgdGFncyhmb2xsb3dpbmcgc3Rh
YmxlIGtlcm5lbCBydWxlcw0KPj4gT3B0aW9uIDMpIHVzaW5nIDxzaGExIDQwIGxlbmd0aD4gcGF0
dGVybiBhcmUgdHJpZ2dlcmluZyBmYWxzZSBwb3NpdGl2ZXM6DQo+Pg0KPj4gICBodHRwczovL2xv
cmUua2VybmVsLm9yZy9sa21sLzIwMjYwNTA1MTEyMzIwLjM2MjcxNS0yLXl1bnNlb25nLmtpbUBl
c3QudGVjaC8NCj4gDQo+IENoZWNrcGF0Y2ggc2hvdWxkIG5vdCBiZSBuZWVkZWQgdG8gYmUgcnVu
IG9uIHN0YWJsZSBrZXJuZWwgYmFja3BvcnRzLCBzbw0KPiBJIGRvbid0IHJlYWxseSB0aGluayB0
aGF0IGlzIG5lY2Vzc2FyeS4NCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQoNCldoaWxl
IHJlYWRpbmcgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N0YWJsZS1rZXJuZWwtcnVsZXMucnN0LCBJ
IG5vdGljZWQgdGhhdA0KaXQgZG9lc24ndCBleHBsaWNpdGx5IG1lbnRpb24gdGhlIHJlcXVpcmVt
ZW50IGZvciBhIGZ1bGwgNDAtY2hhcmFjdGVyIFNIQS0xIG9yDQp0aGUgd2hldGhlciB0byB1c2Ug
b2YgY2hlY2twYXRjaC5wbCBmb3IgdmFsaWRhdGlvbi4NCg0KV291bGQgaXQgYmUgZ29vZCB0byBh
ZGRpbmcgdGhlc2UgcnVsZSB0byB0aGUgZG9jdW1lbnRhdGlvbj8gSSBiZWxpZXZlICAgICAgICAg
ICAgDQpmb3JtYWxpemluZyB0aGlzIGNvdWxkIGhlbHAgY29udHJpYnV0b3JzKGxpa2UgbWUgOikp
IHN1Ym1pdCBtb3JlIGFjY3VyYXRlICAgICAgICAgICAgICAgICAgDQpiYWNrcG9ydCBhbmQgcmVk
dWNlIHRoZSBuZWVkIGZvciBtYW51YWwgY29ycmVjdGlvbnMuDQoNClRoYW5rIHlvdSBhZ2Fpbi4N
Cg0KQmVzdCByZWdhcmRzLA0KWXVuc2VvbmcNCg==

