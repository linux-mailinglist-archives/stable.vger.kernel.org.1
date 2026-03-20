Return-Path: <stable+bounces-227498-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKiNARAOvWkO5gIAu9opvQ
	(envelope-from <stable+bounces-227498-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 10:06:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2D62D7BC8
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 10:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6940230AB87F
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A871325710;
	Fri, 20 Mar 2026 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ZRpfeLKL"
X-Original-To: stable@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010006.outbound.protection.outlook.com [52.103.68.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE1C328B7D
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773997293; cv=fail; b=GYlHco/S3MsgrVpEPzVR4/1I1qg6dahMxyRgAS5GqVVyznD+ZND+4TGThYPIY2FYjbYh+JMYYTCXiKBf4Xq0AqEIcnHv32QIuGEaavyl62Z9mxaEbrkuHRlsTJ8WDxEZh+Hs53T6vAS1dL1oWh8a17wQFGRZ2CCH44uUHs2QghA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773997293; c=relaxed/simple;
	bh=ZpkiZBZkCUNh1CVBvbWHUcD3jwrKNWwohc7m7bn9ICk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SyewJ24mCQQW/nMdxAQFjUSQV+ZulQ4SCTUeZqoNViCPI3+PGFLZA3gJeUfplXyoUWiKe13yqNDLLx0HVjsKla8UY9aYu9pPwbUTh7iqL2dMTL6xYwT5WE3Y/rTkrExxrAbmQOLP7ZfHUxnrcrfID3zA0XtKG4NTqfx/Wwd1s1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ZRpfeLKL; arc=fail smtp.client-ip=52.103.68.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcD0mt9ovGyQ4D1Nwvh3wntCTl9AQX7aL2NUXH8t8COR/oVvGIB1EzMxb+5ME0hBtw7r4aVVnJ3lTGqIIryNDG73Js68Irf3S/kCsFj8FD8IuqAiuywyQ20u9j0yebFHF6UqJZnTC7N4lPFlCntdkkH67aFsRwcVd/gOLUFPtZHJ03dUhzVq4FKlBOndLwArfIs5qFXi2aHaFIHS7FTMUwuCM19DIhGLjNjCkTxGQW1xlWgciuCmm9yDkrndlMgRzfD4e0nY92/JwoDAk5YCyABYds0MO8HzeOuXa9Wuyxs3fhyBocyS7fB81gDAUhNGIG9fnoECLLONoSqw+z8XtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpkiZBZkCUNh1CVBvbWHUcD3jwrKNWwohc7m7bn9ICk=;
 b=Z6M4yI3FLQARvM/Vdr0pR0Wzw3zulVTH9WBNw4u7wSo19r28NYzBfE/O33DJMnlGZyurU7VqHdC/CYKYe9ejNHdAfLfeqR/A3JxYrZLT3aYE+HjjeDdb9RR0NsIYQGhWjt0jhp3jxdsor3XSuUX4+C98LoDKguc2f5wpS46rDMl67SQbW7We0b+IgOfZ9xdB/v5BOF5/O6S7jJI+sKSiqV70tJKonlA4sB6QKWNw6lsjoBurrowoxKYxTdldRXeVv8nN8NmEJnQbFjY2balJwj42VMxXkSarTqVv5cmocFOc/LW+IsX2B1e+Jj2miqtliRurn8GgdhJo8CdS52R2iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpkiZBZkCUNh1CVBvbWHUcD3jwrKNWwohc7m7bn9ICk=;
 b=ZRpfeLKLLq2YEw50yEzMw0Gof7huRV50iCp43pJ1ssy4g3BxtQcFXIB1a9LCDTBcozrED6xRS3XNsOawh1BQWQ3Dm5Gz6DscZE/KCYRTNu+yov+PBuPpcJFRrN3ftl5KAh9IfsHid/+WSW5vZbdi2dfG4wSHMcRevFs/JYl1tSgsU52EtuXv86t/gYgD6fQyraBwrEKiz4PTuJYBBF/booQAM9kYFw/LWlE1Ju+Zxsbrr85CnfZNeQv+uNKJQUdz2ZT9rCEIXStdvXEYDFD4AaTHk6CkfpR2WJG9qekZfcIJ2xXWGg6GyJkaVwvvCB/NNTkzlO1ywm7ty/LlDVfpuQ==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by PN2PR01MB8790.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:118::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Fri, 20 Mar
 2026 09:01:28 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9723.019; Fri, 20 Mar 2026
 09:01:27 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "jkosina@suse.com" <jkosina@suse.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] HID: appletb-kbd: add .resume method in
 PM" failed to apply to 6.12-stable tree
Thread-Topic: FAILED: patch "[PATCH] HID: appletb-kbd: add .resume method in
 PM" failed to apply to 6.12-stable tree
Thread-Index: AQHcuEZFMnHMxcnPH0iDBnLXjcuWY7W3H7WY
Date: Fri, 20 Mar 2026 09:01:27 +0000
Message-ID:
 <MAUPR01MB1154696DABA7DD9EE0D6E99D3B84CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
References: <2026032053-reviver-stock-9da2@gregkh>
In-Reply-To: <2026032053-reviver-stock-9da2@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAUPR01MB11546:EE_|PN2PR01MB8790:EE_
x-ms-office365-filtering-correlation-id: c0d348e2-d14f-47df-e1d4-08de865f4581
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|41001999006|15080799012|461199028|19110799012|25031999004|14091999006|8062599012|8060799015|6072599003|8022599003|10035399007|440099028|3412199025|4302099013|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?utf-8?B?c2gxOVJiUXNNNDE2TEU3cHEycTUxeEFnN2hQalZydGxTa1dXVUlIR0RjM0k1?=
 =?utf-8?B?cWh1T2g3cmNhd09tcDE5ZEFHc2NmdCs3SWNGY3BMTUd4ME5ZS0w0b3F5YkQ1?=
 =?utf-8?B?MkljT0VISDVlUXJ6TE54a0dtak5IL1BIYzlvdjRpVzdyeFJKdEVTVXd2U1pN?=
 =?utf-8?B?RHd1RnFGZDg2bWRxSTliVFdIUVpSR1l4elV1aVlEczlrOWRxM1VjQXJoUzcv?=
 =?utf-8?B?RnRybGZWY3VTVVRBOUV0dWRQdHo5bXBjU1hQcE1EQVd1TGppeEVpd2lGWGRC?=
 =?utf-8?B?d2Q4RzRHS3lGTS9GK3ZCc0NTMG0rNGdXYlZiNTc4ckRmNEMydDdOOUtsYzBh?=
 =?utf-8?B?N1Q4Tlpyc21VNi9mbXljS3R2VjdrZVlnTzB6aWZWQnUzcGEyQjcvN0c2YlFL?=
 =?utf-8?B?SzYzZmlCajJ4U0VHeDVnMnNCZXR5Nml5cHEwcXEvNS9PZVJ0TDVwbmFXc3NM?=
 =?utf-8?B?ZitrcjVRa2pWajV4TEN6K3JtbUhBZnFkcUdJWVU1ZEtINUxYMWJ1WnJrNXZO?=
 =?utf-8?B?L3Y4WEk0ZjZUQ09Wd3FRN3c0NGxTOTRCM3ZPMnY3UTZ6VDh2R0Y2dDF5UUVP?=
 =?utf-8?B?Zlp5ZStpSW1DK3YyZkg3eUtFV01kdTdhWDdOeUJKZktrMHAvdklCNXJ2akc0?=
 =?utf-8?B?bmtKdUtnY2tCd2FUZG1hVitOcElpREtsL1o4cnRXcEpvaVdJZXJOdWd3dmdX?=
 =?utf-8?B?T1M1cmhXNHh5eTZzd0FFMGh1WUhuUXpFUFZWWGxOd1ljRi96Zm9Da2dMSlda?=
 =?utf-8?B?cGkwSWlXb2psWHpNRUtnMmVGL3BRcHlmVEprUStWSS9jdjYxSmVKZmozeDZQ?=
 =?utf-8?B?US9DTmFwSHEvQ0kzY1pwcTl5bjNwbDNnMU85azJaSWpObkpNeFVxTlpsVGh5?=
 =?utf-8?B?aEpCMTAxM0NRMFZoK0hKUG9NZDNOSnprT2pibVhXVjJUVXgxZmR6M0Q3dGJr?=
 =?utf-8?B?ZW1NVC9NMVVldXlGWjhFbnphY3EyNGFPdVEyaklqamtTYUVCV3UydFdJMU9j?=
 =?utf-8?B?eE9iV1FWTTFnbGRaQzhBczVCMURIaHMvemdabWp3aWxVZHRybjAzMlN1N2lH?=
 =?utf-8?B?eVlpdEFsVkNJaW82SVdUSlN5NUxla3kwajBWVkMyWi9EeU9UaDdIQTR6Zkx0?=
 =?utf-8?B?QzFnVE9KcGJvUXp0LzhBVmF2ZmhmQ2lENlVhYnkxQ2FYY1J1U2xJSTBmb1Y0?=
 =?utf-8?B?VzdscDNwWDZtUEVIOGNuQThzTFRLV1VaYmpjSFdyUzcvdmlFMGltWW55aWFr?=
 =?utf-8?B?ZFRwWWY2REVDajR0akdzRjAxMmllS2VqTHIvdTdrbEg3UWJCUjdQMGhOU29x?=
 =?utf-8?B?dnVzT0tqZ0xzQVdIdXFvblFSbHFRRTNIb3B1ZU5UZmtsWWNHOEF3dEpUVzUv?=
 =?utf-8?B?clZHbk1YUmVXYyt1MXc3cGdPTjlkQ2RaNjJ0RG0rbm5ncExrU0VGcVhlQVFw?=
 =?utf-8?B?U3YvSm44WE1Cd0ZVbnhCSnBWZ3ZCSzJrZlBGbUJnPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWRGRWJCVkkwVnBVMXIzSzRZeGduK1Vtd0FlTVpUa3RGa3cwS0RBcW43YTVX?=
 =?utf-8?B?T2Y4YlozSGEySmZSdXJrNi9vWnpwMWdVSFJlRjVLTGZZN1Exb1NBR3VidkhW?=
 =?utf-8?B?K0RtZnlFWXNOYlBrcEJob3V2RDBqc1d0ZnNjbVdMT2s3Z1hDQXl6SHhrcTda?=
 =?utf-8?B?SEN3eHRpTUVWRnh3ZFc2UHlHRGNERWxaT1VaZUFSSkEzUG9wVitjWW01eWZD?=
 =?utf-8?B?cng3TTNGS0VDMWl3L2hWRDlPTmY0R3YrdWhaYW5sUkpkTld5NC9OOW12WkdM?=
 =?utf-8?B?alluWFpQVmt5RnF0VmFPaGdma1N6NEVxTnduTEJzanFFbkhGTGdLdHJjNTAy?=
 =?utf-8?B?ZDJId2FHaFI2a0pSSzc4eXRlNm9jVTI0aVpIbHdtdmt0aVFpUVZJbG5rek83?=
 =?utf-8?B?UXVRY3dyWWxLdEhBUUZTMHA4NGRQeU9ud3lTWkxnK2c0VGpieGIxZ1N0cHZT?=
 =?utf-8?B?R1FYeGJwQy9ockFUaTYrOWtGY3FuWlpyUi92TWFBb1VYdm5GWlkvL0VQNjJZ?=
 =?utf-8?B?OTh1N0Fic29yRlZ4V083NmI1WUNGN2ZESmppbEcwdGRudW9MbEJFUVlyVVRM?=
 =?utf-8?B?L3BUU2ZqRGhXa0pqSVFaYU55NnZjVHRLUGtBeEZmaFN5M2NHSWwrNUIrZHNy?=
 =?utf-8?B?dHllWlFOQTEyTUdQMlBXUnhmRzhCTmIyTEtuK3ZOL2UzUTNuMzZPRlZ5STJB?=
 =?utf-8?B?RkdpMlljK2hYS0tENTd4elFqcll3QjF3WGZWdDI2N3loYW5uU1VSc0JFOXE0?=
 =?utf-8?B?N0NkNWpKRlZlVHJYQWJkakxiY0VwWityeERibWh1bEFLNFM0ayszd2kyME1y?=
 =?utf-8?B?aDBCUjlHREpreVMvR25pWVEyQmtvVTMzMFdiU0ZYNkVRZHM1bkQxYTRaN1Ar?=
 =?utf-8?B?SjQxTk92L2lKU0cwd3F0cXVIZHFXZlJZNHNVNThvNTlVS1AwakFZOG41cXM0?=
 =?utf-8?B?NFh5SlB4dGRkMXpieTZBdko0cloxeFlUZXJKUWZOQ2VDbmltbkF0WEVQYWNu?=
 =?utf-8?B?YWZVQXpnSVhjQ2lGMEdXQ0t5bDZLQWVRZTkrVWlHdDFDc21NbXFhNXZ3ZFpM?=
 =?utf-8?B?TTJkQ0JoenBvRzRCdWRQSHlpQSt3S0lxYjQzQkdnV1Q2SmgxTFQzZDRSRVov?=
 =?utf-8?B?Z29IakRqU1JWUllyNEhNbk1rdG9MWUZ1VjVaNjhyeUJsVzhEUElkb2FtUHZa?=
 =?utf-8?B?YVd2YTJ1c2xYRll3SWYxeHdhS3Z1eVRpNktIV2ZqdVVKYnZWMGIxL3A2RUlX?=
 =?utf-8?B?eWlYS0dGM0ZWNkdQU2x4Q25BRDZuZ0k5aHJVem5mc0pkTkpHU0JLYm5CR0dz?=
 =?utf-8?B?VjlBdkRhYnlYaTZKSGg0WDNDclhQWW5LMWMxREpRUENKNjYxMGthYmp6T0VO?=
 =?utf-8?B?czVBUHQxWDBQbXpjaG9vUFdFL1BZdlBCVWN0dmZ2aU91K3BXb3oxaWlMVm9Y?=
 =?utf-8?B?Zmo0SUFma1FQMHFwdzFDSkFrdjh3S2NGd3ovSDRpeGhtbjJKWWdWSmdWVlBm?=
 =?utf-8?B?cW5lYXZNQURIQnhrVUN0clNSNU5MOXZnc1psUmFFZE9Hb3U5YUZTL0ZKME8w?=
 =?utf-8?B?aWo1Wmw1cWozQ3diWXRPK0g0Mkw5d1pSRjZhZDNJYncrajVTSWVsTG9vcmxD?=
 =?utf-8?B?UGh2cERaQXZlSlJKNGJSbjlVUGFaQlhZT241TnpqZC9yeHZJNnpsbmxkbngw?=
 =?utf-8?B?cURpVzYyOWpha3djNjBRNEt5VTNXYWNoUE5uaWVIWXM2cWdaZ2JoWGhoT3Ur?=
 =?utf-8?B?bnY4S1RnQU9xRSt4L08xM09vL3IvTU12OVAraTB6YTFPVDRrUGpSb0JQcFNl?=
 =?utf-8?B?MFhIVzdZM2lxTFNuMmxhWWFYZ2V1cG9tbGtSVW40c010Vm9ibXpNalQrd2VX?=
 =?utf-8?B?dWVtL2xhaDBvcGpxUDh3U3phVC84M0EwRG9CdG84VVE0dFFSczlBNHZLc3d0?=
 =?utf-8?Q?02XQqCKr57JTBsT+MT8G7IzybDGErhNU?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d348e2-d14f-47df-e1d4-08de865f4581
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 09:01:27.8709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB8790
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[live.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[live.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DKIM_TRACE(0.00)[live.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227498-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya08@live.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.833];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[live.com]
X-Rspamd-Queue-Id: 6B2D62D7BC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

VGhlIGRyaXZlciBkb2Vzbid0IGV4aXN0IGZvciBrZXJuZWxzIGJlZm9yZSA2LjE1IHNvIGl0J3Mg
bm90IG5lZWRlZCB0aGVyZS4NCg0KPiBPbiAyMCBNYXIgMjAyNiwgYXQgMjoxOOKAr1BNLCBncmVn
a2hAbGludXhmb3VuZGF0aW9uLm9yZyB3cm90ZToNCj4gDQo+IO+7vw0KPiBUaGUgcGF0Y2ggYmVs
b3cgZG9lcyBub3QgYXBwbHkgdG8gdGhlIDYuMTItc3RhYmxlIHRyZWUuDQo+IElmIHNvbWVvbmUg
d2FudHMgaXQgYXBwbGllZCB0aGVyZSwgb3IgdG8gYW55IG90aGVyIHN0YWJsZSBvciBsb25ndGVy
bQ0KPiB0cmVlLCB0aGVuIHBsZWFzZSBlbWFpbCB0aGUgYmFja3BvcnQsIGluY2x1ZGluZyB0aGUg
b3JpZ2luYWwgZ2l0IGNvbW1pdA0KPiBpZCB0byA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4uDQo+
IA0KPiBUbyByZXByb2R1Y2UgdGhlIGNvbmZsaWN0IGFuZCByZXN1Ym1pdCwgeW91IG1heSB1c2Ug
dGhlIGZvbGxvd2luZyBjb21tYW5kczoNCj4gDQo+IGdpdCBmZXRjaCBodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFibGUvbGludXguZ2l0LyBsaW51eC02
LjEyLnkNCj4gZ2l0IGNoZWNrb3V0IEZFVENIX0hFQUQNCj4gZ2l0IGNoZXJyeS1waWNrIC14IDE5
NjU0NDVlMTNjMDliNzk5MzJjYTgxNTQ5NzdiNDQwOGNiOTYxMGMNCj4gIyA8cmVzb2x2ZSBjb25m
bGljdHMsIGJ1aWxkLCB0ZXN0LCBldGMuPg0KPiBnaXQgY29tbWl0IC1zDQo+IGdpdCBzZW5kLWVt
YWlsIC0tdG8gJzxzdGFibGVAdmdlci5rZXJuZWwub3JnPicgLS1pbi1yZXBseS10byAnMjAyNjAz
MjA1My1yZXZpdmVyLXN0b2NrLTlkYTJAZ3JlZ2toJyAtLXN1YmplY3QtcHJlZml4ICdQQVRDSCA2
LjEyLnknIEhFQUReLi4NCj4gDQo+IFBvc3NpYmxlIGRlcGVuZGVuY2llczoNCj4gDQo+IA0KPiAN
Cj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCj4gDQo+IC0tLS0tLS0tLS0tLS0tLS0tLSBvcmln
aW5hbCBjb21taXQgaW4gTGludXMncyB0cmVlIC0tLS0tLS0tLS0tLS0tLS0tLQ0KPiANCj4gRnJv
bSAxOTY1NDQ1ZTEzYzA5Yjc5OTMyY2E4MTU0OTc3YjQ0MDhjYjk2MTBjIE1vbiBTZXAgMTcgMDA6
MDA6MDAgMjAwMQ0KPiBGcm9tOiBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4QGxpdmUuY29tPg0K
PiBEYXRlOiBUdWUsIDE3IEZlYiAyMDI2IDAyOjU0OjQ2ICswNTMwDQo+IFN1YmplY3Q6IFtQQVRD
SF0gSElEOiBhcHBsZXRiLWtiZDogYWRkIC5yZXN1bWUgbWV0aG9kIGluIFBNDQo+IA0KPiBVcG9u
IHJlc3VtaW5nIGZyb20gc3VzcGVuZCwgdGhlIFRvdWNoIEJhciBkcml2ZXIgd2FzIG1pc3Npbmcg
YSByZXN1bWUNCj4gbWV0aG9kIGluIG9yZGVyIHRvIHJlc3RvcmUgdGhlIG9yaWdpbmFsIG1vZGUg
dGhlIFRvdWNoIEJhciB3YXMgb24gYmVmb3JlDQo+IHN1c3BlbmRpbmcuIEl0IGlzIHRoZSBzYW1l
IGFzIHRoZSByZXNldF9yZXN1bWUgbWV0aG9kLg0KPiANCj4gW2prb3NpbmFAc3VzZS5jb206IHJl
YmFzZWQgb24gdG9wIG9mIHRoZSBwbV9wdHIoKSBjb252ZXJzaW9uXQ0KPiBDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4
QGxpdmUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKaXJpIEtvc2luYSA8amtvc2luYUBzdXNlLmNv
bT4NCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2hpZC9oaWQtYXBwbGV0Yi1rYmQuYyBiL2Ry
aXZlcnMvaGlkL2hpZC1hcHBsZXRiLWtiZC5jDQo+IGluZGV4IGExZGIzYjNkMDY2Ny4uMGZkYzA5
NjhiOWVmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2hpZC9oaWQtYXBwbGV0Yi1rYmQuYw0KPiAr
KysgYi9kcml2ZXJzL2hpZC9oaWQtYXBwbGV0Yi1rYmQuYw0KPiBAQCAtNDc2LDcgKzQ3Niw3IEBA
IHN0YXRpYyBpbnQgYXBwbGV0Yl9rYmRfc3VzcGVuZChzdHJ1Y3QgaGlkX2RldmljZSAqaGRldiwg
cG1fbWVzc2FnZV90IG1zZykNCj4gICAgcmV0dXJuIDA7DQo+IH0NCj4gDQo+IC1zdGF0aWMgaW50
IGFwcGxldGJfa2JkX3Jlc2V0X3Jlc3VtZShzdHJ1Y3QgaGlkX2RldmljZSAqaGRldikNCj4gK3N0
YXRpYyBpbnQgYXBwbGV0Yl9rYmRfcmVzdW1lKHN0cnVjdCBoaWRfZGV2aWNlICpoZGV2KQ0KPiB7
DQo+ICAgIHN0cnVjdCBhcHBsZXRiX2tiZCAqa2JkID0gaGlkX2dldF9kcnZkYXRhKGhkZXYpOw0K
PiANCj4gQEAgLTUwMCw3ICs1MDAsOCBAQCBzdGF0aWMgc3RydWN0IGhpZF9kcml2ZXIgYXBwbGV0
Yl9rYmRfaGlkX2RyaXZlciA9IHsNCj4gICAgLmV2ZW50ID0gYXBwbGV0Yl9rYmRfaGlkX2V2ZW50
LA0KPiAgICAuaW5wdXRfY29uZmlndXJlZCA9IGFwcGxldGJfa2JkX2lucHV0X2NvbmZpZ3VyZWQs
DQo+ICAgIC5zdXNwZW5kID0gcG1fcHRyKGFwcGxldGJfa2JkX3N1c3BlbmQpLA0KPiAtICAgIC5y
ZXNldF9yZXN1bWUgPSBwbV9wdHIoYXBwbGV0Yl9rYmRfcmVzZXRfcmVzdW1lKSwNCj4gKyAgICAu
cmVzdW1lID0gcG1fcHRyKGFwcGxldGJfa2JkX3Jlc3VtZSksDQo+ICsgICAgLnJlc2V0X3Jlc3Vt
ZSA9IHBtX3B0cihhcHBsZXRiX2tiZF9yZXN1bWUpLA0KPiAgICAuZHJpdmVyLmRldl9ncm91cHMg
PSBhcHBsZXRiX2tiZF9ncm91cHMsDQo+IH07DQo+IG1vZHVsZV9oaWRfZHJpdmVyKGFwcGxldGJf
a2JkX2hpZF9kcml2ZXIpOw0KPiANCg==

