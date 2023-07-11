Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E403274F9F3
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 23:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjGKVky (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 17:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjGKVkx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 17:40:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9E9E69
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 14:40:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpiCOBqCYuW64wT+5xDg0pBiocNFuwCyKh+ScYrge+e8DQsF7vBr261cg4xrVFZIOGoABPEvNBq4VDNH9afxCoXzJ8+lP9zIbdOBUeqMn+u2KaOIkGSXmbJkjzrGLoU90kjgRqUT78/+NgtHEj3mWvmX9XtBYIuE1igQJDOPs5+am8pO9KcDx5mBt92NXi92OU6R2U+7zhjCoABtTf8VcU5H5hhn02qSUNSk29RbssbEwLbAYkmSzf76IE5EVd2dgMKlEw8edrpbBNFe2Bs/OcSlG0FjURxHlxYpfUQ16ZwJtU29i8bBTb86IjKbtliIik/KF7Pt8guWI8dRrPfkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvN9uSDdIqKmdE5aAQTOPxdWZipfoBR8IWt0UdrUiAc=;
 b=JziSBtgyoJkXaaZIf0pLQc58R0AL3D07F8Mv29JhCusL5Ja5VcaTpPDeqrT8Ebg7Nn8fw4Iy6Gu8GFumJ5zU8utGTx0AJ0kVePnpgOoLxMKzlz8FYtjTHlgev6tShwp5k7qQPL/Y89SBYIYBP8MRUL709sZGP6CDIFIoRLgwcI5YKqvVDLaysj9hylr+6LWlToENhnJiZSm6sRcIgc5G4DNW7VxrulQThsoOZ1ztDFL7ve5jFidl7t1OkKxliLpcjCBeUbw9FaIbdhxE0RHr2AGYJ3b2E14jnDec4kGb7n7xKgLOtPjINMxmy8hC0sYxyK9QhPY27K0MTWeoZHn9vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvN9uSDdIqKmdE5aAQTOPxdWZipfoBR8IWt0UdrUiAc=;
 b=uxTxO3KSeO3HqppR6/LYwi/LpZUIFXjvE0baG/V2nsxhLtmuP79YOnqgqvncFIhvfTtefaF33zhNogmRLRJguObJu+FjpPgzismcN6k6WBOen/wXJBg9tQBDXOTKCfapdU45SbFMLkrZVm1jBBUzgQoaK4f2ylrPljNjABVLfrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ1PR12MB6098.namprd12.prod.outlook.com (2603:10b6:a03:45f::11)
 by MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Tue, 11 Jul
 2023 21:40:47 +0000
Received: from SJ1PR12MB6098.namprd12.prod.outlook.com
 ([fe80::497f:6e26:49a7:d016]) by SJ1PR12MB6098.namprd12.prod.outlook.com
 ([fe80::497f:6e26:49a7:d016%5]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 21:40:47 +0000
Message-ID: <c065e6f4-35d5-526f-30ab-61fdcc008415@amd.com>
Date:   Tue, 11 Jul 2023 16:40:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/9] drm/amdgpu: make sure BOs are locked in
 amdgpu_vm_get_memory
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20230707150734.746135-1-alexander.deucher@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230707150734.746135-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR11CA0015.namprd11.prod.outlook.com
 (2603:10b6:5:190::28) To SJ1PR12MB6098.namprd12.prod.outlook.com
 (2603:10b6:a03:45f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6098:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c88f86d-4d4b-41e7-726a-08db82577cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7bD84j5oCRq2IchZ5X9+4E4TOHn771fwwgOhfJIjqtHZ5GBxWJ1Zx2RsPJRZQgeIsQohg8/bDJ1U26zbV+EBi8ddVx2kAyvA+uxGi4gTz7rkJzuEnPrPcFNT+4PXRf3q75jM0nNNWjehW/CEeraIr/3jvjyRUFsWhZeyYXaC+7lsOQe9p6wA1AsjhIS6VwKviNNOsPrrfVCY8HX44+NDhILvlCDnLq3T+EUoMGDtJnZd0woa8SDe58noTKXnwOYOX8sjjyy36uIVpbg/ChzI8NP3mTGV/AlFPyXPlklHkYse1MietU/tLVLSDX64JlfXV8EBEVZB4y0mIkyGE3HaUfU/z67pmF7yf85Mguu828/rRpnfzOCDki/oe7m3bNluP0VLurbq76UPKYUQoEUV7XmdhuhWnJnkoHDYWVSHfhwGRxocjCGQrVpF5pW4Fvgvc8xv0e9MVGk80I1IqX7cUjBFlenxje3jqeeFDB83R6aBQOPkweHtuonZPB7z9TVT1QG/bW/9rm2YEAt7PEw0JlssePw4TBDMlvnZp0H3X2VlzUW9CaNJphbf0D30CN/zbh7GPFyQaOR7UrmtwMPwY+0RGDX6iVJAUphww0IK4/5pZhpy6K1kRn0X12SgGC0lCSP5Mub3ZV9fqjhGtusAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6098.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(31686004)(6512007)(6666004)(54906003)(478600001)(6486002)(83380400001)(2616005)(31696002)(86362001)(36756003)(2906002)(6506007)(66574015)(186003)(8936002)(66946007)(5660300002)(53546011)(44832011)(6916009)(66556008)(8676002)(4326008)(66476007)(316002)(38100700002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk54SmI3VHkwNmY3NW9meStmbDg3amxWOVFOeklwTmpqT1VqUXBPMm0zaG03?=
 =?utf-8?B?NFVNcDAwTHUvNWZFS2o2c1pFVXJ4dWk4eWJhZ1FpYWh5MkNpeFYyajRJa0hX?=
 =?utf-8?B?Zmw2NTRuMERicGIwYXpCZGIyT21ORCtNZW0weWRUMG9XZFhXOG9jek9hUkhY?=
 =?utf-8?B?VU5sTzFyenVGS2ZaUi9tWmpxdXJGVGk3WDNDN2tsajlCd1FjM0pheHZrTXZv?=
 =?utf-8?B?c2hzT3VnV2F6L0M2citLWkxHNi9kR0c1TnZJdTFneUVWTE5DU3RkWk9ScWRO?=
 =?utf-8?B?NlRrS0ppT05OUkNIbE8vNWczVEZjODZzWGRhNE5IOWpVM0FLVU9zcDhhbEd6?=
 =?utf-8?B?Y0JZYXFTcGtSeVd0UHZ3bG9Xditza0VSQVFhOUhZQVJVa0pBYzBHMXpFYmQx?=
 =?utf-8?B?bFVoTnh2MjZzQy9sRlNJRmErRG9YeUZMeUhTdU03OWFZWW5Dc2NQQ0Vnc3du?=
 =?utf-8?B?djNsOXlVYlNKSWQrc3JGYmQyWi8vbDdXd1FQRHZQZ0oyL0krTVpET3lGMENn?=
 =?utf-8?B?NS9zZW4zbExIbmlDYmt2NytlM0ZUOUdsaE9STDVRZE0zUXpFeFJQenRvZ0cx?=
 =?utf-8?B?SG5sVUNBeDNDT2k5ZlZ3VjJwbldLTmhlejJ3ZzFzSjBHTHBmVXlQYWpJamhj?=
 =?utf-8?B?OVlZSVZTd2poNGwyS1lvV1FoQkIycTgybmEyME1Fc3hDNVpTYTJISndieGNW?=
 =?utf-8?B?T0FqeGY2R2VVckVQd2V5QTlOSUtoanQ5RUdtMW53VDk0K0VJT3FXUHNYSnJp?=
 =?utf-8?B?bWFKdGlEWWhkcWVnMFZRemZUYmFCQ2pSK0VXS3ZLNXZEeHd1SEZTeUJiZXJx?=
 =?utf-8?B?d251akVSUmtrOXpWOHlyV2FmK29mK0JZT05hMW1UNjhZQ3RYVFhYNzVZTmpD?=
 =?utf-8?B?N0FkMjNKY3JkVkVsdW9pd1AwbHlIMy9XcHhWd05zWWIwUVBOazVpeDVaRmN0?=
 =?utf-8?B?ZFBqQ2ErRlpjemEwZE9ab0JiaGhXeEV0RnZEZVE1QW9tM0tnMXVBS2FSemlt?=
 =?utf-8?B?QUVhdGxmUkFrekVhVGdpR2pZQUMvZjRVeTJSclN4dE10L0lCUmxsUmxJbFB2?=
 =?utf-8?B?dDBLa1RVQ1NSL0UzYXljOElPditPLy9jME9LdkM1Q1NFSFRSZFZJb05IWGQ4?=
 =?utf-8?B?Mm44NGxwMFlMVEFSK0dOOGVZdDlWekh4N2xsVXZqMG4wTWFYRytKd01pM1hk?=
 =?utf-8?B?SGJjWjdtZkVCOFpvTURsckJody8yNkw3b0o1WE85N3dyMHV1SEt2ZEhmL2Vp?=
 =?utf-8?B?TkFLUmxaT3lqSzYvVE5LMUQ0K1dBZWR6UWdhRWZKWWVVSmduTVR1aTB6cmY3?=
 =?utf-8?B?OWNXWXFIREJoRWdWRXI2eGtBdWUxNzRIbXlEdzl0OGdKK084SkY1YUJmeDlD?=
 =?utf-8?B?U1JaaENyTjEvZmM4RWVjWmhwMVhnREl4TDlHWlJtQ00wNkkwTjBsbEtaRnpM?=
 =?utf-8?B?empad21STGJ6dTV3NjlvS0g1dlFpUnB1T1JHWlY4cTNHeVdWdXZBYTJMK1NT?=
 =?utf-8?B?cG9CNzk2ZldyMjBEeVFWMGpnbHJLWllXN1FaY29nYUJ0bDAvaFcvSUU4NHJH?=
 =?utf-8?B?RHhWMjZ0YlhZcCtKZ2ZQUFJPU2ZKNUV6ckw2K09vOExDWVIyYlVtK2V0dUJP?=
 =?utf-8?B?NVQ4bWJvS3hCbmUrQnY5b0Zqd0RTemJacmRxSTlHNDNKNkRYZmZPa2szdDJj?=
 =?utf-8?B?ckpOMEQxblJuMGQrMkw1MkFkd1AyVjdVRldTYit0RHdJK21DSXdEUmdZTjRt?=
 =?utf-8?B?eCtaK040U1hYQmlEZ2UybWZEK0swRFNYc202UGsrdzdhdW4yOExWUjZjMVlT?=
 =?utf-8?B?RXpXZW9RcjNFamVUanZpZVJWSDJnWU83dVA5ZFFVWElXT1F6ZU4xc3NnbG9Z?=
 =?utf-8?B?Z3BuYkVtc2hvOWFCbXZLRGw3Q0Q1VndMVkxQZW81Y2dObElzMGVXRGxCZlVq?=
 =?utf-8?B?OHl6T2lFRndKS0lNTzRFbEl2MXdZREhCb0htSkEvb0hETGJSTVNKb0xLcVk4?=
 =?utf-8?B?SHVIYlpuQURFVkJhYm5kQ0FucTdlYVN4V0R0TWtSdWM3dGowU1hDOHNFMFJP?=
 =?utf-8?B?UHlXQ2dZVlM4dHhmaFRGWW5wMUFQdG80ZUxBOVErWWdFYmpDMjFiVC9uV09i?=
 =?utf-8?B?RGNiNWRKMTkrbDZFM0FoM3F1ZjZMUFRYam4rNzhyekdXY2s4cDZKOThPbjFV?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c88f86d-4d4b-41e7-726a-08db82577cee
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6098.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 21:40:47.4136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PrmtNYY1pmxcTpVqrJN+46d0of5rpzpob1eaKA72W5sy5ymBDTzj9oSfiNj24AYrUOjgkriz2hXRd9bJlq710g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 7/7/23 10:07, Alex Deucher wrote:
> From: Christian König <christian.koenig@amd.com>
> 
> We need to grab the lock of the BO or otherwise can run into a crash
> when we try to inspect the current location.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Acked-by: Guchun Chen <guchun.chen@amd.com>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit e2ad8e2df432498b1cee2af04df605723f4d75e6)
> Cc: stable@vger.kernel.org # 6.3.x
> ---

Greg,

Just want to make sure you saw these 9 commits as you're processing 
queues since they don't stand out as being sent directly to stable.

>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 69 +++++++++++++++-----------
>   1 file changed, 39 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 5b3a70becbdf..a252a206f37b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -920,42 +920,51 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	return r;
>   }
>   
> +static void amdgpu_vm_bo_get_memory(struct amdgpu_bo_va *bo_va,
> +				    struct amdgpu_mem_stats *stats)
> +{
> +	struct amdgpu_vm *vm = bo_va->base.vm;
> +	struct amdgpu_bo *bo = bo_va->base.bo;
> +
> +	if (!bo)
> +		return;
> +
> +	/*
> +	 * For now ignore BOs which are currently locked and potentially
> +	 * changing their location.
> +	 */
> +	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv &&
> +	    !dma_resv_trylock(bo->tbo.base.resv))
> +		return;
> +
> +	amdgpu_bo_get_memory(bo, stats);
> +	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
> +	    dma_resv_unlock(bo->tbo.base.resv);
> +}
> +
>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>   			  struct amdgpu_mem_stats *stats)
>   {
>   	struct amdgpu_bo_va *bo_va, *tmp;
>   
>   	spin_lock(&vm->status_lock);
> -	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		amdgpu_bo_get_memory(bo_va->base.bo, stats);
> -	}
> -	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		amdgpu_bo_get_memory(bo_va->base.bo, stats);
> -	}
> -	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		amdgpu_bo_get_memory(bo_va->base.bo, stats);
> -	}
> -	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		amdgpu_bo_get_memory(bo_va->base.bo, stats);
> -	}
> -	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		amdgpu_bo_get_memory(bo_va->base.bo, stats);
> -	}
> -	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		amdgpu_bo_get_memory(bo_va->base.bo, stats);
> -	}
> +	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status)
> +		amdgpu_vm_bo_get_memory(bo_va, stats);
> +
> +	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status)
> +		amdgpu_vm_bo_get_memory(bo_va, stats);
> +
> +	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status)
> +		amdgpu_vm_bo_get_memory(bo_va, stats);
> +
> +	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status)
> +		amdgpu_vm_bo_get_memory(bo_va, stats);
> +
> +	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status)
> +		amdgpu_vm_bo_get_memory(bo_va, stats);
> +
> +	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status)
> +		amdgpu_vm_bo_get_memory(bo_va, stats);
>   	spin_unlock(&vm->status_lock);
>   }
>   

