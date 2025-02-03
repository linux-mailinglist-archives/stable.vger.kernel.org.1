Return-Path: <stable+bounces-112018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D14A259A3
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 13:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED153A70FA
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 12:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A268204C14;
	Mon,  3 Feb 2025 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EUrJ824F"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2139B204C0C;
	Mon,  3 Feb 2025 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586547; cv=fail; b=TZh957yINXne9UqPpOGJ5AYjeObdiy/PDKHZl3TATh2Cp/v+NACXCW9K+SnGBqjS2fz5QdVJEYXJEKFxwZgjutEwRvCx45HN8nXG3Pt5A2ByKHYgBn4UFRP6jvqwhqeYRh8E6jcC1gGCRbZeTvuR4T0vIh5ZFwvETeq51S8MFUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586547; c=relaxed/simple;
	bh=+PLjYtgGejKgOYCeiQHbo6XDoGzYacCljVYMQtPPXkI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WYK0OZrPoiWWXSC6jzPmnNdOwBjY8nI0iscd0dUZmDphCifhjpeUNYyHfNZKQhqKpiyCQNrs9qSjfADYmrZwNNfIzoxRvWcUmh/JR1jUp/OnT5rPvn2KIa5njcLEYmmjgQYZCe1vBc31+FRQZYK7jfdma8EIs5w423BUTPk2tAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EUrJ824F; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0QP55wp8D+5llS7NMoGIXy6v/bmLOknV7COvtutGEg80xn1IJ7qJUx/vHx/MGjXALMAQNKK4ysY6pAH/bw5NJaUXW2HXRAyKCRn5B4LI30Wu4mmCQqxNQCOC7dcHM/ahK/JEYkayzMR5YFQjpXgMV3g5w0+85+9vW/QV2YMkMlQ0ra/uecBMcGPYK0l7ENpUE3FUZGYCc7hb4w25hOlSYJMtjkbuvpq2DeoxZRMYH1jXVnC6xGv7J8ivaQT1y8PqhXoeqmk8tpenFEvcZ4rhq391KVr/MQAwYOBuUhIHuLCLuZ71nU4LtnKG/B9oFRAKQVJ0HYpY+YwD29ysBnuTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbaOJBgmajb42HeeQGQSN26W7EIrnXOvVl3pL71pjqw=;
 b=Z25fxH/JOXWloXHWPpCu98Br2xh51G/pXwBuSQHzprMwypVyh6vgPra/9vgDkIxOEBCicfCgVfJG+q5XYh1Umgv77ip0SP2V1ufw1u/2LbR8O21CyIB3v2BnrHIePc33nng6Ni4ffYJWVa0+yrJ+EcyZIxPYSiI5A448Waoj6ot9jNTz4GpqTHHCt3e8yAyOT/I9whvAB1AUlHFUtcXLKqpTS07B1+EJBntXVXS16qOEVD9QkiMrjp/3ERhmR7mF8prdsaCqbLIW9Ky+TrHknrXSmAMP8yBCmRySmc8IJ8A+SCILiBpIhd21daUSJ5554HzykLmR1pqXkYCL05XeeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbaOJBgmajb42HeeQGQSN26W7EIrnXOvVl3pL71pjqw=;
 b=EUrJ824FZ5uDWuuwxPtibOWygqQnIx/Coyx4wDAKJoksbkc+XOvU/LaD9j0sjJlqsm95PT2RB6EJI0N7GKYu4MUwTcHEeFjB07jw5mPcpW7EvKnGX6DBnMn5kZubJOCPtcD5F2uspHzFPcHNt8/p6tWu3UatOO2/3lnilauDqHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 12:42:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 12:42:20 +0000
Message-ID: <f295b002-3ad4-4fd8-aa6c-f02e67aafbbc@amd.com>
Date: Mon, 3 Feb 2025 13:42:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "drm/ttm: Add ttm_bo_access" has been added to the
 6.12-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 matthew.brost@intel.com, Huang Rui <ray.huang@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250202043332.1912950-1-sashal@kernel.org>
 <36c6750c-6bc1-4b56-bc9b-3c27ca23b8b6@amd.com> <Z6C5VoKzOeXZy4-B@lappy>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <Z6C5VoKzOeXZy4-B@lappy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0362.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: a74bc6af-11b8-4492-8b64-08dd445032d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFREbkFiSTRWUWdHWXJkdk1udUVOMXd2dHlibG1RNzk1OFlYOW5na0t1dFFh?=
 =?utf-8?B?b2wwMk1oazM1NlR0UEs0cm54ck5mVXV4OGNDUDdvdDZFemVkTjdMUzM5RG5o?=
 =?utf-8?B?WHRBOXRtc3hjU2p3WkFyZXFCUWtKOWR3WjUzUEJKZS9NTk56NVNxRkwzN2lU?=
 =?utf-8?B?K3p5cHpDTmMvQzJWYWN1RlorT05POXI0enFRRlg0MDU0UFN6SmFsWmk1ZTlm?=
 =?utf-8?B?aXMvRzQzaXhQbnZlSFFvMmFka0pta2pObEVEWm55NjR3QlNXdi8yTzY0bTgx?=
 =?utf-8?B?Tk0wdlAzdDl2Ynd5SW1sVW55dFVxSWdXK3NPUkJXaTVSRXROajREcUsyUkht?=
 =?utf-8?B?MDA0dDlUY3YybGoyVG9WemFGSEk5SHRwSUtkUkxiRjZDU0NqekREdDBmMTcy?=
 =?utf-8?B?NmhHdnkwZEdBeC9lTUJ5ajZLYXoraW05UlE3MGoxNVpQNnR1cUdoWldndTh1?=
 =?utf-8?B?WmxERGVnS3NaUGM3Z0hNUUtXQ1BpWGFOeFZ1NXNxb3lzYmkvaVM4T0llTGJE?=
 =?utf-8?B?eTA2RUlzWWdKRElNTkpqOXo5T1FpNWpud0g5RmlTejRTelgxQzFtZjJVQ3Ay?=
 =?utf-8?B?RHhoZEIzZmQ3YVB3OWxwR0xlZTZQNU1TNWJQUkdaTnlhcGdGS0UxWUV5a2dn?=
 =?utf-8?B?dzNSY1FBOXcwS1dPL1pCQ2Q3c1UwTEtuT2VjSm9ENUk3eWgxejJlanFDUkxn?=
 =?utf-8?B?UHNTUkc1d2FjRlJpWjVtNllaeElRQjQ1RjN0S1pJYUNDTDRzSERCMmlVcEJs?=
 =?utf-8?B?UlpQYWRqSGJiZjVmMDQ5cnpNdzdHZU9SSjZ3eVJBWHR3OXJqbnY2SXlHUTI2?=
 =?utf-8?B?WUhJN0l0M1dwL1kvbDNYdktGYmxuQ3RQbmtMOWZ5K0Yxd0FNTVpqVzhVMUlR?=
 =?utf-8?B?Y3h6Tk5kVGdSOHpGN1VHalRxQXE2Uy83aFBpV2pXaFoxU0d1amswalFqVmo2?=
 =?utf-8?B?VlZYT0dqZmJqOTlSV05xMFQxS1JiMGlSVWRBK3kxc2F1R05Hay8yYXkzY1dX?=
 =?utf-8?B?Rkt3QkloTjU4UUpZNkZnUUowcmN3bGdSbzlyYzUvdWhjL0p1Q2w4TGNNb2ho?=
 =?utf-8?B?dmIyUUxWQXMwUTVSU0JvbEFxcUJrZldjYVZiZjl3UHNGb3VGVTA5V1RGd0pk?=
 =?utf-8?B?T0ZWSGcrSzBMaENJT0hXSVFFbGRUWk9OdkdMRmlMRDdGVHJVU0FmOFVOeHBQ?=
 =?utf-8?B?bHJQY3kyTDlNSXZnVHBqeUtqeFVqNmxMMkhSai8vVE8zdDRKZFc4d2dZcjBO?=
 =?utf-8?B?Wi95a3VBUit5dExlWnhLM0czSjUzTlBMcnU2MFJBNXpvS0JLQyt1eE8veWt5?=
 =?utf-8?B?K3NlVHVJc2l2NXQwdkFmYW45VGFrdVpwTGZwajRjNVBBTWREbGFQdkZNWiti?=
 =?utf-8?B?SkpjSHRYbGw5MldhaEV1U2hZcGxFOERmeGs5NzhHTVRmVnZKMnJNTzJKMEVV?=
 =?utf-8?B?VlNoMENmRFZvSjdVVllSUXp1cUxNZWJXVVQ3R3BkaDhTSnh4c3MwdmNuU1lq?=
 =?utf-8?B?MkJzUGJLemgxMnFkek1iMVI5RkNsNW50SW1neTJyU1lhY2k2Qzk2VjROL1Js?=
 =?utf-8?B?VzFFQmVwNk9yS3FoSCtlV2syR1dSZWNCdktMSkpoQkw1QlhZVUErd3hrYmpk?=
 =?utf-8?B?V2xvdzhqcGRqTzhlMVdieElNNElvbS83UlRUamo5dWxpZGp3dU9FNW1aSU9l?=
 =?utf-8?B?NXhCU2Vsb1dxbjFObjNmV09iMVM5RkFzQU5JaWxzb1huQU1XS05GbXpOS3Uy?=
 =?utf-8?B?c2Njd2pEYXpCOElYWUNESys2aXNXMEtsV29odFNyYlZvTlJrRFA1bTBTbC9P?=
 =?utf-8?B?L2FuNU00Zk9MVEN6QWFwUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmxlWkdtOXNOeXFXUnFJMDV6ZklmM2hubG5mUGM3akdTVERvS0FDYzl2eFFy?=
 =?utf-8?B?UitwZFd0cERiRDlMVVFRa2pTRHp1cUFCVG5YS09XRWdiS3BNb29tdGxRZ2Ja?=
 =?utf-8?B?SDZaY0VBUHdSbnFRcGN2VDZ6UlRFSENMdTRLZkNhR29kVXNBWU9rdVZYWEl6?=
 =?utf-8?B?QXo4Uys0cXV4bldRV0RseGVlZmdDTTdQTXNRdVNodVBCVGUwRVBLUG1yZDhl?=
 =?utf-8?B?VGF6T3lxTElqL0lScVpYYW0rb0RSdU1FRG5EVS9IVERuMmhQTjVnbVBINURo?=
 =?utf-8?B?WG5LM1pTQS9yL251U1VzYklWM3pPUU9BaVBrazF1dzNlRXRIS0VKd1ZuTVFp?=
 =?utf-8?B?VGFUcTZVaWxyRGJYTHVFUDRRbi9qbFdWYW9QMkNHZWh0a3VoK05WTFQvaURW?=
 =?utf-8?B?RGtBK3NObSs2UVN0cjBwQThwdGk2ZHBaUlUrUW90WENmTDJLVy9uMWNUcDU4?=
 =?utf-8?B?a29oSk1PVWFnWTEvTWVmbWpWSkxrNThEb08zbFg0US9VZERYdDVyQlZEbnEw?=
 =?utf-8?B?TzlvR2dkWmtMMkhrNkdtR2lrOENkUmxQUGxMVmFuSVJIQWwydWVSRS9rVktv?=
 =?utf-8?B?c2xtcHpRbXBIOXQ2K04zUFgzOGw1QUY5dWR4V0RtU3NiV2IrVk1zaGY4TWVU?=
 =?utf-8?B?ZDZpeUNTL1ZmV1EveUljcXFEYmlJQjh6OVFYOTJvUHlKOEZHNFE5S0JTVEJE?=
 =?utf-8?B?S09YYXNuU0h0NmkyaXB2ck5QdWJqWTRnTE1rb0pYT0NuQmd1UWJQMGFISTVW?=
 =?utf-8?B?NFJLeFRtb3RZTXlFNmU0YlYvQWFBMWl4c21GZG5vUzBoZHJBc3VpMWwzMXVy?=
 =?utf-8?B?T1NTQlh5Y3hyZDFveHY4UTNlT2RBc0pTY3laRUh2Y0ZNZVEzRXNrTW5odjNK?=
 =?utf-8?B?TjYzUDAzTFUvcGFSR25FVXNmUXJaSytheDh4VWtndTRMdnNUQ3BYbXpISDZj?=
 =?utf-8?B?TEErMyttcWJJalQ0aWY3WE1qVUFzWEo3Z25ZVGZZTjJwbitnb1N0VzNoNTBV?=
 =?utf-8?B?b25iak5Wb1RBSWpQTElna2xab05xK254czhDY1BIc1gwR2tHZDNMakdtT3Y3?=
 =?utf-8?B?WW9hbnJhcVduaXJSVlNDT0IrcnNhaWhUYWJDNWk1Ly9vNHBLcE5FNW83eTEv?=
 =?utf-8?B?TytWeGFSV0JDdXRPOFVxclk1YmFia3hsTWpOSnNrcStqWlN5NERPaHk1a1pr?=
 =?utf-8?B?ZDlRdjlhcnBSVHhPdzFBUHFmQlZPQy96azFpamwwTWpkejM5Wkx5eklKZ1ZM?=
 =?utf-8?B?K1BsL2NmWEpmeHRZWU9KaFdLcnljWGorNlRZKzQ3akh4S1IxcVVYdXJtdUxy?=
 =?utf-8?B?RGZ1cnpPcHdJaXR2K2RDSk5aVW1VdEZ3WW45ZzdKbm4yb3RtQmlSMjg5V1I3?=
 =?utf-8?B?aFJkejR6MVdLdHJBcnFyeTNOeVhlQ1ZsUG9pYUwvbmZ0M0FWbTlna2w0bk1s?=
 =?utf-8?B?U29VZXhFSFpQQUVITFo5MGNrTnc5RjFjRlJBcmU5UmozOGtqVU1GOTVlcnJ2?=
 =?utf-8?B?RkNiQXJOczJmRmVDbU5MT09kVU9SekI3ZmNVTWJOaEhyalZWWTZTMEs1NGFQ?=
 =?utf-8?B?TVhKNnNVNVlQaEZGOVhwdVBoMGRkQWRrcEJTVTcxZ2xsNjVyaUVWeDZpL3Rq?=
 =?utf-8?B?L3NxTTJqUnBOaFh6aUVpMERtekt5Z1dyYS9Ya1c0RDZaNHdrZ1VraFZtQkxy?=
 =?utf-8?B?UFV6a1ZJa2tZazJEcktaVmllZ2NST0NtM1lValV6Tm14Qjk2bGdWV1FjdXRW?=
 =?utf-8?B?Q1VvcDU2ckhPVEhuQjBIcUc0S3krMnhJRmNpeEd4Qnc4UmgzMzlHaFJZaS9j?=
 =?utf-8?B?TG1WTzhBdmtJQmRCL3FjYzU4aHZvanFhU3U1cEtjVVpadG9SaFh4bjZFYUlG?=
 =?utf-8?B?TU5tbm51VjN4cTN0UjRrbkxLZmZLQnNrRDhmOGFBemh2dWZaajVaZ3dxVldE?=
 =?utf-8?B?ek5sNkJDck5EWk5VV3Y3aUVhaUlqUWFnc2h1VEtnaDZIeU9HZDlrSTdib1Ez?=
 =?utf-8?B?K2ZmTS9WQ2grSVNvU0xCenIyZnM0U1FRUForcGVTbWpBOHYrR2lkaEJTN2hh?=
 =?utf-8?B?Tk9ZaUFacVJoKzFzTmVnRnlESnUxODY0cnhJb05SVklJOVFaUHU1QlFhU205?=
 =?utf-8?Q?eInNYJqe5j/fsbhrFvpcpPT8r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a74bc6af-11b8-4492-8b64-08dd445032d9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 12:42:20.0980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nunK+9HiKo7reglsZNnxolLCknTbSN+O4FNek3RKMtNjZdiGGMdNo1eW5TvQiHhF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116

Am 03.02.25 um 13:40 schrieb Sasha Levin:
> On Mon, Feb 03, 2025 at 10:22:57AM +0100, Christian König wrote:
>> Am 02.02.25 um 05:33 schrieb Sasha Levin:
>>> This is a note to let you know that I've just added the patch titled
>>>
>>>     drm/ttm: Add ttm_bo_access
>>>
>>> to the 6.12-stable tree which can be found at:
>>> http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> This isn't a bug fix but a new feature and therefore shouldn't be 
>> backported.
>
> Right, it was added as a dependency for:
>
>>>     Stable-dep-of: 5f7bec831f1f ("drm/xe: Use ttm_bo_access in 
>>> xe_vm_snapshot_capture_delayed")

Ah! Completely missed that line.

>
> But since 5f7bec831f1f is going to be dropped, I'll drop this commit
> too.

Yeah, that is a good idea. All of this are new features and not bug fixes.

Thanks,
Christian.

