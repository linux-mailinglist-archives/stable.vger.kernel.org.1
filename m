Return-Path: <stable+bounces-6658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0791D811EF1
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 20:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA9C1C21163
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 19:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3360A68265;
	Wed, 13 Dec 2023 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FY5V9YeZ"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531C19C
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 11:32:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJz73KsG4Kk5YxmAMssVZHIS1MP0WZcGcRkoVwgIvlEQMk2vEu8UnKFbzvuNgbkHAmc0Vw0+PE1gDJ/oz8NrqHWsUSw0t/4QpU494EVfsFCF+0Gqk0bKg2Ft0buFo1YW5YMHm6XIn5287aJFXGjz+C5vKWqT9T28a9Wf6BYzTzwvkO0aMDrwmzLE+UhojsM152c5r925rAplwFiWPZDTAiR9IntMQ/jrQLE6/JLd1CMnpl+PHROyegnFO9EiOPH2Lbd4uGFZvPf+jZT07lHY73ZTavn37++scBRybWsp6SNpPCfDqaCW2ANEq7mUgCY0fewwnSxNtcHL8JbZ2mtR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gdiuls2OP4iq5h+OYowMfxaD6mjJ1PnVqDC5I/Phi5Q=;
 b=kWEnzQvOcAk9gzHyOYPbHgQ/zBxS5AR1CznybbFP68zfFFIwkHWxVKn/5WTXnjG2iq7iRWNrywlyAUWfCuGEID80FDW3eg/wmtxx/XipjNz7kOpJKJ1ysc5fhIVQjPvneZUfIG3gulGezQ4jrMstVlqEHyH+VomHGt3c2QlnKR2SmEm3fEXsoQm043R/47cI2+G8oOudmyf2eSiuPw38ykcl8z2j8M3rrC6DEC6t38RlH3bYwH1pB2+FHL39NpNjLU5yMs4vnfkzyF1/4lAJLd/utWiGBZiE8waD7mFFTFtqV3C6SMcddVpI3tKVzwNol8N7DlCnrJoKct9XwnJ8Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gdiuls2OP4iq5h+OYowMfxaD6mjJ1PnVqDC5I/Phi5Q=;
 b=FY5V9YeZXoFdzkFozv2j7WlG3yDWR7IwSI6oUtCl4T2hMSlrahO9lAouDHxMNIUbfpghltk5Bm3SKJ8nTiG981tUqK8YTUU1fBxCgpJvIod4XQh8YwsiRrnEWQgmgAJIMUI7zpjsRP3wHbxhpIBjVP93Op9IMU661QGfMpWcl70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 19:32:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 19:32:02 +0000
Message-ID: <13694238-418a-4fcb-8921-f9ab31e08120@amd.com>
Date: Wed, 13 Dec 2023 13:32:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add a workaround for GFX11 systems that fail to
 flush TLB
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Tim Huang <Tim.Huang@amd.com>,
 stable@vger.kernel.org
References: <20231213170454.5962-1-mario.limonciello@amd.com>
 <CADnq5_O=Kp+TkSEHXxSPEtWEYknFL_e_D7m5nXN=y8CJrR950g@mail.gmail.com>
 <38da4566-d936-42d9-9879-eee993270da0@amd.com>
In-Reply-To: <38da4566-d936-42d9-9879-eee993270da0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0066.namprd16.prod.outlook.com
 (2603:10b6:805:ca::43) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 46828dbc-985d-4ba1-b55c-08dbfc122e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+adOT6Cy3i2wuJ3SPcbHWnOLaV7ucX6MuBLK3ZLOFIu4JcvM1o/xEj5E57Ps9cptuEoP70o4bXypsId9Fj7NaooOnb98niC7tNV1+wu/HiU7WZqhJAtQvOUvohc79u8GwPwNwo6GGo40V+hqI67tTa1JOHee8MvvE1yQgprtBRUpcEe9MjnkxrwN53mEn1zxc8R/Dhp7fsK69dMBQ4IJ7I97tM4ya88PWaB8cttFw4clv0VLuZ1bwUVunI7rE66UIfSVbo07wSkVpWXKllx2a9KMsPy+gXqlBBlWJoyzWXDaj8wSbYFQgqvDZ7P2UQhYxP1ixXItTkuSU39ixcFAf8bu2DwDG8I5YM9iRzeYNdDJTLdeJNiS9ggnvQGvLRXYkCGZ9qgYnMEVx+/0vOLjSnV/86yQon/E92QwRB7PSsr75L7Xebh2Q2Yj9+LW/vZXcEPPcDWrK/YrBeMetV3KYZK4O0YpkPqwIAhh+TQaMEr2d8RSzulppG96LaYisLQBtNMWtyaiaPWGoIyYaj7/KPgcSiqurox7H37Ha8rt3uK83EHVy4znENOTmfXSFnCrIOswzOLXUnB26KiEYqSHmnI0V39tjtkP9NNAki9bqtapLyHVPSqwAtbRyLp7hk/0L3r/ZF5z7RwSUhX87SgK0w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(31686004)(2616005)(26005)(6512007)(6506007)(31696002)(86362001)(36756003)(38100700002)(5660300002)(8676002)(8936002)(44832011)(4326008)(966005)(83380400001)(66476007)(6636002)(66556008)(110136005)(66946007)(41300700001)(2906002)(316002)(6486002)(478600001)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2NvNE0rc3JNbDVKWWVrVTlQQk1zUFg0L3hHdW0vbU5Xb2VLTVF1YzZ0bnZr?=
 =?utf-8?B?TzVmTUMrb0JKUXZqZ0NnV2FRaldvclo1M21DbFZ2M0Z1VGY4TXl4aTJvcmZS?=
 =?utf-8?B?NmxqSERUdGloTjNza3pzMXlSOFQ0NmpjUTBoM2N4QmF3MVYrTyt2SkZuYitl?=
 =?utf-8?B?bXIwdzF4bFdLcittREFsdFJ0RmZMSmJIUko4RmhzUUlvejA1bnZuMllmdHJY?=
 =?utf-8?B?R05CL0pIaGUvOSt5UHZBTXE1S1FkellNbmQ2VldOUkRKQmdIMUFtM3lpeVhh?=
 =?utf-8?B?WEtGV2tzMGptbTBhbDBMa2J1eE5xRWh2NUY4dXlDWGIybEkvaUhJc0lmeDdU?=
 =?utf-8?B?Z1NaNUJ2SGJQaTlMNi8xcGM2MXFKTHFJejZ5L0xBZm5hYnhhV0FhSXdCNmRZ?=
 =?utf-8?B?Y0J1NEVNR1I0U0xjMmxHR3Z4eHA3SFord3RrZVMwRHRiVGxhS3E3cndGSkRm?=
 =?utf-8?B?cWFTSHd5ZkRta2FsazBCcVVlZTdZRWhaazNjSzlSM3dLejg2K3lXNUlIaW1r?=
 =?utf-8?B?UmQydVNsS0NsdVp0aXM4NWFUdHdCUlNRVlcrU2RrNkZ5Q205VGF2YUZKbTBt?=
 =?utf-8?B?SGduS0FnWGg1Qk13TC9qcERPdjc5T0x1TnZCUEpwSzhXNFZUQ2pBV2txbmxI?=
 =?utf-8?B?Uk9zcDBsMk91eW9XOWtiVjU0bTlJRWNFWTJnaUJFN2ZuQUR6WHc0MXhPWEtw?=
 =?utf-8?B?UDlvZ1QycGJmQXJOTlFzcUVEZm1nS1hTaWR4d3p2S0sySUc2aDNKcEo2NWVZ?=
 =?utf-8?B?dDRwT0hpWUVvbGFpREtqMTlzOEtYS3NJRDZLTTZIVE0zTmxON1hKTFY5QWtl?=
 =?utf-8?B?YVVRUnI1ZjF5LzdFa0pzdE1LWXpLUXI4alVQb2pMR2tPWFpJMjlrZUloMGgz?=
 =?utf-8?B?RWxFK1FjNDhjWUE4SHAyaXYzQjY4V2MvMGdqN1FNZmVUNlIwSkdrcm4vbHRB?=
 =?utf-8?B?WVBhbTJyWXo0ejJhV052bXc4RG93bHg0VUZNR3JTTEdYc1dEVzRyS1RaME9Q?=
 =?utf-8?B?MU4xa0w2MzE1K3h2QURrWmxOakgwVHRDQ3N0aERGcXliejNyckFkZG1lYzBL?=
 =?utf-8?B?RlVrWXJpeHdZQ1RzY2ovR2FoQ0l2Ym1GUkx1UGtqREt2c0NGdmYxWEZGVlc0?=
 =?utf-8?B?VlQwOExjb21LOFd1TmcxVXBqRitLTW0xMGUrdHMxL1gyM2ZqT296K3hUSVdj?=
 =?utf-8?B?bDhOQlo2dC94OU5VUC8waWVLQ2lCRHUxUUI2N3VtZ3ZqaEg1U1IwR3lpMWJz?=
 =?utf-8?B?VVBLVmN3T1ZQUFVBN0JMVmtCOUVGd3B2MmRjeVVGME1lbU45YnBMZ2Q3R0Vj?=
 =?utf-8?B?WitFYXJzVmEwSU85WithK3ljTURKUDRjeDhvRDh6aXI4KytVZzk5aVZLVG95?=
 =?utf-8?B?NVRhbTVTYmlVNG4rMGR3cHVGZk5lblVKWWE4SFdxdEdZYkh3YTcwNU9CaENo?=
 =?utf-8?B?WnJFZTdoQTl1RlhWRXY4Ung2b0tMS1c5bUdFVkQyQ253YU9CaGdwbVo4dmNH?=
 =?utf-8?B?eUlvWDFkc2VhdWdTQUtWTmhkaTZIRDdsOTNuMzZySVQ1bGEvOElLeEU4bDJl?=
 =?utf-8?B?UHFLZ1BOYUNaS0tVOWJJQ3U5NnRMUVEvS3U0NWVNeXNoOWJpTWM2R0U5czlE?=
 =?utf-8?B?bzJsUjFyWEIwY3VmYTZGV0phMzVPRmdaRWtqZWVuRzUrcjJ4N3h5LzdaSStR?=
 =?utf-8?B?WVpiV1hiZk5DQ1ExSU45RFg2RUU2bjhHbmNKamlIOTVKV01CbFNuQms0S2Zz?=
 =?utf-8?B?ei95dFEwV0xDYmkwVThlQVg4aDkraiswT3R6QndaZEJMV0VRY2JuNUNORDVO?=
 =?utf-8?B?RzM0NUpCN3pEMjZIc3E1V0ROVWZMMzBKVTBtQzdueDFYS3ZZclpyUDdINVRH?=
 =?utf-8?B?bmdZcVpFWDJUcEY4d25lUitkMTFhdkJRdGFjNVRHMWlJbC9IbTBpN3ZienhF?=
 =?utf-8?B?T3kwa3R5UWxIa3A4QmpnbkN2RUh0YUFRcU9WNk1WRUFpK0ZkS0RBRlFFWDBO?=
 =?utf-8?B?SjhmT29mOCtRRXBhSm4vZVJWaXpTcEptQUFQNkFOMzNyNlU2ak9KTnNvaGlL?=
 =?utf-8?B?TEVHbFVobTlVeDNqcG43S3IyL3VCZnU3RTdVRWo3b1hwSlJoMUp2aGtPZW8x?=
 =?utf-8?Q?l6BrzeDv2BSnI2hkWPDfkNGKN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46828dbc-985d-4ba1-b55c-08dbfc122e50
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 19:32:02.1195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+qiKbmtaXrc0WZLjyvuEmqOmeLww/ygQXJQ0eJX+jLD1pNCCXbbbo2FmpMN+egZIRHQprST+wIecGBkr/+Tlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966

On 12/13/2023 13:12, Mario Limonciello wrote:
> On 12/13/2023 13:07, Alex Deucher wrote:
>> On Wed, Dec 13, 2023 at 1:00 PM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>>
>>> Some systems with MP1 13.0.4 or 13.0.11 have a firmware bug that
>>> causes the first MES packet after resume to fail. This packet is
>>> used to flush the TLB when GART is enabled.
>>>
>>> This issue is fixed in newer firmware, but as OEMs may not roll this
>>> out to the field, introduce a workaround that will retry the flush
>>> when detecting running on an older firmware and decrease relevant
>>> error messages to debug while workaround is in use.
>>>
>>> Cc: stable@vger.kernel.org # 6.1+
>>> Cc: Tim Huang <Tim.Huang@amd.com>
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3045
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 10 ++++++++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 ++
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 17 ++++++++++++++++-
>>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  8 ++++++--
>>>   4 files changed, 32 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> index 9ddbf1494326..6ce3f6e6b6de 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> @@ -836,8 +836,14 @@ int amdgpu_mes_reg_write_reg_wait(struct 
>>> amdgpu_device *adev,
>>>          }
>>>
>>>          r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
>>> -       if (r)
>>> -               DRM_ERROR("failed to reg_write_reg_wait\n");
>>> +       if (r) {
>>> +               const char *msg = "failed to reg_write_reg_wait\n";
>>> +
>>> +               if (adev->mes.suspend_workaround)
>>> +                       DRM_DEBUG(msg);
>>> +               else
>>> +                       DRM_ERROR(msg);
>>> +       }
>>>
>>>   error:
>>>          return r;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> index a27b424ffe00..90f2bba3b12b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> @@ -135,6 +135,8 @@ struct amdgpu_mes {
>>>
>>>          /* ip specific functions */
>>>          const struct amdgpu_mes_funcs   *funcs;
>>> +
>>> +       bool                            suspend_workaround;
>>>   };
>>>
>>>   struct amdgpu_mes_process {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> index 23d7b548d13f..e810c7bb3156 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> @@ -889,7 +889,11 @@ static int gmc_v11_0_gart_enable(struct 
>>> amdgpu_device *adev)
>>>                  false : true;
>>>
>>>          adev->mmhub.funcs->set_fault_enable_default(adev, value);
>>> -       gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
>>> +
>>> +       do {
>>> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
>>> +               adev->mes.suspend_workaround = false;
>>> +       } while (adev->mes.suspend_workaround);
>>
>> Shouldn't this be something like:
>>
>>> +       do {
>>> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
>>> +               adev->mes.suspend_workaround = false;
>>> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
>>> +       } while (adev->mes.suspend_workaround);
>>
>> If we actually need the flush.  Maybe a better approach would be to
>> check if we are in s0ix in
> 
> Ah you're right; I had shifted this around to keep less stateful 
> variables and push them up the stack from when I first made it and that 
> logic is wrong now.
> 
> I don't think the one you suggested is right either; it's going to apply 
> twice on ASICs that only need it once.
> 
> I guess pending on what Christian comments on below I'll respin to logic 
> that only calls twice on resume for these ASICs.

One more comment.  Tim and I both did an experiment for this (skipping 
the flush) separately.  The problem isn't the flush itself, rather it's 
the first MES packet after exiting GFXOFF.

So it seems that it pushes off the issue to the next thing which is a 
ring buffer test:

[drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on comp_1.0.0 
(-110).
[drm:process_one_work] *ERROR* ib ring test failed (-110).

So maybe a better workaround is a "dummy" command that is only sent for 
the broken firmware that we don't care about the outcome and discard errors.

Then the workaround doesn't need to get as entangled with correct flow.

> 
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c in gmc_v11_0_flush_gpu_tlb():
>> index 23d7b548d13f..bd6d9953a80e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> @@ -227,7 +227,8 @@ static void gmc_v11_0_flush_gpu_tlb(struct
>> amdgpu_device *adev, uint32_t vmid,
>>           * Directly use kiq to do the vm invalidation instead
>>           */
>>          if ((adev->gfx.kiq[0].ring.sched.ready || 
>> adev->mes.ring.sched.ready) &&
>> -           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
>> +           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) ||
>> +           !adev->in_s0ix) {
>>                  amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, 
>> inv_req,
>>                                  1 << vmid, GET_INST(GC, 0));
>>                  return;
>>
>> @Christian Koenig is this logic correct?
>>
>>          /* For SRIOV run time, driver shouldn't access the register
>> through MMIO
>>           * Directly use kiq to do the vm invalidation instead
>>           */
>>          if ((adev->gfx.kiq[0].ring.sched.ready || 
>> adev->mes.ring.sched.ready) &&
>>              (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
>>                  amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, 
>> inv_req,
>>                                  1 << vmid, GET_INST(GC, 0));
>>                  return;
>>          }
>>
>> We basically always use the MES with that logic.  If that is the case,
>> we should just drop the rest of that function.  Shouldn't we only use
>> KIQ or MES for SR-IOV?  gmc v10 has similar logic which also seems
>> wrong.
>>
>> Alex
>>
>>
>>>
>>>          DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
>>>                   (unsigned int)(adev->gmc.gart_size >> 20),
>>> @@ -960,6 +964,17 @@ static int gmc_v11_0_resume(void *handle)
>>>          int r;
>>>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>
>>> +       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
>>> +       case IP_VERSION(13, 0, 4):
>>> +       case IP_VERSION(13, 0, 11):
>>> +               /* avoid problems with first TLB flush after resume */
>>> +               if ((adev->pm.fw_version & 0x00FFFFFF) < 0x004c4900)
>>> +                       adev->mes.suspend_workaround = adev->in_s0ix;
>>> +               break;
>>> +       default:
>>> +               break;
>>> +       }
>>> +
>>>          r = gmc_v11_0_hw_init(adev);
>>>          if (r)
>>>                  return r;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>> index 4dfec56e1b7f..84ab8c611e5e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>> @@ -137,8 +137,12 @@ static int 
>>> mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>>>          r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
>>>                        timeout);
>>>          if (r < 1) {
>>> -               DRM_ERROR("MES failed to response msg=%d\n",
>>> -                         x_pkt->header.opcode);
>>> +               if (mes->suspend_workaround)
>>> +                       DRM_DEBUG("MES failed to response msg=%d\n",
>>> +                                 x_pkt->header.opcode);
>>> +               else
>>> +                       DRM_ERROR("MES failed to response msg=%d\n",
>>> +                                 x_pkt->header.opcode);
>>>
>>>                  while (halt_if_hws_hang)
>>>                          schedule();
>>> -- 
>>> 2.34.1
>>>
> 


