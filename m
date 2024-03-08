Return-Path: <stable+bounces-27133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845B0875F5F
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 09:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71A81C217E2
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 08:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8280251C28;
	Fri,  8 Mar 2024 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2JaReTZj"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7A951009
	for <stable@vger.kernel.org>; Fri,  8 Mar 2024 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709886199; cv=fail; b=R+lDVF4Tyz+L4+kQHdkiyqcnDgZ5mQjFmgEpboyBDXWUAo4/2ydInlzP1uizGYYeq+PJzd5sK+Rr/3RrXSxPiYqJ/8wdtPq35gM8WzC9A5WrC/SAkdYI8DWyVHjhVrfUtXgbtknfoXse1xHMcUGiID7MFWaRKDSqJTXtt89PEFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709886199; c=relaxed/simple;
	bh=r7rS0jp1Qi2rGe8eHPbdjswPxJ/XY9Rt7ghPZmMI/fE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JhP7IVJNSyzVBHiERjJ0046QMk8dxIsFwDrtsRRh3CKcbqg+D1eRJfDqAhXhL51YhxgoVTJoe4nJvaJBHCRB9AesMJCBNko5akQNTRNBWyd+ThnoPdhn3cTnu2nNfxbF08lc/VPRCoTEaktRVPdj+5s3mZ2hu/XM2h0tUW36LWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2JaReTZj; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fma6UP8vFqJDu+6dYD5bagbGAxaZT96dZBQvd2qFDh0weUeqgFi24VCHjWJra78QDfn8tFFjrgXIEoFtfVPMhBUAd2eVZLPvJJDc60gx5FFDAUmOw6YsqK9MLl3YP1DvW+yTjk/b7CqFKOQA/8BF3d2NrE7/v3+eIISwaeH+T09Y2LtlzFEnohV6haYshgw0nL41onRXjkwqjTdMmxt3uquVsl4hgfRUsuU9LKqX/EYMbDIdi93orr/RwDWY/r5VGkqZhFxbDhnQf4eX1kgPqTH00tDpKUkLKNcC3WaxSmASgWYLTQ5H9vsZRXNgdTEESmDxTPshvTWQcRLvIJlhtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocZ3EK35tdZHqRa2jIwlCH5L9E+04Z6r6kF2Z6U8YxE=;
 b=WtC4ewwl7bxmU7Yp5X/TvPkLC5/4hstPmX7FTqwUkc7K0j3ktiDME7ClJYG4IwLA2j+oI5t3sGmLXGwOabT4bFzvKf6mp8AepUNDTa65sd1/pJ480AHUBbMZaSqT7jplhwi5gyBGJ0eYA6HNM/Ol4Rsu+QCdVqAGwMmuhiv4QAgW+gDuxTxNkpXvos55ho/PT7sCcDDd76bQ0pmbgkQyFzgYkTQo88LAZKIEe4pCOcwyR2MrLwLQAFnTpBjzFn+yLi2Pmody47DUFyNLlaSy6V2ni2ZpKvbuwlZ24DEF+5X3c1EOFmLT/nFzSbSr4epkGK5n4ENa8vbLkAV1WMYzOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocZ3EK35tdZHqRa2jIwlCH5L9E+04Z6r6kF2Z6U8YxE=;
 b=2JaReTZjJ7/+jSdk+i6dlM9g6dcfskMKiaonQM/SD9S0Q68tgeep1mfOTtYGW+EX9Lb9bWli/gmRxC0zVi5Dvx7gQ3zDUcY0V04uQeDSDHPYYSRI/QnJet/R1kF7KPKC/10Dx/1A9d96VpB1FinaLZlNndNI52XQbvlgoECZMaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 08:23:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 08:23:11 +0000
Message-ID: <ed4bc498-e9dd-48ae-8b39-ebbc63fbf79e@amd.com>
Date: Fri, 8 Mar 2024 09:23:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Determine soft recovery deadline next to
 usage
Content-Language: en-US
To: Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 stable@vger.kernel.org
References: <20240307190447.33423-1-joshua@froggi.es>
 <20240307190447.33423-2-joshua@froggi.es>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240307190447.33423-2-joshua@froggi.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0243.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3c4c0e-8259-4475-6841-08dc3f48fdc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j8cyCWzSuqT+RKU59WQi0AZUPmpxkPvJ9SGNzjOISOKo3ujGGpUjWfb/iSOQDnEIW8B07stCj297VtTiN/STC6syU7diABwAPvRuHWYjOSdQqJOr1z0xw1CpbVYqSh8GILzF1uj3m+iWX/H+1/OJK19+jjpmvjiLs9QJxl7TBGpdLcZUugzSzvjXugcr3yaboqDwigyJ9HB6NgKLKWDPQ8Assk4+4UDq4KM/seSXN1GNWbJPKYWp6sy4W9BQmxNAIHf9MiMjxMixjVQHH2PeMt4ZNonC5JvzqV1u5MgfLQmvQ4dIDzpOT9R+4YlOyp4S+W0RtV7r7bzYCazLYyvHNXC2zHSuXX3lJGj9r+7EYSmcGrcsxvWD6a47Qa/njtZ18CuOdMUF2uf/X5PiVX9eCub4IZ1+VUCB+q4E8ajz0FY5Kgx/2mhCCcxoXj4ELl9ioyxCL7mFpObggKhXo85qxI1SliwH4CsndzyqPKWnQHX9XiPbO8mvFIsfiLeKzpXc9lISFBJE6jzQkXyzEWcoJNA5hkr13ZLl5lZYjRHg4O+fvuHXug9xrehKJlPoOQYnRn6di7CtBaypBBRfH/iXZg7C+H+34h7y1D9wjh8rz/H3EH1xJD4+QKcn0G5nh8wfrr8XYMhiHxSHrOHnsebRS4z4xDtqhaaZs8y/mVWgtAs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkc1NUxlRlFuWFBVbXBDQ3Z4b3NCdlMwcFdSWFdjQktuTVBFcGhzOU5McUk5?=
 =?utf-8?B?ZmlvSmxJSTFyNWNCd1RySXFDd01sU2t6Mm1KUDRoaXAza3RUTHBJQURvTGU2?=
 =?utf-8?B?T3BHSFVURGNaYVJrcWsyV2hPZmtNWEY4SzRxSlR2WktUWGdtYTlQNSt4NXEr?=
 =?utf-8?B?TC8xWGFrbFFjQmQydklHaEJIcXpFbHRadjZRU0FxNTdqVHB4QjNVc3RwTmsx?=
 =?utf-8?B?YXR4UHRRVHI0QkZDckFESkE0WWhOdXNwZVhUTzM3N1d0N3R3R0F6RnhzRCtM?=
 =?utf-8?B?eGNIVERXRGdIZEVOMVNXU0VXSDRsRWhZNUw0WC9KQWxHMXFNNXlzSkVJMk9j?=
 =?utf-8?B?clIxNWQrRzdmWkp6cHVOd2IxT3ZWNkJZd2NiMmZoYWJydkZ3eEg4bHhiVmhQ?=
 =?utf-8?B?Y3pqNzBNYVZnK2dBTDg3blhmUjQ1cW5vUWdyOWk3MlJIQnpVa2NoeC9tN0dM?=
 =?utf-8?B?V2tSMVllbS9odlNtSVd3ZFdjdjZaREN3Z0pFeHJJK3NyWE1JeHVMZ0NLU1A1?=
 =?utf-8?B?TUZzTUg1UEN6TThCNlEvMUVQaTJlakRDRG5JSDBzOWkwSUs3bFFTdzNSMzFa?=
 =?utf-8?B?akQ1VDlhNFB1SDZnQWxQWVVNWWhUL1U2NzYyZk1rWUQ1Wkx0WGQ5eXZOSTNk?=
 =?utf-8?B?NCtHc0RYOW1ZYW9DQXRQK3R1OUp5L2RhcUIraVNvVVdyWlNzeG1YaXJuVUZn?=
 =?utf-8?B?eFdNRGxCU1MzTjNxanhuQzRYdzAyUW9ldkhKMzFneXFrdWVPRVUvUGk5RTVC?=
 =?utf-8?B?TmtUcFI4anJQc3UzcG9WcHNGbzkyK21Sb2orb25La2ZLRTByelA5d3VaQlQ2?=
 =?utf-8?B?Y3pRbWxsM0tYeEhnYW1DcjlKVVhjdk10b1Jrd0wxWTJlUkZ3Rll0WmtIMDJa?=
 =?utf-8?B?aG1CenF1QnJzSVhZQm5tWXNScTVnY2FEV3hCbEhvNVg5WDVrcGswYmM4Ny9s?=
 =?utf-8?B?UU5KcEpFSFY5RDBMNmtsd2lyWmJ0ak5ETWhTODJQVTJUZTk3eHNIMERidzB6?=
 =?utf-8?B?TSsveFNpWVF5eVY4bWNSUXZmem9sbEVETWxQNVJkRG5FbjVJUjJVR3B2UjIv?=
 =?utf-8?B?NURyV0w0OXlWZDg5Z2pQQ0hXM1JiSjhuNVY2TjJDOUpDeXQ0dWdrZjEzOE45?=
 =?utf-8?B?eSswdkRleVhCMlozQVBKQ1VLYzVjRjlDRGpkbmVHd0N4U0k3cW90cG8wNUhU?=
 =?utf-8?B?b0M2VmMwZlRZekdDUEhJdEp4L0lreVFiMTJ3YWdJN3RJSld4Z2NKUFVqWjVl?=
 =?utf-8?B?c1JWOWlUODNBVnA3Z1M5QVlBQStXdDhuOTBka0NsYnNGY3dHZ3IrZzFNTmEr?=
 =?utf-8?B?dXFUeE5QS1QrUGxzWTc1cEpHbENNM3laa1FDS1ZSZHdRVUpuSGpnaDc3T0tl?=
 =?utf-8?B?aFhsNXdBVzQxeG1FUDRZVWJPSGRTc2pxQW0wRnZSakl0b2Y1R0dpYTFQekg1?=
 =?utf-8?B?SDRTYkVTU05RMjFnQXU1K3pFSDUvWVkwQlNyNXV1UU43V1NNT2dMNUtmMTQ3?=
 =?utf-8?B?M0lBaHFRRnVvNkNRM29COTJiaUVvQTYzYmpNK09oeTBleGpod1cwT3NpTVZ5?=
 =?utf-8?B?bkpLd2NUZjRRTnd6N2lueHBBR2xZQWN5bytPUFN3dDY0VWRQUUw3QkU3S1ZQ?=
 =?utf-8?B?Z0JWOTByV0x3RDA0aVZJdWRKd1RnMndSM2xsZFBKTmhUYVRia2VqWVZFKzJ5?=
 =?utf-8?B?YUhVZjVaWHpxaHBJTzZicVdwRVJ5VUVhdjFtbFlCNDNOWFVyZWpzZDNaOU1P?=
 =?utf-8?B?SW1PTVluOE5ULy9UL1pGL3hGMHI4dFNSdW5EWnhlNVpLS1ZKMHlwYjdtOFBL?=
 =?utf-8?B?a3Z6QkJ1eHJuTm1BbytoVW1sZkVtT3lIT0xyeXo5d1VRUEdJQUxmT01ieWY5?=
 =?utf-8?B?ejJQOTFtaUlZVjE2bHAyNXFIVm90NXlvTmlMQjJkSzlMVEZNdHVOSFdwS0Jx?=
 =?utf-8?B?OFM0ejhqcGZRWHl5dWNzdWVEeTBJU295SXYwOGtGTTRlSVBZY0R3UHJpVEdT?=
 =?utf-8?B?ZXFWeWdHWDJkZFlzVEVDMDR2TlFvdXNpTk1EamsyRWdqbU9MZVQwNHFwM0c4?=
 =?utf-8?B?SmtvNkVibGp1YnFEOXVReGxWK2FFMHlBSVFrTVVoOE9kUGZQK0V0R1NKSWFN?=
 =?utf-8?Q?rJ/UlKE5zXyqm5mJDYaZXqo9Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3c4c0e-8259-4475-6841-08dc3f48fdc7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:23:10.8717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69n6Tb2HFM/DaSlTXgobNeHbC1QsDRUM48WIr2fYShWoG16XSH57haI5d7A6pU0L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109

Am 07.03.24 um 20:04 schrieb Joshua Ashton:
> Otherwise we are determining this timeout based on
> a time before we go into some unrelated spinlock,
> which is bad.

Actually I don't think that this is a good idea.

The spinlock is the fence processing lock, so when fence processing is 
blocking this with activity it is perfectly valid and desirable that the 
timeout is decreased.

Regards,
Christian.

>
> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>
> Cc: Friedrich Vock <friedrich.vock@gmx.de>
> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: André Almeida <andrealmeid@igalia.com>
> Cc: stable@vger.kernel.org
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 5505d646f43a..57c94901ed0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -439,8 +439,6 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
>   	if (unlikely(ring->adev->debug_disable_soft_recovery))
>   		return false;
>   
> -	deadline = ktime_add_us(ktime_get(), 10000);
> -
>   	if (amdgpu_sriov_vf(ring->adev) || !ring->funcs->soft_recovery || !fence)
>   		return false;
>   
> @@ -450,6 +448,7 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
>   	spin_unlock_irqrestore(fence->lock, flags);
>   
>   	atomic_inc(&ring->adev->gpu_reset_counter);
> +	deadline = ktime_add_us(ktime_get(), 10000);
>   	while (!dma_fence_is_signaled(fence) &&
>   	       ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
>   		ring->funcs->soft_recovery(ring, vmid);


