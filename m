Return-Path: <stable+bounces-163625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A1DB0CAE9
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 21:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0374E188B2F3
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 19:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4BD2222A9;
	Mon, 21 Jul 2025 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TpnJyeBD"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED4225403
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753125318; cv=fail; b=VTIL0d59U0gBa9Lg/JBe0jR4SdGZEsHbpOHYMUm7IsF301bdgOVTbLm4y0fjplC5A5eStTFncHtFoDLJvuo7l48o8YFfofb0m1X45xgVp6Qeo92mfwDd2iyFsW1DjfFGjo1c1iW9Mom7J275UM0aOtUas3h9SCKZjvCARfOi7gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753125318; c=relaxed/simple;
	bh=kvP+13ZXLPlhEiknAkDt+e+o4JNooXcPqhz0yZy0qNM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gdUeTxowmHVXVmFJ1HltY40GvncuVvC7OdL0ryUCOW64hPmRCZn9s5cBFQeHeGVeZaQof/g2qVeRec2Qgt2mFqbaps8ALq+32aC1Oqx8EInWO5PJeZhi+laUHeKi25KahuhxqJY6T6omGfAeUi7q1YiI+9FXxMbPKZtoSUtvYSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TpnJyeBD; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIHloPNmx4DVCI/aZslEO6Iy5979/cJawHgBxmwkJr39LHmiA67hkT8B4Frcehrz8+sIX9HEWAwVAn+JpzJFfvMP7udc4RrFOXqKU26cb5q7bZlO65FLBPKUZrj+hUP5+XMyMXdsxLjhPJDePscExLS1413ApJvPp5J430r0XyQYN3uWYoI50mzLl1tlHy0otIARn85c6lIj6UmzBoh7gnPf4B0VhdjXilFyEuBqAkF1GBlQ20bcFVBtDhrZgXhsEao8dsbLIVAJXUQHN3TqZlQM3nCZEd1xk+Hvyeb3hMUvABNmgIPdJqvN3yyEVfURHTbsSm6xpG8iQxUZmrpPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvP+13ZXLPlhEiknAkDt+e+o4JNooXcPqhz0yZy0qNM=;
 b=NMvNVFvJ36wf8zBTR/oVupmIhBgihK7hGPSKqJwNpg7G6+0LWpbigbfU6e91P/xljQrfU+MIU3C37laBx3t8xW1zwvCsPbzR0QIcg4vKBKgCcvbibVMC7xHac+4++JjzyJE+xY5uWfigXzeOZacpRy94x8rIS6uf5pa06VTXkXEQAL7jwylhdQT/Sr0qte65RAe7eS9NawFwWovxFvDUdsJ9pjGPbmx1zQDHRy7CPCVD+nhMNb7uujqDImD0S6sFVjrnfuG2KuzImtshl6OZVLCEI5lvfHMjRZcuPCcPy59t7EPyC/8U0VfVQCSL0aG70Ee+2C0mUYnfiAgLv5qnpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvP+13ZXLPlhEiknAkDt+e+o4JNooXcPqhz0yZy0qNM=;
 b=TpnJyeBDQXSrflqK4Ce9+wOzYPFz4nTeqQGUxQAmXmnM15/Mit42udfjG6JKAGVl9mieE4buta26F4m24yrkk5LIw8yWy5/wMfaEexWrUa3LrTpvTORAOtmxqDwJ0Nr+ia80Vr4eJTdcPxFsfvM/UmBAS4ZJ2dudUtk8N6HlwRk=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Mon, 21 Jul
 2025 19:15:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%3]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 19:15:13 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Mario Limonciello <superm1@kernel.org>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] Revert "drm/amd/display: Fix AMDGPU_MAX_BL_LEVEL value"
Thread-Topic: [PATCH] Revert "drm/amd/display: Fix AMDGPU_MAX_BL_LEVEL value"
Thread-Index: AQHb+kWC8I+puw2mjk+jabXfQ3Alv7Q88waA
Date: Mon, 21 Jul 2025 19:15:13 +0000
Message-ID: <ead2f2f1-6627-4884-87f8-932f38d54803@amd.com>
References: <20250721134350.4074047-1-superm1@kernel.org>
In-Reply-To: <20250721134350.4074047-1-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|MN0PR12MB5978:EE_
x-ms-office365-filtering-correlation-id: 8fd7e644-8479-4961-3af8-08ddc88aeb5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d1R1bEZTVGJGeTlnaUZDdFVVTy93M3E5Rm5LTUwyN2tCWUdoMGlFL2g5NytF?=
 =?utf-8?B?R3dYdjYreW83RFhuWjhQNklWdERteVNpelQ2aXE1Q282ZGRqUEhwN0cwNXNE?=
 =?utf-8?B?b3ZFbXdQbXFadWpLQXJJT2g0UmdRMEwyUU9tMWJsbmp1RWlvQ1hrWlFZL2hR?=
 =?utf-8?B?WStCbDYzakJiSlFJdUxLZmxLdVQ3QkFCaEVsZC9UZWZjemUxdXVvY3VxQUM4?=
 =?utf-8?B?bkc5dk1jdjBLTnFwV290eEtDMTV6K0JJYTZxbU9KSUk3Z1c5TXJxVXRTNVlE?=
 =?utf-8?B?NEtZa3hXRXhhVVQ1MjB0L0Z2TFFuRDhCQVBzVEdYZlRpRkpuLzhTSnJONEtu?=
 =?utf-8?B?d1Z2R1NxWXoxTmN2emZZb3R4L1pmV0ZiQzlXYWlRWlAvV2Q5T0pxNFJTamQ1?=
 =?utf-8?B?RWdGQmMrQTIxUXFGYlBTQjc5UFZmbmxSK25sWjVXdmt5NDB3Tk1lenByY1Mv?=
 =?utf-8?B?NXc1VktzMmgrNGRWZWVwcEg0Ui9wZHpJVWRpNEEzTlBwVWdncjNBbThuSnJ5?=
 =?utf-8?B?V29qb1dKSlpoTHoyMDJDYS85K0ljR2FXbiszL3YzS0Jra0xVdFo5U2hUUFEv?=
 =?utf-8?B?L01ETmg0UkM4OGtNUXpHSStSbWpmTU9sTzl5aDVUTndPU05wVkZEOXliSjd5?=
 =?utf-8?B?N3ZQM21rSkE0U2tpZ3VLSWdHNWpDaS94OWRtRnFjdjRqYi9uMm0xTkt2cGdq?=
 =?utf-8?B?ZlhienQ1Rmc2NnZ5YTBMcFpuQVN3S0s3Q1lRUkhRRTFhQm0vTFhpN0lSZzNV?=
 =?utf-8?B?dDQvbEo4bzFQbGJGLzhGYyttQ3QzS3N3OUx5RGY2bXRhWUVEc3lJeWpCN3NK?=
 =?utf-8?B?NUdMNmdjOHpXdUVZN0RrUmJyMVY1ai9GS0hWdWhYUmZuRWlVSUhoZ01qSTZX?=
 =?utf-8?B?M2NVVVdqeDB0V2t1V2cwYnlYaXdvenVNL1pFTlVZUWUxWDQzdkcyWGE5V3Vn?=
 =?utf-8?B?UDZQbmZab25TTkZuTHVLQ2ZWaDZ5MHBUV0FGc3FuOVBJd0E4K2l6LzQ0amZS?=
 =?utf-8?B?VmRZNjQ1SGRmeDZ3a0pLTFYySzY3M01IcGhnMHhjTjVSaGZYejlaN3ZGZW5H?=
 =?utf-8?B?T1N0Sm5kYWVvelhDMmRZZFNkbXhicFVoaGwzdEtEMDY2VXhwdDhOWHZSUCtR?=
 =?utf-8?B?WHJWa1AzMU9sVzlTbm9kMjd4K1ZjdmZXU21tS0ROTE9rckJCclY2dFhTRi9t?=
 =?utf-8?B?amV1aklORk1XZ0pEbHU3WEJCY1VyNm95KzB6b2VlOENhNXJNa0Z0NlM3VGtr?=
 =?utf-8?B?VkxDdFppYlJMVzFPTnBKTk5Vb3d3aU44ZXBrMHpkck9XVzd4K3ZvMmJqSjhG?=
 =?utf-8?B?QzV5TmpVeHgxcnFJQUp4aEFKclpCWkpFLytvT0pWQm9nS2tYYUszOFphVWFh?=
 =?utf-8?B?Wm9RMjdLV0NDbGxHc280VlpVaWRxZXFleUxjTFNCVEZnWWhhSDNXRHlyVFZV?=
 =?utf-8?B?RlhwcG9GMU5NWEttY1NGMlNWQk9DVTB6YUJlQ1NNNEhqN1RUb2N6dkZpUXh4?=
 =?utf-8?B?bDZMNnZ3bVRsQWIzdmQzL3c1eHdtSnhVWFplM2Y1b3M5WmZZSHZFTjRLSTZl?=
 =?utf-8?B?d2JrVHd2cG1LRXd6Mzh6S09UalpiZGJML1pYTEZWRjFBeS9JUmdubUV2RU80?=
 =?utf-8?B?OFpGYzZmd29ObVFiNTVPNGRwN0xMc25PQUNpNVpqSVhTdzE5ZlBQVWREeWVK?=
 =?utf-8?B?S1VvekN5RUdyN0xSMUNqRDNkUjY2R0RKNjVkYmpWS1c0MzEzTDU5VklGMEls?=
 =?utf-8?B?Yjc4T0IzVmFBUC9pRW0vWmhPUGppdEZQYTBoODgvZ3I2UWhGSUYweHFSL2Rk?=
 =?utf-8?B?ZDJMMTJwVmZ6dG05TllwcHhOSjBYR1hpdDZJRlhEVms0WnpuWFZwNGQ1K1RI?=
 =?utf-8?B?cVR3cGcxdXdKNUlXMWJBNVRlWjNKUjJwMjJGR3JSNGhOL1pXUC8rMXhydFdI?=
 =?utf-8?Q?c23hC3h8S2M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDY3dlhlekhydmx1bEhHNDVIaXBWcVUrc2lvaWVNeHpXK2d2SlRSRjdSaG85?=
 =?utf-8?B?NlNtbWY5VlB3WUNydm5XOExFUFZIL1cxd0lYcUU2a2tkd0VlemxHcEZ2NTJ3?=
 =?utf-8?B?bXdHZkRVb1dXcUdxdE4vYm5pb2RGellMVmQ0MkNWdTdWMHZleTAraHQ0eE4y?=
 =?utf-8?B?S2ROR0g5M2U5L2tyNDBRTWptcklnamZzNU5yVTNQbk9qc2RlZ0hCY1AxY0du?=
 =?utf-8?B?STdrOW5kTHdsbjVjNkhnWGhVQW1mQnFJN3l2SGN1NHgzZmpGaERnVkwyM3BV?=
 =?utf-8?B?WFFHQXNoL2pWQUpnSWJ3bHlKV2tIZUdMTUF3NHNYQUFYcC9RdENBM2VvSG9n?=
 =?utf-8?B?eDFFK2NYcFBMRVRGanl4c0dCNzZoVmRBTXY5VUhncTJvbWVLUVZjdjRyaEw4?=
 =?utf-8?B?WFBrcE5wUlQ4NnlUMXZzRkV2VWhnbHN4TTVUY3Vvdkp0d0lNc2FQS0pEVkZh?=
 =?utf-8?B?ZTVEblB5TDA4L09VVUE2OTExTGNkWSt1K1pEbldKUG0vS1FDVmRtZzc0dTZm?=
 =?utf-8?B?RW5UaGcrQ2dSS1lQaGRwVldLK3VhbW9xV0pnVEhHZ0M1dU9VWkhIbEI0dGZV?=
 =?utf-8?B?SzFpS3BjRDNpb2FEbEFpSHhSbEdZbEpTdnk1TDdKRjRxU0YzamltRnVzM3BX?=
 =?utf-8?B?MEk4QU1MSENQZ2dBQngrTVE2S3VXcnFEaW5CZHg0eWMxWVlwWmRtSkhRYmI1?=
 =?utf-8?B?ZFNQVUlZMm9yNEVybm9xUXdjYWZ3eDBJb2t2Q0k4N3FpVFZCbVhPTWFQNzZD?=
 =?utf-8?B?VDhRN0JXMi9xaFZsQ2Vta2p5T3luL0ViY0cxN2ZaYWVCQnFrNzd2OFFrei9R?=
 =?utf-8?B?RUZ3N203TEVHV1VlcUdZcS9wZXBJNnFia2hPRFJZRW4vZVVJUjIzT2JyclhW?=
 =?utf-8?B?bmZtZ2w0L3YyTEliOUtpQ290akZmck1sSUpzbmMwSUZYVmFEaVZiWG5jSnQw?=
 =?utf-8?B?NjlzRjNCa3I5RTcxSkRkTG5IZThlSWlWRGJtNG93RWhwUHFudG95SUtReHFT?=
 =?utf-8?B?VGRxbGRzQmJtbjNkbWlFdmRGaDNUTFNMdTdSMWNycUZEcmtTYk9LQS9qQ0Fq?=
 =?utf-8?B?U1BQNENtRWoyazJyakRuSDNabE5PdzNGUU1Lc3ZLbG1GQ3kxVWVOUXFZRWlF?=
 =?utf-8?B?NXpCVkZwbXB0ejF6aXRpN0dVSkw2UHdCZEljS0svcU1kMTlmTm9OQjNWdmJ2?=
 =?utf-8?B?eUg3em82UUZkY2gwemxFdFRYdDZRN29sZmt6aW5QL3VwWFBEbWFTeGlKMXBn?=
 =?utf-8?B?Rno4QnFHcW8xV2wvNTg5OXNFTnp4TXJMQVoybTNaak9Ma0kyUWRtQU02Yjh4?=
 =?utf-8?B?ZWF5RVZjL3FHakd0Yzd2NFVQSzlNUVZhWndCanJjSXZiVTkxemUyTWxBNjdY?=
 =?utf-8?B?cXRtRG5HbERac1c0WTdvQ0ZDbUFRRmFGRE5uemhaT2IvY1Vrank2aVNzMHVo?=
 =?utf-8?B?cW1WU28vOWlZOVVKMG15UXkyKytNbXBZZDJPWVNWbFhOd3Z3U0FXUlVaR3JC?=
 =?utf-8?B?MlNxZHNJb21Md21BZUhxZTFqVmFGc3YrVXIxeTMwb3NqdUJ5KzlsSWJyY1JR?=
 =?utf-8?B?bFFKdXNJMEI1RTE3bDI3OXBMZTc2dnFpTURuMlV5a0NscFVaMHFDS0NhL2xZ?=
 =?utf-8?B?Y0doeGpKT0RJNmxTY05hM3NHMUYxc2lkdG9vUFZqM2RHOC9SOWh0VTVXaUtI?=
 =?utf-8?B?UHZtbDRqY1NLNnQra1JISTRKZjFzQlJ0N2c4RWFOam45SHRWUCtEa0pnN3I4?=
 =?utf-8?B?MnViNDBnOHU5cU0za2RGejdlaE1qM0g2V2JUYkQ4cFE5M3pVeGRUNy9ib0lQ?=
 =?utf-8?B?MnNETC84V0pDa2VKM0VOejBwbTRzY0pBemZweEgvc0pxa3h1cFpsSlVXcjZL?=
 =?utf-8?B?QkZNdkdHNEdMMXo1Y2NKVDBJSjVTN3lBS1lrQVRTbWVTVnY0R3lpdis2eVNW?=
 =?utf-8?B?YXpLcmtEbFdUSmk2NFcwNkxRVlVEVVR0eEx2SThtcFZhWnJyRjhlZktVSlBy?=
 =?utf-8?B?QXNOZStBYlpmd283VkVYU21BbjdUczgraExRVTA5b0JKeUQyUk1Pd2ZCMExa?=
 =?utf-8?B?N2NmRVg3NnpjWUQrVEJoeE1UNW42QWU0Tk02S2hzZ0Z3Vk14emhSakFRMVRV?=
 =?utf-8?Q?PAJQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E90780B6CB5114C8AE19833432439FC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd7e644-8479-4961-3af8-08ddc88aeb5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 19:15:13.5638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v4GHe8O3lFY2KDiyAlVMhFjAIsTUnnHp60TRzRxWhs2YEDgGVFTl/mi/TspAf+YyvRxHAS2neBb3pAz5o8JuaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978

T24gNy8yMS8yNSA4OjQzIEFNLCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90ZToNCj4gRnJvbTogTWFy
aW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+IA0KPiBUaGlzIHJl
dmVydHMgY29tbWl0IDY2YWJiOTk2OTk5ZGUwZDQ0MGEwMjU4M2E2ZTcwYzJjMjRkZWFiNDUuDQo+
IFRoaXMgYnJva2UgY3VzdG9tIGJyaWdodG5lc3MgY3VydmVzIGJ1dCBpdCB3YXNuJ3Qgb2J2aW91
cyBiZWNhdXNlDQo+IG9mIG90aGVyIHJlbGF0ZWQgY2hhbmdlcy4gQ3VzdG9tIGJyaWdodG5lc3Mg
Y3VydmVzIGFyZSBhbHdheXMNCj4gZnJvbSBhIDAtMjU1IGlucHV0IHNpZ25hbC4gVGhlIGNvcnJl
Y3QgZml4IHdhcyB0byBmaXggdGhlIGRlZmF1bHQNCj4gdmFsdWUgd2hpY2ggd2FzIGRvbmUgYnkg
WzFdLg0KPiANCj4gQ2xvc2VzOiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2Ft
ZC8tL2lzc3Vlcy80NDEyDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IExpbms6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FtZC1nZngvMGYwOTRjNGItZDJhMy00MmNkLTgyNGMtZGMy
ODU4YTU2MThkQGtlcm5lbC5vcmcvVC8jbTY5Zjg3NWE3ZTY5YWEyMmRmMzM3MGIzZTNhOWU2OWY0
YTYxZmRhZjINCj4gU2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9u
Y2llbGxvQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9h
bWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAxMCArKysrKy0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYw0KPiBpbmRleCA4ZTE0MDVl
OTAyNWJhLi5mM2U0MDdmMzFkZTExIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMNCj4gQEAgLTQ3NDAsMTYgKzQ3NDAsMTYg
QEAgc3RhdGljIGludCBnZXRfYnJpZ2h0bmVzc19yYW5nZShjb25zdCBzdHJ1Y3QgYW1kZ3B1X2Rt
X2JhY2tsaWdodF9jYXBzICpjYXBzLA0KPiAgIAlyZXR1cm4gMTsNCj4gICB9DQo+ICAgDQo+IC0v
KiBSZXNjYWxlIGZyb20gW21pbi4ubWF4XSB0byBbMC4uTUFYX0JBQ0tMSUdIVF9MRVZFTF0gKi8N
Cj4gKy8qIFJlc2NhbGUgZnJvbSBbbWluLi5tYXhdIHRvIFswLi5BTURHUFVfTUFYX0JMX0xFVkVM
XSAqLw0KPiAgIHN0YXRpYyBpbmxpbmUgdTMyIHNjYWxlX2lucHV0X3RvX2Z3KGludCBtaW4sIGlu
dCBtYXgsIHU2NCBpbnB1dCkNCj4gICB7DQo+IC0JcmV0dXJuIERJVl9ST1VORF9DTE9TRVNUX1VM
TChpbnB1dCAqIE1BWF9CQUNLTElHSFRfTEVWRUwsIG1heCAtIG1pbik7DQo+ICsJcmV0dXJuIERJ
Vl9ST1VORF9DTE9TRVNUX1VMTChpbnB1dCAqIEFNREdQVV9NQVhfQkxfTEVWRUwsIG1heCAtIG1p
bik7DQo+ICAgfQ0KPiAgIA0KPiAtLyogUmVzY2FsZSBmcm9tIFswLi5NQVhfQkFDS0xJR0hUX0xF
VkVMXSB0byBbbWluLi5tYXhdICovDQo+ICsvKiBSZXNjYWxlIGZyb20gWzAuLkFNREdQVV9NQVhf
QkxfTEVWRUxdIHRvIFttaW4uLm1heF0gKi8NCj4gICBzdGF0aWMgaW5saW5lIHUzMiBzY2FsZV9m
d190b19pbnB1dChpbnQgbWluLCBpbnQgbWF4LCB1NjQgaW5wdXQpDQo+ICAgew0KPiAtCXJldHVy
biBtaW4gKyBESVZfUk9VTkRfQ0xPU0VTVF9VTEwoaW5wdXQgKiAobWF4IC0gbWluKSwgTUFYX0JB
Q0tMSUdIVF9MRVZFTCk7DQo+ICsJcmV0dXJuIG1pbiArIERJVl9ST1VORF9DTE9TRVNUX1VMTChp
bnB1dCAqIChtYXggLSBtaW4pLCBBTURHUFVfTUFYX0JMX0xFVkVMKTsNCj4gICB9DQo+ICAgDQo+
ICAgc3RhdGljIHZvaWQgY29udmVydF9jdXN0b21fYnJpZ2h0bmVzcyhjb25zdCBzdHJ1Y3QgYW1k
Z3B1X2RtX2JhY2tsaWdodF9jYXBzICpjYXBzLA0KPiBAQCAtNDk3Nyw3ICs0OTc3LDcgQEAgYW1k
Z3B1X2RtX3JlZ2lzdGVyX2JhY2tsaWdodF9kZXZpY2Uoc3RydWN0IGFtZGdwdV9kbV9jb25uZWN0
b3IgKmFjb25uZWN0b3IpDQo+ICAgCQlkcm1fZGJnKGRybSwgIkJhY2tsaWdodCBjYXBzOiBtaW46
ICVkLCBtYXg6ICVkLCBhYyAlZCwgZGMgJWRcbiIsIG1pbiwgbWF4LA0KPiAgIAkJCWNhcHMtPmFj
X2xldmVsLCBjYXBzLT5kY19sZXZlbCk7DQo+ICAgCX0gZWxzZQ0KPiAtCQlwcm9wcy5icmlnaHRu
ZXNzID0gcHJvcHMubWF4X2JyaWdodG5lc3MgPSBNQVhfQkFDS0xJR0hUX0xFVkVMOw0KPiArCQlw
cm9wcy5icmlnaHRuZXNzID0gcHJvcHMubWF4X2JyaWdodG5lc3MgPSBBTURHUFVfTUFYX0JMX0xF
VkVMOw0KDQpUaGlzIGJvdHRvbSBodW5rIGRvZXNuJ3QgbmVlZCB0byByZXZlcnQsIHRoYXQgb25l
IGlzIGZpbmUuICBUaGUgb3RoZXIgDQp0d28gbmVlZCB0byBiZSByZXZlcnRlZCB0aG91Z2ggdG8g
Zml4IHRoaXMgaXNzdWUuDQoNCg0K

