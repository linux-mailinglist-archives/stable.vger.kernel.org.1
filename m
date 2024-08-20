Return-Path: <stable+bounces-69740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B94C958BD1
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 18:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05CE1C220D3
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF9E195F17;
	Tue, 20 Aug 2024 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fI5MERkp"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995091C0DE4;
	Tue, 20 Aug 2024 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169543; cv=fail; b=sXFJDqCm+qBr+WxyaKPdBBtmnmLvgq71qpAVUD8ztxnEaCywgE45zFf2Lvlwmn95jFhFKEG/LWWQZqIVvwLt1Z4YqYDRMt2hDIuTBZEAc74/+qiqQKbbTqRtu/vze0pln/eTph/EHiRtV69SKq3tWW1NH66ZQkkQelPU3KcqpTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169543; c=relaxed/simple;
	bh=V8pFSLF647c4I9RjOrsj080ZPrACNto5ZiWnQG7ob30=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iII/OEr2dEvv2NYgQPtLLdwkQsovJBgu4tGXhJJkMyzcvkF28Sr7fHNB9fp3aeI/GgCoiDodte8EToJQti8Y81XVckj02OEv9Ip1GZEtIarlySBROCylhG3RxppELvcJPuF21PvnIsS3UrpAvYiitZMyeQnuThn/ZHjn06ijFSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fI5MERkp; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9GFVOJyJeBgJ1WNJ+3tDnbqTttOiluleOMmT4hWv352OgbXByY4cbjJseshd6ZWDwOJYbU5lAdxo7GlwN8OPJAj6lnAzxysWYC/X98xg+8tThuXrfdbXeBY97kMkWWCjYaSyzz5vXsaZEbmeDHCf5unyaFZHkIuMXljacvq0HA7EkmxqqzRaF2E15WaZD8HCcBtDXY09/opRsPpMxYkXtrNwvYX2OFhEzIJx6pMWD08gWNHSwbSscJRGgu+kSBrmte9AHwkOt4Ve0Os0g5wlKMpdqToFUOFxiFRREGN2fEqr+zMbzkK15Pst7wZu+lw1xYyHCd63NGImhLy9TTjVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvI7v+MfitVyRb6GwfDbfGlA0ZsPhwvxmYfq8SXAzOU=;
 b=UZk+ECtgkR8Rrwd3PGSn6BwXdTE8vEmlBpHBj+VO0RrTE0qPWZXM3WlCcBaPzxKo6oE4KhHO9XMOiaq4eZiXI5mrpcw1IXi0LxuhAX4egQOB+/cqKpCHfuGjSQuMjYLZ4K/tDgmclMtBpzzNnommqvgAht8k8FF9hXnDqPCtQIe+5bVi0DYHMC83bwapnRwa4+xw273pWg/q4/gHRDA+xBHa1upAWmWSdaer7Q1BRgucLPsAUp58K5udwpi58DLuxlkcgoklMSFdjg/4z03Kts3Gu5ik+PLkPITNchhGFnSEgJ+jFc89X0+EpzFEGvFzjZ3vYpXeexK502FG6TXPzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvI7v+MfitVyRb6GwfDbfGlA0ZsPhwvxmYfq8SXAzOU=;
 b=fI5MERkpJSlX81UOdexnzbM43ZDMCouEnsSmGIymdJYtRPs7IW/grdiT39BqEaxlGmMrHrG+EginwD1JF0QrvPjlgy6kup7EsrSmvjteYcVSxO4NlVdryFYRzkN5j7lIZnZdtpiXRKCJCISV8spbXy9UHXRCmcxGYad8lNnDhOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 15:58:56 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 15:58:56 +0000
Message-ID: <7153e858-12fa-4772-9405-1d85a14d8e73@amd.com>
Date: Tue, 20 Aug 2024 11:58:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "drm/amdkfd: Move dma unmapping after TLB flush" has been
 added to the 6.1-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 Philip.Yang@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
References: <20240820120325.2975003-1-sashal@kernel.org>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240820120325.2975003-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXP288CA0003.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: 6678e40c-3d8f-439d-57fa-08dcc130ff02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUtHL1AyY3JkZlpkaWlDZGo0RjhzUmRLblh0NzhnVnhSSW13NU9DckdONE1F?=
 =?utf-8?B?S1Rnd1l0czU1a3BVZElKZ0huVERUSDk5cy9pQmRiZEFtUXRVaVlaSEFvcEkr?=
 =?utf-8?B?S1ZoVEs5aHlvbHV2S2NOOUY1bnZFOGM1cC9zbFl2UnphWXVXQi9FcGpuWlNN?=
 =?utf-8?B?UFhCWlpXcmhIdHBLQXVtekJxS0hBWm9hMDR6d0huSGVwNE55V1ZWUkhHMTJ4?=
 =?utf-8?B?bXVScjFLazFSWXlxTkFtdDN1WUFSbHFCUmtmZFh0Zzlzc0RQQXc3My9VSjNu?=
 =?utf-8?B?Qk93UGNIclM1NEhTVTdpSW1JSnE1S29CeVlyd0prWWk5ZkxtdnVQRmlBQ2U1?=
 =?utf-8?B?V0FKbXFRSkgzZm5tcHl2QnJvOVg3UU5HYzNPRkc1VXo0a0lreUJIblc5b3VC?=
 =?utf-8?B?eFo4ZlpDbCtFMmFxQ0trYXRFMGwzKzJIT0ptVURHbUpjdUR5UklWL2paRVRu?=
 =?utf-8?B?TGkxdWhNTWJQbDNUSmZHcVVJckQrSjZGa1VSd3pzaVIyZGdRbWo4TUV5M0ty?=
 =?utf-8?B?dXRJdjFCN29DaC85T1VCUnM2UmQwRTEzSzI3cWF1QktBZDlvMTdxV3dGMFpU?=
 =?utf-8?B?MkQ5NzFreVFpcEMwODZWdkdnTDZhdUw3SG9PVDJjTjhJOHVVTlpqWlNCbGFN?=
 =?utf-8?B?TkJKQWNqSUtBOFhDeVNNK3E0VUU5R2ZlTWdZWFJuMklIM0NYZkpVWnBQYzc5?=
 =?utf-8?B?OCtReWJWMDN0a1kvM05OK096cUxRaUk0T1NQQkNzSlR5MGlKRHRacloxRU1C?=
 =?utf-8?B?MHF0OE1WWEFEdEZuRlU0ME5hMWpDR0hpUE9XUXdJT3NpTzEvNjgwSS9uWnND?=
 =?utf-8?B?UkU1ZnV1anEvWWpzcFhoaGxpbGNFM0ppcE9ybkVJNWloY0RweWlKK0VrOCt1?=
 =?utf-8?B?bWY1aEdlTXpSa2RmTGNZK1kxUUNBa2VTamRQajVYZ0FORUc2Nnk5ZXZ1MnVt?=
 =?utf-8?B?bXZrM1FnVCtUQzNvY3pjL3NaVW9MdFBHKzI1Y0pVaElSUFd0NW82amx5MTh1?=
 =?utf-8?B?cHRFZDJjRE9WRFUxVzFQOE9qYTU1SWFIT2d6MHJaZjZQSFB3Y0Z2a3U2S1RE?=
 =?utf-8?B?Q1lNYTRUUTk4S0dDUWNYcHNGSVRHcW5sZXBJN1VYcFh2SUQ3aGczNFlhUlBi?=
 =?utf-8?B?NmxocDJCamhCOXE0WUdzVWNvSmNLR3hQNzkrcW5zbVZwMlRIVFlvRTU5a3NY?=
 =?utf-8?B?N1RTc0JwMmJOSXh3QU1nK0krY0ZnKzJhdjVkVWNlVjFXaDZoem96ajZ5elhy?=
 =?utf-8?B?Sk1IeXJkaVdZLys5VXRoQTU1am0zYTN2QzZQNmw4QmRHd0w3STNYZXFBUlZN?=
 =?utf-8?B?TjRoak92K01LMlpwZGdWOWg5dkVzaW14ZC80YzRuVVgvMUVXdHhSU1ByUHM3?=
 =?utf-8?B?d3A2V3Z5eTBjRWkwemhYRUFhY3VIN3dNT1p0ZzBsNExCV3U4cHZLZ3kzaE5U?=
 =?utf-8?B?NndhcVZzcHVHVlhSclBpNkJSNEdBbGVZSEUwOXA5dGU0MFZPc1VZMGhOU3FX?=
 =?utf-8?B?QXJ5ZDlUMU9HWUtyUVBPS2dxTm16UWFSYlg5ckZuUnpnd1FvTllManNNb2p3?=
 =?utf-8?B?blZCbXpXaENIVStXdk5XT1NFY0lXaVZDL2dncHpLOFhEWmlEMXZkM0x6UGxl?=
 =?utf-8?B?TUVGdGZRbVVXZUhhMjhKWEZpbEp5MFNiM0tFcVQvemtiMXpwUXozUkRVUk9C?=
 =?utf-8?B?aCtBV0M3M3Uxa2s2ODE4dVl6SlpFNlpibDBRTE1TWDNVbjliUlBmQS83REMv?=
 =?utf-8?Q?mF2ZmEVpOXycISJ/j0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU05aisrYTBBbUZGT0VjcUxobzFnRDFFU0tnL2xkK28xZ3dqdnZaeWhINjdW?=
 =?utf-8?B?TklrUjArdExrdnRFM211THhCQ1hyc2owRUp6ZHFrMjUyMmpZa2liR1lzanpH?=
 =?utf-8?B?NGxYSlpyNHdrZ1VyUm9DbTBqL1Zta0dwbHdoVWZ0MUlvWlVSUXQ3c0lUK3dm?=
 =?utf-8?B?WGlsQnRCZEs3Ym1SU0VvZEhNY2hTMytKMUt5cDFFZHJMRU95QVZxQnVVUGQy?=
 =?utf-8?B?VkZpR2t6QWQ0Y0NiQjFZSFduVXp6RmN4RWV1RlFMT0t0TEdvcEpKOFJraVds?=
 =?utf-8?B?MHIwbTZwNUlJejB0MEJUcUlJbFlGZFd5Uk9KdllFSXNLR3MycGZTenFYU0Zs?=
 =?utf-8?B?RzB2a0FCdTRqTXBGeXJET2NGY1hHQjIySEhZV0xQSTN1Z2RQRWxyUktuQ2gr?=
 =?utf-8?B?OGZYZ2ZpRmp1WkFKU1RzVjhRQ3AydmYrTUlBR0x2OTQ2T0VKWk1yWnJBaWtx?=
 =?utf-8?B?YUhFeXc2RzgzUHRQN09zRXdYUUtOUm8remEvdFMzRExBWEVTTkxsYUY3djB5?=
 =?utf-8?B?OHZQcjVQWldaK015bVdaZEN3Wm1qS2VOOVlZMEVWZEg4YlN3NEFDSytnUCsy?=
 =?utf-8?B?WS90dzZkd05CNHpOV1N1UXdLSGFRNVk3WEtrWCt4cFdSR1pKTFRrTDIrREZK?=
 =?utf-8?B?QmQxTVQ4QVVxeXpSY0g5NE0xWDdGcXo0TDZqdkdBTFFDM3J3a3ZxTEw1Wngr?=
 =?utf-8?B?aUZGaWdpcVlmZXpFcldZQm5jNFNNbjFITlhjWUNEejVlTkNnT1VHb3RTNEVB?=
 =?utf-8?B?SkJjMVdteFZNTndTY29HQjhmckh0b2xTaG1lWUlvUzJIWk96VlR2L3l5cmJK?=
 =?utf-8?B?WHdYS2tLclVYOFM0OXJiZElGdndsSFQrWVl5ZStOMFB4d0VQVUlsM2ErL0lG?=
 =?utf-8?B?cUN5bzZkaEZ3NVFtRGtuRWFubGF5dGRtTWkxMHJRclhXMkNFMWFoUnpvRGc5?=
 =?utf-8?B?cDgrRDBaWFFaTmFqWExBL3MzcFRLeHRtaEw3NmVVaTdaNlR1NVlvR3A3eGEv?=
 =?utf-8?B?N1kvU2paRDh4bGszWVEwT1NNcUg2ZGtjNnU4bXJtRTYrZ1lWbFlENE44Ulpx?=
 =?utf-8?B?YlJPRXlHeFJkNWxIYVZvOUxFaWlJRm1LZy9JaloyWDNCcS82QS9YemRpWkZa?=
 =?utf-8?B?OG01VHBHR0tyTWI0aWdjMHB2VnF4RHYrRkEzbW1XT1RrRUIyT08yVExvVEhH?=
 =?utf-8?B?QzYwN0JQWXg5eTBNeTRUWTZ1aXU4Y3JqQ3htT2ljeHlNR0hjbWFEd3U2R0Jp?=
 =?utf-8?B?My9wNDVxWUErc2tzMGdJOXgweWxVTEZodTF4M2EzZVVzWXN5VUlTeHEvTWhQ?=
 =?utf-8?B?SUowbGpOc0tmcG1aS1FXQ01TaW42MDR1Zm5KblpCUGhSTnE2UjVWZlZ4ZG5C?=
 =?utf-8?B?c0tPTnNianl2VFdaOVlsN2RsTklsWGZ4MlVPRS9HbFA1YXRlR0JvMytLQjZt?=
 =?utf-8?B?dnFuRlB1aGlldGkxR3NKZDV1eE5aYnV3OE8wd3dheFhSOEloNmJCa3RlNW54?=
 =?utf-8?B?ajgzcEpoRk1BaCt2cWFHQjRxZktjYnpsMmd5MzZLOEpCOU1yYjd4QUx6Tm5x?=
 =?utf-8?B?SElsNWdManlMNk1VZlBNOCtiTC92TlpPQStqRHNHdGt1cHZPTUxZNHZtNDVM?=
 =?utf-8?B?UHNmdkZ0WWFDTkltMUtyZjdWQ2FGbCtUbFNFZGFYdGpYbVozcU5mQU9nNnhF?=
 =?utf-8?B?VEdCa0FsdGZuK2NyQW81L04xa3lmNGhySDlIdmdILzUxazQrRDN2WFBzZlFX?=
 =?utf-8?B?YVY4WlZWUkdWSEVXQTJONXZlWjl0VjlxbUhZTyt5N3lXbTljb29nVEdadDdN?=
 =?utf-8?B?ejFWME5HNjZtNnJUWmVyMFdpSEdoMjZ2ZGE3eXVIclFOLytmNXFreHR6bkRW?=
 =?utf-8?B?ZTBJT09FRkFYS1JnMi9NRnl2clV2c0xmd29aY2g5SnlzM1V5bFpzVmJOa2h3?=
 =?utf-8?B?UElvWS8wYXFLbUJkMXFmZ21NRlRGMXlFK2JXS05Uc0gvUWV6L3ZVQUUwS2xG?=
 =?utf-8?B?VEQxMG9FWEtZS1FoMGlKZWtzbVhjNjQvcnl2S3N2ZzVUMkdNMGlreWV4U1NE?=
 =?utf-8?B?YWtwZzhSelRWaDc3YnJkK0MrTVZsQmtEOFBkWkVnbWY4ZDRTazQrZ0FuWG1K?=
 =?utf-8?Q?IFMDOiPYH0qkVFeokKP+6hWMZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6678e40c-3d8f-439d-57fa-08dcc130ff02
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 15:58:56.2012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: re5HlfQ+s72KWMO3tBtVG0AyPgIxsLatkXEvsgN8w3TY333Wzatve8QT14o7g0aJyL9j6JwwANJG+67POcFr9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875

This patch introduced a regression. If you want to backport it, I'd recommend including this fix as well:

commit 9c29282ecbeeb1b43fced3055c6a5bb244b9390b
Author: Lang Yu <Lang.Yu@amd.com>
Date:   Thu Jan 11 12:27:07 2024 +0800

    drm/amdkfd: reserve the BO before validating it
    
    Fix a warning.
    
    v2: Avoid unmapping attachment repeatedly when ERESTARTSYS.
    
    v3: Lock the BO before accessing ttm->sg to avoid race conditions.(Felix)
    
    [   41.708711] WARNING: CPU: 0 PID: 1463 at drivers/gpu/drm/ttm/ttm_bo.c:846 ttm_bo_validate+0x146/0x1b0 [ttm]
    [   41.708989] Call Trace:
    [   41.708992]  <TASK>
    [   41.708996]  ? show_regs+0x6c/0x80
    [   41.709000]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
    [   41.709008]  ? __warn+0x93/0x190
    [   41.709014]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
    [   41.709024]  ? report_bug+0x1f9/0x210
    [   41.709035]  ? handle_bug+0x46/0x80
    [   41.709041]  ? exc_invalid_op+0x1d/0x80
    [   41.709048]  ? asm_exc_invalid_op+0x1f/0x30
    [   41.709057]  ? amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x2c/0x80 [amdgpu]
    [   41.709185]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
    [   41.709197]  ? amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x2c/0x80 [amdgpu]
    [   41.709337]  ? srso_alias_return_thunk+0x5/0x7f
    [   41.709346]  kfd_mem_dmaunmap_attachment+0x9e/0x1e0 [amdgpu]
    [   41.709467]  amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x56/0x80 [amdgpu]
    [   41.709586]  kfd_ioctl_unmap_memory_from_gpu+0x1b7/0x300 [amdgpu]
    [   41.709710]  kfd_ioctl+0x1ec/0x650 [amdgpu]
    [   41.709822]  ? __pfx_kfd_ioctl_unmap_memory_from_gpu+0x10/0x10 [amdgpu]
    [   41.709945]  ? srso_alias_return_thunk+0x5/0x7f
    [   41.709949]  ? tomoyo_file_ioctl+0x20/0x30
    [   41.709959]  __x64_sys_ioctl+0x9c/0xd0
    [   41.709967]  do_syscall_64+0x3f/0x90
    [   41.709973]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
    
    Fixes: 101b8104307e ("drm/amdkfd: Move dma unmapping after TLB flush")
    Signed-off-by: Lang Yu <Lang.Yu@amd.com>
    Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Regards,
  Felix

On 2024-08-20 8:03, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     drm/amdkfd: Move dma unmapping after TLB flush
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      drm-amdkfd-move-dma-unmapping-after-tlb-flush.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 24c08b999ba308592aa69e131bc36fe9fcfcd5be
> Author: Philip Yang <Philip.Yang@amd.com>
> Date:   Mon Sep 11 14:44:22 2023 -0400
> 
>     drm/amdkfd: Move dma unmapping after TLB flush
>     
>     [ Upstream commit 101b8104307eac734f2dfa4d3511430b0b631c73 ]
>     
>     Otherwise GPU may access the stale mapping and generate IOMMU
>     IO_PAGE_FAULT.
>     
>     Move this to inside p->mutex to prevent multiple threads mapping and
>     unmapping concurrently race condition.
>     
>     After kfd_mem_dmaunmap_attachment is removed from unmap_bo_from_gpuvm,
>     kfd_mem_dmaunmap_attachment is called if failed to map to GPUs, and
>     before free the mem attachment in case failed to unmap from GPUs.
>     
>     Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>     Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index dbc842590b253..585d608c10e8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -286,6 +286,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
>  					  struct kgd_mem *mem, void *drm_priv);
>  int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>  		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
> +void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
>  int amdgpu_amdkfd_gpuvm_sync_memory(
>  		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
>  int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 7d5fbaaba72f7..3e7f4d8dc9d13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -719,7 +719,7 @@ kfd_mem_dmaunmap_sg_bo(struct kgd_mem *mem,
>  	enum dma_data_direction dir;
>  
>  	if (unlikely(!ttm->sg)) {
> -		pr_err("SG Table of BO is UNEXPECTEDLY NULL");
> +		pr_debug("SG Table of BO is NULL");
>  		return;
>  	}
>  
> @@ -1226,8 +1226,6 @@ static void unmap_bo_from_gpuvm(struct kgd_mem *mem,
>  	amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
>  
>  	amdgpu_sync_fence(sync, bo_va->last_pt_update);
> -
> -	kfd_mem_dmaunmap_attachment(mem, entry);
>  }
>  
>  static int update_gpuvm_pte(struct kgd_mem *mem,
> @@ -1282,6 +1280,7 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
>  
>  update_gpuvm_pte_failed:
>  	unmap_bo_from_gpuvm(mem, entry, sync);
> +	kfd_mem_dmaunmap_attachment(mem, entry);
>  	return ret;
>  }
>  
> @@ -1852,8 +1851,10 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>  		mem->va + bo_size * (1 + mem->aql_queue));
>  
>  	/* Remove from VM internal data structures */
> -	list_for_each_entry_safe(entry, tmp, &mem->attachments, list)
> +	list_for_each_entry_safe(entry, tmp, &mem->attachments, list) {
> +		kfd_mem_dmaunmap_attachment(mem, entry);
>  		kfd_mem_detach(entry);
> +	}
>  
>  	ret = unreserve_bo_and_vms(&ctx, false, false);
>  
> @@ -2024,6 +2025,23 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>  	return ret;
>  }
>  
> +void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
> +{
> +	struct kfd_mem_attachment *entry;
> +	struct amdgpu_vm *vm;
> +
> +	vm = drm_priv_to_vm(drm_priv);
> +
> +	mutex_lock(&mem->lock);
> +
> +	list_for_each_entry(entry, &mem->attachments, list) {
> +		if (entry->bo_va->base.vm == vm)
> +			kfd_mem_dmaunmap_attachment(mem, entry);
> +	}
> +
> +	mutex_unlock(&mem->lock);
> +}
> +
>  int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>  		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv)
>  {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index b0f475d51ae7e..2b21ce967e766 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1400,17 +1400,21 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>  			goto sync_memory_failed;
>  		}
>  	}
> -	mutex_unlock(&p->mutex);
>  
> -	if (flush_tlb) {
> -		/* Flush TLBs after waiting for the page table updates to complete */
> -		for (i = 0; i < args->n_devices; i++) {
> -			peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
> -			if (WARN_ON_ONCE(!peer_pdd))
> -				continue;
> +	/* Flush TLBs after waiting for the page table updates to complete */
> +	for (i = 0; i < args->n_devices; i++) {
> +		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
> +		if (WARN_ON_ONCE(!peer_pdd))
> +			continue;
> +		if (flush_tlb)
>  			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
> -		}
> +
> +		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
> +		amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
>  	}
> +
> +	mutex_unlock(&p->mutex);
> +
>  	kfree(devices_arr);
>  
>  	return 0;

