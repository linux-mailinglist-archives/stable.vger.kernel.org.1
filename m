Return-Path: <stable+bounces-213262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHJBCWoJgmmCOQMAu9opvQ
	(envelope-from <stable+bounces-213262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:42:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A540DABC2
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A06B9300E4B7
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 14:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468143AA1BB;
	Tue,  3 Feb 2026 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="APlAg3Gs"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72923AA1A5;
	Tue,  3 Feb 2026 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129746; cv=fail; b=oEVFZeAFk2KVA09WCvhKrSNDGQhJFsL8Q8mSAODKmWxJWcIN2UIvyjd4JThwG0ILjzvHEIo5r5WdlMSw4p4CF/GsdFZRW0W3DaOHlGbLdETwNAZWeC+nWZ7wiNcZS62KkIpi3SUN9+bzVCmpQPooWKaHuXOQ1YgOl2UGYGDXOoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129746; c=relaxed/simple;
	bh=7eerSwwKqdpxgT+89DdsTXo9FTR7HN7+/tWmMA94uYo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dqadbOqRbRvn14lgFmk4cANRGW3AeRhTjjHY/dhn6vdQ2+MtE1JaC5h7dq83DLX51deoan4C49WcqsaxjYvR6LGkfoWabb8XqUxtSeB4uGWFC+TQFCOOQf1kYMrtl+55GfqQ/ZJJiIJsZh0jIIkbPvYdAKgsgkhBiRWtwOlZ7VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=APlAg3Gs; arc=fail smtp.client-ip=52.101.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nE/AR4aZi3GrDRZ+KMmkq7VXixY/VHE8fMJUldYIyLtGKRWqWNf4wLZWcD6r2Z0s+f2Ea6PXkFDsl2iTRU4H68ZwXUTU76nNd94O0NmEvLjPIwdxR5jTWi/hH8kEBjBeGImyS8bxV2jC1peALiMZH8q3nxhPZfpNXr2XgzcyPu14/+dvpb7JQ56E0nG/4ncayrwH5hCQbkGh8T8cyCAAJc3GNNEKho889VnillFnirSO7Y4FgAWfv1gXiooE+1wP0/BIzZC9d0w5HauudikY07crdM3KvxXdhYphz9WURvLG1WVvA0xDbWfoc0I9Tvi8fyxpzoHhplA34lv/aWWITw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1Z/njENvQA/uWlNb5FOw28abalg+VEQmEnc6O5pVh8=;
 b=DwKlrVZNV/gLxE86jDKCvrMGfYFhi4kQThYfabSOdn4FXgat/N8c6ITk9vfVkPkz/R3XRQEBE2gX46tqoUkO+ch+DdFs/0osrWVzEDLUV46P7Y6pJvfkgvmjDgZbU9kwz+Xj6Z7HL2uHW9uMK5ALerWt8bijZQpILr7HPaZhQYo78Wh4VcGLzuNA+4lJL11Jty9nTVwvGTm4IiIQcJ9GmTtMUwlmp/w/U5CW6aS9r0nHxZOwozg1WTBWuBIsZWyQlum3fqiZ6ctfki5j1M+V3EAuWesuMm12Sd1W7HaXBZxxqoPSK2rcSwpYWsGVQidc3Plmh+eGgTsKa2osgiMIqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1Z/njENvQA/uWlNb5FOw28abalg+VEQmEnc6O5pVh8=;
 b=APlAg3Gsa7JWS/7OsXrC5DGXtL1ZMAw58+oqz9AyPvzSev6OX4chr7IZV86EQOx/NQcRq6e/sXviDkLp6rLxmdFmtRtlaHgUjwBx7AfqsxNPbVfnE68eC9qE63X6DhXKQY0XUzfiNSErcxLmPu1seFqY+MhrAVpLtxoCkQt7tO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 14:42:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 14:42:21 +0000
Message-ID: <2fcded69-e458-431d-886b-b76c7e3fd9d0@amd.com>
Date: Tue, 3 Feb 2026 08:42:15 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18.8] Revert "drm/amd: Check if ASPM is enabled from
 PCIe subsystem"
To: Greg KH <gregkh@linuxfoundation.org>, Bert Karwatzki <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 stable@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20260201002508.1293510-1-spasswolf@web.de>
 <2026020334-vividly-cognitive-e0b6@gregkh>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2026020334-vividly-cognitive-e0b6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 089995a7-2563-4b1a-12ef-08de63326f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHcrRzRLNG5DMFZ5eXVZWGZVTDdTbUoyNWJ2d3pqL3BZVGJlVmhDN25oKy9z?=
 =?utf-8?B?UU5xS3g4ZlpRbWdGMWhzTTZ1b0tMVDNHSkNzRldtbkQ5dXl1UmJsTUN1RytT?=
 =?utf-8?B?cjlTVW9aTXNOeVBHRG54eDJYYzVIZDdhbnNmOFFGMzlQWHZuZ0lQS2lTb3c0?=
 =?utf-8?B?aCtaRm1OZVFWMjN5MUYvY2JVUUM3am9KdTl4ZGtyNVBrVXRYdU10ejJUdFpW?=
 =?utf-8?B?bGNPRFhoTFFxWm9mR2ZmazZ3c3NyMG5FdXEwbTJ6MkxPK2tsSEtnSUl0MkNK?=
 =?utf-8?B?NEhlZUZFUzh5QmFiYjBueFNRMWpDS1Z2cGs2eHNoY2dYS0JrdzkwVmVENDdN?=
 =?utf-8?B?L0hiaWxvc1BBazQzck9Na1hVWXZybXhjQVZ5cU8ydmFXYWltTlJjbG9HRzFR?=
 =?utf-8?B?b2tHYVZ0NzBHN3phOEZBdkpWN3ZhTkRDaGFycnVnNUhYRXZucktKL0VBbExH?=
 =?utf-8?B?TzdTbmxmVzNGU1phTlZmMWZ5MGZLYjhHZFVRWTUrRVhqcldoVWVyTzRhYUEr?=
 =?utf-8?B?UzdBMEhML2IxL2JzdWV0RkFBdG45OTA0US92cnVQeW5zY3g3aXpYbXkxQ216?=
 =?utf-8?B?cFR5Y0tSQUNVZkdodm9tMXRSUEg3Z1hjd1BJL0JxeDhPbXpOODR0UEVxM2Fj?=
 =?utf-8?B?OHo3dUtmaHkwNkxiamZsRWdJZ0ZVQzNTM3Z1WXBrUFpvOHFtbFQwRkNLYXZp?=
 =?utf-8?B?ZUsyNnZhK2gveFpXaFoxWURRRXB6TXdiYXY4R3pCYU1hVW9KbWR5ZzRhZTZq?=
 =?utf-8?B?a2V6M3ZQYytzVUdwTjZtbFFWeENnTVMvMkxZTTJiczNIVks2eFN1eXArMFEr?=
 =?utf-8?B?YmtCQkJ6VStqcWRhSU9QK3V4N0hPYzFVR2x0YVJUV05ONzJJSG1La1hralJh?=
 =?utf-8?B?WnVRQlpabVhyOWtrVEZNcU16WklDWExEeGxZOVJvWXJLUEdTSG1OTFNDQlVs?=
 =?utf-8?B?Q1d2ZXZlY2pBMFVtQkcvMlgxM05wMnRDWDF4YVI3cUU1U0tucHhYeW4wck11?=
 =?utf-8?B?dS9VRkovQTN6aEw0NFE2d3g0YmhmSHhVYm14Q3cyZGYxcDBRZEtxR0JybFR5?=
 =?utf-8?B?RC9mYWJCd3UydHJTL21nOFdlakFhME5BVWtrRExoU3p2ZGhtUzFKRitzRzdB?=
 =?utf-8?B?Yk9nT0wxc3RkZG5qQmxPajZjektleTlvVzNPSk1vU3hNOEx0RnI4TktpbGov?=
 =?utf-8?B?UWRMTC9raUxuMEdBb1JPNmZoSStIMUN0L24yYWd0RGlkWEhVb3F0REI2ZmIv?=
 =?utf-8?B?alFRMmVwTGplM2RVT29tOEJGT3VBZWJWTDkvaGdDSEhWd3Nnb1dHdTNtQ1dX?=
 =?utf-8?B?UjlpVkZRVTF5bURmRkh0V0VmWEdFQUlnUFlrVzBSREN0NXdobVdxOGJBOWY0?=
 =?utf-8?B?WFhid2tkNk1NTi9GcytPNysyeHNmZ0ZXb1JsR2s1YjZzM2p5dkZ5b0hrTmJi?=
 =?utf-8?B?VkdYT2NFKzhTR3RaS09VZmk2T3FXay9PUGNYOURtY3hYeXhpTWNJYjFSQ1hB?=
 =?utf-8?B?MWpQT1RQRytqN2NFb2kwZHhYTXBKRm4wUGNTVE54Smw4UzRNUjN4RWE5OHcv?=
 =?utf-8?B?K0RlNU14bE10TW5EYTVsTU9YK2JUaFZxcDlCeFZoQ2c1YytQamVGUi81aWlZ?=
 =?utf-8?B?RjExUVl4RGR3SXNlbGVBUHBlaFhVQzZVZG1vcnN2MkZzbTdCS0N5QVh4VFMv?=
 =?utf-8?B?T1U4cHFJNWU0VXRKWU9xUUZBT0V3aTBidm92d3dweXhDMGVEelZZRHhSb3l5?=
 =?utf-8?B?ZUo5Q3ZZNFVNc0RRWU1pZVRLQ2lCaExTdHdPVUpBN2YvQnVBQkFvWVlkM2RS?=
 =?utf-8?B?YUxSVWNEZTludUluTHN0SDBScnhjdHZQSDB3eElMVHY1SlVMczhPNlpRUjJr?=
 =?utf-8?B?OFhWQmpxMXA2dHJ0bDYycThOSWF1VTk3dnBvWWlsbHBPZS9uSzdHditDaFFV?=
 =?utf-8?B?NnlINzZKSlBMbGtNM3hLN3ZBcjN4bFVUVWpwQ25JRS9zUFVncmdiTTJnZHA3?=
 =?utf-8?B?NlNGZUZGYzl4NEN5ZGFqczI0RWt5S2Vmc29aZGMvTVAwa1ZKd3U3VkRVVjUz?=
 =?utf-8?B?Q3N5dkpQQWNvWjh6M1RSTkk0MFVpNzZMdHFmK1g0QkhUYnREc1U4SGJoKzBJ?=
 =?utf-8?Q?fW57ZWEkmv4kv7nDlFs16+AES?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0dCeitudUJST3pZWUMycHJ4clhUYnN2T3A4YWZzNTNsalNxbm8xbWh1OG1Q?=
 =?utf-8?B?UFBtS1VVbC9VS0tsb1Rpem1qVGhpSGZOYXdTM1VScmdralJkNi94c1ROZ1Fk?=
 =?utf-8?B?cE1QcEtnSnRtdG5JT1I4RUNBQ0N1TjN1OHhHMC9US24xRm13Nnh3aDJHMmVX?=
 =?utf-8?B?M2dnWmlqY3NGZHJ5Ukd6bFpEMW84VStCU1E5L1hTOWp0THV4SmNCenRyQU9y?=
 =?utf-8?B?TWUybUFVV21tMEpLSUg1YUE5OEtKNmt3S1pPNHpJUXVNUUZaNjBld1A1eHU1?=
 =?utf-8?B?NlN4U3Jqb1I0Z09zdm5FaUhHVERwS3dacmVCajRPckZOdytaOTRkMTlheldw?=
 =?utf-8?B?RitNL2tkRndWcTdlSEhnZml6QkpCMXZudGwybFYyRWh4dGVVQVVWcWNGckh5?=
 =?utf-8?B?UTBCN3N4WHhwVFhCT1FBcEltZnZra1puUzVxSmlLbStIbVI5QnF5Q294alc2?=
 =?utf-8?B?eldBZWs5ZlZQRGJ6WkdVbWUwMkFyTTdQOVNQcERyYndhZFZ2YzY2MFc4Q1l5?=
 =?utf-8?B?V0E2RTJ6QTZzaEtNWmVJU09tb1ZvR3V4S3VaVUNWQUZ6Y2paQThLam9qMDM4?=
 =?utf-8?B?a2w4TVRQU0wxRnJEOTdaSFBnanJBMHRIK1JQYmg4VVB0dlVmMVI1dWhDNmYr?=
 =?utf-8?B?VE1KVm5JaTFjK3pZNFRLbUhaaE9DdjdZTEovTHByaFQ2WTh3UFAxVGVrWkhU?=
 =?utf-8?B?WW5TYnZyeHk5aXNUaWRRQlJuTTlzeERoRml3SWFqMThUZ3lXWElvU0NLVzhD?=
 =?utf-8?B?RXJTMDk3V2F1MHd5OHRMQ0lUdllsQ2FkK0RyUXJQNHRsVEJISWM3NXR6WjJV?=
 =?utf-8?B?NTRLSWYvWjZRS0w0R3I1cTlKUXlIUFdCbFBPdGFXUDBxY2NicUw4VE14QXF1?=
 =?utf-8?B?YlBLWnFwOUtDQzUwUHQzM0ZXR2ZXM3pmTkpVV3JtWm9STDZleTJPTkJUS3ls?=
 =?utf-8?B?TUEzQnBnS2RkcEpHMGFYSjM4WXJjOVJMQWc1bFcweDFjaEJuM1E3Tit3cXZk?=
 =?utf-8?B?WWsvc1J5VmZ3VklFR0NGajNCQzFJeHVtdFI0blpLVHIwZVNIWEFBNlovc0R2?=
 =?utf-8?B?cFhzZVFZVTZERjJIK0N2VG9VR3JXUlF4QndWNE1yTHY0TnZiUTZaVWVYYlZu?=
 =?utf-8?B?ZTd0RHVYVEZmYUsvZjYweGlsMWE0SzJaT3ZrQmtHUFFaSGkwMGpscWEwd2Jy?=
 =?utf-8?B?ZXAwd0VqT1NKdVFEMVRoMEVxam5nOXdhMTVMczBPZ3BCWDI1ekpRMmpUOTdP?=
 =?utf-8?B?Q01XV2pVSUU1VXp3Mm9MNXNQRkdOczVUTld6SEtYVlVsMG0zcXlCenRzN1ZY?=
 =?utf-8?B?bUtLSnJDdTg5Y0lMVkowb2Z4WG4vSHB6NWJtSFoyQmlrQS9CU0VEMUtob1JF?=
 =?utf-8?B?aVl2ZWRMNTVoNHE2SklkN1FET09nSkhxUDJmaktZTzM4Umd0RGd5OEFaTldt?=
 =?utf-8?B?Y1ZzQ0orbjlyL2pka254Nm55a3BaZG1JN21YZnQ1V2NZTzJhQjJQakc2bU85?=
 =?utf-8?B?aGRHWlFPejRscm1iMTFObldxb3NZc0pTN2FSZi9mVDc3QkF3VXd4aWtvejM5?=
 =?utf-8?B?d2tYNUxtRVY2VE9Jc3dSclMwUFhLS1ROUTg3d0R2em5tSEl6N0srWGQ3Rm9B?=
 =?utf-8?B?Rm84NVU1MldYTDhWTEtSVXk5cFJuTnRTVkhJeHNjMTBwYVdoMHBRUWt2M3pM?=
 =?utf-8?B?dk1MTlRraFVrNVJLQmFRVExYdWljZ1RWMWJlQVFuTVdnUDBHVEJETmNqNENa?=
 =?utf-8?B?Q1ZUdUtqWVBDVXJmbXV0T3JJeFdiSlVHTU4yamJaaDVHN3EyWDZ2MDdBMnVH?=
 =?utf-8?B?ZHI4MnI4VVdXdER4bDNDaDh0RzRyT1VSbGpmbHdBZjhFSVlvVmFORGRmWk5p?=
 =?utf-8?B?cTBCaE1Bd0NJTVdoMXorejVVUXNkbU5GQzJ2NmN5UFJmellVWTRhZCt0V0FU?=
 =?utf-8?B?VU5jWTduL3NhRk1uMU9UcjhZZnVlbElvZmtpSHA4a3NCc3h3UGZnL0R2V1NU?=
 =?utf-8?B?bGtzMFRwd01mV3E4aVFNNlhwZWVaL2Fmc0FpT01tZXQ2cFl5dWZNVS8zSXVN?=
 =?utf-8?B?NktIU1l4WmJiaWZZVWIvblJMNVRHa0ZpWm9oWHA2UTZ4djQxQmVrR3k4cnc0?=
 =?utf-8?B?UXdrSWY5YU5KUS9OaGRBZkZxOTlXS0JWWnBBUFdkRDNkdnJ4WXgrOTVGTUpU?=
 =?utf-8?B?ZGlqU01GWEYyWDM1N25PTFdma05odEZqQUxvQXlNOW0xWjViM2VDbGl3VEFs?=
 =?utf-8?B?REEzRFVieE52Q2crb1I0TGxTdnI0d1IrYkRONm1MbXJlUmlNZHd0dmo5L3Bm?=
 =?utf-8?Q?xOmt8BMlgXQfj+nNPV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 089995a7-2563-4b1a-12ef-08de63326f66
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:42:21.2542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtfvXYgwVoqsxE5g0C6QKvk2m1HtOvsnnlIKXq3a1qXQkDDHlVakBb5boyOHNigtXCmU6TBAPKAEGJ+IGJYRew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8535
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213262-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,web.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A540DABC2
X-Rspamd-Action: no action

On 2/3/26 8:39 AM, Greg KH wrote:
> On Sun, Feb 01, 2026 at 01:25:06AM +0100, Bert Karwatzki wrote:
>> This reverts commit 7294863a6f01248d72b61d38478978d638641bee.
>>
>> This commit was erroneously applied again after commit 0ab5d711ec74
>> ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device")
>> removed it, leading to very hard to debug crashes, when used with a system with two
>> AMD GPUs of which only one supports ASPM.
>>
>> Link: https://lore.kernel.org/linux-acpi/20251006120944.7880-1-spasswolf@web.de/
>> Link: https://github.com/acpica/acpica/issues/1060
>> Fixes: 0ab5d711ec74 ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device")
>>
>> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 7333e19291cf..ec9516d6ae97 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2334,9 +2334,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>>   			return -ENODEV;
>>   	}
>>   
>> -	if (amdgpu_aspm == -1 && !pcie_aspm_enabled(pdev))
>> -		amdgpu_aspm = 0;
>> -
>>   	if (amdgpu_virtual_display ||
>>   	    amdgpu_device_asic_has_dc_support(pdev, flags & AMD_ASIC_MASK))
>>   		supports_atomic = true;
>> -- 
>> 2.47.3
>>
>>
> 
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

FWIW I added a stable tag to the patch when applied to 
amd-staging-drm-next for this.  So it should come back to stable once it 
merges in Linus' tree.

