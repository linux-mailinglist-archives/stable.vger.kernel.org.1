Return-Path: <stable+bounces-134511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B03A92ECF
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 02:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBCB04A2C99
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 00:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311CD2C181;
	Fri, 18 Apr 2025 00:30:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022078.outbound.protection.outlook.com [40.107.75.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA442A1D7
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 00:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744936228; cv=fail; b=nHJtv7Nc+0nbvIDjbp+/iTnnnEk3gJKXOxHFa3l/g935VkPXSofgBXV3Uf2m9bO69tUC9FS3vkhrCrGIY/SC2O/fQa4lfYWDV0PFBEat3F47d1l3Vlsai7qUDsGj5yTYOAyABmFYPKtbkxzbpOUxnyO/OTjkKnLRGjL2sGwXw9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744936228; c=relaxed/simple;
	bh=uagnJKmy3GR2kMGOE71V6sMOoue7pPRMx9lrMlnxkM8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FFtKrOEJWUb0/ecIQCwkBnudxbcLLlFLIOSDhokjAk0qZapQy/i2h2XmmLFWncp1xbb/BXuH3h7RDcC2iRDTkMCV9kw6FcxBDrOutg+ikHgO7r3UsslthNTm0usqtBjScdrZ47jMg1u5wUcc41bGJkirLc7lF490P091JDNREfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccnCG+pl//WNrbidAOb9DGtkGnREm5F8igTGb2aMRBqAK3A82GD7PA1t78QXYqoUrQCOXKQYp9vOjU5I357/rPex7hJ3CFKa2HzOimMi/1Kb4hWrQV+JLNjtM94REiPIaydOihQ2N2MhSvIZ9iMDQ/tKDC+U4lZc0XgolE7bdbQUIydlkEw919Sd/p73VYeDZpkPkv91H7rDBOakkaI9nG0TihgLkMlnNd91mm7s3gCQ+N38NZkOGhzC4VyoOJDBLw0jmvrwnIilv1GcoH6DWkLBLyMrFLV2wikfBM3F22JRE8aDL9RMcRTTPO53fjUaztx6hwR9FknVXRUInh29Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uagnJKmy3GR2kMGOE71V6sMOoue7pPRMx9lrMlnxkM8=;
 b=jmYD6uGePw+DTAtkQbiIvrTZPBi8SXfpwMoI3yENR1oHTWHYr7oGGjaa0MxxBVxYfOwJNwHYFgy6kEPEOPbcr4t8A4uT+llsL7Bz3/QWAR/82qECJX/gYoPNYRqArDlf7YQlX3qRIvZj0hIlEZbQ/CBRSIyzP402ztcUF7IZ6iB+iXcOhFZt5R1mTr4KNSKgostH6k+KfdrWooC5QrknSlmZktWJr4dYBgyHvtxtTn69/M5hwfHNP9wvd91i+XjxlupglpA/i5HfDyS0+cDe9VbgqmbAcTe1F7v6PtQ3bqeHQu2kE2Cd3us8fiKyaxo/YZmrqbC4f7bFrH46aUBbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SI2PR06MB5386.apcprd06.prod.outlook.com (2603:1096:4:1ed::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.46; Fri, 18 Apr 2025 00:30:20 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 00:30:19 +0000
From: Fugang Duan <fugang.duan@cixtech.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: Alexey Klimov <alexey.klimov@linaro.org>, "alexander.deucher@amd.com"
	<alexander.deucher@amd.com>, "frank.min@amd.com" <frank.min@amd.com>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "david.belanger@amd.com"
	<david.belanger@amd.com>, "christian.koenig@amd.com"
	<christian.koenig@amd.com>, Peter Chen <peter.chen@cixtech.com>,
	cix-kernel-upstream <cix-kernel-upstream@cixtech.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtSRUdSRVNTSU9OXSBhbWRncHU6IGFzeW5jIHN5?=
 =?utf-8?B?c3RlbSBlcnJvciBleGNlcHRpb24gZnJvbSBoZHBfdjVfMF9mbHVzaF9oZHAo?=
 =?utf-8?Q?)?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbUkVHUkVTU0lPTl0gYW1kZ3B1OiBhc3luYyBzeXN0ZW0gZXJy?=
 =?utf-8?B?b3IgZXhjZXB0aW9uIGZyb20gaGRwX3Y1XzBfZmx1c2hfaGRwKCk=?=
Thread-Index:
 AQHbrjQsyP3jhAPl60GLV5n21BS/cbOlnd8AgACKPQCAADjdgIAApZ2ggADQmoCAAL0tMA==
Date: Fri, 18 Apr 2025 00:30:19 +0000
Message-ID:
 <SI2PR06MB5041A0BB912EBBC0032A94B8F1BF2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
 <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <D980Y4WDV662.L4S7QAU72GN2@linaro.org>
 <CADnq5_NT0syV8wB=MZZRDONsTNSYwNXhGhNg9LOFmn=MJP7d9Q@mail.gmail.com>
 <SI2PR06MB504138A5BEA1E1B3772E8527F1BC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <CADnq5_M=YiMVvMpGaFhn2T3jRWGY2FrsUwCVPG6HupmTzZCYug@mail.gmail.com>
In-Reply-To:
 <CADnq5_M=YiMVvMpGaFhn2T3jRWGY2FrsUwCVPG6HupmTzZCYug@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SI2PR06MB5386:EE_
x-ms-office365-filtering-correlation-id: 52e25540-e001-409c-bad0-08dd7e1032e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aUVYekp5OUR5RHVqNTVtby84Q1ZMekYzTVh1U2V5VkFFbDlGTGFDb1FscEYr?=
 =?utf-8?B?RHA0M3BEUE8vZHlIcFNyNmNQTDF3STJqNGpocEtkK0RLQnpsWjRrZThHN3FN?=
 =?utf-8?B?VXAvZDNFcDJzYlFSaWNKK0JzeWI2N3RpUEk4SnJyWlU4RHUwWGsrbHhzZEcv?=
 =?utf-8?B?OFVoaVd3UDdMMEhneE9qY2RneW1IT054UHRPRC85bEdKRm1sNDlpZ2NyNmY4?=
 =?utf-8?B?VjQxd3NQU1EyalRZN1VGOTZwL0IvYXdUNUhoQzNxOTdYRmRDOXBHTTZKWWUr?=
 =?utf-8?B?TDJLRHBxczRsOHRub0dSdUlVY0VxQTgzbldjOHpVVXcyOHRiV3FLUkkvU3NE?=
 =?utf-8?B?SUdRZWpKVjVKblFGbXRwQnc4YnVXcEJ4RjNnNTZnbjQ4TzlqcDlyQkZXNjZv?=
 =?utf-8?B?SThGaEtVZ0JOd2lXNHB5TkdvclNheTB2bmNiSitSZWNxZlA1RCtUOUUyYURH?=
 =?utf-8?B?NnErdng2cnNhZFlsQ09WUU5TdjRMUlJZVmRDNW96cWdsb1A2SHllaytHS1Yr?=
 =?utf-8?B?TC91elM4alpkcXhESFVodmxwNGlCU0E5YjZvVFNFQmVIS0I1MVRjemJWRjJy?=
 =?utf-8?B?S1B3TThMejFudFRRaU0rOEVjK3R1QzdHNllUTFF6NE1CS3liNVR4dlV4U24v?=
 =?utf-8?B?ajR6K3JQeTRGdDhvQk5Mc2pNODhPV241WFB0bERrcVZTNmxGTXRTNnd3OHBU?=
 =?utf-8?B?ZGNlOG1XR0lwdTRYOXAzTmhvYTJ5d0c0Sy90YzFDK001cE5ZS2hDYlZiK215?=
 =?utf-8?B?UnJQMU4xREF1bVF1eXpQOEVUYWYxRmlqVjRneTBRakJWamhyeHNSQWVLcWRa?=
 =?utf-8?B?WHpFV3p5WkhYMVorR0xhVWx3TTYxUHVNQVBLdTNDek1sVjdqTXlBVnRHNlZ1?=
 =?utf-8?B?L09LMm5vV1ZpNkQra3FBdTlGMnNqWjVNZFQ0VjNJZ2JhR251SnZKamVVQWNT?=
 =?utf-8?B?d2d2Q3JTZEYvd0pTc2lxL0o0b0ZmSU0vQlVFdjlTWXpVeWlHbkZFaEdUTGIx?=
 =?utf-8?B?YnFhd2hOdTgvS0t2OXl1S0syQUFCVW9FVm5MQTF0dWtrcUh3YmFFaTlyYVBV?=
 =?utf-8?B?V2NLRCtZQ3NZOHVnWis2SkMwa3FYYXFpWTlESFk2TDVsUHpIekQwcXg3TE5t?=
 =?utf-8?B?ajBLem5CNGlDRUZXcnNoM09vTDduVVpndmF5TEtSM0lCZ3BDZy9SajVwMWJG?=
 =?utf-8?B?MWR4T3hGY2FRcVZFZW5NdWtrRTNyRzZNMW9udXp0U0p2eTFVTXZaQnQvUGJx?=
 =?utf-8?B?d2xteHYwT1VITWZwVU5ERWhCYzVFak5TZ05VQTBaaTgvRFB2TmpaVjFUYnpS?=
 =?utf-8?B?N3czaVZlMlA5NjhDVXlkRm5aWk5xTnEwU3FuQjkzTy82VXFUd3R2L3ZYVjNC?=
 =?utf-8?B?WS92UnFSQmltaFQrei81UWtVT2RxSHJXSXd0ZFlyc3BHdHFHQUVMVDhnM2Vz?=
 =?utf-8?B?REpTRlN2ZmR3aDZBNkFMWlY1Z3BqUDZqODZhVnl1N0ZYTkkzblVYM1RXcUFp?=
 =?utf-8?B?SC9CSC94NG8yUGQwMlZVOGE2UXdpNVA5U3I1Z0p6dFo3NmY5Z1lBbWFYazcv?=
 =?utf-8?B?K2w3NkhjMXFMZ2hUYlUraXFnRXJ1dU0xSGZ6SDVidWE2d2o2V2dYTVk3eXQx?=
 =?utf-8?B?ZnJZRHBDcnlldlAvWmZFK2Q3RXlYMWlMU0NCQXdvVUhma3lwZ2g1MVlvSWJ5?=
 =?utf-8?B?QTJRdGUrS3lZZ0VDUHpXTFlDeEpXb0xLV1lMeS94NkRXZHgrU0JmMjFaUUxR?=
 =?utf-8?B?Wm5YVGlBWGtQdGlKeUdjNDdvWWNkdkVFNm0yZSs0TkMxWHBXWHZvbjFnWkhr?=
 =?utf-8?B?OGNjRDVnM2ZxZmdPb2RpU3RhdlM4Z2NVSGdKU1hOSkMzYXBzazhnVEFRdDFj?=
 =?utf-8?B?anptSFFnMGJsYmVSUERrOERDczlnSnBlSFdIZVV2ZWc2d1ZRTEt6QU1YRTVj?=
 =?utf-8?B?WnBmU3pwd2dBc0ZseFBYVldoUGtWdWJQb0k2cC80US90NFV0ektBazk4S1BN?=
 =?utf-8?Q?NWHkKtMDiEP3Xv6SzbWOKB4g+sH1fw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5041.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlNnYVpYeGRmWXZlS2VkNEVzRTlMbm1xYm5LSlphZk5BWS9oc0haM1ArblNB?=
 =?utf-8?B?Q0V2UVZvQysxL0ZwZ2tSYm5QbWxPajJQMmtFTmJvL3VZT2JaR0l0VjFtTmhk?=
 =?utf-8?B?MzJpelRvWW0zZU9vLytnR090YUFrKzkyS1VSN3Q4YmhPbzU0T09vUko0VWNt?=
 =?utf-8?B?MFBqQVFpMXlweTlmdkhRc01ld2w4S3E0MHppUDJsM1ZuZkNOYmM4VjlEMjc0?=
 =?utf-8?B?UW1SMTk3YXRKL3piaHZmN1gvdjZrMDM3SHdnTGREakFMN1JTTGg1TlBrc2ZS?=
 =?utf-8?B?RTJCVHE4ZkNZNzhtNVNLaFFSV3JSbHBUeVBwWUNWWDlORHgvS2E1UUwzbXpR?=
 =?utf-8?B?aTRpUHFvSVFwVkkxZGdMalpFNVpLSkNEUGl0cG5HTFhvMHBqTGxrM1RGS0FV?=
 =?utf-8?B?WmNVUXNHb2lKVzNZRVZhRUJCQkpSNlVVUXNpMGwwT29NUkFDNjNQdnVHRVBD?=
 =?utf-8?B?aXB6MndPeWtQS2Y2TXJrYW9iMFZnWS9mUGZuMHEyM2prT1RIcFh6Q1NCaHNi?=
 =?utf-8?B?eDRkMHRtclNWdVU3cjdhNlArblFEejYydnl4L3F2WnNKdzJUT28zckluM0hE?=
 =?utf-8?B?dDIzOVRyQVRwQkM0S2RnYkpoY0RXRGRQNGMwNUFRNm1xaUtkbDdqRmFyUkRx?=
 =?utf-8?B?UlU0VG1YQmF5WEMwQ05ka1djQTNTQlIzNk54Q2NjL1JRclQxUnVHaUZIUGx5?=
 =?utf-8?B?dWpYU1lDeHFxTGpBdFphcHI1VEN0WkFiU3U5blhBZTR4OUwwRVdkRldqSkp6?=
 =?utf-8?B?NkVjbm1Sd2w3M1pneFRFOGJtL0YzWm03R0ZDSFIzUXYrbmsrc0VYVE51YzhB?=
 =?utf-8?B?Q2FXVUR1L0FpNDhNUHczYytpSWxuMGt5L3lEVlh2NXBjQUFuQnFMSjdEK1dI?=
 =?utf-8?B?NENtTHJNZHdYZ1h3QzVkL0RUREU2cXB3VWJYRCtYNzBhS2pzZEpLWDVMMGY5?=
 =?utf-8?B?Z3lIQ0dBOVE4S1lDN25pYk1BM0svMFR5VTFNWm5Hek1tT1dicDFDckt5blZx?=
 =?utf-8?B?M0k3WHEzRktBc0NqbjhjYTYzd3gyRUV6cnBibTlSRTJIQkI3TW4xWkhhMGZP?=
 =?utf-8?B?RWYrTWNIQlhjQnVYb2t0LzA5eEJWQmNXbkJsMkVzcmlyL3picWNTdW1PUGd0?=
 =?utf-8?B?SFg1MzhlZ3FDMzRiRjJuUnhYTEZxT3plTUFxV0hQNEgzQUJFWU9KenFaNXRE?=
 =?utf-8?B?Qkl6YUVPSW04MitBWTNSSWk4YVhqZzRHU25IemFwT3k5VVVWVmdVYjJxTjZY?=
 =?utf-8?B?NThvNzhLVVl3SmNrSWtTbUw5ajNnOVZkTHFDcmFOa2VlNDYyQ1krWGp1NVBR?=
 =?utf-8?B?SUZqaEVMSThTQlo2cmpQRFIzMTduenFuNHZ1aEp5RXpxTUo0Zjh3b3JIQTdo?=
 =?utf-8?B?V3NZQytPK29nbUYyeFZNN2xLVDdNQ2grREN4dE5sc3JJTXpaMHRjbWFXUTJ6?=
 =?utf-8?B?L2swL2EyMlVaK2E3U1BqTHlSZS9iRjlkMThaZU8vU1dJSTYzV0ZJVEZBdk14?=
 =?utf-8?B?RkRsRXQ4WHZhdzQyQS9RUzFLaDY0MmV2aUtGZXZ2NVlNTmFBL1NxS0xsQ1Nx?=
 =?utf-8?B?NHIyN1N3YVM5RTFjOUZ4YlB3ZEZJVHdub29VTlRrK2ZQV3BGY01ocnhaTk1Q?=
 =?utf-8?B?RjFFOXYyN0ZWeW1oakhkUDRqZW1iWExUVXN3RnA4cmpiN08wRk95RjdiMm9i?=
 =?utf-8?B?SThlSlFMNzJ1M1IzOXM4OWJZbGVwbS95ekw5WG1EWC9VRnQzRHg2U0ovYWk2?=
 =?utf-8?B?cnNhdkR5cThCTVB1Q3l4blV3VnlrZnRtaiszMm1QdkxGdkFTbnU4bUZYZVl0?=
 =?utf-8?B?SndQT3ZNcGlZMXhkNFJnRU5tNkJQMGw0QjFpeXZBaGVKOEFmOWVJWVA0VXNR?=
 =?utf-8?B?ZXBiY1A1MnhzbVZKR0RXL3dXRzRRbHhFZiswQUZtRTZJdUZtUXVjTEVNOTdV?=
 =?utf-8?B?ekVmVkVUQkVDdXpicjcrOWhBalJHa0xnMFRBNmN0eHBHMkNvRFIwTitTMWhh?=
 =?utf-8?B?d3lYZ3M0aWlCWGJHUEordVZGUk5qSG9GU0hwS2FtRzJvV29KSmxIUVZJZXRa?=
 =?utf-8?B?akdhK3VMV2hIaU5YS1ZPZGEvRHRTSHB6cW0vYjFsV1IzVzJNOCtkNU1oNldm?=
 =?utf-8?Q?71SkZhmX+k3fx3H/jUjM7p+Gr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e25540-e001-409c-bad0-08dd7e1032e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 00:30:19.4571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3tva1w5JjNfjxxpeElv12TSNEWsWnCD4Kvm6qAkBr97fVPOdQTrLA4D9DkzF//kqpxTp+VCwA6oj/YEjVc4kUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5386

5Y+R5Lu25Lq6OiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4g5Y+R6YCB5pe2
6Ze0OiAyMDI15bm0NOaciDE35pelIDIxOjA4DQo+T24gV2VkLCBBcHIgMTYsIDIwMjUgYXQgODo0
M+KAr1BNIEZ1Z2FuZyBEdWFuIDxmdWdhbmcuZHVhbkBjaXh0ZWNoLmNvbT4gd3JvdGU6DQo+Pg0K
Pj4g5Y+R5Lu25Lq6OiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4g5Y+R6YCB
5pe26Ze0OiAyMDI15bm0NOaciDE25pelDQo+MjI6NDkNCj4+ID7mlLbku7bkuro6IEFsZXhleSBL
bGltb3YgPGFsZXhleS5rbGltb3ZAbGluYXJvLm9yZz4gT24gV2VkLCBBcHIgMTYsIDIwMjUgYXQN
Cj4+ID45OjQ44oCvQU0gQWxleGV5IEtsaW1vdiA8YWxleGV5LmtsaW1vdkBsaW5hcm8ub3JnPiB3
cm90ZToNCj4+ID4+DQo+PiA+PiBPbiBXZWQgQXByIDE2LCAyMDI1IGF0IDQ6MTIgQU0gQlNULCBG
dWdhbmcgRHVhbiB3cm90ZToNCj4+ID4+ID4g5Y+R5Lu25Lq6OiBBbGV4ZXkgS2xpbW92IDxhbGV4
ZXkua2xpbW92QGxpbmFyby5vcmc+IOWPkemAgeaXtumXtDogMjAyNeW5tDQNCj7mnIgxNg0KPj4g
PuaXpSAyOjI4DQo+PiA+PiA+PiNyZWd6Ym90IGludHJvZHVjZWQ6IHY2LjEyLi52Ni4xMw0KPj4g
Pj4NCj4+ID4+IFsuLl0NCj4+ID4+DQo+PiA+PiA+PlRoZSBvbmx5IGNoYW5nZSByZWxhdGVkIHRv
IGhkcF92NV8wX2ZsdXNoX2hkcCgpIHdhcw0KPj4gPj4gPj5jZjQyNDAyMGUwNDAgZHJtL2FtZGdw
dS9oZHA1LjA6IGRvIGEgcG9zdGluZyByZWFkIHdoZW4gZmx1c2hpbmcNCj4+ID4+ID4+SERQDQo+
PiA+PiA+Pg0KPj4gPj4gPj5SZXZlcnRpbmcgdGhhdCBjb21taXQgXl4gZGlkIGhlbHAgYW5kIHJl
c29sdmVkIHRoYXQgcHJvYmxlbS4NCj4+ID4+ID4+QmVmb3JlIHNlbmRpbmcgcmV2ZXJ0IGFzLWlz
IEkgd2FzIGludGVyZXN0ZWQgdG8ga25vdyBpZiB0aGVyZQ0KPj4gPj4gPj5zdXBwb3NlZCB0byBi
ZSBhIHByb3BlciBmaXggZm9yIHRoaXMgb3IgbWF5YmUgc29tZW9uZSBpcw0KPj4gPj4gPj5pbnRl
cmVzdGVkIHRvIGRlYnVnIHRoaXMgb3INCj4+ID5oYXZlIGFueSBzdWdnZXN0aW9ucy4NCj4+ID4+
ID4+DQo+PiA+PiA+IENhbiB5b3UgcmV2ZXJ0IHRoZSBjaGFuZ2UgYW5kIHRyeSBhZ2Fpbg0KPj4g
Pj4gPiBodHRwczovL2dpdGxhYi5jb20vbGludXgta2VybmVsL2xpbnV4Ly0vY29tbWl0L2NmNDI0
MDIwZTA0MGJlMzVkZg0KPj4gPj4gPiAwNWINCj4+ID4+ID4gNjgyYjU0NmIyNTVlNzRhNDIwZg0K
Pj4gPj4NCj4+ID4+IFBsZWFzZSByZWFkIG15IGVtYWlsIGluIHRoZSBmaXJzdCBwbGFjZS4NCj4+
ID4+IExldCBtZSBxdW90ZSBqdXN0IGluIGNhc2U6DQo+PiA+Pg0KPj4gPj4gPlRoZSBvbmx5IGNo
YW5nZSByZWxhdGVkIHRvIGhkcF92NV8wX2ZsdXNoX2hkcCgpIHdhcw0KPj4gPj4gPmNmNDI0MDIw
ZTA0MCBkcm0vYW1kZ3B1L2hkcDUuMDogZG8gYSBwb3N0aW5nIHJlYWQgd2hlbiBmbHVzaGluZw0K
Pj4gPj4gPkhEUA0KPj4gPj4NCj4+ID4+ID5SZXZlcnRpbmcgdGhhdCBjb21taXQgXl4gZGlkIGhl
bHAgYW5kIHJlc29sdmVkIHRoYXQgcHJvYmxlbS4NCj4+ID4NCj4+ID5XZSBjYW4ndCByZWFsbHkg
cmV2ZXJ0IHRoZSBjaGFuZ2UgYXMgdGhhdCB3aWxsIGxlYWQgdG8gY29oZXJlbmN5DQo+PiA+cHJv
YmxlbXMuICBXaGF0IGlzIHRoZSBwYWdlIHNpemUgb24geW91ciBzeXN0ZW0/ICBEb2VzIHRoZSBh
dHRhY2hlZCBwYXRjaA0KPmZpeCBpdD8NCj4+ID4NCj4+ID5BbGV4DQo+PiA+DQo+PiA0SyBwYWdl
IHNpemUuICBXZSBjYW4gdHJ5IHRoZSBmaXggaWYgd2UgZ290IHRoZSBlbnZpcm9ubWVudC4NCj4N
Cj5PSy4gIHRoYXQgcGF0Y2ggd29uJ3QgY2hhbmdlIGFueXRoaW5nIHRoZW4uICBDYW4geW91IHRy
eSB0aGlzIHBhdGNoIGluc3RlYWQ/DQo+DQo+QWxleA0KPg0KQWxleCwgaXQgaXMgdmVyeSBzb3Jy
eSB0aGF0IG91ciB0ZWFtIGRvbid0IGhhdmUgdGhlIEdQVSBjYXJkIGluIGhhbmRzLiANCkl0IGlz
IGJldHRlciB0byBhc2sgYW1kIGdmeCB0ZWFtIGhlbHAgdG8gdHJ5IHRoZSBmaXhlcy4NCg0KPj4N
Cj4+IEZ1Z2FuZw0KPj4NCj4+DQo+Pg0KPj4gVGhpcyBlbWFpbCAoaW5jbHVkaW5nIGl0cyBhdHRh
Y2htZW50cykgaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkNCj50byB3
aGljaCBpdCBpcyBhZGRyZXNzZWQgYW5kIG1heSBjb250YWluIGluZm9ybWF0aW9uIHRoYXQgaXMg
cHJpdmlsZWdlZCwNCj5jb25maWRlbnRpYWwgb3Igb3RoZXJ3aXNlIHByb3RlY3RlZCBmcm9tIGRp
c2Nsb3N1cmUuIFVuYXV0aG9yaXplZCB1c2UsDQo+ZGlzc2VtaW5hdGlvbiwgZGlzdHJpYnV0aW9u
IG9yIGNvcHlpbmcgb2YgdGhpcyBlbWFpbCBvciB0aGUgaW5mb3JtYXRpb24gaGVyZWluDQo+b3Ig
dGFraW5nIGFueSBhY3Rpb24gaW4gcmVsaWFuY2Ugb24gdGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1h
aWwgb3IgdGhlIGluZm9ybWF0aW9uDQo+aGVyZWluLCBieSBhbnlvbmUgb3RoZXIgdGhhbiB0aGUg
aW50ZW5kZWQgcmVjaXBpZW50LCBvciBhbiBlbXBsb3llZSBvciBhZ2VudA0KPnJlc3BvbnNpYmxl
IGZvciBkZWxpdmVyaW5nIHRoZSBtZXNzYWdlIHRvIHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIGlz
IHN0cmljdGx5DQo+cHJvaGliaXRlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lw
aWVudCwgcGxlYXNlIGRvIG5vdCByZWFkLCBjb3B5LA0KPnVzZSBvciBkaXNjbG9zZSBhbnkgcGFy
dCBvZiB0aGlzIGUtbWFpbCB0byBvdGhlcnMuIFBsZWFzZSBub3RpZnkgdGhlIHNlbmRlcg0KPmlt
bWVkaWF0ZWx5IGFuZCBwZXJtYW5lbnRseSBkZWxldGUgdGhpcyBlLW1haWwgYW5kIGFueSBhdHRh
Y2htZW50cyBpZiB5b3UNCj5yZWNlaXZlZCBpdCBpbiBlcnJvci4gSW50ZXJuZXQgY29tbXVuaWNh
dGlvbnMgY2Fubm90IGJlIGd1YXJhbnRlZWQgdG8gYmUgdGltZWx5LA0KPnNlY3VyZSwgZXJyb3It
ZnJlZSBvciB2aXJ1cy1mcmVlLiBUaGUgc2VuZGVyIGRvZXMgbm90IGFjY2VwdCBsaWFiaWxpdHkg
Zm9yIGFueQ0KPmVycm9ycyBvciBvbWlzc2lvbnMuDQo=

