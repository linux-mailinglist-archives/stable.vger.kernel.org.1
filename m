Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B747A06D0
	for <lists+stable@lfdr.de>; Thu, 14 Sep 2023 16:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbjINODK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 14 Sep 2023 10:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjINODI (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 14 Sep 2023 10:03:08 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFDDDF
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 07:03:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LasN9i46/toV1RVVnprc1wtJ4xVxPqidGpsSmJWod9tEfjYFu8Abz6eqJaP40ojkCBvu/Yp0H4M0P4xCBIhRewQRLY6YTXxFyJNtjBmPbEA14qbj9mAUuilKuceuIbwAHVJFbqXz6xNjwWvFRz1MF3BLc8yKvoBSpj2bKKIo2gCebgfHd/uxuc4sN+DYATTPNWZBxBJdxHPwCsq7u/VrMNGuhJRHdlmM0FD7oGEslwLdkbhCWBfSF35ByAjXs8djfk49MJ0lC6WyyJdk9FV7uPOBpiIdquN7cPnE6EfUyIVNkHxDiOxU2gAvTDfjnsS+ADzftQgzN+MDArZtHnzV+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEEncBo8FDxE6cSOnFZDjhuyflrkybdF7fESYntiojs=;
 b=Hz1k3JABZSOQHutBwTz8Yytq3AzAsweHAzkOUsp9CWdhk2Z69uW+G40Hvtod0df8zIw19lRM3eyJtKqC5bmY8t/ZSTV7utNG0/9IaHLTCHmolBRpqzrOe1QIt5e4WRA6zbmDLQ9df9fumVXs+/U3megPQB4jDiuWwJ8uI+l7I2cN2XBe+M74TkWNrtXWzvqYiQXGyX67XfUjrIIXhkUtB+UkxSKiB2BRjguwNjfER7q+ycLmvreVbdklxlgO95YMdL7qgSVPdVferyCbMeZqx4ALSFWEDim4c2TgCZDS1se43a58WDLBwh0pv1dBGfxTctGD2Hq7kyBjrsAkMVHySw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEEncBo8FDxE6cSOnFZDjhuyflrkybdF7fESYntiojs=;
 b=lLGu+QHmpBTLMb1M3Nm7kWh6wGRMPUZL2R1KTUxCaIpWFoiaPOi4nlvG80Xmd3fIOZtI5Ea0ujTP0nqIAX/vayNUkm8zL2nqVv81lxnbRQPioFvV8gwtlTshuwC2Y7vKyQ6zwZTVFPIgnJWOMPZwiGj7/HiJTJdWASWZSGpYszs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 14:03:01 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::55cb:215b:389e:eced]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::55cb:215b:389e:eced%5]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 14:03:01 +0000
Message-ID: <745145aa-76fb-bb17-6065-c5e29c37f3c6@amd.com>
Date:   Thu, 14 Sep 2023 16:02:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] drm/amdgpu: always use legacy tlb flush on
 cyan_skilfish
Content-Language: en-US
To:     Felix Kuehling <felix.kuehling@amd.com>, Lang Yu <Lang.Yu@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>, stable@vger.kernel.org
References: <20230914092350.3512016-1-Lang.Yu@amd.com>
 <40c096af-6c59-ce6d-af26-5cce7bceab83@amd.com>
 <1317e1a5-b1c0-2c3d-6082-b628fde5ab4d@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <1317e1a5-b1c0-2c3d-6082-b628fde5ab4d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: 662b7d38-93ca-449e-ca72-08dbb52b4ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QEBoYIwpbyZm7L3z9M8GtJBb43jFxyRhS3ILVvbWanhJEj1CzMidme5fzIArjq2wdYdu78M/ULDJnTKLCPJQwQO0PXoiS0t4zAAi728u1E0IpFmeW4eAFxh/FkmI64GRxCSt+819F0XCY2paMpNljStW9ol1GSdEnxlH6FzQybzorUDR0OuS1r8U8rvTMZ8Y7IhAZ98D8F8IWvNs1soSHPYnFE5OoouTEOjHpWgcJke1ttEVETZq/qjoY4YnhE4LHo3isAsxtNd6Bvr63ZTTSrl1R03GJtcZyhornAu17QtInkoIANxURT9P7dtbgK/O2zoIoNYEK1qf9aKUskUYrL3F1BWjZobR0zXrj87qoqMA4zU0IdyuDV10cs6n+AKHhQw2RdYyEOEXnK8gcrZ5L7oweIAo73NpuSArH8k0B87qT50jpjvAg3oUxoEAH3H2+SjcbMLk1VMILsxVoWy3t9pIIbIufKI0zUtfl8MrwiLa3932tI28zqfZIvsycN1eNQKRdl752iv2oALnvOWBpGypyTspUp8j252nBgo+B+gNNNGxIVMB1uAAY+oVOLZQQeFIStmvL2hXVtSo0Ru+369eiT0IJXNI4PvrmfS3GErVa7YHEtF4waV4VTB/YfkOtPxnVZczdAyxhiHhy4tiFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199024)(186009)(1800799009)(31686004)(66899024)(2906002)(5660300002)(36756003)(8936002)(86362001)(31696002)(38100700002)(4326008)(8676002)(6666004)(316002)(54906003)(41300700001)(83380400001)(66946007)(2616005)(26005)(66556008)(110136005)(53546011)(6512007)(6486002)(66574015)(66476007)(6506007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzN3MmNpL0RSbm01a29CVlFLcVkxdEUzNG5acFlkcHJTRERuelJWM2ZVVkl1?=
 =?utf-8?B?TkdhcDJENW5SVHBjM2d2M2xKWnI3T1dPSW0wMWNZNzkrVVh2cTQ3d0xYTWc5?=
 =?utf-8?B?bFFzMWR0cWhHQmVlajZJTVNPNzdvSEU0YUtuRWFMUi9LdWFjcVNHOVJJK29H?=
 =?utf-8?B?amUzWXJBelNSd3JZTWZ3SUJmalJlRFF1aUE5OHNJUFNMbWV0RnVUVDB6cStq?=
 =?utf-8?B?eFJCN0tJVy9XN1NqVFUrQ0FnN0JYcS93MjhOeWlNQ3QzbWY4QzBlVytQcm5M?=
 =?utf-8?B?Yk1KWDIxN0NzVFV4UVArb2l4Wi9QODVNN0ptSE8vZ3NVNTVTYlBORHNyMkVu?=
 =?utf-8?B?VVRWSElJaDcxQ09JRVBBQUlQTVdjTmFTVmFOR1VSYStyRm9MRXRWdEtRWDRD?=
 =?utf-8?B?RXdnMXRLanpPK3dqMmNaeExFSTVyRDZralRQTU4zYnlZRmg2NTNYR096c2JU?=
 =?utf-8?B?VlU0eGFPWVhTZ0t0NGRyTHVwWGEvYUo1bU5xZ2RpSjduTU8rMTJ3bVhJMVJs?=
 =?utf-8?B?ZnJEOGdseUhHSWVOTkhHd1lyYUYwWkwydG1Wc2xSK1A2NlRJVWN2K3lrYnlv?=
 =?utf-8?B?Szl1Q1pUREhJNFBDc1V4YmZYZnQrV3doVlNsOVFKZ2M0ckRsNGlHRUNKMGpn?=
 =?utf-8?B?NTRNYU5IRXVrbUp4c25TQXh2bkdHejIzYi85ZVVidHhjRDd6OTVnbmVuOVpF?=
 =?utf-8?B?OEdHL01mY2xaVlNGTFhjdFhhWTZ5ZVovNGRFblh5MlZFYndBY2p0aUtwbDFQ?=
 =?utf-8?B?b0ZER0J5WTd3Ky9XSlpEK1g2SllNZUJuS1hQTDg0NWdTQUduc0NUOERZWHdZ?=
 =?utf-8?B?ODBQMjM0N1NuOS9aRjl3cFNnMjBISzNlVHkvWmFnUHROaHZZVCswazhmWW1j?=
 =?utf-8?B?dFE4Y05FMGlwbHA4clBIaWIvNDBVUlpxMWdocFVCdE1XQzZjcjcxMlp1RVN4?=
 =?utf-8?B?VU9uZmk5WmFuSGZlU2kzQm1rTzlnUHhsTGNJVCtZYTBwR2ZveXRoRzAwdytr?=
 =?utf-8?B?dGltVTJQYzZMM2toR2JuaktJNGRzUXdySTVNVkVKTk56ZlpocWlmWEpyek1X?=
 =?utf-8?B?SHdwMk81NkVKalUrRGFrbUNUZzI0MmZtbmNUTCsrWUw0bnROK2NkK2Z6cCsr?=
 =?utf-8?B?eUQwZ2RQZ1VIWUh3dkxoN3g1RUFyVFowZ0psMWUrWkIwWEdzME5mUmVmNitS?=
 =?utf-8?B?YzZ2Zm5TRGpNa3pzdk11U05XdDJTNjlCcWNzWDhoM1dkMVR3YjlWM1luS0Fx?=
 =?utf-8?B?SkZ2bk1nOVpWMDI4V1p4aGJ1a2ZKVnRHRjRlMXhTQ2R2LzRVSUV3TGtFUkZ5?=
 =?utf-8?B?REdRcktNQVZubUFFejhmdDBhQnZPNWZVVjlPS1hKN2J5allzYzk3YVl3SUxi?=
 =?utf-8?B?cjB1MGZmTmsyMDhldkUyTnlPbFkzN2Rra2lvRE9sT0hRQmUvZ2VIcGUvempz?=
 =?utf-8?B?R01XOVhkNFVLYkZkYlBEcEpGWjRwZ2RRS1dFaVB5ckg2K3hDVndTQXZWVFZl?=
 =?utf-8?B?M0Eyb0hZZHh6VkNxUldJcVFVUnllRE9KS051bWJuenZKeTJuQTlDNEpSOHNp?=
 =?utf-8?B?SDRZQ1dCb2Q3MGVBZHFoZXM2bzBrL2FDenBXMDBKUjBzT0kzTWN5RWZJSXZv?=
 =?utf-8?B?cXJyR2ZTOUJRT0RBRGV0MkhIa3dHMnpiK2RHb2IrTWh5MmZ3cEpSd0ZRK1FM?=
 =?utf-8?B?R1p5RGJ1QUh6bUJPeW1FWVBWcG5wM2lBOXAzTjRFVmtxLzk0V29PZW9rTU5S?=
 =?utf-8?B?MUgrWmpPdjRkMTlNQWxwZCt5enBXNUQ5SmVYKzdmR1lzR1dQdCsvQU9NeFVL?=
 =?utf-8?B?SGZqdlVKM2lKbDVMK3R1VHIxWkFOTkFnNHd3YmtSeTFSQ0M5N0VFMTR3bXNJ?=
 =?utf-8?B?TlhBQ3ArMjNwekkvZUtQa2VvYlV0Y2FuTnJwT0ZtbWwvNHdZZy8yMGhGOGM5?=
 =?utf-8?B?bDVZNldud0xkV2padktmNGNzWUJFNVpMNlRNS3l1TmFZekdsMnQwVG0yRkJ1?=
 =?utf-8?B?WXRramxzcEVQM2Z0d1ZlajVOWTZUZUxhVFlEZUdHVmRxeWl1WERYSWNsZ0M5?=
 =?utf-8?B?VjZBUzE1LzNSRWp5VnI5Uzh0VlFZcXFrMkxlSFNmN05sQ0ljY1VhdGlNejRP?=
 =?utf-8?Q?Juf9G36zww7XYTLmr7CIkQVnp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662b7d38-93ca-449e-ca72-08dbb52b4ef8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:03:01.7308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rih3Gv153nkNix9y09KDVOCwt/0ArikXxZbCEQCJaUqm1oNpkNk7EybEbkXKPVFo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



Am 14.09.23 um 15:59 schrieb Felix Kuehling:
>
> On 2023-09-14 9:39, Christian König wrote:
>> Is a single legacy flush sufficient to emulate an heavyweight flush 
>> as well?
>>
>> On previous generations we needed to issue at least two legacy 
>> flushes for this.
> I assume you are referring to the Vega20 XGMI workaround. That is a 
> very different issue. Because PTEs would be cached in L2, we had to 
> always use a heavy-weight flush that would also flush the L2 cache as 
> well, and follow that with another legacy flush to deal with race 
> conditions where stale PTEs could be re-fetched from L2 before the L2 
> flush was complete.

No, we also have another (badly documented) workaround which issues a 
legacy flush before each heavy weight on some hw generations. See the my 
TLB flush cleanup patches.

>
> A heavy-weight flush guarantees that there are no more possible memory 
> accesses using the old PTEs. With physically addressed caches on GFXv9 
> that includes a cache flush because the address translation happened 
> before putting data into the cache. I think the address translation 
> and cache architecture works differently on GFXv10. So maybe the 
> cache-flush is not required here.
>
> But even then a legacy flush probably allows for in-flight memory 
> accesses with old physical addresses to complete after the TLB flush. 
> So there is a small risk of memory corruption that was assumed to not 
> be accessed by the GPU any more. Or when using IOMMU device isolation 
> it would result in IOMMU faults if the DMA mappings are invalidated 
> slightly too early.

Mhm, that's quite bad. Any idea how to avoid that?

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> And please don't push before getting an rb from Felix as well.
>>
>> Regards,
>> Christian.
>>
>>
>> Am 14.09.23 um 11:23 schrieb Lang Yu:
>>> cyan_skilfish has problems with other flush types.
>>>
>>> v2: fix incorrect ternary conditional operator usage.(Yifan)
>>>
>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>> Cc: <stable@vger.kernel.org> # v5.15+
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> index d3da13f4c80e..c6d11047169a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> @@ -236,7 +236,8 @@ static void gmc_v10_0_flush_vm_hub(struct 
>>> amdgpu_device *adev, uint32_t vmid,
>>>   {
>>>       bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(adev, 
>>> vmhub);
>>>       struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>>> -    u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, 
>>> flush_type);
>>> +    u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid,
>>> +              (adev->asic_type != CHIP_CYAN_SKILLFISH) ? flush_type 
>>> : 0);
>>>       u32 tmp;
>>>       /* Use register 17 for GART */
>>>       const unsigned int eng = 17;
>>> @@ -331,6 +332,8 @@ static void gmc_v10_0_flush_gpu_tlb(struct 
>>> amdgpu_device *adev, uint32_t vmid,
>>>         int r;
>>>   +    flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH) ? 
>>> flush_type : 0;
>>> +
>>>       /* flush hdp cache */
>>>       adev->hdp.funcs->flush_hdp(adev, NULL);
>>>   @@ -426,6 +429,8 @@ static int 
>>> gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>>>       struct amdgpu_ring *ring = &adev->gfx.kiq[0].ring;
>>>       struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>>>   +    flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH) ? 
>>> flush_type : 0;
>>> +
>>>       if (amdgpu_emu_mode == 0 && ring->sched.ready) {
>>>           spin_lock(&adev->gfx.kiq[0].ring_lock);
>>>           /* 2 dwords flush + 8 dwords fence */
>>

