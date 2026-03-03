Return-Path: <stable+bounces-222856-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID1fAl/Cpmn3TQAAu9opvQ
	(envelope-from <stable+bounces-222856-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 12:13:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 996D41ED89E
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 12:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2610D304B9BB
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 11:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997D43D6CBD;
	Tue,  3 Mar 2026 11:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=genesyslogic.com.tw header.i=@genesyslogic.com.tw header.b="KUAk1IaR"
X-Original-To: stable@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022133.outbound.protection.outlook.com [52.101.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C94B21770B;
	Tue,  3 Mar 2026 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535647; cv=fail; b=G4drjkFS0FK6W9VEpbJbL08INWBcxYIiIe2KY7MpIaZW4Ec3Cbg1L4ijkVChddzU5m4KLN5QcPkk5spTVp6/2FKb/npZ7eAixUqJ6yc6jlETD4F01+uX7xcV58BWjKJjy4ljfO/BPYb+TXnv/Ip9es01VwA44BgUnhk2KQ6VPi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535647; c=relaxed/simple;
	bh=P/WMXZcX2PN6+deo7Y8/+Ta3fNm6SRqJojyAmlDs1o0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nMYzPo2EVH7NJAdyS3PaotE/CyncaOCXlUbKwpQk62xuQ1ZdpFpaczxhRKffn7QpQVZq3eyTzVHqVNyNJWZtEAZlfqseG6mUp3u1/b5xl5NT0fSYPsiFqOkPSH0lb4oKAn1BZhUb8S39wm0m0JVjg+KMazdm/xRdN7T6jt9py4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=genesyslogic.com.tw; spf=pass smtp.mailfrom=genesyslogic.com.tw; dkim=pass (2048-bit key) header.d=genesyslogic.com.tw header.i=@genesyslogic.com.tw header.b=KUAk1IaR; arc=fail smtp.client-ip=52.101.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=genesyslogic.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genesyslogic.com.tw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnqnR82uOjMFFpqCO71pNy9XSmMSLcbO4677N3DVVCuAkso8xcRSjJLSr7N9EfwFcgK62jP5wsOB7TiBYar+rXSZs/iZNXDVzIDMvr9mm1p+UYSnwMZcO3vr1it6qeb3kri+6Lf8EkIpsHnT3AtPsMXu3GSdRQ4xCdh0w2uzW+thtF1Ma+XNnf97M8s460hX4EAFHzxBGzMHefA3iLWve7xzxSFcHiAvoK5fbb88bgZJLokF+nB9iQ2P2ucBvdibjn6hiL2DquHNMV1snlLVA1g3VuxR3JtTFhOXZl1CE/kR7PQzgsv1MFfF5dynLmWXnexMD3OLMh9pVtKwBh2kRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/WMXZcX2PN6+deo7Y8/+Ta3fNm6SRqJojyAmlDs1o0=;
 b=PRyjYZZWLejhuCZN1PMLN3I1rQzRkWj7dASB+KAE5XZmx+Kgpp/KZyNnmNWj3g7kbdJscLBUmV9YGf51vjOvOnG8ewa69db4ZLSSEiOhf4gNqT01N10WSRRZjBNMzfcBNCykPFwwMT72CKkPI2T6NE8m8/1nEp6TrhxsG/HDYHqG0NdFsw1Rb22BnXrBOy6gcktQYB9p1fonAQBbXn7n8EOPZqQxVqYtMytbPSPv7kC1lKihBwKqg/dZEK7nWUpJYFtL1Cyo+qxkbuAHjjHy2CH7Gjj9zNO+1DnP5VPxStD8Cjl6gcCQhSG05VDL+K1z8wYP2YJEK2AvUYeAuwER3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genesyslogic.com.tw; dmarc=pass action=none
 header.from=genesyslogic.com.tw; dkim=pass header.d=genesyslogic.com.tw;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genesyslogic.com.tw;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/WMXZcX2PN6+deo7Y8/+Ta3fNm6SRqJojyAmlDs1o0=;
 b=KUAk1IaR0j4Jpp7NqihqeScyYOmc/icSWxmbK3ND16mM7Qh1/XcwbtG/AWUU28VpJz8wHy9hCwIbW9SkNP2Dy1mriw+XaaiizjZTRLOh/+PcZZZPGscKbmW7iHdRBA1fMeZx1ZSJkVhnY+RLU0cthCcaqupOqMJ5HiTAtnB3IptnV9TZoZGH+fiaqVwtSKfpGXBdKDRO9nIuf9cxKSk4dW3waBs8NJw88+0grmSuo21T14pgFMfS0cMDCWmpdGR5ue0kwHwc2b6vuepHSkiA02A2vGOSzYHsHvG/6+ojRhjQV9dNgzSnR0qZ1TqLHi9zjLY77PVHKETxVZagRjuRxQ==
Received: from TYZPR01MB4260.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c0::6) by JH0PR01MB5608.apcprd01.prod.exchangelabs.com
 (2603:1096:990:d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 11:00:35 +0000
Received: from TYZPR01MB4260.apcprd01.prod.exchangelabs.com
 ([fe80::7c4:a145:8415:c272]) by TYZPR01MB4260.apcprd01.prod.exchangelabs.com
 ([fe80::7c4:a145:8415:c272%4]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 11:00:35 +0000
From: =?utf-8?B?QmVuQ2h1YW5nW+iOiuaZuumHj10=?=
	<Ben.Chuang@genesyslogic.com.tw>
To: Matthew Schwartz <matthew.schwartz@linux.dev>, Adrian Hunter
	<adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] mmc: sdhci-pci-gli: fix GL9750 DMA write corruption
Thread-Topic: [PATCH v2] mmc: sdhci-pci-gli: fix GL9750 DMA write corruption
Thread-Index: AQHcqoiyREv4HXIVOE6GD8FpY0jUe7Wcn7/A
Date: Tue, 3 Mar 2026 11:00:35 +0000
Message-ID:
 <TYZPR01MB4260E79BC01902C664C79BDED77FA@TYZPR01MB4260.apcprd01.prod.exchangelabs.com>
References: <20260302210717.1159159-1-matthew.schwartz@linux.dev>
In-Reply-To: <20260302210717.1159159-1-matthew.schwartz@linux.dev>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genesyslogic.com.tw;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR01MB4260:EE_|JH0PR01MB5608:EE_
x-ms-office365-filtering-correlation-id: c9911345-c717-4c11-cfcb-08de791418a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 wSJIl9qYqnAanJIUmlSUUXbp7eGQsuXIetp0nQpfAIl4RZuFy4ceJ9DBIoW8pIXwhMOPW5jsJFlavE9/OBIyUKK4LWvkiSHXTqBMoHd1OPHgLAUqcpTsYhX069QGihGo+ZTdRDgnoMmaS7RTS14oFhFM0ykAcNDwqOeLmqVnLb6rvmWFo6Wmd7X1MDz9RvjR06KjlQ5OA5AEw4fUMBxFFCCuAM0DtPNKa5YmVgbpMr3eKjpo5UC/nNyLm9uqibgaoZoupy2fz//3UZeSsI1O3ymMAvhylfys2ZMj3xjdQIM7BjaSQGnsl8jWCGCr7Jl6Wgzd7V9rYw2EpqcTNHUw4I/gnp7ZQ7ONSDdJRpcbodUAFnLxGWR8oLV3pBSg5Vgsgjw5Cc8mEjlETXj7LvShmprhbouqv/fOlABlbC8jII/gsJUj1Flq42F+xH1U+MasEdoSuDQSJVCFKdXm4Qgi1M28x1JRifMqqH1o/aWOg4ZzBcj9pvDVjNAPawcoErvpeWBpKQJZUGMrsIEQgP9Jq97fI0i8qS4QwBcNE7UspRW3xUN3Q0+AoCLl8huMB/L7Q8rKtaYKPzvrgp83N5Rt1UbUOH0H2+JAZq+wCmBu9vBMhVtB27qWWwf3YiaHxry9Oz5q14dPNI4guvaTpWXglKBp6gxYxqh0xPUGc7FPDCkhh7l5PeMGMUqMQCCrCT89hrZ2tFCutcSHsb/meS7MrRkLaq0YPieT5CeCV4FopfaoUhLspMU6n3ZmE/NER2TfroBjcWOXCjCVhNgi4LWy3+T2DJRwSiuSiRKk+iJJ0Ns=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR01MB4260.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2NOZW5TQnJpeEp5bm5VS1hhUW9YWWNQSnBYUkxlUUpTYUsvNEcwOTdvMVkw?=
 =?utf-8?B?SWNKcXI3MWxhWEEyd3ExeXZvbnR0SHRZeUh0enZOMmRHYW00N1B0eGRvTVRp?=
 =?utf-8?B?bHQvc09mZnd4cWxBNGM0WXJNVC93alhCZldaK1ZORnV2S040Q2VzODlKT21u?=
 =?utf-8?B?OEVMUlpKOTl1M3RYTEdiT3B4RE0rbmtKSnVhdjg0b2FZZW5lVlh2K3BUejho?=
 =?utf-8?B?enliL2szZWRLMVhvUm8xQzhIZFM0a2lxQ1B1RUg2S1pwY29jUjdLS2RrdjQv?=
 =?utf-8?B?NmNqdzhiM0tpWWlwV0ZiSUprZzE4L1lVcDhSQ1hySGNud0xRV2o4ZTQzYXhl?=
 =?utf-8?B?RTRSR0dDVmw1MmdrbXVqeTlnNXlvSDZkM0JPbEcwYkc2SHRxWmJoRExkS0RR?=
 =?utf-8?B?dlUva3YzRFRsTk1Sb0EyTjZwSnF0REhOWjNQWXYxRURiSkpjSHZWN0hIa2JK?=
 =?utf-8?B?ZGFzcTk0WlRvUEJ0SDJKRXgvOHZlbUp4RFRxeEFxcWsxRW9KQ0YxRitLMkpo?=
 =?utf-8?B?dzg2V3lLTFVhemd3S0tMQzNzektaSkZDRU1JRnFic3dkWGxYZjRHRCs1OWlU?=
 =?utf-8?B?eFV5MmRtZzZzaFl2UUFNUlNkc1p0Z2dkVURidVRzSVZQOVYvYytwTGVVQk81?=
 =?utf-8?B?bmgxNURiTTc5aTQvUXY5endHYUdUV2crYVh3Tmx1bW9Fb1BSckFIamF3dzZw?=
 =?utf-8?B?Qk9ITkduT0NIazZucWFsdTdFZS85aXdEa0VHemVwUWdRczZ3RnhlTSs4NjJT?=
 =?utf-8?B?RGZvRnV4QUgxU2Nsd2o3VW5NQWtvSFFZd3ZzVUtlcXJkajViM3h2ZkJ5QnlY?=
 =?utf-8?B?VVhaQkExMUk0V0tlRWszZ2NYMUtoT1g4V0hGNUQyZ004RUY4cnd6Qk9vRGVF?=
 =?utf-8?B?YlkrbVNUYUViZjNIWURnSGRZMjhQWEFOS0lCK3JhYVNSKytva0h2SDl1bVNF?=
 =?utf-8?B?c0ZodkZtTW5jNjhHUTlFOGVxZHoya1BxVVhGYXcvblhVRXlTMnBHaitNckxH?=
 =?utf-8?B?emY1UVQ2MXQzajM0czlVcEMwVWxXQTZ5ZmFoQ2ZkY3VkTW4xZzJEOVBIMklk?=
 =?utf-8?B?bTRqaER2anIrV2FOK1VDZ1IzNlZpT01nUy9mYmZ2NDJuMTEwbjhSbERvaGZs?=
 =?utf-8?B?bUNHRXJUcDRuMFBiUGZNQnFHZ2psK25qVGNicEV6MzAzM0Y5Z2tMdE9lM0U5?=
 =?utf-8?B?OWt6WTVLQ2g0NTVadjdVSms3SDVrL0pLWHphMTFWWmxvdVNRVGtMam14Z1Ax?=
 =?utf-8?B?eGVhcGdHZmZ5Y09jcnJES2ozYzU3MVJWZ2dHRmlHUFVuYUwzNmlBVjVSUUxD?=
 =?utf-8?B?TCswMGVWSmp3R25WQ2NBTnhoWkQwd2Z0TmRZOEpHK2toa2NBZ05Qd0NOUUV5?=
 =?utf-8?B?SnRDc0lJQkhKV01hWGNnOURjWDF5cmhxRWt0RVg0a1FCYlpwdk1vZWhoc01D?=
 =?utf-8?B?aThWaUZDUU1aNmlEbWlPMngyVjNhVmliNFVvM0c2Vk1ab1pUeDRHVXFDNUto?=
 =?utf-8?B?VUZGWmpKTnJLTms5bWJEY2c1QXFHN3lhSU5HdkZaWTVpZHJ2d3lQeGQrd3F1?=
 =?utf-8?B?TVh5OG5XbnRCVkpPcCtIaFBlTmorTmhMajdEUTJmeUpuYTl3b1VWcVNNS0py?=
 =?utf-8?B?VjZUV1h3NTFJSTFEbHppODNiZUxCSnQrcDRzZkZSclQ2QXZDbnpQblJ0RFNP?=
 =?utf-8?B?b2psSldWVVdYK0RlSzh4OE5MeTlqZUNCNXFXbmh1OHFualArQ0JuTkxVTi81?=
 =?utf-8?B?OXNmRUFwanlJWEFlOUVxQTdMcUNZVnNqRDI2RXFlRzVyZ0ZTbFVhT211cHh4?=
 =?utf-8?B?Rm5hVytCR2o3RnErRXRvNFZtVHBQRXdHNkdxVk0zMTkxTUxDemxYRFo2S0F6?=
 =?utf-8?B?U1RueUJMRjZoZHd4VEVXMXhscXVmQ3ZacUprNzcvVmxCaWJIYmV4NDk2UHg2?=
 =?utf-8?B?UStIMFNuanNOV2t1M2RPa2F1RTV6V001SmdjYmQraTRlemxiWEg0ZHJ6MDU4?=
 =?utf-8?B?YjFISk9NNkdha2kvclBVdW5BRzNocUwvUktjTklheE51M3R3dkNLclA0NnZn?=
 =?utf-8?B?d3c1UmQ2REdLVGJ5MkRvN3ZZTGs5YWFFTkJPQVFoa2ZCQU5adnlSblpOVXFn?=
 =?utf-8?B?MDJNSTVzL2VybTZBVjd4RmNici9rZXhzWjNtZTlhYzBMQWJWNk50V1FxV04z?=
 =?utf-8?B?Nzg1OHJTamR6NFdhQ3VRKzlqMEtydW5OdzJwTWV5cEdWVm1jWU13V1JDT2dt?=
 =?utf-8?B?Z0JrOVRuM2RCdUtoSEZGVGRFQmRDaVJpRlBoYnl1akd6RDJWVCtkWExzUW1P?=
 =?utf-8?B?Y2M3L3NyVzhCaWxwMVhBNWxobkJWZHdzeHZvOTlOL09BbGFJc3BXK1JMS3c0?=
 =?utf-8?Q?djtJax+8bdFstAeY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: genesyslogic.com.tw
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB4260.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9911345-c717-4c11-cfcb-08de791418a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 11:00:35.2925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e753840-bf6b-40a1-9645-185818deeb52
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jiDwJT2JQ/kcay4f4SDpF8XE4ueQSmEBuemt/V06RKAEt+G8WmWLvvIOKCELiwn8ylE+qP37a65N8L+bMuVdPdhSUzC48yjH8fpOVG0ZewA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5608
X-Rspamd-Queue-Id: 996D41ED89E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[genesyslogic.com.tw,none];
	R_DKIM_ALLOW(-0.20)[genesyslogic.com.tw:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222856-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ben.Chuang@genesyslogic.com.tw,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[genesyslogic.com.tw:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[genesyslogic.com.tw:dkim,genesyslogic.com.tw:email,linux.dev:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linaro.org:email,intel.com:email,TYZPR01MB4260.apcprd01.prod.exchangelabs.com:mid]
X-Rspamd-Action: no action

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWF0dGhldyBTY2h3
YXJ0eiA8bWF0dGhldy5zY2h3YXJ0ekBsaW51eC5kZXY+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNo
IDMsIDIwMjYgNTowNyBBTQ0KPiBUbzogQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRl
bC5jb20+OyBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47IEJlbkNodWFuZ1vo
jormmbrph49dDQo+IDxCZW4uQ2h1YW5nQGdlbmVzeXNsb2dpYy5jb20udHc+DQo+IENjOiBsaW51
eC1tbWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBNYXR0
aGV3IFNjaHdhcnR6IDxtYXR0aGV3LnNjaHdhcnR6QGxpbnV4LmRldj47DQo+IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIHYyXSBtbWM6IHNkaGNpLXBjaS1nbGk6IGZp
eCBHTDk3NTAgRE1BIHdyaXRlIGNvcnJ1cHRpb24NCj4NCj4gVGhlIEdMOTc1MCBTRCBob3N0IGNv
bnRyb2xsZXIgaGFzIGludGVybWl0dGVudCBkYXRhIGNvcnJ1cHRpb24gZHVyaW5nDQo+IERNQSB3
cml0ZSBvcGVyYXRpb25zLiBUaGUgR01fQlVSU1QgcmVnaXN0ZXIncyBSX09TUkNfTG10IGZpZWxk
DQo+IChiaXRzIDE3OjE2KSwgd2hpY2ggbGltaXRzIG91dHN0YW5kaW5nIERNQSByZWFkIHJlcXVl
c3RzIGZyb20gc3lzdGVtDQo+IG1lbW9yeSwgaXMgbm90IGJlaW5nIGNsZWFyZWQgZHVyaW5nIGlu
aXRpYWxpemF0aW9uLiBUaGUgV2luZG93cyBkcml2ZXINCj4gc2V0cyBSX09TUkNfTG10IHRvIHpl
cm8sIGxpbWl0aW5nIHJlcXVlc3RzIHRvIHRoZSBzbWFsbGVzdCB1bml0Lg0KPg0KPiBDbGVhciBS
X09TUkNfTG10IHRvIG1hdGNoIHRoZSBXaW5kb3dzIGRyaXZlciBiZWhhdmlvci4gVGhpcyBlbGlt
aW5hdGVzDQo+IHdyaXRlIGNvcnJ1cHRpb24gdmVyaWZpZWQgd2l0aCBmM3dyaXRlL2YzcmVhZCB0
ZXN0cyB3aGlsZSBtYWludGFpbmluZw0KPiBETUEgcGVyZm9ybWFuY2UuDQo+DQo+IENjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnDQo+IEZpeGVzOiBlNTFkZjZjZTY2OGEgKCJtbWM6IGhvc3Q6IHNk
aGNpLXBjaTogQWRkIEdlbmVzeXMgTG9naWMgR0w5NzV4IHN1cHBvcnQiKQ0KPiBDbG9zZXM6DQo+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW1tYy8zM2QxMjgwNy01YzcyLTQxYw0KPiBl
LTg2NzktNTdhYTExODMxZmFkJTQwbGludXguZGV2JTJGJmRhdGE9MDUlN0MwMiU3Q2Jlbi5jaHVh
bmclNDBnZW5lc3lzbG9naWMuY29tLnR3JTdDNjFhMzJjNDQyNWNlNGNkMzUzDQo+IDg3MDhkZTc4
OWZkMjEzJTdDNGU3NTM4NDBiZjZiNDBhMTk2NDUxODU4MThkZWViNTIlN0MwJTdDMCU3QzYzOTA4
MDgyNTAwMDk0NTU5MyU3Q1Vua25vd24lN0NUV0ZwYg0KPiBHWnNiM2Q4ZXlKRmJYQjBlVTFoY0dr
aU9uUnlkV1VzSWxZaU9pSXdMakF1TURBd01DSXNJbEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lUV0Zw
YkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJQ0KPiA3QyU3QyU3QyZzZGF0YT1NRVNFTGNPMGxjZ1Y3
Z3pEMGd1VEEyWmlEVThoVDZFY1dEVkd6dDdTJTJGUGclM0QmcmVzZXJ2ZWQ9MA0KPiBBY2tlZC1i
eTogQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IE1hdHRoZXcgU2Nod2FydHogPG1hdHRoZXcuc2Nod2FydHpAbGludXguZGV2Pg0KDQpSZXZp
ZXdlZC1ieTogQmVuIENodWFuZyA8YmVuLmNodWFuZ0BnZW5lc3lzbG9naWMuY29tLnR3Pg0KDQpX
ZWxsIGRvbmUuIFRoYW5rIHlvdS4NCg0KQmVzdCByZWdhcmRzLA0KQmVuIENodWFuZw0KDQo+IC0t
LQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIE1vdmUgR01fQlVSU1QgcmVnaXN0ZXIgZGVmaW5lcw0K
PiAtIENsZWFyIFJfT1NSQ19MbXQgaW4gZ2xpX3NldF85NzUwIGluc3RlYWQgb2YgZ2w5NzUwX2h3
X3NldHRpbmcgdG8gc3Vydml2ZSByZXNldHMNCj4gLSBMaW5rIHRvIHYxOg0KPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1tbWMvMjAyNjAyMjcwNzU5MDkuMw0KPiA4NjAxODMtMS1tYXR0
aGV3LnNjaHdhcnR6JTQwbGludXguZGV2JTJGJmRhdGE9MDUlN0MwMiU3Q2Jlbi5jaHVhbmclNDBn
ZW5lc3lzbG9naWMuY29tLnR3JTdDNjFhMzJjNDQyNWNlNA0KPiBjZDM1Mzg3MDhkZTc4OWZkMjEz
JTdDNGU3NTM4NDBiZjZiNDBhMTk2NDUxODU4MThkZWViNTIlN0MwJTdDMCU3QzYzOTA4MDgyNTAw
MDk5MTQzNiU3Q1Vua25vd24lN0NUDQo+IFdGcGJHWnNiM2Q4ZXlKRmJYQjBlVTFoY0draU9uUnlk
V1VzSWxZaU9pSXdMakF1TURBd01DSXNJbEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0ls
ZFVJam95ZlElM0QlM0QNCj4gJTdDMCU3QyU3QyU3QyZzZGF0YT1HN3ZFOXV2ZFBXSGFkVjM4T3VD
TVREcDhLTlc1ckhjZCUyQlBId2t1SGZlbDAlM0QmcmVzZXJ2ZWQ9MA0KPg0KPiBDaGFuZ2VzIGlu
IHYxOg0KPiAtIFVzZSB0aGUgcHJvcGVyIG5hbWUgZm9yIHRoZSByZWdpc3RlciBmaWVsZA0KPiAt
IExpbmsgdG8gUkZDOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tbWMvMjAyNjAx
MTcyMzQ4MDAuOQ0KPiAzMTY2NC0xLW1hdHRoZXcuc2Nod2FydHolNDBsaW51eC5kZXYlMkYmZGF0
YT0wNSU3QzAyJTdDYmVuLmNodWFuZyU0MGdlbmVzeXNsb2dpYy5jb20udHclN0M2MWEzMmM0NDI1
Y2U0Yw0KPiBkMzUzODcwOGRlNzg5ZmQyMTMlN0M0ZTc1Mzg0MGJmNmI0MGExOTY0NTE4NTgxOGRl
ZWI1MiU3QzAlN0MwJTdDNjM5MDgwODI1MDAxMDM1MzMwJTdDVW5rbm93biU3Q1QNCj4gV0ZwYkda
c2IzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQXVNREF3TUNJc0lsQWlPaUpY
YVc0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lzSWxkVUlqb3lmUSUzRCUzRA0KPiAlN0MwJTdDJTdDJTdD
JnNkYXRhPU5zT2NmZEhza29iaCUyQmEzQlNBWmF2czFFNnVLdGcwU2sybGJWaSUyQnZSTHUwJTNE
JnJlc2VydmVkPTANCj4gLS0tDQo+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBjaS1nbGkuYyB8
IDkgKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBjaS1nbGkuYyBiL2RyaXZlcnMvbW1j
L2hvc3Qvc2RoY2ktcGNpLWdsaS5jDQo+IGluZGV4IGIwZjkxY2M5ZTQwZTQuLjZlNDA4NDQwNzY2
MmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcGNpLWdsaS5jDQo+ICsr
KyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcGNpLWdsaS5jDQo+IEBAIC02OCw2ICs2OCw5IEBA
DQo+ICAjZGVmaW5lICAgR0xJXzk3NTBfTUlTQ19UWDFfRExZX1ZBTFVFICAgIDB4NQ0KPiAgI2Rl
ZmluZSAgIFNESENJX0dMSV85NzUwX01JU0NfU1NDX09GRiAgICBCSVQoMjYpDQo+DQo+ICsjZGVm
aW5lIFNESENJX0dMSV85NzUwX0dNX0JVUlNUX1NJWkUgICAgICAgICAgIDB4NTEwDQo+ICsjZGVm
aW5lICAgU0RIQ0lfR0xJXzk3NTBfR01fQlVSU1RfU0laRV9SX09TUkNfTE1UICBHRU5NQVNLKDE3
LCAxNikNCj4gKw0KPiAgI2RlZmluZSBTREhDSV9HTElfOTc1MF9UVU5JTkdfQ09OVFJPTCAgICAg
ICAgICAgICAgICAgIDB4NTQwDQo+ICAjZGVmaW5lICAgU0RIQ0lfR0xJXzk3NTBfVFVOSU5HX0NP
TlRST0xfRU4gICAgICAgICAgQklUKDQpDQo+ICAjZGVmaW5lICAgR0xJXzk3NTBfVFVOSU5HX0NP
TlRST0xfRU5fT04gICAgICAgICAgICAgMHgxDQo+IEBAIC0zNDUsMTAgKzM0OCwxNiBAQCBzdGF0
aWMgdm9pZCBnbGlfc2V0Xzk3NTAoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpDQo+ICAgICAgIHUz
MiBtaXNjX3ZhbHVlOw0KPiAgICAgICB1MzIgcGFyYW1ldGVyX3ZhbHVlOw0KPiAgICAgICB1MzIg
Y29udHJvbF92YWx1ZTsNCj4gKyAgICAgdTMyIGJ1cnN0X3ZhbHVlOw0KPiAgICAgICB1MTYgY3Ry
bDI7DQo+DQo+ICAgICAgIGdsOTc1MF93dF9vbihob3N0KTsNCj4NCj4gKyAgICAgLyogY2xlYXIg
Ul9PU1JDX0xtdCB0byBhdm9pZCBETUEgd3JpdGUgY29ycnVwdGlvbiAqLw0KPiArICAgICBidXJz
dF92YWx1ZSA9IHNkaGNpX3JlYWRsKGhvc3QsIFNESENJX0dMSV85NzUwX0dNX0JVUlNUX1NJWkUp
Ow0KPiArICAgICBidXJzdF92YWx1ZSAmPSB+U0RIQ0lfR0xJXzk3NTBfR01fQlVSU1RfU0laRV9S
X09TUkNfTE1UOw0KPiArICAgICBzZGhjaV93cml0ZWwoaG9zdCwgYnVyc3RfdmFsdWUsIFNESENJ
X0dMSV85NzUwX0dNX0JVUlNUX1NJWkUpOw0KPiArDQo+ICAgICAgIGRyaXZpbmdfdmFsdWUgPSBz
ZGhjaV9yZWFkbChob3N0LCBTREhDSV9HTElfOTc1MF9EUklWSU5HKTsNCj4gICAgICAgcGxsX3Zh
bHVlID0gc2RoY2lfcmVhZGwoaG9zdCwgU0RIQ0lfR0xJXzk3NTBfUExMKTsNCj4gICAgICAgc3df
Y3RybF92YWx1ZSA9IHNkaGNpX3JlYWRsKGhvc3QsIFNESENJX0dMSV85NzUwX1NXX0NUUkwpOw0K
PiAtLQ0KPiAyLjUzLjANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0KR2Vu
ZXN5cyBMb2dpYyBFbWFpbCBDb25maWRlbnRpYWxpdHkgTm90aWNlOg0KVGhpcyBtYWlsIGFuZCBh
bnkgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gaW5mb3JtYXRpb24gdGhhdCBpcyBjb25maWRlbnRp
YWwsIHByb3ByaWV0YXJ5LCBwcml2aWxlZ2VkIG9yIG90aGVyd2lzZSBwcm90ZWN0ZWQgYnkgbGF3
LiBUaGUgbWFpbCBpcyBpbnRlbmRlZCBzb2xlbHkgZm9yIHRoZSBuYW1lZCBhZGRyZXNzZWUgKG9y
IGEgcGVyc29uIHJlc3BvbnNpYmxlIGZvciBkZWxpdmVyaW5nIGl0IHRvIHRoZSBhZGRyZXNzZWUp
LiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IG9mIHRoaXMgbWFpbCwgeW91
IGFyZSBub3QgYXV0aG9yaXplZCB0byByZWFkLCBwcmludCwgY29weSBvciBkaXNzZW1pbmF0ZSB0
aGlzIG1haWwuDQoNCklmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZW1haWwgaW4gZXJyb3IsIHBs
ZWFzZSBub3RpZnkgdXMgaW1tZWRpYXRlbHkgYnkgcmVwbHkgZW1haWwgYW5kIGltbWVkaWF0ZWx5
IGRlbGV0ZSB0aGlzIG1lc3NhZ2UgYW5kIGFueSBhdHRhY2htZW50cyBmcm9tIHlvdXIgc3lzdGVt
LiBQbGVhc2UgYmUgbm90ZWQgdGhhdCBhbnkgdW5hdXRob3JpemVkIHVzZSwgZGlzc2VtaW5hdGlv
biwgZGlzdHJpYnV0aW9uIG9yIGNvcHlpbmcgb2YgdGhpcyBlbWFpbCBpcyBzdHJpY3RseSBwcm9o
aWJpdGVkLg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg==

