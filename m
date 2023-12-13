Return-Path: <stable+bounces-6656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24311811E5C
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 20:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71070B20ECC
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 19:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EFA339A1;
	Wed, 13 Dec 2023 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NKhneZxS"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8192ACF
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 11:12:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtChm0aWgR7+zbFBfMf92lu6DiMyq+PvEEn4ngbwkp9lPL2IC/v+J7yC8z4HIz+pkUeJ+xDIe1vjMVqSyYK1G7L7gBKYLqpERaAglC5pmmzBA+OrlQPEY4S3qIVuEV1Tk7br6ikiKhGo76U3axUHycTg1q2F9ECo2nH9dQDCCM3LYAUUE17C1m+QMwhTZKhbEhy/70T2JGTKwT1BfrXjdtECKlzTUDj/1Ab0TYHqSswbXCTsiaZ/HfWC3+NIa0Bw6x6or88GmccfXOjfXI6pxGNNrYRnJZwxrHY4J/vgDkHBwxp9fdIksSng496pa7F8dEMBVqNYnldhsM/d8HOebQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NaW8pLnMLp/Ed/dEi0Y99KeqfbEhSK/nL+d9EmuX70=;
 b=J2GztaWyHkdzF/UYA7I3YsJWKp+eyA9V2gmdZAiSs+Zjx+G2UqmnCCaGSKQY8+0t9J+zILw4cMKC6QmsCNipmBkeEuJVxTbaIxQpR6juScj8C6Z3tSIdV0dlJaairJMyqoXIv66raBMNgghl9lGk7hDLh/EBtlo35UOU1Qh+NhYMGnue1YIKCb2V1SQiCf5aEVCZIkt33zzFcAYESjxuqWDzxxwRrEpYBDj4AEZtBEE9MFC6eFeMcDOBsgNcfXaRDBQ0Z+g/yd4admbFGhdRFv/Qa8IPFVLaxewwr3kz8QFhlpDeHRBLSxHwME0Snm43Av11qkYJduv6kc/rjtScnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NaW8pLnMLp/Ed/dEi0Y99KeqfbEhSK/nL+d9EmuX70=;
 b=NKhneZxSPDBTE/mgQFda/kUQoKjwPwHlB+cGlzcymD1Uq3qa9laF5mjY8VPlu7OK47OXniQE/dtjGO7RbCjyauzhDi5q62v2TJaMarLaY3y0sn9vER4RIppzaZaE7AcXpb48i5EDVD4vzJ9DwU5Y6quSbzEm5DWzcAI89sMmub8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 19:12:52 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 19:12:52 +0000
Message-ID: <38da4566-d936-42d9-9879-eee993270da0@amd.com>
Date: Wed, 13 Dec 2023 13:12:49 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add a workaround for GFX11 systems that fail to
 flush TLB
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Tim Huang <Tim.Huang@amd.com>,
 stable@vger.kernel.org
References: <20231213170454.5962-1-mario.limonciello@amd.com>
 <CADnq5_O=Kp+TkSEHXxSPEtWEYknFL_e_D7m5nXN=y8CJrR950g@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_O=Kp+TkSEHXxSPEtWEYknFL_e_D7m5nXN=y8CJrR950g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0119.namprd04.prod.outlook.com
 (2603:10b6:806:122::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 521d3f05-2269-480c-8228-08dbfc0f80cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hGktG0MpqFYgp5OlZa26aTAXTnA5IPSeFVvgjf1M9SRTcjrblwwSHegTHCz/+m4XtfYb+UU82lIAMxu8k4fDcXyxZv1rSFW0NjvNoQ9Swa55W1wLguDSpvX7ba2sD8sAkhuvta/if9AU5JN12+k+pw/Y6bBVc+tAqhQHyUQBQ6fZb4JhZ4hm/IcuPHLVQA6fAe6gfLSIb1DADkHWhrmvYXYrno5p+FwueEdMGYXOEv2GsUomz/Sy7h8dQPRHFxAYZJ3ePpFUIliY1qWJiQk6kIr9rRkEXWGDLXiGG/KA9wgYCCrEnGlhrT7HZPCUHevTWgNpBoptdcYWae2Es/w1LHshDhHE64YcScTDzO1eJa5KFoGh9PbrS/xOjkFkwZX9ocu53JrXxxR1WlcC7mMcyfkyxycez+Hrk5/yhjj8g53eLBW2UO8MMgKVHtVFdtakSB/o573xgfzF8HORVQrBIZZeyDC2CtcqTRsHkmlPvaV1X9ycxezqrmKQCld2v8nf2P449oJa0wg3OB0P2KUUCjT4ut5wNwK4/Vlx/WO1oRpK4WJ+HT/sp43YsQFv9e8eTX7OhCOxGzPo8lQcVmHfKvv7WsmoAwVX8xaA8yI471Qvsh9RVjrXawCzE1h3VVu3xTD07Df2d7nq6gr9Jje3Pw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(36756003)(31686004)(26005)(2616005)(6486002)(6666004)(2906002)(6506007)(478600001)(966005)(110136005)(66946007)(8936002)(4326008)(8676002)(66556008)(53546011)(6636002)(316002)(6512007)(66476007)(38100700002)(5660300002)(44832011)(83380400001)(31696002)(41300700001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Szg3RkRleWVJZFg3WDVZSllnWUhkRjB0NjV4MWFsQjNZSkV1c2RwTXVmVFJT?=
 =?utf-8?B?RlpUZElMa3JwdTM2aXN2Yzl4TWVXUlVHUUJoTVN3TW1mM051bUcwaUZpQ0Ft?=
 =?utf-8?B?RDNlNlE2eksxajg3OE1hWHdnekIxdnYra0kwUGxsUVBlWWcydzBsemNCaG9R?=
 =?utf-8?B?UXhINitLeXVNSDA5Z0xXVUcxZndPeGRoVFZEeWlJa3E4TjhNU3V3ckF4cVBt?=
 =?utf-8?B?dWxNZExPRHdzMGw0WU1yVG9qVVdWVEd3T3ZpQ2NUMldpNnJySTh1MTFPQU4z?=
 =?utf-8?B?ZEdEWWxvaTI2cWVsZ3pocWJYODBzdEt1bENJNmVHelBpUDFEWGFZLzVJdFM3?=
 =?utf-8?B?VHpDWGI2NFd3WlJ1VGZZWjhzZitKQ3B5NlljVnhlL0JreTQ1N25NRUhnTmVh?=
 =?utf-8?B?c1l2M05RSUQyamIyTnMrNitKYzBJRHZQOUJ2bmF3OXVkT3BUdlpsUjZZL1px?=
 =?utf-8?B?dDNuUnlKZVZJVWhNeGYwRWJYUEY5d05sS3k1dmZVTlVQSDllNXFzUm1hT2V0?=
 =?utf-8?B?bDFRZTZiV3dOeEVxNlBYTTAvVDBuTTR2emJmclU4aVdrcTFJcEdsQ1BWUEZw?=
 =?utf-8?B?aUJHZnRLWXcva1Mvb0tsTGM3U1BQeTBUTFF6bHlUUzJzODVtVlBYaERCR3l2?=
 =?utf-8?B?Sjk0djN0SVY1TmF3WjI0dTRoU0xWb0daakNpakRpd2xrcTRlT3dZeEg4Z0tl?=
 =?utf-8?B?MnBaRDB1NnQrOGRvd1pBSWRRZDhjRTArNHBNNVhLalJveTNkeGdkUXBYaThq?=
 =?utf-8?B?UjJNRFFKUDViSW9XajUrS1RyTjFLZUh6N0xpMlEwRTY5cERnRURpbExxODJn?=
 =?utf-8?B?MGZGajdJM3RTT0lOb1k2dXhtL3RFMHpOaHh4UUNmVmJ3NDM3ZlNWdUplaTBp?=
 =?utf-8?B?M2wyL3ZSRkhlUTd1TWNZREZqdTI5RDdiT1JnazlKd1dsK3QyWC9pWEtSM1JR?=
 =?utf-8?B?bUJ3UVdScmpKUVVWNElCMjBXRHhDdk95WGw4THBabUpKaHgzZEVsVjkrY1g0?=
 =?utf-8?B?Vm5SZmNyeElMMVlZOHpuMkx4alV3eVR1WjluVFJOVmZlTVlXYm1hU2M2QnZR?=
 =?utf-8?B?MDdyUGVqZzRrRTB2NDN5MkhrbmV6ZWc2UU9rNGJWOXdzbEZyWGR2WUxpeGE1?=
 =?utf-8?B?Um9nSFFzZGxYVENBTmFSd3hwM2I5WFFVc3FGUDUraGFsczA5NjVMa3Z3d1ht?=
 =?utf-8?B?alYrNmlMdnI2SWpZQmZNekxzalFUYlpGdWhzNEs2RVE2MGxOMklDZVdjU2hX?=
 =?utf-8?B?QnNBNTVyMytzN1BneUNreEIvMzJoM1VXekd5YW9mNkRQczUvSGl1L2JHTkVq?=
 =?utf-8?B?djVmMGlYNEdRZDAzVSt6bDdGMmw2TVE0dEw0S1Y4S0swUUlJVHc1K2h0MEl5?=
 =?utf-8?B?NWRWQm80RzgwRFdnYyt0a1pqSEtzZnIyT0R1YXFKT2FmZXJRd3BVMEd4a2Fr?=
 =?utf-8?B?c1lZaWYvb3hkQ1dwc3hLUFFlbnlTejRaQ0RCc0cwazFDWDZoY2N4VFR2aG5F?=
 =?utf-8?B?MW1PdkNIL2dIb2IxbXNLZW1KUkp6Z0xzTU80Z0ZEM05OU3lWMzZGTDhvbWhO?=
 =?utf-8?B?aUw5cnIrTWVtcHBNa0o5eGFuVVFoTEt4ODN0Y3c3QlBlc3hKZUJLRmE4Z3Fi?=
 =?utf-8?B?NEpPTWMxMjhHZElpUWNGbGFhSHhtbFY1Tk5sczNEaC9TRVAyK2w3L0hoQm92?=
 =?utf-8?B?dnZ6VmEvcXp6Smt1UTBRTHhMVVFZbWk2ZEJpSWR5ZndrK21hUUNETUZ6a08z?=
 =?utf-8?B?KzYxT3BwdmRLVnptRVMzTmtSbG9QM0hXQm10SUxYQTNEREJTNmlDbTFWaUY1?=
 =?utf-8?B?dUhEQUZ5SGsrZHRnQ0NrdDBlU1B5V3JTbHdWR1oxYytrWnZZTW5RaGRHTm1V?=
 =?utf-8?B?WmhpL3BSVzZWZDBrWG5raHhNTDlIY2hha2xlVzZPc2J5dmxreWJkdUxlQzU2?=
 =?utf-8?B?Z3RTdHBlSDBIOVhwM2Z0SDNxdXBLdWdCeElaaytCZnRkRC9TVmloMklwOFZ3?=
 =?utf-8?B?cVYzcTRJUVRhOGYwVnRnRmh0WnlyNGsxQlhWa3c4ZmJKOThESHR6eWlnVCtv?=
 =?utf-8?B?Z3RkUE1Gam9tS2xnVFl5b2FQRHRvZDkrcGRveFRVQUMvT1hzdDRxZmcxQjh6?=
 =?utf-8?Q?kbWbKEtdvuaFIS/ILMQUcDM2I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521d3f05-2269-480c-8228-08dbfc0f80cb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 19:12:52.0202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /taedeRFadQMcg3D772nsaFyOdt0LmS+4p0WuOWEpWu4urp+ZfavAPWmdH7aMk2BNdnB2sGOC+6ugzUfEmyVbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263

On 12/13/2023 13:07, Alex Deucher wrote:
> On Wed, Dec 13, 2023 at 1:00 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Some systems with MP1 13.0.4 or 13.0.11 have a firmware bug that
>> causes the first MES packet after resume to fail. This packet is
>> used to flush the TLB when GART is enabled.
>>
>> This issue is fixed in newer firmware, but as OEMs may not roll this
>> out to the field, introduce a workaround that will retry the flush
>> when detecting running on an older firmware and decrease relevant
>> error messages to debug while workaround is in use.
>>
>> Cc: stable@vger.kernel.org # 6.1+
>> Cc: Tim Huang <Tim.Huang@amd.com>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3045
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 10 ++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 17 ++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  8 ++++++--
>>   4 files changed, 32 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index 9ddbf1494326..6ce3f6e6b6de 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -836,8 +836,14 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
>>          }
>>
>>          r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
>> -       if (r)
>> -               DRM_ERROR("failed to reg_write_reg_wait\n");
>> +       if (r) {
>> +               const char *msg = "failed to reg_write_reg_wait\n";
>> +
>> +               if (adev->mes.suspend_workaround)
>> +                       DRM_DEBUG(msg);
>> +               else
>> +                       DRM_ERROR(msg);
>> +       }
>>
>>   error:
>>          return r;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> index a27b424ffe00..90f2bba3b12b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> @@ -135,6 +135,8 @@ struct amdgpu_mes {
>>
>>          /* ip specific functions */
>>          const struct amdgpu_mes_funcs   *funcs;
>> +
>> +       bool                            suspend_workaround;
>>   };
>>
>>   struct amdgpu_mes_process {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> index 23d7b548d13f..e810c7bb3156 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> @@ -889,7 +889,11 @@ static int gmc_v11_0_gart_enable(struct amdgpu_device *adev)
>>                  false : true;
>>
>>          adev->mmhub.funcs->set_fault_enable_default(adev, value);
>> -       gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
>> +
>> +       do {
>> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
>> +               adev->mes.suspend_workaround = false;
>> +       } while (adev->mes.suspend_workaround);
> 
> Shouldn't this be something like:
> 
>> +       do {
>> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
>> +               adev->mes.suspend_workaround = false;
>> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
>> +       } while (adev->mes.suspend_workaround);
> 
> If we actually need the flush.  Maybe a better approach would be to
> check if we are in s0ix in

Ah you're right; I had shifted this around to keep less stateful 
variables and push them up the stack from when I first made it and that 
logic is wrong now.

I don't think the one you suggested is right either; it's going to apply 
twice on ASICs that only need it once.

I guess pending on what Christian comments on below I'll respin to logic 
that only calls twice on resume for these ASICs.

> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c in gmc_v11_0_flush_gpu_tlb():
> index 23d7b548d13f..bd6d9953a80e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -227,7 +227,8 @@ static void gmc_v11_0_flush_gpu_tlb(struct
> amdgpu_device *adev, uint32_t vmid,
>           * Directly use kiq to do the vm invalidation instead
>           */
>          if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring.sched.ready) &&
> -           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
> +           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) ||
> +           !adev->in_s0ix) {
>                  amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
>                                  1 << vmid, GET_INST(GC, 0));
>                  return;
> 
> @Christian Koenig is this logic correct?
> 
>          /* For SRIOV run time, driver shouldn't access the register
> through MMIO
>           * Directly use kiq to do the vm invalidation instead
>           */
>          if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring.sched.ready) &&
>              (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
>                  amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
>                                  1 << vmid, GET_INST(GC, 0));
>                  return;
>          }
> 
> We basically always use the MES with that logic.  If that is the case,
> we should just drop the rest of that function.  Shouldn't we only use
> KIQ or MES for SR-IOV?  gmc v10 has similar logic which also seems
> wrong.
> 
> Alex
> 
> 
>>
>>          DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
>>                   (unsigned int)(adev->gmc.gart_size >> 20),
>> @@ -960,6 +964,17 @@ static int gmc_v11_0_resume(void *handle)
>>          int r;
>>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>
>> +       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
>> +       case IP_VERSION(13, 0, 4):
>> +       case IP_VERSION(13, 0, 11):
>> +               /* avoid problems with first TLB flush after resume */
>> +               if ((adev->pm.fw_version & 0x00FFFFFF) < 0x004c4900)
>> +                       adev->mes.suspend_workaround = adev->in_s0ix;
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +
>>          r = gmc_v11_0_hw_init(adev);
>>          if (r)
>>                  return r;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> index 4dfec56e1b7f..84ab8c611e5e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> @@ -137,8 +137,12 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>>          r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
>>                        timeout);
>>          if (r < 1) {
>> -               DRM_ERROR("MES failed to response msg=%d\n",
>> -                         x_pkt->header.opcode);
>> +               if (mes->suspend_workaround)
>> +                       DRM_DEBUG("MES failed to response msg=%d\n",
>> +                                 x_pkt->header.opcode);
>> +               else
>> +                       DRM_ERROR("MES failed to response msg=%d\n",
>> +                                 x_pkt->header.opcode);
>>
>>                  while (halt_if_hws_hang)
>>                          schedule();
>> --
>> 2.34.1
>>


