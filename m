Return-Path: <stable+bounces-112177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95D5A2756E
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 16:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616A43A5AB0
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 15:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66190213E84;
	Tue,  4 Feb 2025 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PCqLYkDk"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A299D214217
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738681773; cv=fail; b=KgA/eVl7ZXeeVoSAplo/njDMkfBCDX/rsg7p8MeTUwQ9xVe60im7/RIfIAwb3EY3heI0YvBMOhz/Io/vg7ICt8FVj0Z5JtxgDCVaMKBP7xokSfSK/C5LWOQKqGnHiVdvTrRUB5FTBAaWf4G6+acjaSk+oMbDPsGcM8rDaH3uZQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738681773; c=relaxed/simple;
	bh=usxyysVYq61wjauayc1xg2NkJyIpsOohGjJooOULkwQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cucygxm64WljSMAmBgDWA53qQKgYe+pzYbeSWJKnyYOA//tM4SldqBq/tWYa9ZJraJZwnM8rC8ifGx0gID+Q9UfuVceJ7IKgaXoaPRCQ0peyXQM471Bu44j5dTQb3cOA+gOL2A2Pb6oYiTONb+hLyCIgoteybZTGiFWUrPDa1iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PCqLYkDk; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siSP7m0VaIp1LFxIEVWmWJxY4XYHpTVDjXzNIfuMn4l7P6U33VF2P/fw+DLnx53k/AQ8anvr2NPNEsXS242ekdxGw5X2kG3aIm9jIese2lGGnm/4GxdpWu8G68MJ5W9Uhk0rW7XXgOnlfBVWzqnr5mL61xHH26rvI+dau5Zh43dokHTfmxobV8h/h/193rLR/XF+TyOiHCTjc1rdXw3djfvcv7Op7y6jkgzraUqkIbqwcOEVZEPublN5NMEVttBkHknxaWj7f6zpPMIynE6/HX7SFfWED4jxrmLNkcZW/tnG+wff17hqjmFZVBl2ZSt5U/uQqMvRg/+M96i+LP7q9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbMfH42uduHcRdsvMcbNC/EOoZH6xP7T239vOE1sbeY=;
 b=cadunPUl6mA8ifrWWxYMb1ah1g6OHN+iKCpOkU87Ox9P3V+UDdyWN6Z+4FRIXICp8XNfIrPJWnS7HtgihGerrtJKOMRZgmbHQ9XPyNDfJjpZB7+SASwwDRKJ9CFLSusr/LEbCHw71S6QnS9n2wODosJgMhAtVNb9gwY9eM07d0Ug/tmmBz5S4R1H9hmDnxhY5jSDX3OLaGRcTvgFB15AE74e5zf2R6lewx7hSiU9l6aBFgMsvk+0bkeU/09vFCayBra17n9rxmfvfr1v4ksi8RgYwe4up9TfsxVtFNmgGK2SnasZM6e3no4kj2V5YE+KXoPy7Oay0yjik/xtLyULFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbMfH42uduHcRdsvMcbNC/EOoZH6xP7T239vOE1sbeY=;
 b=PCqLYkDkNQp5r5e/smFlNNoJQjMwlxglPCFl1+2J22Zy3t2CjK7Oe7ZlCEAJlYvT5cvNCdMPPAqOSufVii+kYSm2ThWsu7BL41CE149rxcnxQ+4FVf7GjWUwxPZ9QffHE5gzaj8LbKg+lGh4sADCm97zqllAy1n3aIj1nexC4vk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 15:09:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 15:09:26 +0000
Message-ID: <158c997f-091b-4f68-b94d-47d02b11a05a@amd.com>
Date: Tue, 4 Feb 2025 09:09:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y] drm/amd/display: Reduce accessing remote DPCD
 overhead
To: Greg KH <gregkh@linuxfoundation.org>, Wayne Lin <Wayne.Lin@amd.com>
Cc: stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 Jerry Zuo <jerry.zuo@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>
References: <2025012032-phoenix-crushing-da7a@gregkh>
 <20250204101336.2029586-1-Wayne.Lin@amd.com>
 <2025020403-conjoined-murky-f8e5@gregkh>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2025020403-conjoined-murky-f8e5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:805:66::43) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: 879c0d7b-eda5-4dfe-babb-08dd452dea75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2FKMFpMSWVYckJEZW5GSS9Tc0dmeThheStJWFhsakJWakpGV2pFV1RjZnla?=
 =?utf-8?B?d29CMHArRXR0OHVhKzFxeHd3M2luNjRRZFFhRngvWllZNm56V3o2N29vNGhV?=
 =?utf-8?B?VVgyVUo5OThwOXBtdkEzOU0xRTZKL2pOY1I3Q3VmUjhjOWV3clpyL0JtZnR0?=
 =?utf-8?B?QTBOZWlQeGlRQU1vY01JY1BIUVFUejNLanEzclNrUG9VeEwxWjYvQnF3WVJZ?=
 =?utf-8?B?QUtkKytaVVI3dGtBR3I2ZFp6bWhYeGV4MndWMlJSNy9JT2ZXU3FkUm1PZ0Zs?=
 =?utf-8?B?cmtmSUtmZ0c0UUhkaSt0cy9aWWVEaUlxbkJtUSt0eFV6a0hhbHovRUQ3cWhn?=
 =?utf-8?B?ZlJwaGF5aVlHbmR0cVNZQzhXTDhjNm5UaHAxVU5tdlFtZWdZUjJxNzBTS0ZM?=
 =?utf-8?B?RmdwZ2FtU3hrYkF4a3U2c0M5SlgxUENiWlJ6SllXWU5qUzlaSnVKSFdEY01D?=
 =?utf-8?B?dEdyTXVKbklXc2N6Q012TjZMcExoQmN0VmdxUmVsM3RqYWlLL0hBU3pYMEQ2?=
 =?utf-8?B?cXJqczdrKytuMUZKNTArUGYxTDNMVmtpRG1DbU5RVGhqcGE4ejhLSnZLeEUr?=
 =?utf-8?B?Nzd4a1cwTE00MHpsaUNYMXZYaXpRVjc2UFg5RGlWZkpocktoUEh4UThqbnJR?=
 =?utf-8?B?SmZaVkJlcTMvVk50SDFwOWdpRXU2QmtkN3VWcEhweHJ0cjRtNzFiZjkraDEy?=
 =?utf-8?B?UmN4elIwb0wvWURRSnExNjIxT0VTOTJFelJBWHBzRXdzMXlrM2duUTNqMCsv?=
 =?utf-8?B?dmlaaGszdEMrOG1TR1E3SjJ2UHhET0VzbmVrMkQ1UlJxOW40aEhJWGJvc0ZQ?=
 =?utf-8?B?Y1RVWmlySFZDWWxkWVluYy9HTWZVYWtkZy9hZ0JoSGM2K29WZy9NMGhCanlJ?=
 =?utf-8?B?MnZZYmM4ZlFyUzN3VnppTk8zbm9HTDkvTDJ2aURMQTIyMlMvK2ZGNDl6L2F0?=
 =?utf-8?B?d0l4MjlzK3BqUVkwZ3RITzJtS2c1WnFwZDhWRFhuclVpenhrdEsvcFJOaUlZ?=
 =?utf-8?B?SEZhbjhSOTlqYUM0Ukd4dDJ5MEVDZVdUd21hMG1iMWcrZ2o2dlF4QkFqN05H?=
 =?utf-8?B?MTdwR01IZkZXcUdXQ1JVSEpocEZhL0tjK1VXTktKdnoxbXo2TGZkUHNOV1gw?=
 =?utf-8?B?QlAxVXJ3TFpQc1ZjOENBbGR3aGptZG5XZlV1YW8wMVhJSVRDTTRLeUtFb2hH?=
 =?utf-8?B?ZnRRODRLOGs5b1ljdjRHSzFOeXpYVFQxd0htdTAwVmhrUG9mOFdsS1JjbkdL?=
 =?utf-8?B?a1diaWJ0ekl5b2VhOUJXNXYyR0k5cjQwZXdJZnJxdXR3dG1lQ2hYaDRNclcx?=
 =?utf-8?B?bmloK1VIekJHSTd3YURvdzQ3YXl4dGZFRmJ2RGZCWjR0eFR3bnJMWWp1ekU2?=
 =?utf-8?B?cG9vZnd5NWFBL2gwN0xxWjVGbFBudmZPb3lIcmdMb2x6ajdnUkpWZXRLNElm?=
 =?utf-8?B?Z0NvMUFFUFRrN1l6dmdmUXMzdWFJVE5mRENNWGFOWGZWWHV4T1MxcEhnWEVR?=
 =?utf-8?B?ZHVXZ2VUejk0MGQ2MDRBc0tPMXpibnlQYkMwNTFzdlkxOHEyekZLdjcxcHRq?=
 =?utf-8?B?QzBucTUrem9RYkNmVVhsaGxOcGQvVmh5NWl6TzIraWVUREh4Zk16WW5DQ3R5?=
 =?utf-8?B?L2xGaFo5ZlNnelVWTHd0ZXJUd21TbDhEMVVYUHpCcFJsbHlzdng1VjFWL2xu?=
 =?utf-8?B?aXlEK2xuR0FtTzlFT2pPbTdYSlpCRnpqVnBybmtaQ3RkWnBsNUN0ajFNTGJy?=
 =?utf-8?B?ejh2cEY1WThVbzExanVEa0pURWR2OXExcll6bnhvbXo5R2lXcU5GRUlaRDY2?=
 =?utf-8?B?VTY3dFdaN043SWdWYitWUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk1ZaXJBMkZ4SzdxZVRQZmJSTkEvQUo0clFIK01MQU9vNld1MWZNRDlScE8v?=
 =?utf-8?B?VWM4Y3pTekNVcGp4ZVJsb2VvUWoybGpZczBlc3ZxWmE3cnQvbFZMTVhzN2J1?=
 =?utf-8?B?aXBoREFsK2QxeUJ2MUplbWFHUmRsemhvSkt4R1hyeHFNS3p1c2lvc0NRVFNT?=
 =?utf-8?B?c3pZaDExN0tjY2pkaWZEV0s0S0g4YmZvZmpWSDVpWlBwUlJDWGlSNFNxN2Z6?=
 =?utf-8?B?aVY2bU04OVBWclpHY2JuckFDMGZSSUxXNGUzbE1pYUZhUE81MTVFMEtZc096?=
 =?utf-8?B?MEhrbnN4aC9FOU9NcENiWjd1djRnY1o5d2d2VS9WQmlSaEJPVmFKVGVqWkli?=
 =?utf-8?B?aXpUUENkREdpV1ByTWFQZGgzQ2QzUks0bnRYYXJhN1dpR2FERzVzdHpMWllU?=
 =?utf-8?B?VGlGYzJveXBOVGE4LzJKVitiRXZQYnV3SWhicjJ4N2oxZEZUTnU1T0pKNGdq?=
 =?utf-8?B?LzBnNStabXV0VCtaZFVWUXYzZDdaN2Z5NEJpWFpZVHRGSWF3VGEvZnYzdGtB?=
 =?utf-8?B?UXVlcGZNSUFKQjFKSXRmbHpsVlFtL3hnWmdoYVlzNkhDMURyeGNrSFRVekN3?=
 =?utf-8?B?NUc3bU9JUWo0UWd2SlhNS0xydG1FblpzbmlVMjFHNzdKclB1bzVEZ2xHaHpa?=
 =?utf-8?B?SXJCZDZ5eHR1K1h1UDJlR21MaEt6bTBZbVdhOERiOU93V1p2ZEVsc29hdE9X?=
 =?utf-8?B?QzdNNUFVbFVNU1BlMndvS2tmRSt5R1BaeFlZaWlRZW9ZQnhsc2FSWEZYMUly?=
 =?utf-8?B?MDM5WVlrdVhFeHVtdkFoVktoT0prY05kQ2hUSXRNZWFVSHd2Sk5UZFY4UE10?=
 =?utf-8?B?WjBOSnV4MjhScGNDSVdQN0duNGEyZ0hNdGNvWlpvK1pXM3BNNEI1anhRUWtx?=
 =?utf-8?B?ZXAzQ2VDenYzckZheFdVdTl6NEpWcVFaMmR2RGp4SVZGanRTME9QQnhFTVVY?=
 =?utf-8?B?TGhGbi96dG02RG4zUWlrYnlNS0k1WXM0ZGlZRDV6U3dLZi9VZWxYT25CWGR5?=
 =?utf-8?B?Nm5nVHFia3Rzak54M3QxMVA1Vml3OUszZCtvTTJwL0d1ajFoZlBuU1RpL0Vs?=
 =?utf-8?B?Q2N3WUtWVnZwc2gyMVV3Z1UwYTRMUWFMUEVaNk12aTRMWDdvN2l6WExxNnNF?=
 =?utf-8?B?OUVsbUJ3WEo3RmZsQVFtcURXQ2wyWitGN0JzZVFYLzVGWUZFeHh3c1B3YzVN?=
 =?utf-8?B?TTV6cFFlOGY2MjhCUW5jaHFNNElXS2ZNWFREWmdZR0VrbEdubVdrSXdTSGpk?=
 =?utf-8?B?RUFRZDd6KzVEMldEaTlQYUx2RnY0bTRpeTJKMGo0bDh0a1o2Um15MkhEYW81?=
 =?utf-8?B?Zjl2NGN0WFF0V3NzdWpzYmFsYlErVjFDZzZHdGZPL1k1STBHZVgxMmNHV0xC?=
 =?utf-8?B?YU4yMVdhaEc4a2xUMFRmN1R0bnJMbHE0SkkrTjg0bllTdzFDcS9OQzllOGJi?=
 =?utf-8?B?Ty9xbE5NUm94Vi9LbXBCV2dpNTh5ek1TL0xjaGEwQkdtQk5hNnIxNWNuTS93?=
 =?utf-8?B?MzhhSEs5ZHBYTW9yWE5EL0RVdDVMaGNieWpLNEZzVklaS2R4QWFGK3h5eUtO?=
 =?utf-8?B?T0graE9OQWVzWlJuRllqbjdLcVlNaUUwTWh1VlpQbjF6aCtmcE15SGxhV2ZB?=
 =?utf-8?B?K0ZNczFtNnpvQTlWWDVoTk1rT21ZalRsSzB6Q3NDQmVBbHhyVEs5MmQvdW9o?=
 =?utf-8?B?SGpLbWZvVng1MSszU2ZxQVlrQ3pCZWlGZ1QrMzBkRi91ZWZ2dWdXTC9xQVN0?=
 =?utf-8?B?ZURYY0lqWkc1QzVBQ3VqZUpkcmltS0N5NksyOTIrL0tRdnJ1V0hOK1NDV0d3?=
 =?utf-8?B?cldWb0o0S2w2Nlgvay91Z0ZPS29rdEplK0JOK3hycERURmUxUno4dDBibEMz?=
 =?utf-8?B?ZXNSV05vRFJQS2ZocFlQVHoxb0g2WHkwR1pvNVloOEtnV0Ftc0xoQzRvNWVI?=
 =?utf-8?B?MXlUQml5TEFTRTF1V1BxeW5oQ0N0RlJvK1QwT1JQQUNLZ3YrU0VvSE5Hc1dR?=
 =?utf-8?B?QkhKakhFNlB1SFc4UkRJK3VJR2pEbDNmVzU3R0VsaVF1M2cwOFBTbFBIU3kv?=
 =?utf-8?B?UWwrcnEwQTlVcVRTWm9ueUpyeWZxQ05RTVBDOS9OVC9kenNpbmUvbEorTy9x?=
 =?utf-8?Q?7qBq067WJZ1b0Ek4Wy8trIlDr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879c0d7b-eda5-4dfe-babb-08dd452dea75
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 15:09:26.7894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QeICwLW3IbG3qEI+TBy56rE6TxxkZaeAOlAhrdPLRRTerj89hwBBVJo7enKvDgr2yDoSfOa1UINA1ePchejOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6733

On 2/4/2025 04:22, Greg KH wrote:
> On Tue, Feb 04, 2025 at 06:13:36PM +0800, Wayne Lin wrote:
>> [Why]
>> Observed frame rate get dropped by tool like glxgear. Even though the
>> output to monitor is 60Hz, the rendered frame rate drops to 30Hz lower.
>>
>> It's due to code path in some cases will trigger
>> dm_dp_mst_is_port_support_mode() to read out remote Link status to
>> assess the available bandwidth for dsc maniplation. Overhead of keep
>> reading remote DPCD is considerable.
>>
>> [How]
>> Store the remote link BW in mst_local_bw and use end-to-end full_pbn
>> as an indicator to decide whether update the remote link bw or not.
>>
>> Whenever we need the info to assess the BW, visit the stored one first.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3720
>> Fixes: fa57924c76d9 ("drm/amd/display: Refactor function dm_dp_mst_is_port_support_mode()")
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
>> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
>> Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
>> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> (cherry picked from commit 4a9a918545455a5979c6232fcf61ed3d8f0db3ae)
>> Cc: stable@vger.kernel.org
>> (cherry picked from commit adb4998f4928a17d91be054218a902ba9f8c1f93)
> 
> I'm confused, which commit is this exactly?  Both of these seem to be
> the same, and you can't have 2 "cherry picked from" lines in a commit,
> right?
> 
> thanks,
> 
> greg k-h

AFAICT what happened here is that this was a case that the same commit 
landed in 6.13 final as well as 6.14-rc1.  So when this was sent this 
out it was cherry picked from adb4998f4928a17d91be054218a902ba9f8c1f93 
which happens to already have a cherry-picked from line from 
4a9a918545455a5979c6232fcf61ed3d8f0db3ae.

❯ git describe --contains adb4998f4928a17d91be054218a902ba9f8c1f93
v6.13~16^2~2^2~12

❯ git describe --contains 4a9a918545455a5979c6232fcf61ed3d8f0db3ae
v6.14-rc1~174^2~2^2~16

But it looks like you've got it sorted out as I saw it get added to the 
6.12 queue.

