Return-Path: <stable+bounces-177695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7510B431D6
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 07:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E7D189E8D2
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 05:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067A2242D67;
	Thu,  4 Sep 2025 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p1aDb/QC"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ED523B627;
	Thu,  4 Sep 2025 05:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756965372; cv=fail; b=Nio1WsC/2KtWQcFaUH/vKuaDXUq37w7dqO8z5/rKl0Ww79n4Gs/af6qRsQ6d6q7peFRfqNAqRgz1rl8bMfdQzSDIDwhbMNgwqmKSr/sFzHu27z6/VkEpVAKF4GOTYzXZTuWAAxu5Du1TxfmApCpjSbIXeu6Yu60hTiWMEyqEdfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756965372; c=relaxed/simple;
	bh=FFCxA1yvgCpFS37aBrl2UbvUfFiJLXLVSIRz2YUxmTM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OK8jW5OFemi0+1DT6vKEZ/2ewK16+jr2zi96+UeM0hhyl6xI9rG4woWHrW4Ajy0n/YbvG8nFNTc0ykuUhyQ++ERMEjVhnno0G11RG97LDIkvY/drNul44B27EqD7kkQoSvPgeViJj5rDDAP6aRDsYtpV2K54MoUiXEmGeVFEZNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p1aDb/QC; arc=fail smtp.client-ip=40.107.96.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7DfYwIY9RZ7s2KK0qLfZRSvBXwxcNAOHarda6s9cwd4ODyTt5Iqq6TMNkk2pYq06NTKU1YEPt7A9LL8uu6Q16zLumg568MV36E+mJfWDSvgpu+IJIuGuSoUsnVPgcPXXHxm4xIvi8dsnPtkvrGcQEBzkDZzp7T+1F1StJI5F+ZAdHAFzwxh+TtgeE3Dh6jmoqg1q7GGfvbnSdo0WMR2/RWzQiqG+3bChQXTXm4L/sfdkZjsyiYRxNI1P6Db98LIiBu8h9OEuVVHiGPEIDPlCGgSR1DBFC4xZMgFqCrFciCdFC8x70/cLMr4cXLAKem+pHyOjqHwTQThcUMqt6igMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZRkfmiQATG3Ihs+2lzbe9T3R2VaNplXw8mDtByf3Kc=;
 b=LDFxExM4pgDRzKUJthDnsdEGIzcM9CfqvFKdFDmvfEo9dLdVwkjZCRZxTJcElfnGjSZpfHrUEsgYTjqAt6u9nmVvJMCWVE23jEfyXodlB5fwZp7Du9p1WPigpJS8oLI9AAz5O44O49fZmkMm0vUHEoJmDBWVvaJkFR1RxZRnPKftjUfAaBOG/yCWlk2q4NRdNiVtOV1ktGZHQmFyw8M7veULOV+zqLY7JiMQShr/vkSkNJyARvin/r7mt3psEzBbPkUh14zRRRD1tL2pMlG9A7aSopCYy5SYlMI9gFRJKLqGmmfOZ5bm/6eFW6y7Djnl+pOdvA7Y7hGOsgoEhbkrBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZRkfmiQATG3Ihs+2lzbe9T3R2VaNplXw8mDtByf3Kc=;
 b=p1aDb/QCS9C1lbkYgVQcZ75GBrCrfI74cwrD2Bq2zG+pYyRkkS9ZQO3Wh5AqXO2RmyqFk/aNVB2SXvcmfGdny0IKCQ6N9/PQHZtz86QjW3EdfPBH7wW2unukTJMd4OQTTjmfSIlSR2qQCk8squrl/WT0BkfhWRBrwRKFyqGfEAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Thu, 4 Sep
 2025 05:56:08 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 05:56:08 +0000
Message-ID: <b43dcd31-93c8-4fd8-8ecb-60dead19470a@amd.com>
Date: Thu, 4 Sep 2025 11:26:01 +0530
User-Agent: Mozilla Thunderbird
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
Subject: Re: [PATCH] drivers/misc/amd-sbi/Kconfig: select REGMAP_I2C
To: Max Kellermann <max.kellermann@ionos.com>, arnd@arndb.de,
 gregkh@linuxfoundation.org, naveenkrishna.chatradhi@amd.com,
 linux@roeck-us.net, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250829091442.1112106-1-max.kellermann@ionos.com>
Content-Language: en-US
In-Reply-To: <20250829091442.1112106-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::16) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: d16707d8-8022-4d88-78e3-08ddeb77bde9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkxPOHhpUU5keDhPc3J5dGhIYXJYRjZ3QzNVdXEwUUY4dkpXQmtmZUMvQVR1?=
 =?utf-8?B?ZFZzK0xNTDdQWE5sdWkyQWgrOGhiUjJqRkxnWURKVjk4aG1GQ3VJeVpVU2ZD?=
 =?utf-8?B?K1crWWFWRXRxK1k0ZktpVFJib0lRNmZ2Q21SeDR3UGpBNEtuNnl1ZUNWeHVM?=
 =?utf-8?B?czNVT0xHZytDK0NPUFRvNEplMTZrV21zQzdhVXZNSXByckhpVTBhWXVYUXE0?=
 =?utf-8?B?eWkwdEJiTGdMUFROZm9MY1hPbGlSbFdvZ0ZwbkFNM3lTSVJ2cDRtbDlFWm1y?=
 =?utf-8?B?bCtzMFQwNXhqMlVtV1lzLzhtYUQxd29ITTdpejJuNDJoRzA5Y2o2d3A1WEpw?=
 =?utf-8?B?RmladzRzaXZWeG5CczJRVjRRZ3d4alA5UVFXTjR2djU3Q3EyNW9oTFBMSmJD?=
 =?utf-8?B?Vkp1cVoyWVBvWHFMZXExaUk0TzZhcnorZks1NVhVSG1SVmV4UjJSQzIxNW1r?=
 =?utf-8?B?VEhlTUZzVkdKaUJlZVlVTzMvUS9JbE9SZEl5Z2NlV1hOZGhZUVpiRXVXRHlB?=
 =?utf-8?B?TEEzN0lPcTJDb2pnazFLTjBMdDdha0VTOVQ0WUxJOElHdk50NEloVVFkZktm?=
 =?utf-8?B?RXA0L2tNY2N1SDd4OWhiMnF0ek9tUVo4YUVSN3ZOa3h1N3VPdVZPVmNJa1c3?=
 =?utf-8?B?Q3VyOUFTL3hlUmF3ZFBUODd0RzFJZTZROXpJRmlmSEljNm1LbDhkcys0VnFo?=
 =?utf-8?B?N2Z6NVI5Z0tPRG8xNEdsaXdHTCtZb29VVzlscjQ4ODdUU3I4dmZzTzh3ZGQr?=
 =?utf-8?B?T3YrUGFpMTNtQlRCYjc5a3BKcmZNV3dxVm9TWm1HQW9JSjZEdFFTSmtrWlE5?=
 =?utf-8?B?bER1bVRjTW5lUEN5N1lFWEpnbGZZeEJ5YlFaZjN0TDRya0dFQUx0dXQveFZC?=
 =?utf-8?B?OGFyWXRuR1ZORWtJN29tR2QvNGdTek1oZ2tHUm9ueHBPR2VJR0VrTDB5MTRs?=
 =?utf-8?B?bzhNMUJGVk51ZEc5VlozeXlLRkJSZGhaYjBWR09WOFErbzdhYXlaV29mY042?=
 =?utf-8?B?Mk9Ga2dmWnY0Z2ZqcDNOc0xjUUFyaFExc2NDK0c3RWl0MzZveGRWMGNiQ0lG?=
 =?utf-8?B?dmdIWkxFMUFRRGNyd0FzNTVpRy9CTVIzdnNiSk1PYmxQcDVxUklYNXVPK2xp?=
 =?utf-8?B?dlRWb3FIaGw1dE9qV3ZJVDh1RG5IeGVCN2NZVHJ0TE1YODVNQXJ1SnMxVnpZ?=
 =?utf-8?B?bGZ3ZUJQM2tFMXNMTGw1MEtJZ29tbVR4bFRVZGdXTDNTcEM1UHpEdFdyUFFx?=
 =?utf-8?B?UERiQS9OelVnQi9WQ3VQbGNRYkJKTE9MV0tHemltdHltRGtoYnlFVHhVcVRq?=
 =?utf-8?B?WkQ2Z2JFS01BT0F2L2V6cWJGVUZrSGdTc09jQ1NHNDZTbWNPM1lEcDQ1Mll6?=
 =?utf-8?B?ZGN5bHVydkloeEdWQys2cXFwdDMxTTFVZE9zVEhhelZDUHJsV281R0pKbytW?=
 =?utf-8?B?eUtTUlpNdVJLYmVDaU9HSGRmcitaMkZqbEtZMXE4dW9pcXVDOUVEc052enRq?=
 =?utf-8?B?K2d0UUZ4RGRNSmR6OTJ4aGJ1V25KWFdPTk9ta24vKzRTdDEydG9KNjYvRkt4?=
 =?utf-8?B?QjJxUDBScmF6enFoQy96SjRKM2xwSzlVdG8vU08rUEZrZnA4eDRORlZPazdC?=
 =?utf-8?B?Q09HcUtlRDExdWU0dy9kWHFMc3ZhcGpaYVladkxrVVN3Mm9CbEtzMWJ1Ykha?=
 =?utf-8?B?WG5PdEtDaGU4YmlsYzg5LzRtVmk0bmJSTDVkWWZCZ2drVmlaWGpjRCtoNWhC?=
 =?utf-8?B?V2RrclFSU0U2dUlLMHpLWlRqalJ4TUFTQlM0TVNXKzNkZ3dMTkhDd1MyY1Fv?=
 =?utf-8?B?eXRBcDhJeGJZUU1DSktERU5kWldXMWNvajN6WTdvWXpjOUgyTVIwUDhEWXZw?=
 =?utf-8?B?VXNZZTNOcTJTU05GcE1zUkI3cjAxMmpWSTA3MFdWS25wUWlHaWd4Q241SWps?=
 =?utf-8?Q?dzbKsGxJEEU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3pPZDdSTWhSZmlualZsTW42RnVUZkVSV1lIWmNJaDBVV0VwQTVwVWxuRkts?=
 =?utf-8?B?bTRTVGRQK2RWanJJR3UydDhQU1NDWDRuRDJWTCs2bkNmYVJvWW9kK1p5YWtr?=
 =?utf-8?B?dlg4dm9CQ0tKWVlPYkNGazl5bjY4R0hDNGhLckVYSCsrd0lCd1gwNEZ3ejli?=
 =?utf-8?B?VlB5K0M1dGl2QTVTQllzaGZUMzFEYmQ1TldSMmxCYlRTMDAweStHdHkyTW5n?=
 =?utf-8?B?aDFQcFIrMUdSc1ZFZUg2RDRtcm9wMStmUitnZktyU0pUdWZnS25DUGVvSHpH?=
 =?utf-8?B?N0gzand3RTVKY0QrVngrSS9PMjF5TjlDc1lnRFV6SzVRYWdJVmJlS3pBT2pn?=
 =?utf-8?B?M2NWckE4cmJlY0NBSnJJbjltOWgxMUY0N1BZQytscFI4aHJMVEJ4UTV4dVN1?=
 =?utf-8?B?VVdOYm9nQ1l3THhaKzBqR1NTSHdOdDhDTmlTK3kzbnozenN4V1NLdld4eE5X?=
 =?utf-8?B?cmQ4eEc1cW41emV6SVdrRjJJUDZ6TUQ1b21SYW5mdTMybURSdnh3eDFYRm1P?=
 =?utf-8?B?enhrYlhmWFNjMERhU1A1eEFsSW5xZ0VFcVBIMUUvMklxc2ZlMnpVRVM1TFhk?=
 =?utf-8?B?MGhPRXIvWkFzTlRoL3ZLZ2luWDk3bmJUN1NhMjBXNXZ6RzVrcUwrQVlUc3VS?=
 =?utf-8?B?VlhVMmxSbjdaQ2g1RUVMSWlwVVdPeWdyQ0xxU0MwVGRySFBzSXdtZWtKa3Rp?=
 =?utf-8?B?anZjMHdPV3BidjRsMHpQUHZKeVBucUxlKzhKNVNzcnpKeStjeVhKMWo3ckJz?=
 =?utf-8?B?TjdmdXh5eUJGTEoraW5RUGgvb1BreFRCeFdROVBRVWxpcGR5eGo0YnU1RjB6?=
 =?utf-8?B?d0JGandiTGhwejFycE9VaFZBYk1pVDdyVExUWkN3Y056ZEVQYjFUNGlXSjlY?=
 =?utf-8?B?RFFoeDFvTkk5THVjbS9IdXJwRk9JbnhRY3czUE1kR0lLNHF6VHZpS1JKRk8y?=
 =?utf-8?B?NGJBYk9rbzhXdDNCWGxMYVNXUzkxOHF3bVhhc1BOMUFwWGZHeHMrMEpseWF2?=
 =?utf-8?B?OFFjQ3JhZ3hrNTFWU0w2RkErak9URmt0T0tsTGdidGhEc0NsZ0tHR1RnVDhr?=
 =?utf-8?B?bUxZbStEcXVhbnN3bzY5VnhGQ2x5aWVySUh0czZOdHJLemc0VUpzMWliMTFy?=
 =?utf-8?B?K1E0ZjNFTnU0WmxRRmthVjdldmVTMlZIRGFpOXEyZFpNQnhnWVBqankvSmZ6?=
 =?utf-8?B?QkRzN2pNcHR0d2MyMmVuU3AyTHhiWEFTdWtRNUtXRUVCL1ZvOHdhVUtBSG9h?=
 =?utf-8?B?U3pmUTh2ckQ1NkF1aURnWXhtczc5SUdoSDBtV3lyRVljSHJxQzlZeTNFN3BV?=
 =?utf-8?B?SlB6bHFtNlVoeXJlSDNMSnlaNGZOQU93aHUvWldJQ29PUDJxUUdwak5zYS9i?=
 =?utf-8?B?dHFVeDFYVkdsNi8vWmJPUzZjczlLb0g4OUhwSFNuZFExTnJRYTZtd3VFRnVY?=
 =?utf-8?B?dEFqMU9UTWgrNkFCVkJyY2NNOTQ1U1EyY0UwZ2dUOHhpSUZxZEp2UnZMY2ow?=
 =?utf-8?B?QUJOVzlobEVyaG1aSkwvR3JnOTV2SmxwR2NYclJwSlJneFpKQlVBQ3NKbU1L?=
 =?utf-8?B?WUlzY29uM0JpbTlQZkJPWjlIV2FML3hnZ0Q2VWNtNXZxdEVsWGx5emxQL2lQ?=
 =?utf-8?B?MHVqMjdadi8yN2k5L24xNXgxZWJrTUVGRWJIb0J5WllFSGJyUnpsd3ZEMDli?=
 =?utf-8?B?SzlHd0lMbldUSmRUYjhNYW5ObXozY0hTZTdSbno1OHRXSjVlMTlrem1wR2Rr?=
 =?utf-8?B?QWZLUkpGQ0hvSy9vdmhmN1cvdFFwK2lqdlRQdVR4dkhXNllrME5IanIraEV4?=
 =?utf-8?B?V3BoTzVFaUxxR3pGcTE4SXhZWlZvMmEvbjRnMlhZT2sxMWc2cXVnSDJBYlZK?=
 =?utf-8?B?WWFVN2tlamU5NHBmOXZmYnE1dW1rUm5HK2E2SUcvcDhMemxVWndORWVCT1pR?=
 =?utf-8?B?RTVtRjlYZmV1QmU5NXlPVm9mdXFjd0c5Rks4YUs4dk56RUNXeFY1T3hsYzlx?=
 =?utf-8?B?R2YyN0FtVnJ2NUpWRndyL1VqdG05ZDJMa0pnZ2c4R3E5UGpxUkd4Zi9EL01v?=
 =?utf-8?B?WDZEWkd0UVZLYkVsUERMYnRXOCtiUloyMi9oUDYxcGh0eGRZTytjak0waE5U?=
 =?utf-8?Q?M683Q33WOMBlSYYjwmWxyJ1z8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16707d8-8022-4d88-78e3-08ddeb77bde9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 05:56:08.0084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmRJ+ik5mlB+bYbhpWCTn8+EnR9q05XjMy1CYul0A0Wqpg6WU1KMTxLB+TBwlGC1yYfW8GEkivzXTXYGYWj35A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359


On 8/29/2025 2:44 PM, Max Kellermann wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Without CONFIG_REGMAP, rmi-i2c.c fails to build because struct
> regmap_config is not defined:
>
>   drivers/misc/amd-sbi/rmi-i2c.c: In function ‘sbrmi_i2c_probe’:
>   drivers/misc/amd-sbi/rmi-i2c.c:57:16: error: variable ‘sbrmi_i2c_regmap_config’ has initializer but incomplete type
>      57 |         struct regmap_config sbrmi_i2c_regmap_config = {
>         |                ^~~~~~~~~~~~~
>
> Additionally, CONFIG_REGMAP_I2C is needed for devm_regmap_init_i2c():
>
>   ld: drivers/misc/amd-sbi/rmi-i2c.o: in function `sbrmi_i2c_probe':
>   drivers/misc/amd-sbi/rmi-i2c.c:69:(.text+0x1c0): undefined reference to `__devm_regmap_init_i2c'
>
> Fixes: 013f7e7131bd ("misc: amd-sbi: Use regmap subsystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>   drivers/misc/amd-sbi/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/misc/amd-sbi/Kconfig b/drivers/misc/amd-sbi/Kconfig
> index 4840831c84ca..4aae0733d0fc 100644
> --- a/drivers/misc/amd-sbi/Kconfig
> +++ b/drivers/misc/amd-sbi/Kconfig
> @@ -2,6 +2,7 @@
>   config AMD_SBRMI_I2C
>          tristate "AMD side band RMI support"
>          depends on I2C
> +       select REGMAP_I2C
>          help
>            Side band RMI over I2C support for AMD out of band management.
>
> --
> 2.47.2

Thank you for the patch.

Tested-by: Akshay Gupta <Akshay.Gupta@amd.com>

Reviewed-by: Akshay Gupta <Akshay.Gupta@amd.com>


