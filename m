Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DA47A06B6
	for <lists+stable@lfdr.de>; Thu, 14 Sep 2023 15:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjINN7o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 14 Sep 2023 09:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbjINN7n (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 14 Sep 2023 09:59:43 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ACACEB
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 06:59:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vod1CTrWLlvV/qCr2ObfX4wuvsXSrGzPhxYsyXvJTuXY3qO90ZTdcSxAdkNxVrEBwoPdAaEB3RNHb/4SPao9b+IyB01k8hstIDiSpLwA80ynRmmkaAQ9hujqqIPdq0sJGfS+DECm9oEzXDdWLHS/jwhh62L1MR1aTWon2JzPYlLuTXfjg5TPX3h/Jlyd8CnSAjAuoZIvR28pkQv5bi6taKFLOLrfu3QpmJga5J/x2wZPGiypi4KsbYLsI3PmF4Is4SZok3PfPEX2RIeRaC5lUoteJVWeEmqUKOfKNYj7QTWZ812OGtrycjeu52vxyyQC5OabCtklSnZbS4iJ8NH4Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGaKcWHEmhr8C+EctrKOUdPfsVnmpQro1di1nphtGqo=;
 b=kwU1rh4f20e1E9PzUMuRx2lLdGLGXJ7qUcvAHYDZLbIyeO+dJvrXHEfocnASwwXAJCO8p92WlkATIyBm+6xl589VB3QUd5Qwjf8oPKJ1bL2RIwtt+qWKq9CsFNnoQYPHYezVLuvVLreBK0RJPJpbmyL3dp5zucfZCufYqFt3ctYAXIN03nsl5JgGyICKVr2NX/F5hg4p92Zq0KDtD9YM4q/o4Df1hGMOlHcukYLeARbSgXuX7/1cWeJDbiyPtFS4Z3c3ru8BdYX/r0k82j1tkVWTXTsNx0ozrLwAC5s6lMvPHeZycsdL/DBGDm+NT5awndpiY3QrwjpxJ5P0NmNiCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGaKcWHEmhr8C+EctrKOUdPfsVnmpQro1di1nphtGqo=;
 b=y660cojWt1q8HPn2aVP/4tJjZNTVmKbnoLV1aBCKmqMyTbRLipAUxTR/FZe1/Wzp4MNZACLPTXQ3/PjvOuiZBrUaU+Ii28Jblu0gW39TIFUna58cMEb/2dr7DKEhWSds/Z/ZWT44CXSyfCkNKqQlYrnjT9y2acfxxTOUm/BCn88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.36; Thu, 14 Sep
 2023 13:59:37 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010%6]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 13:59:36 +0000
Message-ID: <1317e1a5-b1c0-2c3d-6082-b628fde5ab4d@amd.com>
Date:   Thu, 14 Sep 2023 09:59:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] drm/amdgpu: always use legacy tlb flush on
 cyan_skilfish
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>, stable@vger.kernel.org
References: <20230914092350.3512016-1-Lang.Yu@amd.com>
 <40c096af-6c59-ce6d-af26-5cce7bceab83@amd.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <40c096af-6c59-ce6d-af26-5cce7bceab83@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::31) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW6PR12MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7b8807-8cbb-4a9d-5387-08dbb52ad4bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: heam7hdfbtJgaxeemiaoaDOttwuVj7e5D2HKs56XqyiDtdau4wYjYIHjLLizW/whFfwHS2Q1q/oikR0whbZNIlP2X+c14xgpajiZsIQU1Z3JxvfliNabG0EF/h8GKZ7sdGKqgBmvL8NGvSPoY006hhXl3dD/SHCNbAArvS0Vi4xTyQdxcuE+GZ05ZM7xQ/jdTGOKPki4yNDNPjVcJyHEj9Kur1Yw3GZuMUfZ7y9WgJLSQfk8xRNtcjq/4rPVKC2yi5Aa1y8qX/Hj+0/GJ8AdiU9Ctq/wH8J6WiAMry8c5tu+m4mJju3vjmr8w9X5XGOeD/tnOM9O+yK3cwWbVRgUBeylvN9LSL0RENoaEJxDvMi27BS1aicJ4qQ9EwW2nYIYOoVjiWDciVlS0wKi6AH4+JCJT/m6w96dlCoMvB1miQctC6mZjVt4UD6HPBA//5MGCSlAsz4KgjNV+rf3xnzBhG4rkFb8fIIzrdUHLdIlxFuvEQ/spc/B7dixFmY1B1JhCqCKg3zHDLceJHPpCEyZZibH0LMzndcAxt1o//Fc7O2oUEqFJiAlvU7zMJbVEu26SyiZgyJs2CDhXN1geUrk5tHSRO8U4rdPxN8n2SYQOrfv6hlCJRPjA9V4O7Ttf0OLYl/uwwScge5OOi87NdB22Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(376002)(396003)(186009)(1800799009)(451199024)(83380400001)(31696002)(66899024)(2616005)(38100700002)(6512007)(5660300002)(44832011)(54906003)(110136005)(53546011)(66556008)(66946007)(6506007)(8936002)(6486002)(316002)(41300700001)(4326008)(6666004)(36756003)(478600001)(86362001)(26005)(2906002)(66476007)(31686004)(8676002)(66574015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1I1WlVSTHBEMHlFT3hySVdrVkZpdVVBWTh4YjkyRVJUdDQvUFR1aEVDWEJr?=
 =?utf-8?B?TnBhMWFUckVLZXZpNlpKNzlBSm82UjlWOHhUYnVrVmppa0k5STB3L2t5ZDl0?=
 =?utf-8?B?QWJDRm1mN3RPaDJGMlZzVzMyV0dud1ZkdjZzdlo2VkNhSjRmdTlZQysrZmVV?=
 =?utf-8?B?cnErV3U3ZUZXVXNDaXp3RHpHRTdmRHZUVHNOaFNua2ZORSszQ1p4WkpuS3F0?=
 =?utf-8?B?S1RyaDEwMlUvWkFMUWFhVFZHWWdZZzlkUGVYN1RPcndCTEljQ2RPLy9CcGl6?=
 =?utf-8?B?S2F5V2JTanNvVkFuazdYclBzRms4cHJRMkw4WVlzbVpSOWpNZHdaeTE3YzlQ?=
 =?utf-8?B?WXBUUS9xRlpoMFg5T2c3LzRjUERZM3haWXY3Mno2Q3FMZkdYTlpCQjZTenQ4?=
 =?utf-8?B?N2Nod0pSeGVhWFlJTFplaGNVVG5IWlU4M2o2Y0U5TVFkMlNOQm90YTdaM2RO?=
 =?utf-8?B?ajRJa0RyVjVRMGppUGQvalB1ekpOdWFlWmFVNW5RdjV3S3V3RmNnMzJFVVlj?=
 =?utf-8?B?a01PTmRtM1ZWaTRGQmxzS2UxU21zcDBVUFF0UGo4MDR5bFQzaEw3aUJSNEEv?=
 =?utf-8?B?UjMyelMwRFVabUtrWVRubi9kUlppNnhiVFpsRnRSeUVQd0FRdGpWZ1NlQ2NU?=
 =?utf-8?B?MExjZUl5U0t6b0FuOUlkMWN6R2NuZm9RTEN6SDFsczloSVBSQkxJRGJybTFQ?=
 =?utf-8?B?T3BmR2dZaTgxRktWd3FRZWdDeCtybFVKdk9CaE90dy9uWWV5ME1XK0JzK2ZV?=
 =?utf-8?B?dlhsd01TdU43eXNBdU12cElobXJTWXhkK1ZPazlhNGYrbXBHUGduYVg3VzNT?=
 =?utf-8?B?UnJ6TEUxUVVpWGRydTQxTFN3YklmSUU3d1ZSQTZxYjU1eXNmaXpocjB3NUV0?=
 =?utf-8?B?WGpEcml6K0pTWXlVdmdlMWYwTktIOStMMzcwSzBmZVhXcUdxSE9lTzJLZ1B5?=
 =?utf-8?B?RVp2bE9SWkpQd0pKbWxMbGY2VUkvb0s2cWpCcnV0T3dFSGpvdjJRbkVUSGx0?=
 =?utf-8?B?U3B6aTl6a2VKYklVQ0JmMHNWTkZOck5wSjJDQWQ5b2k4VVFVQ0ZOblFxc0Q1?=
 =?utf-8?B?ZkdxNDdtK3V5NHFhMDJsR3h3NzdCL3g1K3NuZ3ovQVl1OG5mbXh6M3RKdndG?=
 =?utf-8?B?aFRhUC9BbDk3ZXBnS3lRN2t3V3VXRkZWcFlBbTAwaUR4ZzZQMlZpVmlKamc1?=
 =?utf-8?B?M0ZIRXg2aTY0ZlJQbTdKMmxUUUdNVThSNmFhS2dkOFlLdTRHUVNzMURKTTUx?=
 =?utf-8?B?aG0vR2hZYkZZZFArNUZUYUlEdVJncGM4b1gxN1pZa1phaDFIcklpbVRNUkI1?=
 =?utf-8?B?L3IzcHl3WEpNc0J1SjM4L1NSWW9qVHJVTmdVeHd3bVhDL3BsTWFZd3lzRDlz?=
 =?utf-8?B?cG5YRHZNZEgrVGNoV2RtSG9XZnd6dTl5T05vTkNBUEZZMVV6UTgrS1lyWVhM?=
 =?utf-8?B?dk1vNTJTelJqR0dKQ1dOaFg3WmdIdWkzL1luM3lFQS9CY2lzRHN1N2tOam0r?=
 =?utf-8?B?b08vbG4zUkZ1Ry9HcnE4TnExNnpvVFgveStwenYxZkcwbFMrMkhvNTVSUUkv?=
 =?utf-8?B?OWtlMjR5WlFvZlFLTEFqV3ZWMzlmZ2R2TEFxa0ZkdkdSazJnMExhMU9WUFRP?=
 =?utf-8?B?Y3dXUzZqY0Jvbko5SGVEZEhseEdJWHlabEwzWXhHekVrd0crQkt6Vk50MS81?=
 =?utf-8?B?SWZGUFVHUDVPTXY1bm5QQ3dCWjRHTi9HTEpJdjZaVWl1cUJtUG1BamMzdXNB?=
 =?utf-8?B?c0ZxdDhwMVQ3TDY1ckwzbVF2QUIvTnE1UnFpUEtLU0ZWS2RReFpaSXN2UU9S?=
 =?utf-8?B?SWhqbVhUWXo0dHVubDgvSUZEdXVvMzJsWWg4VVNENklkWlNzSmdWUktRQ3pF?=
 =?utf-8?B?UnRmK3lTUFdhK0tyMUswSUJZWUZYN1puZFZhUm5HY1RZVHJoY2tINVMwMm9N?=
 =?utf-8?B?UmZ1emg2RVY1ck8xWmlRUGRTdFd1UDJleTdXdFhOZElGb1pOVFdyS3BVNVNv?=
 =?utf-8?B?dVlYUVBEcGVHNTMyZU1QcW4vZlJQMkppaTV1c3Q1alZXbEg1MUtuU3pRN0dC?=
 =?utf-8?B?WWw5NVBwLzNJK3BHQ05Ta3V0Z1JtUlAwdTZ3MW85ZGhjbGwvSC8yWWpYVmRG?=
 =?utf-8?Q?wzl8gOwRYLaqlWEPqUf+e9I49?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7b8807-8cbb-4a9d-5387-08dbb52ad4bd
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 13:59:36.7144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCVXErPwdMAFq4GmR8X0ffVhk0b4si4NzpkfgZMXbcXJ4SMsadZvKfslbBIpFHIRv5yeENnXKGwlGm1s6E0MNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8663
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On 2023-09-14 9:39, Christian König wrote:
> Is a single legacy flush sufficient to emulate an heavyweight flush as 
> well?
>
> On previous generations we needed to issue at least two legacy flushes 
> for this.
I assume you are referring to the Vega20 XGMI workaround. That is a very 
different issue. Because PTEs would be cached in L2, we had to always 
use a heavy-weight flush that would also flush the L2 cache as well, and 
follow that with another legacy flush to deal with race conditions where 
stale PTEs could be re-fetched from L2 before the L2 flush was complete.

A heavy-weight flush guarantees that there are no more possible memory 
accesses using the old PTEs. With physically addressed caches on GFXv9 
that includes a cache flush because the address translation happened 
before putting data into the cache. I think the address translation and 
cache architecture works differently on GFXv10. So maybe the cache-flush 
is not required here.

But even then a legacy flush probably allows for in-flight memory 
accesses with old physical addresses to complete after the TLB flush. So 
there is a small risk of memory corruption that was assumed to not be 
accessed by the GPU any more. Or when using IOMMU device isolation it 
would result in IOMMU faults if the DMA mappings are invalidated 
slightly too early.

Regards,
   Felix


>
> And please don't push before getting an rb from Felix as well.
>
> Regards,
> Christian.
>
>
> Am 14.09.23 um 11:23 schrieb Lang Yu:
>> cyan_skilfish has problems with other flush types.
>>
>> v2: fix incorrect ternary conditional operator usage.(Yifan)
>>
>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>> Cc: <stable@vger.kernel.org> # v5.15+
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index d3da13f4c80e..c6d11047169a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -236,7 +236,8 @@ static void gmc_v10_0_flush_vm_hub(struct 
>> amdgpu_device *adev, uint32_t vmid,
>>   {
>>       bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(adev, 
>> vmhub);
>>       struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>> -    u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, 
>> flush_type);
>> +    u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid,
>> +              (adev->asic_type != CHIP_CYAN_SKILLFISH) ? flush_type 
>> : 0);
>>       u32 tmp;
>>       /* Use register 17 for GART */
>>       const unsigned int eng = 17;
>> @@ -331,6 +332,8 @@ static void gmc_v10_0_flush_gpu_tlb(struct 
>> amdgpu_device *adev, uint32_t vmid,
>>         int r;
>>   +    flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH) ? 
>> flush_type : 0;
>> +
>>       /* flush hdp cache */
>>       adev->hdp.funcs->flush_hdp(adev, NULL);
>>   @@ -426,6 +429,8 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct 
>> amdgpu_device *adev,
>>       struct amdgpu_ring *ring = &adev->gfx.kiq[0].ring;
>>       struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>>   +    flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH) ? 
>> flush_type : 0;
>> +
>>       if (amdgpu_emu_mode == 0 && ring->sched.ready) {
>>           spin_lock(&adev->gfx.kiq[0].ring_lock);
>>           /* 2 dwords flush + 8 dwords fence */
>
