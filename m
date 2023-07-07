Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CA874ACC6
	for <lists+stable@lfdr.de>; Fri,  7 Jul 2023 10:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjGGIWI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 7 Jul 2023 04:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjGGIWG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 7 Jul 2023 04:22:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B606D26A2
        for <stable@vger.kernel.org>; Fri,  7 Jul 2023 01:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYR7wyzcAxDMqtFmlpuDKpMbWaxQu3ejDHMop1AydNEljyROkbdQpN0zK/ZdqtZFN26AqGfDKGdeEFtP+mw+x+AptFOydWYMclm96gHgGgqduHEw9F31D4wJ7/K7dfE2FY4yCegwv5dO6ks78c6nZExm8czA+h2Wtr8kiRu09za1SzW7giEQBAP1db5G+UsATSZ+xVOpedEGL9wqmihZ6Oj1d0c3gkLwm0t9PfVDaDVCcOfsBji7hFnW4EwtRhS/B649sKdVHp5bruTl3WDN+YA5TSKQl2eRYCxWxGNUeI+fAKuxOMUgAE5ONuu5b3KPEHhaxl1Lw73mCWBVx1ROew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pptaZC49hQSfgoyBGblNytKXGX1Pz+FxklRSF8tCTPM=;
 b=MJ8EHYdYXhL+Ysz0HacwhmgW8mkO/N70jcoYW1R31yVgKJQJizUogFMR2bXkuMFBJkad+an2Cc3kOT+upKyClHb8q5NzLXR1TwzRJgS0S+8AQeL5JFzUa0T7gXBsEd4u/hxUYpGPUgiAjpF1uE8cMh+qn3woY5+YQ9l0CNV0ajxTA+dBEF+ly71ZvrBRaYAQD/0CgAKi3GtW7tiu5PuffbZvWepOICypUrp5asSscX+lY4aU8TI9pTun7tIvUeiY7CLOIQLhwktlDY7Vv8GZPbzmsPI23vCTTadw44ZlvRMDXF4z4ZStLVIn6zcjQKu9O2H0CmiyplfJGQzyJpwLPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pptaZC49hQSfgoyBGblNytKXGX1Pz+FxklRSF8tCTPM=;
 b=i0MViHsY3bq9lA5ScWL0vfiEPqeLwBH1mwrtwrSYNikYBOgoSS7a+cs71TzWAIXiLsq40zTkXGhILbGCvGuh7tEAzrE7+mAE3kivpqWFRRYWLyJtN1fEll5rGaEnUnWpoDTSeAuGQD/tzUTvBY8SFd14vimyoUqb2Y4Q/QiIv9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 08:21:36 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e8c1:b961:25c0:1fb0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e8c1:b961:25c0:1fb0%6]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 08:21:35 +0000
Message-ID: <46b18e49-13e4-f5a3-e500-c4aa5bb8820a@amd.com>
Date:   Fri, 7 Jul 2023 10:21:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Always emit GDS switch when GDS/GWS/OA is
 used
Content-Language: en-US
To:     Friedrich Vock <friedrich.vock@gmx.de>,
        amd-gfx@lists.freedesktop.org
Cc:     stable@vger.kernel.org
References: <20230707062908.9470-2-friedrich.vock@gmx.de>
 <a625bd04-1ae6-536d-d255-c3efa6351312@amd.com>
 <ef348f8d-27a6-06b2-210c-da1d8c8f3cca@gmx.de>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <ef348f8d-27a6-06b2-210c-da1d8c8f3cca@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 080c5495-4446-4cf8-5b28-08db7ec32dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gVteLCwCZgTnxboswfDUX2pzw20Pw3A9qjOYlZpTCx3kn9FrAF/P8ohtQNiKqDTbp6yxSyToQbUdYKQwKKkQdeCeVwhTwvXxO8gXI4SZoAZRDChpjg/Q0+iZLvhcd3vVqHko2A+q1LauA06CAInI5Zu1tnwLY3xyEDwRbvMKEmCZnIr/+4yVdMKGd3WSdsbEnFyFPZouHeJCLblHAhVJLH5RylXwJ3WEVhiVy3YeXYRBa3j0UH+nDvgkLgZXIi6JbsSB3G2/rYEk8TvavYPfArXGJJOB8ZDQH4dW9z4flKepwN/zXNaIsOEXtZjKG74cyDb6rsoovE1+sr44RoiS/vmd5Q5aMjtJ+yES8XZIzCgV9VU9jibuxAbv6tVGB2zFXtQkk7mSjH3V65mHFkrTUM/07z/1j/5Y1fGNpfsvFVMOQZYHoD4kavj86smGXJ/Xq7XwDCZ4eYHMnK7Af4ISfIMzb58ZuHYq9gWADkndCNmXV/5liOBAqW/eqgOARFpAaOoRZs0rf6J5JP0V84q97mohvnwybRR3fOmVv8zwbCqoYWhZUCAgssRhn3idcJDAfsMF3/6LfODN/xYWuDpZieR3m+KC9adGUxITGiotkMbayVxjYTLojEBIj/zGR2X0qdP29EuhuPVCwEWCcPrSkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199021)(31686004)(8936002)(8676002)(5660300002)(2906002)(41300700001)(66476007)(316002)(38100700002)(478600001)(66946007)(66556008)(4326008)(83380400001)(66574015)(6666004)(31696002)(6506007)(86362001)(66899021)(6486002)(2616005)(6512007)(966005)(186003)(53546011)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU5RWHhERDhTV3hoWm0zUm8vZk8xbkF4eHlxQTgzZHArTGNHK25RMjRQOGI0?=
 =?utf-8?B?ZFR1YnpsYStibmJLRzN3YXRuU1dwSWNLK1VPaEdVb2UwSUlrYlUyMVlWdThs?=
 =?utf-8?B?YlIrd1RKNit0S2RZR3pyS1ZOc20rcDNSbS9la0c5V2xFVVMya0grcnY5dGJX?=
 =?utf-8?B?UTZENVVIU28rTUFyc2pJNExXWVdvNWFkRDRzL29IUUx6T2VHSHMweEVuSDB5?=
 =?utf-8?B?SUFOdDUyc0JsUHdub3BLMGFvb1MxeHc2NVZKakpFNCtCUTVJYzBpWEJpVExU?=
 =?utf-8?B?M3p1Y0YvTHFiUk8vaWVRSDloZVVORWYzNGhEM3VGN0dwWGg0SFBSa1Y1NUFE?=
 =?utf-8?B?cjFjRFVDV1JiZy9MMGhPd3haYVBsT1IwQ3pqQWllVHh3MXJkbVhqZjdpSUNO?=
 =?utf-8?B?SWdLZ0FiN2tPUmtnaUY0SEJtZThtSlJaVUNSZkRabi8yZlpmNEs3SVNxSFc0?=
 =?utf-8?B?ek13bndKYzRObTZ3QWtQb01SOXVxOXJLSUIyNC9lMU5iQ0xsYitGODF6M1Zr?=
 =?utf-8?B?Zmd1ZHRscllXVTMzMW9NUTRsdExnamFkdjJqNG8rOTFVdnRReXlMcWMxNWNX?=
 =?utf-8?B?Y0RiRmNNRnkvMDhITlFCZ3dyVVplT1JKRkxuWEtyVTc5MEdJT0srd3ErRzgz?=
 =?utf-8?B?czhZWmRmOWFCaFNkSk9XOUp6bk0zNGVXeUI4bGNVM0N6MWhRQnJVU2R3OXdx?=
 =?utf-8?B?N040dVY3TGNycmZTWHRaUEVhSkNEc29Pb0lNVnBtOHFLZ2hxQlR1aEdOSndl?=
 =?utf-8?B?U3o5cGd6bHBacE00ODdmc05ETVhPNWxPZGZsREFBUjJLUWR3MlpTOHFZSTZR?=
 =?utf-8?B?SmR0NlRLTjJHU2tjZjFmSkVpam1ZRWJ4Sm1WY2tvZXRlTXNzWVd1ZTdvQ2VL?=
 =?utf-8?B?UU42QnlpcktIQmlleUpjZHc2R2tjOXlGYnR0ZkEzOEZwVHJPUVV0S1ZiS25F?=
 =?utf-8?B?eHRSeExaRTM4MlJIeDlRSXNQUVBmNWdSUjgrWmM3QUgvamczM05jd0drODgx?=
 =?utf-8?B?eXVScFhsS3pxc0tyQWZEWEhsQm9zNEtIMm53aVlzM0t1T1VqdTN6MCtuQ01a?=
 =?utf-8?B?SG5qVU9HLytQYUN5TXQrSlhLakpOc2F5MFhXN1V5OFJmRmZ1RFRCM2NvQ3lQ?=
 =?utf-8?B?UkIvQVZ2WFFSdk9rcmJ3eE9xRGU0eEpsVlo3dUR4a1c2WWRnMy9PRldEWHVE?=
 =?utf-8?B?ZmFUMjVvWkRHWDZaVTFVd01nVG15SCttaDRSZm8vVFExUnRwcE5IVkZ4bGpn?=
 =?utf-8?B?MVREbm51YjZUcjAwZzFJMkEwNThwSURZa2VSV3hWT3d0ZURnNjNraG9NYUdv?=
 =?utf-8?B?UVZkcG4vSGpmZ3lQL1I1RjFPWWtSWnhHNzZZamhVZjFDV3ZRTEI4S2FUekcw?=
 =?utf-8?B?LzZ1Nmx4TWRzaWh1Mm9Yb3NNZUZYYUdSOEVsNVhHRVlwekpsNmZ1aEtEN1RP?=
 =?utf-8?B?cWREK3ZXaTlmeVg5NFFVdkp2YXhHc1VqRS9jcjFPeURYM0dhZ3lqdXR5VnVu?=
 =?utf-8?B?YkIybG5CSUZIWW43c2xEUTBEZE1ETndLbVhRQ3NPYW5hbk5qbVNVcnMxZXlV?=
 =?utf-8?B?LzhSSWZMc0R4VDdEYWNVYVNZS0tVOHQrQldQdDJVUW53WHI0d1cxSDlLeVJs?=
 =?utf-8?B?NTM5dHUrcEdBSENncU54Z1FTcW4rNG5DZXlQNGdmNTk1aU9zV1gvRHdDSU9p?=
 =?utf-8?B?VmtEM0tUVXZTM1Q4cGlQemZiRnVFT0dML2NEaVpTK1BzNzN2Y0Y3RnpsOGJT?=
 =?utf-8?B?TDJEYTBEVnNwbitIcm9KMnM4QkhtVC85UTQvTWlwK01NeXZNWkpwV2RuQzcz?=
 =?utf-8?B?U0xSUDZPYXhWSGY2eVFEMWlRTmV0RVBTdTV4YS9mRmtyRzc2M2wxN0ZtMWt1?=
 =?utf-8?B?Wk0zSC9XQzN6aVlvRTFvb3FMU2FjbTdOUlo5RFU1Y2xHUkF5WGNRODZ4V3JP?=
 =?utf-8?B?citlN3UvbUlmZi9VRWZUaGhKbVljaXc4OERJN0xGWnBGczZhYmZKY3hMMnVS?=
 =?utf-8?B?eXZhMzRDSXl2VmhIVXBPSmRVWE5jWTNEME0yQ1lIVVk1VmtaYW4wSFV0c0Z3?=
 =?utf-8?B?RHo1UlZab01SaG9aWERWMC9YeW9icXE0QXpENHRJY212b3pmNzBpb1V1ajVv?=
 =?utf-8?B?aXBWejVxT3JjZlhPQjVZZVozZWZyMFFvRTZybGFyVEoxU1NveDV3TnBseXht?=
 =?utf-8?Q?fK3CjvrhlHG67shSoqdEbmSWQFESmG6ZDNVFPh89M1Tj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080c5495-4446-4cf8-5b28-08db7ec32dbb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 08:21:35.5704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/q04Zk6icvaBeyzjNZV0bkZSLD/dxN2FJG2CpZ7nZvbSzIkcOArWXkxD3hVwaOo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
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

Am 07.07.23 um 09:28 schrieb Friedrich Vock:
> Hi Christian,
>
> On 07.07.23 08:56, Christian König wrote:
>>
>>
>> Am 07.07.23 um 08:28 schrieb Friedrich Vock:
>>> During gfxoff, the per-VMID GDS registers are reset and not restored
>>> afterwards.
>>
>> Hui? Since when? Those registers should be part of the saved ones.
>>
>> Have you found that by observation?
>
> yes. I tested this on my RX 6700 XT and the Steam Deck (Vangogh). In the
> bug report I linked, a test program using GWS I developed hangs because
> of this.
>
> The hang occurs as soon as the kernel re-uses a VMID on which GWS was
> already used once. In the hung state, inspecting the per-VMID GWS
> registers shows that the values have been reset to 0.
> The hang does not occur when gfxoff is disabled.
>
> Even without causing hangs, you can confirm the behaviour by doing the
> following:
> 1. Disable gfxoff.
> 2. Set some GWS registers.
> 3. Enable gfxoff and wait a bit.
> 4. Disable gfxoff and read the registers again. The GWS registers have
> been reset.
>
> I performed this test for the GDS_BASE/SIZE registers and it seems these
> aren't affected, so it's only GWS that is buggy here.

That's most like a bug in the FW then. I'm going to ask around internally.

> I should probably make a v2 that combines the behaviour before this
> patch for GDS and OA, and the patched behaviour for GWS.

Yeah, that sounds like a good idea to me. But let me ping the fw teams 
first.

>
> I'm not aware of userspace using GWS (yet, I had some ideas for using it
> in RADV which is what I've been writing these tests for),
> so perhaps the Cc to stable can also be omitted.

Depends on what the fw teams says. As far as I know GWS has never been 
used widely on Linux.

Could be that they say there is a hw bug and we deprecated it for this 
generation, or it's simply not handled by the fw and the driver needs to 
take care of this (like this patch does) or whatever.

Thanks for the notice,
Christian.

>
> Thanks,
> Friedrich
>
>>
>> Thanks,
>> Christian.
>>
>>
>>>   The kernel needs to emit a GDS switch to manually update the
>>> GWS registers in this case. Since gfxoff can happen between any two
>>> submissions and the kernel has no way of knowing, emit the GDS switch
>>> before every submission.
>>>
>>> Fixes: 56b0989e29 ("drm/amdgpu: fix GDS/GWS/OA switch handling")
>>> Cc: stable@vger.kernel.org
>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2530
>>> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 22 +++++++---------------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 -
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 10 ++++++++--
>>>   3 files changed, 15 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> index ff1ea99292fb..de73797e9279 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> @@ -165,24 +165,17 @@ bool amdgpu_vmid_had_gpu_reset(struct
>>> amdgpu_device *adev,
>>>           atomic_read(&adev->gpu_reset_counter);
>>>   }
>>>
>>> -/* Check if we need to switch to another set of resources */
>>> -static bool amdgpu_vmid_gds_switch_needed(struct amdgpu_vmid *id,
>>> -                      struct amdgpu_job *job)
>>> -{
>>> -    return id->gds_base != job->gds_base ||
>>> -        id->gds_size != job->gds_size ||
>>> -        id->gws_base != job->gws_base ||
>>> -        id->gws_size != job->gws_size ||
>>> -        id->oa_base != job->oa_base ||
>>> -        id->oa_size != job->oa_size;
>>> -}
>>> -
>>>   /* Check if the id is compatible with the job */
>>>   static bool amdgpu_vmid_compatible(struct amdgpu_vmid *id,
>>>                      struct amdgpu_job *job)
>>>   {
>>>       return  id->pd_gpu_addr == job->vm_pd_addr &&
>>> -        !amdgpu_vmid_gds_switch_needed(id, job);
>>> +        id->gds_base == job->gds_base &&
>>> +        id->gds_size == job->gds_size &&
>>> +        id->gws_base == job->gws_base &&
>>> +        id->gws_size == job->gws_size &&
>>> +        id->oa_base == job->oa_base &&
>>> +        id->oa_size == job->oa_size;
>>>   }
>>>
>>>   /**
>>> @@ -434,7 +427,6 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct
>>> amdgpu_ring *ring,
>>>           list_move_tail(&id->list, &id_mgr->ids_lru);
>>>       }
>>>
>>> -    job->gds_switch_needed = amdgpu_vmid_gds_switch_needed(id, job);
>>>       if (job->vm_needs_flush) {
>>>           id->flushed_updates = amdgpu_vm_tlb_seq(vm);
>>>           dma_fence_put(id->last_flush);
>>> @@ -503,7 +495,7 @@ void amdgpu_vmid_free_reserved(struct
>>> amdgpu_device *adev,
>>>    * @vmhub: vmhub type
>>>    * @vmid: vmid number to use
>>>    *
>>> - * Reset saved GDW, GWS and OA to force switch on next flush.
>>> + * Reset saved GDS, GWS and OA data.
>>>    */
>>>   void amdgpu_vmid_reset(struct amdgpu_device *adev, unsigned vmhub,
>>>                  unsigned vmid)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> index a963a25ddd62..2898508b1ce4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> @@ -53,7 +53,6 @@ struct amdgpu_job {
>>>       uint32_t        preamble_status;
>>>       uint32_t                preemption_status;
>>>       bool                    vm_needs_flush;
>>> -    bool            gds_switch_needed;
>>>       bool            spm_update_needed;
>>>       uint64_t        vm_pd_addr;
>>>       unsigned        vmid;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 291977b93b1d..61856040cae2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -557,6 +557,12 @@ void amdgpu_vm_check_compute_bug(struct
>>> amdgpu_device *adev)
>>>       }
>>>   }
>>>
>>> +/* Check if the job needs a GDS switch */
>>> +static bool amdgpu_vm_need_gds_switch(struct amdgpu_job *job)
>>> +{
>>> +    return job->gds_size || job->gws_size || job->oa_size;
>>> +}
>>> +
>>>   /**
>>>    * amdgpu_vm_need_pipeline_sync - Check if pipe sync is needed for
>>> job.
>>>    *
>>> @@ -579,7 +585,7 @@ bool amdgpu_vm_need_pipeline_sync(struct
>>> amdgpu_ring *ring,
>>>       if (job->vm_needs_flush || ring->has_compute_vm_bug)
>>>           return true;
>>>
>>> -    if (ring->funcs->emit_gds_switch && job->gds_switch_needed)
>>> +    if (ring->funcs->emit_gds_switch && 
>>> amdgpu_vm_need_gds_switch(job))
>>>           return true;
>>>
>>>       if (amdgpu_vmid_had_gpu_reset(adev, &id_mgr->ids[job->vmid]))
>>> @@ -609,7 +615,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring,
>>> struct amdgpu_job *job,
>>>       struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
>>>       bool spm_update_needed = job->spm_update_needed;
>>>       bool gds_switch_needed = ring->funcs->emit_gds_switch &&
>>> -        job->gds_switch_needed;
>>> +        amdgpu_vm_need_gds_switch(job);
>>>       bool vm_flush_needed = job->vm_needs_flush;
>>>       struct dma_fence *fence = NULL;
>>>       bool pasid_mapping_needed = false;
>>> -- 
>>> 2.41.0
>>>
>>

