Return-Path: <stable+bounces-6768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AD9813ADF
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 20:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB0BCB2178D
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 19:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D55697BD;
	Thu, 14 Dec 2023 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eEdZgu8W"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B6B6A00F
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqlbRPMQc1HGKLK9uewUfysc6SYyL/JZZeNZZASBjH/b27Povm2Bfufyrppm9XQr9Y3I0ET5yNWu6dSLvOrdJ8Hov4uX0KBcG3kOatBy6JPTt0ILtXagRawMPu1pawuVYQUJPf8of2J4lx1jjdAHGXtAahs3zzo4/VV8lQ+RXghVgFQrAs4yk/4nD+WbhtqDIbT5tmDiS6MzK13NKnCgMNvGX6ydNcAKTLtOeHcQUqc0e9Gv2Da+2HsbfoNdCJTiFSlZrji7mg+sjXJaflkeX+oXDIlDVAhkoxZA9iucJumER2VK5JsJvX6o+Nue9LhcFTQSCoEEfZIcNQyaAnjByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4Z8ofa4/Zayy+CzJaTqR2isfCPoaVy8e5ZLBTUH4/4=;
 b=eE+zc468pD27FWR9LWydMQhajUVn3aeYtp/jby+WBPf9zjjswvqmCxpZ+gJxhR7xnqBi9gzgB1WRfFppXWd/iZyGWbiwWRRdJ0CFs5OdKrCM2FmCbCwhy9AoUm0T+68d4YU+tKWA45Kzh0BqJf8wERu2FgojToKLWsMsgK7vdoMr45hgPSkdCGzkDvziriwlguJIOfPtZx4SzxQzJfijTtNWFh3XGIBf1xxV2FkUVIJ0HT+BBaaQBWkA8+SN+J/JFdYUQaq4L2S+XKBFeLslWnc+793ra9PsIlPX9lkys/QfOXMFSXBVvnLKW0+YX9EvrTUuSvw++uKm49tVSXKEdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4Z8ofa4/Zayy+CzJaTqR2isfCPoaVy8e5ZLBTUH4/4=;
 b=eEdZgu8WgSozJ7vOGGsvsy6d8EcIiPYzaG5xp19va/LToRz6JM0k1iow8vLLXRgK4wEiP7xQ8cJpBQRyoL5HLY7Ztaaa2uKBAWXT3XLRxomrZUtLa3daIjIf3YQQiugjrBtqzsHGsKkZW5HTBz8J2EjDqFhtpMyEjakGx30wYWQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB8769.namprd12.prod.outlook.com (2603:10b6:806:34b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 19:38:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 19:38:10 +0000
Message-ID: <1db656ac-756f-40c7-92fd-1e9ca5956780@amd.com>
Date: Thu, 14 Dec 2023 13:38:08 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add a workaround for GFX11 systems that fail to
 flush TLB
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: Tim Huang <Tim.Huang@amd.com>, stable@vger.kernel.org,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231213170454.5962-1-mario.limonciello@amd.com>
 <CADnq5_O=Kp+TkSEHXxSPEtWEYknFL_e_D7m5nXN=y8CJrR950g@mail.gmail.com>
 <38da4566-d936-42d9-9879-eee993270da0@amd.com>
 <13694238-418a-4fcb-8921-f9ab31e08120@amd.com>
 <CADnq5_MkkWqLyC3VYbTXSX7JL2Q5aaeJ6sFT9ROXjqdVfsXgjw@mail.gmail.com>
 <aacee34d-a62a-4af6-8fb8-de981e1dfc9c@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <aacee34d-a62a-4af6-8fb8-de981e1dfc9c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0158.namprd04.prod.outlook.com
 (2603:10b6:806:125::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: c6854c78-ab45-4bd6-9478-08dbfcdc3426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PW24qErMVqdVfYND1lmqvyrMahCLh0687sj2n5/RE56LpBHuXHVmb842AxAnJKI95r4elb5oOJywUNP3STqLuk6QXiGCoPObZJsvNxFRgVMGfZhe+JR/UxbWVAfNT30XzrhMNP6mkZVEMeF4s3d0fm9fbnoBKk6uZcD/dZuq71pdsURRMG4rR7/LniX8tcJ7unarRrVBEfO60H8n/x0/9ace1NOBoBtL2OydF3x9FA2FibGHSsJ/66rrDMJ70rWzKmbydSMBwfK5T66fIgjqX+l0ohTk1arTSZfBPc6w1WSRIFQ2GZFj35nRHdgvzRLWkGrcs99lBXpDoUgXH5uw9+Q/vhwv21KP5yFfqYem7oCzD0dJpzTsVUbN1pLSSk960tzX2DUbIK5X1jTi2fkN1w5E1qc1s2bq+qY4y+4lvqAS8E89HNEyI3fat8XuqBjykM16geduSk/uNy4/acYyOwYNUK/7mXXVloGovfZRYCjV5jrTZV+BRA+b8a5pf8geEty6w+ThVvtsF06SjyowD1UeEwf0Jwod9yNEeL4Cortu3aOpO7OatLFDxIa7eZtTivEoSpzq9CbHMPKdFSmDzFUWXiBAos6th4BOaqY2Ev8RM/wd0Sgqpsznj4AxKr3GWfLtTC1X6nQn/KWnuvs1Xw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(346002)(396003)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(478600001)(31686004)(6512007)(66574015)(26005)(36756003)(966005)(6486002)(66476007)(54906003)(66556008)(66946007)(110136005)(38100700002)(2616005)(83380400001)(6506007)(53546011)(31696002)(316002)(4326008)(44832011)(86362001)(8936002)(8676002)(2906002)(41300700001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzFIOXJQeFZTbE95R3diNDZJaU4vaEpDZHpTdGRjNWFkYmtWcVhEbTNaM0lQ?=
 =?utf-8?B?MkFXTTZ0Y3hpd2g0NWhQTENWdS9ORytrVW5ZMUhQdGRMQVJYckxTLzBxS3pX?=
 =?utf-8?B?VFR5bnF6NEVMaTdzTnhmN0VCZkxNRS9zRGF2ckc2UzhGc2V0dlM0SjN6Qits?=
 =?utf-8?B?dHowTXVkUHc5VlcwUXJtVjRGVEd0aDNjR3RGZFF4YlBQZndWcWhyRHI5d0xy?=
 =?utf-8?B?T2lxLzJ2M1B0L1phRytweEVQRis1ODFxRUwyRmtTb2hycVBjaElCWjRaeEND?=
 =?utf-8?B?N0RkMnpDL1pWeWpiRzVHbU96elJ4TFZYMFMyKzdmZzBJa2VkTm92S1pXQjdY?=
 =?utf-8?B?bjRFaTJjZG5KU3VxSno4SFMxZUgwNndZZ2NhbmNnckk2eFVSZ1lvNFYvOXYx?=
 =?utf-8?B?UjgvTEJjNjUwTmNHT3JnMDB0NHVwVnRiOTRJYklyRWdpd1RJMnFTc2RIOUd2?=
 =?utf-8?B?ZU1HRGdNQVdtMk1wc1V5NVROS2o2c3oxd1FFcmxoM1B5bGpTUW5pWlN0K2NR?=
 =?utf-8?B?VEFtcGtKQjJEdFNUbHczMWIyOTUzMnFBclhIK0ZmNG9kR201RG50SU00ODBk?=
 =?utf-8?B?RkFIL1BiTENwN3EwUjcySXRLMjF1b0VCNXowWE9ldXhHYUVrc3h0d0hXK3lr?=
 =?utf-8?B?TW0xcW1mS3BMbjVGOFY4dE1RYnhuSW9ET0V4bWtFV3NEL1gxbDM5YVFJOGFi?=
 =?utf-8?B?Ny9RbHNpck1idXJPWDZmQkUwc1gvZ3dKRlc5NWpUR0U4Wk56dnhqd2xmQzJu?=
 =?utf-8?B?YXBhNWhTRWpUUzJnRlpUVWxCRFhVT0dDdi9NNXVTTkpvOVpKaS9nTlVsNURT?=
 =?utf-8?B?RStjdXQ2MlZ6bTlNTXZJVkdMWUt5WjdtenExNTBaYkJFNzdJL3dzZEM2RC9q?=
 =?utf-8?B?U2NwTjFwWnNtM0YzTFhybXNmL1VQNng4NUVrdDA3cEFyak9Zbm5VeXVud2p5?=
 =?utf-8?B?NU5DbWw1cjg5RnpyV0JmVjVmWWh2ZHowN21rNkpGVU45NDRGWVovYTUrZ1RG?=
 =?utf-8?B?T2xMeWtTQ2xicmlVbDBlV0dpZmUwQnRXdSs4R3N2NDA1aHZ5TURpVzdmVWJo?=
 =?utf-8?B?VlV3cU05WEpDeVpvYlE2VVFUZFRvOGdkQ1FIYUxlZTNjWFVaTDRwY1lORE5C?=
 =?utf-8?B?Y1dma2MweGpJR3U2Q0V2ZE9VMUV2ZXBmZVdxYUNqeFVNdDQ5ZmlyNzQ3OUdE?=
 =?utf-8?B?dnJVSmVpWEY1c1dldmFnR2pOc2hHQlRuaFRGMFBLVEdIVTlHNm5BeHd1ZS9F?=
 =?utf-8?B?N3VqWHcybkFLMWdEUU1Lb1Y1SDlvMjFHcGFEY1NjMk5Ra1IyOXF3V1dORE9U?=
 =?utf-8?B?L3hMRDd5aTR3M2VTM21FRU9tVTF1TDhuaTNnRWNIOVFHZFNGZ1E1c2RPWGpM?=
 =?utf-8?B?cDdCOEhscjVCa3BxM1hET2FxZVdOSVYxeUVtVTJhbmdXdFVzS0pZMUJPOFNv?=
 =?utf-8?B?Z0RhR0xucGtyY3hGQ2FxVTZTUlBEb2g2czYyMVNMejN3ZmJJWDlsS0ZGTmlp?=
 =?utf-8?B?R2oyWXZKNEl0RHh0bTRNSWlJM2NyV3hsaEJIQWZ2UFZFMGtjdHEyaW9EZlQv?=
 =?utf-8?B?U1FRSXp6NXpYcmZJUFBMcUF6OE94R1hsRjhiMUVHNWxDUjRiQ1ZGc2FBaHV5?=
 =?utf-8?B?SVZNMjNsV1pkaVYyYUJNRGZQUFlSNWI3dVJya0hKQ3ZwVnlFSno5dFY3S05C?=
 =?utf-8?B?ekNEbE1DMEF4eVVRMVZZalZNaDVZbGY5aXdIc09oSXhIaG5SZm1ZN2ZLSkdG?=
 =?utf-8?B?NDA2cFJEeFoxOVdVTlZINllmUnlpcDA0OXd3RFphRUhMS3NnZ1cvZGJFS1hC?=
 =?utf-8?B?WHdzNUlJTC9QU2UvbmdBM0YvSVM5M1FyMkFkTG95aGhIVlNLVUlKdTlQNVJI?=
 =?utf-8?B?Y3d0NURoTXExTllhdXpRR21wZ2lPK0c4V2lncSt2akh1MkJVMVdTYUxPdVN3?=
 =?utf-8?B?UExTbEJwblJsRjRaVUZjNWprc08wU0VYcUZFRHZLbXVlS2ozQjhzQnZRVFZu?=
 =?utf-8?B?K1JrVTBjODFpVDk3cm1iWldiaWZHVFBrSGxxMHpvZWJzK3pCQnl3bFlaY1pU?=
 =?utf-8?B?aUdRSVdmdndtakZ0Wnd4bkt0VzNqRFF4eFhSMGlmTGZDbmQ2dHZVU21qWnN1?=
 =?utf-8?Q?Ql0IO++U2xCES+QxSHsLuO67u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6854c78-ab45-4bd6-9478-08dbfcdc3426
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 19:38:10.2452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSAwwJ+QxwdOZyfITjPHvr73cqUidhNeASFsVMEacLZOxJcYbcQVQ3qWt4Hj55wCFd96Zyjn4eHoqvwilK+YVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8769

On 12/14/2023 03:21, Christian König wrote:
> Am 13.12.23 um 20:44 schrieb Alex Deucher:
>> On Wed, Dec 13, 2023 at 2:32 PM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>> On 12/13/2023 13:12, Mario Limonciello wrote:
>>>> On 12/13/2023 13:07, Alex Deucher wrote:
>>>>> On Wed, Dec 13, 2023 at 1:00 PM Mario Limonciello
>>>>> <mario.limonciello@amd.com> wrote:
>>>>>> Some systems with MP1 13.0.4 or 13.0.11 have a firmware bug that
>>>>>> causes the first MES packet after resume to fail. This packet is
>>>>>> used to flush the TLB when GART is enabled.
>>>>>>
>>>>>> This issue is fixed in newer firmware, but as OEMs may not roll this
>>>>>> out to the field, introduce a workaround that will retry the flush
>>>>>> when detecting running on an older firmware and decrease relevant
>>>>>> error messages to debug while workaround is in use.
>>>>>>
>>>>>> Cc: stable@vger.kernel.org # 6.1+
>>>>>> Cc: Tim Huang <Tim.Huang@amd.com>
>>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3045
>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 10 ++++++++--
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 ++
>>>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 17 ++++++++++++++++-
>>>>>>    drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  8 ++++++--
>>>>>>    4 files changed, 32 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>>>> index 9ddbf1494326..6ce3f6e6b6de 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>>>> @@ -836,8 +836,14 @@ int amdgpu_mes_reg_write_reg_wait(struct
>>>>>> amdgpu_device *adev,
>>>>>>           }
>>>>>>
>>>>>>           r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
>>>>>> -       if (r)
>>>>>> -               DRM_ERROR("failed to reg_write_reg_wait\n");
>>>>>> +       if (r) {
>>>>>> +               const char *msg = "failed to reg_write_reg_wait\n";
>>>>>> +
>>>>>> +               if (adev->mes.suspend_workaround)
>>>>>> +                       DRM_DEBUG(msg);
>>>>>> +               else
>>>>>> +                       DRM_ERROR(msg);
>>>>>> +       }
>>>>>>
>>>>>>    error:
>>>>>>           return r;
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>>>> index a27b424ffe00..90f2bba3b12b 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>>>> @@ -135,6 +135,8 @@ struct amdgpu_mes {
>>>>>>
>>>>>>           /* ip specific functions */
>>>>>>           const struct amdgpu_mes_funcs   *funcs;
>>>>>> +
>>>>>> +       bool                            suspend_workaround;
>>>>>>    };
>>>>>>
>>>>>>    struct amdgpu_mes_process {
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>>> index 23d7b548d13f..e810c7bb3156 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>>> @@ -889,7 +889,11 @@ static int gmc_v11_0_gart_enable(struct
>>>>>> amdgpu_device *adev)
>>>>>>                   false : true;
>>>>>>
>>>>>>           adev->mmhub.funcs->set_fault_enable_default(adev, value);
>>>>>> -       gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
>>>>>> +
>>>>>> +       do {
>>>>>> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 
>>>>>> 0);
>>>>>> +               adev->mes.suspend_workaround = false;
>>>>>> +       } while (adev->mes.suspend_workaround);
>>>>> Shouldn't this be something like:
>>>>>
>>>>>> +       do {
>>>>>> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 
>>>>>> 0);
>>>>>> +               adev->mes.suspend_workaround = false;
>>>>>> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 
>>>>>> 0);
>>>>>> +       } while (adev->mes.suspend_workaround);
>>>>> If we actually need the flush.  Maybe a better approach would be to
>>>>> check if we are in s0ix in
>>>> Ah you're right; I had shifted this around to keep less stateful
>>>> variables and push them up the stack from when I first made it and that
>>>> logic is wrong now.
>>>>
>>>> I don't think the one you suggested is right either; it's going to 
>>>> apply
>>>> twice on ASICs that only need it once.
>>>>
>>>> I guess pending on what Christian comments on below I'll respin to 
>>>> logic
>>>> that only calls twice on resume for these ASICs.
>>> One more comment.  Tim and I both did an experiment for this (skipping
>>> the flush) separately.  The problem isn't the flush itself, rather it's
>>> the first MES packet after exiting GFXOFF.
> 
> Well that's an ugly one. Can that happen every time GFXOFF kicks in?

No; it's specific to the exit from s0i3.

> 
>>>
>>> So it seems that it pushes off the issue to the next thing which is a
>>> ring buffer test:
>>>
>>> [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on comp_1.0.0
>>> (-110).
>>> [drm:process_one_work] *ERROR* ib ring test failed (-110).
>>>
>>> So maybe a better workaround is a "dummy" command that is only sent for
>>> the broken firmware that we don't care about the outcome and discard 
>>> errors.
>>>
>>> Then the workaround doesn't need to get as entangled with correct flow.
>> Yeah. Something like that seems cleaner.  Just a question of where to
>> put it since we skip GC and MES for s0ix.  Probably somewhere in
>> gmc_v11_0_resume() before gmc_v11_0_gart_enable().  Maybe add a new
>> mes callback.
> 
> Please try to keep it completely outside of the TLB invalidation and VM 
> flush handling.

OK, will continue to iterate the direction v2 went.

> 
> Regards,
> Christian.
> 
>>
>> Alex
>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c in gmc_v11_0_flush_gpu_tlb():
>>>>> index 23d7b548d13f..bd6d9953a80e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>> @@ -227,7 +227,8 @@ static void gmc_v11_0_flush_gpu_tlb(struct
>>>>> amdgpu_device *adev, uint32_t vmid,
>>>>>            * Directly use kiq to do the vm invalidation instead
>>>>>            */
>>>>>           if ((adev->gfx.kiq[0].ring.sched.ready ||
>>>>> adev->mes.ring.sched.ready) &&
>>>>> -           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
>>>>> +           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) ||
>>>>> +           !adev->in_s0ix) {
>>>>>                   amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack,
>>>>> inv_req,
>>>>>                                   1 << vmid, GET_INST(GC, 0));
>>>>>                   return;
>>>>>
>>>>> @Christian Koenig is this logic correct?
>>>>>
>>>>>           /* For SRIOV run time, driver shouldn't access the register
>>>>> through MMIO
>>>>>            * Directly use kiq to do the vm invalidation instead
>>>>>            */
>>>>>           if ((adev->gfx.kiq[0].ring.sched.ready ||
>>>>> adev->mes.ring.sched.ready) &&
>>>>>               (amdgpu_sriov_runtime(adev) || 
>>>>> !amdgpu_sriov_vf(adev))) {
>>>>>                   amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack,
>>>>> inv_req,
>>>>>                                   1 << vmid, GET_INST(GC, 0));
>>>>>                   return;
>>>>>           }
>>>>>
>>>>> We basically always use the MES with that logic.  If that is the case,
>>>>> we should just drop the rest of that function.  Shouldn't we only use
>>>>> KIQ or MES for SR-IOV?  gmc v10 has similar logic which also seems
>>>>> wrong.
>>>>>
>>>>> Alex
>>>>>
>>>>>
>>>>>>           DRM_INFO("PCIE GART of %uM enabled (table at 
>>>>>> 0x%016llX).\n",
>>>>>>                    (unsigned int)(adev->gmc.gart_size >> 20),
>>>>>> @@ -960,6 +964,17 @@ static int gmc_v11_0_resume(void *handle)
>>>>>>           int r;
>>>>>>           struct amdgpu_device *adev = (struct amdgpu_device 
>>>>>> *)handle;
>>>>>>
>>>>>> +       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
>>>>>> +       case IP_VERSION(13, 0, 4):
>>>>>> +       case IP_VERSION(13, 0, 11):
>>>>>> +               /* avoid problems with first TLB flush after 
>>>>>> resume */
>>>>>> +               if ((adev->pm.fw_version & 0x00FFFFFF) < 0x004c4900)
>>>>>> +                       adev->mes.suspend_workaround = adev->in_s0ix;
>>>>>> +               break;
>>>>>> +       default:
>>>>>> +               break;
>>>>>> +       }
>>>>>> +
>>>>>>           r = gmc_v11_0_hw_init(adev);
>>>>>>           if (r)
>>>>>>                   return r;
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>>>> index 4dfec56e1b7f..84ab8c611e5e 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>>>> @@ -137,8 +137,12 @@ static int
>>>>>> mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>>>>>>           r = amdgpu_fence_wait_polling(ring, 
>>>>>> ring->fence_drv.sync_seq,
>>>>>>                         timeout);
>>>>>>           if (r < 1) {
>>>>>> -               DRM_ERROR("MES failed to response msg=%d\n",
>>>>>> -                         x_pkt->header.opcode);
>>>>>> +               if (mes->suspend_workaround)
>>>>>> +                       DRM_DEBUG("MES failed to response msg=%d\n",
>>>>>> +                                 x_pkt->header.opcode);
>>>>>> +               else
>>>>>> +                       DRM_ERROR("MES failed to response msg=%d\n",
>>>>>> +                                 x_pkt->header.opcode);
>>>>>>
>>>>>>                   while (halt_if_hws_hang)
>>>>>>                           schedule();
>>>>>> -- 
>>>>>> 2.34.1
>>>>>>
> 


