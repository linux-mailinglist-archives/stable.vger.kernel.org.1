Return-Path: <stable+bounces-244390-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIZbJOhI+2lqYwMAu9opvQ
	(envelope-from <stable+bounces-244390-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 15:58:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E386D4DB795
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 15:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C53C30910BC
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 13:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2717A47DF81;
	Wed,  6 May 2026 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="Qqa3ewid"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA633F167C
	for <stable@vger.kernel.org>; Wed,  6 May 2026 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075676; cv=fail; b=ilDKSomfZcoFYXrfykmjgTnA2dtOZzWg5mjh1okdJuUSfJ+bcZHjDi80v88+3tH4Mo72/pPFnOSxcw2qYZZ3W1v+gEMo6/RCKHNdoQyg9SdsS0kQveWkaaen5VT4rSepLBMsZjYKxIvl8B0PzOQoxj+9U8y+hTgWN6kUr5BWWDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075676; c=relaxed/simple;
	bh=fmQ//If3dZYBVYYmZxzzYhWY3qK6hgzQGSbQePOMghw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iBLk7dejINX3Un0mV7L0l0LnOuUIsESWOU6aOCqWq/8jm7aDFp701t6xlz68hvp3ELSOmmm/rftFvIZ5vsvsKWEBm8Y/vKyFa4KqXx8drvfgrT2vJImn+5QaDKqtG8VB1OVyqexWkFVh3CRmJm0NFRAEcv0kqFN5s+fZaXqIjDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=Qqa3ewid; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Im0ioaYteijfYrgEFl0aE7eGhiSLDtfKFw81okE5U/N46Bz7cM/m09nRHF/D2VwyKt73MuYGwV7zsS4bYrdUfnEd1wC1faIE/UKsUl/86ftIjlM9dLPBQpNuOYEodX7lXAyiLIwPEpnJ/8wD+LzcdM1+Am13ePKl+i8HbnwLRGT66V/KYD9TuKsD8sVg1g37NtAPwcoy08+f1R8zEb30Z3/uSuy3LDv51GqX21nb/7Dzn5UsDs/ZLHy6oCB4lAsB4w8AyNyR80uMzRcXC87Ad9Zr8TKacJLl/6tTDFhZXX0CxWHGODW8jsFyQBShgPbvJRA0NO25rpV7T8SpLv0X0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmQ//If3dZYBVYYmZxzzYhWY3qK6hgzQGSbQePOMghw=;
 b=ICAhZyJbyGDHs+mMKURwMn2H5YMscMrRmtZtAR+mZ28hNDbengDl8LfF/hfF+spz+D9N14cHPz169UuHhEu2gsJz0Nyl0Hw4pvVq1ytZAfI8jc/7lEOgiEJ/1pnhhijUy9S43Prg7bk4ga8nd1nFQLcTmipPf2l+hQuhMpdACo2Mzc+iO/6fcyG9lYPkMu9ZMAkfxBc0R4OJD1zPr8r4Tc6tMXRc9816x7E4K3K/evWQG+PLQjbWP7jUBeOdPjYJd78bTeh96MVeYD3PMBOWOSQNWkRa87Y9pthbb+HKCP0/uZECYj9a9S4wKtKk39OmAqOjlv74yxAbxqfccpFnEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmQ//If3dZYBVYYmZxzzYhWY3qK6hgzQGSbQePOMghw=;
 b=Qqa3ewidLi9koJwfZHcFR4BGmq894FA3Pk0+ogyCOUFuj4dMMvuTCviycuzvYjSKD8BxFFvNwlEH2U0w1AvvtnYpS3P/SIRSCnadmRfjrAmZAgJJaC8hja3jHsnQRm1EN6SNv+bPszR9iR1gredeZafFAd51ES0xzJL1kIPrYMUtQjq81ZZau8O/oCKkGyF3QTMvlkHeKsrDdy6GjHfAyk8aKxJH9wKQExq+I8/0UGQS3KP3XUzK40OFdayIpJ7dxv5XjQv1hLzdg0Z2/h6mBUqBKfxGCZAe6tA2+OZmt4Nf1+G3icoV0hII5/Qa3boqwF/7p+qMCXrGTHBjRuLR4g==
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:39b::19)
 by PA2P189MB2670.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:40b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 13:54:30 +0000
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4]) by AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4%7]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 13:54:30 +0000
From: Yunseong Kim <yunseong.kim@est.tech>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "sashal@kernel.org"
	<sashal@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Chen Zhen
	<chenzhen126@huawei.com>, Jussi Maki <joamaki@gmail.com>, Daniel Borkmann
	<daniel@iogearbox.net>, Paolo Abeni <pabeni@redhat.com>, "ysk@kzalloc.com"
	<ysk@kzalloc.com>, "42.4.sejin@gmail.com" <42.4.sejin@gmail.com>
Subject: Re: [PATCH 6.1.y v2] bonding: fix use-after-free due to enslave fail
 after slave array update
Thread-Topic: [PATCH 6.1.y v2] bonding: fix use-after-free due to enslave fail
 after slave array update
Thread-Index: AQHc3VqVMv4itpz5/ESgtVwO8FypHLYBAIoAgAAEeQA=
Date: Wed, 6 May 2026 13:54:30 +0000
Message-ID: <b48fd28c-4117-4f56-afa9-dd0f7ae2033d@est.tech>
References: <20260506131319.525949-2-yunseong.kim@est.tech>
 <2026050615-quality-zit-9270@gregkh>
In-Reply-To: <2026050615-quality-zit-9270@gregkh>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8P189MB1752:EE_|PA2P189MB2670:EE_
x-ms-office365-filtering-correlation-id: e0e68227-e897-4678-e8d9-08deab76fedd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 1Gd+BWXRWnZkLt0totga/kZloiMqPg7bimp6EZw10TiTYk3oZyQhFfROnQNjb8uF2ePH4yP9AARsNPlLI7oUo68D9a6aTUtjtDpl/SnQGICsTUccuGVxYMDVh/+VwoWcdfPvffzU46Cv+ze7EByYXX48DA+ndDQaePXR0LMCHSGDtr55XzSKfiebItUn1iDr0parenQSMVFQ2t8Ap0FLkPr6xMbbkNya+ofGI3VUDBylJx0wRv8GAJJUmpZ2cnM856Ykr3rSo454C95//Bdaybkr4hkSVQ8zMGHttG43lyTTRb6QZNDxA5fn4vybLa3E0tyUFEtFOZXwwi1Jw+RgcqiAmXR/TNUy3mm0UpQbGYsXSJZUFkt+Aoe54cjUpiuyFIt7s+b/fVbClKGcz0c88kXrMZ84oxL6ZF0xgWtwlJJTEOH854MdcwNcQrgzBYc5/lkEZs55rcic3H3lzjdDEO75nAteQcHVJ5Z/SlmP9ekSI7QPqXJn4xvRDKj5v+tI7vWe9FEiMxyEigxTiYcl69P3scsCpHB3wsE6FMKkxr5QFWDCMwDnHAPt1Lu2vjJyR9Wjn4b0jDfSIeLkgmwnXfgmn75TuFec9BJwjMkVSYOZ97ir3n6jqWQv8LtGmsUfbmEn44dkuqn+Ov+p/hr1+/L5WaJNawAW89E711mEjIw1C/m4i3ooA59iFQaa9yHDYkOAVP2MdkuBhz/BerUybw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P189MB1752.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Sm52OWljTjgrRkNpcnQwNEs5ZXJBOHNQcWRTWVFrOFhialZSVGJIbHJlaFc1?=
 =?utf-8?B?KzF6bCs0bGV4YVl3QXdCSDc1MDU2enhVeGROcFRXaHdQajRyTytSeGd3SFh2?=
 =?utf-8?B?OHpJcTJYMm1Yd3B5VFh3VkVNeWcvZWdyMTlaOXdxSkgxZGh3K0ZUYlRBUi9n?=
 =?utf-8?B?Z3JTbjREKzBYZUVsazJWdmpCcUlBTlFnK1I5RWJZeGtaY2p3bGJsVUsrclNl?=
 =?utf-8?B?bkZBZUh5REI2UVNjWUhMMTRrZDZVRmUvU3padlJzRWlqK2MwMytoUWJYTXRn?=
 =?utf-8?B?ZUV5UnVIS3NpWHFkWU9sdkRueCtKZnFleDE1czlESGdRNERYd0k1Z0toaW11?=
 =?utf-8?B?OCtLRTVLRlRablk5NThjREJwN1RFL2F4eEgvYlZ6L0RDcjdsVkVRTmRBVldr?=
 =?utf-8?B?U1Qvd2VTalZVZmE0TWhxTFU4NDZaUnBCQ2xRSzNvN0c4QkFHeUJ6REJNaCtR?=
 =?utf-8?B?S2ZNRndhT2tSMXpZQmFwcHVnTUdPdHVjUTlJN08yTWx6TEpGZEtRZE9LS1hy?=
 =?utf-8?B?WHlzY0JjV281M1BORndIOWdFenJVMytwMmI5bmtqQlRxQTJ2WVIyVjNMZlhq?=
 =?utf-8?B?U01TelFNelQ3NWFyWm4ybWE1bG5pTWV2MnVZcjZqOUh5dms1UytYTS9CR0ZI?=
 =?utf-8?B?T3BlWGdBZFdUUmgxUUNPd01GbFQ4OXc3clpBNmoray9wTTVLMFk0OFJnaDJN?=
 =?utf-8?B?S3BDT081N3hUT1ljQnREYXM5bVZXSzVEY0RYeVBZYVFEcm5JWEZDWFowK2hB?=
 =?utf-8?B?TDV2ME55VGtERzcwTVYrRS9wa084L3R1djlZcGxCVzVvNmU5LzZYb21EYm5F?=
 =?utf-8?B?VjM1dHhCRnV2eDE0bXQ5WXhyVkExVlVZSUZUNHgzYTBIRTUzWEcwdmY1c1Ew?=
 =?utf-8?B?cmxITHZEcTRLYzc3TzFMTmZlM1dmTERuaStGdXlkakFXZzV2MHRXYis3S09B?=
 =?utf-8?B?Q0pJTkFLRTdJYjJ6K2hUOU1SeWlqUmdwWWhmQjkwQ20rRDJPZjRQV0JIcmVH?=
 =?utf-8?B?VXV0RERvV3JXNTFFMjJ3TEVwRFpEYnB6c2tQc2R2RlFkWTZ4eEc1L0owcTZh?=
 =?utf-8?B?NjhjS0F6MENKelJxNDNPTGRocEtJR05YaGQrVGxPMWEwdEI2ZEFTNDJheTl3?=
 =?utf-8?B?cVpKM1Bta1BaK3FrODZ6WDlCMUhJS0ZrNWtwWS9PNE5DMFpQMjh2QVM3MEtF?=
 =?utf-8?B?WU9wMnZvN05DSjlFeWEycXVOQ1pUbW9sV0xRQ2s4UG10QlhBcGRxSnFpM0VK?=
 =?utf-8?B?SW9BdDVxVkdhN253ajYxcVBwUHcvM2NXSlpBUHVaMHFJUFJHbVpyZU9ya0NT?=
 =?utf-8?B?T1ZCSlFabmwxN0kxdVBoZXlKUmRCcmJuSTlFR1YyN0oxV1l3c1BUeHBSTkdq?=
 =?utf-8?B?TDRHZkxNMlMxVlhrWHNwa01wa05sRmVoS1JwMjRtTDJEcmkzSDFwcGQyNmNT?=
 =?utf-8?B?aHdETjJGc3ArbHI0MG1EL0RsdHU3cHM1VmhEcngvOXcvbGh6NnhiT1ptYWpj?=
 =?utf-8?B?TFBzc3ViWlpaRHFFdUZ5dXNHcnRtN0RHRHJocEFveS9QZGpVbzBQU3kyc2FG?=
 =?utf-8?B?WEFSVWlKWURIa1pSL0tGRlpZem1KRHJxUG5iNTdxN2lmaTdpWmdvS2dSSGE1?=
 =?utf-8?B?Q1lyN2kzZVhDY3BIdDdKaE1NYVdGNmJZVXdueDRBdXYyaDZNTVdxWHEvRDJQ?=
 =?utf-8?B?Mmo0eXFBeGF0V1g4alBPenRJdjFESFBKYjkyZitOUnZUV2Y4bjdySldZbkJm?=
 =?utf-8?B?eDg0dEplN0NsSGwzOGFxRUJGN3YxRlhmRlJZTS9ON2xvZnFIZjIyMG4ycmlh?=
 =?utf-8?B?MnlUQWx3Q3RxQVdNeTVtMnBLWTB1RTBURDJzWnNWSUxneU8wcFpaZ2kranhx?=
 =?utf-8?B?N0NqZUt5dHM4UmhibUZyZVlTOHVMWnpHVzRpazVxTGp1UEFNQ3hHbUsvVUlY?=
 =?utf-8?B?cU5NRmpYaEVGdlZQaXQ0T0dVZEZQZ2VnVjNPQ256eEVUb3YrZ1JBanVqWVIr?=
 =?utf-8?B?MW56aWNjTFVSWlo3Zzk0dG93RnVlOTI1STA2Y01BanNGcjBiOWhiWjFadUFS?=
 =?utf-8?B?L3pEU1dFdWd4VFJtU2dBVE9EUExJc2tBcm5ZVUZka29xbzAwRmwyZlA5R3lH?=
 =?utf-8?B?TmZIMnZ5ajdlUUZVa0tENkl1L0lZd3FxU1FlWUEvYTkzVTVLMFoyelVaRDBH?=
 =?utf-8?B?ZENEdjV3YTZMRUtBSlFmMGZFZjhVSVdIRldRbGhoZkZ3YmVldkZQT3g1MVpO?=
 =?utf-8?B?ZWRxNU1KTDAva2RPQXdia2V3WGZoejBjNDNEdEVVZ3ErbFpPand2cWlUV1lK?=
 =?utf-8?Q?gU19JLGXdU+bUvnV9l?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E601E77BE8CA6B41B4A003BBE83C043D@EURP189.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e68227-e897-4678-e8d9-08deab76fedd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 13:54:30.3243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wh2jjA6ENh1UNsJ7UtmsnDGNAwGrzZU5GgQEoobU7e9jkRWr8PdY/qxbJ4d/dYcWimUioTjwrNVZnKkePhLG/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P189MB2670
X-Rspamd-Queue-Id: E386D4DB795
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244390-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[est.tech];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,blackwall.org,huawei.com,gmail.com,iogearbox.net,redhat.com,kzalloc.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yunseong.kim@est.tech,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[]

SGkgR3JlZywNCg0KVGhhbmsgeW91IGZvciBjaGVja2luZy4NCg0KT24gNS82LzI2IDE1OjM4LCBH
cmVnIEtIIHdyb3RlOg0KPiBPbiBXZWQsIE1heSAwNiwgMjAyNiBhdCAwMzoxMzoyMFBNICswMjAw
LCBZdW5zZW9uZyBLaW0gd3JvdGU6DQo+PiBGcm9tOiBOaWtvbGF5IEFsZWtzYW5kcm92IDxyYXpv
ckBibGFja3dhbGwub3JnPg0KPj4NCj4+IFsgVXBzdHJlYW0gY29tbWl0IGU5YWNkYTUyZmQyZWUw
Y2RjYTMzMmY5OTZkYTdhOTVjNWZkMjUyOTQgXQ0KDQpJIHdyb3RlIHRoZSB3cm9uZyB1cHN0cmVh
bSBzaGExIGFuZCBpbmNvcnJlY3RseSBhc3NpZ25lZCB0aGUgYXV0aG9yLg0KSSB1cGRhdGVkIGl0
IHRvIHJpZ2h0IGF1dGhvciBhbmQgZnVsbCBzaGEgMSBmb3IgdXBzdHJlYW0gY29tbWl0DQoNCj4+
IEZpeCBhIHVzZS1hZnRlci1mcmVlIHdoaWNoIGhhcHBlbnMgZHVlIHRvIGVuc2xhdmUgZmFpbHVy
ZSBhZnRlciB0aGUgbmV3DQo+PiBzbGF2ZSBoYXMgYmVlbiBhZGRlZCB0byB0aGUgYXJyYXkuIFNp
bmNlIHRoZSBuZXcgc2xhdmUgY2FuIGJlIHVzZWQgZm9yIFR4DQo+PiBpbW1lZGlhdGVseSwgd2Ug
Y2FuIHVzZSBpdCBhZnRlciBpdCBoYXMgYmVlbiBmcmVlZCBieSB0aGUgZW5zbGF2ZSBlcnJvcg0K
Pj4gY2xlYW51cCBwYXRoIHdoaWNoIGZyZWVzIHRoZSBhbGxvY2F0ZWQgc2xhdmUgbWVtb3J5LiBT
bGF2ZSB1cGRhdGUgYXJyYXkgaXMNCj4+IHN1cHBvc2VkIHRvIGJlIGNhbGxlZCBsYXN0IHdoZW4g
ZnVydGhlciBlbnNsYXZlIGZhaWx1cmVzIGFyZSBub3QgZXhwZWN0ZWQuDQo+PiBNb3ZlIGl0IGFm
dGVyIHhkcCBzZXR1cCB0byBhdm9pZCBhbnkgcHJvYmxlbXMuDQo+Pg0KPj4gSXQgaXMgdmVyeSBl
YXN5IHRvIHJlcHJvZHVjZSB0aGUgcHJvYmxlbSB3aXRoIGEgc2ltcGxlIHhkcF9wYXNzIHByb2c6
DQo+PiAgaXAgbCBhZGQgYm9uZDEgdHlwZSBib25kIG1vZGUgYmFsYW5jZS14b3INCj4+ICBpcCBs
IHNldCBib25kMSB1cA0KPj4gIGlwIGwgc2V0IGRldiBib25kMSB4ZHAgb2JqZWN0IHhkcF9wYXNz
Lm8gc2VjIHhkcF9wYXNzDQo+PiAgaXAgbCBhZGQgZHVtZHVtIHR5cGUgZHVtbXkNCj4+DQo+PiBU
aGVuIHJ1biBpbiBwYXJhbGxlbDoNCj4+ICB3aGlsZSA6OyBkbyBpcCBsIHNldCBkdW1kdW0gbWFz
dGVyIGJvbmQxIDE+L2Rldi9udWxsIDI+JjE7IGRvbmU7DQo+PiAgbWF1c2V6YWhuIGJvbmQxIC1h
IG93biAtYiByYW5kIC1BIHJhbmQgLUIgMS4xLjEuMSAtYyAwIC10IHRjcCAiZHA9MS0xMDIzLCBm
bGFncz1zeW4iDQo+Pg0KPj4gVGhlIGNyYXNoIGhhcHBlbnMgYWxtb3N0IGltbWVkaWF0ZWx5Og0K
Pj4gIFsgIDYwNS42MDI4NTBdIE9vcHM6IGdlbmVyYWwgcHJvdGVjdGlvbiBmYXVsdCwgcHJvYmFi
bHkgZm9yIG5vbi1jYW5vbmljYWwgYWRkcmVzcyAweGUwZTZmYzI0NjAwMDAxMzc6IDAwMDAgWyMx
XSBTTVAgS0FTQU4gTk9QVEkNCj4+ICBbICA2MDUuNjAyOTE2XSBLQVNBTjogbWF5YmUgd2lsZC1t
ZW1vcnktYWNjZXNzIGluIHJhbmdlIFsweDA3MzgwMTIzMDAwMDA5YjgtMHgwNzM4MDEyMzAwMDAw
OWJmXQ0KPj4gIFsgIDYwNS42MDI5NDZdIENQVTogMCBVSUQ6IDAgUElEOiAyNDQ1IENvbW06IG1h
dXNlemFobiBLZHVtcDogbG9hZGVkIFRhaW50ZWQ6IEcgICAgQiAgICAgICAgICAgICAgIDYuMTku
MC1yYzYrICMyMSBQUkVFTVBUKHZvbHVudGFyeSkNCj4+ICBbICA2MDUuNjAyOTc5XSBUYWludGVk
OiBbQl09QkFEX1BBR0UNCj4+ICBbICA2MDUuNjAyOTk4XSBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0
YW5kYXJkIFBDIChRMzUgKyBJQ0g5LCAyMDA5KSwgQklPUyAxLjE2LjMtZGViaWFuLTEuMTYuMy0y
IDA0LzAxLzIwMTQNCj4+ICBbICA2MDUuNjAzMDMyXSBSSVA6IDAwMTA6bmV0ZGV2X2NvcmVfcGlj
a190eCsweGNkLzB4MjEwDQo+PiAgWyAgNjA1LjYwMzA2M10gQ29kZTogNDggODkgZmEgNDggYzEg
ZWEgMDMgODAgM2MgMDIgMDAgMGYgODUgM2UgMDEgMDAgMDAgNDggYjggMDAgMDAgMDAgMDAgMDAg
ZmMgZmYgZGYgNGMgOGIgNmIgMDggNDkgOGQgN2QgMzAgNDggODkgZmEgNDggYzEgZWEgMDMgPDgw
PiAzYyAwMiAwMCAwZiA4NSAyNSAwMSAwMCAwMCA0OSA4YiA0NSAzMCA0YyA4OSBlMiA0OCA4OSBl
ZSA0OCA4OQ0KPj4gIFsgIDYwNS42MDMxMTFdIFJTUDogMDAxODpmZmZmODg4MTdiOWFmMzQ4IEVG
TEFHUzogMDAwMTAyMTMNCj4+ICBbICA2MDUuNjAzMTQ1XSBSQVg6IGRmZmZmYzAwMDAwMDAwMDAg
UkJYOiBmZmZmODg4MTdkMjhiNDIwIFJDWDogMDAwMDAwMDAwMDAwMDAwMA0KPj4gIFsgIDYwNS42
MDMxNzJdIFJEWDogMDBlNzAwMjQ2MDAwMDEzNyBSU0k6IDAwMDAwMDAwMDAwMDAwMDggUkRJOiAw
NzM4MDEyMzAwMDAwOWJlDQo+PiAgWyAgNjA1LjYwMzE5OV0gUkJQOiBmZmZmODg4MTdiNTQxYTAw
IFIwODogMDAwMDAwMDAwMDAwMDAwMSBSMDk6IGZmZmZmYmZmZjNlZDhjMGMNCj4+ICBbICA2MDUu
NjAzMjI2XSBSMTA6IGZmZmZmZmZmOWY2YzYwNjcgUjExOiAwMDAwMDAwMDAwMDAwMDAxIFIxMjog
MDAwMDAwMDAwMDAwMDAwMA0KPj4gIFsgIDYwNS42MDMyNTNdIFIxMzogMDczODAxMjMwMDAwMDk4
ZSBSMTQ6IGZmZmY4ODgxN2QyOGI0NDggUjE1OiBmZmZmODg4MTdiNTQxYTg0DQo+PiAgWyAgNjA1
LjYwMzI4Nl0gRlM6ICAwMDAwN2Y2NTcwZWY2N2MwKDAwMDApIEdTOmZmZmY4ODgyMjFkZmEwMDAo
MDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KPj4gIFsgIDYwNS42MDMzMTldIENTOiAgMDAx
MCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCj4+ICBbICA2MDUuNjAz
MzQzXSBDUjI6IDAwMDA3ZjY1NzEyZmFlNDAgQ1IzOiAwMDAwMDAwMTEzNzFiMDAwIENSNDogMDAw
MDAwMDAwMDM1MGVmMA0KPj4gIFsgIDYwNS42MDMzNzNdIENhbGwgVHJhY2U6DQo+PiAgWyAgNjA1
LjYwMzM5Ml0gIDxUQVNLPg0KPj4gIFsgIDYwNS42MDM0MTBdICBfX2Rldl9xdWV1ZV94bWl0KzB4
NDQ4LzB4MzJhMA0KPj4gIFsgIDYwNS42MDM0MzRdICA/IF9fcGZ4X3ZwcmludGtfZW1pdCsweDEw
LzB4MTANCj4+ICBbICA2MDUuNjAzNDYxXSAgPyBfX3BmeF92cHJpbnRrX2VtaXQrMHgxMC8weDEw
DQo+PiAgWyAgNjA1LjYwMzQ4NF0gID8gX19wZnhfX19kZXZfcXVldWVfeG1pdCsweDEwLzB4MTAN
Cj4+ICBbICA2MDUuNjAzNTA3XSAgPyBib25kX3N0YXJ0X3htaXQrMHhiZmIvMHhjMjAgW2JvbmRp
bmddDQo+PiAgWyAgNjA1LjYwMzU0Nl0gID8gX3ByaW50aysweGNiLzB4MTAwDQo+PiAgWyAgNjA1
LjYwMzU2Nl0gID8gX19wZnhfX3ByaW50aysweDEwLzB4MTANCj4+ICBbICA2MDUuNjAzNTg5XSAg
PyBib25kX3N0YXJ0X3htaXQrMHhiZmIvMHhjMjAgW2JvbmRpbmddDQo+PiAgWyAgNjA1LjYwMzYy
N10gID8gYWRkX3RhaW50KzB4NWUvMHg3MA0KPj4gIFsgIDYwNS42MDM2NDhdICA/IGFkZF90YWlu
dCsweDJhLzB4NzANCj4+ICBbICA2MDUuNjAzNjcwXSAgPyBlbmRfcmVwb3J0LmNvbGQrMHg1MS8w
eDc1DQo+PiAgWyAgNjA1LjYwMzY5M10gID8gYm9uZF9zdGFydF94bWl0KzB4YmZiLzB4YzIwIFti
b25kaW5nXQ0KPj4gIFsgIDYwNS42MDM3MzFdICBib25kX3N0YXJ0X3htaXQrMHg2MjMvMHhjMjAg
W2JvbmRpbmddDQoNClRoZSB1cHN0cmVhbSBwYXRjaCBoYXMgY29uZmxpY3RlZCwgdGhlcmUgaXMg
cmVjZW50bHkgZGV2ZWxvcGVkIHBhcnQgaW4gdGhlIGNvZGUuDQoNCj4+IEJhY2twb3J0IGNvbW1p
dDoNCj4+DQo+PiAgY29tbWl0IGUwY2FlYjI0ZjUzOCAoIm5ldDogYm9uZGluZzogdXBkYXRlIHRo
ZSBzbGF2ZSBhcnJheSBmb3IgYnJvYWRjYXN0IG1vZGUiKQ0KPj4NCj4+IFRoZSBCT05EX01PREVf
QlJPQURDQVNUIGNvbmRpdGlvbiB3YXMgcmVtb3ZlZC4gQmVjYXVzZSBpbnRyb2R1Y2VkIGJ5DQo+
PiBzdXBwb3J0aW5nIGNvbW1pdCBvbiB0aGUgdjYuMTctcmMxOg0KPj4NCj4+ICBjb21taXQgY2U3
YTM4MTY5N2NiICgibmV0OiBib25kaW5nOiBhZGQgYnJvYWRjYXN0X25laWdoYm9yIG9wdGlvbiBm
b3IgODAyLjNhZCIpDQo+Pg0KPj4gTmVpdGhlciBvZiB3aGljaCBhcmUgcHJlc2VudCBpbiB0aGlz
IGtlcm5lbCB2ZXJzaW9uLg0KDQpCdXQgSSBkaWRu4oCZdCBpbmNsdWRlIHRoZSBjaGVycnktcGlj
ayBwcm9jZXNzIGluZm9ybWF0aW9uIG9uIHRoZSB2MS4gU28sIEkgYWRkIGl0Lg0KDQo+PiBGaXhl
czogOWUyZWU1YzdlN2MzICgibmV0LCBib25kaW5nOiBBZGQgWERQIHN1cHBvcnQgdG8gdGhlIGJv
bmRpbmcgZHJpdmVyIikNCj4+IFNpZ25lZC1vZmYtYnk6IE5pa29sYXkgQWxla3NhbmRyb3YgPHJh
em9yQGJsYWNrd2FsbC5vcmc+DQo+PiBSZXBvcnRlZC1ieTogQ2hlbiBaaGVuIDxjaGVuemhlbjEy
NkBodWF3ZWkuY29tPg0KPj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYv
ZmFlMTdjMjEtNDk0MC01NjA1LTg1YjItMWQ1ZTE3MzQyMzU4QGh1YXdlaS5jb20vDQo+PiBDQzog
SnVzc2kgTWFraSA8am9hbWFraUBnbWFpbC5jb20+DQo+PiBDQzogRGFuaWVsIEJvcmttYW5uIDxk
YW5pZWxAaW9nZWFyYm94Lm5ldD4NCj4+IEFja2VkLWJ5OiBEYW5pZWwgQm9ya21hbm4gPGRhbmll
bEBpb2dlYXJib3gubmV0Pg0KPj4gTGluazogaHR0cHM6Ly9wYXRjaC5tc2dpZC5saW5rLzIwMjYw
MTIzMTIwNjU5LjU3MTE4Ny0xLXJhem9yQGJsYWNrd2FsbC5vcmcNCj4+IFNpZ25lZC1vZmYtYnk6
IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFNhc2hh
IExldmluIDxzYXNoYWxAa2VybmVsLm9yZz4NCj4+IFRlc3RlZC1ieTogWXVuc2VvbmcgS2ltIDx5
dW5zZW9uZy5raW1AZXN0LnRlY2g+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZdW5zZW9uZyBLaW0gPHl1
bnNlb25nLmtpbUBlc3QudGVjaD4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvbmV0L2JvbmRpbmcvYm9u
ZF9tYWluLmMgfCA2ICsrKy0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pDQo+IA0KPiBXaGF0IGNoYW5nZWQgZnJvbSB2MT8NCj4gDQoNCknigJls
bCBpbmNsdWRlIHRoYXQgaW5mb3JtYXRpb24gaW4gdGhlIHBhdGNoIG1lc3NhZ2UgbmV4dCB0aW1l
Lg0KDQpNeSBmaXJzdCBiYWNrcG9ydGluZyB2MSBwYXRjaCBpcyBoZXJlOg0KDQogIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL3N0YWJsZS9iZTZhNWFiYi1lNTI0LTQ3YmEtYmNkYS0xZDgzMjk2NGM3
NGZAZXN0LnRlY2gvDQoNCg0KQmVzdCByZWdhcmRzLA0KWXVuc2VvbmcNCg==

