Return-Path: <stable+bounces-227435-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAosH33mvGkf4QIAu9opvQ
	(envelope-from <stable+bounces-227435-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 07:17:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3C72D632D
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 07:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E449307E87A
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 06:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38492303A01;
	Fri, 20 Mar 2026 06:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="UF2ggUb8"
X-Original-To: stable@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011036.outbound.protection.outlook.com [52.103.67.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8433A175A6B;
	Fri, 20 Mar 2026 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773987402; cv=fail; b=mr8zs0OHpAdw1Eo62NEj8NUPzBccgp12sOM8XxkoIfd5QcdIV5jEqohuIYHVfCT0SqiGYNsBpccKMzQfQh8/a3biW6wza4gUcjox/0Cg0NFj7w4BDNeEbED++XH2uhiEd6pLM6XLLV3Xhc18X+TSZMNKIhtuafMGH+xQ5UmufzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773987402; c=relaxed/simple;
	bh=SdRPGYTXPRHX3SktEP4LYmBCUPLpZR553fNy5vcRF/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pR23c7m/CON36c5TeBkcStClDACY4xITu+LbE3gvQoKHX5mBxgq9yITO9OP8+NgmJM7qm9RAvGN3rgAuPe32VdF7oKABTdGhzE+Lycqdc6gGilEN56oeBpohEpZMrJlLyJzbIAENButOMF9Ruw+piM6LXkw5TS58vIYtKezkO9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=UF2ggUb8; arc=fail smtp.client-ip=52.103.67.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLPN2X9C/doyJ7ubX9UWx3FQEcejqQKW8OqDVj+EUqGYkJIky5Q6fcbZkMeeMs2Q/iPpzQ7Ko3IV7xCt2ohb+l56ZAKCwtr2gkIlMIjB/HRhSiYOW6MFlJPV3aUwdxr4KTO/ChrZrdDCP4mnbB1V7cOxTfiVSEl3r0AlI/3qBpBe7K9Uq75VluOMQzu2RB+W61mVbTxGUz9sf4zjaqwwfUC4Bw5rW9byMz8A4/tRwsEv1LpZQAUc6YWnfQKetEgWtKvTjaFU2bNjSPYXubixW69gZG4tdhiNG+CXZA1vzRUvPi8VSnpM/DTHfgaQAhFklBnWv2ZxBv8nWwOekLR8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdRPGYTXPRHX3SktEP4LYmBCUPLpZR553fNy5vcRF/U=;
 b=ZAm3f3RbEl0jty9mcHc2Q1wJdfmPZ5PbEatDUPd1NliIUIlUNQhSd05H6kEftDx4LnOSwjJGfoPCvHj58OsQToFIsKc5174Ukce0FSovGz+sb4QM5JYpPeoEZfILr1cwp6upYCZqcexpZvx7M73JcTfWdAi8l/I/v+i7TtTejw+r6zfp1arL9kuMzliPQL0cUdSKN2B5mrlZZ7DL6dqWKYJ+s/Ig6sWl3B26MaLiZRDW7JfLtfE/XKvE3kgfnD33fpiQOT3mALKW0s2ciodm/48VIgvMNyxVWtCUUWh8HxPYfdIejf8/2cns7A2CuEKi3H2aP6ZNDvIJ+cIJTTP7sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdRPGYTXPRHX3SktEP4LYmBCUPLpZR553fNy5vcRF/U=;
 b=UF2ggUb8qNtDmPGRBYy8+Ej9u0RafrMj7gnS2Yq0aAeOfo+akEAmNJmdboTQQbWPfN/zz2CH/Ze/FKJ6sU/9OKUOn2jw48xBHv+iNORnlXpLkdAm70JqH9zuEXKceD4ExQMbUSyLndRJnPhFDtIpfru5OyyhbJ76ULkZ1wQM0cfI9iAF66oPHu4a1C7r0taxLmeQP8u/0aesAsRwZeSKQjHk9Dsfg7fuPOZcnehP8kqMUeTj9Ac75Ai7DBZDaMo4/BOGdP873Lry7cIrjtgiNmQ0OFjk/rOIw12GeM+mK+z4eZLffQuzbGKqjkD7vYZTVaA60C2omIf5jHgNxzZ3sw==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by MAUPR01MB12738.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1dc::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 06:16:34 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9723.019; Fri, 20 Mar 2026
 06:16:33 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Masami
 Hiramatsu (Google)" <mhiramat@kernel.org>, Dirk Behme
	<dirk.behme@de.bosch.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] Revert "drivers: core: synchronize really_probe()
 and dev_uevent()"
Thread-Topic: [PATCH v3 1/3] Revert "drivers: core: synchronize really_probe()
 and dev_uevent()"
Thread-Index: AQHcuDEQA1rzyqx9bEimWJTAf5rC8Q==
Date: Fri, 20 Mar 2026 06:16:33 +0000
Message-ID: <75F8FAD9-964A-4F87-8D71-AEF166D9E10D@live.com>
References: <20250311052417.1846985-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20250311052417.1846985-1-dmitry.torokhov@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAUPR01MB11546:EE_|MAUPR01MB12738:EE_
x-ms-office365-filtering-correlation-id: e2b48a08-b678-49fe-4a4a-08de86483c1f
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|8060799015|8062599012|19110799012|25031999004|8022599003|461199028|31061999003|10035399007|440099028|4302099013|3412199025|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?utf-8?B?aVdVNGZPc0RVVzMxMkZPTG5KUjhEMG16L3NXRW9iNTVNV2FmT0JJM0REZXZh?=
 =?utf-8?B?TlJ2MUtOWTVsZGM0NFBuTUZYWHBwdExxUGl4d2taM3ZnUXpUc3JOVGxpOS93?=
 =?utf-8?B?YmFIMVhHM0RjM3VSUTNJNmRUaCtLR09QbEJDb1hOa2dSSXBtcDRmZ2YvN3Fk?=
 =?utf-8?B?RUpQR0E3OFgvZnBJNDE2b0hZYlZ0Z01lRjZzRE9XV1ZXRFpJaitBdFNmTHNE?=
 =?utf-8?B?aUZwS1JjcEVCaXF2aUlhSkZFWExPTk1pWklDOFVjMzAxN3cyWTFiK2pxVS8y?=
 =?utf-8?B?elpjYWZHRTN3M1o5amRMOEdiUmFZNnhSV05tWEZRMGsvUytFTmFaRkhXcktj?=
 =?utf-8?B?SjdMSGNMM2pqc2NDMEZqTW1XK1ZsQTQvZUp0dXJBZW1VRzluSFMydFFIZUEr?=
 =?utf-8?B?Q21Ta1JxQ1JYR0o5NmJ2NjUyQWx1SVZzNmI0K3hPcnFqUjJ5QlFud2VzTHEy?=
 =?utf-8?B?ai9sS2dOb0N0Wi9zcnZhemFZelRQdE96djZOUTdlRE10V0xyVGEzOWg1RE9o?=
 =?utf-8?B?bzJVZDNlRXVpRmR1cjNGY01EMXZQV2xmbGY1RDZrZmVHbG5qUDM4M1d2c0hE?=
 =?utf-8?B?K0dsZzdUYTNGNFFyVnJyTjIrTmZPOU5SR2FzRUxLbEt4bC9QcGJxYURYZG9V?=
 =?utf-8?B?ZWJFQWxUQnZUOVNOV1EvR0NjVW9rbklkc21wSnJic3RQU0xVZG9lUU90b241?=
 =?utf-8?B?UHErcHB3Ulh2dDMwY24zeUYvM2NyRGxVVXFEbGNRc3hHVlVwbUR3VlEzT2gr?=
 =?utf-8?B?aThWN2hWOUcyZlFqQ0M2QTF1c2M0b3Q1V09pMklNYXhwSFI2aDRFUFFRbDRQ?=
 =?utf-8?B?dDJyT2JpNmh0Z3d2S1N1NG5kZmtzYTRKTW5SenhIZkRBMWU3OStTUVFqSkgw?=
 =?utf-8?B?dnA3bG43Myt5WlVBdkdpQkNscVg0Snd6clZYMVlubk9VSzRQZ0NROFUrVTk2?=
 =?utf-8?B?M0I3aG5OdkhnaFpaMi9uTEZXNjZFdjJyTXNXM280bEZDbytMZ1JCTnREL05M?=
 =?utf-8?B?VG03OWVJQkx5WW1VZ05ZeGJDeVlIQzlCbHVpbGJxWGl4SmhKVFZqQWl2ZEd6?=
 =?utf-8?B?S1VUZng2d1o0cFFDRWNVVVlZTFNZUURuYllxNmFWalNsMFluVzY0emRQMmty?=
 =?utf-8?B?NU52a3Rrc0UwYUw4UXRKU1VRN01ISVRUN0ZaNXlwNm54SEdLSG9Kc1h1RVdH?=
 =?utf-8?B?T0N2Y0hORlFZbnNZMG1HWUp5OUtjTDgwcWs2MUtCZTVlbXlFMVMrZWNMYVNy?=
 =?utf-8?B?UVFDNEdqOWUvMmd0Q3FyUmg1VEk5VEc2RzdGWVZaYWV6dHdyM2lVWnJZc3NE?=
 =?utf-8?Q?cj4zoEKfb2eZI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODdIM3NHbEp4WURxelZiL0srRy83VkdFK2NiRFRvdWo1c1BFaUt1aEF5Qlph?=
 =?utf-8?B?YW9xcE8xU2FiZ3BOMnZ6bTk5clhzTjJhclNTTElHbzNCNkhRNm5MN3RSM0Ny?=
 =?utf-8?B?OVZyeSsxeEZSOFJjRWs4OUd6Qi92eDBNQTVJYUFmYkRiMzlEaE02VjdyVVlw?=
 =?utf-8?B?a0dWaFUrb2xodEFuQ0VqZDQvTzY0dzBUZ2xrdXBBcE53V2dSbXlSU2UzY2pj?=
 =?utf-8?B?bkNhS29MVkp5S2NtWkp1MWZlK1J0YjZKTFJBMFc2Nll6UEY3MmpkWk5FT2Iz?=
 =?utf-8?B?UkpJR3NwamthRUV0Zkh5S0RZTy9iQjNLdkVjRXNyK3liYTMzQ1lxRk1ndXIv?=
 =?utf-8?B?ejc1bjFnbXFheUxHODZTa3l4NWF5ODBsSG9PdXRkMzUxUFhNNnRYOUlSbFhu?=
 =?utf-8?B?NGdFWUJ3ZWM3aXNSYitqUXU5WHZYZnJtY1kxNm0rNXM5NjJyRFNTUzRwb1Qy?=
 =?utf-8?B?WndGQVR6emJPTWVnRVVlSURvMFF6MVdBaHBhNnp6dVRlRkhWcFBjbU5pczNV?=
 =?utf-8?B?V245RGNqVjVVMFVyenRrR1NHazRHajBveTBlTFQwa2VkM3BBZFY4eFkxa1k0?=
 =?utf-8?B?UWdqNXozQStSaXFBQlZKK0dlNHJraDUxaVBXNldSSUp0MDVJRHpZWTBycmw0?=
 =?utf-8?B?VERySzhMZVJiOXo2bjVOVFYxZFM1Y3pMNXc4Umk1ckJFLzR6Q2FtQ0oreFN2?=
 =?utf-8?B?TzB2U1FmSzU1OGgreERlL3ZnSEFlSjNiY29SU2VxWFFtcjZLbVBjYnFpN3E3?=
 =?utf-8?B?QkttaEtRYWp4WCtjOGtWOHVrT09HL1M4RWp0ZTBQMjlpNUd6SmxBZjd5VFRz?=
 =?utf-8?B?RkFtN2RoaUVqTVpvQW5pYVczMkxxdEhVUmNtR2VObVlCSGMyc0xEY0VXdVlE?=
 =?utf-8?B?VmZPdFJEcXdKd2ZaOWp6WDdqVHoreFFuTW5SNTJOWmdIS0tuMVpTeHp4TnFp?=
 =?utf-8?B?NlFIbjA5aUF2Y1VxdVFqVWlqM1YrT0dpMVVCOHhIRUFQWHNra3g1SXdvRkJO?=
 =?utf-8?B?b0V3MHNGQnduWWE1Ym1ZTkZlVEhvdmpDbkZhSVA0bG5zKzlDd0h0QytUbWVS?=
 =?utf-8?B?NHJwS0MzSVVmSExmZUNQblIvYmNUdE5Kc1duTTMwSGpSdTNsMzg4a3IvZytQ?=
 =?utf-8?B?T0ZwNEZYck45VllCeVJ3cURkUjhuMDBrR3o5N3FPZzZiYTlzZlFUZjE5Wk5F?=
 =?utf-8?B?Q2xvMTJuSjBqRzkwOXpRcGFjRkVuZ0kyZWdQUDkxZ2VsMUE1b0FaQ3J1NjVs?=
 =?utf-8?B?U0hONEw3R0lsZDZyL0x5UWhsSzlFWWswZlliRFdPb1lZQzBvYll3cllpZWN3?=
 =?utf-8?B?Q0ZHMHdmcElsUzBBUk9KVTJZNURCTUtIV0pUQnZEWkh4WTg1RjJwN2FOTFBr?=
 =?utf-8?B?T2p1Z3FQUUNtVnA1SVJQOW9lRTdwVVdpNFZGNzYzZXZTTFB1S1NlNlFkd2px?=
 =?utf-8?B?bE8vR0ZDQlpvMUo3OEdsWjVZbUNldWZiMStJYWRjRDFzVU83Z3p0Wi9VNEZ5?=
 =?utf-8?B?Tlh2bVF5MlBNeU96VlUzYjJtVEowUU1QTS9aeDFuWGdRZ3UrSHgySWphU1M0?=
 =?utf-8?B?TWFkVWZFZ1JVQTMvM0dUU2E1WFFJZzlIZHpobWxwSkl2dUZ4bk9DVFFZdzFN?=
 =?utf-8?B?dHFIMjQ4eUV1Tmg4YngvNmlLcVZqTlMrZnFBVGtRdjZMaXI2WWNRVTdseVls?=
 =?utf-8?B?dG5zT0ovV0UvQjVGQURzc0dHNUdoS0VOdlRsSnl3TzMzc3BWRFNGYlp4WVFx?=
 =?utf-8?B?TytsQlRFS1FLSHpPUEZuS0FlUWNLOXZRYmhiWjAxWll6SHdDOHlVSzh2UGFU?=
 =?utf-8?B?K3NrUThqd1I0VTA0OTU3SnlYSWtFTFphckw5TEFCVERJcldVcHJmeWRFdHVU?=
 =?utf-8?B?MXNFYUtiUDkyMVU2K0tkRElLV0Z2UC91T3k4aVNNeGMzUDRMLzZ0ZUtZUVc5?=
 =?utf-8?Q?UejZ2zfystnJVP9qEGd+m8TWrI2kZMQ/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B004F25E64DD7A408F80DB41E19C38FB@INDPRD01.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b48a08-b678-49fe-4a4a-08de86483c1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 06:16:33.7052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAUPR01MB12738
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[live.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[live.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227435-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[live.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.595];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya08@live.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[live.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF3C72D632D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gT24gMTEgTWFyIDIwMjUsIGF0IDEwOjU04oCvQU0sIERtaXRyeSBUb3Jva2hvdiA8ZG1p
dHJ5LnRvcm9raG92QGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBUaGlzIHJldmVydHMgY29tbWl0
IGMwYTQwMDk3ZjBiYzgxZGVhZmMxNWY5MTk1ZDFmYjU0NTk1Y2Q2ZDAuDQo+IA0KPiBQcm9iaW5n
IGEgZGV2aWNlIGNhbiB0YWtlIGFyYml0cmFyeSBsb25nIHRpbWUuIEluIHRoZSBmaWVsZCB3ZSBv
YnNlcnZlZA0KPiB0aGF0LCBmb3IgZXhhbXBsZSwgcHJvYmluZyBhIGJhZCBtaWNyby1TRCBjYXJk
cyBpbiBhbiBleHRlcm5hbCBVU0IgY2FyZA0KPiByZWFkZXIgKG9yIG1heWJlIGNhcmRzIHdlcmUg
Z29vZCBidXQgY2FibGVzIHdlcmUgZmxha3kpIHNvbWV0aW1lcyB0YWtlcw0KPiBsb25nZXIgdGhh
biAyIG1pbnV0ZXMgZHVlIHRvIG11bHRpcGxlIHJldHJpZXMgYXQgdmFyaW91cyBsZXZlbHMgb2Yg
dGhlDQo+IHN0YWNrLiBXZSBjYW4gbm90IGJsb2NrIHVldmVudF9zaG93KCkgbWV0aG9kIGZvciB0
aGF0IGxvbmcgYmVjYXVzZSB1ZGV2DQo+IGlzIHJlYWRpbmcgdGhhdCBhdHRyaWJ1dGUgdmVyeSBv
ZnRlbiBhbmQgdGhhdCBibG9ja3MgdWRldiBhbmQgaW50ZXJmZXJlcw0KPiB3aXRoIGJvb3Rpbmcg
b2YgdGhlIHN5c3RlbS4NCj4gDQo+IFRoZSBjaGFuZ2UgdGhhdCBpbnRyb2R1Y2VkIGxvY2tpbmcg
d2FzIGNvbmNlcm5lZCB3aXRoIGRldl91ZXZlbnQoKQ0KPiByYWNpbmcgd2l0aCB1bmJpbmRpbmcg
dGhlIGRyaXZlci4gSG93ZXZlciB3ZSBjYW4gaGFuZGxlIGl0IHdpdGhvdXQNCj4gbG9ja2luZyAo
d2hpY2ggd2lsbCBiZSBkb25lIGluIHN1YnNlcXVlbnQgcGF0Y2gpLg0KPiANCj4gVGhlcmUgd2Fz
IGFsc28gY2xhaW0gdGhhdCBzeW5jaHJvbml6YXRpb24gd2l0aCBwcm9iZSgpIGlzIG5lZWRlZCB0
bw0KPiBwcm9wZXJseSBsb2FkIFVTQiBkcml2ZXJzLCBob3dldmVyIHRoaXMgaXMgYSByZWQgaGVy
cmluZzogdGhlIGNoYW5nZQ0KPiBhZGRpbmcgdGhlIGxvY2sgd2FzIGludHJvZHVjZWQgaW4gTWF5
IG9mIGxhc3QgeWVhciBhbmQgVVNCIGxvYWRpbmcgYW5kDQo+IHByb2Jpbmcgd29ya2VkIHByb3Bl
cmx5IGZvciBtYW55IHllYXJzIGJlZm9yZSB0aGF0Lg0KPiANCj4gUmV2ZXJ0IHRoZSBoYXJtZnVs
IGxvY2tpbmcuDQo+IA0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2Zm
LWJ5OiBEbWl0cnkgVG9yb2tob3YgPGRtaXRyeS50b3Jva2hvdkBnbWFpbC5jb20+DQo+IC0tLQ0K
DQpIaQ0KDQpGb3Igc29tZXRpbWUgdXNlcnMgb2YgdGhlIGFwcGxldGJkcm0gZHJpdmVyIHVzZWQg
Zm9yIFRvdWNoIEJhciBzdXBwb3J0IG9uIFQyIE1hY3MgKGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2RyaXZlcnMv
Z3B1L2RybS90aW55L2FwcGxldGJkcm0uYz9oPXY3LjAtcmM0KSBoYXZlIGJlZW4gZmFjaW5nIGEg
cmVncmVzc2lvbiB0aGF0IGNhdXNlZCB0aGUgVG91Y2ggQmFyIHRvIG5vIGxvbmdlciB3b3JrIG9u
IHJlc3VtZS4gQSBwZXJzb24gdHJpZWQgdG8gYmlzZWN0IGFuZCB0aGlzIGNvbW1pdCB3YXMgZm91
bmQgdG8gYmUgdGhlIHJlYXNvbi4NCg0KVGhlIHBlcnNvbiBoYXMgdHJpZWQgdG8gZXhwbGFpbiB0
aGUgd2hvbGUgc2l0dWF0aW9uIGluIHRoaXMgR2l0SHViIGlzc3VlOiBodHRwczovL2dpdGh1Yi5j
b20vdDJsaW51eC93aWtpL2lzc3Vlcy82MzUjaXNzdWVjb21tZW50LTQwOTI5MDczMzUNCg0KQW5k
IHRoaXMgc2VlbXMgdG8gYmUgdGhlIG1vc3QgcGxhdXNpYmxlIGV4cGxhbmF0aW9uOiBodHRwczov
L2dpdGh1Yi5jb20vdDJsaW51eC93aWtpL2lzc3Vlcy82MzUjaXNzdWVjb21tZW50LTQwNzE3MjAx
NDgNCg0KVGhhbmtzDQpBZGl0eWENCg0K

