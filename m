Return-Path: <stable+bounces-27134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABF4875F7D
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 09:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA3A1C217CC
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 08:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA01B524AD;
	Fri,  8 Mar 2024 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hbyfMh60"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1563D0C6
	for <stable@vger.kernel.org>; Fri,  8 Mar 2024 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709886607; cv=fail; b=Zpp2kkAW7HMIY8za9wIrEZuNsCtI0xho6VV9jiIqws8yb0Tt89PA5SzDDmcXNtDYo7shJN5KRUq8IDELoiMsX338Lj5GLByrQ2dipFRYRcYF07QbSay2hHsWGkw9J8o2fVooBHHNxQJklxOMUzO7aA4ZYIpdWRZNXt7xK4+2+qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709886607; c=relaxed/simple;
	bh=f2Cc0N43Hk3DneqaNUkmixgmgodMAtxvutKwWTTiLkE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eRnwkAIYz099P1y1arupF4j9c36HalhFDNQA/kws2qCU6AKHB092p3Cd1NH6aEG1GOhPw/LiRihlU7mCIt1rb5LUvhYS/0Ub8fd99cjon/ov2psvL7vfkpdXaiNeHbH2HnrtmxjlYhEZ/aVXQwQvwyEdDCDjQX2AqzaG1xLtx9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hbyfMh60; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hft1SrLHGZfMlKfJ80Zhprs8u1rbDsX16HiJ2OzBYYWcYMOtCYFt/JC1FhHJ21IUxBhJBQoG3UQfTQ6KVdHnffvUl1PrJSvsXfY77KBklICRGtos68W2G9dzK1mUm+hZFKJ2Vl/gxEtDV31kUr7eJiMazo+Ier89Ih/7YyOq7ilUvsUwHxFzjeaJbbtUiSBf8/i4TI5diNGSs2Uox8BK/51tr7+LlMXGQDre1Y6EkIPiqgvpou5Qa/+3Nij1Nbmu41Bvm4D8vEoUptYWAnwI5RJt78ujTUdZuCwbP4KlZbFKOoJm6D4yPHCysaGm7XSbo7caPhpiI89qOZmCsFbr/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eo/02buFJgVA56D6k7DzMjPxu1XKVTCVkeXxljQV8CE=;
 b=Rz+e+iWNBmXHd57FXQtV0PIqxUzdVrt/ldanpLb2oyc9NN+eFFTtibCpeuMTs4OK4zlF5CEos46y/ypAwBifwEpRgQjj7zWdXXcYE+8sHH3VUt6q5e6nJJVrfvaVA7jIuSn7RwlrdhkD7gcEI7idulGbuxqcELX8PL5koxlMzqgZmJFi77ZdC0mgSwH78ej7LCNNrFpyz3l1M9Vci+2qYz14u+u63mgpYqcKGthvgj48shHCtSjXQWngSY8YO65ykds8yLu5vlRMF/mGnMJrUxlFLv/uS5HWF1g84ifjj+fbgd8tepYhPpW4EmbDcoqtU+OeJT/y++dgE0cFILoECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eo/02buFJgVA56D6k7DzMjPxu1XKVTCVkeXxljQV8CE=;
 b=hbyfMh605sLcCTCno/c018M09hwIYyH/mAMdF/ZMet7PNPzosiY+7Jquf9pApnJOvCPwxum3e11//r4FT2j3wsRs8sulii1o5V6ditWj+oOXjuHTtwGsvkUxC72A+1SsA3eEkJvbg+k90qFDy0AbY6LzNfsJlp38F0O8RwKSocg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Fri, 8 Mar
 2024 08:30:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 08:30:03 +0000
Message-ID: <5f70caef-7c7e-4bad-9de9-f8f61bba2584@amd.com>
Date: Fri, 8 Mar 2024 09:29:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Increase soft recovery timeout to .5s
Content-Language: en-US
To: Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 stable@vger.kernel.org
References: <20240307190447.33423-1-joshua@froggi.es>
 <20240307190447.33423-3-joshua@froggi.es>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240307190447.33423-3-joshua@froggi.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0398.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c3dae7-65c6-40c0-ead9-08dc3f49f37f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3QKFoJhnBcB6cArQHwcaKDuwF+QwsmG1CJCOCvLKaMq0cb3o96ZYnQ4Ih+xdzBiDbP0ldIKfBkKlJMgx+lyahz56aIMjkPrD/nCjGiimxIxY+AFwb7XB6Hp91RPAFUn94ADmVFXIu45BZRGWwYkaDJczLdniImN7LNUZcqggtUNhcz4Yvlu1skVJ0aGTOXx+SjUVnjCdXy79G3NHIzrnQdID8BJ2Y64iZkDUQ7JcEN608aQtFvAuhkRIre4KizI3PITx9PEqZgyx4nmoJZUqxjStDyVU0M/5xnZ5quI2/FAV8aHz96oxb/lP61IqXApbB7dYBR7o2xKB9lqAmW1vkDCF1zz/EFH3RAZbX+fYZ1VgLmpVitJOEjVscS6fLU/vb1tJdHSurMl37ceOw9cDBzbbCWrbK4M2gUrZjJMGswxmhxOaGsIJgR3de1jHBbxOBUwwRWy5hVIZlNpLuIh5OmZOdfNkQMnna2j1N0ZbrR18dF7+FsJxLIeu1kwapgLX4ErSxb95m6bNV6Ofq9RuGVaHAmX6LOtH/ffxtXaN1N8dtSrk0Yc42jieeFMqK8QbMOAgRqwKcv2HaXZ1Cu/BrkP7s2OcRJfGNUl4RvjVOsogfZExFOo79HbSpUHatiM8uX65un3lk/8SNEbpeJKUmADfh1y3LJ4fDJyQdLzavzs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWJWWXZzamYzcXVkZCtjZkRjbU5mK0U0NnkxZXh5M2RWNk1uT29kOTBNR0Jr?=
 =?utf-8?B?azFuUW9kZ0ovcm1rdVh0MGptU2pUTFoxWHV6VjJoRXY4ZTVZWGx2S2pLc2p4?=
 =?utf-8?B?NnlabjFmK3VBOFNrazhHdzh4NXhhWGN1d25abktnUTlJeUdsd2JFR0hvQWh2?=
 =?utf-8?B?UU9GUnB0SDRDRHM1S2hIRlVRQXdxRlp6SGxaZUh1aTBuaENvQmR1dGRhbXM2?=
 =?utf-8?B?VDJtdkxHMlpma2s0bXQ1eHp5Unh5SjNWV3dRTUxoMjY5MmJ4eEdHYVdyYW1i?=
 =?utf-8?B?WUJDNk9jLzRGWGxWRWMxT1NGZFJUOG40dmt1V0k2YXJ6Z3pKMUxsNDZqeXpm?=
 =?utf-8?B?cDc0b0YxVkQyOFZsZG1FUG1ITlNVWk42aWloaGwxOXh3R0ltaEl3eUlZWWN0?=
 =?utf-8?B?VnZaYnM2N1BrMVdUWkRxNzhic2UrVXl4YU5yU0Z2djVGZG54d3E4SGh1MUly?=
 =?utf-8?B?Q2JhYU9leGdtMm5NS3ZKUmpCdlpxY3lmOU1FS0dzRVdTbDVPMkoydXVYR0hh?=
 =?utf-8?B?UGw1c0l6dUlZNERYeEkwNVVFMnNvSW80ZnpZZTJiS0hzZGZHb2w0cGJjRTJt?=
 =?utf-8?B?WDFobHlWYkZiNWNIb3orMzJ3WXFhRWNsa1dKaEV6UU1VNEprSXdQRFRoZ0NP?=
 =?utf-8?B?RVBYVVVkTFQ5N0o5Yy9sLzh3bkJ4S2VFOHZpMzJpSk9VYXl0YUxjMDYxQUUy?=
 =?utf-8?B?cVpKZ2FRVHlveGNIWXVQc1M3T21uVllVZzg3czdWcGpwalpQYjlSUWczQ2Jx?=
 =?utf-8?B?OXVDOS9GNjVkQ0dKYkJ4NDdpTXorNmlJSVdNU0NnN1V2ZXArZytKcHN5UkZt?=
 =?utf-8?B?R09qTkMwMFdPMXlRRkJuNlNScVBtMlc5bUNSTUR2clVFU0JyckJsVVNmTS81?=
 =?utf-8?B?WHBFMVlVQU1iRStnTHk1RUE5ZG1UcmhCSUx5THhQRFNpeHJUdHNrTnI2alh2?=
 =?utf-8?B?dExTNmxHT3cxNVV3UEg1Yldva1BhVmRGUnQ4N3FtNkpDeWZJYm8zMk4wK3ht?=
 =?utf-8?B?NmFhVE1QY2xESzJhdk1jZVZQZ0RTQVdHV1dTV2pkdmwyMDJVc3ZZZkljU1Bu?=
 =?utf-8?B?RHFFYytrekhzYVBvQUtRMHlTRUFqL3RGeGdIQnUrTmc0Y01Eb2JvWVU5d3lz?=
 =?utf-8?B?VkNiWHhXdnRIbFFSOUw4MzdmVTErSVI4OGNFNy90aWNIRW1CRXJTN1lNZ0dj?=
 =?utf-8?B?SlAwb1lRbWx3QzJtbHBkRXVMUmpzOWJEdjBWdFVZV0pXTkRtUy9RSlUxeldD?=
 =?utf-8?B?eGhsTWZyR1NncUo5OXhKVmNzaVBWTnFMUzBjbzE2cmRQd0lINUtBR1hVdDFR?=
 =?utf-8?B?OFJXTld2QWZNajc1dmN3cUlQSjNhN3F6RjZTTTVKMnNKcXZzRzJzbGE1WE1F?=
 =?utf-8?B?L0RSU2VwekppMjdYR3NKdk92TkwwLzc2OGVXT2tSNzhIWHFRNTFQUjBkMTgx?=
 =?utf-8?B?MmZmaTcveThPak80UnJseW54TlFaMjVnbVphS3d1cGkzZElPTlJuNmVscDk2?=
 =?utf-8?B?UVcrVTlDRElvMVlCMjVIZDl4Q2dvd1p0d2t4Y0daTGFWaTFqd1ZxQktUbnU2?=
 =?utf-8?B?SmpxLzJ1RkV6V011YkExTEZmOGFzN1VNL3VJVGE5eHp0RUFScEQ4SnBQNHc0?=
 =?utf-8?B?WWZzKzB1WFpRZUFtMXBLaFVjSVFPT2s4S2VYekhJK0ozYis5Y3BaUTA0eW1i?=
 =?utf-8?B?Uk1uQ1I3Slo5VmtHdTVWbDNKcTFQNWJUSXFZUnZZeDgveWpyRldNQXEvNmFM?=
 =?utf-8?B?MEhITG1KUTgyem51UEhqV1NJa09mb0psVUxRVjZOVDNaWk5EZ1NLWFpxN1JS?=
 =?utf-8?B?S0d6bEVLVmZDenVLWjVWbnJXSlM4WGV1bzF0SUNMT0UwWEJWdEtCZFRSMURU?=
 =?utf-8?B?aWdjemxTTE15UzYyMWdPN2dkK3N5ZjhxZ001eFJkWENTRm8rQTVLUWJWRkYy?=
 =?utf-8?B?T3AzZXkxVHRzTlhIMDlpRmFMUTd0NzJCYmZQZFZmQXB3K3RScjJZUFovVmJs?=
 =?utf-8?B?VHpJYXdVRXpPaThYU0N5NmlJaHFIZk5wbkQ3RXVHOHVjLzQzU2hMbnJWTEZw?=
 =?utf-8?B?aFhpb1k5cHpISDJqcGhVVWlaa3dRbFNvSi9VQVpLVlRmeEhvejJzMm5NenAy?=
 =?utf-8?Q?zjBLe8oWNOLcmp9YCtJytMPnZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c3dae7-65c6-40c0-ead9-08dc3f49f37f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:30:03.2541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: labqqgCYmpAEYvXSuGa3arBig54ndkLMAvxEPfuGSt7i41CHIeuTxQcuZpnqOFFk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945

Am 07.03.24 um 20:04 schrieb Joshua Ashton:
> Results in much more reliable soft recovery on
> Steam Deck.

Waiting 500ms for a locked up shader is way to long I think. We could 
increase the 10ms to something like 20ms, but I really wouldn't go much 
over that.

This here just kills shaders which are in an endless loop, when that 
takes longer than 10-20ms we really have a hardware problem which needs 
a full reset to resolve.

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
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 57c94901ed0a..be99db0e077e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -448,7 +448,7 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
>   	spin_unlock_irqrestore(fence->lock, flags);
>   
>   	atomic_inc(&ring->adev->gpu_reset_counter);
> -	deadline = ktime_add_us(ktime_get(), 10000);
> +	deadline = ktime_add_ms(ktime_get(), 500);
>   	while (!dma_fence_is_signaled(fence) &&
>   	       ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
>   		ring->funcs->soft_recovery(ring, vmid);


